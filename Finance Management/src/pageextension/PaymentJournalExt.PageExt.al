pageextension 51022 "Payment Journal Ext" extends "Payment Journal"
{
    layout
    {
        modify("Currency Code")
        {
            ApplicationArea = All;
            Visible = true;
        }
        modify("Bal. Gen. Posting Type")
        {
            ApplicationArea = All;
            Visible = true;
        }
        modify("Bal. Gen. Bus. Posting Group")
        {
            ApplicationArea = All;
            Visible = true;
        }
        modify("Bal. Gen. Prod. Posting Group")
        {
            ApplicationArea = All;
            Visible = true;
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = true;
        }
        modify("Gen. Posting Type")
        {
            Visible = true;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = true;
        }
        modify("External Document No.")
        {
            Visible = true;
        }
    }
}
