pageextension 51029 "Purch. Order Subform Ext" extends "Purchase Order Subform"
{
    layout
    {
        // modify("Gen. Bus. Posting Group")
        // {
        //     Visible = true;
        // }
        // modify("Gen. Prod. Posting Group")
        // {
        //     Visible = true;
        // }
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
    }
}
