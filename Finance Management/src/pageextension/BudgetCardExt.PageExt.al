pageextension 51000 BudgetCardExt extends Budget
{
    actions
    {
        addafter(ReportGroup)
        {
            group(Approvals)
            {
                Caption = 'Approvals';
                action(SendApproval)
                {
                    ApplicationArea = All;
                    Caption = 'Send Proposed Budget For Approval';
                    ToolTip = 'Executes the Send Proposed Budget For Approval action';

                    /* trigger OnAction()
                    begin
                        if Confirm(SendApprovalTxt, false) then begin
                            //if GLBudgetName.get(budget)
                        end;
                    end; */
                }
            }
        }
    }
}
