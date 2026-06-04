Page 50616 "Loan Top-Up List-Posted"
{
    ApplicationArea = Basic;
    Caption = 'Loan Refinance List';
    CardPageID = "Loan Top-Up Card-Posted";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Loan Top Up.";
    SourceTableView = where(Posted = const(true));
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;

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
