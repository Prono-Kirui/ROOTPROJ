codeunit 51002 "Payments Management"
{
    Permissions = tabledata "Approval Entry" = rimd;

    var
        CMSetup: Record "Cash Management Setups";
        CashOfficeUserTemplate: Record "Cash Office User Template";
        CheckLedgerEntry: Record "Check Ledger Entry";
        CurrencyRec: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        CustLedgEntry: Record "Cust. Ledger Entry";
        Batch: Record "Gen. Journal Batch";
        GLSetup: Record "General Ledger Setup";
        PaymentLine: Record "Payment Lines";
        PaymentsRec: Record Payments;
        VendLedgEntry: Record "Vendor Ledger Entry";
        Apportionment: Codeunit Apportionment;
        Committment: Codeunit "Commitments Mgt Finance";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PaymentToleranceMgt: Codeunit PaymentToleranceCUExtension;
        ApplyCustEntries: Page "Apply Customer Entries Custom";
        ApplyVendEntries: Page "Apply Vendor Entries Custom";
        OK: Boolean;
        CurrencyCode2: Code[10];
        JBatch: Code[10];
        JTemplate: Code[10];
        AccNo: Code[20];
        AccType: Enum "Gen. Journal Account Type";
        CentsTxt: Label 'CENTS';
#pragma warning disable AA0074
#pragma warning disable AA0470
        Text002: Label 'Are you sure you want to post Imprest No %1 ?';
        Text003: Label 'The Imprest No %1  has not been fully approved';
        Text004: Label 'The Imprest Lines are empty';
        Text005: Label 'Amount cannot be zero';
        Text006: Label 'Imprest %1 has been posted';
        Text007: Label 'Are you sure you want to post Imprest Surrender No. %1 ?';
        Text008: Label 'The Imprest Surrender No. %1 has not been fully approved';
        Text013: Label 'The Imprest Surrender has already been posted';
        Text014: Label 'Are you sure you want to post petty cash surrender No %1 ?';
        Text015: Label 'Petty Cash %1 has been surrendered';
        Text017: Label 'Are you sure you want to post receipt no. %1 ?';
        Text018: Label 'The receipt is already posted';
        Text019: Label 'Dept %1 has not been commited, kindly commit before posting';
        Text020: Label 'The Petty Cash Remaining amount must be zero';
        Text021: Label 'Create a Petty Cash Voucher,Create a Payment Voucher, Create a Staff Claim';
        Text022: Label 'Please Choose one of these options';
        WText026: Label 'ZERO';
        WText027: Label 'HUNDRED';
        WText028: Label 'AND';
        WText029: Label '%1 results in a written number that is too long.';
        WText032: Label 'ONE';
        WText033: Label 'TWO';
        WText034: Label 'THREE';
        WText035: Label 'FOUR';
        WText036: Label 'FIVE';
        WText037: Label 'SIX';
        WText038: Label 'SEVEN';
        WText039: Label 'EIGHT';
        WText040: Label 'NINE';
        WText041: Label 'TEN';
        WText042: Label 'ELEVEN';
        WText043: Label 'TWELVE';
        WText044: Label 'THIRTEEN';
        WText045: Label 'FOURTEEN';
        WText046: Label 'FIFTEEN';
        WText047: Label 'SIXTEEN';
        WText048: Label 'SEVENTEEN';
        WText049: Label 'EIGHTEEN';
        WText050: Label 'NINETEEN';
        WText051: Label 'TWENTY';
        WText052: Label 'THIRTY';
        WText053: Label 'FORTY';
        WText054: Label 'FIFTY';
        WText055: Label 'SIXTY';
        WText056: Label 'SEVENTY';
        WText057: Label 'EIGHTY';
        WText058: Label 'NINETY';
        WText059: Label 'THOUSAND';
        WText060: Label 'MILLION';
        WText061: Label 'BILLION';
#pragma warning restore AA0470
#pragma warning restore AA0074
        ExponentText: array[5] of Text[30];
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];

    trigger OnRun()
    begin
    end;

    procedure ApplyEntry(var Rec: Record "Payment Lines")
    var
        PaymentRec: Record Payments;
        MustSpecifyLbl: Label 'You must specify %1 or %2.', Comment = '%1 = Payment Line No., %2 = Applies-to ID';
        CurrencyChangeLbl: Label 'The %1 in the %2 will be changed from %3 to %4.\', Comment = '%1 = Currency, %2 = Payment Line, %3 = Payment Currency, %4 = Entry Currency';
        ConfirmContinueMsg: Label 'Do you wish to continue?';
        WarningLbl: Label 'The update has been interrupted to respect the warning.';
        AccTypeErr: Label 'The %1  must be Customer or Vendor.', Comment = '%1 = Account Type';
    begin
        PaymentLine.Copy(Rec);
        PaymentRec.Get(PaymentLine.No);
        PaymentLine.GetCurrency();
        AccType := PaymentLine."Account Type";
        AccNo := PaymentLine."Account No";
        case AccType of
            AccType::Customer:
                begin
                    CustLedgEntry.SetRange("Applies-to ID");
                    CustLedgEntry.SetCurrentKey("Customer No.", Open, Positive);
                    CustLedgEntry.SetRange("Customer No.", AccNo);
                    CustLedgEntry.SetRange(Open, true);
                    CustLedgEntry.SetRange("On Hold", '');
                    if PaymentLine."Applies-to ID" = '' then
                        PaymentLine."Applies-to ID" := PaymentLine.No;
                    if PaymentLine."Applies-to ID" = '' then
                        Error(
                          MustSpecifyLbl,
                          PaymentLine.FieldCaption(No), PaymentLine.FieldCaption("Applies-to ID"));
                    ApplyCustEntries.SetPaymentLine(PaymentLine, PaymentLine.FieldNo("Applies-to ID"));
                    ApplyCustEntries.SetRecord(CustLedgEntry);
                    ApplyCustEntries.SetTableView(CustLedgEntry);
                    ApplyCustEntries.LookupMode(true);
                    OK := ApplyCustEntries.RunModal() = Action::LookupOK;
                    Clear(ApplyCustEntries);
                    if not OK then
                        exit;
                    CustLedgEntry.Reset();
                    CustLedgEntry.SetCurrentKey("Customer No.", Open, Positive);
                    CustLedgEntry.SetRange("Customer No.", AccNo);
                    CustLedgEntry.SetRange(Open, true);
                    CustLedgEntry.SetRange("Applies-to ID", PaymentLine."Applies-to ID");
                    if CustLedgEntry.Find('-') then begin
                        CurrencyCode2 := CustLedgEntry."Currency Code";
                        if PaymentLine.Amount = 0 then begin
                            repeat
                                PaymentToleranceMgt.DelPmtTolApllnDocNoPayments(PaymentLine, CustLedgEntry."Document No.");
                                //CheckAgainstApplnCurrency(CurrencyCode2, CustLedgEntry."Currency Code", AccType::Customer, true);
                                CustLedgEntry.CalcFields("Remaining Amount");
                                CustLedgEntry."Remaining Amount" :=
                                  CurrExchRate.ExchangeAmount(
                                    CustLedgEntry."Remaining Amount",
                                    CustLedgEntry."Currency Code", CopyStr(PaymentRec.Currency, 1, 10), PaymentRec.Date);
                                CustLedgEntry."Remaining Amount" :=
                                  Round(CustLedgEntry."Remaining Amount", CurrencyRec."Amount Rounding Precision");
                                CustLedgEntry."Remaining Pmt. Disc. Possible" :=
                                  CurrExchRate.ExchangeAmount(
                                    CustLedgEntry."Remaining Pmt. Disc. Possible",
                                    CustLedgEntry."Currency Code", CopyStr(PaymentRec.Currency, 1, 10), PaymentRec.Date);
                                CustLedgEntry."Remaining Pmt. Disc. Possible" :=
                                  Round(CustLedgEntry."Remaining Pmt. Disc. Possible", CurrencyRec."Amount Rounding Precision");
                                CustLedgEntry."Amount to Apply" :=
                                  CurrExchRate.ExchangeAmount(
                                    CustLedgEntry."Amount to Apply",
                                    CustLedgEntry."Currency Code", CopyStr(PaymentRec.Currency, 1, 10), PaymentRec.Date);
                                CustLedgEntry."Amount to Apply" :=
                                  Round(CustLedgEntry."Amount to Apply", CurrencyRec."Amount Rounding Precision");
                                if PaymentToleranceMgt.CheckCalcPmtDiscPaymentsCust(Rec, CustLedgEntry, 0, false) and
                                   (Abs(CustLedgEntry."Amount to Apply") >=
                                    Abs(CustLedgEntry."Remaining Amount" - CustLedgEntry."Remaining Pmt. Disc. Possible"))
                                then
                                    PaymentLine.Amount := PaymentLine.Amount - (CustLedgEntry."Amount to Apply" - CustLedgEntry."Remaining Pmt. Disc. Possible")
                                else
                                    PaymentLine.Amount := Abs(PaymentLine.Amount - CustLedgEntry."Amount to Apply");
                            until CustLedgEntry.Next() = 0;
                            PaymentLine.Validate(Amount);
                        end else
                            repeat
                            //CheckAgainstApplnCurrency(CurrencyCode2, CustLedgEntry."Currency Code", AccType::Customer, true);
                            until CustLedgEntry.Next() = 0;
                        if PaymentRec.Currency <> CurrencyCode2 then
                            if PaymentLine.Amount = 0 then begin
                                if not
                                   Confirm(
                                     CurrencyChangeLbl +
                                     ConfirmContinueMsg, true,
                                     PaymentRec.FieldCaption(Currency), PaymentLine.TableCaption, PaymentRec.Currency,
                                     CustLedgEntry."Currency Code")
                                then
                                    Error(WarningLbl);
                                PaymentRec.Currency := CustLedgEntry."Currency Code"
                            end else
                                ;
                        //CheckAgainstApplnCurrency(PaymentRec.Currency, CustLedgEntry."Currency Code", AccType::Customer, true);
                        PaymentLine."Applies-to Doc Type" := PaymentLine."Applies-to Doc Type"::" ";
                        PaymentLine."Applies-to Doc. No." := '';
                    end else
                        PaymentLine."Applies-to ID" := '';
                    PaymentLine.Modify();
                    // Check Payment Tolerance
                    /* if  Rec.Amount <> 0 then
                       if not PaymentToleranceMgt.PmtTolGenJnl(GenJnlLine) then
                         exit;
                    */
                end;
            AccType::Vendor:
                begin
                    VendLedgEntry.SetRange("Applies-to ID");
                    VendLedgEntry.SetCurrentKey("Vendor No.", Open, Positive);
                    VendLedgEntry.SetRange("Vendor No.", AccNo);
                    VendLedgEntry.SetRange(Open, true);
                    VendLedgEntry.SetRange("On Hold", '');
                    if PaymentLine."Applies-to ID" = '' then
                        PaymentLine."Applies-to ID" := PaymentLine.No;
                    if PaymentLine."Applies-to ID" = '' then
                        Error(
                          MustSpecifyLbl,
                          PaymentRec.FieldCaption("No."), PaymentLine.FieldCaption("Applies-to ID"));
                    ApplyVendEntries.SetPaymentLine(PaymentLine, PaymentLine.FieldNo("Applies-to ID"));
                    ApplyVendEntries.SetRecord(VendLedgEntry);
                    ApplyVendEntries.SetTableView(VendLedgEntry);
                    ApplyVendEntries.LookupMode(true);
                    OK := ApplyVendEntries.RunModal() = Action::LookupOK;
                    Clear(ApplyVendEntries);
                    if not OK then
                        exit;
                    VendLedgEntry.Reset();
                    VendLedgEntry.SetCurrentKey("Vendor No.", Open, Positive);
                    VendLedgEntry.SetRange("Vendor No.", AccNo);
                    VendLedgEntry.SetRange(Open, true);
                    VendLedgEntry.SetRange("Applies-to ID", PaymentLine."Applies-to ID");
                    if VendLedgEntry.Find('-') then begin
                        PaymentLine."Vendor Invoice" := VendLedgEntry."Document No.";
                        // "Applies-to Doc. Type":=VendLedgEntry."Document Type";
                        PaymentLine.Modify();
                        CurrencyCode2 := VendLedgEntry."Currency Code";
                        if PaymentLine.Amount = 0 then begin
                            repeat
                                PaymentToleranceMgt.DelPmtTolApllnDocNoPayments(PaymentLine, VendLedgEntry."Document No.");
                                //CheckAgainstApplnCurrency(CurrencyCode2, VendLedgEntry."Currency Code", AccType::Vendor, true);
                                VendLedgEntry.CalcFields("Remaining Amount");
                                VendLedgEntry."Remaining Amount" :=
                                  CurrExchRate.ExchangeAmount(
                                    VendLedgEntry."Remaining Amount",
                                    VendLedgEntry."Currency Code", CopyStr(PaymentRec.Currency, 1, 10), PaymentRec.Date);
                                VendLedgEntry."Remaining Amount" :=
                                  Round(VendLedgEntry."Remaining Amount", CurrencyRec."Amount Rounding Precision");
                                VendLedgEntry."Remaining Pmt. Disc. Possible" :=
                                  CurrExchRate.ExchangeAmount(
                                    VendLedgEntry."Remaining Pmt. Disc. Possible",
                                    VendLedgEntry."Currency Code", CopyStr(PaymentRec.Currency, 1, 10), PaymentRec.Date);
                                VendLedgEntry."Remaining Pmt. Disc. Possible" :=
                                  Round(VendLedgEntry."Remaining Pmt. Disc. Possible", CurrencyRec."Amount Rounding Precision");
                                VendLedgEntry."Amount to Apply" :=
                                  CurrExchRate.ExchangeAmount(
                                    VendLedgEntry."Amount to Apply",
                                    VendLedgEntry."Currency Code", CopyStr(PaymentRec.Currency, 1, 10), PaymentRec.Date);
                                VendLedgEntry."Amount to Apply" :=
                                  Round(VendLedgEntry."Amount to Apply", CurrencyRec."Amount Rounding Precision");
                                if PaymentToleranceMgt.CheckCalcPmtDiscPaymentsVend(Rec, VendLedgEntry, 0, false) and
                                   (Abs(VendLedgEntry."Amount to Apply") >=
                                    Abs(VendLedgEntry."Remaining Amount" - VendLedgEntry."Remaining Pmt. Disc. Possible"))
                                then
                                    PaymentLine.Amount := PaymentLine.Amount - (VendLedgEntry."Amount to Apply" - VendLedgEntry."Remaining Pmt. Disc. Possible")
                                else
                                    PaymentLine.Amount := PaymentLine.Amount - VendLedgEntry."Amount to Apply";
                            until VendLedgEntry.Next() = 0;
                            PaymentLine.Validate(Amount);
                        end else
                            repeat
                            //CheckAgainstApplnCurrency(CurrencyCode2, VendLedgEntry."Currency Code", AccType::Vendor, true);
                            until VendLedgEntry.Next() = 0;
                        if PaymentRec.Currency <> CurrencyCode2 then
                            if PaymentLine.Amount = 0 then begin
                                if not
                                   Confirm(
                                     CurrencyChangeLbl +
                                     ConfirmContinueMsg, true,
                                     PaymentRec.FieldCaption(Currency), PaymentLine.TableCaption, PaymentRec.Currency,
                                     VendLedgEntry."Currency Code")
                                then
                                    Error(WarningLbl);
                                PaymentRec.Currency := VendLedgEntry."Currency Code"
                            end;
                        //CheckAgainstApplnCurrency(PaymentRec.Currency, VendLedgEntry."Currency Code", AccType::Vendor, true);
                        PaymentLine."Applies-to Doc Type" := PaymentLine."Applies-to Doc Type"::" ";
                        PaymentLine."Applies-to Doc. No." := '';
                    end else
                        PaymentLine."Applies-to ID" := '';
                    PaymentLine.Modify();
                    // Check Payment Tolerance
                    /*
                    if  Rec.Amount <> 0 then
                      if not PaymentToleranceMgt.PmtTolGenJnl(GenJnlLine) then
                        exit;
                    */
                end;
            else
                Error(
                  AccTypeErr,
                  PaymentLine.FieldCaption("Account Type"));
        end;
        Rec := PaymentLine;
    end;

    procedure ArchiveDocument(PayRec: Record Payments)
    begin
        PayRec.Status := PayRec.Status::Archived;
        PayRec.Modify();
    end;

    procedure CancelPostedCheque(CheckLedgerEntryRec: Record "Check Ledger Entry"; EntryType: Option Void,Cancel)
    var
        ChequeRegister: Record "Cheque Register";
        ChequeRegisterCopy: Record "Cheque Register";
        PmtRec: Record Payments;
        ChequeRegPage: Page "Cheque Register";
    begin
        if Confirm('Are you sure you want to %1 this cheque?', false, Format(EntryType)) then begin
            //Modify cheque as voided in cheque register
            ChequeRegister.Reset();
            ChequeRegister.SetRange("Cheque No.", CheckLedgerEntryRec."Check No.");
            ChequeRegister.SetRange("Bank Account No.", CheckLedgerEntryRec."Bank Account No.");
            if ChequeRegister.FindFirst() then begin
                case EntryType of
                    EntryType::Void:
                        begin
                            ChequeRegister."Entry Status" := ChequeRegister."Entry Status"::"Financially Voided";
                            ChequeRegister.Voided := true;
                            ChequeRegister."Voided By" := CopyStr(UserId, 1, MaxStrLen(ChequeRegister."Voided By"));
                            ChequeRegister."Void Date-Time" := CurrentDateTime;
                        end;
                    EntryType::Cancel:
                        begin
                            ChequeRegister."Entry Status" := ChequeRegister."Entry Status"::Cancelled;
                            ChequeRegister.Cancelled := true;
                            ChequeRegister."Cancelled By" := CopyStr(UserId, 1, MaxStrLen(ChequeRegister."Cancelled By"));
                            ChequeRegister."Cancelled Date-Time" := CurrentDateTime;
                        end;
                end;
                ChequeRegister.Modify();
            end;

            if Confirm('Do you want to issue a new cheque for this transaction?', false) then begin
                //Issue a new cheque
                Clear(ChequeRegPage);
                ChequeRegisterCopy.Reset();
                ChequeRegisterCopy.SetRange("Bank Account No.", CheckLedgerEntryRec."Bank Account No.");
                ChequeRegisterCopy.SetRange("Entry Status", ChequeRegisterCopy."Entry Status"::Printed);
                ChequeRegPage.SetTableView(ChequeRegisterCopy);
                ChequeRegPage.LookupMode(true);
                ChequeRegPage.Editable(false);
                Message('Kindly select a new cheque no. in the next window');
                if ChequeRegPage.RunModal() = Action::LookupOK then begin
                    ChequeRegPage.GetRecord(ChequeRegisterCopy);
                    if ChequeRegisterCopy."Cheque No." = '' then
                        Error('Kindly select a cheque no to proceed');

                    if Confirm('Do you want to issue cheque no. %1?', false, ChequeRegisterCopy."Cheque No.") then begin
                        CheckLedgerEntryRec."Check No." := ChequeRegisterCopy."Cheque No.";
                        CheckLedgerEntryRec.Modify();

                        ChequeRegisterCopy."Entry Status" := ChequeRegisterCopy."Entry Status"::Posted;
                        ChequeRegisterCopy.Issued := true;
                        ChequeRegisterCopy."Issued By" := CopyStr(UserId, 1, MaxStrLen(ChequeRegisterCopy."Issued By"));
                        ChequeRegisterCopy."Issued Doc No." := CheckLedgerEntryRec."Document No.";
                        ChequeRegisterCopy.Modify();
                    end;
                    Message('Cheque has been successfully canceled and a new cheque no. %1 has been issued', ChequeRegisterCopy."Cheque No.");

                    //Modify cheque no from PV
                    if PmtRec.Get(CheckLedgerEntryRec."Document No.") then begin
                        PmtRec."Cheque No" := ChequeRegisterCopy."Cheque No.";
                        PmtRec.Modify();
                    end;
                end;
                CheckLedgerEntryRec."Entry Status" := CheckLedgerEntryRec."Entry Status"::Voided;
                CheckLedgerEntryRec.Modify();
            end;
            case EntryType of
                EntryType::Void:
                    CheckLedgerEntryRec."Entry Status" := CheckLedgerEntryRec."Entry Status"::Voided;
                EntryType::Cancel:
                    CheckLedgerEntryRec."Entry Status" := CheckLedgerEntryRec."Entry Status"::Voided;
            end;
            CheckLedgerEntryRec.Modify();
        end;
    end;

    procedure CheckAgainstApplnCurrency(ApplnCurrencyCode: Code[10]; CompareCurrencyCode: Code[10]; AccnType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset"; Message: Boolean): Boolean
    var
        Currency: Record Currency;
        Currency2: Record Currency;
        PurchSetup: Record "Purchases & Payables Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        CurrencyAppln: Option No,EMU,All;
    begin
        if ApplnCurrencyCode = CompareCurrencyCode then
            exit(true);
        case AccnType of
            AccnType::Customer:
                begin
                    SalesSetup.Get();
                    CurrencyAppln := SalesSetup."Appln. between Currencies";
                    case CurrencyAppln of
                        CurrencyAppln::No:

                            if ApplnCurrencyCode <> CompareCurrencyCode then
                                if Message then
                                    Error(Text006)
                                else
                                    exit(false);
                        CurrencyAppln::EMU:
                            begin
                                GLSetup.Get();
                                if not Currency.Get(ApplnCurrencyCode) then
                                    Currency."EMU Currency" := GLSetup."EMU Currency";
                                if not Currency2.Get(CompareCurrencyCode) then
                                    Currency2."EMU Currency" := GLSetup."EMU Currency";
                                if not Currency."EMU Currency" or not Currency2."EMU Currency" then
                                    if Message then
                                        Error(Text007)
                                    else
                                        exit(false);
                            end;
                    end;
                end;
            AccnType::Vendor:
                begin
                    PurchSetup.Get();
                    CurrencyAppln := PurchSetup."Appln. between Currencies";
                    case CurrencyAppln of
                        CurrencyAppln::No:

                            if ApplnCurrencyCode <> CompareCurrencyCode then
                                if Message then
                                    Error(Text006)
                                else
                                    exit(false);
                        CurrencyAppln::EMU:
                            begin
                                GLSetup.Get();
                                if not Currency.Get(ApplnCurrencyCode) then
                                    Currency."EMU Currency" := GLSetup."EMU Currency";
                                if not Currency2.Get(CompareCurrencyCode) then
                                    Currency2."EMU Currency" := GLSetup."EMU Currency";
                                if not Currency."EMU Currency" or not Currency2."EMU Currency" then
                                    if Message then
                                        Error(Text007)
                                    else
                                        exit(false);
                            end;
                    end;
                end;
        end;
        exit(true);
    end;

    procedure CheckIfBalancing(JournalName: Code[40]; BatchName: Code[40])
    var
        GenJnlLine: Record "Gen. Journal Line";
        AmountBal: Decimal;
    begin
        GenJnlLine.Reset();
        GenJnlLine.SetRange("Journal Template Name", JournalName);
        GenJnlLine.SetRange("Journal Batch Name", BatchName);
        GenJnlLine.SetRange("Bal. Account No.", ' ');
        GenJnlLine.CalcSums("Amount (LCY)");
        AmountBal := GenJnlLine."Amount (LCY)";
        GenJnlLine.Reset();
        GenJnlLine.SetRange("Journal Template Name", JournalName);
        GenJnlLine.SetRange("Journal Batch Name", BatchName);
        GenJnlLine.SetFilter("Bal. Account No.", '');
        GenJnlLine.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
        if GenJnlLine.FindLast() then
            GenJnlLine."Amount (LCY)" := GenJnlLine."Amount (LCY)" - AmountBal;
        GenJnlLine.Validate("Amount (LCY)");
        GenJnlLine.Modify();
    end;

    procedure ConfirmPost(Prec: Record Payments)
    begin
        /*if not Prec.Apportion then
          begin
            if Confirm(ConfPostMsg,true) then begin
              Error(ProceedMsg);
            end;
          end;*/

        /* if (not Prec.Apportion) and (not Prec."No Apportion") then
            Error(ErrorMsg); */
    end;

    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
    var
        PrintExponent: Boolean;
        DecimalPosition: Decimal;
        Cents: Integer;
        Exponent: Integer;
        Hundreds: Integer;
        NoTextIndex: Integer;
        Ones: Integer;
        Tens: Integer;
    begin
        Clear(NoText);
        NoTextIndex := 1;
        NoText[1] := '****';
        if No < 1 then
            AddToNoText(NoText, NoTextIndex, PrintExponent, WText026)
        else
            for Exponent := 4 downto 1 do begin
                PrintExponent := false;
                Ones := No div Power(1000, Exponent - 1);
                Hundreds := Ones div 100;
                Tens := (Ones mod 100) div 10;
                Ones := Ones mod 10;
                if Hundreds > 0 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, WText027);
                end;
                if Tens >= 2 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    if Ones > 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                end else
                    if (Tens * 10 + Ones) > 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                if PrintExponent and (Exponent > 1) then
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                No := No - (Hundreds * 100 + Tens * 10 + Ones) * Power(1000, Exponent - 1);
            end;

        DecimalPosition := 100;
        Cents := No * DecimalPosition;
        if Cents <> 0 then begin
            AddToNoText(NoText, NoTextIndex, PrintExponent, WText028);
            AddToNoText(NoText, NoTextIndex, PrintExponent, (Format(No * DecimalPosition) + ' ' + CentsTxt));
        end;

        if CurrencyCode <> '' then
            AddToNoText(NoText, NoTextIndex, PrintExponent, CurrencyCode);

        /* if Cents = 0 then
                    AddToNoText(NoText, NoTextIndex, PrintExponent, '')
                else
                    if Cents <= 20 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, 'AND ' + OnesText[Cents] + ' ' + CentsTxt + ' ')
                    else begin
                        AddToNoText(NoText, NoTextIndex, PrintExponent, WText028 + ' ');// + ' CENTS ');
                        AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[(Cents mod 100) div 10]);
                        if Cents mod 10 <> 0 then
                            AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Cents mod 10] + ' ' + CentsTxt)
                        else
                            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ' + CentsTxt);
                    end; */

        /*AddToNoText(NoText,NoTextIndex,PrintExponent,WText028);
        DecimalPosition:=GetDecimalPosition;

        CentsValue:= No * DecimalPosition;

        //AddToNoText(NoText,NoTextIndex,PrintExponent,FORMAT(No * 100) + '/100');
        AddToNoText(NoText,NoTextIndex,PrintExponent,(Format(No * DecimalPosition)+' '+CentsTxt));
        if CurrencyCode <> '' then
          AddToNoText(NoText,NoTextIndex,PrintExponent,CurrencyCode);*/
    end;

    procedure GetCurrentAccountingPeriod(var PeriodStart: Date; var PeriodEnd: Date; CurrentDate: Date)
    var
        AccountingPeriod: Record "Accounting Period";
        AccountingPeriod2: Record "Accounting Period";
    begin
        AccountingPeriod.Reset();
        AccountingPeriod.SetFilter("Starting Date", '<%1', CurrentDate);
        AccountingPeriod.SetRange("New Fiscal Year", true);
        if AccountingPeriod.FindLast() then
            PeriodStart := AccountingPeriod."Starting Date";

        AccountingPeriod2.Reset();
        AccountingPeriod2.SetFilter("Starting Date", '>%1', CurrentDate);
        AccountingPeriod2.SetRange("New Fiscal Year", true);
        if AccountingPeriod2.FindLast() then
            PeriodEnd := CalcDate('<-1D>', AccountingPeriod2."Starting Date");
    end;

    procedure GetDecimalPosition(): Decimal
    var
        GenSetup: Record "General Ledger Setup";
        RoundPrecision: Decimal;
    begin
        if GenSetup."Amount Rounding Precision" = 0 then
            RoundPrecision := 0.01
        else
            RoundPrecision := GenSetup."Amount Rounding Precision";
        exit(1 / RoundPrecision);
    end;

    procedure GetEFTName(): Text
    var
        //FileSystem: Automation BC;
        CashSetup: Record "Cash Management Setups";
        EFTFileNaming: Record "EFT File Naming";
        PaymentMethod: Record "Payment Method";
        PaymentRec: Record Payments;
        EFTCount: Integer;
        EFTValue: Integer;
        FileName: Text;
        TodayText: Text;
        TodayTextFormatted: Text;
    begin
        CashSetup.Get();
        PaymentMethod.Reset();
        PaymentMethod.SetRange("Bal. Account Type", PaymentMethod."Bal. Account Type"::EFT);
        if PaymentMethod.FindFirst() then begin
            PaymentRec.Reset();
            PaymentRec.SetRange(PaymentRec."Payment Type", PaymentRec."Payment Type"::"Payment Voucher");
            PaymentRec.SetRange(PaymentRec."Pay Mode", PaymentMethod.Code);
            PaymentRec.SetRange(PaymentRec."EFT File Generated", true);
            PaymentRec.SetFilter(PaymentRec.Date, '=%1', Today);
            if PaymentRec.Find('-') then
                EFTCount := PaymentRec.Count
            else
                EFTCount := 0;
            EFTValue := EFTCount + 1;
            //EFT Naming
            EFTFileNaming.Reset();
            EFTFileNaming.SetRange(EFTFileNaming.Value, EFTValue);
            if EFTFileNaming.FindFirst() then begin
                TodayText := Format(Today);
                TodayTextFormatted := DelChr(TodayText, '=', '/');
                /*  Clear(FileSystem);
                 if Create(FileSystem, false, true) then begin
                     if not FileSystem.FolderExists(CashSetup."EFT Path") then
                         FileSystem.CreateFolder(CashSetup."EFT Path");
                 end; */
                FileName := CashSetup."EFT Path" + 'EFT ' + TodayTextFormatted + EFTFileNaming.Character + '.xlsx';
                exit(FileName);
            end else
                Error('No EFT Naming Setup Located');
        end;
    end;

    procedure GetPeriodEnd(CurrentDate: Date): Date
    var
        AccountingPeriod: Record "Accounting Period";
    begin
        AccountingPeriod.Reset();
        AccountingPeriod.SetFilter("Starting Date", '>%1', CurrentDate);
        AccountingPeriod.SetRange("New Fiscal Year", true);
        if AccountingPeriod.FindLast() then
            exit(AccountingPeriod."Starting Date");
    end;

    procedure GetPeriodStart(CurrentDate: Date): Date
    var
        AccountingPeriod: Record "Accounting Period";
    begin
        AccountingPeriod.Reset();
        AccountingPeriod.SetFilter("Starting Date", '<%1', CurrentDate);
        AccountingPeriod.SetRange("New Fiscal Year", true);
        if AccountingPeriod.FindLast() then
            exit(AccountingPeriod."Starting Date");
    end;

    procedure GetUserName(UserName: Text): Text
    var
        UserDetails: Record User;
    begin
        UserDetails.Reset();
        UserDetails.SetRange("User Name", UserName);
        if UserDetails.FindFirst() then
            if UserDetails."Full Name" <> '' then
                exit(UserDetails."Full Name")
            else
                exit(UserName);
    end;

    procedure InitTextVariable()
    begin
        OnesText[1] := WText032;
        OnesText[2] := WText033;
        OnesText[3] := WText034;
        OnesText[4] := WText035;
        OnesText[5] := WText036;
        OnesText[6] := WText037;
        OnesText[7] := WText038;
        OnesText[8] := WText039;
        OnesText[9] := WText040;
        OnesText[10] := WText041;
        OnesText[11] := WText042;
        OnesText[12] := WText043;
        OnesText[13] := WText044;
        OnesText[14] := WText045;
        OnesText[15] := WText046;
        OnesText[16] := WText047;
        OnesText[17] := WText048;
        OnesText[18] := WText049;
        OnesText[19] := WText050;
        TensText[1] := '';
        TensText[2] := WText051;
        TensText[3] := WText052;
        TensText[4] := WText053;
        TensText[5] := WText054;
        TensText[6] := WText055;
        TensText[7] := WText056;
        TensText[8] := WText057;
        TensText[9] := WText058;
        ExponentText[1] := '';
        ExponentText[2] := WText059;
        ExponentText[3] := WText060;
        ExponentText[4] := WText061;
    end;

    procedure IsAccountVotebookEntry(GLAccount: Code[20]): Boolean
    var
        GLAccountRec: Record "G/L Account";
    begin
        GLAccountRec.Reset();
        GLAccountRec.SetRange("No.", GLAccount);
        if GLAccountRec.FindFirst() then
            if GLAccountRec."Votebook Entry" then
                exit(true)
            else
                exit(false);
    end;

    procedure IsMedicalCeilingClaim(ClaimType: Code[50]): Boolean
    var
        ClaimTypes: Record "Receipts and Payment Types";
    begin
        ClaimTypes.Reset();
        ClaimTypes.SetRange(Code, ClaimType);
        ClaimTypes.SetRange(Type, ClaimTypes.Type::"Staff Claim");
        if ClaimTypes.FindFirst() then
            if ClaimTypes."Check Medical Ceiling" then
                exit(true)
            else
                exit(false);
    end;

    procedure NotifyPaymentsFundsReceipt(PayRec: Record Payments)
    var
        CashSetup: Record "Cash Management Setups";
        CompanyInfo: Record "Company Information";
        UserSetup: Record "User Setup";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        EmailBodyMsg: Label '<p style="font-family:Corbel,Corbel;font-size:10pt">Dear %1,<br><br></p><p style="font-family:Corbel,Corbel;font-size:10pt"> This is to inform your %2 No. %3 has been approved. </br><br>Kindly proceed to Confirm Receipt of Funds in the system. <br><br> Thank you.<br><br>Kind regards,<br><br><Strong>%4<Strong></p>', Comment = '%1 = Payee, %2 = Payment Type, %3 = Payment No., %4 = Sender Name';
        Recipient: List of [Text];
        FormattedBody: Text;
        SenderAddress: Text;
        SenderName: Text;
        Subject: Text;
    begin
        //Notify on approval
        if PayRec."Payment Type" in [PayRec."Payment Type"::Imprest,
                                // PayRec."Payment Type"::"Petty Cash",
                                PayRec."Payment Type"::"Staff Claim"] then
            if Confirm('Do you wish to notify payee to Confirm Receipt of Funds?', false) then begin
                CashSetup.Get();
                CompanyInfo.Get();
                CashSetup.TestField("Finance Email");
                PayRec.TestField(Cashier);
                UserSetup.Get(PayRec.Cashier);
                UserSetup.TestField("E-Mail");

                SenderAddress := CashSetup."Finance Email";
                SenderName := CompanyInfo.Name;
                Recipient.Add(UserSetup."E-Mail");
                Subject := 'Confirm Funds Receipt';
                FormattedBody := StrSubstNo(EmailBodyMsg, PayRec.Payee,
                                    Format(PayRec."Payment Type"), PayRec."No.",
                                    'Finance Department');
                EmailMessage.Create(Recipient, Subject, FormattedBody, true);
                Email.Send(EmailMessage);
                Message('Payee notified successfully');
            end;
    end;

    procedure PostImprest(var Imprest: Record Payments)
    var
        ChequeRegister: Record "Cheque Register";
        GLEntry: Record "G/L Entry";
        GenJnLine: Record "Gen. Journal Line";
        GLSetupRec: Record "General Ledger Setup";
        ImprestLines: Record "Payment Lines";
        PaymentMethod: Record "Payment Method";
        Commitment: Codeunit "Commitments Mgt Finance";
        ChequePmt: Boolean;
        DocNo: Code[20];
        ShortcutDimValue: array[8] of Code[20];
        LineNo: Integer;
        DimValueName: array[8] of Text;
    begin
        ChequePmt := false;

        if Confirm(Text002, false, Imprest."No.") = true then begin
            if Imprest.Status <> Imprest.Status::Released then
                Error(Text003, Imprest."No.");

            /* if not Imprest."Confirm Receipt" then
                Error(ConfirmFundsReceiptErr); */

            //Get batches
            CashOfficeUserTemplate.Get(UserId);
            JTemplate := CopyStr(CashOfficeUserTemplate."Imprest Template", 1, MaxStrLen(GenJnLine."Journal Template Name"));
            JBatch := CopyStr(Imprest."No.", 1, MaxStrLen(GenJnLine."Journal Batch Name"));// Temp."Imprest  Batch";

            if JTemplate = '' then
                Error('Ensure the Imprest Template is set up in Cash Office Setup');

            if JBatch = '' then
                Error('Ensure the Imprest Batch is set up in the Cash Office Setup');

            Imprest.TestField("Account No.");
            Imprest.TestField("Paying Bank Account");
            Imprest.TestField(Date);
            Imprest.TestField("Payment Release Date");
            Imprest.TestField("Pay Mode");
            PaymentMethod.Get(Imprest."Pay Mode");
            //Check Commitment
            ImprestLines.Reset();
            ImprestLines.SetRange(No, Imprest."No.");
            if ImprestLines.Find('-') then
                repeat
                    if IsAccountVotebookEntry(ImprestLines."Account No") then begin
                        Commitment.FetchDimValue(ImprestLines."Dimension Set ID", ShortcutDimValue, DimValueName);
                        GLSetupRec.Get();
                        //DimValue.GET(GLSetup."Shortcut Dimension 6 Code",ShortcutDimValue[6]);
                        //DimValueName:=DimValue.Name;
                        if (Commitment.IsAccountVotebookEntry(ImprestLines."Account No")) and not Commitment.LineCommitted(Imprest."No.", ImprestLines."Account No", ImprestLines."Line No") then
                            Error(Text019, ShortcutDimValue[1] + ' ' + DimValueName[1]);
                    end;
                until ImprestLines.Next() = 0;
            if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then begin
                Imprest.TestField("Cheque No");
                Imprest.TestField("Cheque Date");
                ChequePmt := true;
            end;
            //Check if the imprest Lines have been populated
            ImprestLines.SetRange(ImprestLines.No, Imprest."No.");
            if ImprestLines.IsEmpty() then
                Error(Text004);

            Imprest.CalcFields("Imprest Amount");
            if Imprest.Posted then
                Error(Text006, Imprest."No.");
            CMSetup.Get();

            // Delete Lines Present on the General Journal Line
            GenJnLine.Reset();
            GenJnLine.SetRange(GenJnLine."Journal Template Name", JTemplate);
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", JBatch);
            GenJnLine.DeleteAll();

            Batch.Init();
            if CMSetup.Get() then
                Batch."Journal Template Name" := JTemplate;
            Batch.Name := JBatch;
            if not Batch.Get(Batch."Journal Template Name", Batch.Name) then
                Batch.Insert();

            //Use separate no series for banks
            if CMSetup."Use Bank Pmt Doc Nos" then
                DocNo := NoSeriesMgt.GetNextNo(GetBankPaymentNoSeries(Imprest."Paying Bank Account"), 0D, true)
            else
                DocNo := Imprest."No.";

            LineNo := 1000;
            GenJnLine.Init();
            GenJnLine."Journal Template Name" := JTemplate;
            GenJnLine."Journal Batch Name" := JBatch;
            GenJnLine."Line No." := LineNo;
            GenJnLine."Account Type" := GenJnLine."Account Type"::"Bank Account";
            GenJnLine."Account No." := Imprest."Paying Bank Account";
            GenJnLine.Validate("Posting Date", Imprest."Payment Release Date");
            GenJnLine."Document No." := DocNo;
            if ChequePmt then
                GenJnLine."External Document No." := Imprest."Cheque No";
            //GenJnLine."Bank Payment Type" := GenJnLine."Bank Payment Type"::"Manual Check"; // this inserts check ledger entry
            GenJnLine.Description := CopyStr(Imprest.Payee, 1, MaxStrLen(GenJnLine.Description));
            GenJnLine.Amount := -Imprest."Imprest Amount";
            GenJnLine."Currency Code" := CopyStr(Imprest.Currency, 1, MaxStrLen(GenJnLine."Currency Code"));
            GenJnLine.Validate("Currency Code");
            GenJnLine.Validate(Amount);
            GenJnLine."Shortcut Dimension 1 Code" := Imprest."Shortcut Dimension 1 Code";
            GenJnLine.Validate("Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := Imprest."Shortcut Dimension 2 Code";
            GenJnLine.Validate("Shortcut Dimension 2 Code");
            GenJnLine."Dimension Set ID" := Imprest."Dimension Set ID";
            GenJnLine.Validate(GenJnLine."Dimension Set ID");
            GenJnLine."Bal. Account Type" := GenJnLine."Bal. Account Type"::Customer;
            GenJnLine."Bal. Account No." := Imprest."Account No.";
            GenJnLine.Validate("Bal. Account No.");
            GenJnLine.Payee := CopyStr(Imprest.Payee, 1, MaxStrLen(GenJnLine.Payee));
            if GenJnLine.Amount <> 0 then
                GenJnLine.Insert();
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnLine);
            GLEntry.Reset();
            GLEntry.SetRange(GLEntry."Document No.", DocNo);
            GLEntry.SetRange(GLEntry.Reversed, false);
            if not GLEntry.IsEmpty() then begin

                if Imprest."Cheque No" <> '' then begin
                    //Modify Check Ledger-cheque no.
                    CheckLedgerEntry.Reset();
                    CheckLedgerEntry.SetRange(CheckLedgerEntry."Check No.", Imprest."No.");
                    if CheckLedgerEntry.FindFirst() then begin
                        CheckLedgerEntry."Check No." := Imprest."Cheque No";
                        CheckLedgerEntry."Payments Mgt Generated" := true;
                        CheckLedgerEntry.Modify();
                    end;

                    //Modify Cheque as Posted in cheque register
                    if Imprest."Cheque Type" = Imprest."Cheque Type"::"Computer Check" then begin
                        ChequeRegister.Reset();
                        ChequeRegister.SetRange(ChequeRegister."Cheque No.", Imprest."Cheque No");
                        if ChequeRegister.FindFirst() then begin
                            ChequeRegister."Entry Status" := ChequeRegister."Entry Status"::Posted;
                            ChequeRegister."Cheque Date" := Imprest."Cheque Date";
                            ChequeRegister."Posted By" := CopyStr(UserId, 1, MaxStrLen(ChequeRegister."Posted By"));
                            ChequeRegister.Modify();
                        end;
                    end;
                end;
                //Encumber
                Commitment.EncumberImprest(Imprest);
                //Update the Imprest Deadline
                //   IF CMSetup."Imprest Due Date"<>DueDate THEN
                //   Imprest."Imprest Deadline":=CALCDATE(CMSetup."Imprest Due Date",TODAY);
                //   Imprest.MODIFY;
                Imprest.Posted := true;
                Imprest."Posted By" := CopyStr(UserId, 1, MaxStrLen(Imprest."Posted By"));
                Imprest."Posted Date" := Today;
                Imprest."Time Posted" := Time;
                Imprest."Posted Document No." := DocNo;
                Imprest.Modify();
            end;
        end;
    end;

    procedure "Post ImprestSurrender"(var Imprest: Record Payments)
    var
        GLEntry: Record "G/L Entry";
        GenJnLine: Record "Gen. Journal Line";
        ImprestLines: Record "Payment Lines";
        ImprestHeader: Record Payments;
        Commitment: Codeunit "Commitments Mgt Finance";
        LineNo: Integer;
    begin
        if Confirm(Text007, false, Imprest."No.") = true then begin
            if Imprest.Status <> Imprest.Status::Released then
                Error(Text008, Imprest."No.");
            Imprest.TestField("Imprest Issue Doc. No");
            Imprest.CalcFields("Imprest Amount", Imprest."Actual Amount Spent", "Cash Receipt Amount");
            if Imprest."Imprest Amount" = 0 then
                Error(Text005);
            // IF Imprest."Actual Amount Spent"=0 THEN
            //  ERROR(Text016);
            if Imprest.Surrendered then
                Error(Text013);

            if Imprest.Apportion then
                Apportionment.CheckApportionment(Imprest."No.");

            //Get surrender template
            CashOfficeUserTemplate.Get(UserId);
            JTemplate := CopyStr(CashOfficeUserTemplate."Imprest Sur Template", 1, MaxStrLen(JTemplate));
            JBatch := CopyStr(Imprest."No.", 1, MaxStrLen(GenJnLine."Journal Batch Name"));// Temp."Imprest Sur Batch";

            if JTemplate = '' then
                Error('Ensure the Imprest Surrender Template is set up in Cash Office Setup');

            if JBatch = '' then
                Error('Ensure the Imprest Surrender Batch is set up in the Cash Office Setup');

            CMSetup.Get();
            //CMSetup.TESTFIELD("Imprest Due Date");
            CMSetup.TestField(CMSetup."Imprest Surrender Template");
            // Delete Lines Present on the General Journal Line
            GenJnLine.Reset();
            GenJnLine.SetRange(GenJnLine."Journal Template Name", JTemplate);
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", JBatch);
            GenJnLine.DeleteAll();

            Batch.Init();
            if CMSetup.Get() then
                Batch."Journal Template Name" := JTemplate;
            Batch.Name := JBatch;
            if not Batch.Get(Batch."Journal Template Name", Batch.Name) then
                Batch.Insert();
            LineNo := LineNo + 1000;
            GenJnLine.Init();
            GenJnLine."Journal Template Name" := JTemplate;
            GenJnLine."Journal Batch Name" := JBatch;
            GenJnLine."Line No." := LineNo;
            GenJnLine."Account Type" := GenJnLine."Account Type"::Customer;
            GenJnLine."Account No." := Imprest."Account No.";
            GenJnLine.Validate("Posting Date", Imprest."Payment Release Date");
            GenJnLine."Document No." := Imprest."No.";
            GenJnLine."External Document No." := Imprest."Imprest Issue Doc. No";
            GenJnLine.Description := CopyStr('Imprest Surrendered by: ' + Imprest.Payee, 1, MaxStrLen(GenJnLine.Description));
            GenJnLine.Amount := -Imprest."Actual Amount Spent";
            GenJnLine."Currency Code" := CopyStr(Imprest.Currency, 1, MaxStrLen(GenJnLine."Currency Code"));
            GenJnLine.Validate("Currency Code");
            GenJnLine.Validate(Amount);
            GenJnLine."Shortcut Dimension 1 Code" := Imprest."Shortcut Dimension 1 Code";
            GenJnLine.Validate("Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := Imprest."Shortcut Dimension 2 Code";
            GenJnLine.Validate("Shortcut Dimension 2 Code");
            GenJnLine."Dimension Set ID" := Imprest."Dimension Set ID";
            GenJnLine.Validate(GenJnLine."Dimension Set ID");
            //  GenJnLine."VAT Bus. Posting Group":='LOCAL';
            // GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::" ";
            GenJnLine."Applies-to Doc. No." := CopyStr(GetImprestPostedPV(Imprest."Imprest Issue Doc. No"), 1, MaxStrLen(GenJnLine."Applies-to Doc. No."));
            GenJnLine.Validate("Currency Code");
            GenJnLine.Validate(Amount);
            GenJnLine.Validate(GenJnLine."Applies-to Doc. No.");
            GenJnLine.Payee := CopyStr(Imprest.Payee, 1, MaxStrLen(GenJnLine.Payee));
            if GenJnLine.Amount <> 0 then
                GenJnLine.Insert();
            /*// Post receipt or payment to  the customer
             LineNo:=LineNo+10000;
             GenJnLine.Init();
                if CMSetup.Get() then
             GenJnLine."Journal Template Name":=JTemplate;
             GenJnLine."Journal Batch Name":=Imprest."No.";
             GenJnLine."Line No.":=LineNo;
             GenJnLine."Account Type":=GenJnLine."Account Type"::Customer;
             GenJnLine."Account No.":=Imprest."Account No.";
             GenJnLine.Validate(GenJnLine."Account No.");
             GenJnLine."Posting Date":=Today;
             GenJnLine."Document No.":=Imprest."No.";
             GenJnLine."External Document No.":=Imprest."Cheque No";
             GenJnLine."Payment Method Code":=Imprest."Pay Mode";
             GenJnLine.Description:=Imprest."Account Name";
             GenJnLine.Amount:=(Imprest."Actual Amount Spent"-Imprest."Imprest Amount");
             GenJnLine."Currency Code":=Imprest.Currency;
             GenJnLine.Validate("Currency Code");
             GenJnLine.Validate(GenJnLine.Amount);
             GenJnLine."Bal. Account Type":=GenJnLine."Account Type"::"Bank Account";
             GenJnLine."Bal. Account No.":=Imprest."Paying Bank Account";
             GenJnLine.Validate("Bal. Account No.");
             GenJnLine."Shortcut Dimension 1 Code":=ImprestLines."Shortcut Dimension 1 Code";
             GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
             GenJnLine."Shortcut Dimension 2 Code":=ImprestLines."Shortcut Dimension 2 Code";
             GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
             GenJnLine."Dimension Set ID":=ImprestLines."Dimension Set ID";
             GenJnLine.Validate(GenJnLine."Dimension Set ID");
             //GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::" ";
             //GenJnLine."Applies-to Doc. No.":=Imprest."Imprest Issue Doc. No";
             GenJnLine.Validate(GenJnLine."Applies-to Doc. No.");
             if GenJnLine.Amount<0 then
             GenJnLine.Insert();*/
            //IMP surrender Lines Entries
            ImprestLines.Reset();
            ImprestLines.SetRange("Payment Type", Imprest."Payment Type");
            ImprestLines.SetRange(No, Imprest."No.");
            if ImprestLines.Find('-') then
                repeat
                    ImprestLines.Validate(ImprestLines.Amount);
                    ImprestLines.TestField(Purpose);
                    LineNo := LineNo + 10000;
                    GenJnLine.Init();
                    GenJnLine."Journal Template Name" := JTemplate;
                    GenJnLine."Journal Batch Name" := JBatch;
                    GenJnLine."Line No." := LineNo;
                    GenJnLine."Account Type" := ImprestLines."Account Type";
                    GenJnLine."Account No." := ImprestLines."Account No";
                    GenJnLine.Validate(GenJnLine."Account No.");
                    if Imprest."Surrender Date" = 0D then
                        Error('You must specify the surrender date');
                    GenJnLine.Validate("Posting Date", Imprest."Payment Release Date");
                    GenJnLine."Document No." := Imprest."No.";
                    //GenJnLine."External Document No.":=Imprest."Imprest Issue Doc. No";
                    GenJnLine.Description := CopyStr(ImprestLines.Purpose, 1, MaxStrLen(GenJnLine.Description));
                    GenJnLine.Amount := ImprestLines."Actual Spent";
                    GenJnLine."Currency Code" := CopyStr(Imprest.Currency, 1, MaxStrLen(GenJnLine."Currency Code"));
                    GenJnLine.Validate("Currency Code");
                    GenJnLine.Validate(GenJnLine.Amount);
                    GenJnLine."Shortcut Dimension 1 Code" := ImprestLines."Shortcut Dimension 1 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                    GenJnLine."Shortcut Dimension 2 Code" := ImprestLines."Shortcut Dimension 2 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                    GenJnLine."Dimension Set ID" := ImprestLines."Dimension Set ID";
                    GenJnLine.Validate(GenJnLine."Dimension Set ID");
                    GenJnLine.Payee := CopyStr(Imprest.Payee, 1, MaxStrLen(GenJnLine.Payee));
                    //GenJnLine."VAT Bus. Posting Group":='LOCAL';
                    //GenJnLine."Gen. Posting Type":=GenJnLine."Gen. Posting Type"::Sale;
                    if GenJnLine.Amount <> 0 then
                        GenJnLine.Insert();
                    if Imprest."Cash Receipt Amount" <> 0 then
                        //Receipt Lines Entries
                        if (ImprestLines."Cash Receipt Amount" <> 0) and (ImprestLines."Imprest Receipt No." = '') then begin
                            ImprestLines.TestField("Receiving Bank");
                            LineNo := LineNo + 10000;
                            GenJnLine.Init();
                            if CMSetup.Get() then
                                GenJnLine."Journal Template Name" := JTemplate;
                            GenJnLine."Journal Batch Name" := JBatch;
                            GenJnLine."Line No." := LineNo;
                            GenJnLine."Account Type" := GenJnLine."Account Type"::Customer;
                            GenJnLine."Account No." := Imprest."Account No.";
                            GenJnLine.Validate(GenJnLine."Account No.");
                            GenJnLine.Validate("Posting Date", Imprest."Payment Release Date");
                            GenJnLine."Document No." := Imprest."No.";
                            GenJnLine."External Document No." := Imprest."Cheque No";
                            GenJnLine."Payment Method Code" := CopyStr(Imprest."Pay Mode", 1, MaxStrLen(GenJnLine."Payment Method Code"));
                            GenJnLine.Description := Imprest."Account Name";
                            GenJnLine.Amount := -ImprestLines."Cash Receipt Amount";
                            GenJnLine."Currency Code" := CopyStr(Imprest.Currency, 1, MaxStrLen(GenJnLine."Currency Code"));
                            GenJnLine.Validate("Currency Code");
                            GenJnLine.Validate(GenJnLine.Amount);
                            GenJnLine."Bal. Account Type" := GenJnLine."Account Type"::"Bank Account";
                            GenJnLine."Bal. Account No." := ImprestLines."Receiving Bank";
                            GenJnLine.Validate("Bal. Account No.");
                            GenJnLine."Shortcut Dimension 1 Code" := ImprestLines."Shortcut Dimension 1 Code";
                            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                            GenJnLine."Shortcut Dimension 2 Code" := ImprestLines."Shortcut Dimension 2 Code";
                            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                            GenJnLine."Dimension Set ID" := ImprestLines."Dimension Set ID";
                            GenJnLine.Validate(GenJnLine."Dimension Set ID");
                            //GenJnLine."VAT Bus. Posting Group":='LOCAL';
                            //GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::" ";
                            GenJnLine."Applies-to Doc. No." := CopyStr(GetImprestPostedPV(Imprest."Imprest Issue Doc. No"), 1, MaxStrLen(GenJnLine."Applies-to Doc. No."));
                            GenJnLine.Validate(GenJnLine."Applies-to Doc. No.");
                            GenJnLine.Payee := CopyStr(Imprest.Payee, 1, MaxStrLen(GenJnLine.Payee));
                            if GenJnLine.Amount <> 0 then
                                GenJnLine.Insert();
                        end;
                until ImprestLines.Next() = 0;
            CheckIfBalancing(JTemplate, JBatch);
            GenJnLine.Reset();
            GenJnLine.SetRange(GenJnLine."Journal Template Name", JTemplate);
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", JBatch);
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnLine);
            GLEntry.Reset();
            GLEntry.SetRange(GLEntry."Document No.", Imprest."No.");
            GLEntry.SetRange(GLEntry.Reversed, false);
            if not GLEntry.IsEmpty() then begin
                Imprest.Posted := true;
                Imprest."Posted By" := CopyStr(UserId, 1, MaxStrLen(Imprest."Posted By"));
                Imprest."Posted Date" := Today;
                Imprest."Time Posted" := Time;
                Imprest.Surrendered := true;
                Imprest."Surrender Date" := Today;
                Imprest."Surrendered By" := CopyStr(UserId, 1, MaxStrLen(Imprest."Surrendered By"));
                Imprest."Posted Document No." := Imprest."No.";
                Imprest.Modify();
                //Create a Payment Voucher or Petty Cash if there's a receipted amount
                Imprest.CalcFields("Cash Receipt Amount", "Actual Amount Spent", "Imprest Amount");
                if Imprest."Actual Amount Spent" > Imprest."Imprest Amount" then
                    CreatePVPettyCash(Imprest);
                //Uncommit Entries made to the varoius expenses accounts
                Commitment.UnencumberImprest(Imprest);

                ImprestHeader.Reset();
                ImprestHeader.SetRange(ImprestHeader."No.", Imprest."Imprest Issue Doc. No");
                if ImprestHeader.Find('-') then begin
                    ImprestHeader.Surrendered := true;
                    ImprestHeader."Surrender Date" := Imprest."Surrender Date";
                    ImprestHeader."Surrendered By" := Imprest."Surrendered By";
                    ImprestHeader.Modify();
                end;

                if Imprest.Apportion then
                    Apportionment.CreatePaymentApportionEntry(Imprest);
            end;
        end;
    end;

    procedure PostInputTax(ReceiptRec: Record Payments)
    var
        CMSetupRec: Record "Cash Management Setups";
        GLEntry: Record "G/L Entry";
        GenJnLine: Record "Gen. Journal Line";
        RcptLines: Record "Payment Lines";
        PaymentMethod: Record "Payment Method";
        LineNo: Integer;
    begin
        if Confirm(Text017, false, ReceiptRec."No.") = true then begin
            if ReceiptRec.Posted then
                Error(Text018);

            ReceiptRec.TestField(Date);
            ReceiptRec.TestField("Pay Mode");

            if ReceiptRec."Payment Release Date" = 0D then
                Error('Please input posting date');

            if PaymentMethod.Get(ReceiptRec."Pay Mode") then;
            if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then begin
                ReceiptRec.TestField("Cheque No");
                ReceiptRec.TestField("Cheque Date");
            end;

            ReceiptRec.CalcFields("Receipt Amount");
            ReceiptRec.CalcFields("Imp Surr Receipt Amount");

            //Check Lines
            if ReceiptRec."Receipt Amount" = 0 then
                Error('Amount cannot be zero');

            RcptLines.Reset();
            RcptLines.SetRange(No, ReceiptRec."No.");
            if not RcptLines.FindLast() then
                Error('Receipt Lines cannot be empty');

            CMSetupRec.Get();
            // Delete Lines Present on the General Journal Line
            GenJnLine.Reset();
            GenJnLine.SetRange(GenJnLine."Journal Template Name", CMSetupRec."Receipt Template");
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", ReceiptRec."No.");
            GenJnLine.DeleteAll();

            Batch.Init();
            if CMSetupRec.Get() then
                Batch."Journal Template Name" := CopyStr(CMSetupRec."Receipt Template", 1, MaxStrLen(Batch."Journal Template Name"));
            Batch.Name := CopyStr(ReceiptRec."No.", 1, MaxStrLen(Batch.Name));
            if not Batch.Get(Batch."Journal Template Name", ReceiptRec."No.") then
                Batch.Insert();

            //Header Entries
            LineNo := LineNo + 10000;
            RcptLines.Reset();
            RcptLines.SetRange(No, ReceiptRec."No.");
            RcptLines.Validate(Amount);
            RcptLines.CalcSums(Amount);
            GenJnLine.Init();
            if CMSetupRec.Get() then
                GenJnLine."Journal Template Name" := CopyStr(CMSetupRec."Receipt Template", 1, MaxStrLen(GenJnLine."Journal Template Name"));
            GenJnLine."Journal Batch Name" := CopyStr(ReceiptRec."No.", 1, MaxStrLen(GenJnLine."Journal Batch Name"));
            GenJnLine."Line No." := LineNo;
            GenJnLine."Account Type" := ReceiptRec."Account Type";
            GenJnLine."Account No." := ReceiptRec."Account No.";
            GenJnLine.Validate(GenJnLine."Account No.");
            if ReceiptRec.Date = 0D then
                Error('You must specify the Receipt date');
            GenJnLine.Validate("Posting Date", ReceiptRec."Payment Release Date");
            GenJnLine."Document No." := ReceiptRec."No.";
            GenJnLine."External Document No." := ReceiptRec."Cheque No";
            GenJnLine."Payment Method Code" := CopyStr(ReceiptRec."Pay Mode", 1, MaxStrLen(GenJnLine."Payment Method Code"));
            GenJnLine.Description := CopyStr(ReceiptRec."Payment Narration", 1, MaxStrLen(GenJnLine.Description));
            GenJnLine.Amount := ReceiptRec."Receipt Amount";
            GenJnLine."Currency Code" := CopyStr(ReceiptRec.Currency, 1, MaxStrLen(GenJnLine."Currency Code"));
            GenJnLine.Validate("Currency Code");
            GenJnLine.Validate(GenJnLine.Amount);
            GenJnLine."Shortcut Dimension 1 Code" := ReceiptRec."Shortcut Dimension 1 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := ReceiptRec."Shortcut Dimension 2 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
            GenJnLine.Payee := CopyStr(ReceiptRec.Payee, 1, MaxStrLen(GenJnLine.Payee));
            if GenJnLine.Amount <> 0 then
                GenJnLine.Insert();

            //Receipt Lines Entries
            RcptLines.Reset();
            RcptLines.SetRange(No, ReceiptRec."No.");
            if RcptLines.FindFirst() then
                repeat
                    RcptLines.Validate(RcptLines.Amount);
                    LineNo := LineNo + 10000;
                    GenJnLine.Init();
                    if CMSetupRec.Get() then
                        GenJnLine."Journal Template Name" := CopyStr(CMSetupRec."Receipt Template", 1, MaxStrLen(GenJnLine."Journal Template Name"));
                    GenJnLine."Journal Batch Name" := CopyStr(ReceiptRec."No.", 1, MaxStrLen(GenJnLine."Journal Batch Name"));
                    GenJnLine."Line No." := LineNo;
                    GenJnLine."Account Type" := RcptLines."Account Type";
                    GenJnLine."Account No." := RcptLines."Account No";
                    GenJnLine.Validate(GenJnLine."Account No.");
                    GenJnLine.Validate("Posting Date", ReceiptRec."Payment Release Date");
                    GenJnLine."Document No." := ReceiptRec."No.";
                    GenJnLine."External Document No." := ReceiptRec."Cheque No";
                    GenJnLine."Payment Method Code" := CopyStr(ReceiptRec."Pay Mode", 1, MaxStrLen(GenJnLine."Payment Method Code"));
                    GenJnLine.Description := CopyStr(RcptLines.Description, 1, MaxStrLen(GenJnLine.Description));
                    GenJnLine.Amount := -RcptLines.Amount;
                    GenJnLine."Currency Code" := CopyStr(ReceiptRec.Currency, 1, MaxStrLen(GenJnLine."Currency Code"));
                    GenJnLine.Validate("Currency Code");
                    GenJnLine.Validate(GenJnLine.Amount);
                    GenJnLine."Shortcut Dimension 1 Code" := RcptLines."Shortcut Dimension 1 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                    GenJnLine."Shortcut Dimension 2 Code" := RcptLines."Shortcut Dimension 2 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                    GenJnLine."Dimension Set ID" := RcptLines."Dimension Set ID";
                    GenJnLine."Gen. Posting Type" := RcptLines."Gen. Posting Type";
                    GenJnLine."Applies-to Doc. No." := RcptLines."Applies-to Doc. No.";
                    GenJnLine.Validate(GenJnLine."Applies-to Doc. No.");
                    GenJnLine."Applies-to ID" := RcptLines."Applies-to ID";
                    GenJnLine.Payee := CopyStr(ReceiptRec.Payee, 1, MaxStrLen(GenJnLine.Payee));
                    if GenJnLine.Amount <> 0 then
                        GenJnLine.Insert();
                until RcptLines.Next() = 0;

            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnLine);
            GLEntry.Reset();
            GLEntry.SetRange(GLEntry."Document No.", ReceiptRec."No.");
            GLEntry.SetRange(GLEntry.Reversed, false);
            if not GLEntry.IsEmpty() then begin
                ReceiptRec.Posted := true;
                ReceiptRec."Posted Date" := Today;
                ReceiptRec."Time Posted" := Time;
                ReceiptRec."Posted By" := CopyStr(UserId, 1, MaxStrLen(ReceiptRec."Posted By"));
                ReceiptRec."Posted Document No." := ReceiptRec."No.";
                ReceiptRec.Modify();
            end;
        end;
    end;

    procedure PostInterBank(InterBank: Record Payments; Preview: Boolean)
    var
        CMSetupRec: Record "Cash Management Setups";
        GLEntry: Record "G/L Entry";
        GenJnLine: Record "Gen. Journal Line";
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        AmountLCY: Decimal;
        LineNo: Integer;
    begin
        if Confirm('Are you sure you want to post the Bank Transfer No. ' + InterBank."No." + ' ?') = true then begin
            if InterBank.Status <> InterBank.Status::Released then
                Error('The Bank Transfer No %1 has not been fully approved', InterBank."No.");
            if InterBank.Posted then
                Error('Bank Transfer %1 has been posted', InterBank."No.");

            //Get batches
            CashOfficeUserTemplate.Get(UserId);
            JTemplate := CopyStr(CashOfficeUserTemplate."Inter Bank Template Name", 1, MaxStrLen(JTemplate));
            JBatch := CopyStr(InterBank."No.", 1, MaxStrLen(GenJnLine."Journal Batch Name"));// Temp."Inter Bank Batch Name";

            if JTemplate = '' then
                Error('Ensure the Petty Cash Template is set up in Cash Office Setup');

            if JBatch = '' then
                Error('Ensure the Petty Cash Batch is set up in the Cash Office Setup');

            InterBank.TestField(Date);
            InterBank.TestField("Payment Release Date");
            InterBank.TestField("Exchange Rate");

            // IF InterBank."Receiving Amount LCY"<>InterBank."Source Amount LCY" THEN
            //  ERROR('Receiving Amount of %3.%1 must be same as Source Amount %4.%2',InterBank."Receiving Bank Amount",InterBank."Source Bank Amount",InterBank.Currency,InterBank."Source Currency");
            //Check Amounts
            InterBank.CalcFields("Petty Cash Amount");
            if InterBank."Receiving Bank Amount" = 0 then
                Error('Amount cannot be zero');
            if InterBank."Receiving Amount LCY" <> InterBank."Source Amount LCY" then
                Error('Please make sure both Receiving and Source Amounts are the same');
            CMSetupRec.Get();

            // Delete Lines Present on the General Journal Line
            GenJnLine.Reset();
            GenJnLine.SetRange(GenJnLine."Journal Template Name", JTemplate);
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", JBatch);
            GenJnLine.DeleteAll();

            Batch.Init();
            if CMSetupRec.Get() then
                Batch."Journal Template Name" := JTemplate;
            Batch.Name := JBatch;
            if not Batch.Get(Batch."Journal Template Name", Batch.Name) then
                Batch.Insert();

            AmountLCY := 0;

            //Source Bank Entries
            LineNo := LineNo + 10000;
            GenJnLine.Init();
            if CMSetupRec.Get() then
                GenJnLine."Journal Template Name" := JTemplate;
            GenJnLine."Journal Batch Name" := JBatch;
            GenJnLine."Line No." := LineNo;
            GenJnLine."Account Type" := GenJnLine."Account Type"::"Bank Account";
            GenJnLine."Account No." := InterBank."Source Bank";
            GenJnLine.Validate(GenJnLine."Account No.");
            if InterBank.Date = 0D then
                Error('You must specify the InterBank date');
            //  GenJnLine."Posting Date":=TODAY;
            GenJnLine."Posting Date" := InterBank."Payment Release Date";
            GenJnLine."Document No." := InterBank."No.";
            GenJnLine."External Document No." := InterBank."Cheque No";
            GenJnLine."Payment Method Code" := CopyStr(InterBank."Pay Mode", 1, MaxStrLen(GenJnLine."Payment Method Code"));
            GenJnLine.Description := CopyStr(InterBank."Payment Narration", 1, MaxStrLen(GenJnLine.Description));//'Inter Bank Transfer to '+InterBank."Account No."+' Bank';
            GenJnLine.Amount := -InterBank."Source Bank Amount";
            GenJnLine."Currency Code" := InterBank."Source Currency";
            GenJnLine.Validate("Currency Code");
            GenJnLine."Currency Factor" := 1 / InterBank."Exchange Rate";
            GenJnLine.Validate(GenJnLine.Amount);
            AmountLCY := GenJnLine."Amount (LCY)";
            GenJnLine."Shortcut Dimension 1 Code" := InterBank."Shortcut Dimension 1 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := InterBank."Shortcut Dimension 2 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
            GenJnLine."Dimension Set ID" := InterBank."Dimension Set ID";
            GenJnLine.Validate(GenJnLine."Dimension Set ID");
            GenJnLine.Payee := CopyStr(InterBank.Payee, 1, MaxStrLen(GenJnLine.Payee));
            if GenJnLine.Amount <> 0 then
                GenJnLine.Insert();

            //Receiving Bank Entries
            LineNo := LineNo + 10000;
            GenJnLine.Init();
            if CMSetupRec.Get() then
                GenJnLine."Journal Template Name" := JTemplate;
            GenJnLine."Journal Batch Name" := JBatch;
            GenJnLine."Line No." := LineNo;
            GenJnLine."Account Type" := GenJnLine."Account Type"::"Bank Account";
            GenJnLine."Account No." := InterBank."Account No.";
            GenJnLine.Validate(GenJnLine."Account No.");
            if InterBank.Date = 0D then
                Error('You must specify the InterBank date');
            GenJnLine."Posting Date" := InterBank."Payment Release Date";
            GenJnLine."Document No." := InterBank."No.";
            GenJnLine."External Document No." := InterBank."Cheque No";
            GenJnLine."Payment Method Code" := CopyStr(InterBank."Pay Mode", 1, MaxStrLen(GenJnLine."Payment Method Code"));
            GenJnLine.Description := CopyStr(InterBank."Payment Narration", 1, MaxStrLen(GenJnLine.Description));
            GenJnLine.Amount := InterBank."Receiving Bank Amount";
            GenJnLine."Currency Code" := CopyStr(InterBank.Currency, 1, MaxStrLen(GenJnLine."Currency Code"));
            GenJnLine.Validate("Currency Code");
            GenJnLine."Currency Factor" := 1 / InterBank."Exchange Rate";
            GenJnLine.Validate(GenJnLine.Amount);
            GenJnLine."Amount (LCY)" := Abs(AmountLCY);
            GenJnLine."Shortcut Dimension 1 Code" := InterBank."Shortcut Dimension 1 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := InterBank."Shortcut Dimension 2 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
            GenJnLine."Dimension Set ID" := InterBank."Dimension Set ID";
            GenJnLine.Validate(GenJnLine."Dimension Set ID");
            GenJnLine.Payee := CopyStr(InterBank.Payee, 1, MaxStrLen(GenJnLine.Payee));
            if GenJnLine.Amount <> 0 then
                GenJnLine.Insert();

            //End of Posting
            if Preview then begin
                Commit();
                GenJnlPost.Preview(GenJnLine);
            end else
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnLine);

            GLEntry.Reset();
            GLEntry.SetRange(GLEntry."Document No.", InterBank."No.");
            GLEntry.SetRange(GLEntry.Reversed, false);
            if not GLEntry.IsEmpty() then begin
                InterBank.Posted := true;
                InterBank."Posted By" := CopyStr(UserId, 1, MaxStrLen(InterBank."Posted By"));
                InterBank."Posted Date" := Today;
                InterBank."Time Posted" := Time;
                InterBank."Posted Document No." := InterBank."No.";
                InterBank.Modify();
            end;
        end;
    end;

    procedure PostInterBankMultiple(InterBank: Record Payments; Preview: Boolean)
    var
        CMSetupRec: Record "Cash Management Setups";
        GLEntry: Record "G/L Entry";
        GenJnLine: Record "Gen. Journal Line";
        InterBankLines: Record "Payment Lines";
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        LineNo: Integer;
    begin
        if Confirm('Are you sure you want to post the Bank Transfer No. ' + InterBank."No." + ' ?') = true then begin
            if InterBank.Status <> InterBank.Status::Released then
                Error('The Bank Transfer No %1 has not been fully approved', InterBank."No.");
            if InterBank.Posted then
                Error('Bank Transfer %1 has been posted', InterBank."No.");

            //Get batches
            CashOfficeUserTemplate.Get(UserId);
            JTemplate := CopyStr(CashOfficeUserTemplate."Inter Bank Template Name", 1, MaxStrLen(JTemplate));
            JBatch := CopyStr(InterBank."No.", 1, MaxStrLen(GenJnLine."Journal Batch Name"));// Temp."Inter Bank Batch Name";

            if JTemplate = '' then
                Error('Ensure the InterBank Template is set up in Cash Office Setup');

            if JBatch = '' then
                Error('Ensure the InterBank Batch is set up in the Cash Office Setup');

            InterBank.TestField(Date);

            if InterBank."Payment Release Date" = 0D then
                Error('Please enter posting date');

            //Check Amounts
            InterBank.CalcFields("Petty Cash Amount", "Petty Cash Amount (LCY)");

            if InterBank."Source Bank Amount" = 0 then
                Error('Source Amount cannot be zero');

            if InterBank."Petty Cash Amount (LCY)" <> InterBank."Source Amount LCY" then
                Error('Please make sure both Total Receiving and Source Bank Amounts are the same');

            CMSetupRec.Get();

            // Delete Lines Present on the General Journal Line
            GenJnLine.Reset();
            GenJnLine.SetRange(GenJnLine."Journal Template Name", JTemplate);
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", JBatch);
            GenJnLine.DeleteAll();

            Batch.Init();
            if CMSetupRec.Get() then
                Batch."Journal Template Name" := JTemplate;
            Batch.Name := JBatch;
            if not Batch.Get(Batch."Journal Template Name", Batch.Name) then
                Batch.Insert();

            //Source Bank Entries
            LineNo := LineNo + 10000;
            GenJnLine.Init();
            if CMSetupRec.Get() then
                GenJnLine."Journal Template Name" := JTemplate;
            GenJnLine."Journal Batch Name" := JBatch;
            GenJnLine."Line No." := LineNo;
            GenJnLine."Account Type" := GenJnLine."Account Type"::"Bank Account";
            GenJnLine."Account No." := InterBank."Source Bank";
            GenJnLine.Validate(GenJnLine."Account No.");
            if InterBank.Date = 0D then
                Error('You must specify the InterBank date');
            //  GenJnLine."Posting Date":=TODAY;
            GenJnLine.Validate("Posting Date", InterBank."Payment Release Date");
            GenJnLine."Document No." := InterBank."No.";
            GenJnLine."External Document No." := InterBank."Cheque No";
            GenJnLine."Payment Method Code" := CopyStr(InterBank."Pay Mode", 1, MaxStrLen(GenJnLine."Payment Method Code"));
            GenJnLine.Description := CopyStr(InterBank."Payment Narration", 1, MaxStrLen(GenJnLine.Description));//'Inter Bank Transfer to '+InterBank."Account No."+' Bank';
            GenJnLine.Amount := -InterBank."Source Bank Amount";
            GenJnLine."Currency Code" := InterBank."Source Currency";
            GenJnLine.Validate("Currency Code");
            GenJnLine.Validate(GenJnLine.Amount);
            GenJnLine."Shortcut Dimension 1 Code" := InterBank."Shortcut Dimension 1 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := InterBank."Shortcut Dimension 2 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
            GenJnLine."Dimension Set ID" := InterBank."Dimension Set ID";
            GenJnLine.Validate(GenJnLine."Dimension Set ID");
            GenJnLine.Payee := CopyStr(InterBank.Payee, 1, MaxStrLen(GenJnLine.Payee));
            if GenJnLine.Amount <> 0 then
                GenJnLine.Insert();

            InterBankLines.SetRange(No, InterBank."No.");
            if InterBankLines.Find('-') then
                repeat
                    //Receiving Bank Entries
                    LineNo := LineNo + 10000;
                    GenJnLine.Init();
                    if CMSetupRec.Get() then
                        GenJnLine."Journal Template Name" := JTemplate;
                    GenJnLine."Journal Batch Name" := JBatch;
                    GenJnLine."Line No." := LineNo;
                    GenJnLine."Account Type" := GenJnLine."Account Type"::"Bank Account";
                    GenJnLine."Account No." := InterBankLines."Account No";
                    GenJnLine.Validate(GenJnLine."Account No.");
                    if InterBank.Date = 0D then
                        Error('You must specify the InterBank date');
                    GenJnLine.Validate("Posting Date", InterBank."Payment Release Date");
                    GenJnLine."Document No." := InterBank."No.";
                    GenJnLine."External Document No." := InterBank."Cheque No";
                    GenJnLine."Payment Method Code" := CopyStr(InterBank."Pay Mode", 1, MaxStrLen(GenJnLine."Payment Method Code"));
                    GenJnLine.Description := CopyStr(InterBank."Payment Narration", 1, MaxStrLen(GenJnLine.Description));//'Inter Bank Transfer from '+InterBank."Source Bank"+' Bank';
                    GenJnLine.Amount := InterBankLines.Amount;
                    GenJnLine."Currency Code" := CopyStr(InterBankLines.Currency, 1, MaxStrLen(GenJnLine."Currency Code"));
                    GenJnLine.Validate("Currency Code");
                    GenJnLine.Validate(GenJnLine.Amount);
                    GenJnLine.Validate("Amount (LCY)", Abs(InterBankLines."Amount (LCY)"));
                    GenJnLine."Shortcut Dimension 1 Code" := InterBank."Shortcut Dimension 1 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                    GenJnLine."Shortcut Dimension 2 Code" := InterBank."Shortcut Dimension 2 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                    GenJnLine."Dimension Set ID" := InterBank."Dimension Set ID";
                    GenJnLine.Validate(GenJnLine."Dimension Set ID");
                    GenJnLine.Payee := CopyStr(InterBank.Payee, 1, MaxStrLen(GenJnLine.Payee));
                    if GenJnLine.Amount <> 0 then
                        GenJnLine.Insert();
                until InterBankLines.Next() = 0;

            //End of Posting
            if Preview then begin
                Commit();
                GenJnlPost.Preview(GenJnLine);
            end else
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnLine);

            GLEntry.Reset();
            GLEntry.SetRange(GLEntry."Document No.", InterBank."No.");
            GLEntry.SetRange(GLEntry.Reversed, false);
            if not GLEntry.IsEmpty() then begin
                InterBank.Posted := true;
                InterBank."Posted By" := CopyStr(UserId, 1, MaxStrLen(InterBank."Posted By"));
                InterBank."Posted Date" := Today;
                InterBank."Time Posted" := Time;
                InterBank."Posted Document No." := InterBank."No.";
                InterBank.Modify();
            end;
        end;
    end;

    procedure "Post Payment Voucher"(PV: Record Payments; Preview: Boolean)
    var
        CMSetupRec: Record "Cash Management Setups";
        ChequeRegister: Record "Cheque Register";
        Customer: Record Customer;
        GLAccount: Record "G/L Account";
        GLEntry: Record "G/L Entry";
        GenJnLine: Record "Gen. Journal Line";
        PVLines: Record "Payment Lines";
        PaymentMethod: Record "Payment Method";
        ImprestRec: Record Payments;
        VATSetup: Record "VAT Posting Setup";
        Vendor: Record Vendor;
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        DocNo: Code[20];
        PVDate: Date;
        BalAccType: Enum "Payment Balance Account Type";
        LineNo: Integer;
    begin
        if Confirm('Are you sure you want to post the Payment Voucher No. ' + PV."No." + '?', false) then begin

            CashOfficeUserTemplate.Get(UserId);
            JTemplate := CopyStr(CashOfficeUserTemplate."Payment Journal Template", 1, MaxStrLen(JTemplate));
            JBatch := CopyStr(PV."No.", 1, MaxStrLen(GenJnLine."Journal Batch Name"));// Temp."Payment Journal Batch";

            if JTemplate = '' then
                Error('Ensure the PV Template is set up in Cash Office Setup');

            if JBatch = '' then
                Error('Ensure the PV Batch is set up in the Cash Office Setup');

            if not Preview then
                if PV.Status <> PV.Status::Released then
                    Error('The Payment Voucher No %1 has not been fully approved', PV."No.");

            if PV.Posted then
                Error('Payment Voucher %1 has been posted', PV."No.");
            PV.TestField(Date);
            PV.TestField("Paying Bank Account");
            PV.TestField(PV.Payee);
            PV.TestField(PV."Pay Mode");
            //PV.TestField("Responsibility Center");
            if PaymentMethod.Get(PV."Pay Mode") then
                BalAccType := PaymentMethod."Bal. Account Type";

            /*case BalAccType of
              BalAccType::EFT:
                PVDate:=PV."EFT Date";
              BalAccType::Cheque:
                PVDate:=PV."Cheque Date";
              BalAccType::RTGS:
                PVDate:=PV."RTGS Date";
              else
                PVDate:=PV.Date;
            end;*/
            if PV."Payment Release Date" = 0D then
                Error('Please input posting date');
            PVDate := PV."Payment Release Date";

            PaymentMethod.Get(PV."Pay Mode");
            if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then begin
                PV.TestField(PV."Cheque No");
                PV.TestField(PV."Cheque Date");
            end;
            PaymentMethod.Get(PV."Pay Mode");
            if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::EFT then begin
                PV.TestField(PV."EFT Date");
                PV.TestField(PV."EFT Reference");
            end;
            PaymentMethod.Get(PV."Pay Mode");
            if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::RTGS then
                PV.TestField(PV."RTGS Date");

            //Check Lines
            PV.CalcFields("Total Amount");
            if PV."Total Amount" = 0 then
                Error('Amount is cannot be zero');
            PVLines.Reset();
            PVLines.SetRange(PVLines.No, PV."No.");
            if not PVLines.FindLast() then
                Error('Payment voucher Lines cannot be empty');

            CMSetupRec.Get();
            CMSetupRec.TestField("Payment Voucher Template");

            //Use separate no series for banks
            if CMSetupRec."Use Bank Pmt Doc Nos" then
                DocNo := NoSeriesMgt.GetNextNo(GetBankPaymentNoSeries(PV."Paying Bank Account"), 0D, true)
            else
                DocNo := PV."No.";

            // Delete Lines Present on the General Journal Line
            GenJnLine.Reset();
            GenJnLine.SetRange(GenJnLine."Journal Template Name", JTemplate);
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", JBatch);
            GenJnLine.DeleteAll();

            Batch.Init();
            if CMSetupRec.Get() then
                Batch."Journal Template Name" := JTemplate;
            Batch.Name := JBatch;
            if not Batch.Get(Batch."Journal Template Name", Batch.Name) then
                Batch.Insert();

            //Bank Entries
            /* LineNo := LineNo + 10000;
            PV.CalcFields(PV."Total Amount", "Total Net Amount");
            GenJnLine.Init();
            if CMSetupRec.Get() then
                GenJnLine."Journal Template Name" := JTemplate;
            GenJnLine."Journal Batch Name" := JBatch;
            GenJnLine."Line No." := LineNo;
            GenJnLine."Account Type" := GenJnLine."Account Type"::"Bank Account";
            GenJnLine."Account No." := PV."Paying Bank Account";
            GenJnLine.Validate(GenJnLine."Account No.");
            if PV.Date = 0D then
                Error('You must specify the PV date');
            GenJnLine.Validate("Posting Date", PVDate);
            GenJnLine."Document No." := DocNo;//PV."No.";
            if ChequePayment then
                GenJnLine."External Document No." := PV."Cheque No";
            //GenJnLine."Bank Payment Type" := GenJnLine."Bank Payment Type"::"Manual Check"; // this inserts check ledger entry
            GenJnLine.Description := CopyStr(PV."Payment Narration" + '-' + PV.Payee, 1, MaxStrLen(GenJnLine.Description));
            GenJnLine.Amount := -PV."Total Net Amount";
            GenJnLine."Currency Code" := CopyStr(PV.Currency, 1, MaxStrLen(GenJnLine."Currency Code"));
            GenJnLine.Validate(GenJnLine."Currency Code");
            GenJnLine.Validate(GenJnLine.Amount);
            GenJnLine."Shortcut Dimension 1 Code" := PV."Shortcut Dimension 1 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := PV."Shortcut Dimension 2 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
            if BalAccType = BalAccType::EFT then
                GenJnLine."EFT Reference" := PV."EFT Reference";
            if GenJnLine.Amount <> 0 then
                GenJnLine.Insert(); */

            //PV Lines Entries
            PVLines.Reset();
            PVLines.SetRange(PVLines.No, PV."No.");
            if PVLines.FindFirst() then
                repeat
                    if PVLines."Levied Invoice H" = true then
                        PVLines.Validate(PVLines.Amount);
                    LineNo := LineNo + 10000;
                    GenJnLine.Init();
                    if CMSetupRec.Get() then
                        GenJnLine."Journal Template Name" := JTemplate;
                    GenJnLine."Journal Batch Name" := JBatch;
                    GenJnLine."Line No." := LineNo;
                    GenJnLine."Account Type" := PVLines."Account Type";
                    GenJnLine."Account No." := PVLines."Account No";
                    GenJnLine.Validate(GenJnLine."Account No.");
                    if PV.Date = 0D then
                        Error('You must specify the PV date');
                    GenJnLine.Validate("Posting Date", PVDate);
                    GenJnLine."Document No." := DocNo;//PV."No.";
                    GenJnLine."External Document No." := PV."Cheque No";
                    GenJnLine.Description := CopyStr(PVLines.Description + '-' + PV.Payee, 1, MaxStrLen(GenJnLine.Description));
                    GenJnLine.Amount := PVLines."Net Amount";
                    GenJnLine."Currency Code" := CopyStr(PV.Currency, 1, MaxStrLen(GenJnLine."Currency Code"));
                    GenJnLine.Validate(GenJnLine."Currency Code");
                    GenJnLine.Validate(GenJnLine.Amount);
                    GenJnLine."Applies-to Doc. Type" := GenJnLine."Applies-to Doc. Type"::Invoice;
                    GenJnLine."Applies-to Doc. No." := PVLines."Applies-to Doc. No.";
                    GenJnLine.Validate(GenJnLine."Applies-to Doc. No.");
                    GenJnLine."Applies-to ID" := PVLines."Applies-to ID";
                    GenJnLine."Gen. Posting Type" := PVLines."Gen. Posting Type";
                    GenJnLine.Validate("Bal. Account Type", GenJnLine."Account Type"::"Bank Account");
                    GenJnLine.Validate("Bal. Account No.", PV."Paying Bank Account");
                    GenJnLine."Shortcut Dimension 1 Code" := PVLines."Shortcut Dimension 1 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                    GenJnLine."Shortcut Dimension 2 Code" := PVLines."Shortcut Dimension 2 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                    GenJnLine."Dimension Set ID" := PVLines."Dimension Set ID";
                    GenJnLine.Validate(GenJnLine."Dimension Set ID");
                    if BalAccType = BalAccType::EFT then
                        GenJnLine."EFT Reference" := PV."EFT Reference";
                    GenJnLine.Payee := CopyStr(PV.Payee, 1, MaxStrLen(GenJnLine.Payee));
                    if GenJnLine.Amount <> 0 then
                        GenJnLine.Insert();

                    //Post VAT
                    if CMSetupRec."Post VAT" then
                        if PVLines."VAT Code" <> '' then begin
                            LineNo := LineNo + 10000;
                            GenJnLine.Init();
                            if CMSetupRec.Get() then
                                GenJnLine."Journal Template Name" := JTemplate;
                            GenJnLine."Journal Batch Name" := JBatch;
                            GenJnLine."Line No." := LineNo;
                            GenJnLine."Account Type" := PVLines."Account Type";
                            GenJnLine."Account No." := PVLines."Account No";
                            GenJnLine.Validate(GenJnLine."Account No.");
                            if PV.Date = 0D then
                                Error('You must specify the PV date');
                            GenJnLine.Validate("Posting Date", PVDate);
                            GenJnLine."Document No." := DocNo;//PV."No.";
                            GenJnLine."External Document No." := PV."Cheque No";
                            GenJnLine.Description := CopyStr(PVLines.Description + ' VAT-' + PV.Payee, 1, MaxStrLen(GenJnLine.Description));
                            GenJnLine.Amount := PVLines."VAT Amount";
                            GenJnLine."Currency Code" := CopyStr(PV.Currency, 1, MaxStrLen(GenJnLine."Currency Code"));
                            GenJnLine.Validate(GenJnLine."Currency Code");
                            GenJnLine.Validate(GenJnLine.Amount);
                            //Set these fields to blanks
                            GenJnLine."Gen. Posting Type" := GenJnLine."Gen. Posting Type"::" ";
                            GenJnLine.Validate("Gen. Posting Type");
                            GenJnLine."Gen. Bus. Posting Group" := '';
                            GenJnLine.Validate("Gen. Bus. Posting Group");
                            GenJnLine."Gen. Prod. Posting Group" := '';
                            GenJnLine.Validate("Gen. Prod. Posting Group");
                            GenJnLine."VAT Bus. Posting Group" := '';
                            GenJnLine.Validate("VAT Bus. Posting Group");
                            GenJnLine."VAT Prod. Posting Group" := '';
                            GenJnLine.Validate("VAT Prod. Posting Group");
                            //
                            GenJnLine."Shortcut Dimension 1 Code" := PVLines."Shortcut Dimension 1 Code";
                            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                            GenJnLine."Shortcut Dimension 2 Code" := PVLines."Shortcut Dimension 2 Code";
                            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                            GenJnLine."Dimension Set ID" := PVLines."Dimension Set ID";
                            GenJnLine.Validate(GenJnLine."Dimension Set ID");
                            GenJnLine.Payee := CopyStr(PV.Payee, 1, MaxStrLen(GenJnLine.Payee));
                            //GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::Invoice;
                            //GenJnLine."Applies-to Doc. No.":=PVLines."Applies to Doc. No";
                            //GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");
                            if GenJnLine.Amount <> 0 then
                                GenJnLine.Insert();
                            LineNo := LineNo + 10000;
                            GenJnLine.Init();
                            if CMSetupRec.Get() then
                                GenJnLine."Journal Template Name" := JTemplate;
                            GenJnLine."Journal Batch Name" := JBatch;
                            GenJnLine."Line No." := LineNo;
                            GenJnLine."Account Type" := GenJnLine."Account Type"::"G/L Account";
                            case PVLines."Account Type" of
                                PVLines."Account Type"::"G/L Account":
                                    begin
                                        GLAccount.Get(PVLines."Account No");
                                        GLAccount.TestField("VAT Bus. Posting Group");
                                        if VATSetup.Get(GLAccount."VAT Bus. Posting Group", PVLines."VAT Code") then
                                            GenJnLine."Account No." := VATSetup."Purchase VAT Account";
                                        GenJnLine.Validate(GenJnLine."Account No.");
                                    end;
                                PVLines."Account Type"::Vendor:
                                    begin
                                        Vendor.Get(PVLines."Account No");
                                        Vendor.TestField("VAT Bus. Posting Group");
                                        if VATSetup.Get(Vendor."VAT Bus. Posting Group", PVLines."VAT Code") then
                                            GenJnLine."Account No." := VATSetup."Purchase VAT Account";
                                        GenJnLine.Validate(GenJnLine."Account No.");
                                    end;
                                PVLines."Account Type"::Customer:
                                    begin
                                        Customer.Get(PVLines."Account No");
                                        Customer.TestField("VAT Bus. Posting Group");
                                        if VATSetup.Get(Customer."VAT Bus. Posting Group", PVLines."VAT Code") then
                                            GenJnLine."Account No." := VATSetup."Purchase VAT Account";
                                        GenJnLine.Validate(GenJnLine."Account No.");
                                    end;
                            end;
                            if PV.Date = 0D then
                                Error('You must specify the PV date');
                            GenJnLine.Validate("Posting Date", PVDate);
                            GenJnLine."Document No." := DocNo;//PV."No.";
                            GenJnLine."External Document No." := PV."Cheque No";
                            GenJnLine.Description := CopyStr(PVLines.Description + ' VAT-' + PV.Payee, 1, MaxStrLen(GenJnLine.Description));
                            GenJnLine.Amount := -PVLines."VAT Amount";
                            GenJnLine."Currency Code" := CopyStr(PV.Currency, 1, MaxStrLen(GenJnLine."Currency Code"));
                            GenJnLine.Validate(GenJnLine."Currency Code");
                            GenJnLine.Validate(GenJnLine.Amount);
                            //Set these fields to blanks
                            GenJnLine."Gen. Posting Type" := GenJnLine."Gen. Posting Type"::" ";
                            GenJnLine.Validate("Gen. Posting Type");
                            GenJnLine."Gen. Bus. Posting Group" := '';
                            GenJnLine.Validate("Gen. Bus. Posting Group");
                            GenJnLine."Gen. Prod. Posting Group" := '';
                            GenJnLine.Validate("Gen. Prod. Posting Group");
                            GenJnLine."VAT Bus. Posting Group" := '';
                            GenJnLine.Validate("VAT Bus. Posting Group");
                            GenJnLine."VAT Prod. Posting Group" := '';
                            GenJnLine.Validate("VAT Prod. Posting Group");
                            //
                            GenJnLine."Shortcut Dimension 1 Code" := PVLines."Shortcut Dimension 1 Code";
                            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                            GenJnLine."Shortcut Dimension 2 Code" := PVLines."Shortcut Dimension 2 Code";
                            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                            GenJnLine."Dimension Set ID" := PVLines."Dimension Set ID";
                            GenJnLine.Validate(GenJnLine."Dimension Set ID");
                            GenJnLine.Payee := CopyStr(PV.Payee, 1, MaxStrLen(GenJnLine.Payee));
                            //GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::Invoice;
                            //GenJnLine."Applies-to Doc. No.":=PVLines."Applies to Doc. No";
                            //GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");
                            if GenJnLine.Amount <> 0 then
                                GenJnLine.Insert();
                        end;
                    //End of Posting VAT
                    //Post Withholding Tax
                    if PVLines."W/Tax Code" <> '' then begin
                        //PVLines.VALIDATE(PVLines.Amount);
                        LineNo := LineNo + 10000;
                        GenJnLine.Init();
                        if CMSetupRec.Get() then
                            GenJnLine."Journal Template Name" := JTemplate;
                        GenJnLine."Journal Batch Name" := JBatch;
                        GenJnLine."Line No." := LineNo;
                        GenJnLine."Account Type" := PVLines."Account Type";
                        GenJnLine."Account No." := PVLines."Account No";
                        GenJnLine.Validate(GenJnLine."Account No.");
                        if PV.Date = 0D then
                            Error('You must specify the PV date');
                        GenJnLine.Validate("Posting Date", PVDate);
                        GenJnLine."Document No." := DocNo;//PV."No.";
                        GenJnLine."External Document No." := PV."Cheque No";
                        GenJnLine.Description := CopyStr(PVLines.Description + ' W/Tax-' + PV.Payee, 1, MaxStrLen(GenJnLine.Description));
                        GenJnLine.Amount := PVLines."W/Tax Amount";
                        GenJnLine."Currency Code" := CopyStr(PV.Currency, 1, MaxStrLen(GenJnLine."Currency Code"));
                        GenJnLine.Validate(GenJnLine."Currency Code");
                        GenJnLine.Validate(GenJnLine.Amount);
                        //Set these fields to blanks
                        GenJnLine."Gen. Posting Type" := GenJnLine."Gen. Posting Type"::" ";
                        GenJnLine.Validate("Gen. Posting Type");
                        GenJnLine."Gen. Bus. Posting Group" := '';
                        GenJnLine.Validate("Gen. Bus. Posting Group");
                        GenJnLine."Gen. Prod. Posting Group" := '';
                        GenJnLine.Validate("Gen. Prod. Posting Group");
                        GenJnLine."VAT Bus. Posting Group" := '';
                        GenJnLine.Validate("VAT Bus. Posting Group");
                        GenJnLine."VAT Prod. Posting Group" := '';
                        GenJnLine.Validate("VAT Prod. Posting Group");
                        //
                        GenJnLine."Shortcut Dimension 1 Code" := PVLines."Shortcut Dimension 1 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                        GenJnLine."Shortcut Dimension 2 Code" := PVLines."Shortcut Dimension 2 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                        GenJnLine."Dimension Set ID" := PVLines."Dimension Set ID";
                        GenJnLine.Validate(GenJnLine."Dimension Set ID");
                        GenJnLine.Payee := CopyStr(PV.Payee, 1, MaxStrLen(GenJnLine.Payee));
                        //GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::Invoice;
                        //GenJnLine."Applies-to Doc. No.":=PVLines."Applies to Doc. No";
                        //GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");
                        if GenJnLine.Amount <> 0 then
                            GenJnLine.Insert();
                        LineNo := LineNo + 10000;
                        GenJnLine.Init();
                        if CMSetupRec.Get() then
                            GenJnLine."Journal Template Name" := JTemplate;
                        GenJnLine."Journal Batch Name" := JBatch;
                        GenJnLine."Line No." := LineNo;
                        GenJnLine."Account Type" := GenJnLine."Account Type"::"G/L Account";
                        case PVLines."Account Type" of
                            PVLines."Account Type"::"G/L Account":
                                begin
                                    GLAccount.Get(PVLines."Account No");
                                    GLAccount.TestField("VAT Bus. Posting Group");
                                    if VATSetup.Get(GLAccount."VAT Bus. Posting Group", PVLines."W/Tax Code") then
                                        GenJnLine."Account No." := VATSetup."Purchase VAT Account";
                                    GenJnLine.Validate(GenJnLine."Account No.");
                                end;
                            PVLines."Account Type"::Vendor:
                                begin
                                    Vendor.Get(PVLines."Account No");
                                    Vendor.TestField("VAT Bus. Posting Group");
                                    if VATSetup.Get(Vendor."VAT Bus. Posting Group", PVLines."W/Tax Code") then
                                        GenJnLine."Account No." := VATSetup."Purchase VAT Account";
                                    GenJnLine.Validate(GenJnLine."Account No.");
                                end;
                            PVLines."Account Type"::Customer:
                                begin
                                    Customer.Get(PVLines."Account No");
                                    Customer.TestField("VAT Bus. Posting Group");
                                    if VATSetup.Get(Customer."VAT Bus. Posting Group", PVLines."W/Tax Code") then
                                        GenJnLine."Account No." := VATSetup."Purchase VAT Account";
                                    GenJnLine.Validate(GenJnLine."Account No.");
                                end;
                        end;
                        if PV.Date = 0D then
                            Error('You must specify the PV date');
                        GenJnLine.Validate("Posting Date", PVDate);
                        GenJnLine."Document No." := DocNo;//PV."No.";
                        GenJnLine."External Document No." := PV."Cheque No";
                        GenJnLine.Description := CopyStr(PVLines.Description + ' W/Tax-' + PV.Payee, 1, MaxStrLen(GenJnLine.Description));
                        GenJnLine.Amount := -PVLines."W/Tax Amount";
                        GenJnLine."Currency Code" := CopyStr(PV.Currency, 1, MaxStrLen(GenJnLine."Currency Code"));
                        GenJnLine.Validate(GenJnLine."Currency Code");
                        GenJnLine.Validate(GenJnLine.Amount);
                        //Set these fields to blanks
                        GenJnLine."Gen. Posting Type" := GenJnLine."Gen. Posting Type"::" ";
                        GenJnLine.Validate("Gen. Posting Type");
                        GenJnLine."Gen. Bus. Posting Group" := '';
                        GenJnLine.Validate("Gen. Bus. Posting Group");
                        GenJnLine."Gen. Prod. Posting Group" := '';
                        GenJnLine.Validate("Gen. Prod. Posting Group");
                        GenJnLine."VAT Bus. Posting Group" := '';
                        GenJnLine.Validate("VAT Bus. Posting Group");
                        GenJnLine."VAT Prod. Posting Group" := '';
                        GenJnLine.Validate("VAT Prod. Posting Group");
                        //
                        GenJnLine."Shortcut Dimension 1 Code" := PVLines."Shortcut Dimension 1 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                        GenJnLine."Shortcut Dimension 2 Code" := PVLines."Shortcut Dimension 2 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                        GenJnLine."Dimension Set ID" := PVLines."Dimension Set ID";
                        GenJnLine.Validate(GenJnLine."Dimension Set ID");
                        GenJnLine.Payee := CopyStr(PV.Payee, 1, MaxStrLen(GenJnLine.Payee));
                        //GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::Invoice;
                        //GenJnLine."Applies-to Doc. No.":=PVLines."Applies to Doc. No";
                        //GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");
                        if GenJnLine.Amount <> 0 then
                            GenJnLine.Insert();
                    end;
                    //End of Posting Withholding Tax
                    //Post Withholding VAT
                    if PVLines."W/T VAT Code" <> '' then begin
                        //PVLines.VALIDATE(PVLines.Amount);
                        LineNo := LineNo + 10000;
                        GenJnLine.Init();
                        if CMSetupRec.Get() then
                            GenJnLine."Journal Template Name" := JTemplate;
                        GenJnLine."Journal Batch Name" := JBatch;
                        GenJnLine."Line No." := LineNo;
                        GenJnLine."Account Type" := PVLines."Account Type";
                        GenJnLine."Account No." := PVLines."Account No";
                        GenJnLine.Validate(GenJnLine."Account No.");
                        if PV.Date = 0D then
                            Error('You must specify the PV date');
                        GenJnLine.Validate("Posting Date", PVDate);
                        GenJnLine."Document No." := DocNo;//PV."No.";
                        GenJnLine."External Document No." := PV."Cheque No";
                        GenJnLine.Description := CopyStr(PVLines.Description + ' W/Tax VAT-' + PV.Payee, 1, MaxStrLen(GenJnLine.Description));
                        GenJnLine.Amount := PVLines."W/T VAT Amount";
                        GenJnLine."Currency Code" := CopyStr(PV.Currency, 1, MaxStrLen(GenJnLine."Currency Code"));
                        GenJnLine.Validate(GenJnLine."Currency Code");
                        GenJnLine.Validate(GenJnLine.Amount);
                        //Set these fields to blanks
                        GenJnLine."Gen. Posting Type" := GenJnLine."Gen. Posting Type"::" ";
                        GenJnLine.Validate("Gen. Posting Type");
                        GenJnLine."Gen. Bus. Posting Group" := '';
                        GenJnLine.Validate("Gen. Bus. Posting Group");
                        GenJnLine."Gen. Prod. Posting Group" := '';
                        GenJnLine.Validate("Gen. Prod. Posting Group");
                        GenJnLine."VAT Bus. Posting Group" := '';
                        GenJnLine.Validate("VAT Bus. Posting Group");
                        GenJnLine."VAT Prod. Posting Group" := '';
                        GenJnLine.Validate("VAT Prod. Posting Group");
                        //
                        GenJnLine."Shortcut Dimension 1 Code" := PVLines."Shortcut Dimension 1 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                        GenJnLine."Shortcut Dimension 2 Code" := PVLines."Shortcut Dimension 2 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                        GenJnLine."Dimension Set ID" := PVLines."Dimension Set ID";
                        GenJnLine.Validate(GenJnLine."Dimension Set ID");
                        GenJnLine.Payee := CopyStr(PV.Payee, 1, MaxStrLen(GenJnLine.Payee));
                        //GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::Invoice;
                        //GenJnLine."Applies-to Doc. No.":=PVLines."Applies to Doc. No";
                        //GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");
                        if GenJnLine.Amount <> 0 then
                            GenJnLine.Insert();
                        LineNo := LineNo + 10000;
                        GenJnLine.Init();
                        if CMSetupRec.Get() then
                            GenJnLine."Journal Template Name" := JTemplate;
                        GenJnLine."Journal Batch Name" := JBatch;
                        GenJnLine."Line No." := LineNo;
                        GenJnLine."Account Type" := GenJnLine."Account Type"::"G/L Account";
                        case PVLines."Account Type" of
                            PVLines."Account Type"::"G/L Account":
                                begin
                                    GLAccount.Get(PVLines."Account No");
                                    GLAccount.TestField("VAT Bus. Posting Group");
                                    if VATSetup.Get(GLAccount."VAT Bus. Posting Group", PVLines."W/T VAT Code") then
                                        GenJnLine."Account No." := VATSetup."Purchase VAT Account";
                                    GenJnLine.Validate(GenJnLine."Account No.");
                                end;
                            PVLines."Account Type"::Vendor:
                                begin
                                    Vendor.Get(PVLines."Account No");
                                    Vendor.TestField("VAT Bus. Posting Group");
                                    if VATSetup.Get(Vendor."VAT Bus. Posting Group", PVLines."W/T VAT Code") then
                                        GenJnLine."Account No." := VATSetup."Purchase VAT Account";
                                    GenJnLine.Validate(GenJnLine."Account No.");
                                end;
                            PVLines."Account Type"::Customer:
                                begin
                                    Customer.Get(PVLines."Account No");
                                    Customer.TestField("VAT Bus. Posting Group");
                                    if VATSetup.Get(Customer."VAT Bus. Posting Group", PVLines."W/T VAT Code") then
                                        GenJnLine."Account No." := VATSetup."Purchase VAT Account";
                                    GenJnLine.Validate(GenJnLine."Account No.");
                                end;
                        end;
                        if PV.Date = 0D then
                            Error('You must specify the PV date');
                        GenJnLine.Validate("Posting Date", PVDate);
                        GenJnLine."Document No." := DocNo;//PV."No.";
                        GenJnLine."External Document No." := PV."Cheque No";
                        GenJnLine.Description := CopyStr(PVLines.Description + ' W/Tax VAT-' + PV.Payee, 1, MaxStrLen(GenJnLine.Description));
                        GenJnLine.Amount := -PVLines."W/T VAT Amount";
                        GenJnLine."Currency Code" := CopyStr(PV.Currency, 1, MaxStrLen(GenJnLine."Currency Code"));
                        GenJnLine.Validate(GenJnLine."Currency Code");
                        GenJnLine.Validate(GenJnLine.Amount);
                        //Set these fields to blanks
                        GenJnLine."Gen. Posting Type" := GenJnLine."Gen. Posting Type"::" ";
                        GenJnLine.Validate("Gen. Posting Type");
                        GenJnLine."Gen. Bus. Posting Group" := '';
                        GenJnLine.Validate("Gen. Bus. Posting Group");
                        GenJnLine."Gen. Prod. Posting Group" := '';
                        GenJnLine.Validate("Gen. Prod. Posting Group");
                        GenJnLine."VAT Bus. Posting Group" := '';
                        GenJnLine.Validate("VAT Bus. Posting Group");
                        GenJnLine."VAT Prod. Posting Group" := '';
                        GenJnLine.Validate("VAT Prod. Posting Group");
                        //
                        GenJnLine."Shortcut Dimension 1 Code" := PVLines."Shortcut Dimension 1 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                        GenJnLine."Shortcut Dimension 2 Code" := PVLines."Shortcut Dimension 2 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                        GenJnLine."Dimension Set ID" := PVLines."Dimension Set ID";
                        GenJnLine.Validate(GenJnLine."Dimension Set ID");
                        GenJnLine.Payee := CopyStr(PV.Payee, 1, MaxStrLen(GenJnLine.Payee));
                        //GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::Invoice;
                        //GenJnLine."Applies-to Doc. No.":=PVLines."Applies to Doc. No";
                        //GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");
                        if GenJnLine.Amount <> 0 then
                            GenJnLine.Insert();
                    end;
                //End of Posting Withholding VAT
                until PVLines.Next() = 0;

            if Preview then begin
                Commit();
                GenJnlPost.Preview(GenJnLine);
            end else
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnLine);

            GLEntry.Reset();
            GLEntry.SetRange(GLEntry."Document No.", DocNo);
            GLEntry.SetRange(GLEntry.Reversed, false);
            if not GLEntry.IsEmpty() then begin
                PV.Posted := true;
                PV."Posted By" := CopyStr(UserId, 1, MaxStrLen(PV."Posted By"));
                PV."Posted Date" := Today;
                PV."Time Posted" := Time;
                PV."Posted Document No." := DocNo;
                PV.Modify();
                if PV."Cheque No" <> '' then begin
                    //Modify Check Ledger-cheque no.
                    CheckLedgerEntry.Reset();
                    CheckLedgerEntry.SetRange(CheckLedgerEntry."Check No.", PV."No.");
                    if CheckLedgerEntry.FindFirst() then begin
                        CheckLedgerEntry."Check No." := PV."Cheque No";
                        CheckLedgerEntry."Payments Mgt Generated" := true;
                        CheckLedgerEntry.Modify();
                    end;

                    //Modify Cheque as Posted in cheque register
                    if PV."Cheque Type" = PV."Cheque Type"::"Computer Check" then begin
                        ChequeRegister.Reset();
                        ChequeRegister.SetRange(ChequeRegister."Cheque No.", PV."Cheque No");
                        if ChequeRegister.FindFirst() then begin
                            ChequeRegister."Entry Status" := ChequeRegister."Entry Status"::Posted;
                            ChequeRegister."Cheque Date" := PV."Cheque Date";
                            ChequeRegister."Posted By" := CopyStr(UserId, 1, MaxStrLen(ChequeRegister."Posted By"));
                            ChequeRegister.Modify();
                        end;
                    end;
                end;

                //Modify imprest as posted if Imprests are posted using a PV
                PVLines.Reset();
                PVLines.SetRange(No, PV."No.");
                PVLines.SetFilter("Imprest No.", '<>%1', '');
                if PVLines.FindSet() then
                    repeat
                        if ImprestRec.Get(PVLines."Imprest No.") then begin
                            ImprestRec.Posted := true;
                            ImprestRec."Posted By" := CopyStr(UserId, 1, MaxStrLen(ImprestRec."Posted By"));
                            ImprestRec."Posted Date" := Today;
                            ImprestRec."Time Posted" := Time;
                            ImprestRec."Imprest Posted by PV" := PV."No.";
                            ImprestRec.Modify();
                            Committment.UncommitImprest(ImprestRec);
                            Committment.EncumberImprest(ImprestRec);
                        end;
                    until PVLines.Next() = 0;

                //Uncommit PV
                Committment.UncommitPV(PV);

                //Apportion Inter-Company Expenses
                if PV.Apportion then
                    Apportionment.CreatePaymentApportionEntry(PV);
            end;
        end;
    end;

    procedure PostPettyCash(PCASH: Record Payments; Preview: Boolean)
    var
        CMSetupRec: Record "Cash Management Setups";
        GLEntry: Record "G/L Entry";
        GenJnLine: Record "Gen. Journal Line";
        GLSetupRec: Record "General Ledger Setup";
        PCASHLines: Record "Payment Lines";
        PaymentMethod: Record "Payment Method";
        Commitment: Codeunit "Commitments Mgt Finance";
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        DocNo: Code[20];
        ShortcutDimValue: array[8] of Code[20];
        LineNo: Integer;
        DimValueName: array[8] of Text;
    begin
        if PCASH.Status <> PCASH.Status::Released then
            Error('The Petty Cash Voucher No %1 has not been fully approved', PCASH."No.");
        if PCASH.Posted then
            Error('Petty Cash Voucher %1 has been posted', PCASH."No.");

        //Get batches
        CashOfficeUserTemplate.Get(UserId);
        JTemplate := CopyStr(CashOfficeUserTemplate."Petty Cash Template", 1, MaxStrLen(JTemplate));
        JBatch := CopyStr(PCASH."No.", 1, MaxStrLen(GenJnLine."Journal Batch Name"));// Temp."Petty Cash Batch";

        if JTemplate = '' then
            Error('Ensure the Petty Cash Template is set up in Cash Office Setup');

        if JBatch = '' then
            Error('Ensure the Petty Cash Batch is set up in the Cash Office Setup');

        PCASH.TestField(Date);
        PCASH.TestField("Paying Bank Account");
        //PCASH.TESTFIELD(PCASH.Payee);
        PCASH.TestField(PCASH."Pay Mode");
        if PCASH."Payment Release Date" = 0D then
            Error('Kindly input posting date');
        PaymentMethod.Get(PCASH."Pay Mode");
        if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then begin
            PCASH.TestField(PCASH."Cheque No");
            PCASH.TestField(PCASH."Cheque Date");
        end;
        //Check Commitment
        PCASHLines.Reset();
        PCASHLines.SetRange(No, PCASH."No.");
        if PCASHLines.Find('-') then
            repeat
                if IsAccountVotebookEntry(PCASHLines."Account No") then begin
                    Commitment.FetchDimValue(PCASHLines."Dimension Set ID", ShortcutDimValue, DimValueName);
                    GLSetupRec.Get();
                    //DimValue.GET(GLSetup."Shortcut Dimension 1 Code",ShortcutDimValue[1]);
                    //DimValueName:=DimValue.Name;
                    if not Commitment.LineCommitted(PCASH."No.", PCASHLines."Account No", PCASHLines."Line No") then
                        Error(Text019, ShortcutDimValue[1] + ' ' + DimValueName[1]);
                end;
            until PCASHLines.Next() = 0;
        if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then begin
            PCASH.TestField("Cheque No");
            PCASH.TestField("Cheque Date");
        end;

        //Check Lines
        PCASH.CalcFields("Petty Cash Amount");
        if PCASH."Petty Cash Amount" = 0 then
            Error('Amount cannot be zero');
        PCASHLines.Reset();
        PCASHLines.SetRange(PCASHLines.No, PCASH."No.");
        if not PCASHLines.FindLast() then
            Error('Petty Cash voucher Lines cannot be empty');
        CMSetupRec.Get();

        //Use separate no series for banks
        if CMSetupRec."Use Bank Pmt Doc Nos" then
            DocNo := NoSeriesMgt.GetNextNo(GetBankPaymentNoSeries(PCASH."Paying Bank Account"), 0D, true)
        else
            DocNo := PCASH."No.";

        // Delete Lines Present on the General Journal Line
        GenJnLine.Reset();
        GenJnLine.SetRange(GenJnLine."Journal Template Name", JTemplate);
        GenJnLine.SetRange(GenJnLine."Journal Batch Name", JBatch);
        GenJnLine.DeleteAll();

        Batch.Init();
        if CMSetupRec.Get() then
            Batch."Journal Template Name" := JTemplate;
        Batch.Name := JBatch;
        if not Batch.Get(Batch."Journal Template Name", Batch.Name) then
            Batch.Insert();

        //Bank Entries
        LineNo := LineNo + 10000;
        PCASH.CalcFields(PCASH."Petty Cash Amount");
        PCASHLines.Reset();
        PCASHLines.SetRange(PCASHLines.No, PCASH."No.");
        PCASHLines.Validate(PCASHLines.Amount);

        GenJnLine.Init();
        GenJnLine."Journal Template Name" := JTemplate;
        GenJnLine."Journal Batch Name" := JBatch;
        GenJnLine."Line No." := LineNo;
        GenJnLine."Account Type" := GenJnLine."Account Type"::"Bank Account";
        GenJnLine."Account No." := PCASH."Paying Bank Account";
        GenJnLine.Validate(GenJnLine."Account No.");
        GenJnLine.Validate("Posting Date", PCASH."Payment Release Date");
        GenJnLine."Document No." := DocNo;//PCASH."No.";
        GenJnLine."External Document No." := PCASH."Cheque No";
        GenJnLine."Payment Method Code" := CopyStr(PCASH."Pay Mode", 1, MaxStrLen(GenJnLine."Payment Method Code"));
        GenJnLine.Description := CopyStr(PCASH."Payment Narration" + ' ' + PCASH.Payee, 1, MaxStrLen(GenJnLine.Description));//+'Pay To:'+PCASH.Payee;
        GenJnLine.Amount := -PCASH."Petty Cash Amount";
        GenJnLine.Validate("Currency Code", PCASH.Currency);
        GenJnLine.Validate(GenJnLine.Amount);
        GenJnLine."Shortcut Dimension 1 Code" := PCASH."Shortcut Dimension 1 Code";
        GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
        GenJnLine."Shortcut Dimension 2 Code" := PCASH."Shortcut Dimension 2 Code";
        GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
        GenJnLine."Dimension Set ID" := PCASH."Dimension Set ID";
        GenJnLine.Validate(GenJnLine."Dimension Set ID");
        GenJnLine.Payee := CopyStr(PCASH.Payee, 1, MaxStrLen(GenJnLine.Payee));
        if GenJnLine.Amount <> 0 then
            GenJnLine.Insert();

        case PCASH."Petty Cash Type" of
            PCASH."Petty Cash Type"::" ":
                Error('Petty Cash Type not specified');
            PCASH."Petty Cash Type"::Float:
                begin
                    GenJnLine.Init();
                    GenJnLine."Journal Template Name" := JTemplate;
                    GenJnLine."Journal Batch Name" := JBatch;
                    GenJnLine."Line No." := LineNo + 10000;
                    GenJnLine."Account Type" := GenJnLine."Bal. Account Type"::Customer;
                    GenJnLine."Account No." := PCASH."Account No.";
                    GenJnLine.Validate(GenJnLine."Account No.");
                    GenJnLine.Validate("Posting Date", PCASH."Payment Release Date");
                    GenJnLine."Document No." := DocNo;//PCASH."No.";
                    GenJnLine."External Document No." := PCASH."Cheque No";
                    GenJnLine."Payment Method Code" := CopyStr(PCASH."Pay Mode", 1, MaxStrLen(GenJnLine."Payment Method Code"));
                    GenJnLine.Description := CopyStr(PCASH."Payment Narration" + ' ' + PCASH.Payee, 1, MaxStrLen(GenJnLine.Description));//+'Pay To:'+PCASH.Payee;
                    GenJnLine.Amount := PCASH."Petty Cash Amount";
                    GenJnLine.Validate("Currency Code", PCASH.Currency);
                    GenJnLine.Validate(GenJnLine.Amount);
                    GenJnLine."Shortcut Dimension 1 Code" := PCASHLines."Shortcut Dimension 1 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                    GenJnLine."Shortcut Dimension 2 Code" := PCASHLines."Shortcut Dimension 2 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                    GenJnLine."Dimension Set ID" := PCASHLines."Dimension Set ID";
                    GenJnLine.Validate(GenJnLine."Dimension Set ID");
                    GenJnLine.Payee := CopyStr(PCASH.Payee, 1, MaxStrLen(GenJnLine.Payee));
                    if GenJnLine.Amount <> 0 then
                        GenJnLine.Insert();
                end;
            PCASH."Petty Cash Type"::"Direct Expense":
                begin
                    PCASHLines.Reset();
                    PCASHLines.SetRange(PCASHLines.No, PCASH."No.");
                    if PCASHLines.Find('-') then
                        repeat
                            LineNo := LineNo + 10000;
                            GenJnLine.Init();
                            GenJnLine."Journal Template Name" := JTemplate;
                            GenJnLine."Journal Batch Name" := JBatch;
                            GenJnLine."Line No." := LineNo;
                            GenJnLine."Account Type" := PCASHLines."Account Type";
                            GenJnLine."Account No." := PCASHLines."Account No";
                            GenJnLine.Validate(GenJnLine."Account No.");
                            GenJnLine.Validate("Posting Date", PCASH."Payment Release Date");
                            GenJnLine."Document No." := DocNo;//PCASH."No.";
                            GenJnLine."External Document No." := PCASH."Cheque No";
                            GenJnLine."Payment Method Code" := CopyStr(PCASH."Pay Mode", 1, MaxStrLen(GenJnLine."Payment Method Code"));
                            GenJnLine.Description := CopyStr(PCASHLines.Description + ' ' + PCASH.Payee, 1, MaxStrLen(GenJnLine.Description));
                            GenJnLine.Amount := PCASHLines.Amount;
                            GenJnLine.Validate("Currency Code", PCASH.Currency);
                            GenJnLine.Validate(GenJnLine.Amount);
                            GenJnLine."Shortcut Dimension 1 Code" := PCASHLines."Shortcut Dimension 1 Code";
                            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                            GenJnLine."Shortcut Dimension 2 Code" := PCASHLines."Shortcut Dimension 2 Code";
                            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                            GenJnLine."Dimension Set ID" := PCASHLines."Dimension Set ID";
                            GenJnLine.Validate(GenJnLine."Dimension Set ID");
                            GenJnLine.Payee := CopyStr(PCASH.Payee, 1, MaxStrLen(GenJnLine.Payee));
                            if GenJnLine.Amount <> 0 then
                                GenJnLine.Insert();
                        until PCASHLines.Next() = 0;
                end;
        end;

        if Preview then begin
            Commit();
            GenJnlPost.Preview(GenJnLine);
        end else
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnLine);

        GLEntry.Reset();
        GLEntry.SetRange(GLEntry."Document No.", DocNo);
        GLEntry.SetRange(GLEntry.Reversed, false);
        if not GLEntry.IsEmpty() then begin
            //Encumber
            Commitment.EncumberPayments(PCASH);
            //
            PCASH.Posted := true;
            PCASH."Posted By" := CopyStr(UserId, 1, MaxStrLen(PCASH."Posted By"));
            PCASH."Posted Date" := Today;
            PCASH."Time Posted" := Time;
            PCASH."Posted Document No." := DocNo;
            PCASH.Modify();
        end;
    end;

    procedure PostPettyCashSurrender(var PCash: Record Payments)
    var
        GLEntry: Record "G/L Entry";
        GenJnLine: Record "Gen. Journal Line";
        PCLines: Record "Payment Lines";
        PaymentRec: Record Payments;
        Commitment: Codeunit "Commitments Mgt Finance";
        LineNo: Integer;
    begin
        if Confirm(Text014, false, PCash."No.") = true then begin
            if PCash.Status <> PCash.Status::Released then
                Error(Text003, PCash."No.");
            PCash.TestField("Surrender Date");
            PCash.CalcFields("Petty Cash Amount", PCash."Actual Petty Cash Amount Spent");
            if PCash."Petty Cash Amount" = 0 then
                Error(Text005);
            if PCash."Payment Release Date" = 0D then
                Error('Please input posting date');
            // IF PCash."Actual Petty Cash Amount Spent"=0 THEN
            //  ERROR(Text016);
            if PCash."Remaining Amount" <> 0 then
                Error(Text020);
            if PCash.Surrendered then
                Error(Text015, PCash."No.");

            if PCash.Apportion then
                Apportionment.CheckApportionment(PCash."No.");

            CMSetup.Get();
            CMSetup.TestField("Petty Cash Surrender Template");
            GenJnLine.Reset();
            GenJnLine.SetRange("Journal Template Name", CMSetup."Petty Cash Surrender Template");
            GenJnLine.SetRange("Journal Batch Name", PCash."No.");
            GenJnLine.DeleteAll();
            Batch.Init();
            Batch."Journal Template Name" := CopyStr(CMSetup."Petty Cash Surrender Template", 1, MaxStrLen(Batch."Journal Template Name"));
            Batch.Name := CopyStr(PCash."No.", 1, MaxStrLen(GenJnLine."Journal Batch Name"));
            if not Batch.Get(Batch."Journal Template Name", Batch.Name) then
                Batch.Insert();
            LineNo := 1000;
            GenJnLine.Init();
            GenJnLine."Journal Template Name" := CopyStr(CMSetup."Petty Cash Surrender Template", 1, MaxStrLen(GenJnLine."Journal Template Name"));
            GenJnLine."Journal Batch Name" := CopyStr(PCash."No.", 1, MaxStrLen(GenJnLine."Journal Batch Name"));
            GenJnLine."Line No." := LineNo;
            GenJnLine."Account Type" := GenJnLine."Account Type"::Customer;
            GenJnLine."Account No." := PCash."Account No.";
            GenJnLine.Validate("Posting Date", PCash."Payment Release Date");
            GenJnLine."Document No." := PCash."No.";
            GenJnLine.Description := CopyStr('Petty Cash Surrendered by: ' + PCash.Payee, 1, MaxStrLen(GenJnLine.Description));
            GenJnLine.Amount := -PCash."Actual Petty Cash Amount Spent";
            GenJnLine.Validate(Amount);
            GenJnLine."Currency Code" := CopyStr(PCash.Currency, 1, MaxStrLen(GenJnLine."Currency Code"));
            GenJnLine.Validate("Currency Code");
            GenJnLine."Shortcut Dimension 1 Code" := PCash."Shortcut Dimension 1 Code";
            GenJnLine.Validate("Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := PCash."Shortcut Dimension 2 Code";
            GenJnLine.Validate("Shortcut Dimension 2 Code");
            GenJnLine."Dimension Set ID" := PCash."Dimension Set ID";
            GenJnLine.Validate(GenJnLine."Dimension Set ID");
            GenJnLine."Applies-to Doc. Type" := GenJnLine."Applies-to Doc. Type"::" ";
            GenJnLine."Applies-to Doc. No." := PCash."Petty Cash Issue Doc.No";
            GenJnLine.Validate(GenJnLine."Applies-to Doc. No.");
            GenJnLine.Payee := CopyStr(PCASH.Payee, 1, MaxStrLen(GenJnLine.Payee));
            if GenJnLine.Amount <> 0 then
                GenJnLine.Insert();
            //Petty Cash surrender Lines Entries
            PCLines.Reset();
            PCLines.SetRange(PCLines.No, PCash."No.");
            if PCLines.FindFirst() then
                repeat
                    PCLines.Validate(PCLines.Amount);
                    LineNo := LineNo + 10000;
                    GenJnLine.Init();
                    GenJnLine."Journal Template Name" := CopyStr(CMSetup."Petty Cash Surrender Template", 1, MaxStrLen(GenJnLine."Journal Template Name"));
                    GenJnLine."Journal Batch Name" := CopyStr(PCash."No.", 1, MaxStrLen(GenJnLine."Journal Batch Name"));
                    GenJnLine."Line No." := LineNo;
                    GenJnLine."Account Type" := PCLines."Account Type";
                    GenJnLine."Account No." := PCLines."Account No";
                    GenJnLine.Validate(GenJnLine."Account No.");
                    if PCash."Surrender Date" = 0D then
                        Error('You must specify the surrender date');
                    GenJnLine.Validate("Posting Date", PCash."Payment Release Date");
                    GenJnLine."Document No." := PCash."No.";
                    PCLines.TestField(Purpose);
                    GenJnLine.Description := CopyStr(PCLines.Purpose, 1, 100);
                    GenJnLine.Amount := PCLines."Actual Spent";
                    GenJnLine."Currency Code" := CopyStr(PCash.Currency, 1, MaxStrLen(GenJnLine."Currency Code"));
                    GenJnLine.Validate("Currency Code");
                    GenJnLine.Validate(GenJnLine.Amount);
                    GenJnLine."Shortcut Dimension 1 Code" := PCLines."Shortcut Dimension 1 Code";
                    GenJnLine.Validate("Shortcut Dimension 1 Code");
                    GenJnLine."Shortcut Dimension 2 Code" := PCLines."Shortcut Dimension 2 Code";
                    GenJnLine.Validate("Shortcut Dimension 2 Code");
                    GenJnLine."Dimension Set ID" := PCLines."Dimension Set ID";
                    GenJnLine.Validate(GenJnLine."Dimension Set ID");
                    GenJnLine.Payee := CopyStr(PCASH.Payee, 1, MaxStrLen(GenJnLine.Payee));
                    if GenJnLine.Amount <> 0 then
                        GenJnLine.Insert();
                    //Receipt Lines Entries
                    if PCLines."Cash Receipt Amount" <> 0 then begin
                        PCLines.TestField("Receiving Bank");
                        LineNo := LineNo + 10000;
                        GenJnLine.Init();
                        if CMSetup.Get() then
                            GenJnLine."Journal Template Name" := CopyStr(CMSetup."Petty Cash Surrender Template", 1, MaxStrLen(GenJnLine."Journal Template Name"));
                        GenJnLine."Journal Batch Name" := CopyStr(PCash."No.", 1, MaxStrLen(GenJnLine."Journal Batch Name"));
                        GenJnLine."Line No." := LineNo;
                        GenJnLine."Account Type" := GenJnLine."Account Type"::Customer;
                        GenJnLine."Account No." := PCash."Account No.";
                        GenJnLine.Validate(GenJnLine."Account No.");
                        GenJnLine.Validate("Posting Date", PCash."Payment Release Date");
                        GenJnLine."Document No." := PCash."No.";
                        GenJnLine."External Document No." := PCash."Cheque No";
                        GenJnLine."Payment Method Code" := CopyStr(PCash."Pay Mode", 1, MaxStrLen(GenJnLine."Payment Method Code"));
                        GenJnLine.Description := PCash."Account Name";
                        GenJnLine.Amount := -PCLines."Cash Receipt Amount";
                        GenJnLine."Currency Code" := CopyStr(PCash.Currency, 1, MaxStrLen(GenJnLine."Currency Code"));
                        GenJnLine.Validate("Currency Code");
                        GenJnLine.Validate(GenJnLine.Amount);
                        GenJnLine."Bal. Account Type" := GenJnLine."Account Type"::"Bank Account";
                        GenJnLine."Bal. Account No." := PCLines."Receiving Bank";
                        GenJnLine.Validate("Bal. Account No.");
                        GenJnLine."Shortcut Dimension 1 Code" := PCLines."Shortcut Dimension 1 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                        GenJnLine."Shortcut Dimension 2 Code" := PCLines."Shortcut Dimension 2 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                        GenJnLine."Dimension Set ID" := PCLines."Dimension Set ID";
                        GenJnLine.Validate(GenJnLine."Dimension Set ID");
                        GenJnLine."Applies-to Doc. Type" := GenJnLine."Applies-to Doc. Type"::" ";
                        GenJnLine."Applies-to Doc. No." := PCash."Petty Cash Issue Doc.No";
                        GenJnLine.Validate(GenJnLine."Applies-to Doc. No.");
                        GenJnLine.Payee := CopyStr(PCASH.Payee, 1, MaxStrLen(GenJnLine.Payee));
                        if GenJnLine.Amount <> 0 then
                            GenJnLine.Insert();
                    end;
                until PCLines.Next() = 0;
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnLine);
            GLEntry.Reset();
            GLEntry.SetRange(GLEntry."Document No.", PCash."No.");
            GLEntry.SetRange(GLEntry.Reversed, false);
            //GLEntry.SETRANGE("Posting Date",PCash."Payment Release Date");
            if not GLEntry.IsEmpty() then begin
                PCash.Posted := true;
                PCash."Posted By" := CopyStr(UserId, 1, MaxStrLen(PCash."Posted By"));
                PCash."Posted Date" := Today;
                PCash."Time Posted" := Time;
                PCash.Surrendered := true;
                PCash."Surrendered By" := CopyStr(UserId, 1, MaxStrLen(PCash."Surrendered By"));
                PCash."Date Surrendered" := Today;
                PCash."Posted Document No." := PCash."No.";
                PCash.Modify();
                //PaymentRec.SETRANGE("Petty Cash Issue Doc.No",PCash."No.");

                PaymentRec.Reset();
                PaymentRec.SetRange("No.", PCash."Petty Cash Issue Doc.No");
                if PaymentRec.Find('-') then begin
                    PaymentRec."Surrender Date" := PCash."Surrender Date";
                    PaymentRec."Surrendered By" := PCash."Surrendered By";
                    PaymentRec.Surrendered := true;
                    PaymentRec.Modify(true);
                end;

                //Uncommit Entries made to the varoius expenses accounts
                Commitment.UnencumberPettyCash(PCash);

                //Apportion
                if PCash.Apportion then
                    Apportionment.CreatePaymentApportionEntry(PCash);
            end;
        end;
    end;

    procedure PostReceipt(ReceiptRec: Record Payments)
    var
        CMSetupRec: Record "Cash Management Setups";
        GLEntry: Record "G/L Entry";
        GenJnLine: Record "Gen. Journal Line";
        RcptLines: Record "Payment Lines";
        PaymentMethod: Record "Payment Method";
        JournBatch: Code[10];
        JournTemplate: Code[10];
        DocNo: Code[20];
        LineNo: Integer;
    begin
        if Confirm(Text017, false, ReceiptRec."No.") = true then begin
            if ReceiptRec.Posted then
                Error(Text018);

            ReceiptRec.TestField("Paying Bank Account");
            ReceiptRec.TestField("Received From");
            ReceiptRec.TestField(Date);
            ReceiptRec.TestField("Pay Mode");

            if ReceiptRec."Payment Release Date" = 0D then
                Error('Please input posting date');

            if PaymentMethod.Get(ReceiptRec."Pay Mode") then;
            if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then begin
                ReceiptRec.TestField("Cheque No");
                ReceiptRec.TestField("Cheque Date");
            end;

            ReceiptRec.CalcFields("Receipt Amount");
            ReceiptRec.CalcFields("Imp Surr Receipt Amount");
            if ReceiptRec."Imprest Surrender Doc. No" = '' then
                if ReceiptRec."Receipt Amount" = 0 then
                    Error('Amount cannot be zero');

            if ReceiptRec."Imprest Surrender Doc. No" <> '' then
                if ReceiptRec."Imp Surr Receipt Amount" = 0 then
                    Error('Imprest Receipt Amount cannot be zero');

            if ReceiptRec."Imprest Surrender Doc. No" = '' then begin
                RcptLines.Reset();
                //RcptLines.SETRANGE("Payment Type",ReceiptRec."Payment Type");
                RcptLines.SetRange(No, ReceiptRec."No.");
                if not RcptLines.FindLast() then
                    Error('Receipt Lines cannot be empty');
            end;

            CMSetupRec.Get();
            //Use separate no series for banks
            if CMSetupRec."Use Bank Pmt Doc Nos" then
                DocNo := NoSeriesMgt.GetNextNo(GetBankPaymentNoSeries(ReceiptRec."Paying Bank Account"), 0D, true)
            else
                DocNo := ReceiptRec."No.";

            JournTemplate := CopyStr(CMSetupRec."Receipt Template", 1, MaxStrLen(JournTemplate));
            JournBatch := CopyStr(ReceiptRec."No.", 1, MaxStrLen(GenJnLine."Journal Batch Name"));

            // Delete Lines Present on the General Journal Line
            GenJnLine.Reset();
            GenJnLine.SetRange(GenJnLine."Journal Template Name", JournTemplate);
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", JournBatch);
            GenJnLine.DeleteAll();

            Batch.Init();
            Batch."Journal Template Name" := JournTemplate;
            Batch.Name := JournBatch;
            if not Batch.Get(Batch."Journal Template Name", JournBatch) then
                Batch.Insert();

            //Bank Entries
            LineNo := LineNo + 10000;
            GenJnLine.Init();
            GenJnLine."Journal Template Name" := JournTemplate;
            GenJnLine."Journal Batch Name" := JournBatch;
            GenJnLine."Line No." := LineNo;
            GenJnLine."Account Type" := GenJnLine."Account Type"::"Bank Account";
            GenJnLine."Account No." := ReceiptRec."Paying Bank Account";
            GenJnLine.Validate(GenJnLine."Account No.");
            if ReceiptRec.Date = 0D then
                Error('You must specify the Receipt date');
            GenJnLine.Validate("Posting Date", ReceiptRec."Payment Release Date");
            GenJnLine."Document No." := DocNo;//ReceiptRec."No.";
            GenJnLine."External Document No." := ReceiptRec."Cheque No";
            GenJnLine."Payment Method Code" := CopyStr(ReceiptRec."Pay Mode", 1, MaxStrLen(GenJnLine."Payment Method Code"));
            GenJnLine.Description := CopyStr(ReceiptRec."Payment Narration", 1, MaxStrLen(GenJnLine.Description));
            if ReceiptRec."Imprest Surrender Doc. No" <> '' then
                GenJnLine.Amount := ReceiptRec."Imp Surr Receipt Amount"
            else
                GenJnLine.Amount := ReceiptRec."Receipt Amount";
            GenJnLine."Currency Code" := CopyStr(ReceiptRec.Currency, 1, MaxStrLen(GenJnLine."Currency Code"));
            GenJnLine.Validate("Currency Code");
            GenJnLine.Validate(GenJnLine.Amount);
            GenJnLine."Shortcut Dimension 1 Code" := ReceiptRec."Shortcut Dimension 1 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := ReceiptRec."Shortcut Dimension 2 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
            GenJnLine.Payee := CopyStr(ReceiptRec."Received From", 1, MaxStrLen(GenJnLine.Payee));
            if GenJnLine.Amount <> 0 then
                GenJnLine.Insert();

            if ReceiptRec."Imprest Surrender Doc. No" = '' then begin
                //Receipt Lines Entries
                RcptLines.Reset();
                //RcptLines.SETRANGE("Payment Type",ReceiptRec."Payment Type");
                RcptLines.SetRange(No, ReceiptRec."No.");
                if RcptLines.FindFirst() then
                    repeat
                        RcptLines.Validate(RcptLines.Amount);
                        LineNo := LineNo + 10000;
                        GenJnLine.Init();
                        if CMSetupRec.Get() then
                            GenJnLine."Journal Template Name" := JournTemplate;
                        GenJnLine."Journal Batch Name" := JournBatch;
                        GenJnLine."Line No." := LineNo;
                        GenJnLine."Account Type" := RcptLines."Account Type";
                        GenJnLine."Account No." := RcptLines."Account No";
                        GenJnLine.Validate(GenJnLine."Account No.");
                        GenJnLine.Validate("Posting Date", ReceiptRec."Payment Release Date");
                        GenJnLine."Document No." := DocNo;//ReceiptRec."No.";
                        GenJnLine."External Document No." := ReceiptRec."Cheque No";
                        GenJnLine."Payment Method Code" := CopyStr(ReceiptRec."Pay Mode", 1, MaxStrLen(GenJnLine."Payment Method Code"));
                        GenJnLine.Description := CopyStr(RcptLines.Description, 1, MaxStrLen(GenJnLine.Description));
                        GenJnLine.Amount := -RcptLines.Amount;
                        GenJnLine."Currency Code" := CopyStr(ReceiptRec.Currency, 1, MaxStrLen(GenJnLine."Currency Code"));
                        GenJnLine.Validate("Currency Code");
                        GenJnLine.Validate(GenJnLine.Amount);
                        GenJnLine."Shortcut Dimension 1 Code" := RcptLines."Shortcut Dimension 1 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                        GenJnLine."Shortcut Dimension 2 Code" := RcptLines."Shortcut Dimension 2 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                        GenJnLine."Dimension Set ID" := RcptLines."Dimension Set ID";
                        GenJnLine."Gen. Posting Type" := RcptLines."Gen. Posting Type";
                        //GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::Invoice;
                        GenJnLine."Applies-to Doc. No." := RcptLines."Applies-to Doc. No.";
                        GenJnLine.Validate(GenJnLine."Applies-to Doc. No.");
                        GenJnLine."Applies-to ID" := RcptLines."Applies-to ID";
                        GenJnLine.Payee := CopyStr(ReceiptRec."Received From", 1, MaxStrLen(GenJnLine.Payee));
                        if GenJnLine.Amount <> 0 then
                            GenJnLine.Insert();
                    until RcptLines.Next() = 0;
            end else begin
                //Receipt Lines Entries
                RcptLines.Reset();
                RcptLines.SetRange(No, ReceiptRec."Imprest Surrender Doc. No");
                if RcptLines.FindSet() then
                    repeat
                        LineNo := LineNo + 10000;
                        GenJnLine.Init();
                        if CMSetupRec.Get() then
                            GenJnLine."Journal Template Name" := JournTemplate;
                        GenJnLine."Journal Batch Name" := JournBatch;
                        GenJnLine."Line No." := LineNo;
                        GenJnLine."Account Type" := GenJnLine."Account Type"::Customer;
                        GenJnLine."Account No." := GetCustAccNo(ReceiptRec."Imprest Surrender Doc. No");
                        GenJnLine.Validate(GenJnLine."Account No.");
                        GenJnLine.Validate("Posting Date", ReceiptRec."Payment Release Date");
                        GenJnLine."Document No." := DocNo;//ReceiptRec."No.";
                        GenJnLine."External Document No." := ReceiptRec."Cheque No";
                        GenJnLine."Payment Method Code" := CopyStr(ReceiptRec."Pay Mode", 1, MaxStrLen(GenJnLine."Payment Method Code"));
                        GenJnLine.Description := CopyStr(RcptLines.Description, 1, MaxStrLen(GenJnLine.Description));
                        GenJnLine.Amount := -RcptLines."Cash Receipt Amount";
                        GenJnLine."Currency Code" := CopyStr(ReceiptRec.Currency, 1, MaxStrLen(GenJnLine."Currency Code"));
                        GenJnLine.Validate("Currency Code");
                        GenJnLine.Validate(GenJnLine.Amount);
                        GenJnLine."Shortcut Dimension 1 Code" := RcptLines."Shortcut Dimension 1 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                        GenJnLine."Shortcut Dimension 2 Code" := RcptLines."Shortcut Dimension 2 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                        GenJnLine."Dimension Set ID" := RcptLines."Dimension Set ID";
                        GenJnLine."Applies-to Doc. No." := GetImprestForReceipt(ReceiptRec."Imprest Surrender Doc. No");
                        GenJnLine.Validate(GenJnLine."Applies-to Doc. No.");
                        GenJnLine.Payee := CopyStr(ReceiptRec."Received From", 1, MaxStrLen(GenJnLine.Payee));
                        if GenJnLine.Amount <> 0 then
                            GenJnLine.Insert();
                    until RcptLines.Next() = 0;
            end;
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnLine);
            GLEntry.Reset();
            GLEntry.SetRange(GLEntry."Document No.", DocNo);
            GLEntry.SetRange(GLEntry.Reversed, false);
            if not GLEntry.IsEmpty() then begin
                ReceiptRec.Posted := true;
                ReceiptRec."Posted Date" := Today;
                ReceiptRec."Time Posted" := Time;
                ReceiptRec."Posted By" := CopyStr(UserId, 1, MaxStrLen(ReceiptRec."Posted By"));
                ReceiptRec."Posted Document No." := DocNo;
                ReceiptRec.Modify();
                if ReceiptRec."Imprest Surrender Doc. No" <> '' then begin
                    RcptLines.Reset();
                    RcptLines.SetRange(No, ReceiptRec."Imprest Surrender Doc. No");
                    if RcptLines.Find('-') then
                        repeat
                            RcptLines."Imprest Receipt No." := ReceiptRec."No.";
                            RcptLines.Modify();
                        until RcptLines.Next() = 0;
                end;
            end;
        end;
    end;

    procedure PostPropertyExpenseClaim(Claim: Record Payments)
    var
        CMSetupRec: Record "Cash Management Setups";
        ChequeRegister: Record "Cheque Register";
        GLEntry: Record "G/L Entry";
        GenJnLine: Record "Gen. Journal Line";
        ClaimLines: Record "Payment Lines";
        PaymentMethod: Record "Payment Method";
        ChequePmt: Boolean;
        DocNo: Code[20];
        LineNo: Integer;
    begin
        ChequePmt := false;

        if Confirm('Are you sure you want to post the Claim No. ' + Claim."No." + ' ?') = true then begin
            if Claim.Status <> Claim.Status::Released then
                Error('The Staff Claim No %1 has not been fully approved', Claim."No.");
            if Claim.Posted then
                Error('Staff Claim %1 has been posted', Claim."No.");

            //Get batches
            CashOfficeUserTemplate.Get(UserId);
            JTemplate := CopyStr(CashOfficeUserTemplate."Claim Template", 1, MaxStrLen(JTemplate));
            JBatch := CopyStr(CashOfficeUserTemplate."Claim  Batch", 1, MaxStrLen(JBatch));

            if JTemplate = '' then
                Error('Ensure the Claims Template is set up in Cash Office Setup');

            if JBatch = '' then
                Error('Ensure the Claims Batch is set up in the Cash Office Setup');

            //Check Apportionment
            if Claim.Apportion then
                Apportionment.CheckApportionment(Claim."No.");

            Claim.TestField(Date);
            Claim.TestField("Paying Bank Account");
            //Claim.TESTFIELD(Claim.Payee);
            Claim.TestField(Claim."Pay Mode");
            PaymentMethod.Get(Claim."Pay Mode");
            if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then begin
                Claim.TestField(Claim."Cheque No");
                Claim.TestField(Claim."Cheque Date");
                ChequePmt := true;
            end;

            if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then begin
                Claim.TestField("Cheque No");
                Claim.TestField("Cheque Date");
            end;
            //Check Lines
            Claim.CalcFields("Petty Cash Amount");
            if Claim."Petty Cash Amount" = 0 then
                Error('Amount cannot be zero');

            ClaimLines.Reset();
            ClaimLines.SetRange(ClaimLines.No, Claim."No.");
            if not ClaimLines.FindLast() then
                Error('Claim Lines cannot be empty');

            ClaimLines.Reset();
            ClaimLines.SetRange(ClaimLines.No, Claim."No.");
            if ClaimLines.Find('-') then
                repeat
                    ClaimLines.TestField("Expenditure Date");
                    //ClaimLines.TESTFIELD("Claim Receipt No.");
                    ClaimLines.TestField("Expenditure Description");
                until ClaimLines.Next() = 0;

            CMSetupRec.Get();

            //Use separate no series for banks
            if CMSetupRec."Use Bank Pmt Doc Nos" then
                DocNo := NoSeriesMgt.GetNextNo(GetBankPaymentNoSeries(Claim."Paying Bank Account"), 0D, true)
            else
                DocNo := Claim."No.";

            // Delete Lines Present on the General Journal Line
            GenJnLine.Reset();
            GenJnLine.SetRange(GenJnLine."Journal Template Name", JTemplate);
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", JBatch);
            GenJnLine.DeleteAll();

            Batch.Init();
            if CMSetupRec.Get() then
                Batch."Journal Template Name" := JTemplate;
            Batch.Name := JBatch;
            if not Batch.Get(Batch."Journal Template Name", Batch.Name) then
                Batch.Insert();

            //Bank Entries
            LineNo := LineNo + 10000;
            Claim.CalcFields(Claim."Petty Cash Amount");
            ClaimLines.Reset();
            ClaimLines.SetRange(ClaimLines.No, Claim."No.");
            ClaimLines.Validate(ClaimLines.Amount);

            GenJnLine.Init();
            if CMSetupRec.Get() then
                GenJnLine."Journal Template Name" := JTemplate;
            GenJnLine."Journal Batch Name" := JBatch;
            GenJnLine."Line No." := LineNo;
            GenJnLine."Account Type" := GenJnLine."Account Type"::"Bank Account";
            GenJnLine."Account No." := Claim."Paying Bank Account";
            GenJnLine.Validate(GenJnLine."Account No.");
            if Claim.Date = 0D then
                Error('You must specify the Claim date');
            GenJnLine.Validate("Posting Date", Claim."Payment Release Date");
            GenJnLine."Document No." := DocNo; //Claim."No.";
            if ChequePmt then
                GenJnLine."External Document No." := Claim."Cheque No";
            //GenJnLine."Bank Payment Type" := GenJnLine."Bank Payment Type"::"Manual Check"; //inserts check ledger entry
            GenJnLine."Payment Method Code" := CopyStr(Claim."Pay Mode", 1, MaxStrLen(GenJnLine."Payment Method Code"));
            GenJnLine.Description := CopyStr('Staff Claim:' + Claim.Payee, 1, MaxStrLen(GenJnLine.Description));
            GenJnLine.Amount := -Claim."Petty Cash Amount";
            GenJnLine.Validate("Currency Code");
            GenJnLine.Validate(GenJnLine.Amount);
            GenJnLine."Shortcut Dimension 1 Code" := Claim."Shortcut Dimension 1 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := Claim."Shortcut Dimension 2 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
            GenJnLine."Dimension Set ID" := Claim."Dimension Set ID";
            GenJnLine.Validate(GenJnLine."Dimension Set ID");
            GenJnLine.Payee := CopyStr(Claim.Payee, 1, MaxStrLen(GenJnLine.Payee));
            if GenJnLine.Amount <> 0 then
                GenJnLine.Insert();

            //Claim Entries
            ClaimLines.Reset();
            ClaimLines.SetRange(No, Claim."No.");
            if ClaimLines.Find('-') then
                repeat
                    ClaimLines.Validate(ClaimLines.Amount);
                    LineNo := LineNo + 10000;
                    GenJnLine.Init();
                    if CMSetupRec.Get() then
                        GenJnLine."Journal Template Name" := JTemplate;
                    GenJnLine."Journal Batch Name" := JBatch;
                    GenJnLine."Line No." := LineNo;
                    GenJnLine."Account Type" := ClaimLines."Account Type";
                    GenJnLine."Account No." := ClaimLines."Account No";
                    GenJnLine.Validate(GenJnLine."Account No.");
                    GenJnLine.Validate("Posting Date", Claim."Payment Release Date");
                    GenJnLine."Document No." := DocNo;//Claim."No.";
                    GenJnLine."External Document No." := Claim."Cheque No";
                    GenJnLine."Payment Method Code" := CopyStr(Claim."Pay Mode", 1, MaxStrLen(GenJnLine."Payment Method Code"));
                    GenJnLine.Description := CopyStr(ClaimLines.Description, 1, MaxStrLen(GenJnLine.Description));
                    GenJnLine.Amount := ClaimLines.Amount;
                    GenJnLine."Currency Code" := CopyStr(Claim.Currency, 1, MaxStrLen(GenJnLine."Currency Code"));
                    GenJnLine.Validate("Currency Code");
                    GenJnLine.Validate(GenJnLine.Amount);
                    GenJnLine."Shortcut Dimension 1 Code" := ClaimLines."Shortcut Dimension 1 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                    GenJnLine."Shortcut Dimension 2 Code" := ClaimLines."Shortcut Dimension 2 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                    GenJnLine."Dimension Set ID" := ClaimLines."Dimension Set ID";
                    GenJnLine.Payee := CopyStr(Claim.Payee, 1, MaxStrLen(GenJnLine.Payee));
                    //    GenJnLine."Applies-to Doc. No.":=ClaimLines."Applies-to Doc. No.";
                    //    GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");
                    //    GenJnLine."Applies-to ID":=ClaimLines."Applies-to ID";
                    if GenJnLine.Amount <> 0 then
                        GenJnLine.Insert();
                until ClaimLines.Next() = 0;

            //End of Posting
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnLine);
            GLEntry.Reset();
            GLEntry.SetRange(GLEntry."Document No.", DocNo);
            GLEntry.SetRange(GLEntry.Reversed, false);
            if not GLEntry.IsEmpty() then begin
                Claim.Posted := true;
                Claim."Posted By" := CopyStr(UserId, 1, MaxStrLen(Claim."Posted By"));
                Claim."Posted Date" := Today;
                Claim."Time Posted" := Time;
                Claim."Posted Document No." := DocNo;
                Claim.Modify();

                if Claim."Cheque No" <> '' then begin
                    //Modify Check Ledger-cheque no.
                    CheckLedgerEntry.Reset();
                    CheckLedgerEntry.SetRange(CheckLedgerEntry."Check No.", Claim."No.");
                    if CheckLedgerEntry.FindFirst() then begin
                        CheckLedgerEntry."Check No." := Claim."Cheque No";
                        CheckLedgerEntry."Payments Mgt Generated" := true;
                        CheckLedgerEntry.Modify();
                    end;

                    //Modify Cheque as Posted in cheque register
                    if Claim."Cheque Type" = Claim."Cheque Type"::"Computer Check" then begin
                        ChequeRegister.Reset();
                        ChequeRegister.SetRange(ChequeRegister."Cheque No.", Claim."Cheque No");
                        if ChequeRegister.FindFirst() then begin
                            ChequeRegister."Entry Status" := ChequeRegister."Entry Status"::Posted;
                            ChequeRegister."Cheque Date" := Claim."Cheque Date";
                            ChequeRegister."Posted By" := CopyStr(UserId, 1, MaxStrLen(ChequeRegister."Posted By"));
                            ChequeRegister.Modify();
                        end;
                    end;
                end;

                //Encumber
                //Commitment.EncumberPayments(Claim);

                //Apportion Card
                if Claim.Apportion then
                    Apportionment.CreatePaymentApportionEntry(Claim);
            end;
        end;
    end;

    procedure PostPropertyExpenseImprest(var Imprest: Record Payments)
    var
        ChequeRegister: Record "Cheque Register";
        GLEntry: Record "G/L Entry";
        GenJnLine: Record "Gen. Journal Line";
        ImprestLines: Record "Payment Lines";
        PaymentMethod: Record "Payment Method";
        ChequePmt: Boolean;
        DocNo: Code[20];
        LineNo: Integer;
    begin
        ChequePmt := false;

        if Confirm(Text002, false, Imprest."No.") = true then begin

            if Imprest.Status <> Imprest.Status::Released then
                Error(Text003, Imprest."No.");
            //Get batches
            CashOfficeUserTemplate.Get(UserId);
            JTemplate := CopyStr(CashOfficeUserTemplate."Imprest Template", 1, MaxStrLen(JTemplate));
            JBatch := CopyStr(Imprest."No.", 1, MaxStrLen(JBatch));// Temp."Imprest  Batch";

            if JTemplate = '' then
                Error('Ensure the Imprest Template is set up in Cash Office Setup');

            if JBatch = '' then
                Error('Ensure the Imprest Batch is set up in the Cash Office Setup');

            Imprest.TestField("Account No.");
            Imprest.TestField("Paying Bank Account");
            Imprest.TestField(Date);
            //Imprest.TESTFIELD(Payee);
            Imprest.TestField("Pay Mode");
            PaymentMethod.Get(Imprest."Pay Mode");
            //Check Commitment
            ImprestLines.Reset();
            ImprestLines.SetRange(No, Imprest."No.");

            /* if ImprestLines.Find('-') then begin
               repeat
                 if IsAccountVotebookEntry(ImprestLines."Account No") then begin
                 Commitment.FetchDimValue(ImprestLines."Dimension Set ID",ShortcutDimValue,DimValueName);
                 GLSetup.Get();
                 //DimValue.GET(GLSetup."Shortcut Dimension 6 Code",ShortcutDimValue[6]);
                 //DimValueName:=DimValue.Name;
                   if (Commitment.IsAccountVotebookEntry(ImprestLines."Account No")) and not Commitment.LineCommitted(Imprest."No.",ImprestLines."Account No",ImprestLines."Line No") then
                     Error(Text019,ShortcutDimValue[1]+' '+DimValueName[1]);
                 end;
                 until ImprestLines.Next()=0;
               end;*/

            if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then begin
                Imprest.TestField("Cheque No");
                Imprest.TestField("Cheque Date");
                ChequePmt := true;
            end;
            //Check if the imprest Lines have been populated
            ImprestLines.SetRange(ImprestLines.No, Imprest."No.");
            if ImprestLines.IsEmpty() then
                Error(Text004);

            Imprest.CalcFields("Imprest Amount");

            if Imprest.Posted then
                Error(Text006, Imprest."No.");
            CMSetup.Get();

            //Use separate no series for banks
            if CMSetup."Use Bank Pmt Doc Nos" then
                DocNo := NoSeriesMgt.GetNextNo(GetBankPaymentNoSeries(Imprest."Paying Bank Account"), 0D, true)
            else
                DocNo := Imprest."No.";

            // Delete Lines Present on the General Journal Line
            GenJnLine.Reset();
            GenJnLine.SetRange(GenJnLine."Journal Template Name", JTemplate);
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", JBatch);
            GenJnLine.DeleteAll();

            Batch.Init();
            if CMSetup.Get() then
                Batch."Journal Template Name" := JTemplate;
            Batch.Name := JBatch;
            if not Batch.Get(Batch."Journal Template Name", Batch.Name) then
                Batch.Insert();

            LineNo := 1000;
            GenJnLine.Init();
            GenJnLine."Journal Template Name" := JTemplate;
            GenJnLine."Journal Batch Name" := JBatch;
            GenJnLine."Line No." := LineNo;
            GenJnLine."Account Type" := GenJnLine."Account Type"::"Bank Account";
            GenJnLine."Account No." := Imprest."Paying Bank Account";
            GenJnLine.Validate("Posting Date", Imprest."Payment Release Date");
            GenJnLine."Document No." := DocNo;//Imprest."No.";
            if ChequePmt then
                GenJnLine."External Document No." := Imprest."Cheque No";
            //GenJnLine."Bank Payment Type" := GenJnLine."Bank Payment Type"::"Manual Check"; // this inserts check ledger entry
            GenJnLine.Description := CopyStr(Imprest."Payment Narration", 1, MaxStrLen(GenJnLine.Description));
            GenJnLine.Amount := -Imprest."Imprest Amount";
            GenJnLine.Validate(Amount);
            GenJnLine."Shortcut Dimension 1 Code" := Imprest."Shortcut Dimension 1 Code";
            GenJnLine.Validate("Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := Imprest."Shortcut Dimension 2 Code";
            GenJnLine.Validate("Shortcut Dimension 2 Code");
            GenJnLine."Dimension Set ID" := Imprest."Dimension Set ID";
            GenJnLine.Validate(GenJnLine."Dimension Set ID");
            GenJnLine."Bal. Account Type" := Imprest."Account Type";
            GenJnLine."Bal. Account No." := Imprest."Account No.";
            GenJnLine."Currency Code" := CopyStr(Imprest.Currency, 1, MaxStrLen(GenJnLine."Currency Code"));
            GenJnLine.Validate("Bal. Account No.");
            GenJnLine.Payee := CopyStr(Imprest.Payee, 1, MaxStrLen(GenJnLine.Payee));
            if GenJnLine.Amount <> 0 then
                GenJnLine.Insert();
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnLine);
            GLEntry.Reset();
            GLEntry.SetRange(GLEntry."Document No.", DocNo);
            GLEntry.SetRange(GLEntry.Reversed, false);
            if not GLEntry.IsEmpty() then begin

                if Imprest."Cheque No" <> '' then begin
                    //Modify Check Ledger-cheque no.
                    CheckLedgerEntry.Reset();
                    CheckLedgerEntry.SetRange(CheckLedgerEntry."Check No.", Imprest."No.");
                    if CheckLedgerEntry.FindFirst() then begin
                        CheckLedgerEntry."Check No." := Imprest."Cheque No";
                        CheckLedgerEntry."Payments Mgt Generated" := true;
                        CheckLedgerEntry.Modify();
                    end;

                    //Modify Cheque as Posted in cheque register
                    if Imprest."Cheque Type" = Imprest."Cheque Type"::"Computer Check" then begin
                        ChequeRegister.Reset();
                        ChequeRegister.SetRange(ChequeRegister."Cheque No.", Imprest."Cheque No");
                        if ChequeRegister.FindFirst() then begin
                            ChequeRegister."Entry Status" := ChequeRegister."Entry Status"::Posted;
                            ChequeRegister."Cheque Date" := Imprest."Cheque Date";
                            ChequeRegister."Posted By" := CopyStr(UserId, 1, MaxStrLen(ChequeRegister."Posted By"));
                            ChequeRegister.Modify();
                        end;
                    end;
                end;
                //Encumber
                //Commitment.EncumberPayments(Imprest);
                //Update the Imprest Deadline
                //   IF CMSetup."Imprest Due Date"<>DueDate THEN
                //   Imprest."Imprest Deadline":=CALCDATE(CMSetup."Imprest Due Date",TODAY);
                //   Imprest.MODIFY;
                Imprest.Posted := true;
                Imprest."Posted By" := CopyStr(UserId, 1, MaxStrLen(Imprest."Posted By"));
                Imprest."Posted Date" := Today;
                Imprest."Time Posted" := Time;
                Imprest."Posted Document No." := DocNo;
                Imprest.Modify();
            end;
        end;
    end;

    procedure PostPropertyExpenseSurrender(var Imprest: Record Payments)
    var
        GLEntry: Record "G/L Entry";
        GenJnLine: Record "Gen. Journal Line";
        ImprestLines: Record "Payment Lines";
        ImprestHeader: Record Payments;
        LineNo: Integer;
    begin
        if Confirm(Text007, false, Imprest."No.") = true then begin
            if Imprest.Status <> Imprest.Status::Released then
                Error(Text008, Imprest."No.");
            Imprest.TestField("Property Expense Doc. No");
            Imprest.CalcFields("Imprest Amount", Imprest."Actual Amount Spent", "Cash Receipt Amount");
            if Imprest."Imprest Amount" = 0 then
                Error(Text005);
            if Imprest."Actual Amount Spent" = 0 then
                Error('Actual Amount Spent must have a value');

            // IF Imprest."Actual Amount Spent"=0 THEN
            //  ERROR(Text016);
            if Imprest.Surrendered then
                Error(Text013);

            if Imprest.Apportion then
                Apportionment.CheckApportionment(Imprest."No.");

            //Get surrender templater
            CashOfficeUserTemplate.Get(UserId);
            JTemplate := CopyStr(CashOfficeUserTemplate."Imprest Sur Template", 1, MaxStrLen(JTemplate));
            JBatch := CopyStr(Imprest."No.", 1, MaxStrLen(JBatch));// Temp."Imprest Sur Batch";

            if JTemplate = '' then
                Error('Ensure the Imprest Surrender Template is set up in Cash Office Setup');

            if JBatch = '' then
                Error('Ensure the Imprest Surrender Batch is set up in the Cash Office Setup');

            CMSetup.Get();
            CMSetup.TestField(CMSetup."Imprest Surrender Template");
            // Delete Lines Present on the General Journal Line
            GenJnLine.Reset();
            GenJnLine.SetRange(GenJnLine."Journal Template Name", JTemplate);
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", JBatch);
            GenJnLine.DeleteAll();

            Batch.Init();
            if CMSetup.Get() then
                Batch."Journal Template Name" := JTemplate;
            Batch.Name := JBatch;
            if not Batch.Get(Batch."Journal Template Name", Batch.Name) then
                Batch.Insert();
            LineNo := LineNo + 1000;
            GenJnLine.Init();
            GenJnLine."Journal Template Name" := JTemplate;
            GenJnLine."Journal Batch Name" := JBatch;
            GenJnLine."Line No." := LineNo;
            GenJnLine."Account Type" := Imprest."Account Type";
            GenJnLine."Account No." := Imprest."Account No.";
            GenJnLine.Validate("Posting Date", Imprest."Payment Release Date");
            GenJnLine."Document No." := Imprest."No.";
            GenJnLine."External Document No." := Imprest."Property Expense Doc. No";
            GenJnLine.Description := CopyStr('Property Expense Surrendered by: ' + Imprest.Payee, 1, MaxStrLen(GenJnLine.Description));
            GenJnLine.Amount := -Imprest."Actual Amount Spent";
            GenJnLine."Currency Code" := CopyStr(Imprest.Currency, 1, MaxStrLen(GenJnLine."Currency Code"));
            GenJnLine.Validate("Currency Code");
            GenJnLine.Validate(Amount);
            GenJnLine."Shortcut Dimension 1 Code" := Imprest."Shortcut Dimension 1 Code";
            GenJnLine.Validate("Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := Imprest."Shortcut Dimension 2 Code";
            GenJnLine.Validate("Shortcut Dimension 2 Code");
            GenJnLine."Dimension Set ID" := Imprest."Dimension Set ID";
            GenJnLine.Validate(GenJnLine."Dimension Set ID");
            //  GenJnLine."VAT Bus. Posting Group":='LOCAL';
            // GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::" ";
            GenJnLine."Applies-to Doc. No." := Imprest."Property Expense Doc. No";
            GenJnLine.Validate("Currency Code");
            GenJnLine.Validate(Amount);
            GenJnLine.Validate(GenJnLine."Applies-to Doc. No.");
            GenJnLine.Payee := CopyStr(Imprest.Payee, 1, MaxStrLen(GenJnLine.Payee));
            if GenJnLine.Amount <> 0 then
                GenJnLine.Insert();

            /*// Post receipt or payment to  the customer
             LineNo:=LineNo+10000;
             GenJnLine.Init();
                if CMSetup.Get() then
             GenJnLine."Journal Template Name":=JTemplate;
             GenJnLine."Journal Batch Name":=Imprest."No.";
             GenJnLine."Line No.":=LineNo;
             GenJnLine."Account Type":=GenJnLine."Account Type"::Customer;
             GenJnLine."Account No.":=Imprest."Account No.";
             GenJnLine.Validate(GenJnLine."Account No.");
             GenJnLine."Posting Date":=Today;
             GenJnLine."Document No.":=Imprest."No.";
             GenJnLine."External Document No.":=Imprest."Cheque No";
             GenJnLine."Payment Method Code":=Imprest."Pay Mode";
             GenJnLine.Description:=Imprest."Account Name";
             GenJnLine.Amount:=(Imprest."Actual Amount Spent"-Imprest."Imprest Amount");
             GenJnLine."Currency Code":=Imprest.Currency;
             GenJnLine.Validate("Currency Code");
             GenJnLine.Validate(GenJnLine.Amount);
             GenJnLine."Bal. Account Type":=GenJnLine."Account Type"::"Bank Account";
             GenJnLine."Bal. Account No.":=Imprest."Paying Bank Account";
             GenJnLine.Validate("Bal. Account No.");
             GenJnLine."Shortcut Dimension 1 Code":=ImprestLines."Shortcut Dimension 1 Code";
             GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
             GenJnLine."Shortcut Dimension 2 Code":=ImprestLines."Shortcut Dimension 2 Code";
             GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
             GenJnLine."Dimension Set ID":=ImprestLines."Dimension Set ID";
             GenJnLine.Validate(GenJnLine."Dimension Set ID");
             //GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::" ";
             //GenJnLine."Applies-to Doc. No.":=Imprest."Imprest Issue Doc. No";
             GenJnLine.Validate(GenJnLine."Applies-to Doc. No.");
             if GenJnLine.Amount<0 then
             GenJnLine.Insert();*/

            //IMP surrender Lines Entries
            ImprestLines.Reset();
            ImprestLines.SetRange("Payment Type", Imprest."Payment Type");
            ImprestLines.SetRange(No, Imprest."No.");
            if ImprestLines.Find('-') then
                repeat
                    ImprestLines.Validate(ImprestLines.Amount);
                    ImprestLines.TestField(Purpose);
                    LineNo := LineNo + 10000;
                    GenJnLine.Init();
                    GenJnLine."Journal Template Name" := JTemplate;
                    GenJnLine."Journal Batch Name" := JBatch;
                    GenJnLine."Line No." := LineNo;
                    GenJnLine."Account Type" := ImprestLines."Account Type";
                    GenJnLine."Account No." := ImprestLines."Account No";
                    GenJnLine.Validate(GenJnLine."Account No.");
                    if Imprest."Surrender Date" = 0D then
                        Error('You must specify the surrender date');
                    GenJnLine.Validate("Posting Date", Imprest."Payment Release Date");
                    GenJnLine."Document No." := Imprest."No.";
                    //GenJnLine."External Document No.":=Imprest."Imprest Issue Doc. No";
                    GenJnLine.Description := CopyStr(ImprestLines.Purpose, 1, MaxStrLen(GenJnLine.Description));
                    GenJnLine.Amount := ImprestLines."Actual Spent";
                    GenJnLine."Currency Code" := CopyStr(Imprest.Currency, 1, MaxStrLen(GenJnLine."Currency Code"));
                    GenJnLine.Validate("Currency Code");
                    GenJnLine.Validate(GenJnLine.Amount);
                    GenJnLine."Shortcut Dimension 1 Code" := ImprestLines."Shortcut Dimension 1 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                    GenJnLine."Shortcut Dimension 2 Code" := ImprestLines."Shortcut Dimension 2 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                    GenJnLine."Dimension Set ID" := ImprestLines."Dimension Set ID";
                    GenJnLine.Validate(GenJnLine."Dimension Set ID");
                    GenJnLine.Payee := CopyStr(Imprest.Payee, 1, MaxStrLen(GenJnLine.Payee));
                    //GenJnLine."VAT Bus. Posting Group":='LOCAL';
                    //GenJnLine."Gen. Posting Type":=GenJnLine."Gen. Posting Type"::Sale;
                    if GenJnLine.Amount <> 0 then
                        GenJnLine.Insert();

                    if Imprest."Cash Receipt Amount" <> 0 then
                        //Receipt Lines Entries
                        if (ImprestLines."Cash Receipt Amount" <> 0) and (ImprestLines."Imprest Receipt No." = '') then begin
                            ImprestLines.TestField("Receiving Bank");
                            LineNo := LineNo + 10000;
                            GenJnLine.Init();
                            if CMSetup.Get() then
                                GenJnLine."Journal Template Name" := JTemplate;
                            GenJnLine."Journal Batch Name" := JBatch;
                            GenJnLine."Line No." := LineNo;
                            GenJnLine."Account Type" := Imprest."Account Type";
                            GenJnLine."Account No." := Imprest."Account No.";
                            GenJnLine.Validate(GenJnLine."Account No.");
                            GenJnLine.Validate("Posting Date", Imprest."Payment Release Date");
                            GenJnLine."Document No." := Imprest."No.";
                            GenJnLine."External Document No." := Imprest."Cheque No";
                            GenJnLine."Payment Method Code" := CopyStr(Imprest."Pay Mode", 1, MaxStrLen(GenJnLine."Payment Method Code"));
                            GenJnLine.Description := Imprest."Account Name";
                            GenJnLine.Amount := -ImprestLines."Cash Receipt Amount";
                            GenJnLine."Currency Code" := CopyStr(Imprest.Currency, 1, MaxStrLen(GenJnLine."Currency Code"));
                            GenJnLine.Validate("Currency Code");
                            GenJnLine.Validate(GenJnLine.Amount);
                            GenJnLine."Bal. Account Type" := GenJnLine."Account Type"::"Bank Account";
                            GenJnLine."Bal. Account No." := ImprestLines."Receiving Bank";
                            GenJnLine.Validate("Bal. Account No.");
                            GenJnLine."Shortcut Dimension 1 Code" := ImprestLines."Shortcut Dimension 1 Code";
                            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                            GenJnLine."Shortcut Dimension 2 Code" := ImprestLines."Shortcut Dimension 2 Code";
                            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                            GenJnLine."Dimension Set ID" := ImprestLines."Dimension Set ID";
                            GenJnLine.Validate(GenJnLine."Dimension Set ID");
                            //GenJnLine."VAT Bus. Posting Group":='LOCAL';
                            //GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::" ";
                            GenJnLine."Applies-to Doc. No." := Imprest."Property Expense Doc. No";
                            GenJnLine.Validate(GenJnLine."Applies-to Doc. No.");
                            GenJnLine.Payee := CopyStr(Imprest.Payee, 1, MaxStrLen(GenJnLine.Payee));
                            if GenJnLine.Amount <> 0 then
                                GenJnLine.Insert();
                        end;
                until ImprestLines.Next() = 0;

            //CheckIfBalancing(JTemplate,JBatch);
            GenJnLine.Reset();
            GenJnLine.SetRange(GenJnLine."Journal Template Name", JTemplate);
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", JBatch);
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnLine);
            GLEntry.Reset();
            GLEntry.SetRange(GLEntry."Document No.", Imprest."No.");
            GLEntry.SetRange(GLEntry.Reversed, false);
            if not GLEntry.IsEmpty() then begin
                Imprest.Posted := true;
                Imprest."Posted By" := CopyStr(UserId, 1, MaxStrLen(Imprest."Posted By"));
                Imprest."Posted Date" := Today;
                Imprest."Time Posted" := Time;
                Imprest.Surrendered := true;
                Imprest."Surrender Date" := Today;
                Imprest."Surrendered By" := CopyStr(UserId, 1, MaxStrLen(Imprest."Surrendered By"));
                Imprest."Posted Document No." := Imprest."No.";
                Imprest.Modify();
                //Create a Payment Voucher or Petty Cash if there's a receipted amount
                Imprest.CalcFields("Cash Receipt Amount", "Actual Amount Spent", "Imprest Amount");
                if Imprest."Actual Amount Spent" > Imprest."Imprest Amount" then
                    CreatePVPettyCash(Imprest);
                //Uncommit Entries made to the varoius expenses accounts
                //Commitment.UnencumberImprest(Imprest);

                ImprestHeader.Reset();
                ImprestHeader.SetRange(ImprestHeader."No.", Imprest."Property Expense Doc. No");
                if ImprestHeader.Find('-') then begin
                    ImprestHeader.Surrendered := true;
                    ImprestHeader."Surrender Date" := Imprest."Surrender Date";
                    ImprestHeader."Surrendered By" := Imprest."Surrendered By";
                    ImprestHeader.Modify();
                end;

                if Imprest.Apportion then
                    Apportionment.CreatePaymentApportionEntry(Imprest);
            end;
        end;
    end;

    procedure PostStaffClaim(Claim: Record Payments)
    var
        CMSetupRec: Record "Cash Management Setups";
        ChequeRegister: Record "Cheque Register";
        GLEntry: Record "G/L Entry";
        GenJnLine: Record "Gen. Journal Line";
        GLSetupRec: Record "General Ledger Setup";
        ClaimLines: Record "Payment Lines";
        PaymentMethod: Record "Payment Method";
        Commitment: Codeunit "Commitments Mgt Finance";
        ChequePmt: Boolean;
        DocNo: Code[20];
        ShortcutDimValue: array[8] of Code[20];
        LineNo: Integer;
        DimValueName: array[8] of Text;
    begin
        ChequePmt := false;

        /* if not Claim."Confirm Receipt" then
            Error(ConfirmFundsReceiptErr); */

        //Claim.TestField("Confirm Receipt");

        if Confirm('Are you sure you want to post the Staff Claim No. ' + Claim."No." + ' ?') = true then begin
            if Claim.Status <> Claim.Status::Released then
                Error('The Staff Claim No %1 has not been fully approved', Claim."No.");
            if Claim.Posted then
                Error('Staff Claim %1 has been posted', Claim."No.");

            //Get batches
            CashOfficeUserTemplate.Get(UserId);
            JTemplate := CopyStr(CashOfficeUserTemplate."Claim Template", 1, MaxStrLen(JTemplate));
            JBatch := CopyStr(Claim."No.", 1, MaxStrLen(JBatch));// Temp."Claim  Batch";

            if JTemplate = '' then
                Error('Ensure the Claims Template is set up in Cash Office Setup');

            if JBatch = '' then
                Error('Ensure the Claims Batch is set up in the Cash Office Setup');

            //Check Apportionment
            if Claim.Apportion then
                Apportionment.CheckApportionment(Claim."No.");

            Claim.TestField(Date);
            Claim.TestField("Paying Bank Account");
            //Claim.TESTFIELD(Claim.Payee);
            Claim.TestField(Claim."Pay Mode");
            PaymentMethod.Get(Claim."Pay Mode");
            if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then begin
                Claim.TestField(Claim."Cheque No");
                Claim.TestField(Claim."Cheque Date");
                ChequePmt := true;
            end;
            //Check Commitment
            ClaimLines.Reset();
            ClaimLines.SetRange(No, Claim."No.");
            if ClaimLines.Find('-') then
                repeat
                    if IsAccountVotebookEntry(ClaimLines."Account No") then begin
                        Commitment.FetchDimValue(ClaimLines."Dimension Set ID", ShortcutDimValue, DimValueName);
                        GLSetupRec.Get();
                        //DimValue.GET(GLSetup."Shortcut Dimension 1 Code",ShortcutDimValue[1]);
                        //DimValueName:=DimValue.Name;
                        if not Commitment.LineCommitted(Claim."No.", ClaimLines."Account No", ClaimLines."Line No") then
                            Error(Text019, ShortcutDimValue[1] + ' ' + DimValueName[1]);
                    end;
                until ClaimLines.Next() = 0;
            if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then begin
                Claim.TestField("Cheque No");
                Claim.TestField("Cheque Date");
            end;
            //Check Lines
            Claim.CalcFields("Petty Cash Amount");
            if Claim."Petty Cash Amount" = 0 then
                Error('Amount cannot be zero');
            ClaimLines.Reset();
            ClaimLines.SetRange(ClaimLines.No, Claim."No.");
            if not ClaimLines.FindLast() then
                Error('Staff Claim Lines cannot be empty');
            ClaimLines.Reset();
            ClaimLines.SetRange(ClaimLines.No, Claim."No.");
            if ClaimLines.Find('-') then
                repeat
                    ClaimLines.TestField("Expenditure Date");
                    //ClaimLines.TESTFIELD("Claim Receipt No.");
                    ClaimLines.TestField("Expenditure Description");
                until ClaimLines.Next() = 0;
            CMSetupRec.Get();

            //Use separate no series for banks
            if CMSetupRec."Use Bank Pmt Doc Nos" then
                DocNo := NoSeriesMgt.GetNextNo(GetBankPaymentNoSeries(Claim."Paying Bank Account"), 0D, true)
            else
                DocNo := Claim."No.";

            // Delete Lines Present on the General Journal Line
            GenJnLine.Reset();
            GenJnLine.SetRange(GenJnLine."Journal Template Name", JTemplate);
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", JBatch);
            GenJnLine.DeleteAll();

            Batch.Init();
            if CMSetupRec.Get() then
                Batch."Journal Template Name" := JTemplate;
            Batch.Name := JBatch;
            if not Batch.Get(Batch."Journal Template Name", Batch.Name) then
                Batch.Insert();

            //Bank Entries
            LineNo := LineNo + 10000;
            Claim.CalcFields(Claim."Petty Cash Amount");
            ClaimLines.Reset();
            ClaimLines.SetRange(ClaimLines.No, Claim."No.");
            ClaimLines.Validate(ClaimLines.Amount);

            GenJnLine.Init();
            if CMSetupRec.Get() then
                GenJnLine."Journal Template Name" := JTemplate;
            GenJnLine."Journal Batch Name" := JBatch;
            GenJnLine."Line No." := LineNo;
            GenJnLine."Account Type" := GenJnLine."Account Type"::"Bank Account";
            GenJnLine."Account No." := Claim."Paying Bank Account";
            GenJnLine.Validate(GenJnLine."Account No.");
            if Claim.Date = 0D then
                Error('You must specify the Claim date');
            GenJnLine.Validate("Posting Date", Claim."Payment Release Date");
            GenJnLine."Document No." := DocNo;// Claim."No.";
            if ChequePmt then
                GenJnLine."External Document No." := Claim."Cheque No";
            //GenJnLine."Bank Payment Type" := GenJnLine."Bank Payment Type"::"Manual Check"; //inserts check ledger entry
            GenJnLine."Payment Method Code" := CopyStr(Claim."Pay Mode", 1, MaxStrLen(GenJnLine."Payment Method Code"));
            GenJnLine.Description := CopyStr('Staff Claim:' + Claim.Payee, 1, MaxStrLen(GenJnLine.Description));
            GenJnLine.Amount := -Claim."Petty Cash Amount";
            GenJnLine.Validate("Currency Code");
            GenJnLine.Validate(GenJnLine.Amount);
            GenJnLine."Shortcut Dimension 1 Code" := Claim."Shortcut Dimension 1 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := Claim."Shortcut Dimension 2 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
            GenJnLine."Dimension Set ID" := Claim."Dimension Set ID";
            GenJnLine.Validate(GenJnLine."Dimension Set ID");
            GenJnLine.Payee := CopyStr(Claim.Payee, 1, MaxStrLen(GenJnLine.Payee));
            if GenJnLine.Amount <> 0 then
                GenJnLine.Insert();
            //Claim Entries
            ClaimLines.Reset();
            ClaimLines.SetRange(No, Claim."No.");
            if ClaimLines.Find('-') then
                repeat
                    ClaimLines.Validate(ClaimLines.Amount);
                    LineNo := LineNo + 10000;
                    GenJnLine.Init();
                    if CMSetupRec.Get() then
                        GenJnLine."Journal Template Name" := JTemplate;
                    GenJnLine."Journal Batch Name" := JBatch;
                    GenJnLine."Line No." := LineNo;
                    GenJnLine."Account Type" := ClaimLines."Account Type";
                    GenJnLine."Account No." := ClaimLines."Account No";
                    GenJnLine.Validate(GenJnLine."Account No.");
                    GenJnLine.Validate("Posting Date", Claim."Payment Release Date");
                    GenJnLine."Document No." := DocNo;//Claim."No.";
                    GenJnLine."External Document No." := Claim."Cheque No";
                    GenJnLine."Payment Method Code" := CopyStr(Claim."Pay Mode", 1, MaxStrLen(GenJnLine."Payment Method Code"));
                    GenJnLine.Description := CopyStr(ClaimLines.Description, 1, MaxStrLen(GenJnLine.Description));
                    GenJnLine.Amount := ClaimLines.Amount;
                    GenJnLine."Currency Code" := CopyStr(Claim.Currency, 1, MaxStrLen(GenJnLine."Currency Code"));
                    GenJnLine.Validate("Currency Code");
                    GenJnLine.Validate(GenJnLine.Amount);
                    GenJnLine."Shortcut Dimension 1 Code" := ClaimLines."Shortcut Dimension 1 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                    GenJnLine."Shortcut Dimension 2 Code" := ClaimLines."Shortcut Dimension 2 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                    GenJnLine."Dimension Set ID" := ClaimLines."Dimension Set ID";
                    GenJnLine.Payee := CopyStr(Claim.Payee, 1, MaxStrLen(GenJnLine.Payee));
                    //    GenJnLine."Applies-to Doc. No.":=ClaimLines."Applies-to Doc. No.";
                    //    GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");
                    //    GenJnLine."Applies-to ID":=ClaimLines."Applies-to ID";
                    if GenJnLine.Amount <> 0 then
                        GenJnLine.Insert();
                until ClaimLines.Next() = 0;
            //End of Posting Withholding Tax
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnLine);
            GLEntry.Reset();
            GLEntry.SetRange(GLEntry."Document No.", DocNo);
            GLEntry.SetRange(GLEntry.Reversed, false);
            if not GLEntry.IsEmpty() then begin
                Claim.Posted := true;
                Claim."Posted By" := CopyStr(UserId, 1, MaxStrLen(Claim."Posted By"));
                Claim."Posted Date" := Today;
                Claim."Time Posted" := Time;
                Claim."Posted Document No." := DocNo;
                Claim.Modify();

                if Claim."Cheque No" <> '' then begin
                    //Modify Check Ledger-cheque no.
                    CheckLedgerEntry.Reset();
                    CheckLedgerEntry.SetRange(CheckLedgerEntry."Check No.", Claim."No.");
                    if CheckLedgerEntry.FindFirst() then begin
                        CheckLedgerEntry."Check No." := Claim."Cheque No";
                        CheckLedgerEntry."Payments Mgt Generated" := true;
                        CheckLedgerEntry.Modify();
                    end;

                    //Modify Cheque as Posted in cheque register
                    if Claim."Cheque Type" = Claim."Cheque Type"::"Computer Check" then begin
                        ChequeRegister.Reset();
                        ChequeRegister.SetRange(ChequeRegister."Cheque No.", Claim."Cheque No");
                        if ChequeRegister.FindFirst() then begin
                            ChequeRegister."Entry Status" := ChequeRegister."Entry Status"::Posted;
                            ChequeRegister."Cheque Date" := Claim."Cheque Date";
                            ChequeRegister."Posted By" := CopyStr(UserId, 1, MaxStrLen(ChequeRegister."Posted By"));
                            ChequeRegister.Modify();
                        end;
                    end;
                end;

                //Encumber
                Commitment.EncumberPayments(Claim);

                //Apportion Card
                if Claim.Apportion then
                    Apportionment.CreatePaymentApportionEntry(Claim);
            end;
        end;
    end;

    procedure PostVoteTransfer(VotebookTransfer: Record "Votebook Transfer")
    var
        GLAccount: Record "G/L Account";
        GLBudgetEntry: Record "G/L Budget Entry";
        GLSetupRec: Record "General Ledger Setup";
        AllocatedAmount: Decimal;
        BudgetBalance: Decimal;
        CommitmentAmount: Decimal;
        EncumbaranceAmount: Decimal;
        ExpenseAmount: Decimal;
        BudgetErr: Label 'The Amount %1 in Vote transfer No %2 exceeds the Budget By %3 . Total Allocation=%4 , Commitments=%5 , Actuals=%6, Available Budget=%7', Comment = '%1=Amount, %2=Vote Transfer No, %3=Excess Amount, %4=Total Allocation, %5=Commitments, %6=Actuals, %7=Available Budget';
        NoBudgetErr: Label 'No Budget To Check Against', Comment = 'No Budget To Check Against';
        SuccessMsg: Label 'Budget Entry Transferred Successfully';
    begin
        VotebookTransfer.TestField(Date);
        VotebookTransfer.TestField("Budget Name");
        VotebookTransfer.TestField(Amount);
        VotebookTransfer.TestField("Source Vote");
        VotebookTransfer.TestField("Destination Vote");
        //    TESTFIELD("Source Dimension 1");
        //    TESTFIELD("Source Dimension 2");
        //    TESTFIELD("Destination Dimension 1");
        //    TESTFIELD("Destination Dimension 2");
        if VotebookTransfer."Balance As At" = VotebookTransfer."Balance As At"::" " then
            Error('Please select Budget Balance As At');

        GLSetupRec.Get();
        GLSetupRec.TestField("Current Budget");
        GLSetupRec.TestField("Current Budget Start Date");
        GLSetupRec.TestField("Current Budget End Date");

        //Get Source Vote Allocation
        GLAccount.Reset();
        GLAccount.SetRange("No.", VotebookTransfer."Source Vote");
        if VotebookTransfer."Balance As At" = VotebookTransfer."Balance As At"::"End of Financial Year" then
            GLAccount.SetRange("Date Filter", GLSetupRec."Current Budget Start Date", GLSetupRec."Current Budget End Date")
        else
            GLAccount.SetRange("Date Filter", GLSetupRec."Current Budget Start Date", Today);
        GLAccount.SetFilter("Budget Filter", VotebookTransfer."Budget Name");
        GLAccount.SetFilter("Global Dimension 1 Filter", VotebookTransfer."Source Dimension 1");
        GLAccount.SetFilter("Global Dimension 2 Filter", VotebookTransfer."Source Dimension 2");
        if GLAccount.Find('-') then begin
            GLAccount.CalcFields("Approved Budget", Commitment, Encumberance, "Net Change", Balance, "Budgeted Amount");
            AllocatedAmount := GLAccount."Approved Budget";
            CommitmentAmount := GLAccount.Commitment;
            EncumbaranceAmount := GLAccount.Encumberance;
            ExpenseAmount := GLAccount."Net Change";
        end;

        BudgetBalance := AllocatedAmount - (CommitmentAmount + EncumbaranceAmount + ExpenseAmount);

        if BudgetBalance <= 0 then
            Error(NoBudgetErr);

        if VotebookTransfer.Amount > BudgetBalance then
            Error(BudgetErr, VotebookTransfer.Amount, VotebookTransfer.No, (VotebookTransfer.Amount - BudgetBalance), AllocatedAmount, (CommitmentAmount + EncumbaranceAmount), ExpenseAmount, BudgetBalance);

        //Insert budget entries
        GLBudgetEntry.Init();
        GLBudgetEntry."Entry No." := GLBudgetEntry.GetNextEntryNo();
        GLBudgetEntry."Budget Name" := CopyStr(VotebookTransfer."Budget Name", 1, MaxStrLen(GLBudgetEntry."Budget Name"));
        GLBudgetEntry."G/L Account No." := VotebookTransfer."Source Vote";
        GLBudgetEntry.Date := VotebookTransfer.Date;
        GLBudgetEntry."Global Dimension 1 Code" := VotebookTransfer."Source Dimension 1";
        GLBudgetEntry."Global Dimension 2 Code" := VotebookTransfer."Source Dimension 2";
        GLBudgetEntry.Amount := -VotebookTransfer.Amount;
        GLBudgetEntry.Description := CopyStr(VotebookTransfer.Remarks, 1, MaxStrLen(GLBudgetEntry.Description));
        GLBudgetEntry."User ID" := CopyStr(UserId, 1, MaxStrLen(GLBudgetEntry."User ID"));
        GLBudgetEntry.Transferred := true;
        GLBudgetEntry."Transferred from/To Ac." := VotebookTransfer."Destination Vote";
        if not GLBudgetEntry.Get(GLBudgetEntry."Entry No.") then
            GLBudgetEntry.Insert(true);

        GLBudgetEntry.Init();
        GLBudgetEntry."Entry No." := GLBudgetEntry.GetNextEntryNo();
        GLBudgetEntry."Budget Name" := CopyStr(VotebookTransfer."Budget Name", 1, MaxStrLen(GLBudgetEntry."Budget Name"));
        GLBudgetEntry."G/L Account No." := VotebookTransfer."Destination Vote";
        GLBudgetEntry.Date := VotebookTransfer.Date;
        GLBudgetEntry."Global Dimension 1 Code" := VotebookTransfer."Destination Dimension 1";
        GLBudgetEntry."Global Dimension 2 Code" := VotebookTransfer."Destination Dimension 2";
        GLBudgetEntry.Amount := VotebookTransfer.Amount;
        GLBudgetEntry.Description := CopyStr(VotebookTransfer.Remarks, 1, MaxStrLen(GLBudgetEntry.Description));
        GLBudgetEntry."User ID" := CopyStr(UserId, 1, MaxStrLen(GLBudgetEntry."User ID"));
        GLBudgetEntry.Transferred := true;
        GLBudgetEntry."Transferred from/To Ac." := VotebookTransfer."Source Vote";
        if not GLBudgetEntry.Get(GLBudgetEntry."Entry No.") then
            GLBudgetEntry.Insert(true);

        VotebookTransfer.Posted := true;
        VotebookTransfer."Posted By" := CopyStr(UserId, 1, MaxStrLen(VotebookTransfer."Posted By"));
        VotebookTransfer."Posted Date" := Today;
        VotebookTransfer.Modify();
        Message(SuccessMsg);
    end;

    procedure ReopenDocument(var PayRec: Record Payments)
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange("Document No.", PayRec."No.");
        if ApprovalEntry.Find('-') then
            repeat
                ApprovalEntry.Status := ApprovalEntry.Status::Canceled;
                ApprovalEntry.Modify();
            until ApprovalEntry.Next() = 0;

        PayRec.Status := PayRec.Status::Open;
        PayRec.Modify();
    end;

    procedure ViewAppliedEntries(PLines: Record "Payment Lines")
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CustLedgerEntry2: Record "Cust. Ledger Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        VendorLedgerEntry2: Record "Vendor Ledger Entry";
        AppliedCustEntriesCustom: Page "Applied Cust Entries-Custom";
        AppliedVendorEntriesCustom: Page "Applied Vendor Entries-Custom";
    begin
        case PLines."Account Type" of
            PLines."Account Type"::Vendor:
                begin
                    Clear(AppliedVendorEntriesCustom);
                    VendorLedgerEntry.Reset();
                    VendorLedgerEntry.SetRange("Document No.", PLines.No);
                    if VendorLedgerEntry.FindFirst() then begin
                        VendorLedgerEntry2.FilterGroup(10);
                        VendorLedgerEntry2.SetRange("Closed by Entry No.", VendorLedgerEntry."Entry No.");
                        VendorLedgerEntry2.FilterGroup(0);
                        AppliedVendorEntriesCustom.SetTableView(VendorLedgerEntry2);
                        AppliedVendorEntriesCustom.Editable(false);
                        AppliedVendorEntriesCustom.RunModal();
                    end;
                end;
            PLines."Account Type"::Customer:
                begin
                    Clear(AppliedCustEntriesCustom);
                    CustLedgerEntry.Reset();
                    CustLedgerEntry.SetRange("Document No.", PLines.No);
                    if CustLedgerEntry.FindFirst() then begin
                        CustLedgerEntry2.FilterGroup(10);
                        CustLedgerEntry2.SetRange("Closed by Entry No.", CustLedgerEntry."Entry No.");
                        CustLedgerEntry2.FilterGroup(0);
                        AppliedCustEntriesCustom.SetTableView(CustLedgerEntry2);
                        AppliedCustEntriesCustom.Editable(false);
                        AppliedCustEntriesCustom.RunModal();
                    end;
                end;
        end;
    end;

    local procedure AddToNoText(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent := true;
        while StrLen(NoText[NoTextIndex] + ' ' + AddText) > MaxStrLen(NoText[1]) do begin
            NoTextIndex := NoTextIndex + 1;
            if NoTextIndex > ArrayLen(NoText) then
                Error(WText029, AddText);
        end;
        NoText[NoTextIndex] := CopyStr(DelChr(NoText[NoTextIndex] + ' ' + AddText, '<'), 1, 80);
    end;

    local procedure CreatePVPettyCash(Imprest: Record Payments)
    var
        PaymentLines: Record "Payment Lines";
        PaymentRec: Record Payments;
        OptionNumber: Integer;
    begin
        OptionNumber := Dialog.StrMenu(Text021, 0, Text022);

        //Header
        PaymentRec.Init();
        PaymentRec.TransferFields(Imprest);
        PaymentRec."No." := '';
        case OptionNumber of
            1:
                begin
                    PaymentRec."Payment Type" := PaymentRec."Payment Type"::"Petty Cash";
                    PaymentRec."Paying Bank Account" := CopyStr(PaymentRec.GetPettyCashBank(), 1, MaxStrLen(PaymentRec."Paying Bank Account"));
                end;
            2:
                begin
                    PaymentRec."Payment Type" := PaymentRec."Payment Type"::"Payment Voucher";
                    PaymentRec."Paying Bank Account" := Imprest."Paying Bank Account";
                end;
            3:
                begin
                    PaymentRec."Payment Type" := PaymentRec."Payment Type"::"Staff Claim";
                    PaymentRec."Paying Bank Account" := Imprest."Paying Bank Account";
                end;
        end;
        PaymentRec.Status := PaymentRec.Status::Open;
        PaymentRec.Posted := false;
        PaymentRec."Posted By" := '';
        PaymentRec."Posted Date" := 0D;
        PaymentRec."Posting Date" := 0D;
        PaymentRec."Time Posted" := 0T;
        PaymentRec."Posted Document No." := '';
        PaymentRec.Insert(true);
        Imprest.CalcFields("Actual Amount Spent", "Imprest Amount");

        //Lines
        PaymentLines.Init();
        PaymentLines.No := PaymentRec."No.";
        PaymentLines."Line No" := 1000;
        PaymentLines."Account Type" := PaymentLines."Account Type"::Customer;
        PaymentLines."Account No" := Imprest."Account No.";
        PaymentLines.Description := 'Refund';
        PaymentLines.Amount := Imprest."Actual Amount Spent" - Imprest."Imprest Amount";
        PaymentLines.Validate(Amount);
        case OptionNumber of
            1:
                PaymentLines."Payment Type" := PaymentRec."Payment Type"::"Petty Cash";
            2:
                PaymentLines."Payment Type" := PaymentRec."Payment Type"::"Payment Voucher";
            3:
                PaymentLines."Payment Type" := PaymentRec."Payment Type"::"Staff Claim";
        end;
        if PaymentLines.Amount <> 0 then
            PaymentLines.Insert(true);

        case OptionNumber of
            1:
                Page.Run(Page::"Petty Cash", PaymentRec);
            2:
                Page.Run(Page::"Payment Voucher", PaymentRec);
            3:
                Page.Run(Page::"Staff Claim", PaymentRec);
        end;
    end;

    local procedure GetCustAccNo(DocNo: Code[20]) CustNo: Code[20]
    var
        Payments: Record Payments;
    begin
        if Payments.Get(DocNo) then
            CustNo := Payments."Account No.";
    end;

    local procedure GetImprestForReceipt(SurrenderDoc: Code[20]): Code[20]
    var
        Imprest: Record Payments;
        Payments: Record Payments;
    begin
        if Payments.Get(SurrenderDoc) then
            if Imprest.Get(Payments."Imprest Issue Doc. No") then
                exit(Imprest."Imprest Posted by PV");
    end;

    local procedure GetImprestPostedPV(ImpDocNo: Code[50]): Code[50]
    var
        ImpSurr: Record Payments;
    begin
        if ImpSurr.Get(ImpDocNo) then
            if ImpSurr."Imprest Posted by PV" <> '' then
                exit(ImpSurr."Imprest Posted by PV")
            else
                exit(ImpSurr."Imprest Issue Doc. No");
    end;

    procedure GetBudgetLineBalance(PaymentLinesRec: Record "Payment Lines"; var CurrentBalance: Decimal; var BalanceAfter: Decimal)
    var
        CommitmentEntries: Record "Commitment Entries";
        GLAccount: Record "G/L Account";
        GenLedSetup: Record "General Ledger Setup";
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
    begin
        GenLedSetup.Get();
        GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
        GLAccount.SetRange(GLAccount."No.", PaymentLinesRec."Account No");
        GLAccount.SetRange(GLAccount."Dimension Set ID Filter", PaymentLinesRec."Dimension Set ID");

        GetPaymentHeader(PaymentLinesRec);

        //Get budget amount avaliable
        GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", PaymentsRec.Date);
        if GLAccount.Find('-') then begin
            GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget");
            BudgetAvailable := GLAccount."Approved Budget" - GLAccount."Net Change";
        end;

        //Get committed Amount
        CommittedAmount := 0;
        CommitmentEntries.Reset();
        CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
        CommitmentEntries.SetRange(CommitmentEntries.Account, PaymentLinesRec."Account No");
        CommitmentEntries.SetRange(CommitmentEntries."Dimension Set ID", PaymentLinesRec."Dimension Set ID");
        CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
        if PaymentsRec.Date = 0D then
            Error('Please insert the header date');
        CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date",
                                  PaymentsRec.Date);
        CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
        CommittedAmount := CommitmentEntries."Committed Amount";

        CurrentBalance := BudgetAvailable - CommittedAmount;
        BalanceAfter := Abs(BudgetAvailable - (CommittedAmount + PaymentLinesRec.Amount));
    end;

    local procedure GetPaymentHeader(PLines: Record "Payment Lines")
    begin
        if PaymentsRec.Get(PLines.No) then;
    end;

    procedure GenerateEFT(PaymentRec: Record Payments): Boolean
    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        PaymentLines: Record "Payment Lines";
        TempBlob: Codeunit "Temp Blob";
        XlsxInStream: InStream;
        DialogTitleTok: Label 'Generate EFT as Xlsx';
        FileNameTok: Label '%1_EFT-%2.xlsx', Comment = '%1 = PV no. %2 = Current Date', Locked = true;
        XlsxFilterTok: Label 'Xlsx Files (*.xlsx)|*.xlsx';
        XlsxOutStream: OutStream;
        FileName: Text;
    begin
        CreateEFTHeader(TempExcelBuffer);

        PaymentLines.Reset();
        PaymentLines.SetRange(No, PaymentRec."No.");
        if PaymentLines.FindSet() then
            repeat
                CreateEFTLine(PaymentRec, PaymentLines, TempExcelBuffer);
            until PaymentLines.Next() = 0;

        TempExcelBuffer.CreateNewBook(CopyStr(PaymentRec.TableCaption(), 1, 250));
        TempExcelBuffer.WriteSheet(PaymentRec.TableCaption(), CompanyName(), UserId());
        TempExcelBuffer.CloseBook();

        TempBlob.CreateOutStream(XlsxOutStream, TextEncoding::UTF8);
        TempExcelBuffer.SaveToStream(XlsxOutStream, true);
        TempBlob.CreateInStream(XlsxInStream, TextEncoding::UTF8);

        FileName := StrSubstNo(FileNameTok, PaymentRec."No.", CurrentDateTime());
        exit(File.DownloadFromStream(XlsxInStream, DialogTitleTok, '', XlsxFilterTok, FileName));
    end;

    local procedure CreateEFTHeader(var TempExcelBuffer: Record "Excel Buffer")
    begin
        TempExcelBuffer.Reset();
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('Name', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Amount', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn('Ref_No', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Account_No', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Bank_Code', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('RTGS(Y/N)', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Bene Address 1', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Bene Address 2', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Payment_Details 1', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Payment_Details 2', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Payment_Details 3', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Payment_Details 4', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
    end;

    local procedure CreateEFTLine(Payments: Record Payments; PaymentLineRec: Record "Payment Lines"; var TempExcelBuffer: Record "Excel Buffer")
    var
        Vendor: Record Vendor;
        VendorBank: Record "Vendor Bank Account";
    begin
        GetVendor(Vendor, PaymentLineRec."Account No");
        GetVendorBankDetails(VendorBank, PaymentLineRec."Account No");

        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(PaymentLineRec."Account Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(PaymentLineRec.Amount, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(Payments."EFT Reference", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(VendorBank."Bank Account No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(StrSubstNo(VendorBank.Code + VendorBank."Bank Branch No."), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Y', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Vendor.Address, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Vendor."Address 2", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(PaymentLineRec.Description, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
    end;

    procedure GetVendorBankDetails(var VendorBank: Record "Vendor Bank Account"; VendorNo: Code[50])
    var
        Vendor: Record Vendor;
    begin
        if Vendor.Get(VendorNo) then begin
            VendorBank.Reset();
            VendorBank.SetRange("Vendor No.", VendorNo);
            if VendorBank.FindFirst() then;
        end;
    end;

    local procedure GetVendor(var Vendor: Record Vendor; VendorNo: Code[50])
    begin
        if Vendor.Get(VendorNo) then;
    end;

    procedure GeneratePVBankTemplate(PaymentRec: Record Payments): Boolean
    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        PaymentLines: Record "Payment Lines";
        TempBlob: Codeunit "Temp Blob";
        XlsxInStream: InStream;
        DialogTitleTok: Label 'Generate EFT as csv';
        FileNameTok: Label '%1_EFT-%2.csv', Comment = '%1 = File no. %2 = Current Date', Locked = true;
        XlsxFilterTok: Label 'Xlsx Files (*.csv)|*.csv';
        XlsxOutStream: OutStream;
        FileName: Text;
    begin

        CreatePVHeaderBankTemplate(PaymentRec, TempExcelBuffer);
        PaymentLines.Reset();
        PaymentLines.SetRange(No, PaymentRec."No.");
        if PaymentLines.FindSet() then
            repeat
                CreatePVLineBankTemplate(PaymentLines, TempExcelBuffer);
            until PaymentLines.Next() = 0;

        //CreateStoreFilePV(PaymentRec, StrSubstNo(FileNameTok, CurrentDateTime(), PaymentRec."No."));

        TempExcelBuffer.CreateNewBook(CopyStr(PaymentRec.TableCaption(), 1, 250));
        TempExcelBuffer.WriteSheet(PaymentRec.TableCaption(), CompanyName(), UserId());
        TempExcelBuffer.CloseBook();

        TempBlob.CreateOutStream(XlsxOutStream, TextEncoding::UTF8);
        TempExcelBuffer.SaveToStream(XlsxOutStream, true);
        TempBlob.CreateInStream(XlsxInStream, TextEncoding::UTF8);
        FileName := StrSubstNo(FileNameTok, CurrentDateTime(), PaymentRec."No.");
        exit(File.DownloadFromStream(XlsxInStream, DialogTitleTok, '', XlsxFilterTok, FileName));
    end;

    local procedure CreatePVHeaderBankTemplate(PaymentRec: Record Payments; var TempExcelBuffer: Record "Excel Buffer")
    var
        BankDetails: Record "Bank Account";
    begin
        PaymentRec.CalcFields("Total Amount");
        if BankDetails.Get(PaymentRec."Account No.") then;
        TempExcelBuffer.Reset();
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('BInSol - U ver 1.00', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);

        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(Format(PaymentRec."Payment Release Date"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(BankDetails."Bank Account No.", false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('Name', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Amount', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Ref', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Account No', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Bank_Code', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('RTGS(Y/N)', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Bene Address 1', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Bene Address 2', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Payment_Details 1', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Payment_Details 2', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Payment_Details 3', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Payment_Details 4', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);

        /*
                TempExcelBuffer.AddColumn('RECIPIENT ACCOUNT TYPE', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('BRANCHCODE', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('AMOUNT', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('OWN REFERENCE', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('RECIPIENT REFERENCE', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text); */
    end;

    local procedure CreatePVLineBankTemplate(PaymentLineRec: Record "Payment Lines"; var TempExcelBuffer: Record "Excel Buffer")
    begin
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(PaymentLineRec."Account Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Format(PaymentLineRec.Amount, 0, '<Precision,2:2><Standard Format,2>'), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(PaymentLineRec."Bank Account No", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn('Y', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(1, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn('NAIROBI', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(PaymentLineRec.Description, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(PaymentLineRec.Purpose, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);

        //TempExcelBuffer.AddColumn(PaymentLine."Bank Account Branch", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
    end;

    procedure GetBankPaymentNoSeries(BankAcc: Code[20]): Code[20]
    var
        BankAccRec: Record "Bank Account";
    begin
        if BankAccRec.Get(BankAcc) then begin
            BankAccRec.TestField("Payment Document Nos");
            exit(BankAccRec."Payment Document Nos");
        end;
    end;

    procedure SendPaymentAdviceViaMail(PaymentRec: Record Payments)
    var
        CompanyInfo: Record "Company Information";
        PaymentLines: Record "Payment Lines";
        PaymentCopy: Record Payments;
        Vendor: Record Vendor;
        PaymentAdvice: Report "Payment Advice";
        Base64Conv: Codeunit "Base64 Convert";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        Inst: InStream;
        NewBodyMsg: Label '<p style="font-family:Verdana,Arial;font-size:10pt">To<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:10pt">Please find attached your payment advice for Payment No. <strong>%2<strong>:%4.</p><p style="font-family:Verdana,Arial;font-size:10pt">Regards,<br>%3.</p>', Comment = '%1=Vendor Name, %2=Payment No, %3=Company Name, %4=Payment Narration';
        Recipient: List of [Text];
        OutS: OutStream;
        Base64Txt, FileName : Text;
        EmailBody: Text;
        Subject: Text;
    begin
        CompanyInfo.Get();

        PaymentCopy.SetRange("No.", PaymentRec."No.");
        if PaymentCopy.FindFirst() then begin
            PaymentLines.SetRange(No, PaymentCopy."No.");
            PaymentLines.SetRange("Account Type", PaymentLines."Account Type"::Vendor);
            if PaymentLines.FindFirst() then
                if Vendor.Get(PaymentLines."Account No") then begin
                    Subject := 'Payment Advice - ' + PaymentCopy."No.";
                    Clear(Recipient);
                    Vendor.TestField("E-Mail");
                    Recipient.Add(Vendor."E-Mail");
                    FileName := 'Payment Advice ' + PaymentCopy."No." + '.pdf';
                    EmailBody := StrSubstNo(NewBodyMsg, Vendor.Name, PaymentCopy."No.", CompanyInfo.Name, PaymentCopy."Payment Narration");
                    EmailMessage.Create(Recipient, Subject, EmailBody, true);

                    Clear(PaymentAdvice);
                    PaymentAdvice.SetTableView(PaymentCopy);
                    TempBlob.CreateOutStream(OutS);
                    if PaymentAdvice.SaveAs('', ReportFormat::Pdf, OutS) then begin
                        TempBlob.CreateInStream(Inst);
                        Base64Txt := Base64Conv.ToBase64(Inst, true);
                        EmailMessage.AddAttachment(CopyStr(FileName, 1, 250), 'application/pdf', Base64Txt);
                    end;

                    if Email.Send(EmailMessage) then begin
                        PaymentCopy."Payment Advice Sent" := true;
                        PaymentCopy.Modify();

                        Message('Payment Advice Sent Successfully');
                    end;
                end;
        end;
    end;
}
