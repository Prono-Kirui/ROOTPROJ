report 51027 "Petty Cash Summary"
{
    ApplicationArea = All;
    Caption = 'Petty Cash Summary';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/PettyCashSummary.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Payments; Payments)
        {
            column(No; "No.")
            {
            }
            column(AccountNo; "Account No.")
            {
            }
            column(AccountName; "Account Name")
            {
            }
            column(CashReceiptAmount; "Cash Receipt Amount")
            {
            }
            column(Date; "Date")
            {
            }
            column(DateCreated; "Date Created")
            {
            }
            column(DateSurrendered; "Date Surrendered")
            {
            }
            column(PaymentNarration; "Payment Narration")
            {
            }
            column(PaymentType; "Payment Type")
            {
            }
            column(PettyCashAmount; "Petty Cash Amount")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(Status; Status)
            {
            }
            column(SurrenderStatus; "Surrender Status")
            {
            }
            column(SurrenderDate; "Surrender Date")
            {
            }
            column(Payee; Payee)
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    Caption = 'GroupName';
                }
            }
        }
    }
}
