tableextension 51017 "Bank Account Ledger Entry Ext" extends "Bank Account Ledger Entry"
{
    fields
    {
        field(51003; Payee; Text[250])
        {
            Caption = 'Payee';
            DataClassification = CustomerContent;
        }
    }
}
