pageextension 51026 "Vendor Ledger Entries Ext" extends "Vendor Ledger Entries"
{
    layout
    {
        modify(Reversed)
        {
            Visible = true;
        }
        modify("User ID")
        {
            Visible = true;
        }
    }
}
