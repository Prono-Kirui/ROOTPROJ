codeunit 51008 "Workflow Responses Finance"
{
    trigger OnRun()
    begin
    end;

    procedure ReleaseBudget(var BudgetRec: Record "Budget Approval Header")
    var
        Budget: Record "Budget Approval Header";
        BudgetApprovalLines: Record "Budget Approval Lines";
        /* ProcPlanApprovalLines: Record "Procurement Plan Approval Line";
        ProcPlanItems: Record "Procurement Plan Item"; */
        GLBudgetEntry: Record "G/L Budget Entry";
    begin
        if Budget.Get(BudgetRec."Document No.") then begin
            case Budget."Budget Type" of
                Budget."Budget Type"::Budget:
                    begin
                        BudgetApprovalLines.Reset();
                        BudgetApprovalLines.SetRange("Document No.", Budget."Document No.");
                        if BudgetApprovalLines.Find('-') then
                            repeat
                                GLBudgetEntry.Init();
                                GLBudgetEntry.TransferFields(BudgetApprovalLines);
                                GLBudgetEntry."Entry No." := GLBudgetEntry.GetNextEntryNo();
                                if Budget."Budget Option" = Budget."Budget Option"::Budgeting then
                                    GLBudgetEntry."Budget Status" := GLBudgetEntry."Budget Status"::Open
                                else
                                    GLBudgetEntry."Budget Status" := GLBudgetEntry."Budget Status"::Approved;
                                GLBudgetEntry.Insert(true);

                                BudgetApprovalLines.Proposed := true;
                                BudgetApprovalLines.Posted := true;
                                BudgetApprovalLines."Posted By" := UserId;
                                BudgetApprovalLines."Date-Time Posted" := CreateDateTime(Today, Time);
                                BudgetApprovalLines."Budget Status" := BudgetApprovalLines."Budget Status"::Approved;
                                BudgetApprovalLines."User ID" := Budget."User ID";
                                BudgetApprovalLines.Modify();
                            until BudgetApprovalLines.Next() = 0;
                    end;
            /* Budget."Budget Type"::"Procurement Plan":
                begin
                    case Budget."Budget Option" of
                        Budget."Budget Option"::"Procurement Plan":
                            begin
                                ProcPlanApprovalLines.Reset();
                                ProcPlanApprovalLines.SetRange("Document No.", Budget."Document No.");
                                if ProcPlanApprovalLines.FindSet() then
                                    repeat
                                        ProcPlanItems.Init();
                                        ProcPlanItems.TransferFields(ProcPlanApprovalLines);
                                        ProcPlanItems."Plan Year" := Budget."Budget Name";
                                        ProcPlanItems."Plan Item No" := '';
                                        ProcPlanItems."User ID" := Budget."User ID";
                                        ProcPlanItems.Insert(true);
                                    until ProcPlanApprovalLines.Next() = 0;
                            end;
                        Budget."Budget Option"::"Procurement Plan Review":
                            begin
                                ProcPlanItems.SetRange("Plan Year", Budget."Budget Name");
                                ProcPlanItems.DeleteAll();

                                ProcPlanApprovalLines.Reset();
                                ProcPlanApprovalLines.SetRange("Document No.", Budget."Document No.");
                                if ProcPlanApprovalLines.FindSet() then
                                    repeat
                                        ProcPlanItems.Init();
                                        ProcPlanItems.TransferFields(ProcPlanApprovalLines);
                                        ProcPlanItems."Plan Year" := Budget."Budget Name";
                                        ProcPlanItems."Plan Item No" := '';
                                        ProcPlanItems."User ID" := ProcPlanApprovalLines."User ID";
                                        ProcPlanItems.Insert(true);
                                    until ProcPlanApprovalLines.Next() = 0;
                            end;
                    end;

                    Budget.Status := Budget.Status::Approved;
                    Budget.Modify();
                end; */
            end;

            Budget.Status := Budget.Status::Approved;
            Budget.Modify();
        end;
    end;

    procedure ReopenBudget(var BudgetRec: Record "Budget Approval Header")
    var
        Budget: Record "Budget Approval Header";
    begin
        Budget.Reset();
        Budget.SetRange("Document No.", BudgetRec."Document No.");
        if Budget.FindFirst() then begin
            //Transfer Lines to main budget
            Budget.Status := Budget.Status::Open;
            Budget.Modify();
        end;
    end;

    procedure ReleaseProposedBudget(var ProposedBudget: Record "G/L Budget Name")
    var
        GLBudgetEntry: Record "G/L Budget Entry";
        Budget: Record "G/L Budget Name";
    begin
        Budget.Reset();
        Budget.SetRange("Document No.", ProposedBudget."Document No.");
        if Budget.FindFirst() then begin
            GLBudgetEntry.Reset();
            GLBudgetEntry.SetRange("Budget Name", Budget.Name);
            if GLBudgetEntry.Find('-') then
                repeat
                    GLBudgetEntry."Budget Status" := GLBudgetEntry."Budget Status"::Approved;
                    GLBudgetEntry.Modify();
                until GLBudgetEntry.Next() = 0;

            Budget."Budget Status" := Budget."Budget Status"::Approved;
            Budget.Modify();
        end;
    end;

    procedure ReopenProposedBudget(var ProposedBudget: Record "G/L Budget Name")
    var
        Budget: Record "G/L Budget Name";
    begin
        Budget.Reset();
        Budget.SetRange("Document No.", ProposedBudget."Document No.");
        if Budget.FindFirst() then begin
            Budget."Budget Status" := Budget."Budget Status"::Open;
            Budget.Modify();
        end;
    end;

    procedure ReleaseBankRec(BankAccRec: Record "Bank Acc. Reconciliation")
    var
        BankAccReconciliation: Record "Bank Acc. Reconciliation";
    begin
        BankAccReconciliation.Reset();
        BankAccReconciliation.SetRange("Document No.", BankAccRec."Document No.");
        if BankAccReconciliation.FindFirst() then begin
            BankAccReconciliation."Approval Status" := BankAccReconciliation."Approval Status"::Approved;
            BankAccReconciliation.Modify();
        end;
    end;

    procedure ReopenBankRec(BankAccRec: Record "Bank Acc. Reconciliation")
    var
        BankAccReconciliation: Record "Bank Acc. Reconciliation";
    begin
        BankAccReconciliation.Reset();
        BankAccReconciliation.SetRange("Document No.", BankAccRec."Document No.");
        if BankAccReconciliation.FindFirst() then begin
            BankAccReconciliation."Approval Status" := BankAccReconciliation."Approval Status"::Open;
            BankAccReconciliation.Modify();
        end;
    end;

    procedure ReleaseUserChanges(var UserChanges: Record "User Changes")
    var
        UserChangesRec: Record "User Changes";
    begin
        if UserChangesRec.Get(UserChanges."Document No.") then begin
            UserChangesRec.Validate(Status, UserChangesRec.Status::Approved);
            UserChangesRec.Validate("Approved By", UserId());
            UserChangesRec.Validate("Approved Date", Today());
            UserChangesRec.Modify();
        end;
    end;

    procedure ReOpenUserChanges(var UserChanges: Record "User Changes")
    var
        UserChangesRec: Record "User Changes";
    begin
        if UserChangesRec.Get(UserChanges."Document No.") then begin
            UserChangesRec.Validate(Status, UserChangesRec.Status::Open);
            UserChangesRec.Validate("Approved By", '');
            UserChangesRec.Validate("Approved Date", 0D);
            UserChangesRec.Modify();
        end;
    end;
}
