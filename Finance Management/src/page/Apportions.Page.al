page 51087 Apportions
{
    ApplicationArea = All;
    Caption = 'Apportions';
    CardPageId = "Apportion Card";
    PageType = List;
    SourceTable = "Apportion Header";
    SourceTableView = where(Posted = const(false));
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
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                    ToolTip = 'Specifies the value of the Status field';
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
