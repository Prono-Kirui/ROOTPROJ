pageextension 51012 CustLedgerEntryPageExt extends "Customer Ledger Entries"
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
