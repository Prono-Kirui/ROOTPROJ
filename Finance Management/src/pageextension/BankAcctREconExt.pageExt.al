pageextension 51019 "Bank Acct REcon Ext" extends "Bank Acc. Reconciliation"
{
    layout
    {

    }
    actions
    {
        addlast(processing)
        {
            action("Bank ReconReport")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Test Reconciliation Report';
                Image = Report;
                ToolTip = 'Executes the Journal Report action.';
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    BankRec.Reset();
                    BankRec.SetRange("Bank Account No.", Rec."Bank Account No.");
                    BankRec.SetRange("Statement No.", Rec."Statement No.");
                    if BankRec.FindFirst() then
                        Report.Run(Report::"Bank Reconciliation Test Rep", true, true, BankRec);
                end;
            }
        }
    }
    var
        BankRec: Record "Bank Acc. Reconciliation";
}
