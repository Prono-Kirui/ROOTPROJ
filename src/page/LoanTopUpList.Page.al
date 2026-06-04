Page 50614 "Loan Top-Up List"
{
    ApplicationArea = Basic;
    Caption = 'Loan Refinance List';
    CardPageID = "Loan Top-Up Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Loan Top Up.";
    SourceTableView = where(Posted = const(false));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Topped-Up By"; Rec."Topped-Up By")
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
