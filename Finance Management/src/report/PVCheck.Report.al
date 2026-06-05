report 51013 "PV Check"
{
    ApplicationArea = All;
    Caption = 'PV Check';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/PVCheck.rdlc';
    dataset
    {
        dataitem(Payments; Payments)
        {
            CalcFields = "Total Net Amount";

            column(No_Payments; Payments."No.")
            {
            }
            column(Date_Payments; Payments.Date)
            {
            }
            column(PayMode_Payments; Payments."Pay Mode")
            {
            }
            column(ChequeNo_Payments; Payments."Cheque No")
            {
            }
            column(ChequeDate_Payments; Payments."Cheque Date")
            {
            }
            column(Payee_Payments; Payments.Payee)
            {
            }
            column(Onbehalfof_Payments; Payments."On behalf of")
            {
            }
            column(TotalNetAmount_Payments; Payments."Total Net Amount")
            {
            }
            column(AmountInWords; NumberText[1])
            {
            }

            trigger OnAfterGetRecord()
            begin
                NetAmount := Payments."Total Net Amount";

                PaymentMgt.InitTextVariable();
                PaymentMgt.FormatNoText(NumberText, NetAmount, CurrencyCodeText);

                Payments."Check Printed" := true;
                Payments.Modify();

                InsertCheckLedger();
            end;
        }
    }
    labels
    {
    }

    var
        CheckLedgerEntry: Record "Check Ledger Entry";
        PaymentMgt: Codeunit "Payments Management";
        CurrencyCodeText: Code[10];
        NetAmount: Decimal;
        NumberText: array[2] of Text[80];

    local procedure InsertCheckLedger()
    var
        EntryNo: Integer;
    begin
        if CheckLedgerEntry.FindLast() then
            EntryNo := CheckLedgerEntry."Entry No." + 1
        else
            EntryNo := 1;

        CheckLedgerEntry.Init();
        CheckLedgerEntry."Entry No." := EntryNo;
        CheckLedgerEntry."Bank Account No." := Payments."Paying Bank Account";
        CheckLedgerEntry."Posting Date" := Payments."Cheque Date";
        CheckLedgerEntry."Document No." := Payments."No.";
        CheckLedgerEntry.Description := Payments."Payment Narration";
        CheckLedgerEntry."Bank Payment Type" := CheckLedgerEntry."Bank Payment Type"::"Computer Check";
        CheckLedgerEntry."Entry Status" := CheckLedgerEntry."Entry Status"::Printed;
        CheckLedgerEntry."Check No." := Payments."Cheque No";
        CheckLedgerEntry."Check Date" := Payments."Cheque Date";
        CheckLedgerEntry.Amount := Payments."Total Net Amount";
        CheckLedgerEntry.Insert();
    end;
}
