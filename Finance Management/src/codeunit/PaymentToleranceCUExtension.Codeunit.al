codeunit 51006 PaymentToleranceCUExtension
{
    procedure CheckCalcPmtDiscPaymentsCust(PaymentLine: Record "Payment Lines"; OldCustLedgEntry2: Record "Cust. Ledger Entry"; ApplnRoundingPrecision: Decimal; CheckAmount: Boolean): Boolean
    var
        NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer";
        OldCVLedgEntryBuf2: Record "CV Ledger Entry Buffer";
        PaymentRec: Record Payments;
        PaymentTolerance: Codeunit "Payment Tolerance Management";
    begin
        PaymentRec.Get(PaymentLine.No);
        NewCVLedgEntryBuf."Document Type" := NewCVLedgEntryBuf."Document Type"::" ";
        NewCVLedgEntryBuf."Posting Date" := PaymentRec.Date;
        NewCVLedgEntryBuf."Remaining Amount" := PaymentLine.Amount;
        OldCVLedgEntryBuf2.CopyFromCustLedgEntry(OldCustLedgEntry2);
        exit(
          PaymentTolerance.CheckCalcPmtDisc(
            NewCVLedgEntryBuf, OldCVLedgEntryBuf2, ApplnRoundingPrecision, false, CheckAmount));
    end;

    procedure CheckCalcPmtDiscPaymentsVend(PaymentLine: Record "Payment Lines"; OldVendLedgEntry2: Record "Vendor Ledger Entry"; ApplnRoundingPrecision: Decimal; CheckAmount: Boolean): Boolean
    var
        NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer";
        OldCVLedgEntryBuf2: Record "CV Ledger Entry Buffer";
        PaymentRec: Record Payments;
        PaymentTolerance: Codeunit "Payment Tolerance Management";
    begin
        PaymentRec.Get(PaymentLine.No);
        NewCVLedgEntryBuf."Document Type" := NewCVLedgEntryBuf."Document Type"::" ";
        NewCVLedgEntryBuf."Posting Date" := PaymentRec.Date;
        NewCVLedgEntryBuf."Remaining Amount" := PaymentLine.Amount;
        OldCVLedgEntryBuf2.CopyFromVendLedgEntry(OldVendLedgEntry2);
        exit(
          PaymentTolerance.CheckCalcPmtDisc(
            NewCVLedgEntryBuf, OldCVLedgEntryBuf2, ApplnRoundingPrecision, false, CheckAmount));
    end;

    procedure DelPmtTolApllnDocNoPayments(PaymentLine: Record "Payment Lines"; DocumentNo: Code[20])
    var
        AppliedCustLedgEntry: Record "Cust. Ledger Entry";
        AppliedVendLedgEntry: Record "Vendor Ledger Entry";
    begin
        if PaymentLine."Account Type" = PaymentLine."Account Type"::Customer then begin
            AppliedCustLedgEntry.SetCurrentKey("Customer No.", Open, Positive);
            AppliedCustLedgEntry.SetRange("Customer No.", PaymentLine."Account No");
            AppliedCustLedgEntry.SetRange(Open, true);
            AppliedCustLedgEntry.SetRange("Document No.", DocumentNo);
            AppliedCustLedgEntry.LockTable();
            if AppliedCustLedgEntry.FindSet() then
                repeat
                    AppliedCustLedgEntry."Accepted Payment Tolerance" := 0;
                    AppliedCustLedgEntry."Accepted Pmt. Disc. Tolerance" := false;
                    AppliedCustLedgEntry.Modify();
                until AppliedCustLedgEntry.Next() = 0;
        end else
            if PaymentLine."Account Type" = PaymentLine."Account Type"::Vendor then begin
                AppliedVendLedgEntry.SetCurrentKey("Vendor No.", Open, Positive);
                AppliedVendLedgEntry.SetRange("Vendor No.", PaymentLine."Account No");
                AppliedVendLedgEntry.SetRange(Open, true);
                AppliedVendLedgEntry.SetRange("Document No.", DocumentNo);
                AppliedVendLedgEntry.LockTable();
                if AppliedVendLedgEntry.FindSet() then
                    repeat
                        AppliedVendLedgEntry."Accepted Payment Tolerance" := 0;
                        AppliedVendLedgEntry."Accepted Pmt. Disc. Tolerance" := false;
                        AppliedVendLedgEntry.Modify();
                    until AppliedVendLedgEntry.Next() = 0;
            end;
    end;
}
