page 51078 "Budget Approved List"
{
    ApplicationArea = All;
    Caption = 'Budget Approved List';
    CardPageId = "Budget Approved Card";
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Budget Approval Header";
    SourceTableView = where(Status = filter(Approved), "Budget Type" = const(Budget));
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Document No."; Rec."Document No.")
                {
                    Caption = 'Document No.';
                    ToolTip = 'Specifies the value of the Document No. field';
                }
                field("Date Created"; Rec."Date Created")
                {
                    Caption = 'Date Created';
                    ToolTip = 'Specifies the value of the Date Created field';
                }
                field("Time Created"; Rec."Time Created")
                {
                    Caption = 'Time Created';
                    ToolTip = 'Specifies the value of the Time Created field';
                }
                field("Budget Name"; Rec."Budget Name")
                {
                    Caption = 'Budget Name';
                    ToolTip = 'Specifies the value of the Budget Name field';
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                    ToolTip = 'Specifies the value of the Status field';
                }
                field("User ID"; Rec."User ID")
                {
                    Caption = 'User ID';
                    ToolTip = 'Specifies the value of the User ID field';
                }
            }
        }
    }
}
