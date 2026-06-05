pageextension 51024 "Purchase Journal Ext" extends "Purchase Journal"
{
    layout
    {
        modify("Currency Code")
        {
            ApplicationArea = All;
            Visible = true;
        }
    }
}
