Page 50347 "Transfer Schedule"
{
    ApplicationArea = Basic;
    PageType = ListPart;
    SourceTable = "BOSA Transfer Schedule";
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Type';
                }
                field("Source Account No."; Rec."Source Account No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account to Debit(BOSA)';
                }
                field("Source Account Name"; Rec."Source Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Line Description"; Rec."Line Description")
                {
                    ApplicationArea = Basic;
                }
                field(Loan; Rec.Loan)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(charges; Rec.charges)
                {
                    ApplicationArea = Basic;
                    Caption = 'Include Transfer Fee';
                }
                field("Transfer Fee"; Rec."Transfer Fee")
                {
                    ApplicationArea = Basic;
                }




                //************************************************************************
                field("Destination Account Type"; Rec."Destination Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account No."; Rec."Destination Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account Name"; Rec."Destination Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Loan"; Rec."Destination Loan")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Type"; Rec."Destination Type")
                {
                    ApplicationArea = Basic;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
    actions
    {
    }
}
