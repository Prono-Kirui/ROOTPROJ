codeunit 50452 "CFT Factory"
{
    procedure FnMobileLoanAppraisal(MNo: Code[50]): Decimal
    var
        ApprovedAmount: Decimal;
        Product: Code[20];
        TotalDeposits: Decimal;
        TotalShares: Decimal;
        FreeSharesAmount: Decimal;
        vintage: Decimal;
        DepositContributionCount: Decimal;
        MemberName: Text;
        MaximumAmount: Decimal;
        MobileLoanCount: Integer;
        msg: Text;
        LastDisbursedDate: Date;
        LoanBal: Decimal;
    begin
        Product := 'RUAIMOBI';
        ApprovedAmount := 0;
        ObjCust.RESET;
        ObjCust.SETRANGE("No.", MNo);
        ObjCust.SETFILTER(Status, '%1', ObjCust.Status::Active);
        ObjCust.SETFILTER("Date Filter", '..%1', TODAY);
        IF ObjCust.FIND('-') THEN BEGIN
            ObjCust.CALCFIELDS("Current Shares", "Insurance Fund", "Un-allocated Funds", "Dividend Amount", "Shares Retained");
            TotalDeposits := ObjCust."Current Shares";
            TotalShares := ObjCust."Shares Retained";

            // Calculate Free Shares by considering actual loan outstanding balances
            FreeSharesAmount := CalculateEffectiveGuarantees(MNo);
            FreeSharesAmount := ObjCust."Current Shares" - FreeSharesAmount;

            MemberName := ObjCust.Name;

            // if ObjCust."Registration Date" <> 0D then begin
            //     vintage := ROUND((TODAY - ObjCust."Registration Date") / 30, 1, '<');
            // end else begin
            //     MESSAGE('Registration Date is not set');
            //     FnLogMobileDisqualification(MNo, 'Registration Date is not set', MemberName, ApprovedAmount);
            //     EXIT(ApprovedAmount);
            // end;

            //1=============ACCOUNT BLOCKED FOR MOBILE LOAN========================
            IF ObjCust."Mobile Loan Blocked" THEN BEGIN
                MESSAGE('Account Blocked');
                FnLogMobileDisqualification(MNo, 'Member Blocked for Mobile', MemberName, ApprovedAmount);
                EXIT(ApprovedAmount);
            END;

            //2=============MEMBERSHIP PERIOD MORE OR EQUAL TO 6 MONTHS========================
            // IF vintage < 6 THEN BEGIN
            //     Message('Your Existence is Less than 6 Months');
            //     FnLogMobileDisqualification(MNo, 'Your Existence is Less than 6 Months', MemberName, ApprovedAmount);
            //     EXIT(ApprovedAmount);
            // END;

            //3=============Minimum Deposit Contribution=2,000 =========================================
            IF TotalDeposits < 2000 THEN BEGIN
                Message('Total Deposit Contribution is below the allowed minimum of KES 2,000.Your Current Total Deposit Contribution=' + FORMAT(TotalDeposits));
                FnLogMobileDisqualification(MNo, 'Total Deposit Contribution is below the allowed minimum of KES 2,000.Your Current Total Deposit Contribution=' + FORMAT(TotalDeposits), MemberName, ApprovedAmount);
                EXIT(ApprovedAmount);
            END;

            //4============= Minimum Free Shares=1,000 =========================================           

            IF FreeSharesAmount < 1000 THEN BEGIN
                Message('Your available Deposit Contribution(Free Shares) is below the allowed minimum of KES 1,000. Your Current Free Shares =' + FORMAT(FreeSharesAmount));
                FnLogMobileDisqualification(MNo, 'Your available Free Shares is below the allowed minimum of KES 1,000. Your Current Free Shares =' + FORMAT(FreeSharesAmount), MemberName, ApprovedAmount);
                EXIT(ApprovedAmount);
            END;


            //5=============NO EXISTING PENDING NEW MOBILE LOAN=========================================
            ObjLoans.RESET;
            ObjLoans.SETRANGE("Loan Product Type", 'RUAIMOBI');
            ObjLoans.SETRANGE("Client Code", MNo);
            ObjLoans.SETRANGE(Posted, FALSE);
            ObjLoans.SETRANGE("Failed Mobile Loan Request", FALSE);
            IF ObjLoans.FINDLAST THEN BEGIN
                MESSAGE('You have Pending unposted Mobile Loan-' + ObjLoans."Loan  No.");
                FnLogMobileDisqualification(MNo, 'You have Pending unposted Mobile Loan-' + ObjLoans."Loan  No.", MemberName, ApprovedAmount);
                EXIT(0);
            END;

            //6=============NO EXISTING UNCLEARED MOBILE LOAN ========================================
            ObjLoans.RESET;
            ObjLoans.SETRANGE("Client Code", MNo);
            ObjLoans.SETRANGE("Loan Product Type", 'RUAIMOBI');
            ObjLoans.SETRANGE(Posted, TRUE);
            IF ObjLoans.FIND('-') THEN BEGIN
                REPEAT
                    ObjLoans.CALCFIELDS("Outstanding Balance", "Oustanding Interest to Date");
                    IF ((ObjLoans."Outstanding Balance" > 0) OR (ObjLoans."Oustanding Interest to Date" > 0)) THEN BEGIN
                        MESSAGE('You have uncleared Mobile Loan-' + ObjLoans."Loan  No." + ' of ' + FORMAT(ObjLoans."Outstanding Balance"));
                        FnLogMobileDisqualification(MNo, 'You have uncleared Mobile Loan-' + ObjLoans."Loan  No." + ' of ' + FORMAT(ObjLoans."Outstanding Balance"), MemberName, ApprovedAmount);
                        EXIT(0);
                    END;
                UNTIL ObjLoans.NEXT = 0;
            END;

            //7=============NOT TAKE MORE THAN 2 MOBILE LOANS A DAY ========================================
            MobileLoanCount := 0;
            ObjLoans.RESET;
            ObjLoans.SETRANGE("Client Code", MNo);
            ObjLoans.SETRANGE("Loan Product Type", 'RUAIMOBI');
            ObjLoans.SETRANGE(Posted, TRUE);
            ObjLoans.SetRange("Application Date", Today);
            ObjLoans.SETFILTER("Outstanding Balance", '<=0');
            IF ObjLoans.FIND('-') THEN BEGIN
                REPEAT
                    MobileLoanCount := MobileLoanCount + 1;
                UNTIL ObjLoans.NEXT = 0;
                IF MobileLoanCount >= 2 then begin
                    MESSAGE('You have reached Mobile Loan Daily Limit');
                    FnLogMobileDisqualification(MNo, 'You have reached Mobile Loan Daily Limit', MemberName, ApprovedAmount);
                    EXIT(ApprovedAmount);
                end;
            END;

            //9=============PROCESS MOBILE LOAN APPRAISAL ========================================        

            if FreeSharesAmount < 1000 then
                ApprovedAmount := 0
            else if FreeSharesAmount > 10000 then
                ApprovedAmount := 10000
            else
                ApprovedAmount := FreeSharesAmount;

            MESSAGE('Member OK');
            FnLogMobileDisqualification(MNo, 'Member OK', MemberName, ApprovedAmount);
            EXIT(ApprovedAmount);
        END;
    end;

    procedure FnRecoverDefaultedMobileLoans()
    var
        LineNo: Integer;
        TotalDue: Decimal;
        AvailableDeposit: Decimal;
        msg: Text;
        ObjCust: Record Customer;
    begin

        ObjLoans.RESET;
        ObjLoans.SETRANGE(Posted, TRUE);
        ObjLoans.SETRANGE("Mobile Loan Recovered", FALSE);
        ObjLoans.SETRANGE("Loan Product Type", 'RUAIMOBI');
        ObjLoans.SETFILTER("Expected Date Of Completion", '<%1', CalcDate('-5D', TODAY));
        IF ObjLoans.FINDSET() THEN
            REPEAT
                ObjLoans.CALCFIELDS("Outstanding Balance");
                ObjCust.GET(ObjLoans."Client Code");
                ObjCust.CalcFields("Current Shares");
                IF ObjLoans."Outstanding Balance" > 0 THEN BEGIN
                    AvailableDeposit := ObjCust."Current Shares" - CalculateEffectiveGuarantees(ObjLoans."Client Code");
                    Message('Processing Loan No: %1 with Outstanding Balance %2, Available Deposit %3', ObjLoans."Loan  No.", ObjLoans."Outstanding Balance", AvailableDeposit);
                    TotalDue := ObjLoans."Outstanding Balance";
                    IF AvailableDeposit >= TotalDue then begin
                        // Start batch
                        FnHandleBatch('GENERAL', 'MOBIREC', 'Default Loan Recovery Batch', GenJournalLine, 'CREATE');

                        // Debit member deposit
                        LineNo := LineNo + 1000;
                        FnGenerateGeneralJournalLine('GENERAL', 'MOBIREC', LineNo, '', Today, ObjLoans."Loan  No.", COPYSTR(STRSUBSTNO('RUAIMOBI Loan Recovery/%1', ObjLoans."Loan  No."), 1, 35), GenJournalLine."Account Type"::Customer, ObjLoans."Client Code", TotalDue, 'Loan Recovery ' + ObjLoans."Client Code", GenJournalLine."Transaction Type"::"Deposit Contribution", ObjLoans."Loan  No.", 'BOSA', 'RUAIMOBI', '', '', '');

                        //------------------CREDIT OUTSTANDING BALANCE-------------------------------------------------------

                        LineNo := LineNo + 1000;
                        FnGenerateGeneralJournalLine('GENERAL', 'MOBIREC', LineNo, '', Today, ObjLoans."Loan  No.", ObjLoans."Client Code", GenJournalLine."Account Type"::Customer, ObjLoans."Client Code", -1 * TotalDue, 'Loan Repayment ' + ObjLoans."Loan  No.",
                        GenJournalLine."Transaction Type"::"Loan Repayment", ObjLoans."Loan  No.", 'BOSA', 'RUAIMOBI', '', '', '');

                        FnHandleBatch('GENERAL', 'MOBIREC', 'Default Loan Recovery Batch', GenJournalLine, 'POST');

                        ObjLoans."Recovered Arrears Amount" := TotalDue;
                        ObjLoans."Mobile Loan Recovered" := TRUE;
                        ObjLoans."Mobile Loan Recovered By" := UserId;
                        ObjLoans."Mobile Loan Recovery Date" := Today;
                        ObjLoans.MODIFY();


                        msg := STRSUBSTNO('Your RUAIMOBI Loan No. %1 of KES %2 was fully recovered from your deposit contribution.', ObjLoans."Loan  No.", TotalDue);
                        SMSMessage(ObjLoans."Loan  No.", ObjLoans."Client Code", ObjCust."Phone No.", msg, 'RUAIMOBIREC');
                    end;

                end;

            UNTIL ObjLoans.NEXT = 0;

    End;



    procedure FnSendMobileLoanReminders()
    begin
        RunOneDayAfterLoanCompletionDate();
        RunOneDayBeforeLoanCompletionDate();
        RunSevenDayBeforeLoanCompletionDate();
    end;

    procedure RunOneDayAfterLoanCompletionDate()
    var
        Msg: Text;
        LoanBal: Decimal;
        ObjLoans: Record "Loans Register";
        ObjCust: Record Customer;
    begin
        ObjLoans.Reset();
        ObjLoans.SetRange("Loan Product Type", 'RUAIMOBI');
        ObjLoans.SetRange("1D After Loan Completion Date", false);
        ObjLoans.SetFilter("Expected Date of Completion", '<=%1', Today - 1);

        if ObjLoans.FindSet() then
            repeat
                ObjLoans.CalcFields("Outstanding Balance");
                LoanBal := ObjLoans."Outstanding Balance";

                if (ObjCust.Get(ObjLoans."Client Code"))
                   and (ObjCust."Phone No." <> '')
                   and (LoanBal > 0) then begin

                    Msg :=
                      'Dear ' + ObjLoans."Client Name" +
                      ', Your Mobile Loan No. ' + ObjLoans."Loan  No." +
                      ' of KES ' + Format(LoanBal) +
                      ' was due on ' +
                      Format(ObjLoans."Expected Date of Completion", 0, '<Day,2>-<Month,2>-<Year4>') +
                      '. Kindly Dial *670# to repay and avoid penalties.';

                    SMSMessage(
                        ObjLoans."Loan  No.",
                        ObjLoans."Client Code",
                        ObjCust."Phone No.",
                        Msg,
                        'MOBILOANREMINDER'
                    );

                    ObjLoans."1D After Loan Completion Date" := true;
                    ObjLoans.Modify();
                end;
            until ObjLoans.Next() = 0;
    end;



    procedure RunOneDayBeforeLoanCompletionDate()
    var
        Msg: Text;
        LoanBal: Decimal;
        ObjLoans: Record "Loans Register";
        ObjCust: Record Customer;
        RunDate: Date;
    begin

        ObjLoans.Reset();
        ObjLoans.SetRange("Loan Product Type", 'RUAIMOBI');
        ObjLoans.SetRange("1D Before Loan Completion Date", false);
        ObjLoans.SetFilter("Expected Date of Completion", '%1..%1', Today + 1);

        if ObjLoans.FindSet() then
            repeat
                ObjLoans.CalcFields("Outstanding Balance");
                LoanBal := ObjLoans."Outstanding Balance";
                if (ObjCust.Get(ObjLoans."Client Code")) and (ObjCust."Phone No." <> '') and (LoanBal > 0) then begin
                    Msg :=
                     'Dear ' + ObjLoans."Client Name" +
                     ', Your Mobile Loan No. ' + ObjLoans."Loan  No." +
                     ' of KES ' + Format(LoanBal) +
                     ' is due tomorrow (' +
                     Format(ObjLoans."Expected Date of Completion", 0, '<Day,2>-<Month,2>-<Year4>') +
                     '). Kindly Dial *670# to repay and avoid penalties.';

                    SMSMessage(
                        ObjLoans."Loan  No.",
                        ObjLoans."Client Code",
                        ObjCust."Phone No.",
                        Msg,
                        'MOBILOANREMINDER'
                    );

                    ObjLoans."1D Before Loan Completion Date" := true;
                    ObjLoans.Modify();
                end;
            until ObjLoans.Next() = 0;
    end;

    procedure RunSevenDayBeforeLoanCompletionDate()
    var
        Msg: Text;
        LoanBal: Decimal;
        ObjLoans: Record "Loans Register";
        ObjCust: Record Customer;
    begin

        ObjLoans.Reset();
        ObjLoans.SetRange("Loan Product Type", 'RUAIMOBI');
        ObjLoans.SetRange("7D Before Loan Completion Date", false);
        ObjLoans.SetFilter("Expected Date of Completion", '=%1', Today + 7);

        if ObjLoans.FindSet() then
            repeat
                ObjLoans.CalcFields("Outstanding Balance");
                LoanBal := ObjLoans."Outstanding Balance";

                if (ObjCust.Get(ObjLoans."Client Code")) and (ObjCust."Phone No." <> '') and (LoanBal > 0) then begin
                    Message('Processing Loan No: %1 for %2', ObjLoans."Loan  No.", ObjCust."Phone No.");

                    Msg :=
                      'Dear ' + ObjLoans."Client Name" +
                      ', Your Mobile Loan No. ' + ObjLoans."Loan  No." +
                      ' of KES ' + Format(LoanBal) +
                      ' is due in 7 days on ' +
                      Format(ObjLoans."Expected Date of Completion", 0, '<Day,2>-<Month,2>-<Year4>') +
                      '. Kindly Dial *670# to repay.';

                    SMSMessage(
                        ObjLoans."Loan  No.",
                        ObjLoans."Client Code",
                        ObjCust."Phone No.",
                        Msg,
                        'MOBILOANREMINDER'
                    );

                    ObjLoans."7D Before Loan Completion Date" := true;
                    ObjLoans.Modify();
                end;
            until ObjLoans.Next() = 0;
    end;


    procedure FnLogMobileDisqualification(MemberNo: Code[20]; Reason: Text[150]; MemberName: Text; QualifiedAmount: Decimal)
    var
        MobileLoanAppraisal: Record "Mobile Loan Appraisal Logs";
        txtMessage: Text;
    begin
        txtMessage := '';
        MobileLoanAppraisal.RESET;
        MobileLoanAppraisal.SETRANGE("Member No", MemberNo);
        IF MobileLoanAppraisal.FIND('-') THEN BEGIN
            MobileLoanAppraisal."Member Name" := MemberName;
            MobileLoanAppraisal."Qualified Amount" := QualifiedAmount;
            MobileLoanAppraisal."Disqualification Reason" := Reason;
            MobileLoanAppraisal."Transaction Date" := Today;
            MobileLoanAppraisal.MODIFY;
        END ELSE BEGIN
            MobileLoanAppraisal."Member No" := MemberNo;
            MobileLoanAppraisal."Member Name" := MemberName;
            MobileLoanAppraisal."Qualified Amount" := QualifiedAmount;
            MobileLoanAppraisal."Disqualification Reason" := Reason;
            MobileLoanAppraisal."Transaction Date" := Today;
            MobileLoanAppraisal.INSERT;

        END;

        IF Reason <> 'Member:OK' THEN BEGIN
            ObjCust.RESET;
            ObjCust.SETRANGE("No.", MemberNo);
            IF ObjCust.FINDFIRST THEN BEGIN
                txtMessage := 'Dear ' + MemberName + ', You are not qualified for Mobile Loan. Reason: ' + Reason;
                // SMSMessage(MemberNo, MemberNo, ObjCust."Phone No.", txtMessage, 'LOANAPPRAISAL');
            END;
        END;
    end;


    procedure FnLogMobileLoan(MNo: Code[20]; LoanAmount: Decimal; cft_reference: Code[20]; repayment_period: Integer) Processed: Code[150]
    var
        InterestRate: Decimal;
        DocNumber: Code[30];
        ObjLoan: Record "Loans Register";
        DFormula: DateFormula;
        GeneralSetup: Record "BO General Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        Processed := 'FALSE';
        IF LoanAmount > 10000 THEN EXIT('FALSE');

        ObjLoanProduct.RESET;
        ObjLoanProduct.SETRANGE(ObjLoanProduct."Code", 'RUAIMOBI');
        IF ObjLoanProduct.FIND('-') THEN BEGIN
            InterestRate := ObjLoanProduct."Interest rate";
            ObjCust.RESET;
            ObjCust.SETRANGE(ObjCust."No.", MNo);
            IF ObjCust.FIND('-') THEN BEGIN

                IF DocNumber = '' THEN BEGIN
                    GeneralSetup.GET;
                    GeneralSetup.TESTFIELD(GeneralSetup."RuaiMobi Loan Nos");
                    NoSeriesMgt.InitSeries(GeneralSetup."RuaiMobi Loan Nos", GeneralSetup."RuaiMobi Loan Nos", 0D, DocNumber, GeneralSetup."RuaiMobi Loan Nos");
                END;


                ObjLoan.INIT;
                ObjLoan."Loan  No." := DocNumber;
                ObjLoan."Client Code" := MNo;
                ObjLoan.VALIDATE(ObjLoan."Client Code");
                ObjLoan.Source := ObjLoan.Source::BOSA;
                ObjLoan."Application Date" := TODAY;
                ObjLoan."BOSA No" := MNo;
                ObjLoan."Loan Product Type" := ObjLoanProduct.Code;
                ObjLoan."Loan Product Type Name" := ObjLoanProduct."Product Description";
                ObjLoan."Loan Status" := ObjLoan."Loan Status"::Issued;
                ObjLoan."Client Name" := ObjCust.Name;
                ObjLoan."Posting Date" := TODAY;
                ObjLoan."Loan Disbursement Date" := TODAY;
                ObjLoan.VALIDATE("Loan Disbursement Date");
                ObjLoan.Installments := repayment_period;
                EVALUATE(DFormula, FORMAT(repayment_period) + 'M');
                ObjLoan."Instalment Period" := DFormula;
                ObjLoan."Expected Date of Completion" := CALCDATE('1M', TODAY);
                ObjLoan.Repayment := LoanAmount;
                ObjLoan."Staff No" := ObjCust."Personal No";
                ObjLoan."Repayment Method" := ObjLoanProduct."Repayment Method";
                ObjLoan."Repayment Frequency" := ObjLoanProduct."Repayment Frequency";
                ObjLoan."Requested Amount" := ROUND(LoanAmount, 0.05, '>');
                ObjLoan."Approved Amount" := ROUND(LoanAmount, 0.05, '>');
                ObjLoan."Amount Disbursed" := ROUND(LoanAmount, 0.05, '>');
                ObjLoan."Loan Principle Repayment" := LoanAmount / repayment_period;
                ObjLoan.Interest := InterestRate;
                ObjLoan."Mode of Disbursement" := ObjLoan."Mode of Disbursement"::"Bank Transfer";
                ObjLoan."Approval Status" := ObjLoan."Approval Status"::Approved;
                ObjLoan.Posted := FALSE;
                ObjLoan."Advice Date" := TODAY;
                ObjLoan."Captured By" := UserId;
                ObjLoan."System Created" := TRUE;
                ObjLoan."CFT Reference No" := cft_reference;
                ObjLoan.Insert();
            END;
        END;
        Processed := 'TRUE';
        EXIT(Processed);
    end;




    procedure FnProcessMobileLoan(ObjLoan: Record "Loans Register"): Code[20]
    var
        Completed: Code[20];
    begin
        Completed := 'FALSE';
        FnPostMobileLoan(ObjLoan."Loan  No.", ObjLoan."CFT Reference No");
        Completed := 'TRUE';
        EXIT(Completed);
    end;

    procedure FnPostMobileLoan(LoanNo: Code[50]; cft_reference: Code[20])
    var
        LineNo: Integer;
        InterestDue: Decimal;
        msg: Text;
        CreditedAmt: Decimal;
        LoanInterestAccount: Code[50];
        MobileCommissionAccount: Code[50];
        InterestReceivableAccount: Code[50];
        GeneralSetup: Record "BO General Setup";
    begin
        ObjLoans.RESET;
        ObjLoans.SETRANGE("Loan  No.", LoanNo);
        ObjLoans.SETRANGE(Posted, FALSE);
        IF ObjLoans.FIND('-') THEN BEGIN
            ObjLoans.CALCFIELDS("Outstanding Balance");
            IF ObjLoans."Outstanding Balance" = 0 THEN BEGIN
                ObjLoanProduct.GET(ObjLoans."Loan Product Type");
                ObjLoanProduct.TestField("Loan Interest Account");

                InterestDue := ObjLoans."Approved Amount" * (ObjLoans.Interest / 100);

                FnHandleBatch('GENERAL', 'MOBILELOAN', 'MOBILELOAN Batch', GenJournalLine, 'CREATE');

                //Post Loan(Debit Member Loan Account)---------------------------------------------
                LineNo := 1000;
                FnGenerateGeneralJournalLine('GENERAL', 'MOBILELOAN', LineNo, '', TODAY, ObjLoans."Loan  No.", ObjLoans."Loan  No.", GenJournalLine."Account Type"::Customer, ObjLoans."Client Code",
                    ObjLoans."Approved Amount", 'Mobile Loan Principal -' + ObjLoans."Client Code", GenJournalLine."Transaction Type"::Loan, ObjLoans."Loan  No.", 'BOSA', '', '', '', '');

                //Credit Bank with amount minus interest
                LineNo := LineNo + 1000;
                CreditedAmt := ObjLoans."Approved Amount" - InterestDue;
                FnGenerateGeneralJournalLine('GENERAL', 'MOBILELOAN', LineNo, '', TODAY, ObjLoans."Loan  No.", ObjLoans."Loan  No.", GenJournalLine."Account Type"::"Bank Account", 'BNK0006',
                    CreditedAmt * -1, 'Mobile Loan Issued - ' + ObjLoans."Client Code", GenJournalLine."Transaction Type"::" ", ObjLoans."Loan  No.", 'BOSA', '', '', '', '');

                //------------------ACCRUE INTEREST -------------------------------------------------------
                LineNo := LineNo + 1000;
                FnGenerateGeneralJournalLine('GENERAL', 'MOBILELOAN', LineNo, '', TODAY, ObjLoans."Loan  No.", ObjLoans."Loan  No.", GenJournalLine."Account Type"::Customer, ObjLoans."Client Code",
                    InterestDue, 'Mobile Loan Interest - ' + ObjLoans."Client Code", GenJournalLine."Transaction Type"::"Interest Due", ObjLoans."Loan  No.", 'BOSA', '', '', '', '');

                // Interest Paid

                LineNo := LineNo + 1000;
                FnGenerateGeneralJournalLine('GENERAL', 'MOBILELOAN', LineNo, '', TODAY, ObjLoans."Loan  No.", ObjLoans."Loan  No.", GenJournalLine."Account Type"::Customer, ObjLoans."Client Code",
                    InterestDue * -1, 'Interest Paid - ' + ObjLoans."Client Code" + '' + ObjLoans."Loan  No.", GenJournalLine."Transaction Type"::"Interest Paid", ObjLoans."Loan  No.", 'BOSA', '', '', '', '');



                LoanInterestAccount := ObjLoanProduct."Loan Interest Account";

                GeneralSetup.reset();
                GeneralSetup.get;

                GeneralSetup.TestField("Vendor Commission Account");

                LineNo := LineNo + 1000;
                MobileCommissionAccount := GeneralSetup."Vendor Commission Account";
                FnGenerateGeneralJournalLine('GENERAL', 'MOBILELOAN', LineNo, '', TODAY, ObjLoans."Loan  No.", ObjLoans."Loan  No.", GenJournalLine."Account Type"::"G/L Account", LoanInterestAccount,
                    InterestDue * 0.8 * -1, 'Mobile Loan Interest', GenJournalLine."Transaction Type"::" ", ObjLoans."Loan  No.", 'BOSA', '', '', '', '');

                LineNo := LineNo + 1000;
                FnGenerateGeneralJournalLine('GENERAL', 'MOBILELOAN', LineNo, '', TODAY, ObjLoans."Loan  No.", ObjLoans."Loan  No.", GenJournalLine."Account Type"::"G/L Account", MobileCommissionAccount,
                    InterestDue * 0.2 * -1, 'Mobile Loan Commission', GenJournalLine."Transaction Type"::" ", ObjLoans."Loan  No.", 'BOSA', '', '', '', '');

                //---------------------END-----------------------------------------------------------------

                ObjLoans.Posted := TRUE;
                ObjLoans."Disbursed By" := USERID;
                ObjLoans."Net Payment to FOSA" := CreditedAmt;
                ObjLoans."Amount Disbursed" := CreditedAmt;
                ObjLoans.MODIFY;
                FnHandleBatch('GENERAL', 'MOBILELOAN', 'MOBILELOAN Batch', GenJournalLine, 'POST');

                ObjCust.GET(ObjLoans."Client Code");
                msg := '';
                msg := 'Your loan of KSH.' + FORMAT(ObjLoans."Approved Amount") + ' has been Issued. ' + ' Total Amount to Repay is KSH. ' + FORMAT(ObjLoans."Approved Amount") + '. Expected Repayment Completion Date for the Loan is ' + formatDateLocally(CalcDate('30D', Today)) + '. Dial *670# to Repay your Loan';
                SMSMessage(ObjLoans."Loan  No.", ObjLoans."Client Code", ObjCust."Phone No.", msg, 'MOBILOANDISBURSE');

                MESSAGE('Batch posted successfully.');
            END;
        end;
    end;

    procedure formatDateLocally(DateValue: Date): Text
    begin
        exit(FORMAT(DateValue, 0, '<Day,2>/<Month,2>/<Year4>'));
    end;



    procedure SMSMessage(documentNo: Text[30]; accfrom: Text[30]; phone: Text[20]; message: Text[250]; Source: Code[100])
    var
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;
    begin

        SMSMessages.RESET();
        IF SMSMessages.FINDLAST() THEN BEGIN
            iEntryNo := SMSMessages."Entry No" + 1;
        END
        ELSE BEGIN
            iEntryNo := 1;
        END;

        if phone <> '' then begin
            SMSMessages.INIT;
            SMSMessages."Entry No" := iEntryNo;
            SMSMessages."Batch No" := documentNo;
            SMSMessages."Document No" := documentNo;
            SMSMessages."Account No" := accfrom;
            SMSMessages."Date Entered" := TODAY;
            SMSMessages."Time Entered" := DT2TIME(CURRENTDATETIME);
            SMSMessages.Source := Source;
            SMSMessages."Entered By" := USERID;
            SMSMessages."Sent To Server" := SMSMessages."Sent To Server"::No;
            SMSMessages."SMS Message" := message;
            SMSMessages."Telephone No" := phone;
            SMSMessages.INSERT();

        end;

    end;


    procedure FnReturnProductType(LoanNo: Code[20]) ProductType: Code[20]
    var
        Product: Code[30];
    begin
        ObjLoans.Reset();
        ObjLoans.SetRange(ObjLoans."Loan  No.", LoanNo);
        if ObjLoans.Find('-') then begin
            Product := ObjLoans."Loan Product Type";
        end;
        exit(Product);
    end;

    procedure FnCreateGnlJournalLineBalanced(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer;
    TransactionType: Option ,"Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loans,"Interest Due"; AccountType: Option; AccountNo: Code[50]; TransactionDate: Date;
    TransactionAmount: Decimal; ExternalDocumentNo: Code[20]; TransactionDescription: Text; BalancingAccountType: Option; BalancingAccountNo: Code[40]; LoanNumber: code[50];
    loanProduct: code[50])
    var

    begin
        GenJournalLine.Init();
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Loan No" := LoanNumber;
        GenJournalLine.Validate("Loan No");
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine.VALIDATE(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := BalancingAccountType;
        GenJournalLine."Bal. Account No." := BalancingAccountNo;
        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");

        IF GenJournalLine.Amount <> 0 THEN
            GenJournalLine.INSERT;
    end;

    procedure FnGetCommonGLAccount(OptionName: Option): code[20]
    var
        GLAccount: Code[20];
        objDirectGLs: Record "Common Direct Posting GL";
    begin
        objDirectGLs.SetRange(Description, OptionName);
        if objDirectGLs.Find('-') then begin

            GLAccount := objDirectGLs."G/L Account";
            exit(GLAccount);
        end
    end;

    procedure FnGetCommonGLAmount(OptionName: Option; parAmount: Decimal): Decimal
    var
        Amount: Decimal;
        objDirectGLs: Record "Common Direct Posting GL";
    begin
        objDirectGLs.SetRange(Description, OptionName);
        if objDirectGLs.Find('-') then begin

            Amount := objDirectGLs."Amount";

            IF objDirectGLs."Is Percentage" then Begin
                Amount := objDirectGLs."Amount" / 100 * parAmount;
            End;
            exit(Amount);
        end
    end;


    procedure getAvailableBal(AccountNo: code[20]): Decimal
    var
        AvailableBalance: Decimal;
    begin
        exit(AvailableBalance);
    end;

    procedure fnsendmessage(DocNo: Code[20]; CellNo: Code[150]; Source: Text; SMS: Text[2048])
    var
        iEntryNo: Integer;
    begin
        Messages.RESET;
        IF Messages.FIND('+') THEN BEGIN
            iEntryNo := Messages."Entry No";
            iEntryNo := iEntryNo + 1;
        END
        ELSE BEGIN
            iEntryNo := 1;
        END;

        Messages.INIT;
        Messages."Entry No" := iEntryNo;
        Messages."Document No" := DocNo;
        Messages."Date Entered" := TODAY;
        Messages."Time Entered" := DT2TIME(CurrentDateTime);
        Messages.Source := Source;
        Messages."Entered By" := USERID;
        Messages."SMS Message" := SMS;
        Messages."Telephone No" := CellNo;
        IF Messages."Telephone No" <> '' THEN
            Messages.INSERT;
    end;

    procedure FnHandleBatch(BatchType: Code[100]; BatchName: Code[100]; BatchDescription: Text[100]; ObjGenJournalLine: Record "Gen. Journal Line"; CodeAction: Code[20])
    var
        ObjGenJournals: Record "Gen. Journal Line";
        ObjBatches: Record "Gen. Journal Batch";

    begin
        IF (CodeAction = 'CREATE') THEN BEGIN
            ObjGenJournals.RESET;
            ObjGenJournals.SETRANGE("Journal Template Name", BatchType);
            ObjGenJournals.SETRANGE("Journal Batch Name", BatchName);
            ObjGenJournals.DELETEALL;

            ObjBatches.RESET;
            ObjBatches.SETRANGE(ObjBatches."Journal Template Name", BatchType);
            ObjBatches.SETRANGE(ObjBatches.Name, BatchName);
            IF NOT ObjBatches.FIND('-') THEN BEGIN
                ObjBatches.INIT;
                ObjBatches."Journal Template Name" := BatchType;
                ObjBatches.Name := BatchName;
                ObjBatches.Description := BatchDescription;
                ObjBatches.VALIDATE(ObjBatches."Journal Template Name");
                ObjBatches.VALIDATE(ObjBatches.Name);
                ObjBatches.INSERT;
            END;
        END;

        IF (CodeAction = 'POST') THEN BEGIN
            //Post New
            ObjGenJournals.RESET;
            ObjGenJournals.SETRANGE("Journal Template Name", BatchType);
            ObjGenJournals.SETRANGE("Journal Batch Name", BatchName);
            IF ObjGenJournals.FIND('-') THEN BEGIN
                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", ObjGenJournals);
            END;
        END;
    end;


    procedure FnCheckExists(TransCode: Code[50]) CodeExist: Boolean
    var
        ObjLoanProducts: Record "Loan Products Setup";
    begin
        CASE TransCode OF
            'SHA', 'DEP', 'EDU', 'FIX', 'HOL', 'JUN':
                EXIT(TRUE)
        END;

        ObjLoanProducts.Reset();
        ObjLoanProducts.setrange(Paybill_code, TransCode);
        if ObjLoanProducts.find('-') then
            EXIT(TRUE);
    end;

    procedure FnGenerateGeneralJournalLine(JTemplate: Code[20]; JBatch: Code[20]; LineNo: Integer; SourceCode: Code[20]; PostingDate: Date; DocumentNo: Code[20]; ExternalDocNo: Code[35]; AccountType: Option; AccountNo: Code[20]; Amount: Decimal; Description: Text[250]; TransactionType: Option; LoanNo: Code[20]; ActivityCode: Code[50]; BranchCode: Code[50]; UnAllocatedAccount: Code[50]; loanproduct: Code[20]; fosacode: code[30])
    begin
        GenJournalLine.INIT;
        GenJournalLine."Journal Template Name" := JTemplate;
        GenJournalLine."Journal Batch Name" := JBatch;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."External Document No." := ExternalDocNo;
        GenJournalLine."Posting Date" := PostingDate;
        GenJournalLine.Description := Description;
        GenJournalLine.Amount := Amount;
        GenJournalLine.VALIDATE(GenJournalLine.Amount);
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Loan No" := LoanNo;
        GenJournalLine."Shortcut Dimension 1 Code" := ActivityCode;
        GenJournalLine."Shortcut Dimension 2 Code" := BranchCode;
        IF GenJournalLine.Amount <> 0 THEN
            GenJournalLine.INSERT;
    end;

    local procedure CalculateEffectiveGuarantees(MemberNo: Code[20]): Decimal
    var
        LoansGuaranteeDetails: Record "Loans Guarantee Details";
        LoansRegister: Record "Loans Register";
        EffectiveGuarantee: Decimal;
        TotalEffective: Decimal;
    begin
        // Calculate total effective guarantees considering actual loan balances
        TotalEffective := 0;

        LoansGuaranteeDetails.Reset();
        LoansGuaranteeDetails.SetRange("Member No", MemberNo);
        LoansGuaranteeDetails.SetFilter("Outstanding Balance", '>%1', 0);
        LoansGuaranteeDetails.SetRange(Substituted, false);

        if LoansGuaranteeDetails.FindSet() then
            repeat
                // Get the loan's current outstanding balance
                if LoansRegister.Get(LoansGuaranteeDetails."Loan No") then begin
                    LoansRegister.CalcFields("Outstanding Balance");

                    // Use the lesser of: original guarantee or current loan balance
                    if LoansRegister."Outstanding Balance" < LoansGuaranteeDetails."Amont Guaranteed" then
                        EffectiveGuarantee := LoansRegister."Outstanding Balance"
                    else
                        EffectiveGuarantee := LoansGuaranteeDetails."Amont Guaranteed";

                    TotalEffective += EffectiveGuarantee;
                end;
            until LoansGuaranteeDetails.Next() = 0;

        exit(TotalEffective);
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        Messages: Record "SMS Messages";
        ObjCust: Record Customer;
        ObjLoans: Record "Loans Register";
        ObjLoanProduct: Record "Loan Products Setup";
}