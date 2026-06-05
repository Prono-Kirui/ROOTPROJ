pageextension 51017 BankAccountLedgerEnntriesExt extends "Bank Account Ledger Entries"
{
    layout
    {
        addafter("Document No.")
        {
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
                Caption = 'External Document No.';
                ToolTip = 'Specifies the value of the External Document No. field.';
            }
        }
        modify(Reversed)
        {
            Visible = true;
        }
        modify("User ID")
        {
            Visible = true;
        }
        addlast(Control1)
        {
            field(Payee; Rec.Payee)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Payee field.', Comment = '%';
            }
        }
    }
}
