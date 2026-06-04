page 50090 "Shares Transfer List"
{
    ApplicationArea = All;
    Caption = 'Shares Transfer List';
    PageType = List;
    CardPageId = "New Shares Transfer Card";

    SourceTable = "Shares Transfer Header";
    UsageCategory = Lists;
    Editable = false;

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
