page 50849 "Loan Schedule List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Loan Repayment Schedule";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Loan No."; Rec."Loan No.")
                {

                }
                field("Member No."; Rec."Member No.")
                {

                }
                field("Member Name"; Rec."Member Name")
                {

                }
                field("Principal Repayment"; Rec."Principal Repayment")
                {

                }
                field("Interest Paid"; Rec."Interest Paid")
                {

                }
                field("Monthly Repayment"; Rec."Monthly Repayment")
                {

                }
                field("Loan Balance"; Rec."Loan Balance")
                {

                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }
}