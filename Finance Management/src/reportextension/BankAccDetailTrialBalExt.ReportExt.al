reportextension 51000 "Bank Acc Detail Trial Bal. Ext" extends "Bank Acc. - Detail Trial Bal."
{
    dataset
    {
        add("Bank Account Ledger Entry")
        {
            column(Payee_BankAccountLedgerEntry; Payee)
            {
            }
        }
    }


    rendering
    {
        layout(Custom)
        {
            Caption = 'Bank Accounts - Detail Trial Balance - AACC';
            Type = RDLC;
            LayoutFile = './src/report_layout/BankAccDetailTrialBal-AACC.rdl';
        }
    }
}
