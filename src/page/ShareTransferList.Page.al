page 50399 "Share Transfer List"
{
    ApplicationArea = All;
    Caption = 'SharesCapital Trading List';
    PageType = List;
    CardPageId = "Shares Transfer Card";
    SourceTable = "Shares Transfer Header";
    UsageCategory = Lists;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Reference No"; Rec."Reference No")
                {
                    ToolTip = 'Specifies the value of the Reference No field.';
                }
                field("Member No"; Rec."Member No")
                {
                    ToolTip = 'Specifies the value of the Reference No field.';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Reference No field.';
                }
                field("Shares Amount"; Rec."Shares Amount")
                {
                    ToolTip = 'Specifies the value of the Reference No field.';
                }
                field("Amount To Transfer"; Rec."Amount To Transfer")
                {
                    ToolTip = 'Specifies the value of the Reference No field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Reference No field.';
                    Style = Attention;
                }
            }
        }
    }
}
