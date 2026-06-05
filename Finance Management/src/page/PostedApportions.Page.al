page 51090 "Posted Apportions"
{
    ApplicationArea = All;
    Caption = 'Posted Apportions';
    CardPageId = "Posted Apportion Card";
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Apportion Header";
    SourceTableView = where(Posted = const(true));
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    ToolTip = 'Specifies the value of the No. field';
                }
                field("Created Date"; Rec."Created Date")
                {
                    Caption = 'Created Date';
                    ToolTip = 'Specifies the value of the Created Date field';
                }
                field(Posted; Rec.Posted)
                {
                    Caption = 'Posted';
                    ToolTip = 'Specifies the value of the Posted field';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    Caption = 'Total Amount';
                    ToolTip = 'Specifies the value of the Total Amount field';
                }
            }
        }
    }
}
