pageextension 51028 "Purch. Invoice Subform Ext" extends "Purch. Invoice Subform"
{
    layout
    {
        // modify("Gen. Bus. Posting Group")
        // {
        //     Visible = true;
        // }
        modify("Gen. Prod. Posting Group")
        {
            Visible = true;
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
    }
}
