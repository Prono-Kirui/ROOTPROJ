page 51095 "Vote Transfers"
{
    ApplicationArea = All;
    Caption = 'Vote Transfers';
    CardPageId = "Vote Transfer";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Votebook Transfer";
    SourceTableView = where(Posted = const(false));
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field(No; Rec.No)
                {
                    Caption = 'No';
                    ToolTip = 'Specifies the value of the No field';
                }
                field(Date; Rec.Date)
                {
                    Caption = 'Date';
                    ToolTip = 'Specifies the value of the Date field';
                }
                field("Source Vote"; Rec."Source Vote")
                {
                    Caption = 'Source G/L Account';
                    ToolTip = 'Specifies the value of the Source G/L Account field';
                }
                field("Destination Vote"; Rec."Destination Vote")
                {
                    Caption = 'Destination G/L Account';
                    ToolTip = 'Specifies the value of the Destination G/L Account field';
                }
                field("Budget Name"; Rec."Budget Name")
                {
                    Caption = 'Budget Name';
                    ToolTip = 'Specifies the value of the Budget Name field';
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                    ToolTip = 'Specifies the value of the Amount field';
                }
            }
        }
    }
}
