pageextension 51015 FixedAssetsGLJournal extends "Fixed Asset G/L Journal"
{
    actions
    {
        addbefore("P&ost")

        {
            group(Approvals)
            {
                Caption = 'Approvals';
                Image = "Action";
                action(SendApprovalRequest)
                {
                    ApplicationArea = All;
                    Caption = 'Send A&pproval Request';
                    //Enabled = not OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    ToolTip = 'Executes the Send A&pproval Request action';

                    trigger OnAction()
                    var
                        ApprovalMng: Codeunit "Approvals Mgmt.";
                        ApprovalTxt: Label 'Are you sure you want to sent for Approval';

                    begin
                        if Confirm(ApprovalTxt, false) = true then
                            if ApprovalMng.CheckGeneralJournalLineApprovalsWorkflowEnabled(Rec) then
                                ApprovalMng.OnSendGeneralJournalLineForApproval(Rec);
                        //CurrPage.Close();
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = All;
                    Caption = 'Cancel A&pproval Request';
                    //Enabled = not OpenApprovalEntriesExist;
                    Image = CancelApprovalRequest;
                    ToolTip = 'Executes the Cancel A&pproval Request action';

                    trigger OnAction()
                    var
                        ApprovalMng: Codeunit "Approvals Mgmt.";

                    begin

                        ApprovalMng.OnCancelGeneralJournalLineApprovalRequest(Rec);
                    end;
                    //CurrPage.Close();
                }
            }
        }
        addlast(Category_Process)
        {
            actionref(SendApprovalRequest_Promoted; SendApprovalRequest)
            {
            }
            actionref(CancelApprovalRequest_Promoted; CancelApprovalRequest)
            {
            }
        }
    }
}
