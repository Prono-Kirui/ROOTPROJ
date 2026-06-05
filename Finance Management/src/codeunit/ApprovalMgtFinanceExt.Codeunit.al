codeunit 51009 "Approval Mgt Finance Ext"

{
    var
        WorkflowEventHandling: Codeunit "Wkfl Event Handling Finance";
        WorkFlowManagement: Codeunit "Workflow Management";
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';

    //Payments
    procedure CheckPaymentsApprovalsWorkflowEnabled(var Payments: Record Payments): Boolean
    begin
        if not IsPaymentsApprovalsWorkflowEnabled(Payments) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsPaymentsApprovalsWorkflowEnabled(var Payments: Record Payments): Boolean
    begin
        exit(WorkFlowManagement.CanExecuteWorkflow(Payments, WorkflowEventHandling.RunWorkflowOnSendPaymentsForApprovalCode()));
    end;

    //Budget
    procedure CheckBudgetWorkflowEnabled(var Budget: Record "Budget Approval Header"): Boolean
    begin
        if not IsBudgetWorkflowEnabled(Budget) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsBudgetWorkflowEnabled(var Budget: Record "Budget Approval Header"): Boolean
    begin
        exit(WorkFlowManagement.CanExecuteWorkflow(Budget, WorkflowEventHandling.RunWorkflowOnSendBudgetRequestForApprovalCode()));
    end;

    //Proposed Budget
    procedure CheckProposedBudgetWorkflowEnabled(var ProposedBudget: Record "G/L Budget Name"): Boolean
    begin
        if not IsProposedBudgetWorkflowEnabled(ProposedBudget) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsProposedBudgetWorkflowEnabled(var ProposedBudget: Record "G/L Budget Name"): Boolean
    begin
        exit(WorkFlowManagement.CanExecuteWorkflow(ProposedBudget, WorkflowEventHandling.RunWorkflowOnSendProposedBudgetForApprovalCode()));
    end;

    //Bank Reconciliation
    procedure CheckBankRecWorkflowEnabled(var BankAccRec: Record "Bank Acc. Reconciliation"): Boolean
    begin
        if not IsBankRecWorkflowEnabled(BankAccRec) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsBankRecWorkflowEnabled(var BankAccRec: Record "Bank Acc. Reconciliation"): Boolean
    begin
        exit(WorkFlowManagement.CanExecuteWorkflow(BankAccRec, WorkflowEventHandling.RunWorkflowOnSendBankRecForApprovalCode()));
    end;

    //User Changes
    procedure CheckUserChangesWorkflowEnabled(var UserChanges: Record "User Changes"): Boolean
    begin
        if not IsUserChangesWorkflowEnabled(UserChanges) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsUserChangesWorkflowEnabled(var UserChanges: Record "User Changes"): Boolean
    begin
        exit(WorkFlowManagement.CanExecuteWorkflow(UserChanges, WorkflowEventHandling.RunWorkflowOnSendUserChangesForApprovalCode()));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        BankAccReconciliation: Record "Bank Acc. Reconciliation";
        Budget: Record "Budget Approval Header";
        CashManagementSetups: Record "Cash Management Setups";
        ProposedBudget: Record "G/L Budget Name";
        Payments: Record Payments;
        UserChanges: Record "User Changes";
        NoSeries: Codeunit NoSeriesManagement;
        ApprovalAmount: Decimal;
        ApprovalAmountLCY: Decimal;
    begin
        case RecRef.Number of
            //Payments
            Database::Payments:
                begin
                    RecRef.SetTable(Payments);
                    Payments.CalcFields("Total Amount");
                    ApprovalAmount := Payments."Total Amount";
                    ApprovalAmountLCY := Payments."Total Amount";

                    ApprovalEntryArgument."Currency Code" := CopyStr(Payments.Currency, 1, MaxStrLen(ApprovalEntryArgument."Currency Code"));

                    case Payments."Payment Type" of
                        Payments."Payment Type"::"Payment Voucher":
                            ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Payment Voucher";
                        Payments."Payment Type"::Imprest:
                            ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::Imprest;
                        Payments."Payment Type"::"Imprest Surrender":
                            ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Imprest Surrender";
                        Payments."Payment Type"::"Petty Cash":
                            ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Petty Cash";
                        Payments."Payment Type"::"Petty Cash Surrender":
                            ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Petty Cash Surrender";
                        Payments."Payment Type"::"Bank Transfer":
                            begin
                                ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Bank Transfer";
                                ApprovalAmount := Payments."Source Bank Amount";
                                ApprovalAmountLCY := Payments."Source Amount LCY";
                                ApprovalEntryArgument."Currency Code" := Payments."Source Currency";
                            end;
                        Payments."Payment Type"::"Staff Claim":
                            ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Staff Claim";
                        else
                            ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Payment Voucher";
                    end;

                    ApprovalEntryArgument."Document No." := Payments."No.";
                    ApprovalEntryArgument.Amount := ApprovalAmount;
                    ApprovalEntryArgument."Amount (LCY)" := ApprovalAmountLCY;
                    ApprovalEntryArgument.Description := Payments."Payment Narration";
                end;
            //Budget
            Database::"Budget Approval Header":
                begin
                    RecRef.SetTable(Budget);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::Budget;
                    ApprovalEntryArgument."Document No." := CopyStr(Budget."Document No.", 1, MaxStrLen(ApprovalEntryArgument."Document No."));
                    ApprovalEntryArgument.Description := 'Budget Entries for ' + Budget."Budget Name" + ' from ' + Budget."User ID";
                end;

            //Budget App
            Database::"G/L Budget Name":
                begin
                    CashManagementSetups.Get();
                    CashManagementSetups.TestField("Proposed Budget Approval Nos");
                    RecRef.SetTable(ProposedBudget);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Proposed Budget";
                    ProposedBudget."Document No." := NoSeries.GetNextNo(CashManagementSetups."Proposed Budget Approval Nos", 0D, true);
                    ProposedBudget.Modify(true);
                    ApprovalEntryArgument."Document No." := ProposedBudget."Document No.";
                    ApprovalEntryArgument.Description := ProposedBudget.Name + ' Final Budget Approval';
                end;

            //Bank Rec
            Database::"Bank Acc. Reconciliation":
                begin
                    CashManagementSetups.Get();
                    CashManagementSetups.TestField("Bank Reconciliation Nos");
                    RecRef.SetTable(BankAccReconciliation);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Bank Reconciliation";
                    BankAccReconciliation."Document No." := NoSeries.GetNextNo(CashManagementSetups."Bank Reconciliation Nos", 0D, true);
                    BankAccReconciliation.Modify(true);
                    ApprovalEntryArgument."Document No." := BankAccReconciliation."Document No.";
                    ApprovalEntryArgument.Description := BankAccReconciliation."Bank Account No." + 'Reconciliation as at ' + Format(BankAccReconciliation."Statement Date");
                end;
            //User Changes
            Database::"User Changes":
                begin
                    RecRef.SetTable(UserChanges);
                    case UserChanges."Change Type" of
                        UserChanges."Change Type"::"Password Reset":
                            ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Password Reset";
                        UserChanges."Change Type"::"Role Change":
                            ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Role Change";
                    end;
                    ApprovalEntryArgument."Document No." := UserChanges."Document No.";
                    ApprovalEntryArgument.Description := Format(UserChanges."Change Type") + ' for ' + UserChanges."User Name";
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        BankAccReconciliation: Record "Bank Acc. Reconciliation";
        Budget: Record "Budget Approval Header";
        ProposedBudget: Record "G/L Budget Name";
        Payments: Record Payments;
        UserChanges: Record "User Changes";
    begin
        case RecRef.Number of

            //Payments
            Database::Payments:
                begin
                    RecRef.SetTable(Payments);
                    Payments.Validate(Status, Payments.Status::"Pending Approval");
                    Payments.Modify(true);
                    Variant := Payments;
                    IsHandled := true;
                end;
            //Budget
            Database::"Budget Approval Header":
                begin
                    RecRef.SetTable(Budget);
                    Budget.Validate(Status, Budget.Status::"Pending Approval");
                    Budget.Modify(true);
                    Variant := Budget;
                    IsHandled := true;
                end;
            //Proposed Budget
            Database::"G/L Budget Name":
                begin
                    RecRef.SetTable(ProposedBudget);
                    ProposedBudget.Validate("Budget Status", ProposedBudget."Budget Status"::"Pending Approval");
                    ProposedBudget.Modify(true);
                    Variant := ProposedBudget;
                    IsHandled := true;
                end;
            //Bank Rec
            Database::"Bank Acc. Reconciliation":
                begin
                    RecRef.SetTable(BankAccReconciliation);
                    BankAccReconciliation.Validate("Approval Status", BankAccReconciliation."Approval Status"::"Pending Approval");
                    BankAccReconciliation.Modify(true);
                    Variant := BankAccReconciliation;
                    IsHandled := true;
                end;
            //User Changes
            Database::"User Changes":
                begin
                    RecRef.SetTable(UserChanges);
                    UserChanges.Validate(Status, UserChanges.Status::"Pending Approval");
                    UserChanges.Modify(true);
                    Variant := UserChanges;
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    local procedure PerformActionsOnRejectApprovalRequestFinance(var ApprovalEntry: Record "Approval Entry")
    var
        BudgetApproval: Record "Budget Approval Header";
    begin
        //Budget
        if BudgetApproval.Get(ApprovalEntry."Document No.") then begin
            BudgetApproval.Validate(Status, BudgetApproval.Status::Rejected);
            BudgetApproval.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeApprovalEntryInsert', '', false, false)]
    local procedure InsertCustomApprovalEntryFieldsFinance(var ApprovalEntry: Record "Approval Entry"; ApprovalEntryArgument: Record "Approval Entry")
    var
        Budget: Record "Budget Approval Header";
        ProposedBudget: Record "G/L Budget Name";
        RecRef: RecordRef;
    begin
        //Insert Descriptions
        case ApprovalEntry."Table ID" of
            Database::"Budget Approval Header":
                begin
                    RecRef.Get(ApprovalEntryArgument."Record ID to Approve");
                    RecRef.SetTable(Budget);
                    ApprovalEntryArgument.Description := 'Budget Entries for ' + Budget."Budget Name" + ' from ' + Budget."User ID";
                end;
            Database::"G/L Budget Name":
                begin
                    RecRef.Get(ApprovalEntryArgument."Record ID to Approve");
                    RecRef.SetTable(ProposedBudget);
                    ApprovalEntryArgument.Description := ProposedBudget.Name + ' Final Budget Approval';
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeApprovalEntryInsert', '', false, false)]
    local procedure MakeApprovalEntryBatch(var ApprovalEntry: Record "Approval Entry"; ApprovalEntryArgument: Record "Approval Entry")
    var
        GenJournalBatch: Record "Gen. Journal Batch";
        RecRef: RecordRef;
    begin
        if ApprovalEntry."Table ID" = 232 then begin
            RecRef.Get(ApprovalEntryArgument."Record ID to Approve");
            RecRef.SetTable(GenJournalBatch);
            ApprovalEntry."Document No." := GenJournalBatch.Name;
            ApprovalEntry."Payroll period start Date" := GenJournalBatch."Payroll start date";
        end;
    end;

    //-------------------------------------------------------Payments------------------------------------------------------------------------
    [IntegrationEvent(false, false)]
    procedure OnSendPaymentsForApproval(var Payments: Record Payments)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelPaymentsApprovalRequest(var Payments: Record Payments)
    begin
    end;
    //-------------------------------------------------------Payments------------------------------------------------------------------------

    //-------------------------------------------------------Budget------------------------------------------------------------------------
    [IntegrationEvent(false, false)]
    procedure OnSendBudgetApproval(var Budget: Record "Budget Approval Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelBudgetApproval(var Budget: Record "Budget Approval Header")
    begin
    end;
    //-------------------------------------------------------Budget------------------------------------------------------------------------

    //-------------------------------------------------------ProposedBudget------------------------------------------------------------------------
    [IntegrationEvent(false, false)]
    procedure OnSendProposedBudgetApproval(var ProposedBudget: Record "G/L Budget Name")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelProposedBudgetApproval(var ProposedBudget: Record "G/L Budget Name")
    begin
    end;
    //-------------------------------------------------------ProposedBudget------------------------------------------------------------------------

    //-------------------------------------------------------BankReconciliation------------------------------------------------------------------------
    [IntegrationEvent(false, false)]
    procedure OnSendBankRecApproval(var BankAccRec: Record "Bank Acc. Reconciliation")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelBankRecApproval(var BankAccRec: Record "Bank Acc. Reconciliation")
    begin
    end;
    //-------------------------------------------------------BankReconciliation------------------------------------------------------------------------

    //-------------------------------------------------------UserChanges------------------------------------------------------------------------
    [IntegrationEvent(false, false)]
    procedure OnSendUserChangesForApproval(var UserChanges: Record "User Changes")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelUserChangesRequest(var UserChanges: Record "User Changes")
    begin
    end;
    //-------------------------------------------------------UserChanges------------------------------------------------------------------------
}
