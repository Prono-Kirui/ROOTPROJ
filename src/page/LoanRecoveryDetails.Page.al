#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50917 "Loan Recovery Details"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = "Loan Member Loans";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Guarantor Number"; Rec."Guarantor Number")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Type"; Rec."Loan Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field("Amont Guaranteed"; Rec."Amont Guaranteed")
                {
                    ApplicationArea = Basic;
                }
                field("Current Member Deposits"; Rec."Current Member Deposits")
                {
                    ApplicationArea = Basic;
                }
                field("Guarantor Amount Apportioned"; Rec."Guarantor Amount Apportioned")
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
