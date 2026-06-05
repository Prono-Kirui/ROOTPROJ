codeunit 51007 PaymentsPostingCUExt
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Vend. Entry-SetAppl.ID", 'OnAfterUpdateVendLedgerEntry', '', false, false)]
    local procedure ValidateAppliesToID(var VendorLedgerEntry: Record "Vendor Ledger Entry"; var TempVendLedgEntry: Record "Vendor Ledger Entry" temporary; ApplyingVendLedgEntry: Record "Vendor Ledger Entry"; AppliesToID: Code[50])
    begin
        VendorLedgerEntry.Validate("Applies-to ID");
        VendorLedgerEntry.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", 'OnAfterCopyGLEntryFromGenJnlLine', '', false, false)]
    local procedure OnAfterCopyGLEntryFromGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry")
    begin
        GLEntry.Payee := GenJournalLine.Payee;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Bank Account Ledger Entry", 'OnAfterCopyFromGenJnlLine', '', false, false)]
    local procedure OnAfterCopyBankAccLedgEntryFromGenJnlLine(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        BankAccountLedgerEntry.Payee := GenJournalLine.Payee;
    end;

    /* [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostBankAccOnBeforeInitBankAccLedgEntry', '', false, false)]
    local procedure PreventOverdrawingBank(var GenJournalLine: Record "Gen. Journal Line")
    var
        BankAcc: Record "Bank Account";
        OverdrawWarningMsg: Label 'Please note that this transaction will result in an Overdraw of Bank Account %1';
    begin

        if BankAcc.Get(GenJournalLine."Account No.") then begin
            BankAcc.CalcFields("Balance (LCY)");
            case BankAcc."Bank Type" of
                BankAcc."Bank Type"::Bank:
                    if GenJournalLine."Credit Amount" <> 0 then begin
                        if (BankAcc."Balance (LCY)" - GenJournalLine."Credit Amount") < 0 then
                            Message(OverdrawWarningMsg, BankAcc.Name);
                    end;
            end;
        end;
    end;
    */
}
