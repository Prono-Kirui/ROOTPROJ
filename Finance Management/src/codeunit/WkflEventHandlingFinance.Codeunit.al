codeunit 51010 "Wkfl Event Handling Finance"
{
    var
        WorkflowEvent: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";
        BankRecCancelApprovalTxt: Label 'An approval request for Bank Reconciliation is cancelled';
        BankRecSendApprovalTxt: Label 'An approval request for a Bank Reconciliation is requested';
        BudgetCancelApprovalTxt: Label 'An approval request for Budget Lines is cancelled';
        BudgetSendApprovalTxt: Label 'An approval request for Budget Lines is requested';
        PaymentsApprovalRequestCancelledEventDescTxt: Label 'Approval Request for a payment has been cancelled';
        PaymentsReleasedEventDescTxt: Label 'A payment has been released';
        PaymentsSendForApprovalEventDescTxt: Label 'Approval of Payment is requested';
        ProposedBudgetCancelApprovalTxt: Label 'An approval request for Proposed Budget Lines is cancelled';
        ProposedBudgetSendApprovalTxt: Label 'An approval request for Proposed Budget is requested';
        UserChangesCancelApprovalRequestDescTxt: Label 'An approval request for a User Change is cancelled ';
        UserChangesSendforApprovalDescTxt: Label 'An approval for a User Change is requested';

    //-------------------------------------------------------Payments------------------------------------------------------------------------
    procedure RunWorkflowOnSendPaymentsForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPaymentsForApproval'));
    end;

    procedure RunWorkflowOnCancelPaymentsApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPaymentsApprovalRequest'));
    end;

    procedure RunWorkflowOnAfterReleasePaymentsCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnAfterReleasePayments'));
    end;

    procedure RunWorkflowOnRejectPaymentsCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnAfterRejectPayments'));
    end;
    //-------------------------------------------------------Payments------------------------------------------------------------------------

    //-------------------------------------------------------Budget------------------------------------------------------------------------
    procedure RunWorkflowOnSendBudgetRequestForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendBudgetRequestForApproval'));
    end;

    procedure RunWorkflowOnCancelBudgetRequestForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelBudgetRequestForApproval'));
    end;
    //-------------------------------------------------------Budget------------------------------------------------------------------------

    //-------------------------------------------------------Proposed Budget------------------------------------------------------------------------
    procedure RunWorkflowOnSendProposedBudgetForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendProposedBudgetForApproval'));
    end;

    procedure RunWorkflowOnCancelProposedBudgetForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelProposedBudgetForApproval'));
    end;
    //-------------------------------------------------------Proposed Budget------------------------------------------------------------------------

    //-------------------------------------------------------Bank Reconciliation------------------------------------------------------------------------
    procedure RunWorkflowOnSendBankRecForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendBankRecForApproval'));
    end;

    procedure RunWorkflowOnCancelBankRecForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCanceBankRecForApproval'));
    end;
    //-------------------------------------------------------Bank Reconciliation------------------------------------------------------------------------

    //-------------------------------------------------------User Changes------------------------------------------------------------------------
    procedure RunWorkflowOnSendUserChangesForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendUserChangesForApproval'));
    end;

    procedure RunWorkflowOnCancelUserChangesApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelUserChangesApprovalRequest'));
    end;
    //-------------------------------------------------------User Changes------------------------------------------------------------------------

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary()
    begin
        //Payments
        WorkflowEvent.AddEventToLibrary(
        RunWorkflowOnSendPaymentsForApprovalCode(), Database::Payments,
        PaymentsSendForApprovalEventDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(
        RunWorkflowOnCancelPaymentsApprovalRequestCode(), Database::Payments,
        PaymentsApprovalRequestCancelledEventDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(
        RunWorkflowOnAfterReleasePaymentsCode(), Database::Payments,
        PaymentsReleasedEventDescTxt, 0, false);

        //Budget
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendBudgetRequestForApprovalCode(), Database::"Budget Approval Header",
        BudgetSendApprovalTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelBudgetRequestForApprovalCode(), Database::"Budget Approval Header",
        BudgetCancelApprovalTxt, 0, false);

        //Proposed Budget
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendProposedBudgetForApprovalCode(), Database::"G/L Budget Name",
        ProposedBudgetSendApprovalTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelProposedBudgetForApprovalCode(), Database::"G/L Budget Name",
        ProposedBudgetCancelApprovalTxt, 0, false);

        //Bank Rec
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendBankRecForApprovalCode(), Database::"Bank Acc. Reconciliation",
        BankRecSendApprovalTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelBankRecForApprovalCode(), Database::"Bank Acc. Reconciliation",
        BankRecCancelApprovalTxt, 0, false);

        //User Changes
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendUserChangesForApprovalCode(), Database::"User Changes",
        UserChangesSendforApprovalDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelUserChangesApprovalRequestCode(), Database::"User Changes",
        UserChangesCancelApprovalRequestDescTxt, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEvent: Codeunit "Workflow Event Handling";
    begin
        case EventFunctionName of
            //Payments
            RunWorkflowOnCancelPaymentsApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelPaymentsApprovalRequestCode(), RunWorkflowOnSendPaymentsForApprovalCode());

            //Budget
            RunWorkflowOnSendBudgetRequestForApprovalCode():
                WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelBudgetRequestForApprovalCode(), RunWorkflowOnSendBudgetRequestForApprovalCode());

            //Proposed Budget
            RunWorkflowOnSendProposedBudgetForApprovalCode():
                WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelProposedBudgetForApprovalCode(), RunWorkflowOnSendProposedBudgetForApprovalCode());

            //Bank Rec
            RunWorkflowOnSendBankRecForApprovalCode():
                WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelBankRecForApprovalCode(), RunWorkflowOnSendBankRecForApprovalCode());

            //User Changes
            RunWorkflowOnCancelUserChangesApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelUserChangesApprovalRequestCode(), RunWorkflowOnSendUserChangesForApprovalCode());

            WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode():
                begin
                    //Payments
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunWorkflowOnSendPaymentsForApprovalCode());
                    //Budget
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunWorkflowOnSendBudgetRequestForApprovalCode());
                    //Proposed Budget
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunWorkflowOnSendProposedBudgetForApprovalCode());
                    //Bank Rec
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunWorkflowOnSendBankRecForApprovalCode());
                    //User Changes
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunWorkflowOnSendUserChangesForApprovalCode());
                end;

            WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode():
                begin
                    //Payments
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunWorkflowOnSendPaymentsForApprovalCode());
                    //Budget
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunWorkflowOnSendBudgetRequestForApprovalCode());
                    //Proposed Budget
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunWorkflowOnSendProposedBudgetForApprovalCode());
                    //Bank Rec
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunWorkflowOnSendBankRecForApprovalCode());
                    //User Changes
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunWorkflowOnSendUserChangesForApprovalCode());
                end;
            WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode():
                begin
                    //Payments
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunWorkflowOnSendPaymentsForApprovalCode());
                    //Budget
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunWorkflowOnSendBudgetRequestForApprovalCode());
                    //Proposed Budget
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunWorkflowOnSendProposedBudgetForApprovalCode());
                    //Bank Rec
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunWorkflowOnSendBankRecForApprovalCode());
                    //User Changes
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunWorkflowOnSendUserChangesForApprovalCode());
                end;
        end;
    end;

    //-------------------------------------------------------Payments------------------------------------------------------------------------
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt Finance Ext", 'OnSendPaymentsForApproval', '', false, false)]
    local procedure RunWorkflowOnSendPaymentsForApproval(var Payments: Record Payments)
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPaymentsForApprovalCode(), Payments);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt Finance Ext", 'OnCancelPaymentsApprovalRequest', '', false, false)]
    local procedure RunWorkflowOnCancelPaymentsApprovalRequest(var Payments: Record Payments)
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPaymentsApprovalRequestCode(), Payments);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Payments", 'OnAfterReleasePayments', '', false, false)]
    local procedure RunWorkflowOnAfterReleasePaymentsDoc(var Payments: Record Payments)
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleasePaymentsCode(), Payments);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    local procedure RunWorkflowOnRejectPayments(var ApprovalEntry: Record "Approval Entry")
    var
        PaymentsRec: Record Payments;
    begin
        WorkflowManagement.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectPaymentsCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
        PaymentsRec.Reset();
        PaymentsRec.SetRange("No.", ApprovalEntry."Document No.");
        if PaymentsRec.FindFirst() then begin
            PaymentsRec.Status := PaymentsRec.Status::Open;
            PaymentsRec.Modify(true);
        end;
    end;
    //-------------------------------------------------------Payments------------------------------------------------------------------------

    //-------------------------------------------------------Budget------------------------------------------------------------------------
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt Finance Ext", 'OnSendBudgetApproval', '', false, false)]
    local procedure RunWorkflowOnSendBudgetRequestForApproval(var Budget: Record "Budget Approval Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendBudgetRequestForApprovalCode(), Budget);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt Finance Ext", 'OnCancelBudgetApproval', '', false, false)]
    local procedure RunWorkflowOnCancelBudgetRequestForApproval(var Budget: Record "Budget Approval Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelBudgetRequestForApprovalCode(), Budget);
    end;
    //-------------------------------------------------------Budget------------------------------------------------------------------------

    //-------------------------------------------------------Proposed Budget------------------------------------------------------------------------
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt Finance Ext", 'OnSendProposedBudgetApproval', '', false, false)]
    local procedure RunWorkflowOnSendProposedBudgetForApproval(var ProposedBudget: Record "G/L Budget Name")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendProposedBudgetForApprovalCode(), ProposedBudget);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt Finance Ext", 'OnCancelProposedBudgetApproval', '', false, false)]
    local procedure RunWorkflowOnCancelProposedBudgetForApproval(var ProposedBudget: Record "G/L Budget Name")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelProposedBudgetForApprovalCode(), ProposedBudget);
    end;
    //-------------------------------------------------------Proposed Budget------------------------------------------------------------------------

    //-------------------------------------------------------Bank Reconciliation------------------------------------------------------------------------
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt Finance Ext", 'OnSendBankRecApproval', '', false, false)]
    local procedure RunWorkflowOnSendBankRecForApproval(var BankAccRec: Record "Bank Acc. Reconciliation")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendBankRecForApprovalCode(), BankAccRec);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt Finance Ext", 'OnCancelBankRecApproval', '', false, false)]
    local procedure RunWorkflowOnCanceBankRecForApproval(var BankAccRec: Record "Bank Acc. Reconciliation")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelBankRecForApprovalCode(), BankAccRec);
    end;
    //-------------------------------------------------------Bank Reconciliation------------------------------------------------------------------------

    //-------------------------------------------------------User Changes------------------------------------------------------------------------
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt Finance Ext", 'OnSendUserChangesForApproval', '', false, false)]
    local procedure RunWorkflowOnSendUserChangesForApproval(var UserChanges: Record "User Changes")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendUserChangesForApprovalCode(), UserChanges);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt Finance Ext", 'OnCancelUserChangesRequest', '', false, false)]
    local procedure RunWorkflowOnCancelUserChangesApprovalRequest(var UserChanges: Record "User Changes")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelUserChangesApprovalRequestCode(), UserChanges);
    end;
    //-------------------------------------------------------User Changes------------------------------------------------------------------------
}
