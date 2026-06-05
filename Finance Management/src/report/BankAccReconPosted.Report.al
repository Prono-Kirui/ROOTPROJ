report 51042 "Bank Acc. Recon. - Posted"
{
    ApplicationArea = All;
    Caption = 'Bank Acc. Recon. - Posted';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/BankAccReconPosted.rdl';
    UsageCategory = None;

    dataset
    {
        dataitem("Bank Account Statement"; "Bank Account Statement")
        {
            RequestFilterFields = "Statement No.";
            column(BankAccountNo_BankAccountStatement; "Bank Account Statement"."Bank Account No.")
            {
            }
            column(StatementNo_BankAccountStatement; "Bank Account Statement"."Statement No.")
            {
            }
            column(StatementEndingBalance_BankAccountStatement; "Bank Account Statement"."Statement Ending Balance")
            {
            }
            column(StatementDate_BankAccountStatement; "Bank Account Statement"."Statement Date")
            {
            }
            column(BalanceLastStatement_BankAccountStatement; "Bank Account Statement"."Balance Last Statement")
            {
            }
            column(BankCode; BankCode)
            {
            }
            column(BankAccountNo; BankAccountNo)
            {
            }
            column(BankName; BankName)
            {
            }
            column(BankAccountBalanceasperCashBook; BankAccountBalanceasperCashBook)
            {
            }
            column(UnpresentedChequesTotal; UnpresentedChequesTotal)
            {
            }
            column(UncreditedBanking; UncreditedBanking)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(DifferencesInBankTotal; DifferencesInBankTotal)
            {
            }
            column(DifferenceToExplain; DifferenceToExplain)
            {
            }
            dataitem("Bank Account Statement Line"; "Bank Account Statement Line")
            {
                DataItemLink = "Bank Account No." = field("Bank Account No."), "Statement No." = field("Statement No.");
                DataItemTableView = where(Reconciled = const(false), "Statement Amount" = filter(< 0));
                column(BankAccountNo_BankAccountStatementLine; "Bank Account Statement Line"."Bank Account No.")
                {
                }
                column(StatementLineNo_BankAccountStatementLine; "Bank Account Statement Line"."Statement Line No.")
                {
                }
                column(StatementNo_BankAccountStatementLine; "Bank Account Statement Line"."Statement No.")
                {
                }
                column(StatementAmount_BankAccountStatementLine; "Bank Account Statement Line"."Statement Amount")
                {
                }
                column(CheckNo_BankAccountStatementLine; "Bank Account Statement Line"."Check No.")
                {
                }
                column(Description_BankAccountStatementLine; "Bank Account Statement Line".Description)
                {
                }
                column(TransactionDate_BankAccountStatementLine; "Bank Account Statement Line"."Transaction Date")
                {
                }
                column(DocumentNo_BankAccountStatementLine; "Bank Account Statement Line"."Document No.")
                {
                }
            }
            dataitem("<Bank Account Statement Line1>"; "Bank Account Statement Line")
            {
                DataItemLink = "Bank Account No." = field("Bank Account No."), "Statement No." = field("Statement No.");
                DataItemTableView = where(Reconciled = const(false), "Statement Amount" = filter(> 0));
                column(BankAccountNo_BankAccountStatementLine1; "<Bank Account Statement Line1>"."Bank Account No.")
                {
                }
                column(StatementLineNo_BankAccountStatementLine1; "<Bank Account Statement Line1>"."Statement Line No.")
                {
                }
                column(StatementNo_BankAccountStatementLine1; "<Bank Account Statement Line1>"."Statement No.")
                {
                }
                column(CheckNo_BankAccountStatementLine1; "<Bank Account Statement Line1>"."Check No.")
                {
                }
                column(StatementAmount_BankAccountStatementLine1; "<Bank Account Statement Line1>"."Statement Amount")
                {
                }
                column(Description_BankAccountStatementLine1; "<Bank Account Statement Line1>".Description)
                {
                }
                column(TransactionDate_BankAccountStatementLine1; "<Bank Account Statement Line1>"."Transaction Date")
                {
                }
                column(DocumentNo_BankAccountStatementLine1; "<Bank Account Statement Line1>"."Document No.")
                {
                }
            }
            dataitem("Posted Bank Acc. Recon Line"; "Posted Bank Acc. Recon Line")
            {
                DataItemLink = "Bank Account No." = field("Bank Account No."), "Statement No." = field("Statement No.");
                DataItemTableView = where("Applied Amount" = filter(0));
                column(BankAccountNo_PostedBankAccReconLine; "Posted Bank Acc. Recon Line"."Bank Account No.")
                {
                }
                column(StatementNo_PostedBankAccReconLine; "Posted Bank Acc. Recon Line"."Statement No.")
                {
                }
                column(StatementLineNo_PostedBankAccReconLine; "Posted Bank Acc. Recon Line"."Statement Line No.")
                {
                }
                column(CheckNo_PostedBankAccReconLine; "Posted Bank Acc. Recon Line"."Check No.")
                {
                }
                column(DocumentNo_PostedBankAccReconLine; "Posted Bank Acc. Recon Line"."Document No.")
                {
                }
                column(TransactionDate_PostedBankAccReconLine; "Posted Bank Acc. Recon Line"."Transaction Date")
                {
                }
                column(Description_PostedBankAccReconLine; "Posted Bank Acc. Recon Line".Description)
                {
                }
                column(StatementAmount_PostedBankAccReconLine; "Posted Bank Acc. Recon Line"."Statement Amount")
                {
                }
            }

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord()
            begin
                BankCode := '';
                BankAccountNo := '';
                BankName := '';
                BankAccountBalanceasperCashBook := 0;
                UnpresentedChequesTotal := 0;
                UncreditedBanking := 0;

                Bank.Reset();
                Bank.SetRange(Bank."No.", "Bank Account No.");
                if Bank.Find('-') then begin
                    BankCode := Bank."No.";
                    BankAccountNo := Bank."Bank Account No.";
                    BankName := Bank.Name;
                    // Bank.CALCFIELDS(Bank.Balance);
                    // BankAccountBalanceasperCashBook:="Cash Book Balance";
                    //BankAccountBalanceasperCashBook:="Bank Account Statement"."Cash Book Balance";

                    BankStatementLine.Reset();
                    BankStatementLine.SetRange(BankStatementLine."Bank Account No.", Bank."No.");
                    BankStatementLine.SetRange(BankStatementLine."Statement No.", "Statement No.");
                    BankStatementLine.SetRange(BankStatementLine.Reconciled, false);
                    if BankStatementLine.Find('-') then
                        repeat
                            if BankStatementLine."Statement Amount" < 0 then
                                UnpresentedChequesTotal := UnpresentedChequesTotal + BankStatementLine."Statement Amount"
                            else
                                if BankStatementLine."Statement Amount" > 0 then
                                    UncreditedBanking := UncreditedBanking + BankStatementLine."Statement Amount";
                        until BankStatementLine.Next() = 0;

                    UnpresentedChequesTotal := UnpresentedChequesTotal * -1;

                    //BankStatementLine
                end;
                //Diferences in Bank

                PostedBankAccReconLine.Reset();
                PostedBankAccReconLine.SetRange(PostedBankAccReconLine."Bank Account No.", Bank."No.");
                PostedBankAccReconLine.SetRange(PostedBankAccReconLine."Statement No.", "Statement No.");
                PostedBankAccReconLine.SetFilter(PostedBankAccReconLine."Applied Amount", '=%1', 0);
                if PostedBankAccReconLine.Find('-') then
                    repeat
                        DifferencesInBankTotal := DifferencesInBankTotal + PostedBankAccReconLine."Statement Amount";
                    until PostedBankAccReconLine.Next() = 0;

                DifferenceToExplain := Abs(BankAccountBalanceasperCashBook - "Bank Account Statement"."Statement Ending Balance");
            end;
        }
    }

    var
        Bank: Record "Bank Account";
        BankStatementLine: Record "Bank Account Statement Line";
        CompanyInfo: Record "Company Information";
        PostedBankAccReconLine: Record "Posted Bank Acc. Recon Line";
        BankAccountNo: Code[30];
        BankCode: Code[20];
        BankAccountBalanceasperCashBook: Decimal;
        DifferencesInBankTotal: Decimal;
        DifferenceToExplain: Decimal;
        UncreditedBanking: Decimal;
        UnpresentedChequesTotal: Decimal;
        BankName: Text;
}
