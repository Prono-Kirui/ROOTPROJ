tableextension 50045 "BankAccountLedgerEntryExt" extends "Bank Account Ledger Entry"
{
    fields
    {
        field(1000; "Type"; Code[100])
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
        }
        field(1001; "Teller Transaction Type"; enum "Teller Transaction Types")
        {
            DataClassification = ToBeClassified;
        }
    }
}
