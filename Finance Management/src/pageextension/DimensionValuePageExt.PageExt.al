pageextension 51001 DimensionValuePageExt extends "Dimension Values"
{
    layout
    {
        addlast(Control1)
        {
            field("Global Dimension No."; Rec."Global Dimension No.")
            {
                ApplicationArea = All;
                Caption = 'Global Dimension No.';
                ToolTip = 'Specifies the value of the Global Dimension No. field';
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetFilter(Blocked, '=%1', false);
    end;
}
