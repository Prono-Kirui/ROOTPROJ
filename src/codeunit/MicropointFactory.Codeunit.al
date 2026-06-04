#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50007 "Micropoint Factory"
{

    trigger OnRun()
    begin
        //MESSAGE(FORMAT(FnGetFosaAccountBalance('0804-019444-00')));
        //MESSAGE(FORMAT(FnGetCashierTransactionBudding('CASHWD-S',1000)));
        //MESSAGE(FORMAT(FnGetMinimumAllowedBalance('CURRENT')));
        //FnSendSMS('Cashwi','my message','Fosaaccount');
        //MESSAGE(FnGetMpesaAccount());
        //FnUpdateMonthlyContributions();
        //FnReturnRetirementDate('006987');
        //FnGetMemberAMLRiskRating('001024011');


        /* ObjLoans.RESET;
         ObjLoans.SETRANGE("Loan  No.",'BLN_00044');
         ObjLoans.SETFILTER("Date filter",'..'+FORMAT(20181111D));
         IF ObjLoans.FIND('-') THEN BEGIN
           ObjLoans.CALCFIELDS("Scheduled Principal to Date");
         MESSAGE('%1 %2',FnGetPrincipalDueFiltered(ObjLoans,'..'+FORMAT(TODAY)), ObjLoans."Scheduled Principal to Date");
         END;*/

        //FnRunLoanAmountDue('LN_02081');
        /*
        MESSAGE('xxxxxx %1',FnCalculatePaye(50020.85));
        MESSAGE('40,000 %1',FnCalculatePaye(40000));
        MESSAGE('100,000 %1',FnCalculatePaye(100000));
        MESSAGE('150,000 %1',FnCalculatePaye(150000));
        MESSAGE('500,000 %1',FnCalculatePaye(500000));
        */

    end;

    var
        ObjTransCharges: Record "Transaction Charges";
        UserSetup: Record "User Setup";
        ObjVendor: Record Vendor;
        ObjProducts: Record "Account Types-Saving Products";
        ObjMemberLedgerEntry: Record "Cust. Ledger Entry";
        ObjLoans: Record "Loans Register";
        ObjBanks: Record "Bank Account";
        ObjLoanProductSetup: Record "Loan Products Setup";
        ObjProductCharges: Record "Loan Product Charges";
        ObjMembers: Record Customer;
        ObjMembers2: Record Customer;
        ObjGenSetUp: Record "Sacco General Set-Up";
        ObjCompInfo: Record "Company Information";
        BAND1: Decimal;
        BAND2: Decimal;
        BAND3: Decimal;
        BAND4: Decimal;
        BAND5: Decimal;
        ObjMembershipWithdrawal: Record "Membership Exist";
        ObjSalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjNoSeriesManagement: Codeunit NoSeriesManagement;
        ObjNextNo: Code[20];
        PostingDate: Date;
        ObjNoSeries: Record "No. Series Line";
        VarRepaymentPeriod: Date;
        VarLoanNo: Code[20];
        VarLastMonth: Date;
        ObjLSchedule: Record "Loan Repayment Schedule";
        VarScheduledLoanBal: Decimal;
        VarDateFilter: Text;
        VarLBal: Decimal;
        VarArrears: Decimal;
        VarDate: Integer;
        VarMonth: Integer;
        VarYear: Integer;
        VarLastMonthBeginDate: Date;
        VarScheduleDateFilter: Text;
        VarScheduleRepayDate: Date;
        ObjCustRiskRates: Record "Customer Risk Rating";
        ObjMembershipApplication: Record "Membership Applications";
        ObjMemberRiskRating: Record "Individual Customer Risk Rate";
        ObjProductRiskRating: Record "Product Risk Rating";
        ObjProductsApp: Record "Membership Reg. Products Appli";
        ObjNetRiskScale: Record "Member Gross Risk Rating Scale";
        GenJournalLine: Record "Gen. Journal Line";
        //SMTP: Codeunit UnknownCodeunit400;
        TextBody: Text;
        TextMessage: Text;
        //SMTPSetup: Record "SMTP Mail Setup";
        // ObjEmailLogs: Record "Email Logs";
        iEntryNo: Integer;
        FAJournalLine: Record "Gen. Journal Line";


    procedure FnGetCashierTransactionBudding(TransactionType: Code[100]; TransAmount: Decimal) TCharge: Decimal
    begin
        ObjTransCharges.Reset;
        ObjTransCharges.SetRange(ObjTransCharges."Transaction Type", TransactionType);
        ObjTransCharges.SetFilter(ObjTransCharges."Minimum Amount", '<=%1', TransAmount);
        ObjTransCharges.SetFilter(ObjTransCharges."Maximum Amount", '>=%1', TransAmount);
        TCharge := 0;
        if ObjTransCharges.FindSet then begin
            repeat
                TCharge := TCharge + ObjTransCharges."Charge Amount" + ObjTransCharges."Charge Amount" * 0.1;
            until ObjTransCharges.Next = 0;
        end;
    end;


    procedure FnGetUserBranch() branchCode: Code[20]
    begin
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID", UserId);
        if UserSetup.Find('-') then begin
            branchCode := UserSetup."Branch Code";
        end;
        exit(branchCode);
    end;


    procedure FnSendSMS(SMSSource: Text; SMSBody: Text; CurrentAccountNo: Text; MobileNumber: Text)
    var
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
    begin
        ObjGenSetUp.Get;
        ObjCompInfo.Get;

        SMSMessage.Reset;
        if SMSMessage.Find('+') then begin
            iEntryNo := SMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        SMSMessage."Batch No" := CurrentAccountNo;
        SMSMessage."Document No" := '';
        SMSMessage."Account No" := CurrentAccountNo;
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := SMSSource;
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := SMSBody + '. RUAI ENDELEA Sacco';// +' '+ObjGenSetUp."Customer Care No";
        SMSMessage."Telephone No" := MobileNumber;
        if ((MobileNumber <> '') and (SMSBody <> '')) then
            SMSMessage.Insert;
    end;


    procedure FnCreateGnlJournalLine(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; AppSource: Option " ",CBS,ATM,Mobile,Internet,MPESA,Equity,"Co-op",Family,"SMS Banking")
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Loan No" := LoanNumber;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine."Application Source" := AppSource;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure FnGetFosaAccountBalance(Acc: Code[30]) Bal: Decimal
    begin
        if ObjVendor.Get(Acc) then begin
            ObjVendor.CalcFields(ObjVendor."Balance (LCY)", ObjVendor."ATM Transactions", ObjVendor."Mobile Transactions", ObjVendor."Uncleared Cheques");
            Bal := ObjVendor."Balance (LCY)" - (ObjVendor."ATM Transactions" + ObjVendor."Mobile Transactions" + FnGetMinimumAllowedBalance(ObjVendor."Account Type"));
        end
    end;

    local procedure FnGetMinimumAllowedBalance(ProductCode: Code[60]) MinimumBalance: Decimal
    begin
        ObjProducts.Reset;
        ObjProducts.SetRange(ObjProducts.Code, ProductCode);
        if ObjProducts.Find('-') then
            MinimumBalance := ObjProducts."Minimum Balance";
    end;

    local procedure FnGetMemberLoanBalance(LoanNo: Code[50]; DateFilter: Date; TotalBalance: Decimal)
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", LoanNo);
        ObjLoans.SetFilter(ObjLoans."Date filter", '..%1', DateFilter);
        if ObjMemberLedgerEntry.FindSet then begin
            TotalBalance := TotalBalance + ObjMemberLedgerEntry."Amount (LCY)";
        end;
    end;


    procedure FnGetTellerTillNo() TellerTillNo: Code[40]
    begin
        ObjBanks.Reset;
        ObjBanks.SetRange(ObjBanks."Account Type", ObjBanks."account type"::Cashier);
        ObjBanks.SetRange(ObjBanks.CashierID, UserId);
        if ObjBanks.Find('-') then begin
            TellerTillNo := ObjBanks."No.";
        end;
        exit(TellerTillNo);
    end;


    procedure FnGetMpesaAccount() TellerTillNo: Code[40]
    begin
        ObjBanks.Reset;
        //ObjBanks.SetRange(ObjBanks."Account Type",ObjBanks."account type"::"3");
        //ObjBanks.SetRange(ObjBanks."Bank Account Branch",FnGetUserBranch());
        if ObjBanks.Find('-') then begin
            TellerTillNo := ObjBanks."No.";
        end;
        exit(TellerTillNo);
    end;


    procedure FnGetChargeFee(ProductCode: Code[50]; InsuredAmount: Decimal; ChargeType: Code[100]) FCharged: Decimal
    begin
        if ObjLoanProductSetup.Get(ProductCode) then begin
            ObjProductCharges.Reset;
            ObjProductCharges.SetRange(ObjProductCharges."Product Code", ProductCode);
            ObjProductCharges.SetRange(ObjProductCharges.Code, ChargeType);
            if ObjProductCharges.Find('-') then begin
                if ObjProductCharges."Use Perc" = true then begin
                    FCharged := InsuredAmount * (ObjProductCharges.Percentage / 100);
                end
                else
                    FCharged := ObjProductCharges.Amount;
            end;
        end;
        exit(FCharged);
    end;


    procedure FnGetChargeAccount(ProductCode: Code[50]; MemberCategory: Option Single,Joint,Corporate,Group,Parish,Church,"Church Department",Staff; ChargeType: Code[100]) ChargeGLAccount: Code[50]
    begin
        if ObjLoanProductSetup.Get(ProductCode) then begin
            ObjProductCharges.Reset;
            ObjProductCharges.SetRange(ObjProductCharges."Product Code", ProductCode);
            ObjProductCharges.SetRange(ObjProductCharges.Code, ChargeType);
            if ObjProductCharges.Find('-') then begin
                ChargeGLAccount := ObjProductCharges."G/L Account";
            end;
        end;
        exit(ChargeGLAccount);
    end;

    local procedure FnUpdateMonthlyContributions()
    begin
        ObjMembers.Reset;
        ObjMembers.SetCurrentkey(ObjMembers."No.");
        ObjMembers.SetRange(ObjMembers."Monthly Contribution", 0.0);
        if ObjMembers.FindSet then begin
            repeat
                ObjMembers2."Monthly Contribution" := 500;
                ObjMembers2.Modify;
            until ObjMembers.Next = 0;
            Message('Succesfully done');
        end;


    end;


    procedure FnGetUserBranchB(varUserId: Code[100]) branchCode: Code[20]
    begin
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID", varUserId);
        if UserSetup.Find('-') then begin
            branchCode := UserSetup."Branch Code";
        end;
        exit(branchCode);
    end;


    procedure FnGetMemberBranch(MemberNo: Code[100]) MemberBranch: Code[100]
    var
        ObjMemberLocal: Record Customer;
    begin
        ObjMemberLocal.Reset;
        ObjMemberLocal.SetRange(ObjMemberLocal."No.", MemberNo);
        if ObjMemberLocal.Find('-') then begin
            MemberBranch := ObjMemberLocal."Global Dimension 2 Code";
        end;
        exit(MemberBranch);
    end;

    local procedure FnReturnRetirementDate(MemberNo: Code[50]): Date
    var
        ObjMembers: Record Customer;
    begin
        ObjGenSetUp.Get();
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.Find('-') then
            Message(Format(CalcDate(ObjGenSetUp."Retirement Age", ObjMembers."Date of Birth")));
        exit(CalcDate(ObjGenSetUp."Retirement Age", ObjMembers."Date of Birth"));
    end;


    procedure FnGetTransferFee(DisbursementMode: Option " ",Cheque,"Bank Transfer",EFT,RTGS,"Cheque NonMember"): Decimal
    var
        TransferFee: Decimal;
    begin
        ObjGenSetUp.Get();
        case DisbursementMode of
            Disbursementmode::"Bank Transfer":
                TransferFee := ObjGenSetUp."Loan Trasfer Fee-FOSA";

            Disbursementmode::Cheque:
                TransferFee := ObjGenSetUp."Loan Trasfer Fee-Cheque";

            Disbursementmode::"Cheque NonMember":
                TransferFee := ObjGenSetUp."Loan Trasfer Fee-EFT";

            Disbursementmode::EFT:
                TransferFee := ObjGenSetUp."Loan Trasfer Fee-RTGS";
        end;
        exit(TransferFee);
    end;


    procedure FnGetFosaAccount(MemberNo: Code[50]) FosaAccount: Code[50]
    var
        ObjMembers: Record Customer;
    begin
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.Find('-') then begin
            FosaAccount := ObjMembers."FOSA Account No.";
        end;
        exit(FosaAccount);
    end;


    procedure FnClearGnlJournalLine(TemplateName: Text; BatchName: Text)
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Reset;
        GenJournalLine.SetRange(GenJournalLine."Journal Template Name", TemplateName);
        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BatchName);
        if GenJournalLine.FindSet then begin
            GenJournalLine.DeleteAll;
        end;
    end;


    procedure FnPostGnlJournalLine(TemplateName: Text; BatchName: Text)
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Reset;
        GenJournalLine.SetRange(GenJournalLine."Journal Template Name", TemplateName);
        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BatchName);
        if GenJournalLine.FindSet then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco21", GenJournalLine);
        end;
    end;


    procedure FnCreateGnlJournalLineBalanced(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionDescription: Text; BalancingAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor; BalancingAccountNo: Code[50]; TransactionAmount: Decimal; DimensionActivity: Code[40]; LoanNo: Code[20])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."Loan No" := LoanNo;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := BalancingAccountType;
        GenJournalLine."Bal. Account No." := BalancingAccountNo;
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        //  GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        //  GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure FnChargeExcise(ChargeCode: Code[100]): Boolean
    var
        ObjProductCharges: Record "Loan Charges";
    begin
        ObjProductCharges.Reset;
        ObjProductCharges.SetRange(Code, ChargeCode);
        if ObjProductCharges.Find('-') then
            exit(ObjProductCharges."Charge Excise");
    end;


    procedure FnGetInterestDueTodate(ObjLoans: Record "Loans Register"): Decimal
    var
        ObjLoanRegister: Record "Loans Register";
    begin
        ObjLoans.SetFilter("Date filter", '..' + Format(Today));
        ObjLoans.CalcFields("Schedule Interest to Date", "Outstanding Balance");
        exit(ObjLoans."Schedule Interest to Date");
    end;


    procedure FnGetPhoneNumber(ObjLoans: Record "Loans Register"): Code[50]
    begin
        ObjMembers.Reset;
        ObjMembers.SetRange("No.", ObjLoans."Client Code");
        if ObjMembers.Find('-') then
            exit(ObjMembers."Mobile Phone No");
    end;

    local procedure FnBoosterLoansDisbursement(ObjLoanDetails: Record "Loans Register"): Code[40]
    var
        GenJournalLine: Record "Gen. Journal Line";
        CUNoSeriesManagement: Codeunit NoSeriesManagement;
        DocNumber: Code[100];
        loanTypes: Record "Loan Products Setup";
        ObjLoanX: Record "Loans Register";
        LoansRec: Record "Loans Register";
        Cust: Record Customer;
    begin
        loanTypes.Reset;
        loanTypes.SetRange(loanTypes.Code, 'BLOAN');
        if loanTypes.Find('-') then begin
            DocNumber := CUNoSeriesManagement.GetNextNo('LOANSB', 0D, true);
            LoansRec.Init;
            LoansRec."Loan  No." := DocNumber;
            // LoansRec.INSERT;

            if LoansRec.Get('BLN_00041') then begin
                LoansRec."Client Code" := ObjLoanDetails."Client Code";
                LoansRec.Validate(LoansRec."Client Code");
                LoansRec."Loan Product Type" := 'BLOAN';
                LoansRec.Validate(LoansRec."Loan Product Type");
                LoansRec.Interest := ObjLoanDetails.Interest;
                LoansRec."Loan Status" := LoansRec."loan status"::Closed;
                LoansRec."Application Date" := ObjLoanDetails."Application Date";
                LoansRec."Issued Date" := ObjLoanDetails."Posting Date";
                LoansRec."Loan Disbursement Date" := ObjLoanDetails."Loan Disbursement Date";
                LoansRec.Validate(LoansRec."Loan Disbursement Date");
                LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::"Bank Transfer";
                LoansRec."Repayment Start Date" := ObjLoanDetails."Repayment Start Date";
                LoansRec."Global Dimension 1 Code" := 'BOSA';
                LoansRec."Global Dimension 2 Code" := FnGetUserBranch();
                LoansRec.Source := ObjLoanDetails.Source;
                LoansRec."Approval Status" := ObjLoanDetails."Approval Status";
                LoansRec.Repayment := ObjLoanDetails."Boosted Amount";
                LoansRec."Requested Amount" := ObjLoanDetails."Boosted Amount";
                LoansRec."Approved Amount" := ObjLoanDetails."Boosted Amount";
                LoansRec.Interest := ObjLoanDetails.Interest;
                LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::"Bank Transfer";
                LoansRec.Posted := true;
                LoansRec."Advice Date" := Today;
                LoansRec.Modify;
            end;
        end;
        exit(DocNumber);
    end;

    local procedure FnGenerateRepaymentSchedule(LoanNumber: Code[50])
    var
        LoansRec: Record "Loans Register";
        RSchedule: Record "Loan Repayment Schedule";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        InitialInstal: Decimal;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        GrPrinciple: Integer;
        GrInterest: Integer;
        RepayCode: Code[10];
        WhichDay: Integer;
    begin
        LoansRec.Reset;
        LoansRec.SetRange(LoansRec."Loan  No.", LoanNumber);
        LoansRec.SetFilter(LoansRec."Approved Amount", '>%1', 0);
        LoansRec.SetFilter(LoansRec.Posted, '=%1', true);
        if LoansRec.Find('-') then begin
            if (LoansRec."Loan Product Type" = 'DEFAULTER') and (LoansRec."Issued Date" <> 0D) and (LoansRec."Repayment Start Date" <> 0D) then begin
                LoansRec.TestField(LoansRec."Loan Disbursement Date");
                LoansRec.TestField(LoansRec."Repayment Start Date");

                RSchedule.Reset;
                RSchedule.SetRange(RSchedule."Loan No.", LoansRec."Loan  No.");
                RSchedule.DeleteAll;

                LoanAmount := LoansRec."Approved Amount";
                InterestRate := LoansRec.Interest;
                RepayPeriod := LoansRec.Installments;
                InitialInstal := LoansRec.Installments + LoansRec."Grace Period - Principle (M)";
                LBalance := LoansRec."Approved Amount";
                RunDate := LoansRec."Repayment Start Date";
                InstalNo := 0;

                //Repayment Frequency
                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                    RunDate := CalcDate('-1D', RunDate)
                else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                    RunDate := CalcDate('-1W', RunDate)
                else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                    RunDate := CalcDate('-1M', RunDate)
                else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                    RunDate := CalcDate('-1Q', RunDate);
                //Repayment Frequency


                repeat
                    InstalNo := InstalNo + 1;
                    //Repayment Frequency
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                        RunDate := CalcDate('1D', RunDate)
                    else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                        RunDate := CalcDate('1W', RunDate)
                    else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                        RunDate := CalcDate('1M', RunDate)
                    else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                        RunDate := CalcDate('1Q', RunDate);

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::Amortised then begin
                        //LoansRec.TESTFIELD(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                        LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                        LPrincipal := TotalMRepay - LInterest;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::"Straight Line" then begin
                        LoansRec.TestField(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LoanAmount / RepayPeriod;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::"Reducing Balance" then begin
                        LoansRec.TestField(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LBalance;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::Constants then begin
                        LoansRec.TestField(LoansRec.Repayment);
                        if LBalance < LoansRec.Repayment then
                            LPrincipal := LBalance
                        else
                            LPrincipal := LoansRec.Repayment;
                        LInterest := LoansRec.Interest;
                    end;

                    //Grace Period
                    if GrPrinciple > 0 then begin
                        LPrincipal := 0
                    end else begin
                        LBalance := LBalance - LPrincipal;

                    end;

                    if GrInterest > 0 then
                        LInterest := 0;

                    GrPrinciple := GrPrinciple - 1;
                    GrInterest := GrInterest - 1;
                    Evaluate(RepayCode, Format(InstalNo));


                    RSchedule.Init;
                    RSchedule."Repayment Code" := RepayCode;
                    RSchedule."Interest Rate" := InterestRate;
                    RSchedule."Loan No." := LoansRec."Loan  No.";
                    RSchedule."Loan Amount" := LoanAmount;
                    RSchedule."Instalment No" := InstalNo;
                    RSchedule."Repayment Date" := RunDate;
                    RSchedule."Member No." := LoansRec."Client Code";
                    RSchedule."Loan Category" := LoansRec."Loan Product Type";
                    RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                    RSchedule."Monthly Interest" := LInterest;
                    RSchedule."Principal Repayment" := LPrincipal;
                    RSchedule.Insert;
                    WhichDay := Date2dwy(RSchedule."Repayment Date", 1);
                until LBalance < 1

            end;
        end;

        Commit;
    end;


    procedure FnGetInterestDueFiltered(ObjLoans: Record "Loans Register"; DateFilter: Text): Decimal
    var
        ObjLoanRegister: Record "Loans Register";
    begin
        ObjLoans.SetFilter("Date filter", DateFilter);
        ObjLoans.CalcFields("Schedule Interest to Date", "Outstanding Balance");
        exit(ObjLoans."Schedule Interest to Date");
    end;


    procedure FnGetPAYEBudCharge(ChargeCode: Code[10]): Decimal
    var
        ObjpayeCharges: Record "PAYE Brackets Credit";
    begin
        ObjpayeCharges.Reset;
        ObjpayeCharges.SetRange("Tax Band", ChargeCode);
        if ObjpayeCharges.FindFirst then
            exit(ObjpayeCharges."Taxable Amount" * ObjpayeCharges.Percentage / 100);
    end;


    procedure FnPayeRate(ChargeCode: Code[10]): Decimal
    var
        ObjpayeCharges: Record "PAYE Brackets Credit";
    begin
        ObjpayeCharges.Reset;
        ObjpayeCharges.SetRange("Tax Band", ChargeCode);
        if ObjpayeCharges.FindFirst then
            exit(ObjpayeCharges.Percentage / 100);
    end;


    procedure FnCalculatePaye(Chargeable: Decimal) PAYE: Decimal
    var
        TAXABLEPAY: Record "PAYE Brackets Credit";
        Taxrelief: Decimal;
        OTrelief: Decimal;
    begin
        PAYE := 0;
        if TAXABLEPAY.Find('-') then begin
            repeat
                if Chargeable > 0 then begin
                    case TAXABLEPAY."Tax Band" of
                        '01':
                            begin
                                if Chargeable > TAXABLEPAY."Upper Limit" then begin
                                    BAND1 := FnGetPAYEBudCharge('01');
                                    Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                end else begin
                                    if Chargeable > TAXABLEPAY."Taxable Amount" then begin
                                        BAND1 := FnGetPAYEBudCharge('01');
                                        Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                    end else begin
                                        BAND1 := Chargeable * FnPayeRate('01');
                                        Chargeable := 0;
                                    end;
                                end;
                            end;
                        '02':
                            begin
                                if Chargeable > TAXABLEPAY."Upper Limit" then begin
                                    BAND2 := FnGetPAYEBudCharge('02');
                                    Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                end else begin
                                    if Chargeable > TAXABLEPAY."Taxable Amount" then begin
                                        BAND2 := FnGetPAYEBudCharge('02');
                                        Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                    end else begin
                                        BAND2 := Chargeable * FnPayeRate('02');
                                        Chargeable := 0;
                                    end;
                                end;
                            end;
                        '03':
                            begin
                                if Chargeable > TAXABLEPAY."Upper Limit" then begin
                                    BAND3 := FnGetPAYEBudCharge('03');
                                    Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                end else begin
                                    if Chargeable > TAXABLEPAY."Taxable Amount" then begin
                                        BAND3 := FnGetPAYEBudCharge('03');
                                        Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                    end else begin
                                        BAND3 := Chargeable * FnPayeRate('03');
                                        Chargeable := 0;
                                    end;
                                end;
                            end;
                        '04':
                            begin
                                if Chargeable > TAXABLEPAY."Upper Limit" then begin
                                    BAND4 := FnGetPAYEBudCharge('04');
                                    Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                end else begin
                                    if Chargeable > TAXABLEPAY."Taxable Amount" then begin
                                        BAND4 := FnGetPAYEBudCharge('04');
                                        Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                    end else begin
                                        BAND4 := Chargeable * FnPayeRate('04');
                                        Chargeable := 0;
                                    end;
                                end;
                            end;
                        '05':
                            begin
                                BAND5 := Chargeable * FnPayeRate('05');
                            end;
                    end;
                end;
            until TAXABLEPAY.Next = 0;
        end;
        exit(BAND1 + BAND2 + BAND3 + BAND4 + BAND5 - 1280);
    end;


    procedure FnGetUpfrontsTotal(ProductCode: Code[50]; InsuredAmount: Decimal) FCharged: Decimal
    var
        ObjLoanCharges: Record "Loan Charges";
    begin
        ObjProductCharges.Reset;
        ObjProductCharges.SetRange(ObjProductCharges."Product Code", ProductCode);
        if ObjProductCharges.Find('-') then begin
            repeat
                if ObjProductCharges."Use Perc" = true then begin
                    FCharged := InsuredAmount * (ObjProductCharges.Percentage / 100) + FCharged;
                    if ObjLoanCharges.Get(ObjProductCharges.Code) then begin
                        if ObjLoanCharges."Charge Excise" = true then
                            FCharged := FCharged + (InsuredAmount * (ObjProductCharges.Percentage / 100)) * 0.1;
                    end
                end
                else begin
                    FCharged := ObjProductCharges.Amount + FCharged;
                    if ObjLoanCharges.Get(ObjProductCharges.Code) then begin
                        if ObjLoanCharges."Charge Excise" = true then
                            FCharged := FCharged + ObjProductCharges.Amount * 0.1;
                    end
                end

            until ObjProductCharges.Next = 0;
        end;

        exit(FCharged);
    end;


    procedure FnGetPrincipalDueFiltered(ObjLoans: Record "Loans Register"; DateFilter: Text): Decimal
    var
        ObjLoanRegister: Record "Loans Register";
    begin
        ObjLoans.SetFilter("Date filter", DateFilter);
        ObjLoans.CalcFields("Scheduled Principal to Date", "Outstanding Balance");
        exit(ObjLoans."Scheduled Principal to Date");
    end;


    procedure FnCreateMembershipWithdrawalApplication(MemberNo: Code[20]; ApplicationDate: Date; Reason: Option Relocation,"Financial Constraints","House/Group Challages","Join another Institution","Personal Reasons",Other; ClosureDate: Date)
    begin
        PostingDate := WorkDate;
        ObjSalesSetup.Get;

        ObjNextNo := ObjNoSeriesManagement.TryGetNextNo(ObjSalesSetup."Closure  Nos", PostingDate);
        ObjNoSeries.Reset;
        ObjNoSeries.SetRange(ObjNoSeries."Series Code", ObjSalesSetup."Closure  Nos");
        if ObjNoSeries.FindSet then begin
            ObjNoSeries."Last No. Used" := IncStr(ObjNoSeries."Last No. Used");
            ObjNoSeries."Last Date Used" := Today;
            ObjNoSeries.Modify;
        end;


        ObjMembershipWithdrawal.Init;
        ObjMembershipWithdrawal."No." := ObjNextNo;
        ObjMembershipWithdrawal."Member No." := MemberNo;
        if ObjMembers.Get(MemberNo) then begin
            ObjMembershipWithdrawal."Member Name" := ObjMembers.Name;
        end;
        ObjMembershipWithdrawal."Withdrawal Application Date" := ApplicationDate;
        ObjMembershipWithdrawal."Closing Date" := ClosureDate;
        ObjMembershipWithdrawal."Reason For Withdrawal" := Reason;
        ObjMembershipWithdrawal.Insert;

        ObjMembershipWithdrawal.Validate(ObjMembershipWithdrawal."Member No.");
        ObjMembershipWithdrawal.Modify;

        Message('Withdrawal Application Created Succesfully,Application No  %1 ', ObjNextNo);
    end;

    local procedure FnGetDepreciationValueofCollateral()
    begin
    end;


    procedure FnGetLoanAmountinArrears(VarLoanNo: Code[20]) VarArrears: Decimal
    begin
        VarRepaymentPeriod := WorkDate;

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        if ObjLoans.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Interest Due", ObjLoans."Interest Paid", ObjLoans."Penalty Charged");
            VarLoanNo := ObjLoans."Loan  No.";

            //================Get Last Day of the previous month===================================
            if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Monthly then begin
                if VarRepaymentPeriod = CalcDate('CM', VarRepaymentPeriod) then begin
                    VarLastMonth := VarRepaymentPeriod;
                end else begin
                    VarLastMonth := CalcDate('-1M', VarRepaymentPeriod);
                end;
                VarLastMonth := CalcDate('CM', VarLastMonth);
            end;
            VarDate := 1;
            VarMonth := Date2dmy(VarLastMonth, 2);
            VarYear := Date2dmy(VarLastMonth, 3);
            VarLastMonthBeginDate := Dmy2date(VarDate, VarMonth, VarYear);
            VarScheduleDateFilter := Format(VarLastMonthBeginDate) + '..' + Format(VarLastMonth);
            //End ===========Get Last Day of the previous month==========================================


            //================Get Scheduled Balance=======================================================
            ObjLSchedule.Reset;
            ObjLSchedule.SetRange(ObjLSchedule."Loan No.", VarLoanNo);
            ObjLSchedule.SetRange(ObjLSchedule."Close Schedule", false);
            ObjLSchedule.SetFilter(ObjLSchedule."Repayment Date", VarScheduleDateFilter);
            if ObjLSchedule.FindFirst then begin
                VarScheduledLoanBal := ObjLSchedule."Loan Balance";
                VarScheduleRepayDate := ObjLSchedule."Repayment Date";
            end;

            ObjLSchedule.Reset;
            ObjLSchedule.SetCurrentkey(ObjLSchedule."Repayment Date");
            ObjLSchedule.SetRange(ObjLSchedule."Loan No.", VarLoanNo);
            ObjLSchedule.SetRange(ObjLSchedule."Close Schedule", false);
            if ObjLSchedule.FindLast then begin
                if ObjLSchedule."Repayment Date" < Today then begin
                    VarScheduledLoanBal := ObjLSchedule."Loan Balance";
                    VarScheduleRepayDate := ObjLSchedule."Repayment Date";
                end;
            end;
            //================End Get Scheduled Balance====================================================

            //================Get Loan Bal as per the date filter===========================================
            if VarScheduleRepayDate <> 0D then begin
                VarDateFilter := '..' + Format(VarScheduleRepayDate);
                ObjLoans.SetFilter(ObjLoans."Date filter", VarDateFilter);
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                VarLBal := ObjLoans."Outstanding Balance";
                //===============End Get Loan Bal as per the date filter=========================================

                VarLBal := ObjLoans."Outstanding Balance";

                //============Amount in Arrears================================================================
                VarArrears := VarScheduledLoanBal - VarLBal;
                if (VarArrears > 0) or (VarArrears = 0) then begin
                    VarArrears := 0
                end else
                    VarArrears := VarArrears;
            end;
        end;
        exit(VarArrears * -1);
    end;


    procedure FnCreateGnlJournalLineGuarantorRecovery(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; VarRecoveryType: Option Normal,"Guarantor Recoverd","Guarantor Paid"; VarLoanRecovered: Code[20])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Loan No" := LoanNumber;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine."Recovery Transaction Type" := VarRecoveryType;
        // GenJournalLine."Recoverd Loan":=VarLoanRecovered;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        //GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        //GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure FnGetMemberApplicationAMLRiskRating(MemberNo: Code[20])
    var
        VarCategoryScore: Integer;
        VarResidencyScore: Integer;
        VarNatureofBusinessScore: Integer;
        VarEntityScore: Integer;
        VarIndustryScore: Integer;
        VarLenghtOfRelationshipScore: Integer;
        VarInternationalTradeScore: Integer;
        VarElectronicPaymentScore: Integer;
        VarCardTypeScore: Integer;
        VarAccountTypeScore: Integer;
        VarChannelTakenScore: Integer;
        VarAccountTypeOption: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","FOSA(KSA",Imara," MJA","Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        MemberTotalRiskRatingScore: Decimal;
        MemberNetRiskScore: Decimal;
        // ObjMemberDueDiligence: Record "Member Due Diligence Measures";
        // ObjDueDiligenceSetup: Record "Due Diligence Measures";
        VarRiskRatingDescription: Text[50];
    begin


        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Individuals);
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication."Individual Category");
            if ObjCustRiskRates.FindSet then begin
                VarCategoryScore := ObjCustRiskRates."Risk Score";
            end;
        end;


        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Entities);
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication.Entities);
            if ObjCustRiskRates.FindSet then begin
                VarEntityScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"Residency Status");
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication."Member Residency Status");
            if ObjCustRiskRates.FindSet then begin
                VarResidencyScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Industry);
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication."Industry Type");
            if ObjCustRiskRates.FindSet then begin
                VarIndustryScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"Length Of Relationship");
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication."Length Of Relationship");
            if ObjCustRiskRates.FindSet then begin
                VarLenghtOfRelationshipScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"International Trade");
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication."International Trade");
            if ObjCustRiskRates.FindSet then begin
                VarInternationalTradeScore := ObjCustRiskRates."Risk Score";
            end;
        end;


        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjProductRiskRating.Reset;
            ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::"Electronic Payment");
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", ObjMembershipApplication."Electronic Payment");
            if ObjProductRiskRating.FindSet then begin
                VarElectronicPaymentScore := ObjProductRiskRating."Risk Score";
            end;
        end;


        //ObjProductRiskRating.GET();
        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin

            ObjProductRiskRating.Reset;
            ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Cards);
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", ObjMembershipApplication."Cards Type Taken");
            if ObjProductRiskRating.FindSet then begin
                VarCardTypeScore := ObjProductRiskRating."Risk Score";
            end;
        end;

        ObjProductRiskRating.Reset;
        ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", ObjMembershipApplication."Accounts Type Taken");
        if ObjCustRiskRates.FindSet then begin
            VarAccountTypeScore := ObjProductRiskRating."Risk Score";
        end;

        ObjProductRiskRating.Reset;
        ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Others);
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", ObjMembershipApplication."Others(Channels)");
        if ObjCustRiskRates.FindSet then begin
            VarChannelTakenScore := ObjProductRiskRating."Risk Score";
        end;

        ObjProductsApp.Reset;
        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", MemberNo);
        ObjProductsApp.SetFilter(ObjProductsApp."Product Source", '<>%1', ObjProductsApp."product source"::FOSA);
        if ObjProductsApp.FindSet then begin
            repeat
                ObjProductRiskRating.Reset;
                ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type");
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type", ObjProductRiskRating."product type"::BOSA);
                if ObjCustRiskRates.FindSet then begin
                    VarAccountTypeScore := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOption := ObjProductRiskRating."product type"::BOSA;
                end;
            until ObjProductsApp.Next = 0;
        end;

        ObjProductsApp.Reset;
        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", MemberNo);
        ObjProductsApp.SetFilter(ObjProductsApp."Product Source", '%1', ObjProductsApp."product source"::FOSA);
        ObjProductsApp.SetFilter(ObjProductsApp.Product, '<>%1|%2', '503', '506');
        if ObjProductsApp.FindSet then begin

            repeat
                ObjProductRiskRating.Reset;
                ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type");
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type", ObjProductRiskRating."product type"::"FOSA(KSA");
                if ObjCustRiskRates.FindSet then begin
                    VarAccountTypeScore := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOption := ObjProductRiskRating."product type"::"FOSA(KSA";
                end;
            until ObjProductsApp.Next = 0;
        end;


        ObjProductsApp.Reset;
        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", MemberNo);
        ObjProductsApp.SetFilter(ObjProductsApp.Product, '%1|%2', '503', '506');
        if ObjProductsApp.FindSet then begin
            repeat
                ObjProductRiskRating.Reset;
                ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type");
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type", ObjProductRiskRating."product type"::"Fixed/Call Deposit Accounts");
                if ObjCustRiskRates.FindSet then begin
                    VarAccountTypeScore := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOption := ObjProductRiskRating."product type"::"Fixed/Call Deposit Accounts";
                end;
            until ObjProductsApp.Next = 0;
        end;

        //Create Entries on Membership Risk Rating Table
        ObjMemberRiskRating.Reset;
        ObjMemberRiskRating.SetRange(ObjMemberRiskRating."Membership Application No", MemberNo);
        if ObjMemberRiskRating.FindSet then begin
            ObjMemberRiskRating.DeleteAll;
        end;


        ObjMemberRiskRating.Init;
        ObjMemberRiskRating."Membership Application No" := MemberNo;
        ObjMemberRiskRating."What is the Customer Category?" := ObjMembershipApplication."Individual Category";
        ObjMemberRiskRating."Customer Category Score" := VarCategoryScore;
        ObjMemberRiskRating."What is the Member residency?" := ObjMembershipApplication."Member Residency Status";
        ObjMemberRiskRating."Member Residency Score" := VarResidencyScore;
        ObjMemberRiskRating."Cust Employment Risk?" := ObjMembershipApplication.Entities;
        ObjMemberRiskRating."Cust Employment Risk Score" := VarEntityScore;
        ObjMemberRiskRating."Cust Business Risk Industry?" := ObjMembershipApplication."Industry Type";
        ObjMemberRiskRating."Cust Bus. Risk Industry Score" := VarIndustryScore;
        ObjMemberRiskRating."Lenght Of Relationship?" := ObjMembershipApplication."Length Of Relationship";
        ObjMemberRiskRating."Length Of Relation Score" := VarLenghtOfRelationshipScore;
        ObjMemberRiskRating."Cust Involved in Intern. Trade" := ObjMembershipApplication."International Trade";
        ObjMemberRiskRating."Involve in Inter. Trade Score" := VarInternationalTradeScore;
        ObjMemberRiskRating."Account Type Taken?" := Format(VarAccountTypeOption);
        ObjMemberRiskRating."Account Type Taken Score" := VarAccountTypeScore;
        ObjMemberRiskRating."Card Type Taken" := ObjMembershipApplication."Cards Type Taken";
        ObjMemberRiskRating."Card Type Taken Score" := VarCardTypeScore;
        ObjMemberRiskRating."Channel Taken?" := ObjMembershipApplication."Others(Channels)";
        ObjMemberRiskRating."Channel Taken Score" := VarChannelTakenScore;
        ObjMemberRiskRating."Electronic Payments?" := ObjMembershipApplication."Electronic Payment";
        ObjMemberRiskRating."Electronic Payments Score" := VarElectronicPaymentScore;
        MemberTotalRiskRatingScore := VarCategoryScore + VarEntityScore + VarIndustryScore + VarInternationalTradeScore + VarLenghtOfRelationshipScore + VarResidencyScore + VarAccountTypeScore
        + VarCardTypeScore + VarChannelTakenScore + VarElectronicPaymentScore;
        ObjMemberRiskRating."GROSS CUSTOMER AML RISK RATING" := MemberTotalRiskRatingScore;
        ObjMemberRiskRating."BANK'S CONTROL RISK RATING" := 9;
        ObjMemberRiskRating."CUSTOMER NET RISK RATING" := ROUND(ObjMemberRiskRating."GROSS CUSTOMER AML RISK RATING" / ObjMemberRiskRating."BANK'S CONTROL RISK RATING", 0.5, '>');
        MemberNetRiskScore := MemberTotalRiskRatingScore / 9;

        ObjNetRiskScale.Reset;
        if ObjNetRiskScale.FindSet then begin
            repeat
                if (MemberTotalRiskRatingScore >= ObjNetRiskScale."Minimum Risk Rate") and (MemberTotalRiskRatingScore <= ObjNetRiskScale."Maximum Risk Rate") then begin
                    ObjMemberRiskRating."Risk Rate Scale" := ObjNetRiskScale."Risk Scale";
                    VarRiskRatingDescription := ObjNetRiskScale.Description;
                end;
            until ObjNetRiskScale.Next = 0;
        end;
        ObjMemberRiskRating.Insert;
        ObjMemberRiskRating.Validate(ObjMemberRiskRating."Membership Application No");
        ObjMemberRiskRating.Modify;


        // ObjMemberDueDiligence.Reset;
        // ObjMemberDueDiligence.SetRange(ObjMemberDueDiligence."Member No",MemberNo);
        // if ObjMemberDueDiligence.FindSet then
        //   begin
        //     ObjMemberDueDiligence.DeleteAll;
        //     end;

        // ObjDueDiligenceSetup.Reset;
        // ObjDueDiligenceSetup.SetRange(ObjDueDiligenceSetup."Risk Rating Level",ObjMemberRiskRating."Risk Rate Scale");
        // if ObjDueDiligenceSetup.FindSet then
        //   begin
        //     repeat
        //       ObjMemberDueDiligence.Init;
        //       ObjMemberDueDiligence."Member No":=MemberNo;
        //       if ObjMembershipApplication.Get(MemberNo) then
        //         begin
        //           ObjMemberDueDiligence."Member Name":=ObjMembershipApplication.Name;
        //           end;
        //       ObjMemberDueDiligence."Due Diligence No":=ObjDueDiligenceSetup."Due Diligence No";
        //       ObjMemberDueDiligence."Risk Rating Level":=ObjMemberRiskRating."Risk Rate Scale";
        //       ObjMemberDueDiligence."Risk Rating Scale":= VarRiskRatingDescription;
        //       ObjMemberDueDiligence."Due Diligence Type":=ObjDueDiligenceSetup."Due Diligence Type";
        //       ObjMemberDueDiligence."Due Diligence Measure":=ObjDueDiligenceSetup."Due Diligence Measure";
        //       ObjMemberDueDiligence.Insert;
        //       until ObjDueDiligenceSetup.Next=0;
        //     end;

        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjMembershipApplication."Member Risk Level" := ObjMemberRiskRating."Risk Rate Scale";
            // ObjMembershipApplication."Due Diligence Measure":=ObjDueDiligenceSetup."Due Diligence Type";
            ObjMembershipApplication.Modify;
        end;
    end;


    procedure FnGetMemberAMLRiskRating(MemberNo: Code[20])
    var
        VarCategoryScore: Integer;
        VarResidencyScore: Integer;
        VarNatureofBusinessScore: Integer;
        VarEntityScore: Integer;
        VarIndustryScore: Integer;
        VarLenghtOfRelationshipScore: Integer;
        VarInternationalTradeScore: Integer;
        VarElectronicPaymentScore: Integer;
        VarCardTypeScore: Integer;
        VarAccountTypeScore: Integer;
        VarChannelTakenScore: Integer;
        VarAccountTypeOption: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","FOSA(KSA",Imara," MJA","Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        MemberTotalRiskRatingScore: Decimal;
        MemberNetRiskScore: Decimal;
        VarMemberAnnualIncome: Decimal;
        ObjNetWorth: Record "Customer Net Income Risk Rates";
        ObjPeps: Record "Politically Exposed Persons";
        VarPepsRiskScore: Decimal;
        VarHighNet: Decimal;
        VarIndividualCategoryOption: Option "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 – 1 Year","1 – 3 Years","Trade/Export Finance","Local Trade";
        VarLenghtOfRelationshipOption: Option "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 – 1 Year","1 – 3 Years","Trade/Export Finance","Local Trade";
        VarMemberSaccoAge: Integer;
        // ObjMemberDueDiligence: Record "Member Due Diligence Measures";
        //ObjDueDiligenceSetup: Record "Due Diligence Measures";
        VarRiskRatingDescription: Text[50];
    begin

        //Member Category(High Net Worth|PEPS|Others)==============================================================================================
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin


            //High Net Worth==============================================================================
            VarMemberAnnualIncome := ObjMembers."Expected Monthly Income" * 12;
            ObjNetWorth.Reset;
            //ObjNetWorth.SETFILTER(ObjNetWorth."Minimum Risk Rate",'<=%1',VarMemberAnnualIncome);
            if ObjNetWorth.FindSet then begin
                repeat
                    if (VarMemberAnnualIncome >= ObjNetWorth."Min Annual Income") and (VarMemberAnnualIncome <= ObjNetWorth."Max Annual Income") then begin
                        VarHighNet := ObjNetWorth."Risk Rate";
                    end;
                until ObjNetWorth.Next = 0;
            end;
            //End High Net Worth==========================================================================

            //Politicall Exposed Persons====================================================================
            ObjPeps.Reset;
            ObjPeps.SetFilter(ObjPeps.Name, ObjMembers.Name);
            if ObjPeps.FindSet then begin
                ObjCustRiskRates.Reset;
                ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Individuals);
                ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category Option", ObjCustRiskRates."sub category option"::"Politically Exposed Persons (PEPs)");
                if ObjCustRiskRates.FindSet then begin
                    VarPepsRiskScore := ObjCustRiskRates."Risk Score";
                end;
            end;
            //End Politicall Exposed Persons================================================================

            if (VarHighNet < 5) and (VarPepsRiskScore = 0) then begin

                ObjCustRiskRates.Reset;
                ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Individuals);
                ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category Option", ObjCustRiskRates."sub category option"::Other);
                if ObjCustRiskRates.FindSet then begin
                    VarCategoryScore := ObjCustRiskRates."Risk Score";
                    VarIndividualCategoryOption := Varindividualcategoryoption::Other;
                end;

            end else
                if (VarHighNet = 5) and (VarPepsRiskScore = 0) then begin

                    ObjCustRiskRates.Reset;
                    ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Individuals);
                    ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category Option", ObjCustRiskRates."sub category option"::"High Net worth");
                    if ObjCustRiskRates.FindSet then begin
                        VarCategoryScore := ObjCustRiskRates."Risk Score";
                        VarIndividualCategoryOption := Varindividualcategoryoption::"High Net worth";
                    end;

                end else
                    if (VarHighNet <> 5) and (VarPepsRiskScore = 5) then begin

                        ObjCustRiskRates.Reset;
                        ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Individuals);
                        ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category Option", ObjCustRiskRates."sub category option"::"Politically Exposed Persons (PEPs)");
                        if ObjCustRiskRates.FindSet then begin
                            VarCategoryScore := ObjCustRiskRates."Risk Score";
                            VarIndividualCategoryOption := Varindividualcategoryoption::"Politically Exposed Persons (PEPs)";
                        end;
                    end;
        end;
        //END Member Category(High Net Worth|PEPS|Others)==============================================================================================

        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Entities);
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembers.Entities);
            if ObjCustRiskRates.FindSet then begin
                VarEntityScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"Residency Status");
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembers."Member Residency Status");
            if ObjCustRiskRates.FindSet then begin
                VarResidencyScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Industry);
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembers."Industry Type");
            if ObjCustRiskRates.FindSet then begin
                VarIndustryScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        //Lenght Of Relationship=========================================================================================================
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin
            if ObjMembers."Registration Date" <> 0D then
                VarMemberSaccoAge := ROUND((Today - ObjMembers."Registration Date") / 365, 1, '<');

            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetCurrentkey(ObjCustRiskRates."Min Relationship Length(Years)");
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"Length Of Relationship");
            if ObjCustRiskRates.FindSet then begin
                repeat
                    if (VarMemberSaccoAge >= ObjCustRiskRates."Min Relationship Length(Years)") and (VarMemberSaccoAge <= ObjCustRiskRates."Max Relationship Length(Years)") then begin
                        //MESSAGE('VarMemberSaccoAge is %1',VarMemberSaccoAge);
                        VarLenghtOfRelationshipScore := ObjCustRiskRates."Risk Score";
                        VarLenghtOfRelationshipOption := ObjCustRiskRates."Sub Category Option";
                        //MESSAGE('VarLenghtOfRelationshipOption %1 VarLenghtOfRelationshipScore%2,',VarLenghtOfRelationshipOption,VarLenghtOfRelationshipScore);
                    end;
                until ObjNetWorth.Next = 0;
            end;
        end;
        //End Lenght Of Relationship=========================================================================================================

        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"International Trade");
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembers."International Trade");
            if ObjCustRiskRates.FindSet then begin
                VarInternationalTradeScore := ObjCustRiskRates."Risk Score";
            end;
        end;


        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin
            ObjProductRiskRating.Reset;
            ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::"Electronic Payment");
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", ObjMembers."Electronic Payment");
            if ObjProductRiskRating.FindSet then begin
                VarElectronicPaymentScore := ObjProductRiskRating."Risk Score";
            end;
        end;


        //ObjProductRiskRating.GET();
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin

            ObjProductRiskRating.Reset;
            ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Cards);
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", ObjMembers."Cards Type Taken");//VarCardType
            if ObjProductRiskRating.FindSet then begin
                VarCardTypeScore := ObjProductRiskRating."Risk Score";
            end;
        end;

        ObjProductRiskRating.Reset;
        ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", ObjMembers."Accounts Type Taken");
        if ObjCustRiskRates.FindSet then begin
            VarAccountTypeScore := ObjProductRiskRating."Risk Score";
        end;

        ObjProductRiskRating.Reset;
        ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Others);
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", ObjMembers."Others(Channels)");
        if ObjCustRiskRates.FindSet then begin
            VarChannelTakenScore := ObjProductRiskRating."Risk Score";
        end;

        ObjProductsApp.Reset;
        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", MemberNo);
        ObjProductsApp.SetFilter(ObjProductsApp."Product Source", '<>%1', ObjProductsApp."product source"::FOSA);
        if ObjProductsApp.FindSet then begin
            repeat
                ObjProductRiskRating.Reset;
                ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type");
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type", ObjProductRiskRating."product type"::BOSA);
                if ObjCustRiskRates.FindSet then begin
                    VarAccountTypeScore := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOption := ObjProductRiskRating."product type"::BOSA;
                end;
            until ObjProductsApp.Next = 0;
        end;

        ObjProductsApp.Reset;
        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", MemberNo);
        ObjProductsApp.SetFilter(ObjProductsApp."Product Source", '%1', ObjProductsApp."product source"::FOSA);
        ObjProductsApp.SetFilter(ObjProductsApp.Product, '<>%1|%2', '503', '506');
        if ObjProductsApp.FindSet then begin

            repeat
                ObjProductRiskRating.Reset;
                ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type");
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type", ObjProductRiskRating."product type"::"FOSA(KSA");
                if ObjCustRiskRates.FindSet then begin
                    VarAccountTypeScore := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOption := ObjProductRiskRating."product type"::"FOSA(KSA";
                end;
            until ObjProductsApp.Next = 0;
        end;


        ObjProductsApp.Reset;
        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", MemberNo);
        ObjProductsApp.SetFilter(ObjProductsApp.Product, '%1|%2', '503', '506');
        if ObjProductsApp.FindSet then begin
            repeat
                ObjProductRiskRating.Reset;
                ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type");
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type", ObjProductRiskRating."product type"::"Fixed/Call Deposit Accounts");
                if ObjCustRiskRates.FindSet then begin
                    VarAccountTypeScore := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOption := ObjProductRiskRating."product type"::"Fixed/Call Deposit Accounts";
                end;
            until ObjProductsApp.Next = 0;
        end;

        //Create Entries on Membership Risk Rating Table
        ObjMemberRiskRating.Reset;
        ObjMemberRiskRating.SetRange(ObjMemberRiskRating."Membership Application No", MemberNo);
        if ObjMemberRiskRating.FindSet then begin
            ObjMemberRiskRating.DeleteAll;
        end;


        if ObjMembers.Get(MemberNo) then begin
            ObjMembers."Individual Category" := Format(VarIndividualCategoryOption);
            ObjMembers."Length Of Relationship" := Format(VarLenghtOfRelationshipOption);
            ObjMembers.Modify;
        end;

        ObjMemberRiskRating.Init;
        ObjMemberRiskRating."Membership Application No" := MemberNo;
        ObjMemberRiskRating."What is the Customer Category?" := Format(VarIndividualCategoryOption);
        ObjMemberRiskRating."Customer Category Score" := VarCategoryScore;
        ObjMemberRiskRating."What is the Member residency?" := ObjMembers."Member Residency Status";
        ObjMemberRiskRating."Member Residency Score" := VarResidencyScore;
        ObjMemberRiskRating."Cust Employment Risk?" := ObjMembers.Entities;
        ObjMemberRiskRating."Cust Employment Risk Score" := VarEntityScore;
        ObjMemberRiskRating."Cust Business Risk Industry?" := ObjMembers."Industry Type";
        ObjMemberRiskRating."Cust Bus. Risk Industry Score" := VarIndustryScore;
        ObjMemberRiskRating."Lenght Of Relationship?" := Format(VarLenghtOfRelationshipOption);
        ObjMemberRiskRating."Length Of Relation Score" := VarLenghtOfRelationshipScore;
        ObjMemberRiskRating."Cust Involved in Intern. Trade" := ObjMembers."International Trade";
        ObjMemberRiskRating."Involve in Inter. Trade Score" := VarInternationalTradeScore;
        ObjMemberRiskRating."Account Type Taken?" := Format(VarAccountTypeOption);
        ObjMemberRiskRating."Account Type Taken Score" := VarAccountTypeScore;
        ObjMemberRiskRating."Card Type Taken" := ObjMembers."Cards Type Taken";
        ObjMemberRiskRating."Card Type Taken Score" := VarCardTypeScore;
        ObjMemberRiskRating."Channel Taken?" := ObjMembers."Others(Channels)";
        ObjMemberRiskRating."Channel Taken Score" := VarChannelTakenScore;
        ObjMemberRiskRating."Electronic Payments?" := ObjMembers."Electronic Payment";
        ObjMemberRiskRating."Electronic Payments Score" := VarElectronicPaymentScore;
        MemberTotalRiskRatingScore := VarCategoryScore + VarEntityScore + VarIndustryScore + VarInternationalTradeScore + VarLenghtOfRelationshipScore + VarResidencyScore + VarAccountTypeScore
        + VarCardTypeScore + VarChannelTakenScore + VarElectronicPaymentScore;
        ObjMemberRiskRating."GROSS CUSTOMER AML RISK RATING" := MemberTotalRiskRatingScore;
        ObjMemberRiskRating."BANK'S CONTROL RISK RATING" := 9;
        ObjMemberRiskRating."CUSTOMER NET RISK RATING" := ROUND(ObjMemberRiskRating."GROSS CUSTOMER AML RISK RATING" / ObjMemberRiskRating."BANK'S CONTROL RISK RATING", 0.5, '>');
        MemberNetRiskScore := MemberTotalRiskRatingScore / 9;

        ObjNetRiskScale.Reset;
        if ObjNetRiskScale.FindSet then begin
            repeat
                if (MemberTotalRiskRatingScore >= ObjNetRiskScale."Minimum Risk Rate") and (MemberTotalRiskRatingScore <= ObjNetRiskScale."Maximum Risk Rate") then begin
                    ObjMemberRiskRating."Risk Rate Scale" := ObjNetRiskScale."Risk Scale";
                    VarRiskRatingDescription := ObjNetRiskScale.Description;
                end;
            until ObjNetRiskScale.Next = 0;
        end;
        ObjMemberRiskRating.Insert;
        ObjMemberRiskRating.Validate(ObjMemberRiskRating."Membership Application No");
        ObjMemberRiskRating.Modify;


        // ObjMemberDueDiligence.Reset;
        // ObjMemberDueDiligence.SetRange(ObjMemberDueDiligence."Member No",MemberNo);
        // if ObjMemberDueDiligence.FindSet then
        //   begin
        //     ObjMemberDueDiligence.DeleteAll;
        //     end;

        // ObjDueDiligenceSetup.Reset;
        // ObjDueDiligenceSetup.SetRange(ObjDueDiligenceSetup."Risk Rating Level",ObjMemberRiskRating."Risk Rate Scale");
        // if ObjDueDiligenceSetup.FindSet then
        //   begin
        //     repeat
        //       ObjMemberDueDiligence.Init;
        //       ObjMemberDueDiligence."Member No":=MemberNo;
        //       if ObjMembers.Get(MemberNo) then
        //         begin
        //           ObjMemberDueDiligence."Member Name":=ObjMembers.Name;
        //           end;
        //       ObjMemberDueDiligence."Due Diligence No":=ObjDueDiligenceSetup."Due Diligence No";
        //       ObjMemberDueDiligence."Risk Rating Level":=ObjMemberRiskRating."Risk Rate Scale";
        //       ObjMemberDueDiligence."Risk Rating Scale":= VarRiskRatingDescription;
        //       ObjMemberDueDiligence."Due Diligence Type":=ObjDueDiligenceSetup."Due Diligence Type";
        //       ObjMemberDueDiligence."Due Diligence Measure":=ObjDueDiligenceSetup."Due Diligence Measure";
        //       ObjMemberDueDiligence.Insert;
        //       until ObjDueDiligenceSetup.Next=0;
        //     end;

        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin
            ObjMembers."Member Risk Level" := ObjMemberRiskRating."Risk Rate Scale";
            //  ObjMembers."Due Diligence Measure":=ObjDueDiligenceSetup."Due Diligence Type";
            ObjMembers.Modify;
        end;
    end;


    procedure FnGetMemberLiability(MemberNo: Code[30]) VarTotaMemberLiability: Decimal
    var
        ObjLoanGuarantors: Record "Loans Guarantee Details";
        ObjLoans: Record "Loans Register";
        ObjLoanSecurities: Record "Loan Collateral Details";
        ObjLoanGuarantors2: Record "Loans Guarantee Details";
        VarTotalGuaranteeValue: Decimal;
        VarMemberAnountGuaranteed: Decimal;
        VarApportionedLiability: Decimal;
        VarLoanOutstandingBal: Decimal;
    begin
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin

            VarTotalGuaranteeValue := 0;
            VarApportionedLiability := 0;
            VarTotaMemberLiability := 0;
            //Loans Guaranteed=======================================================================
            ObjLoanGuarantors.CalcFields(ObjLoanGuarantors."Outstanding Balance");
            ObjLoanGuarantors.Reset;
            ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Member No", MemberNo);
            ObjLoanGuarantors.SetFilter(ObjLoanGuarantors."Outstanding Balance", '>%1', 0);
            if ObjLoanGuarantors.FindSet then begin
                repeat
                    if ObjLoanGuarantors."Amont Guaranteed" > 0 then begin
                        ObjLoanGuarantors.CalcFields(ObjLoanGuarantors."Total Loans Guaranteed");
                        if ObjLoans.Get(ObjLoanGuarantors."Loan No") then begin
                            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                            if ObjLoans."Outstanding Balance" > 0 then begin
                                VarLoanOutstandingBal := ObjLoans."Outstanding Balance";
                                VarApportionedLiability := ROUND((ObjLoanGuarantors."Amont Guaranteed" / ObjLoanGuarantors."Total Loans Guaranteed") * VarLoanOutstandingBal, 0.5, '=');
                            end
                        end;
                    end;
                    VarTotaMemberLiability := VarTotaMemberLiability + VarApportionedLiability;
                until ObjLoanGuarantors.Next = 0;
            end;
        end;
        exit(VarTotaMemberLiability);

    end;


    procedure FnGetMemberMonthlyContributionDepositstier(MemberNo: Code[30]) VarMemberMonthlyContribution: Decimal
    var
        ObjMember: Record Customer;
        ObjLoans: Record "Loans Register";
        VarTotalLoansIssued: Decimal;
    // ObjDeposittier: Record "Member Deposit Tier";
    begin
        VarTotalLoansIssued := 0;

        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", MemberNo);
        if ObjMember.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");

            ObjLoans.Reset;
            ObjLoans.SetRange(ObjLoans."Client Code", MemberNo);
            ObjLoans.SetRange(ObjLoans.Posted, true);
            ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
            if ObjLoans.FindSet then begin
                repeat
                    VarTotalLoansIssued := VarTotalLoansIssued + ObjLoans."Approved Amount";
                until ObjLoans.Next = 0;
            end;

            // ObjDeposittier.Reset;
            //  if ObjDeposittier.Find('-') then
            //  begin
            //  repeat
            // if (VarTotalLoansIssued>=ObjDeposittier."Minimum Amount") and (VarTotalLoansIssued<=ObjDeposittier."Maximum Amount") then
            //  begin
            //  VarMemberMonthlyContribution:=ObjDeposittier.Amount;
            //  end;
            // until ObjDeposittier.Next=0;
            // end;
        end;
        exit(VarMemberMonthlyContribution);

    end;


    procedure FnGetAccountMonthlyCredit(VarAccountNo: Code[20]; VarTransactionDate: Date) VarMonthCredits: Decimal
    var
        ObjVendorLedger: Record "Detailed Vendor Ledg. Entry";
        VarStartDate: Integer;
        VarMonthMonth: Integer;
        VarMonthYear: Integer;
        VarMonthStartDate: Date;
        VarDateFilter: Text;
    begin
        VarStartDate := 1;
        VarMonthMonth := Date2dmy(VarTransactionDate, 2);
        VarMonthYear := Date2dmy(VarTransactionDate, 3);
        VarMonthStartDate := Dmy2date(VarStartDate, VarMonthMonth, VarMonthYear);
        VarDateFilter := Format(VarMonthStartDate) + '..' + Format(VarTransactionDate);

        ObjVendorLedger.Reset;
        ObjVendorLedger.SetRange(ObjVendorLedger."Vendor No.", VarAccountNo);
        ObjVendorLedger.SetFilter(ObjVendorLedger."Posting Date", VarDateFilter);
        ObjVendorLedger.SetFilter(ObjVendorLedger.Amount, '<%1', 0);
        if ObjVendorLedger.FindSet then begin
            repeat
                VarMonthCredits := (ObjVendorLedger.Amount * -1);
            until ObjVendorLedger.Next = 0;
        end;
    end;


    procedure FnCreateGnlJournalLineMC(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; GroupCode: Code[100])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Loan No" := LoanNumber;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        GenJournalLine."Group Code" := GroupCode;
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure FnCreateGnlJournalLineAtm(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text[250]; LoanNumber: Code[50]; TraceID: Code[100])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Loan No" := LoanNumber;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        GenJournalLine."ATM SMS" := true;
        GenJournalLine."Trace ID" := TraceID;
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;

    local procedure FnGetGroupNetworth(HouseGroupNo: Code[20])
    var
        ObjCust: Record Customer;
        VarCollateralSecurity: Decimal;
        VarRepaymentPeriod: Date;
        VarArrears: Decimal;
        VarTotalArrears: Decimal;
        ObjLoanCollateral: Record "Loan Collateral Details";
        ObjCustII: Record Customer;
        VarLoanRisk: Decimal;
        VarRepaymentDate: Date;
        VarRepayDate: Date;
    begin
        /*VarCollateralSecurity:=0;
        VarRepaymentPeriod:=WORKDATE;
        VarArrears:=0;
        VarTotalArrears:=0;
        
        ObjCust.RESET;
        ObjCust.SETRANGE(ObjCust."Member House Group",HouseGroupNo);
        IF ObjCust.FINDSET THEN
          BEGIN
            REPEAT
        
            ObjLoanCollateral.RESET;
            ObjLoanCollateral.SETRANGE(ObjLoanCollateral."Member No",ObjCust."No.");
            IF ObjLoanCollateral.FINDSET THEN BEGIN
              REPEAT
        
                ObjLoans.RESET;
                ObjLoans.SETRANGE(ObjLoans."Loan  No.",ObjLoanCollateral."Loan No");
                IF ObjLoans.FINDSET THEN BEGIN
                  ObjLoans.CALCFIELDS(ObjLoans."Outstanding Balance");
                  IF ObjLoans."Outstanding Balance">0 THEN BEGIN
                    VarCollateralSecurity:=VarCollateralSecurity+ObjLoanCollateral."Guarantee Value";
                    END;
                  END;
                UNTIL ObjLoanCollateral.NEXT=0;
              END;
        
        
        ObjCustII.RESET;
        ObjCustII.SETRANGE(ObjCustII."No.",ObjCust."No.");
        IF ObjCustII.FINDSET THEN BEGIN
          ObjCustII.CALCFIELDS(ObjCustII."Total Loans Outstanding");
            IF ObjCustII."Total Loans Outstanding">VarCollateralSecurity THEN BEGIN
              VarLoanRisk:=ObjCustII."Total Loans Outstanding"-VarCollateralSecurity
              END ELSE
              VarLoanRisk:=0;
        END;
        
        
        ObjLoans.RESET;
        ObjLoans.SETRANGE(ObjLoans."Client Code",ObjCust."No.");
        ObjLoans.SETRANGE(ObjLoans.Posted,TRUE);
        IF ObjLoans.FINDSET THEN BEGIN
        REPEAT
        ObjLoans.CALCFIELDS(ObjLoans."Outstanding Balance");
        IF ObjLoans."Outstanding Balance">0 THEN BEGIN
        IF ObjLoans."Repayment Frequency"=ObjLoans."Repayment Frequency"::Monthly THEN BEGIN
          IF VarRepaymentPeriod=CALCDATE('CM',VarRepaymentPeriod) THEN BEGIN
                VarRepaymentDate:=ObjLoans."Repayment Start Date";
                VarRepayDate:=DATE2DMY(VarRepaymentDate,1);
        
                VarLastMonth:=VarRepaymentPeriod;
              END ELSE BEGIN
                VarLastMonth:=CALCDATE('-1M',VarRepaymentPeriod);
                VarLastMonthDate:=DATE2DMY(VarLastMonth,1);
                VarLastMonthMonth:=DATE2DMY(VarLastMonth,2);
                VarLastMonthYear:=DATE2DMY(VarLastMonth,3);
              END;
            VarRepayDate:=DATE2DMY(VarLastMonth,1);//DATE2DMY(ObjLoans."Repayment Start Date",1);
            VarLastMonth:=DMY2DATE(VarRepayDate,VarLastMonthMonth,VarLastMonthYear);
        
         END;
        
        
          ObjRepaymentSch.RESET;
          ObjRepaymentSch.SETRANGE(ObjRepaymentSch."Loan No.",ObjLoans."Loan  No.");
          ObjRepaymentSch.SETRANGE(ObjRepaymentSch."Repayment Date",VarLastMonth);
            IF ObjRepaymentSch.FINDFIRST THEN BEGIN
              VarScheduledLoanBal:=ObjRepaymentSch."Loan Balance";
            END;
        
          VarDateFilter:='..'+FORMAT(VarLastMonth);
          ObjLoans.SETFILTER(ObjLoans."Date filter",VarDateFilter);
              ObjLoans.CALCFIELDS(ObjLoans."Outstanding Balance");
              VarLBal:=ObjLoans."Outstanding Balance";
              VarLBal:=ObjLoans."Outstanding Balance";
        
          //Amount in Arrears
          VarArrears:=VarScheduledLoanBal-VarLBal;
          IF (VarArrears>0) OR (VarArrears=0) THEN BEGIN
          VarArrears:=0
          END ELSE
          VarArrears:=VarArrears;
          END;
          UNTIL ObjLoans.NEXT=0;
          END;
        
          UNTIL ObjCust.NEXT=0;
        END;
        VarTotalArrears:=VarTotalArrears+VarArrears;*/

    end;


    procedure FnGetLoanArrearsAmountII(VarLoanNo: Code[20])
    var
        ObjLoanRepaymentschedule: Record "Loan Repayment Schedule";
        ObjLoans: Record "Loans Register";
        VarPrinciplePaid: Decimal;
        VarAmountRemaining: Decimal;
        VarAmountAllocated: Decimal;
        VarDateFilter: Text;
        VarSchedulePrincipletoDate: Decimal;
        VarActualPrincipletoDate: Decimal;
        VarAmountinArrears: Decimal;
        VarNoofDaysinArrears: Integer;
        VarInterestPaid: Decimal;
        VarInsurancePaid: Decimal;
        VarAmountRemainingInterest: Decimal;
        VarAmountRemainingInsurance: Decimal;
        VarAmountAllocatedInterest: Decimal;
        VarAmountAllocatedInsurance: Decimal;
        VarScheduleInteresttoDate: Decimal;
        VarActualInteresttoDate: Decimal;
        VarScheduleInsurancetoDate: Decimal;
        VarActualInsurancetoDate: Decimal;
        VarAmountinArrearsInterest: Decimal;
        VarAmountinArrearsInsurance: Decimal;
        VarOutstandingPenalty: Decimal;
        VarLastInstalmentDueDate: Date;
        ObjLoanInterestAccrued: Record "Interest Due Ledger Entry";
        VarTotalInterestAccrued: Decimal;
        VarRoundedArrears: Decimal;
    begin
        VarAmountRemaining := 0;
        VarAmountAllocated := 0;
        //VarAmountRemainingInterest:=0;
        //VarAmountRemainingInsurance:=0;

        //=================================================Initialize amounts Paid on the Schedule
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                ObjLoanRepaymentschedule."Principle Amount Paid" := 0;
                ObjLoanRepaymentschedule."Interest Paid" := 0;
                ObjLoanRepaymentschedule."Insurance Paid" := 0;
                ObjLoanRepaymentschedule."Instalment Fully Settled" := false;
                ObjLoanRepaymentschedule.Modify;
            until ObjLoanRepaymentschedule.Next = 0;
        end;
        //=================================================End Initialize amounts Paid on the Schedule

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        if ObjLoans.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Principle Paid to Date", ObjLoans."Loan Insurance Paid", ObjLoans."Interest Paid", ObjLoans."Principle Paid Historical"
            , ObjLoans."Interest Paid Historical", ObjLoans."Insurance Paid Historical", ObjLoans."Penalty Paid Historical");

            VarPrinciplePaid := (ObjLoans."Principle Paid to Date" + ObjLoans."Principle Paid Historical" * -1);
            VarInterestPaid := (ObjLoans."Interest Paid" + ObjLoans."Interest Paid Historical");
            VarInsurancePaid := ((ObjLoans."Loan Insurance Paid" * -1) + ObjLoans."Insurance Paid Historical");
        end;

        VarAmountRemaining := VarPrinciplePaid;
        VarAmountRemainingInterest := VarInterestPaid;
        VarAmountRemainingInsurance := VarInsurancePaid;


        //====================================================Loan Principle
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                if VarAmountRemaining > 0 then begin
                    if VarAmountRemaining >= ObjLoanRepaymentschedule."Principal Repayment" then begin
                        VarAmountAllocated := ObjLoanRepaymentschedule."Principal Repayment";
                        ObjLoanRepaymentschedule."Instalment Fully Settled" := true;
                        ObjLoanRepaymentschedule.Modify;
                    end;

                    if VarAmountRemaining < ObjLoanRepaymentschedule."Principal Repayment" then begin
                        VarAmountAllocated := VarAmountRemaining;
                    end;

                    ObjLoanRepaymentschedule."Principal Repayment" := ROUND(ObjLoanRepaymentschedule."Principal Repayment", 0.01, '=');
                    ObjLoanRepaymentschedule."Principle Amount Paid" := ROUND(VarAmountAllocated, 0.01, '=');
                    ObjLoanRepaymentschedule.Modify;
                    VarAmountRemaining := VarAmountRemaining - VarAmountAllocated;
                end;
            until ObjLoanRepaymentschedule.Next = 0;
        end;

        //====================================================Loan Interest
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                if VarAmountRemainingInterest > 0 then begin

                    if VarAmountRemainingInterest >= ObjLoanRepaymentschedule."Monthly Interest" then begin
                        VarAmountAllocatedInterest := ObjLoanRepaymentschedule."Monthly Interest"
                    end;

                    if VarAmountRemainingInterest < ObjLoanRepaymentschedule."Monthly Interest" then begin
                        VarAmountAllocatedInterest := VarAmountRemainingInterest;
                    end;

                    ObjLoanRepaymentschedule."Interest Paid" := VarAmountAllocatedInterest;
                    ObjLoanRepaymentschedule.Modify;
                    VarAmountRemainingInterest := VarAmountRemainingInterest - VarAmountAllocatedInterest;
                end;
            until ObjLoanRepaymentschedule.Next = 0;
        end;




        //====================================================Loan Insurance
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                if VarAmountRemainingInsurance > 0 then begin
                    if VarAmountRemainingInsurance >= ObjLoanRepaymentschedule."Monthly Insurance" then begin
                        VarAmountAllocatedInsurance := ObjLoanRepaymentschedule."Monthly Insurance"
                    end;

                    if VarAmountRemainingInsurance < ObjLoanRepaymentschedule."Monthly Insurance" then begin
                        VarAmountAllocatedInsurance := VarAmountRemainingInsurance;
                    end;

                    ObjLoanRepaymentschedule."Insurance Paid" := VarAmountAllocatedInsurance;
                    ObjLoanRepaymentschedule.Modify;
                    VarAmountRemainingInsurance := VarAmountRemainingInsurance - VarAmountAllocatedInsurance;
                end;
            until ObjLoanRepaymentschedule.Next = 0;
        end;

        VarDateFilter := '..' + Format(WorkDate);

        //===================================================Scheduled Repayment to Date
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Repayment Date", '<%1', WorkDate);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                VarSchedulePrincipletoDate := VarSchedulePrincipletoDate + ObjLoanRepaymentschedule."Principal Repayment";
                VarScheduleInteresttoDate := VarScheduleInteresttoDate + ObjLoanRepaymentschedule."Monthly Interest";
                VarScheduleInsurancetoDate := VarScheduleInsurancetoDate + ObjLoanRepaymentschedule."Monthly Insurance";
            until ObjLoanRepaymentschedule.Next = 0;
        end;

        //===================================================Actual Repayment to Date
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Principle Amount Paid", '<>%1', 0);
        if ObjLoanRepaymentschedule.FindSet then begin
            if ObjLoanRepaymentschedule."Repayment Date" < WorkDate then begin
                repeat
                    VarActualPrincipletoDate := VarActualPrincipletoDate + ObjLoanRepaymentschedule."Principle Amount Paid";
                    VarActualInteresttoDate := VarActualInteresttoDate + ObjLoanRepaymentschedule."Interest Paid";
                    VarActualInsurancetoDate := VarActualInsurancetoDate + ObjLoanRepaymentschedule."Insurance Paid";
                until ObjLoanRepaymentschedule.Next = 0;
            end;
        end;


        //====================================================Get Loan Interest In Arrears
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetCurrentkey(ObjLoanRepaymentschedule."Repayment Date");
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Repayment Date", '<%1', WorkDate);
        if ObjLoanRepaymentschedule.FindLast then begin
            VarLastInstalmentDueDate := ObjLoanRepaymentschedule."Repayment Date";
        end;

        ObjLoanInterestAccrued.Reset;
        ObjLoanInterestAccrued.SetRange(ObjLoanInterestAccrued."Loan No", VarLoanNo);
        ObjLoanInterestAccrued.SetFilter(ObjLoanInterestAccrued."Posting Date", '<=%1', VarLastInstalmentDueDate);
        if ObjLoanInterestAccrued.FindSet then begin
            repeat
                VarTotalInterestAccrued := VarTotalInterestAccrued + ObjLoanInterestAccrued.Amount;
            until ObjLoanInterestAccrued.Next = 0;
        end;

        VarAmountinArrearsInterest := VarTotalInterestAccrued - VarInterestPaid;
        if VarAmountinArrearsInterest < 0 then
            VarAmountinArrearsInterest := 0;
        //====================================================Get Loan Interest In Arrears

        VarAmountinArrears := 0;

        //=================================Loan Principle


        if ObjLoans.Get(VarLoanNo) then begin
            ObjLoans.CalcFields(ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Outstanding Balance");
            if ObjLoans."Outstanding Balance" > 0 then begin
                VarAmountinArrears := VarSchedulePrincipletoDate - VarActualPrincipletoDate;
                VarAmountinArrearsInsurance := VarScheduleInsurancetoDate - VarActualInsurancetoDate;
                if VarAmountinArrears < 0 then begin
                    VarAmountinArrears := 0
                end;
            end;
        end;
        //=================================Loan Interest
        if VarAmountinArrearsInterest < 0 then begin
            VarAmountinArrearsInterest := 0
        end else
            VarAmountinArrearsInterest := VarAmountinArrearsInterest;

        //=================================Loan Insurance
        if VarAmountinArrearsInsurance < 0 then begin
            VarAmountinArrearsInsurance := 0
        end else
            VarAmountinArrearsInsurance := VarAmountinArrearsInsurance;

        //=================================Loan Principle
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetCurrentkey(ObjLoanRepaymentschedule."Repayment Date");
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Instalment Fully Settled", false);
        if ObjLoanRepaymentschedule.FindFirst then begin
            VarNoofDaysinArrears := WorkDate - ObjLoanRepaymentschedule."Repayment Date";
        end;



        if VarNoofDaysinArrears < 0 then begin
            VarNoofDaysinArrears := 0
        end else
            VarNoofDaysinArrears := VarNoofDaysinArrears;



        if ObjLoans.Get(VarLoanNo) then begin
            ObjLoans.CalcFields(ObjLoans."Penalty Charged", ObjLoans."Penalty Paid");

            VarOutstandingPenalty := ObjLoans."Penalty Charged" - ObjLoans."Penalty Paid";
            if VarOutstandingPenalty < 0 then
                VarOutstandingPenalty := 0;


            VarRoundedArrears := VarAmountinArrears + VarAmountinArrearsInterest + VarAmountinArrearsInsurance + VarOutstandingPenalty;
            if VarRoundedArrears < 0 then
                VarRoundedArrears := 0;
            if VarRoundedArrears = 0 then
                VarNoofDaysinArrears := 0;
            ObjLoans."Amount in Arrears" := VarRoundedArrears;
            ObjLoans."Days In Arrears" := VarNoofDaysinArrears;

            //==============================================================================Update Loan Category
            if (VarNoofDaysinArrears = 0) then begin
                ObjLoans."Loans Category" := ObjLoans."loans category"::Perfoming;
                ObjLoans."Loans Category-SASRA" := ObjLoans."loans category-sasra"::Perfoming;
            end else
                if (VarNoofDaysinArrears > 0) and (VarNoofDaysinArrears <= 30) then begin
                    ObjLoans."Loans Category" := ObjLoans."loans category"::Watch;
                    ObjLoans."Loans Category-SASRA" := ObjLoans."loans category-sasra"::Watch;
                end else
                    if (VarNoofDaysinArrears >= 31) and (VarNoofDaysinArrears <= 180) then begin
                        ObjLoans."Loans Category" := ObjLoans."loans category"::Substandard;
                        ObjLoans."Loans Category-SASRA" := ObjLoans."loans category-sasra"::Substandard;
                    end else
                        if (VarNoofDaysinArrears >= 181) and (VarNoofDaysinArrears <= 360) then begin
                            ObjLoans."Loans Category" := ObjLoans."loans category"::Doubtful;
                            ObjLoans."Loans Category-SASRA" := ObjLoans."loans category-sasra"::Doubtful
                        end else
                            if (VarNoofDaysinArrears > 360) then begin
                                ObjLoans."Loans Category" := ObjLoans."loans category"::Loss;
                                ObjLoans."Loans Category-SASRA" := ObjLoans."loans category-sasra"::Loss;
                            end;
            //==============================================================================End Update Loan Category

            ObjLoans.Modify;
        end;

    end;


    procedure FnCreateLoanRecoveryJournals(VarLoanNoRecovered: Code[30]; BATCH_TEMPLATE: Code[20]; BATCH_NAME: Code[20]; DOCUMENT_NO: Code[20]; VarMemberNo: Code[20]; VarPostingDate: Date; EXTERNAL_DOC_NO: Code[30]; VarLoanSettlementAcc: Code[30]; VarMemberName: Text[100]; RunningBalance: Decimal)
    var
        ObjLoans: Record "Loans Register";
        AmountToDeduct: Decimal;
        LineNo: Integer;
        SFactory: Codeunit "Micropoint Factory";
        VarAmounttoDeduct: Decimal;
        VarOutstandingInterest: Decimal;
        VarEndYear: Date;
        VarInsuranceMonths: Integer;
        ObjProductCharge: Record "Loan Product Charges";
        VarInsurancePayoff: Decimal;
        VarOutstandingInsurance: Decimal;
        VarLoanInsuranceBalAccount: Code[30];
        ObjLoanType: Record "Loan Products Setup";
        ObjLoanSchedule: Record "Loan Repayment Schedule";
        VarLoanInsuranceCharged: Decimal;
        VarLoanInsurancePaid: Decimal;
        VarTotalOutstandingInsurance: Decimal;
        VarLoanInterestDueBalAccount: Code[30];
        VarOutstandingPenalty: Decimal;
        VarLoanPenaltyBalAccount: Code[30];
        VarLoanDueAmount: Decimal;
        VarDebtCollectorBaseAmount: Decimal;
        VarDebtCollectorFee: Decimal;
        ObjLoanRepaymentschedule: Record "Loan Repayment Schedule";
        VarLastInstalmentDueDate: Date;
        ObjLoanInterestAccrued: Record "Interest Due Ledger Entry";
        VarTotalInterestAccrued: Decimal;
        VarAmountinArrearsInterest: Decimal;
         ObjGenSetUp: Record "Sacco General Set-Up";
    begin
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;


        //============================================================Debt Collector Fee
        if RunningBalance > 0 then begin
            if ObjLoans.Get(VarLoanNoRecovered) then begin
                VarDebtCollectorFee := SFactory.FnRunGetLoanDebtCollectorFee(VarLoanNoRecovered, RunningBalance);

                if RunningBalance > VarDebtCollectorFee then begin
                    AmountToDeduct := VarDebtCollectorFee
                end else
                    AmountToDeduct := RunningBalance;

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Recovery Account",
                GenJournalLine."account type"::Customer, ObjLoans."Loan Debt Collector", VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                'Debt Collection Charge + VAT from ' + VarLoanNoRecovered + ObjLoans."Client Name", VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Recovery Account",
                GenJournalLine."account type"::Customer, VarLoanSettlementAcc, VarPostingDate, AmountToDeduct, 'BOSA', EXTERNAL_DOC_NO,
                'Debt Collection Charge + VAT from ' + VarLoanNoRecovered + ObjLoans."Client Name", VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);
                RunningBalance := RunningBalance - AmountToDeduct;

            end;
        end;




        //============================================================Loan Penalty Repayment
        if RunningBalance > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            if ObjLoans.Find('-') then begin
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Penalty Paid Historical");
                if RunningBalance > 0 then begin
                    AmountToDeduct := 0;

                    VarOutstandingPenalty := ObjLoans."Penalty Charged" - (ObjLoans."Penalty Paid" + ObjLoans."Penalty Paid Historical");
                    if VarOutstandingPenalty < 0 then
                        VarOutstandingPenalty := 0;

                    if VarOutstandingPenalty > 0 then begin
                        if VarOutstandingPenalty < RunningBalance then begin
                            AmountToDeduct := VarOutstandingPenalty
                        end else
                            AmountToDeduct := RunningBalance;
                        AmountToDeduct := ROUND(AmountToDeduct, 0.01, '=');

                        if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                            VarLoanPenaltyBalAccount := ObjLoanType."Penalty Charged Account";
                        end;



                        //------------------------------------Debit Loan Penalty Charged---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Penalty Charged",
                        GenJournalLine."account type"::Customer, ObjLoans."Client Code", WorkDate, 'Loan Penalty Charged - ' + VarLoanNoRecovered, GenJournalLine."bal. account type"::"G/L Account",
                        VarLoanPenaltyBalAccount, AmountToDeduct, 'BOSA', VarLoanNoRecovered);
                        //--------------------------------Debit Loan Penalty Charged-------------------------------------------------------------------------------

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Penalty Paid",
                        GenJournalLine."account type"::Customer, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'Loan Penalty Paid - ' + VarLoanNoRecovered, VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);

                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                    end;
                end;
            end;
        end;

        //============================================================Loan Interest Repayment
        if RunningBalance > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            if ObjLoans.Find('-') then begin

                //====================================================Get Loan Interest In Arrears
                ObjLoanRepaymentschedule.Reset;
                ObjLoanRepaymentschedule.SetCurrentkey(ObjLoanRepaymentschedule."Repayment Date");
                ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNoRecovered);
                ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Repayment Date", '<=%1', WorkDate);
                if ObjLoanRepaymentschedule.FindLast then begin
                    VarLastInstalmentDueDate := ObjLoanRepaymentschedule."Repayment Date";
                end;

                ObjLoanInterestAccrued.Reset;
                ObjLoanInterestAccrued.SetRange(ObjLoanInterestAccrued."Loan No", VarLoanNoRecovered);
                ObjLoanInterestAccrued.SetFilter(ObjLoanInterestAccrued."Posting Date", '<=%1', VarLastInstalmentDueDate);
                if ObjLoanInterestAccrued.FindSet then begin
                    repeat
                        VarTotalInterestAccrued := VarTotalInterestAccrued + ObjLoanInterestAccrued.Amount;
                    until ObjLoanInterestAccrued.Next = 0;

                end;

                ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Interest Due", ObjLoans."Interest Paid", ObjLoans."Penalty Charged",
                ObjLoans."Penalty Paid", ObjLoans."Interest Paid Historical");
                VarAmountinArrearsInterest := VarTotalInterestAccrued - (ObjLoans."Interest Paid" + ObjLoans."Interest Paid Historical");
                if VarAmountinArrearsInterest < 0 then
                    VarAmountinArrearsInterest := 0;
                //====================================================Get Loan Interest In Arrears


                if RunningBalance > 0 then begin
                    VarOutstandingInterest := VarAmountinArrearsInterest;
                    if VarOutstandingInterest < 0 then
                        VarOutstandingInterest := 0;

                    AmountToDeduct := 0;
                    if VarOutstandingInterest > 0 then begin
                        if VarOutstandingInterest < RunningBalance then begin
                            AmountToDeduct := VarOutstandingInterest
                        end else
                            AmountToDeduct := RunningBalance;
                        AmountToDeduct := ROUND(AmountToDeduct, 0.01, '=');


                        if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                            VarLoanInterestDueBalAccount := ObjLoanType."Receivable Interest Account";
                        end;

                        //------------------------------------Debit Loan Interest Due---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Due",
                        GenJournalLine."account type"::Customer, VarMemberNo, VarPostingDate, 'Loan Interest Charged - ' + VarLoanNoRecovered, GenJournalLine."bal. account type"::"G/L Account",
                        VarLoanInterestDueBalAccount, AmountToDeduct, 'BOSA', VarLoanNoRecovered);
                        //--------------------------------Debit Loan Interest Due-------------------------------------------------------------------------------

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                        GenJournalLine."account type"::Customer, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'Loan Interest Paid - ' + VarLoanNoRecovered, VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);

                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                    end;
                end;
            end;
        end;


        //============================================================Loan Insurance Repayment

        if RunningBalance > 0 then begin

            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            if ObjLoans.Find('-') then begin

                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
                if ObjLoans.FindSet then begin
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Interest Due",
                    ObjLoans."Interest Paid", ObjLoans."Insurance Paid Historical");

                    if ObjLoans."Outstanding Balance" <> 0 then begin
                        VarEndYear := CalcDate('CY', Today);
                        VarInsuranceMonths := ROUND((VarEndYear - Today) / 30, 1, '=');

                        ObjProductCharge.Reset;
                        ObjProductCharge.SetRange(ObjProductCharge."Product Code", ObjLoans."Loan Product Type");
                        ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                        if ObjProductCharge.FindSet then begin
                            VarInsurancePayoff := ROUND((ObjLoans."Approved Amount" * (ObjProductCharge.Percentage / 100)) * VarInsuranceMonths, 0.05, '>');
                        end;
                    end;
                end;

                FnGetLoanArrearsAmountII(VarLoanNoRecovered);//===========================Get Amount In Arrears

                ObjLoanSchedule.Reset;
                ObjLoanSchedule.SetRange(ObjLoanSchedule."Loan No.", VarLoanNoRecovered);
                ObjLoanSchedule.SetFilter(ObjLoanSchedule."Repayment Date", '<=%1', WorkDate);
                if ObjLoanSchedule.FindSet then begin
                    repeat
                        VarLoanInsuranceCharged := VarLoanInsuranceCharged + ObjLoanSchedule."Monthly Insurance";
                        VarLoanInsurancePaid := VarLoanInsurancePaid + ObjLoanSchedule."Insurance Paid";
                    until ObjLoanSchedule.Next = 0;
                end;

                VarOutstandingInsurance := VarLoanInsuranceCharged - VarLoanInsurancePaid;

                if RunningBalance > 0 then begin
                    AmountToDeduct := 0;

                    VarTotalOutstandingInsurance := VarOutstandingInsurance;//+VarInsurancePayoff;

                    if VarTotalOutstandingInsurance > 0 then begin
                        if VarTotalOutstandingInsurance < RunningBalance then begin
                            AmountToDeduct := VarTotalOutstandingInsurance
                        end else
                            AmountToDeduct := RunningBalance;
                        AmountToDeduct := ROUND(AmountToDeduct, 0.01, '=');

                        if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                            VarLoanInsuranceBalAccount := ObjLoanType."Receivable Insurance Accounts";
                        end;

                        //------------------------------------Debit Loan Insurance Due---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Charged",
                        GenJournalLine."account type"::Customer, ObjLoans."Client Code", WorkDate, 'Loan Insurance Charged - ' + VarLoanNoRecovered, GenJournalLine."bal. account type"::"G/L Account",
                        VarLoanInsuranceBalAccount, AmountToDeduct, 'BOSA', VarLoanNoRecovered);
                        //--------------------------------Debit Loan Insurance Due-------------------------------------------------------------------------------

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Paid",
                        GenJournalLine."account type"::Customer, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'Loan Insurance Paid - ' + VarLoanNoRecovered, VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);

                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                    end;
                end;
            end;
        end;



        //============================================================Loan Principle Repayment
        if RunningBalance > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            if ObjLoans.Find('-') then begin
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid");
                if RunningBalance > 0 then begin
                    AmountToDeduct := 0;
                    if ObjLoans."Outstanding Balance" > 0 then begin
                        if ObjLoans."Outstanding Balance" < RunningBalance then begin
                            AmountToDeduct := ObjLoans."Outstanding Balance"
                        end else
                            AmountToDeduct := RunningBalance;
                        AmountToDeduct := ROUND(AmountToDeduct, 0.01, '=');

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                        GenJournalLine."account type"::Customer, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'Loan Principal Repayment - ' + VarLoanNoRecovered, VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);
                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                        VarAmounttoDeduct := ROUND(VarAmounttoDeduct, 0.01, '=');
                    end;
                end;
            end;
        end;


        if ObjLoans.Get(VarLoanNoRecovered) then begin
            //==============================================================================================Recover From Loan Settlement Account
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Customer, VarLoanSettlementAcc, VarPostingDate, VarAmounttoDeduct, 'BOSA', EXTERNAL_DOC_NO,
            'Loan Repayment - ' + VarLoanNoRecovered + ' ' + ObjLoans."Loan Product Type Name", '', GenJournalLine."application source"::" ");
            //==============================================================================================End Recover From Loan Settlement Account
        end;

            if ObjLoans.Get(VarLoanNoRecovered) then begin
        if ObjLoans."Monthly Tracking Fee" > 0 then begin
            ObjGenSetUp.Get();
            ObjGenSetUp.TestField("Car Tracking Fee Account");

            // Debit Member BOSA Account for Tracking Fee
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(
                BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo,
                GenJournalLine."transaction type"::"Loan Repayment",
                GenJournalLine."account type"::Customer,
                ObjLoans."Client Code",
                VarPostingDate,
                ObjLoans."Monthly Tracking Fee" * -1,
                'BOSA',
                EXTERNAL_DOC_NO,
                'Car Tracking Fee - ' + VarLoanNoRecovered,
                VarLoanNoRecovered,
                GenJournalLine."application source"::" "
            );

            // Credit Car Tracking Fee GL Account
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(
                BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo,
                GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account",
                ObjGenSetUp."Car Tracking Fee Account",
                VarPostingDate,
                ObjLoans."Monthly Tracking Fee",
                'BOSA',
                EXTERNAL_DOC_NO,
                'Car Tracking Fee - ' + VarLoanNoRecovered,
                VarLoanNoRecovered,
                GenJournalLine."application source"::" "
            );
        end;
    end;
    end;


    procedure FnCreateGuarantorRecoveryReimbursment(VarMemberNo: Code[20]; VarBalanceinFOSA: Decimal; VarFOSAAccountNo: Code[20]; VarDocumentNo: Code[20])
    var
        // ObjGuarantorLedger: Record "Guarantor Recovery Ledger";
        VarAmounttoDeduct: Decimal;
        LineNo: Integer;
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        EXTERNAL_DOC_NO: Code[40];
        SFactory: Codeunit "Micropoint Factory";
        VarRecoveryDifference: Decimal;
        VarAmountApportioned: Decimal;
        VarDepositNo: Code[30];
    begin
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'RECOVERIES';
        DOCUMENT_NO := VarDocumentNo;
        EXTERNAL_DOC_NO := VarDocumentNo;

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;


        VarAmounttoDeduct := 0;
        // ObjGuarantorLedger.Reset;
        // ObjGuarantorLedger.SetRange(ObjGuarantorLedger."Defaulter Member No", VarMemberNo);
        // ObjGuarantorLedger.SetRange(ObjGuarantorLedger."Fully Settled", false);
        // if ObjGuarantorLedger.FindSet then begin
        //     repeat
        //         ObjGuarantorLedger.CalcFields(ObjGuarantorLedger."Total Amount Apportioned");
        //         VarAmountApportioned := ObjGuarantorLedger."Amount Allocated" / ObjGuarantorLedger."Total Amount Apportioned" * VarBalanceinFOSA;
        //         VarRecoveryDifference := ObjGuarantorLedger."Amount Allocated" - ObjGuarantorLedger."Amount Paid Back";

        //         if ObjMembers.Get(ObjGuarantorLedger."Guarantor No") then begin
        //             VarDepositNo := ObjMembers."Deposits Account No";
        //         end;

        //         if VarRecoveryDifference > VarAmountApportioned then begin
        //             VarRecoveryDifference := VarAmountApportioned
        //         end else
        //             VarRecoveryDifference := VarRecoveryDifference;

        //         if VarBalanceinFOSA > 0 then begin
        //             if VarBalanceinFOSA > VarRecoveryDifference then begin
        //                 VarAmounttoDeduct := VarRecoveryDifference
        //             end else
        //                 VarAmounttoDeduct := VarBalanceinFOSA;

        //             //======================================================================================================Recover From FOSA Account
        //             LineNo := LineNo + 10000;
        //             SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        //             GenJournalLine."account type"::Vendor, VarFOSAAccountNo, WorkDate, VarAmounttoDeduct, 'BOSA', EXTERNAL_DOC_NO,
        //             'Guarantor Reimbursment:' + ObjGuarantorLedger."Guarantor Name", '', GenJournalLine."recovery transaction type"::"Guarantor Paid", '');

        //             //======================================================================================================Recovery to Deposit Account
        //             LineNo := LineNo + 10000;
        //             SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
        //             GenJournalLine."account type"::Vendor, VarDepositNo, WorkDate, VarAmounttoDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
        //             'Recovery Reimbursment:' + ObjGuarantorLedger."Defaulter Name", '', GenJournalLine."recovery transaction type"::"Guarantor Paid", '');

        //             ObjGuarantorLedger."Amount Paid Back" := ObjGuarantorLedger."Amount Paid Back" + VarAmounttoDeduct;
        //             if ObjGuarantorLedger."Amount Allocated" = ObjGuarantorLedger."Amount Paid Back" then begin
        //                 ObjGuarantorLedger."Fully Settled" := true;
        //                 ObjGuarantorLedger.Modify;
        //             end;
        //             ObjGuarantorLedger.Modify;
        //             VarBalanceinFOSA := VarBalanceinFOSA - VarAmounttoDeduct;
        //         end;
        //     until ObjGuarantorLedger.Next = 0;
        // end;

        // //Post New
        // GenJournalLine.Reset;
        // GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        // GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        // if GenJournalLine.Find('-') then begin
        //     Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
        // end;
    end;

    local procedure FnRecoverLoansFromFOSAAccounts()
    var
        ObjLoanScheduleII: Record "Loan Repayment Schedule";
        ObjAccounts: Record Vendor;
    begin
        ObjLSchedule.Reset;
        ObjLSchedule.SetRange(ObjLSchedule."Loan No.", ObjLoanScheduleII."Loan No.");
        ObjLSchedule.SetFilter(ObjLSchedule."Repayment Date", '=%1', WorkDate);
        if ObjLSchedule.FindSet then begin
            if ObjLoans.Get(ObjLSchedule."Loan No.") then begin

                ObjAccounts.Reset;
                ObjAccounts.SetRange(ObjAccounts."BOSA Account No", ObjLoans."Client Code");
                ObjAccounts.SetRange(ObjAccounts."Account Type", '507');
                if ObjAccounts.FindSet then begin

                end;
            end;
        end;
    end;


    procedure FnSendStatementViaMail("Recepient Name": Text; Subject: Text; Body: Text; "Recepient Email": Text; "Report Name": Text; AddCC: Text) Result: Boolean
    begin
        // SMTPSetup.Reset;
        // SMTPSetup.Get;
        //  SMTP.CreateMessage(COMPANYNAME,SMTPSetup."Email Sender Address","Recepient Email",Subject,'',true);
        //  SMTP.AppendBody('<html> <body> <font face="Maiandra GD,Garamond,Tahoma", size = "3">');
        //SMTP.AppendBody('Dear '+"Recepient Name"+',');
        // SMTP.AppendBody('<br><br>');
        // SMTP.AppendBody(Body);
        // SMTP.AppendBody('<br><br>');
        //SMTP.AppendBody('<HR>');
        // SMTP.AppendBody('Kind Regards');
        // SMTP.AppendBody('<br>');
        // SMTP.AppendBody('<img src="http://RUAI ENDELEAsacco.com/images/New_Logo.png" alt="KSacco Logo">');
        // SMTP.AppendBody('<br>');
        // SMTP.AppendBody('RUAI ENDELEA SACCO SOCIETY LIMITED');
        // SMTP.AppendBody('<br>');
        // SMTP.AppendBody('P.O. Box 8017 - 00300 Nairobi, Kenya');
        // SMTP.AppendBody('<br>');
        // SMTP.AppendBody('Tel: 0720838422, 0705344094');
        // SMTP.AppendBody('<br>');
        // SMTP.AppendBody('info@RUAI ENDELEAsacco.com');
        // SMTP.AppendBody('<br>');
        //SMTP.AppendBody('www.RUAI ENDELEAsacco.com');
        // SMTP.AppendBody('<br>');
        // SMTP.AppendBody('Empowering People, Transfoming Lives');
        //SMTP.AppendBody('<br>');
        //if  AddCC  ='' then  begin
        // end else begin
        //   SMTP.AddCC(AddCC);
        //  end;
        //SMTP.AppendBody('</body></font></html>');
        //if Exists(SMTPSetup."Path to Save Report"+"Report Name") then
        //  SMTP.AddAttachment(SMTPSetup."Path to Save Report"+"Report Name",'');
        // SMTP.Send;
        // ObjEmailLogs.Reset;
        // if ObjEmailLogs.Find('+') then begin
        //iEntryNo:=ObjEmailLogs.No;
        //iEntryNo:=iEntryNo+1;

        // end
        //else begin
        //iEntryNo:=1;
        //end;
        // ObjEmailLogs.Reset;
        // ObjEmailLogs.Init;
        // ObjEmailLogs.No:=iEntryNo;
        // ObjEmailLogs.Subject:=Subject;
        // ObjEmailLogs.Body:=CopyStr(Body,1,250);
        // ObjEmailLogs.Name:="Recepient Name";
        // ObjEmailLogs."Recepient EMail":="Recepient Email";
        // ObjEmailLogs."Date Sent":=CurrentDatetime;
        //ObjEmailLogs."Sender E Mail":=SMTPSetup."Email Sender Address";
        //ObjEmailLogs.Status:=ObjEmailLogs.Status::Sent;
        //ObjEmailLogs.Insert;
        //  Result:=true;
    end;


    procedure FnCreateLoanRecoveryJournalsLSAUfalme(VarLoanNoRecovered: Code[30]; BATCH_TEMPLATE: Code[20]; BATCH_NAME: Code[20]; DOCUMENT_NO: Code[20]; VarMemberNo: Code[20]; VarPostingDate: Date; EXTERNAL_DOC_NO: Code[30]; VarLoanSettlementAcc: Code[30]; VarMemberName: Text[100]; RunningBalance: Decimal)
    var
        ObjLoans: Record "Loans Register";
        AmountToDeduct: Decimal;
        LineNo: Integer;
        SFactory: Codeunit "Micropoint Factory";
        VarAmounttoDeduct: Decimal;
        VarOutstandingInterest: Decimal;
        VarEndYear: Date;
        VarInsuranceMonths: Integer;
        ObjProductCharge: Record "Loan Product Charges";
        VarInsurancePayoff: Decimal;
        VarOutstandingInsurance: Decimal;
        VarLoanInsuranceBalAccount: Code[30];
        ObjLoanType: Record "Loan Products Setup";
        ObjLoanSchedule: Record "Loan Repayment Schedule";
        VarLoanInsuranceCharged: Decimal;
        VarLoanInsurancePaid: Decimal;
        VarTotalOutstandingInsurance: Decimal;
        VarLoanInterestDueBalAccount: Code[30];
        VarOutstandingPenalty: Decimal;
        VarLoanPenaltyBalAccount: Code[30];
        ObjRepamentSchedule: Record "Loan Repayment Schedule";
        VarPrincipleRepayment: Decimal;
    begin
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;

        if RunningBalance > 0 then begin

            //============================================================Loan Insurance Repayment
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            if ObjLoans.Find('-') then begin

                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
                if ObjLoans.FindSet then begin
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Loan Insurance Paid", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Interest Due",
                    ObjLoans."Interest Paid", ObjLoans."Insurance Paid Historical");

                    if ObjLoans."Outstanding Balance" <> 0 then begin
                        VarEndYear := CalcDate('CY', Today);
                        VarInsuranceMonths := ROUND((VarEndYear - Today) / 30, 1, '=');

                        ObjProductCharge.Reset;
                        ObjProductCharge.SetRange(ObjProductCharge."Product Code", ObjLoans."Loan Product Type");
                        ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                        if ObjProductCharge.FindSet then begin
                            VarInsurancePayoff := ROUND((ObjLoans."Approved Amount" * (ObjProductCharge.Percentage / 100)) * VarInsuranceMonths, 0.05, '>');
                        end;
                    end;
                end;

                FnGetLoanArrearsAmountII(VarLoanNoRecovered);//===========================Get Amount In Arrears

                ObjLoanSchedule.Reset;
                ObjLoanSchedule.SetRange(ObjLoanSchedule."Loan No.", VarLoanNoRecovered);
                ObjLoanSchedule.SetFilter(ObjLoanSchedule."Repayment Date", '<=%1', WorkDate);
                if ObjLoanSchedule.FindSet then begin
                    repeat
                        VarLoanInsuranceCharged := VarLoanInsuranceCharged + ObjLoanSchedule."Monthly Insurance";
                        VarLoanInsurancePaid := VarLoanInsurancePaid + ObjLoanSchedule."Insurance Paid";
                    until ObjLoanSchedule.Next = 0;
                end;

                VarOutstandingInsurance := VarLoanInsuranceCharged - VarLoanInsurancePaid;

                if RunningBalance > 0 then begin
                    AmountToDeduct := 0;

                    VarTotalOutstandingInsurance := VarOutstandingInsurance;

                    if VarTotalOutstandingInsurance > 0 then begin
                        if VarTotalOutstandingInsurance < RunningBalance then begin
                            AmountToDeduct := VarTotalOutstandingInsurance
                        end else
                            AmountToDeduct := RunningBalance;

                        if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                            VarLoanInsuranceBalAccount := ObjLoanType."Receivable Insurance Accounts";
                        end;

                        //------------------------------------Debit Loan Insurance Due---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Charged",
                        GenJournalLine."account type"::Customer, ObjLoans."Client Code", WorkDate, 'Insurance Charged:_' + DOCUMENT_NO, GenJournalLine."bal. account type"::"G/L Account",
                        VarLoanInsuranceBalAccount, AmountToDeduct, 'BOSA', VarLoanNoRecovered);
                        //--------------------------------Debit Loan Insurance Due-------------------------------------------------------------------------------

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Paid",
                        GenJournalLine."account type"::Customer, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'Insurance Paid', VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);

                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                    end;
                end;
            end;
        end;


        //============================================================Loan Penalty Repayment
        if RunningBalance > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            if ObjLoans.Find('-') then begin
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Penalty Paid Historical");
                if RunningBalance > 0 then begin
                    AmountToDeduct := 0;

                    VarOutstandingPenalty := ObjLoans."Penalty Charged" - (ObjLoans."Penalty Paid" + ObjLoans."Penalty Paid Historical");
                    if VarOutstandingPenalty < 0 then
                        VarOutstandingPenalty := 0;

                    if VarOutstandingPenalty > 0 then begin
                        if VarOutstandingPenalty < RunningBalance then begin
                            AmountToDeduct := VarOutstandingPenalty
                        end else
                            AmountToDeduct := RunningBalance;


                        if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                            VarLoanPenaltyBalAccount := ObjLoanType."Penalty Charged Account";
                        end;



                        //------------------------------------Debit Loan Penalty Charged---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Penalty Charged",
                        GenJournalLine."account type"::Customer, ObjLoans."Client Code", WorkDate, 'Penalty Charged:_' + DOCUMENT_NO, GenJournalLine."bal. account type"::"G/L Account",
                        VarLoanPenaltyBalAccount, AmountToDeduct, 'BOSA', VarLoanNoRecovered);
                        //--------------------------------Debit Loan Penalty Charged-------------------------------------------------------------------------------

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Penalty Paid",
                        GenJournalLine."account type"::Customer, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'Penalty Paid', VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);

                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                    end;
                end;
            end;
        end;


        //============================================================Loan Interest Repayment
        if RunningBalance > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            if ObjLoans.Find('-') then begin
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Interest Due", ObjLoans."Interest Paid", ObjLoans."Penalty Charged",
              ObjLoans."Penalty Paid", ObjLoans."Interest Paid Historical");
                if RunningBalance > 0 then begin
                    VarOutstandingInterest := ObjLoans."Interest Due" - (ObjLoans."Interest Paid" + ObjLoans."Interest Paid Historical");
                    if VarOutstandingInterest < 0 then
                        VarOutstandingInterest := 0;

                    AmountToDeduct := 0;
                    if VarOutstandingInterest > 0 then begin
                        if VarOutstandingInterest < RunningBalance then begin
                            AmountToDeduct := VarOutstandingInterest
                        end else
                            AmountToDeduct := RunningBalance;



                        if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                            VarLoanInterestDueBalAccount := ObjLoanType."Receivable Interest Account";
                        end;

                        //------------------------------------Debit Loan Interest Due---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Due",
                        GenJournalLine."account type"::Customer, ObjLoans."Client Code", WorkDate, 'Interest Charged:_' + DOCUMENT_NO, GenJournalLine."bal. account type"::"G/L Account",
                        VarLoanInterestDueBalAccount, AmountToDeduct, 'BOSA', VarLoanNoRecovered);
                        //--------------------------------Debit Loan Interest Due-------------------------------------------------------------------------------

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                        GenJournalLine."account type"::Customer, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'Interest Paid', VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);

                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                    end;
                end;
            end;
        end;





        //============================================================Loan Principle Repayment
        if RunningBalance > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            if ObjLoans.Find('-') then begin

                ObjRepamentSchedule.Reset;
                ObjRepamentSchedule.SetRange(ObjRepamentSchedule."Loan No.", VarLoanNoRecovered);
                ObjRepamentSchedule.SetRange(ObjRepamentSchedule."Repayment Date", WorkDate);
                if ObjRepamentSchedule.FindSet then begin
                    VarPrincipleRepayment := ObjRepamentSchedule."Principal Repayment";
                end;

                ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid");
                if RunningBalance > 0 then begin
                    AmountToDeduct := 0;
                    if ObjLoans."Outstanding Balance" > 0 then begin
                        if VarPrincipleRepayment < RunningBalance then begin
                            AmountToDeduct := VarPrincipleRepayment
                        end else
                            AmountToDeduct := RunningBalance;

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                        GenJournalLine."account type"::Customer, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'Loan Recovery', VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);
                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                    end;
                end;
            end;
        end;

        //==============================================================================================Recover From Loan Settlement Account
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, VarLoanSettlementAcc, VarPostingDate, VarAmounttoDeduct, 'BOSA', EXTERNAL_DOC_NO,
        'Loan Recovery' + '-' + VarMemberNo + '-' + VarMemberName, '', GenJournalLine."application source"::" ");
        //==============================================================================================End Recover From Loan Settlement Account
    end;


    procedure FnGetOutstandingInterest(VarLoanNo: Code[30]) VarOutstandingInterest: Decimal
    var
        ObjLoans: Record "Loans Register";
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        ObjLoans.CalcFields(ObjLoans."Interest Due", ObjLoans."Interest Paid", ObjLoans."Interest Paid Historical");
        if ObjLoans.FindSet then begin
            VarOutstandingInterest := ObjLoans."Interest Due" - (ObjLoans."Interest Paid" + ObjLoans."Interest Paid Historical");
            //MESSAGE('Interest Due is %1,Loan No %2',ObjLoans."Interest Due",ObjLoans."Loan  No.");
            if VarOutstandingInterest < 0 then
                VarOutstandingInterest := 0;
            exit(VarOutstandingInterest);
        end;
    end;


    procedure FnGetMemberUnsecuredLoanAmount(VarMemberNo: Code[30]) VarTotalUnsecuredLoans: Decimal
    var
        ObjSecurities: Record "Loan Collateral Details";
        VarTotalCollateralValue: Decimal;
        VarTotalLoansnotSecuredbyCollateral: Decimal;
    begin
        VarTotalCollateralValue := 0;

        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
        //Get Member Collateral Value===========================================
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Client Code", VarMemberNo);
        ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
        if ObjLoans.FindSet then begin
            repeat
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                ObjSecurities.Reset;
                ObjSecurities.SetRange(ObjSecurities."Loan No", ObjLoans."Loan  No.");
                ObjSecurities.SetFilter(ObjSecurities."Guarantee Value", '<%1', ObjLoans."Outstanding Balance");
                if ObjSecurities.FindSet then begin
                    VarTotalCollateralValue := VarTotalCollateralValue + (ObjLoans."Outstanding Balance" - ObjSecurities."Guarantee Value");
                end;
            until ObjLoans.Next = 0;
        end;
        //End Get Member Collateral Value=======================================

        VarTotalLoansnotSecuredbyCollateral := 0;
        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
        //Get Loans not Secured by Collateral===========================================
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Client Code", VarMemberNo);
        ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
        if ObjLoans.FindSet then begin
            repeat
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                ObjSecurities.Reset;
                ObjSecurities.SetRange(ObjSecurities."Loan No", ObjLoans."Loan  No.");
                if ObjSecurities.Find('-') = false then begin
                    VarTotalLoansnotSecuredbyCollateral := VarTotalLoansnotSecuredbyCollateral + ObjLoans."Outstanding Balance";
                end;
            until ObjLoans.Next = 0;
        end;
        //End Get Loans not Secured by Collateral=======================================

        VarTotalUnsecuredLoans := VarTotalCollateralValue + VarTotalLoansnotSecuredbyCollateral;
        exit(VarTotalUnsecuredLoans);
    end;


    procedure FnRunGetLoanPayoffAmount(VarLoanNo: Code[30]) VarLoanPayoffAmount: Decimal
    var
        ObjLoans: Record "Loans Register";
        VarInsurancePayoff: Decimal;
        ObjProductCharge: Record "Loan Product Charges";
        VarEndYear: Date;
        VarInsuranceMonths: Integer;
        VarAmountinArrears: Decimal;
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        VarOutstandingInterest: Decimal;
        ObjLoanSchedule: Record "Loan Repayment Schedule";
        VarLoanInsuranceCharged: Decimal;
        VarLoanInsurancePaid: Decimal;
        VarOutstandingInsurance: Decimal;
        VarOutstandingPenalty: Decimal;
        VarTotalInterestPaid: Decimal;
        VarTotalPenaltyPaid: Decimal;
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        if ObjLoans.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Loan Insurance Paid", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Interest Due",
            ObjLoans."Interest Paid");





            //============================================================Loan Insurance Repayment
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
            if ObjLoans.Find('-') then begin

                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
                if ObjLoans.FindSet then begin
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Loan Insurance Paid", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Interest Due",
                    ObjLoans."Interest Paid", ObjLoans."Penalty Paid Historical", ObjLoans."Interest Paid Historical");

                    if ObjLoans."Outstanding Balance" <> 0 then begin
                        VarEndYear := CalcDate('CY', Today);
                        VarInsuranceMonths := ROUND((VarEndYear - Today) / 30, 1, '=');

                        ObjProductCharge.Reset;
                        ObjProductCharge.SetRange(ObjProductCharge."Product Code", ObjLoans."Loan Product Type");
                        ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                        if ObjProductCharge.FindSet then begin
                            VarInsurancePayoff := ROUND((ObjLoans."Approved Amount" * (ObjProductCharge.Percentage / 100)) * VarInsuranceMonths, 0.05, '>');
                        end;
                    end;
                end;

                FnGetLoanArrearsAmountII(VarLoanNo);//===========================Get Amount In Arrears

                ObjLoanSchedule.Reset;
                ObjLoanSchedule.SetRange(ObjLoanSchedule."Loan No.", VarLoanNo);
                ObjLoanSchedule.SetFilter(ObjLoanSchedule."Repayment Date", '<=%1', WorkDate);
                if ObjLoanSchedule.FindSet then begin
                    repeat
                        VarLoanInsuranceCharged := VarLoanInsuranceCharged + ObjLoanSchedule."Monthly Insurance";
                        VarLoanInsurancePaid := VarLoanInsurancePaid + ObjLoanSchedule."Insurance Paid";
                    until ObjLoanSchedule.Next = 0;
                end;

                VarOutstandingInsurance := VarLoanInsuranceCharged - VarLoanInsurancePaid;



                VarOutstandingInterest := ObjLoans."Interest Due" - (ObjLoans."Interest Paid" + ObjLoans."Interest Paid Historical");
                if VarOutstandingInterest < 0 then begin
                    VarOutstandingInterest := 0;
                end;

                VarOutstandingPenalty := ObjLoans."Penalty Charged" - (ObjLoans."Penalty Paid" + ObjLoans."Penalty Paid Historical");
                if VarOutstandingPenalty < 0 then begin
                    VarOutstandingPenalty := 0;
                end;

                VarTotalInterestPaid := ObjLoans."Interest Paid" + ObjLoans."Interest Paid Historical";
                VarTotalPenaltyPaid := ObjLoans."Penalty Paid" + ObjLoans."Penalty Paid Historical";
                if ObjLoans.Get(VarLoanNo) then begin
                    ObjLoans."Outstanding Penalty" := VarOutstandingPenalty;
                    ObjLoans."Outstanding Insurance" := VarOutstandingInsurance;
                    ObjLoans."Loan Insurance Charged" := VarLoanInsuranceCharged;
                    ObjLoans."Total Insurance Paid" := VarLoanInsurancePaid;
                    ObjLoans."Total Penalty Paid" := VarTotalPenaltyPaid;
                    ObjLoans."Outstanding Interest" := VarOutstandingInterest;
                    ObjLoans."Total Interest Paid" := VarTotalInterestPaid;
                    ObjLoans.Modify;
                end;
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                VarLoanPayoffAmount := ObjLoans."Outstanding Balance" + VarOutstandingInterest + VarOutstandingPenalty + (VarOutstandingInsurance + VarInsurancePayoff);
                exit(VarLoanPayoffAmount);

            end;
        end;

    end;

    procedure FnRunGetLoanPayoffinterest(VarLoanNo: Code[30]) VarLoanPayoffAmount: Decimal
    var
        ObjLoans: Record "Loans Register";
        VarInsurancePayoff: Decimal;
        ObjProductCharge: Record "Loan Product Charges";
        VarEndYear: Date;
        VarInsuranceMonths: Integer;
        VarAmountinArrears: Decimal;
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        VarOutstandingInterest: Decimal;
        ObjLoanSchedule: Record "Loan Repayment Schedule";
        VarLoanInsuranceCharged: Decimal;
        VarLoanInsurancePaid: Decimal;
        VarOutstandingInsurance: Decimal;
        VarOutstandingPenalty: Decimal;
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        if ObjLoans.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Interest");
            VarLoanPayoffAmount := ObjLoans."Outstanding Interest";
        end;
    end;

    procedure FnRunGetLoanPayoffRecoveryAmount(VarLoanNo: Code[30]) VarLoanPayoffAmount: Decimal
    var
        ObjLoans: Record "Loans Register";
        VarInsurancePayoff: Decimal;
        ObjProductCharge: Record "Loan Product Charges";
        VarEndYear: Date;
        VarInsuranceMonths: Integer;
        VarAmountinArrears: Decimal;
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        VarOutstandingInterest: Decimal;
        ObjLoanSchedule: Record "Loan Repayment Schedule";
        VarLoanInsuranceCharged: Decimal;
        VarLoanInsurancePaid: Decimal;
        VarOutstandingInsurance: Decimal;
        VarOutstandingPenalty: Decimal;
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        if ObjLoans.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Loan Insurance Paid", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Interest Due",
            ObjLoans."Interest Paid", ObjLoans."Interest Paid Historical", ObjLoans."Penalty Paid Historical");


            //============================================================Loan Insurance Repayment
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
            if ObjLoans.Find('-') then begin

                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
                if ObjLoans.FindSet then begin
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Loan Insurance Paid", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Interest Due",
                    ObjLoans."Interest Paid", ObjLoans."Interest Paid Historical", ObjLoans."Penalty Paid Historical");

                    if ObjLoans."Outstanding Balance" <> 0 then begin
                        VarEndYear := CalcDate('CY', Today);
                        VarInsuranceMonths := ROUND((VarEndYear - Today) / 30, 1, '=');

                        ObjProductCharge.Reset;
                        ObjProductCharge.SetRange(ObjProductCharge."Product Code", ObjLoans."Loan Product Type");
                        ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                        if ObjProductCharge.FindSet then begin
                            VarInsurancePayoff := ROUND((ObjLoans."Approved Amount" * (ObjProductCharge.Percentage / 100)) * VarInsuranceMonths, 0.05, '>');
                        end;
                    end;
                end;

                // FnGetLoanArrearsAmountII(VarLoanNo);//===========================Get Amount In Arrears

                ObjLoanSchedule.Reset;
                ObjLoanSchedule.SetRange(ObjLoanSchedule."Loan No.", VarLoanNo);
                ObjLoanSchedule.SetFilter(ObjLoanSchedule."Repayment Date", '<=%1', WorkDate);
                if ObjLoanSchedule.FindSet then begin
                    repeat
                        VarLoanInsuranceCharged := VarLoanInsuranceCharged + ObjLoanSchedule."Monthly Insurance";
                        VarLoanInsurancePaid := VarLoanInsurancePaid + ObjLoanSchedule."Insurance Paid";
                    until ObjLoanSchedule.Next = 0;
                end;

                VarOutstandingInsurance := VarLoanInsuranceCharged - VarLoanInsurancePaid;



                VarOutstandingInterest := ObjLoans."Interest Due" - (ObjLoans."Interest Paid" + ObjLoans."Interest Paid Historical");
                if VarOutstandingInterest < 0 then begin
                    VarOutstandingInterest := 0;
                end;

                VarOutstandingPenalty := ObjLoans."Penalty Charged" - (ObjLoans."Penalty Paid" + ObjLoans."Penalty Paid Historical");
                if VarOutstandingPenalty < 0 then begin
                    VarOutstandingPenalty := 0;
                end;

                if ObjLoans.Get(VarLoanNo) then begin
                    ObjLoans."Outstanding Penalty" := VarOutstandingPenalty;
                    ObjLoans."Outstanding Insurance" := VarOutstandingInsurance;
                    ObjLoans."Loan Insurance Charged" := VarLoanInsuranceCharged;
                    ObjLoans."Loan Insurance Paid" := VarLoanInsurancePaid;
                    ObjLoans.Modify;
                end;
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                VarLoanPayoffAmount := ObjLoans."Outstanding Balance" + VarOutstandingInterest + VarOutstandingPenalty + (VarOutstandingInsurance);
                exit(VarLoanPayoffAmount);

            end;
        end;
    end;


    procedure FnCreateLoanPayOffJournals(VarLoanNoRecovered: Code[30]; BATCH_TEMPLATE: Code[20]; BATCH_NAME: Code[20]; DOCUMENT_NO: Code[20]; VarMemberNo: Code[20]; VarPostingDate: Date; EXTERNAL_DOC_NO: Code[30]; VarLoanSettlementAcc: Code[30]; VarMemberName: Text[100]; RunningBalance: Decimal)
    var
        ObjLoans: Record "Loans Register";
        AmountToDeduct: Decimal;
        LineNo: Integer;
        SFactory: Codeunit "Micropoint Factory";
        VarAmounttoDeduct: Decimal;
        VarOutstandingInterest: Decimal;
        VarEndYear: Date;
        VarInsuranceMonths: Integer;
        ObjProductCharge: Record "Loan Product Charges";
        VarInsurancePayoff: Decimal;
        VarOutstandingInsurance: Decimal;
        VarLoanInsuranceBalAccount: Code[30];
        ObjLoanType: Record "Loan Products Setup";
        ObjLoanSchedule: Record "Loan Repayment Schedule";
        VarLoanInsuranceCharged: Decimal;
        VarLoanInsurancePaid: Decimal;
        VarTotalOutstandingInsurance: Decimal;
        VarLoanInterestDueBalAccount: Code[30];
        VarOutstandingPenalty: Decimal;
        VarLoanPenaltyBalAccount: Code[30];
        VarLoanDueAmount: Decimal;
        VarDebtCollectorBaseAmount: Decimal;
        VarDebtCollectorFee: Decimal;
    begin
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;


        //============================================================Debt Collector Fee
        if RunningBalance > 0 then begin
            if ObjLoans.Get(VarLoanNoRecovered) then begin
                VarDebtCollectorFee := SFactory.FnRunGetLoanDebtCollectorFeePayoff(VarLoanNoRecovered, RunningBalance);

                if RunningBalance > VarDebtCollectorFee then begin
                    AmountToDeduct := VarDebtCollectorFee
                end else
                    AmountToDeduct := RunningBalance;

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Customer, ObjLoans."Loan Debt Collector", VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                'Debt Collection Charge + VAT from ' + VarLoanNoRecovered + ObjLoans."Client Name", VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Customer, VarLoanSettlementAcc, VarPostingDate, AmountToDeduct, 'BOSA', EXTERNAL_DOC_NO,
                'Debt Collection Charge + VAT from ' + VarLoanNoRecovered + ObjLoans."Client Name", VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);
                RunningBalance := RunningBalance - AmountToDeduct;

            end;
        end;




        //============================================================Loan Penalty Repayment
        if RunningBalance > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            if ObjLoans.Find('-') then begin
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Loan Insurance Paid", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid",
                ObjLoans."Interest Paid Historical", ObjLoans."Penalty Paid Historical");
                if RunningBalance > 0 then begin
                    AmountToDeduct := 0;

                    VarOutstandingPenalty := ObjLoans."Penalty Charged" - (ObjLoans."Penalty Paid" + ObjLoans."Penalty Paid Historical");
                    if VarOutstandingPenalty < 0 then
                        VarOutstandingPenalty := 0;

                    if VarOutstandingPenalty > 0 then begin
                        if VarOutstandingPenalty < RunningBalance then begin
                            AmountToDeduct := VarOutstandingPenalty
                        end else
                            AmountToDeduct := RunningBalance;


                        if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                            VarLoanPenaltyBalAccount := ObjLoanType."Penalty Charged Account";
                        end;



                        //------------------------------------Debit Loan Penalty Charged---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Penalty Charged",
                        GenJournalLine."account type"::Customer, ObjLoans."Client Code", WorkDate, 'PayOff:Penalty Charged:_' + DOCUMENT_NO, GenJournalLine."bal. account type"::"G/L Account",
                        VarLoanPenaltyBalAccount, AmountToDeduct, 'BOSA', VarLoanNoRecovered);
                        //--------------------------------Debit Loan Penalty Charged-------------------------------------------------------------------------------

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Penalty Paid",
                        GenJournalLine."account type"::Customer, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'PayOff:Penalty Paid', VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);

                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                    end;
                end;
            end;
        end;

        //============================================================Loan Interest Repayment
        if RunningBalance > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            if ObjLoans.Find('-') then begin
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Interest Due", ObjLoans."Interest Paid", ObjLoans."Loan Insurance Paid",
              ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Interest Paid Historical", ObjLoans."Penalty Paid Historical");
                if RunningBalance > 0 then begin
                    VarOutstandingInterest := ObjLoans."Interest Due" - (ObjLoans."Interest Paid" + ObjLoans."Interest Paid Historical");
                    if VarOutstandingInterest < 0 then
                        VarOutstandingInterest := 0;

                    AmountToDeduct := 0;
                    if VarOutstandingInterest > 0 then begin
                        if VarOutstandingInterest < RunningBalance then begin
                            AmountToDeduct := VarOutstandingInterest
                        end else
                            AmountToDeduct := RunningBalance;



                        if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                            VarLoanInterestDueBalAccount := ObjLoanType."Receivable Interest Account";
                        end;

                        //------------------------------------Debit Loan Interest Due---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Due",
                        GenJournalLine."account type"::Customer, ObjLoans."Client Code", WorkDate, 'PayOff:Interest Charged:_' + DOCUMENT_NO, GenJournalLine."bal. account type"::"G/L Account",
                        VarLoanInterestDueBalAccount, AmountToDeduct, 'BOSA', VarLoanNoRecovered);
                        //--------------------------------Debit Loan Interest Due-------------------------------------------------------------------------------

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                        GenJournalLine."account type"::Customer, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'PayOff:Interest Paid', VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);

                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                    end;
                end;
            end;
        end;

        //============================================================Loan Insurance Repayment
        if RunningBalance > 0 then begin

            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            if ObjLoans.Find('-') then begin

                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
                if ObjLoans.FindSet then begin
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Loan Insurance Paid", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Interest Due",
                    ObjLoans."Interest Paid");

                    if ObjLoans."Outstanding Balance" <> 0 then begin
                        VarEndYear := CalcDate('CY', Today);
                        VarInsuranceMonths := ROUND((VarEndYear - Today) / 30, 1, '=');

                        ObjProductCharge.Reset;
                        ObjProductCharge.SetRange(ObjProductCharge."Product Code", ObjLoans."Loan Product Type");
                        ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                        if ObjProductCharge.FindSet then begin
                            VarInsurancePayoff := ROUND((ObjLoans."Approved Amount" * (ObjProductCharge.Percentage / 100)) * VarInsuranceMonths, 0.05, '>');
                        end;
                    end;
                end;

                FnGetLoanArrearsAmountII(VarLoanNoRecovered);//===========================Get Amount In Arrears

                ObjLoanSchedule.Reset;
                ObjLoanSchedule.SetRange(ObjLoanSchedule."Loan No.", VarLoanNoRecovered);
                ObjLoanSchedule.SetFilter(ObjLoanSchedule."Repayment Date", '<=%1', WorkDate);
                if ObjLoanSchedule.FindSet then begin
                    repeat
                        VarLoanInsuranceCharged := VarLoanInsuranceCharged + ObjLoanSchedule."Monthly Insurance";
                        VarLoanInsurancePaid := VarLoanInsurancePaid + ObjLoanSchedule."Insurance Paid";
                    until ObjLoanSchedule.Next = 0;
                end;

                VarOutstandingInsurance := VarLoanInsuranceCharged - VarLoanInsurancePaid;

                if RunningBalance > 0 then begin
                    AmountToDeduct := 0;

                    VarTotalOutstandingInsurance := VarOutstandingInsurance + VarInsurancePayoff;

                    if VarTotalOutstandingInsurance > 0 then begin
                        if VarTotalOutstandingInsurance < RunningBalance then begin
                            AmountToDeduct := VarTotalOutstandingInsurance
                        end else
                            AmountToDeduct := RunningBalance;

                        if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                            VarLoanInsuranceBalAccount := ObjLoanType."Receivable Insurance Accounts";
                        end;

                        //------------------------------------Debit Loan Insurance Due---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Charged",
                        GenJournalLine."account type"::Customer, ObjLoans."Client Code", WorkDate, 'PayOff:Insurance Charged:_' + DOCUMENT_NO, GenJournalLine."bal. account type"::"G/L Account",
                        VarLoanInsuranceBalAccount, AmountToDeduct, 'BOSA', VarLoanNoRecovered);
                        //--------------------------------Debit Loan Insurance Due-------------------------------------------------------------------------------

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Paid",
                        GenJournalLine."account type"::Customer, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'PayOff:Insurance Paid', VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);

                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                    end;
                end;
            end;
        end;




        //============================================================Loan Principle Repayment
        if RunningBalance > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            if ObjLoans.Find('-') then begin
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid");
                if RunningBalance > 0 then begin
                    AmountToDeduct := 0;
                    if ObjLoans."Outstanding Balance" > 0 then begin
                        if ObjLoans."Outstanding Balance" < RunningBalance then begin
                            AmountToDeduct := ObjLoans."Outstanding Balance"
                        end else
                            AmountToDeduct := RunningBalance;

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                        GenJournalLine."account type"::Customer, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'PayOff:Principle Recovery', VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);
                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                    end;
                end;
            end;
        end;

        //==============================================================================================Recover From Loan Settlement Account
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, VarLoanSettlementAcc, VarPostingDate, VarAmounttoDeduct, 'BOSA', EXTERNAL_DOC_NO,
        'Loan Payoff Recovery' + '-' + VarMemberNo + '-' + VarMemberName, '', GenJournalLine."application source"::" ");
        //==============================================================================================End Recover From Loan Settlement Account
    end;


    procedure FnGetDailyInterestAccrualOD(VarAccountNo: Code[30])
    var
        ObjAccounts: Record Vendor;
        ObjDailyAccrual: Record "Daily Interest/Penalty Buffer";
        VarInterestCharged: Decimal;
        ObjAccountTypes: Record "Account Types-Saving Products";
        VarEntryNo: Integer;
    begin
        ObjAccounts.CalcFields(ObjAccounts.Balance);
        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."No.", VarAccountNo);
        ObjAccounts.SetFilter(ObjAccounts.Balance, '<%1', 0);
        if ObjAccounts.FindSet then begin
            ObjAccounts.CalcFields(ObjAccounts.Balance);
            if ObjAccountTypes.Get(ObjAccounts."Account Type") then begin
                VarInterestCharged := (ObjAccountTypes."Over Draft Interest Rate" / 36000) * ObjAccounts.Balance;

                ObjDailyAccrual.Reset;
                ObjDailyAccrual.SetCurrentkey(ObjDailyAccrual."Entry No.");
                if ObjDailyAccrual.FindLast then begin
                    VarEntryNo := ObjDailyAccrual."Entry No."
                end else
                    VarEntryNo := 0;

                ObjDailyAccrual.Init;
                ObjDailyAccrual."Entry No." := VarEntryNo + 1;
                ObjDailyAccrual."Account Type" := ObjDailyAccrual."account type"::"FOSA Account";
                ObjDailyAccrual."Account No." := VarAccountNo;
                ObjDailyAccrual."Member Name" := ObjAccounts.Name;
                ObjDailyAccrual."Posting Date" := WorkDate;
                ObjDailyAccrual."Document No." := Format(WorkDate) + ':INT';
                ObjDailyAccrual.Description := 'Interest Accrual For ' + Format(WorkDate);
                ObjDailyAccrual."Base Amount" := ObjAccounts.Balance;
                ObjDailyAccrual.Amount := VarInterestCharged;
                ObjDailyAccrual."Global Dimension 1 Code" := 'FOSA';
                ObjDailyAccrual."Global Dimension 1 Code" := FnGetMemberBranch(ObjAccounts."BOSA Account No");
                ObjDailyAccrual."User ID" := UserId;
                ObjDailyAccrual."Transaction Type" := ObjDailyAccrual."transaction type"::"Interest Accrual";
                ObjDailyAccrual."Loan No" := '';
                if VarInterestCharged <> 0 then
                    ObjDailyAccrual.Insert;

            end;
        end;
    end;


    procedure FnGetDailyPenaltyChargedOnLoans(VarLoanNo: Code[30])
    var
        ObjLoans: Record "Loans Register";
        ObjDailyAccrual: Record "Daily Interest/Penalty Buffer";
        VarPenaltyCharged: Decimal;
        ObjLoanType: Record "Loan Products Setup";
        VarEntryNo: Integer;
        VarPenaltyGraceDays: DateFormula;
        ObjLoanSchedule: Record "Loan Repayment Schedule";
        VarOutstandingPenalty: Decimal;
        VarLastPrincipleRepaymentDate: Date;
        VarLastInterestPaymentDate: Date;
        VarLastInsurancePaymentDate: Date;
        VarScheduleFilter: Text;
        VarDateAftertheGraceDays: Date;
        VarPrincipleCharged: Decimal;
        VarPrinciplePaid: Decimal;
        VarInterestCharged: Decimal;
        VarInterestPaid: Decimal;
        VarInsuranceCharged: Decimal;
        VarInsurancePaid: Decimal;
        VarPrincipleArrears: Decimal;
        VarInterestArrears: Decimal;
        VarPenaltyOnPrincipleinArrears: Decimal;
        VarPenaltyOnInterestinArrears: Decimal;
        ObjLoanRepaymentschedule: Record "Loan Repayment Schedule";
        VarLastInstalmentDueDate: Date;
        ObjLoanInterestAccrued: Record "Interest Due Ledger Entry";
        VarTotalInterestAccrued: Decimal;
        VarAmountinArrearsInterest: Decimal;
        VarTotalArrears: Decimal;
    begin
        VarPenaltyCharged := 0;

        ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Paid", ObjLoans."Penalty Charged");

        //=======================================================================Get Outstanding Penalty Amount
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        if ObjLoans.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Paid", ObjLoans."Penalty Charged",
            ObjLoans."Interest Paid Historical", ObjLoans."Penalty Paid Historical");
            VarOutstandingPenalty := ObjLoans."Penalty Charged" - (ObjLoans."Penalty Paid" + ObjLoans."Penalty Paid Historical");
            VarInterestPaid := ObjLoans."Interest Paid" + ObjLoans."Interest Paid Historical";
            if VarOutstandingPenalty < 0 then
                VarOutstandingPenalty := 0;
        end;
        //=======================================================================End Get Outstanding Penalty Amount

        FnGetLoanArrearsAmountII(VarLoanNo);//===================================Update Schedule With Repayments

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        ObjLoans.SetRange(ObjLoans."Except From Penalty", false);
        ObjLoans.SetFilter(ObjLoans."Approved Amount", '>%1', ObjLoans."Penalty Charged");
        ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
        if ObjLoans.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
            if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin

                //======================================================================Get Principle In Arrears
                ObjLoanSchedule.Reset;
                ObjLoanSchedule.SetCurrentkey(ObjLoanSchedule."Repayment Date");
                ObjLoanSchedule.SetRange(ObjLoanSchedule."Loan No.", VarLoanNo);
                ObjLoanSchedule.SetFilter(ObjLoanSchedule."Principal Repayment", '<>%1', ObjLoanSchedule."Principle Amount Paid");
                if ObjLoanSchedule.FindFirst then begin
                    VarLastPrincipleRepaymentDate := ObjLoanSchedule."Repayment Date";
                end;

                if VarLastPrincipleRepaymentDate <> 0D then begin
                    VarPrincipleCharged := 0;
                    VarPrinciplePaid := 0;
                    VarPrincipleArrears := 0;
                    VarDateAftertheGraceDays := CalcDate(ObjLoanType."Penalty Calculation Days", VarLastPrincipleRepaymentDate);

                    ObjLoanSchedule.Reset;
                    ObjLoanSchedule.SetRange(ObjLoanSchedule."Loan No.", VarLoanNo);
                    ObjLoanSchedule.SetFilter(ObjLoanSchedule."Repayment Date", '<%1', WorkDate);
                    if ObjLoanSchedule.FindSet then begin
                        if VarDateAftertheGraceDays < WorkDate then begin
                            repeat
                                VarPrincipleCharged := VarPrincipleCharged + ObjLoanSchedule."Principal Repayment";
                                VarPrinciplePaid := VarPrinciplePaid + ObjLoanSchedule."Principle Amount Paid";
                            until ObjLoanSchedule.Next = 0;
                        end;
                        VarPrincipleArrears := VarPrincipleCharged - VarPrinciplePaid;

                    end;
                end;
                //======================================================================End Get Principle In Arrears



                //====================================================Get Loan Interest In Arrears
                ObjLoanRepaymentschedule.Reset;
                ObjLoanRepaymentschedule.SetCurrentkey(ObjLoanRepaymentschedule."Repayment Date");
                ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
                ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Repayment Date", '<%1', WorkDate);
                if ObjLoanRepaymentschedule.FindLast then begin
                    VarLastInstalmentDueDate := ObjLoanRepaymentschedule."Repayment Date";
                end;

                ObjLoanInterestAccrued.Reset;
                ObjLoanInterestAccrued.SetRange(ObjLoanInterestAccrued."Loan No", VarLoanNo);
                ObjLoanInterestAccrued.SetFilter(ObjLoanInterestAccrued."Posting Date", '<=%1', VarLastInstalmentDueDate);
                if ObjLoanInterestAccrued.FindSet then begin
                    repeat
                        VarTotalInterestAccrued := VarTotalInterestAccrued + ObjLoanInterestAccrued.Amount;
                    until ObjLoanInterestAccrued.Next = 0;
                end;

                VarAmountinArrearsInterest := VarTotalInterestAccrued - VarInterestPaid;
                if VarAmountinArrearsInterest < 0 then
                    VarAmountinArrearsInterest := 0;
                //====================================================Get Loan Interest In Arrears


                if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                    if ObjLoanType."Penalty Calculation Method" = ObjLoanType."penalty calculation method"::"Principal in Arrears" then begin
                        VarTotalArrears := VarPrincipleArrears;
                    end;

                    if ObjLoanType."Penalty Calculation Method" = ObjLoanType."penalty calculation method"::"Principal in Arrears+Interest in Arrears" then begin
                        VarTotalArrears := VarPrincipleArrears + VarAmountinArrearsInterest;
                    end;
                    VarPenaltyCharged := (ObjLoanType."Penalty Percentage" / 36000) * VarTotalArrears;
                end;

            end;
        end;


        ObjDailyAccrual.Reset;
        ObjDailyAccrual.SetCurrentkey(ObjDailyAccrual."Entry No.");
        if ObjDailyAccrual.FindLast then begin
            VarEntryNo := ObjDailyAccrual."Entry No."
        end else
            VarEntryNo := 0;

        ObjDailyAccrual.Init;
        ObjDailyAccrual."Entry No." := VarEntryNo + 1;
        ObjDailyAccrual."Account Type" := ObjDailyAccrual."account type"::"BOSA Account";
        ObjDailyAccrual."Account No." := ObjLoans."Client Code";
        ObjDailyAccrual."Member Name" := ObjLoans."Client Name";
        ObjDailyAccrual."Posting Date" := WorkDate;
        ObjDailyAccrual."Document No." := Format(WorkDate) + ':Pen';
        ObjDailyAccrual.Description := 'Penaly Charged On ' + Format(WorkDate);
        ObjDailyAccrual."Base Amount" := VarTotalArrears;
        ObjDailyAccrual.Amount := VarPenaltyCharged;
        ObjDailyAccrual."Global Dimension 1 Code" := 'BOSA';
        ObjDailyAccrual."Global Dimension 1 Code" := FnGetMemberBranch(ObjLoans."Client Code");
        ObjDailyAccrual."User ID" := UserId;
        ObjDailyAccrual."Transaction Type" := ObjDailyAccrual."transaction type"::"Penalty Charged";
        ObjDailyAccrual."Loan No" := ObjLoans."Loan  No.";
        if VarPenaltyCharged <> 0 then
            ObjDailyAccrual.Insert;
    end;


    procedure FnGetCoreCapital()
    var
        ShareCapitalAmount: Decimal;
        GLEntries: Record "G/L Entry";
        ShareCapitalAcc: Code[50];
        RetainedSurplusAcc: Code[50];
        RetainedSurplusAmount: Decimal;
        CapitalGrantAcc: Code[50];
        CapitalGrantAmount: Decimal;
        StatutoryReserveAcc: Code[50];
        StatutoryReserveAmount: Decimal;
        WithMembersSharesAcc: Code[50];
        WithMembersSharesAmount: Decimal;
        AdditionalSharesAcc: Code[50];
        AdditionalSharesAmount: Decimal;
    begin
    end;


    procedure FnConvertTexttoBeginingWordstostartWithCapital(CurValue: Text[250]) NewValue: Text[250]
    var
        Cap: Boolean;
        Indx: Integer;
    begin
        if (CurValue = '') then exit; //just to save a little extra needless processing in case of empty string

        Cap := true; //Capitalize the first letter of the sentence regardless
        CurValue := Lowercase(CurValue); //convert everything to lowercase "in case" we have rogue uppercase letters

        for Indx := 1 to StrLen(CurValue) do begin
            if (CurValue[Indx] = ' ') then begin
                NewValue += ' '; //by adding a hardcoded space here we avoid having to waste processing on a call to Format()
                Cap := true;
            end else begin
                if Cap then begin
                    NewValue += UpperCase(Format(CurValue[Indx]));
                    Cap := false;
                end else
                    NewValue += Format(CurValue[Indx])
            end;
        end;

        exit(NewValue);
    end;


    procedure FnRunLoanAmountDue(VarLoanNo: Code[20]) VarTotalLoanDueAmount: Decimal
    var
        ObjLoanRepaymentschedule: Record "Loan Repayment Schedule";
        ObjLoans: Record "Loans Register";
        VarPrinciplePaid: Decimal;
        VarAmountRemaining: Decimal;
        VarAmountAllocated: Decimal;
        VarDateFilter: Text;
        VarSchedulePrincipletoDate: Decimal;
        VarActualPrincipletoDate: Decimal;
        VarAmountinArrears: Decimal;
        VarNoofDaysinArrears: Integer;
        VarInterestPaid: Decimal;
        VarInsurancePaid: Decimal;
        VarAmountRemainingInterest: Decimal;
        VarAmountRemainingInsurance: Decimal;
        VarAmountAllocatedInterest: Decimal;
        VarAmountAllocatedInsurance: Decimal;
        VarScheduleInteresttoDate: Decimal;
        VarActualInteresttoDate: Decimal;
        VarScheduleInsurancetoDate: Decimal;
        VarActualInsurancetoDate: Decimal;
        VarAmountinArrearsInterest: Decimal;
        VarAmountinArrearsInsurance: Decimal;
        VarOutstandingPenalty: Decimal;
        VarLastInstalmentDueDate: Date;
        ObjLoanInterestAccrued: Record "Interest Due Ledger Entry";
        VarTotalInterestAccrued: Decimal;
        VarCurrOutstandingInterest: Decimal;
    begin
        VarAmountRemaining := 0;
        VarAmountAllocated := 0;
        //VarAmountRemainingInterest:=0;
        //VarAmountRemainingInsurance:=0;

        //=================================================Initialize amounts Paid on the Schedule
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                ObjLoanRepaymentschedule."Principle Amount Paid" := 0;
                ObjLoanRepaymentschedule."Interest Paid" := 0;
                ObjLoanRepaymentschedule."Insurance Paid" := 0;
                ObjLoanRepaymentschedule.Modify;
            until ObjLoanRepaymentschedule.Next = 0;
        end;
        //=================================================End Initialize amounts Paid on the Schedule

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        if ObjLoans.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Principle Paid to Date", ObjLoans."Loan Insurance Paid", ObjLoans."Interest Paid", ObjLoans."Principle Paid Historical"
            , ObjLoans."Interest Paid Historical", ObjLoans."Insurance Paid Historical", ObjLoans."Penalty Paid Historical");

            VarPrinciplePaid := (ObjLoans."Principle Paid to Date" + ObjLoans."Principle Paid Historical" * -1);
            VarInterestPaid := (ObjLoans."Interest Paid" + ObjLoans."Interest Paid Historical");
            VarInsurancePaid := ((ObjLoans."Loan Insurance Paid" * -1) + ObjLoans."Insurance Paid Historical");
        end;

        VarAmountRemaining := VarPrinciplePaid;
        VarAmountRemainingInterest := VarInterestPaid;
        VarAmountRemainingInsurance := VarInsurancePaid;


        //====================================================Loan Principle
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                if VarAmountRemaining > 0 then begin
                    if VarAmountRemaining >= ObjLoanRepaymentschedule."Principal Repayment" then begin
                        VarAmountAllocated := ObjLoanRepaymentschedule."Principal Repayment"
                    end;

                    if VarAmountRemaining < ObjLoanRepaymentschedule."Principal Repayment" then begin
                        VarAmountAllocated := VarAmountRemaining;
                    end;

                    ObjLoanRepaymentschedule."Principle Amount Paid" := VarAmountAllocated;
                    ObjLoanRepaymentschedule.Modify;
                    VarAmountRemaining := VarAmountRemaining - VarAmountAllocated;
                end;
            until ObjLoanRepaymentschedule.Next = 0;
        end;

        //====================================================Loan Interest
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                if VarAmountRemainingInterest > 0 then begin

                    if VarAmountRemainingInterest >= ObjLoanRepaymentschedule."Monthly Interest" then begin
                        VarAmountAllocatedInterest := ObjLoanRepaymentschedule."Monthly Interest"
                    end;

                    if VarAmountRemainingInterest < ObjLoanRepaymentschedule."Monthly Interest" then begin
                        VarAmountAllocatedInterest := VarAmountRemainingInterest;
                    end;

                    ObjLoanRepaymentschedule."Interest Paid" := VarAmountAllocatedInterest;
                    ObjLoanRepaymentschedule.Modify;
                    VarAmountRemainingInterest := VarAmountRemainingInterest - VarAmountAllocatedInterest;
                end;
            until ObjLoanRepaymentschedule.Next = 0;
        end;




        //====================================================Loan Insurance
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                if VarAmountRemainingInsurance > 0 then begin
                    if VarAmountRemainingInsurance >= ObjLoanRepaymentschedule."Monthly Insurance" then begin
                        VarAmountAllocatedInsurance := ObjLoanRepaymentschedule."Monthly Insurance"
                    end;

                    if VarAmountRemainingInsurance < ObjLoanRepaymentschedule."Monthly Insurance" then begin
                        VarAmountAllocatedInsurance := VarAmountRemainingInsurance;
                    end;

                    ObjLoanRepaymentschedule."Insurance Paid" := VarAmountAllocatedInsurance;
                    ObjLoanRepaymentschedule.Modify;
                    VarAmountRemainingInsurance := VarAmountRemainingInsurance - VarAmountAllocatedInsurance;
                end;
            until ObjLoanRepaymentschedule.Next = 0;
        end;

        VarDateFilter := '..' + Format(WorkDate);

        //===================================================Scheduled Repayment to Date
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Repayment Date", '<=%1', WorkDate);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                VarSchedulePrincipletoDate := VarSchedulePrincipletoDate + ObjLoanRepaymentschedule."Principal Repayment";
                VarScheduleInteresttoDate := VarScheduleInteresttoDate + ObjLoanRepaymentschedule."Monthly Interest";
                VarScheduleInsurancetoDate := VarScheduleInsurancetoDate + ObjLoanRepaymentschedule."Monthly Insurance";
            until ObjLoanRepaymentschedule.Next = 0;
        end;

        //===================================================Actual Repayment to Date
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Principle Amount Paid", '<>%1', 0);
        if ObjLoanRepaymentschedule.FindSet then begin
            if ObjLoanRepaymentschedule."Repayment Date" < WorkDate then begin
                repeat
                    VarActualPrincipletoDate := VarActualPrincipletoDate + ObjLoanRepaymentschedule."Principle Amount Paid";
                    VarActualInteresttoDate := VarActualInteresttoDate + ObjLoanRepaymentschedule."Interest Paid";
                    VarActualInsurancetoDate := VarActualInsurancetoDate + ObjLoanRepaymentschedule."Insurance Paid";
                until ObjLoanRepaymentschedule.Next = 0;
            end;
        end;


        //====================================================Get Loan Interest In Arrears
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetCurrentkey(ObjLoanRepaymentschedule."Repayment Date");
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Repayment Date", '<=%1', WorkDate);
        if ObjLoanRepaymentschedule.FindLast then begin
            VarLastInstalmentDueDate := ObjLoanRepaymentschedule."Repayment Date";
        end;

        ObjLoanInterestAccrued.Reset;
        ObjLoanInterestAccrued.SetRange(ObjLoanInterestAccrued."Loan No", VarLoanNo);
        ObjLoanInterestAccrued.SetFilter(ObjLoanInterestAccrued."Posting Date", '<=%1', VarLastInstalmentDueDate);
        if ObjLoanInterestAccrued.FindSet then begin
            repeat
                VarTotalInterestAccrued := VarTotalInterestAccrued + ObjLoanInterestAccrued.Amount;
            until ObjLoanInterestAccrued.Next = 0;

        end;

        VarAmountinArrearsInterest := VarTotalInterestAccrued - VarInterestPaid;
        if VarAmountinArrearsInterest < 0 then
            VarAmountinArrearsInterest := 0;
        //====================================================Get Loan Interest In Arrears


        VarAmountinArrears := 0;

        //=================================Loan Principle
        if ObjLoans.Get(VarLoanNo) then begin
            ObjLoans.CalcFields(ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Outstanding Balance");
            if ObjLoans."Outstanding Balance" > 0 then begin

                VarAmountinArrears := VarSchedulePrincipletoDate - VarActualPrincipletoDate;
                VarAmountinArrearsInsurance := VarScheduleInsurancetoDate - VarActualInsurancetoDate;

                if VarAmountinArrears < 0 then begin
                    VarAmountinArrears := 0
                end;
            end;
        end;
        //=================================Loan Interest
        if VarAmountinArrearsInterest < 0 then begin
            VarAmountinArrearsInterest := 0
        end else
            VarAmountinArrearsInterest := VarAmountinArrearsInterest;

        //=================================Loan Insurance
        if VarAmountinArrearsInsurance < 0 then begin
            VarAmountinArrearsInsurance := 0
        end else
            VarAmountinArrearsInsurance := VarAmountinArrearsInsurance;



        if ObjLoans.Get(VarLoanNo) then begin
            ObjLoans.CalcFields(ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Interest Due", ObjLoans."Interest Paid",
            ObjLoans."Penalty Paid Historical", ObjLoans."Interest Paid Historical");
            VarCurrOutstandingInterest := ObjLoans."Interest Due" - (ObjLoans."Interest Paid" + ObjLoans."Interest Paid Historical");
            if VarCurrOutstandingInterest < 0 then
                VarCurrOutstandingInterest := 0;

            VarOutstandingPenalty := ObjLoans."Penalty Charged" - (ObjLoans."Penalty Paid" + ObjLoans."Penalty Paid Historical");
            if VarOutstandingPenalty < 0 then
                VarOutstandingPenalty := 0;

            VarTotalLoanDueAmount := VarAmountinArrears + VarAmountinArrearsInterest + VarAmountinArrearsInsurance + VarOutstandingPenalty;
            ObjLoans."Current Principle Due" := VarAmountinArrears;
            ObjLoans."Current Interest Due" := VarCurrOutstandingInterest;
            ObjLoans."Current Insurance Due" := VarAmountinArrearsInsurance;
            ObjLoans."Current Penalty Due" := VarOutstandingPenalty;
            ObjLoans.Modify;
        end;
        exit(VarTotalLoanDueAmount);
    end;


    procedure FnRunSplitString(Text: Text[250]; Separator: Text[50]) TokenI: Text[100]
    var
        Pos: Integer;
        Token: Text[100];
    begin
        Pos := StrPos(Text, Separator);
        if Pos > 0 then begin
            Token := CopyStr(Text, 1, Pos - 1);
            if Pos + 1 <= StrLen(Text) then
                Text := CopyStr(Text, Pos + 1)
            else
                Text := '';
        end else begin
            Token := Text;
            Text := '';
        end;

        TokenI := Token;
        exit(TokenI);
    end;


    procedure FnRunLoanAmountDuePayroll(VarLoanNo: Code[20]) VarTotalLoanDueAmount: Decimal
    var
        ObjLoanRepaymentschedule: Record "Loan Repayment Schedule";
        ObjLoans: Record "Loans Register";
        VarPrinciplePaid: Decimal;
        VarAmountRemaining: Decimal;
        VarAmountAllocated: Decimal;
        VarDateFilter: Text;
        VarSchedulePrincipletoDate: Decimal;
        VarActualPrincipletoDate: Decimal;
        VarAmountinArrears: Decimal;
        VarNoofDaysinArrears: Integer;
        VarInterestPaid: Decimal;
        VarInsurancePaid: Decimal;
        VarAmountRemainingInterest: Decimal;
        VarAmountRemainingInsurance: Decimal;
        VarAmountAllocatedInterest: Decimal;
        VarAmountAllocatedInsurance: Decimal;
        VarScheduleInteresttoDate: Decimal;
        VarActualInteresttoDate: Decimal;
        VarScheduleInsurancetoDate: Decimal;
        VarActualInsurancetoDate: Decimal;
        VarAmountinArrearsInterest: Decimal;
        VarAmountinArrearsInsurance: Decimal;
        VarOutstandingPenalty: Decimal;
        VarLastInstalmentDueDate: Date;
        ObjLoanInterestAccrued: Record "Interest Due Ledger Entry";
        VarTotalInterestAccrued: Decimal;
        VarEndMonthDate: Date;
    begin
        VarAmountRemaining := 0;
        VarAmountAllocated := 0;
        VarEndMonthDate := CalcDate('CM', WorkDate);

        //=================================================Initialize amounts Paid on the Schedule
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                ObjLoanRepaymentschedule."Principle Amount Paid" := 0;
                ObjLoanRepaymentschedule."Interest Paid" := 0;
                ObjLoanRepaymentschedule."Insurance Paid" := 0;
                ObjLoanRepaymentschedule.Modify;
            until ObjLoanRepaymentschedule.Next = 0;
        end;
        //=================================================End Initialize amounts Paid on the Schedule

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        if ObjLoans.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Principle Paid to Date", ObjLoans."Loan Insurance Paid", ObjLoans."Interest Paid", ObjLoans."Principle Paid Historical",
            ObjLoans."Interest Paid Historical", ObjLoans."Penalty Paid Historical", ObjLoans."Insurance Paid Historical");
            VarPrinciplePaid := ((ObjLoans."Principle Paid to Date" + ObjLoans."Principle Paid Historical") * -1);
            VarInterestPaid := (ObjLoans."Interest Paid" + ObjLoans."Interest Paid Historical");
            VarInsurancePaid := ((ObjLoans."Loan Insurance Paid" * -1) + ObjLoans."Insurance Paid Historical");
        end;

        VarAmountRemaining := VarPrinciplePaid;
        VarAmountRemainingInterest := VarInterestPaid;
        VarAmountRemainingInsurance := VarInsurancePaid;


        //====================================================Loan Principle
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                if VarAmountRemaining > 0 then begin
                    if VarAmountRemaining >= ObjLoanRepaymentschedule."Principal Repayment" then begin
                        VarAmountAllocated := ObjLoanRepaymentschedule."Principal Repayment"
                    end;

                    if VarAmountRemaining < ObjLoanRepaymentschedule."Principal Repayment" then begin
                        VarAmountAllocated := VarAmountRemaining;
                    end;

                    ObjLoanRepaymentschedule."Principle Amount Paid" := VarAmountAllocated;
                    ObjLoanRepaymentschedule.Modify;
                    VarAmountRemaining := VarAmountRemaining - VarAmountAllocated;
                end;
            until ObjLoanRepaymentschedule.Next = 0;
        end;

        //====================================================Loan Interest
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                if VarAmountRemainingInterest > 0 then begin

                    if VarAmountRemainingInterest >= ObjLoanRepaymentschedule."Monthly Interest" then begin
                        VarAmountAllocatedInterest := ObjLoanRepaymentschedule."Monthly Interest"
                    end;

                    if VarAmountRemainingInterest < ObjLoanRepaymentschedule."Monthly Interest" then begin
                        VarAmountAllocatedInterest := VarAmountRemainingInterest;
                    end;

                    ObjLoanRepaymentschedule."Interest Paid" := VarAmountAllocatedInterest;
                    ObjLoanRepaymentschedule.Modify;
                    VarAmountRemainingInterest := VarAmountRemainingInterest - VarAmountAllocatedInterest;
                end;
            until ObjLoanRepaymentschedule.Next = 0;
        end;




        //====================================================Loan Insurance
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                if VarAmountRemainingInsurance > 0 then begin
                    if VarAmountRemainingInsurance >= ObjLoanRepaymentschedule."Monthly Insurance" then begin
                        VarAmountAllocatedInsurance := ObjLoanRepaymentschedule."Monthly Insurance"
                    end;

                    if VarAmountRemainingInsurance < ObjLoanRepaymentschedule."Monthly Insurance" then begin
                        VarAmountAllocatedInsurance := VarAmountRemainingInsurance;
                    end;

                    ObjLoanRepaymentschedule."Insurance Paid" := VarAmountAllocatedInsurance;
                    ObjLoanRepaymentschedule.Modify;
                    VarAmountRemainingInsurance := VarAmountRemainingInsurance - VarAmountAllocatedInsurance;
                end;
            until ObjLoanRepaymentschedule.Next = 0;
        end;

        VarDateFilter := '..' + Format(WorkDate);

        //===================================================Scheduled Repayment to Date
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Repayment Date", '<=%1', VarEndMonthDate);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                VarSchedulePrincipletoDate := VarSchedulePrincipletoDate + ObjLoanRepaymentschedule."Principal Repayment";
                VarScheduleInteresttoDate := VarScheduleInteresttoDate + ObjLoanRepaymentschedule."Monthly Interest";
                VarScheduleInsurancetoDate := VarScheduleInsurancetoDate + ObjLoanRepaymentschedule."Monthly Insurance";
            until ObjLoanRepaymentschedule.Next = 0;
        end;

        //===================================================Actual Repayment to Date
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Principle Amount Paid", '<>%1', 0);
        if ObjLoanRepaymentschedule.FindSet then begin
            if ObjLoanRepaymentschedule."Repayment Date" < VarEndMonthDate then begin
                repeat
                    VarActualPrincipletoDate := VarActualPrincipletoDate + ObjLoanRepaymentschedule."Principle Amount Paid";
                    VarActualInteresttoDate := VarActualInteresttoDate + ObjLoanRepaymentschedule."Interest Paid";
                    VarActualInsurancetoDate := VarActualInsurancetoDate + ObjLoanRepaymentschedule."Insurance Paid";
                until ObjLoanRepaymentschedule.Next = 0;
            end;
        end;
        //====================================================Get Loan Interest In Arrears

        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetCurrentkey(ObjLoanRepaymentschedule."Repayment Date");
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Repayment Date", '<=%1', VarEndMonthDate);
        if ObjLoanRepaymentschedule.FindLast then begin
            VarLastInstalmentDueDate := ObjLoanRepaymentschedule."Repayment Date";
        end;

        ObjLoanInterestAccrued.Reset;
        ObjLoanInterestAccrued.SetRange(ObjLoanInterestAccrued."Loan No", VarLoanNo);
        ObjLoanInterestAccrued.SetFilter(ObjLoanInterestAccrued."Posting Date", '<=%1', VarLastInstalmentDueDate);
        if ObjLoanInterestAccrued.FindSet then begin
            repeat
                VarTotalInterestAccrued := VarTotalInterestAccrued + ObjLoanInterestAccrued.Amount;
            until ObjLoanInterestAccrued.Next = 0;

        end;

        VarAmountinArrearsInterest := VarTotalInterestAccrued - VarInterestPaid;
        if VarAmountinArrearsInterest < 0 then
            VarAmountinArrearsInterest := 0;
        //====================================================Get Loan Interest In Arrears


        VarAmountinArrears := 0;

        //=================================Loan Principle
        if ObjLoans.Get(VarLoanNo) then begin
            ObjLoans.CalcFields(ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Outstanding Balance");
            if ObjLoans."Outstanding Balance" > 0 then begin

                VarAmountinArrears := VarSchedulePrincipletoDate - VarActualPrincipletoDate;
                VarAmountinArrearsInsurance := VarScheduleInsurancetoDate - VarActualInsurancetoDate;

                if VarAmountinArrears < 0 then begin
                    VarAmountinArrears := 0
                end;
            end;
        end;
        //=================================Loan Interest
        if VarAmountinArrearsInterest < 0 then begin
            VarAmountinArrearsInterest := 0
        end else
            VarAmountinArrearsInterest := VarAmountinArrearsInterest;

        //=================================Loan Insurance
        if VarAmountinArrearsInsurance < 0 then begin
            VarAmountinArrearsInsurance := 0
        end else
            VarAmountinArrearsInsurance := VarAmountinArrearsInsurance;



        if ObjLoans.Get(VarLoanNo) then begin
            ObjLoans.CalcFields(ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Penalty Paid Historical");

            VarOutstandingPenalty := ObjLoans."Penalty Charged" - (ObjLoans."Penalty Paid" + ObjLoans."Penalty Paid Historical");
            if VarOutstandingPenalty < 0 then
                VarOutstandingPenalty := 0;

            VarTotalLoanDueAmount := VarAmountinArrears + VarAmountinArrearsInterest + VarAmountinArrearsInsurance + VarOutstandingPenalty;

            ObjLoans."Current Principle Due" := VarAmountinArrears;
            ObjLoans."Current Interest Due" := VarAmountinArrearsInterest;
            ObjLoans."Current Insurance Due" := VarAmountinArrearsInsurance;
            ObjLoans."Current Penalty Due" := VarOutstandingPenalty;
            ObjLoans.Modify;
        end;
        exit(VarTotalLoanDueAmount);
    end;


    procedure FnGetLoanArrearsAmountReport(VarLoanNo: Code[20]; VarReportDate: Date; var VarArrearsAmountOutput: Decimal; var VarArrearsDaysOutput: Integer)
    var
        ObjLoanRepaymentschedule: Record "Loan Repayment Schedule Temp";
        ObjLoans: Record "Loans Register";
        VarPrinciplePaid: Decimal;
        VarAmountRemaining: Decimal;
        VarAmountAllocated: Decimal;
        VarDateFilter: Text;
        VarSchedulePrincipletoDate: Decimal;
        VarActualPrincipletoDate: Decimal;
        VarAmountinArrears: Decimal;
        VarNoofDaysinArrears: Integer;
        VarInterestPaid: Decimal;
        VarInsurancePaid: Decimal;
        VarAmountRemainingInterest: Decimal;
        VarAmountRemainingInsurance: Decimal;
        VarAmountAllocatedInterest: Decimal;
        VarAmountAllocatedInsurance: Decimal;
        VarScheduleInteresttoDate: Decimal;
        VarActualInteresttoDate: Decimal;
        VarScheduleInsurancetoDate: Decimal;
        VarActualInsurancetoDate: Decimal;
        VarAmountinArrearsInterest: Decimal;
        VarAmountinArrearsInsurance: Decimal;
        VarOutstandingPenalty: Decimal;
        VarLastInstalmentDueDate: Date;
        ObjLoanInterestAccrued: Record "Interest Due Ledger Entry";
        VarTotalInterestAccrued: Decimal;
        VarRoundedArrears: Decimal;
    begin
        VarAmountRemaining := 0;
        VarAmountAllocated := 0;
        //VarAmountRemainingInterest:=0;
        //VarAmountRemainingInsurance:=0;

        //=================================================Initialize amounts Paid on the Schedule
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                ObjLoanRepaymentschedule."Principle Amount Paid" := 0;
                ObjLoanRepaymentschedule."Interest Paid" := 0;
                ObjLoanRepaymentschedule."Insurance Paid" := 0;
                ObjLoanRepaymentschedule."Instalment Fully Settled" := false;
                ObjLoanRepaymentschedule.Modify;
            until ObjLoanRepaymentschedule.Next = 0;
        end;
        //=================================================End Initialize amounts Paid on the Schedule

        VarDateFilter := '..' + Format(VarReportDate);
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        if ObjLoans.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Principle Paid to Date", ObjLoans."Loan Insurance Paid", ObjLoans."Interest Paid", ObjLoans."Principle Paid Historical",
            ObjLoans."Interest Paid Historical", ObjLoans."Penalty Paid Historical", ObjLoans."Insurance Paid Historical");
            VarPrinciplePaid := ((ObjLoans."Principle Paid to Date" + ObjLoans."Principle Paid Historical") * -1);
            VarInterestPaid := (ObjLoans."Interest Paid" + ObjLoans."Interest Paid Historical");
            VarInsurancePaid := ((ObjLoans."Loan Insurance Paid" * -1) + ObjLoans."Insurance Paid Historical");
        end;

        VarAmountRemaining := VarPrinciplePaid;
        VarAmountRemainingInterest := VarInterestPaid;
        VarAmountRemainingInsurance := VarInsurancePaid;


        //====================================================Loan Principle
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                if VarAmountRemaining > 0 then begin
                    if VarAmountRemaining >= ObjLoanRepaymentschedule."Principal Repayment" then begin
                        VarAmountAllocated := ObjLoanRepaymentschedule."Principal Repayment";
                        ObjLoanRepaymentschedule."Instalment Fully Settled" := true;
                        ObjLoanRepaymentschedule.Modify;
                    end;

                    if VarAmountRemaining < ObjLoanRepaymentschedule."Principal Repayment" then begin
                        VarAmountAllocated := VarAmountRemaining;
                    end;

                    ObjLoanRepaymentschedule."Principle Amount Paid" := VarAmountAllocated;
                    ObjLoanRepaymentschedule.Modify;
                    VarAmountRemaining := VarAmountRemaining - VarAmountAllocated;
                end;
            until ObjLoanRepaymentschedule.Next = 0;
        end;

        //====================================================Loan Interest
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                if VarAmountRemainingInterest > 0 then begin

                    if VarAmountRemainingInterest >= ObjLoanRepaymentschedule."Monthly Interest" then begin
                        VarAmountAllocatedInterest := ObjLoanRepaymentschedule."Monthly Interest"
                    end;

                    if VarAmountRemainingInterest < ObjLoanRepaymentschedule."Monthly Interest" then begin
                        VarAmountAllocatedInterest := VarAmountRemainingInterest;
                    end;

                    ObjLoanRepaymentschedule."Interest Paid" := VarAmountAllocatedInterest;
                    ObjLoanRepaymentschedule.Modify;
                    VarAmountRemainingInterest := VarAmountRemainingInterest - VarAmountAllocatedInterest;
                end;
            until ObjLoanRepaymentschedule.Next = 0;
        end;




        //====================================================Loan Insurance
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                if VarAmountRemainingInsurance > 0 then begin
                    if VarAmountRemainingInsurance >= ObjLoanRepaymentschedule."Monthly Insurance" then begin
                        VarAmountAllocatedInsurance := ObjLoanRepaymentschedule."Monthly Insurance"
                    end;

                    if VarAmountRemainingInsurance < ObjLoanRepaymentschedule."Monthly Insurance" then begin
                        VarAmountAllocatedInsurance := VarAmountRemainingInsurance;
                    end;

                    ObjLoanRepaymentschedule."Insurance Paid" := VarAmountAllocatedInsurance;
                    ObjLoanRepaymentschedule.Modify;
                    VarAmountRemainingInsurance := VarAmountRemainingInsurance - VarAmountAllocatedInsurance;
                end;
            until ObjLoanRepaymentschedule.Next = 0;
        end;



        //===================================================Scheduled Repayment to Date
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Repayment Date", '<=%1', VarReportDate);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                VarSchedulePrincipletoDate := VarSchedulePrincipletoDate + ObjLoanRepaymentschedule."Principal Repayment";
                VarScheduleInteresttoDate := VarScheduleInteresttoDate + ObjLoanRepaymentschedule."Monthly Interest";
                VarScheduleInsurancetoDate := VarScheduleInsurancetoDate + ObjLoanRepaymentschedule."Monthly Insurance";
            until ObjLoanRepaymentschedule.Next = 0;
        end;

        //===================================================Actual Repayment to Date
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Principle Amount Paid", '<>%1', 0);
        if ObjLoanRepaymentschedule.FindSet then begin
            if ObjLoanRepaymentschedule."Repayment Date" <= VarReportDate then begin
                repeat
                    VarActualPrincipletoDate := VarActualPrincipletoDate + ObjLoanRepaymentschedule."Principle Amount Paid";
                    VarActualInteresttoDate := VarActualInteresttoDate + ObjLoanRepaymentschedule."Interest Paid";
                    VarActualInsurancetoDate := VarActualInsurancetoDate + ObjLoanRepaymentschedule."Insurance Paid";
                until ObjLoanRepaymentschedule.Next = 0;
            end;
        end;


        //====================================================Get Loan Interest In Arrears
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetCurrentkey(ObjLoanRepaymentschedule."Repayment Date");
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Repayment Date", '<=%1', VarReportDate);
        if ObjLoanRepaymentschedule.FindLast then begin
            VarLastInstalmentDueDate := ObjLoanRepaymentschedule."Repayment Date";
        end;

        ObjLoanInterestAccrued.Reset;
        ObjLoanInterestAccrued.SetRange(ObjLoanInterestAccrued."Loan No", VarLoanNo);
        ObjLoanInterestAccrued.SetFilter(ObjLoanInterestAccrued."Posting Date", '<=%1', VarLastInstalmentDueDate);
        if ObjLoanInterestAccrued.FindSet then begin
            repeat
                VarTotalInterestAccrued := VarTotalInterestAccrued + ObjLoanInterestAccrued.Amount;
            until ObjLoanInterestAccrued.Next = 0;
        end;

        VarAmountinArrearsInterest := VarTotalInterestAccrued - VarInterestPaid;
        if VarAmountinArrearsInterest < 0 then
            VarAmountinArrearsInterest := 0;
        //====================================================Get Loan Interest In Arrears

        VarAmountinArrears := 0;

        //=================================Loan Principle


        if ObjLoans.Get(VarLoanNo) then begin
            ObjLoans.CalcFields(ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Outstanding Balance");
            if ObjLoans."Outstanding Balance" > 0 then begin
                VarAmountinArrears := VarSchedulePrincipletoDate - VarActualPrincipletoDate;
                VarAmountinArrearsInsurance := VarScheduleInsurancetoDate - VarActualInsurancetoDate;
                if VarAmountinArrears < 0 then begin
                    VarAmountinArrears := 0
                end;
            end;
        end;
        //=================================Loan Interest
        if VarAmountinArrearsInterest < 0 then begin
            VarAmountinArrearsInterest := 0
        end else
            VarAmountinArrearsInterest := VarAmountinArrearsInterest;

        //=================================Loan Insurance
        if VarAmountinArrearsInsurance < 0 then begin
            VarAmountinArrearsInsurance := 0
        end else
            VarAmountinArrearsInsurance := VarAmountinArrearsInsurance;

        //=================================Loan Principle
        ObjLoanRepaymentschedule.CalcFields("Cummulative Principle Paid");
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetCurrentkey(ObjLoanRepaymentschedule."Repayment Date");
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Instalment Fully Settled", false);
        //ObjLoanRepaymentschedule.SETFILTER(ObjLoanRepaymentschedule."Principle Amount Paid",'<>%1',ObjLoanRepaymentschedule."Principal Repayment");
        if ObjLoanRepaymentschedule.FindFirst then begin
            VarNoofDaysinArrears := VarReportDate - ObjLoanRepaymentschedule."Repayment Date"
        end;


        if VarNoofDaysinArrears < 0 then begin
            VarNoofDaysinArrears := 0
        end else
            VarNoofDaysinArrears := VarNoofDaysinArrears;



        if ObjLoans.Get(VarLoanNo) then begin
            ObjLoans.CalcFields(ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Penalty Paid Historical");

            VarOutstandingPenalty := ObjLoans."Penalty Charged" - (ObjLoans."Penalty Paid" + ObjLoans."Penalty Paid Historical");
            if VarOutstandingPenalty < 0 then
                VarOutstandingPenalty := 0;


            VarRoundedArrears := VarAmountinArrears + VarAmountinArrearsInterest + VarAmountinArrearsInsurance + VarOutstandingPenalty;
            if VarRoundedArrears < 0 then
                VarRoundedArrears := 0;

            if VarRoundedArrears = 0 then
                VarNoofDaysinArrears := 0;

            VarArrearsAmountOutput := VarRoundedArrears;
            VarArrearsDaysOutput := VarNoofDaysinArrears;
        end;

    end;


    procedure FnUpdateLoanPortfolio(VarReportDate: Date)
    var
        ObjLoans: Record "Loans Register";
        ObLoansII: Record "Loans Register";
        ObjLoanPortfolio: Record "Loan Portfolio Provision";
        VarDateFilter: Text;
        SFactory: Codeunit "Micropoint Factory";
        VarClassification: Option Perfoming,Watch,Substandard,Doubtful,Loss;
        VarPerformingAmount: Decimal;
        VarWatchAmount: Decimal;
        VarSubstandardAmount: Decimal;
        VarDoubtfulAmount: Decimal;
        VarLossAmount: Decimal;
        VarArrearsAmount: Decimal;
        VarArrearsDays: Integer;
        VarMemberAge: Integer;
        VarAge: Integer;
        VarAge2: Integer;
    begin

        ObjLoanPortfolio.Reset;
        ObjLoanPortfolio.SetRange(ObjLoanPortfolio."Report Date", VarReportDate);
        if ObjLoanPortfolio.Find('-') = false then begin
            VarDateFilter := '..' + Format(VarReportDate);
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
            ObjLoans.Reset;
            ObjLoans.SetFilter(ObjLoans."Issued Date", '<=%1', VarReportDate);
            ObjLoans.SetFilter(ObjLoans."Date filter", VarDateFilter);
            ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
            if ObjLoans.Find('-') then begin
                repeat
                    VarPerformingAmount := 0;
                    VarWatchAmount := 0;
                    VarSubstandardAmount := 0;
                    VarDoubtfulAmount := 0;
                    VarLossAmount := 0;
                    SFactory.FnGetLoanArrearsAmountReport(ObjLoans."Loan  No.", VarReportDate, VarArrearsAmount, VarArrearsDays);

                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance");

                    if (VarArrearsDays = 0) then begin
                        VarClassification := Varclassification::Perfoming;
                        VarPerformingAmount := ObjLoans."Outstanding Balance";
                    end else
                        if (VarArrearsDays > 0) and (VarArrearsDays <= 30) then begin
                            VarClassification := Varclassification::Watch;
                            VarWatchAmount := ObjLoans."Outstanding Balance";
                        end else
                            if (VarArrearsDays >= 31) and (VarArrearsDays <= 180) then begin
                                VarClassification := Varclassification::Substandard;
                                VarSubstandardAmount := ObjLoans."Outstanding Balance";
                            end else
                                if (VarArrearsDays >= 181) and (VarArrearsDays <= 360) then begin
                                    VarDoubtfulAmount := ObjLoans."Outstanding Balance";
                                    VarClassification := Varclassification::Doubtful;
                                end else
                                    if (VarArrearsDays > 360) then begin
                                        VarClassification := Varclassification::Loss;
                                        VarLossAmount := ObjLoans."Outstanding Balance"
                                    end;

                    //===============================================================Insert Member Age
                    if ObjMembers.Get(ObjLoans."Client Code") then begin
                        if ObjMembers."Date Filter" <> 0D then begin
                            VarAge := VarReportDate - ObjMembers."Date of Birth"; //Returns number of days old
                            VarAge2 := ROUND((VarAge / 365.2364), 1, '<');  //Returns number of years old as Decimal - Takes into Account Leap Years
                            VarMemberAge := VarAge2;
                        end;
                    end;

                    ObjLoanPortfolio.Init;
                    ObjLoanPortfolio."Loan No" := ObjLoans."Loan  No.";
                    ObjLoanPortfolio."Member No" := ObjLoans."Client Code";
                    ObjLoanPortfolio."Member Name" := ObjLoans."Client Name";
                    ObjLoanPortfolio."Outstanding Balance" := ObjLoans."Outstanding Balance";
                    ObjLoanPortfolio."Arrears Amount" := VarArrearsAmount;
                    ObjLoanPortfolio."Arrears Days" := VarArrearsDays;
                    ObjLoanPortfolio.Classification := VarClassification;
                    ObjLoanPortfolio.Performing := VarPerformingAmount;
                    ObjLoanPortfolio.Watch := VarWatchAmount;
                    ObjLoanPortfolio.Substandard := VarSubstandardAmount;
                    ObjLoanPortfolio.Doubtful := VarDoubtfulAmount;
                    ObjLoanPortfolio.Loss := VarLossAmount;
                    ObjLoanPortfolio."Report Date" := VarReportDate;
                    ObjLoanPortfolio.Rescheduled := ObjLoans.Rescheduled;
                    ObjLoanPortfolio."Member Age" := VarMemberAge;
                    ObjLoanPortfolio."Loan Product Code" := ObjLoans."Loan Product Type";
                    ObjLoanPortfolio."Branch Code" := ObjLoans."Branch Code";
                    ObjLoanPortfolio."Group Code" := ObjLoans."Member House Group";
                    ObjLoanPortfolio.Insert;


                until ObjLoans.Next = 0;
            end;
        end;
    end;


    procedure FnGenerateLoanRepaymentSchedule(VarLoanNo: Code[30])
    var
        ObjLoans: Record "Loans Register";
        ObjRepaymentschedule: Record "Loan Repayment Schedule";
        ObjRepaymentscheduleTemp: Record "Loan Repayment Schedule Temp";
        ObjLoansII: Record "Loans Register";
        VarPeriodDueDate: Date;
        VarRunningDate: Date;
        VarGracePeiodEndDate: Date;
        VarInstalmentEnddate: Date;
        VarGracePerodDays: Integer;
        VarInstalmentDays: Integer;
        VarNoOfGracePeriod: Integer;
        VarLoanAmount: Decimal;
        VarInterestRate: Decimal;
        VarRepayPeriod: Integer;
        VarLBalance: Decimal;
        VarRunDate: Date;
        VarInstalNo: Decimal;
        VarRepayInterval: DateFormula;
        VarTotalMRepay: Decimal;
        VarLInterest: Decimal;
        VarLPrincipal: Decimal;
        VarLInsurance: Decimal;
        VarRepayCode: Code[40];
        VarGrPrinciple: Integer;
        VarGrInterest: Integer;
        VarQPrinciple: Decimal;
        VarQCounter: Integer;
        VarInPeriod: DateFormula;
        VarInitialInstal: Integer;
        VarInitialGraceInt: Integer;
        VarScheduleBal: Decimal;
        VarLNBalance: Decimal;
        ObjProductCharge: Record "Loan Product Charges";
        VarWhichDay: Integer;
    begin

        // ObjLoans.Reset;
        // ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        // if ObjLoans.FindSet then begin
        //     if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Daily then
        //         Evaluate(VarInPeriod, '1D')
        //     else if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Weekly then
        //         Evaluate(VarInPeriod, '1W')
        //     else if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Monthly then
        //         Evaluate(VarInPeriod, '1M')
        //     else if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Quaterly then
        //         Evaluate(VarInPeriod, '1Q');

        //     VarRunDate := 0D;
        //     VarQCounter := 0;
        //     VarQCounter := 3;
        //     VarScheduleBal := 0;

        //     VarGrPrinciple := ObjLoans."Grace Period - Principle (M)";
        //     VarGrInterest := ObjLoans."Grace Period - Interest (M)";
        //     VarInitialGraceInt := ObjLoans."Grace Period - Interest (M)";


        //     ObjLoansII.Reset;
        //     ObjLoansII.SetRange(ObjLoansII."Loan  No.", VarLoanNo);
        //     if ObjLoansII.Find('-') then begin
        //         ObjLoansII.CalcFields(ObjLoansII."Outstanding Balance");

        //         ObjLoans.TestField(ObjLoans."Loan Disbursement Date");
        //         ObjLoans.TestField(ObjLoans."Repayment Start Date");

        //         //=================================================================Delete From Tables
        //         ObjRepaymentschedule.Reset;
        //         ObjRepaymentschedule.SetRange(ObjRepaymentschedule."Loan No.", VarLoanNo);
        //         ObjRepaymentschedule.DeleteAll;

        //         ObjRepaymentscheduleTemp.Reset;
        //         ObjRepaymentscheduleTemp.SetRange(ObjRepaymentscheduleTemp."Loan No.", VarLoanNo);
        //         ObjRepaymentscheduleTemp.DeleteAll;


        //         if ObjLoansII.Get(VarLoanNo) then begin
        //             VarLoanAmount := ObjLoansII."Approved Amount" + ObjLoansII."Capitalized Charges";
        //             VarInterestRate := ObjLoansII.Interest;
        //             VarRepayPeriod := ObjLoansII.Installments;
        //             VarInitialInstal := ObjLoansII.Installments + ObjLoansII."Grace Period - Principle (M)";
        //             VarLBalance := ObjLoansII."Approved Amount" + ObjLoansII."Capitalized Charges";
        //             VarLNBalance := ObjLoansII."Outstanding Balance";
        //             VarRunDate := ObjLoansII."Repayment Start Date";


        //             VarInstalNo := 0;
        //             Evaluate(VarRepayInterval, '1W');

        //             //=================================================================================Repayment Frequency
        //             if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Daily then
        //                 VarRunDate := CalcDate('-1D', VarRunDate)
        //             else if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Weekly then
        //                 VarRunDate := CalcDate('-1W', VarRunDate)
        //             else if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Monthly then
        //                 VarRunDate := CalcDate('-1M', VarRunDate)
        //             else if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Quaterly then
        //                 VarRunDate := CalcDate('-1Q', VarRunDate);

        //             repeat
        //                 VarInstalNo := VarInstalNo + 1;
        //                 VarScheduleBal := VarLBalance;

        //                 //=====================================================================================Repayment Frequency
        //                 if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Daily then
        //                     VarRunDate := CalcDate('1D', VarRunDate)
        //                 else if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Weekly then
        //                     VarRunDate := CalcDate('1W', VarRunDate)
        //                 else if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Monthly then
        //                     VarRunDate := CalcDate('1M', VarRunDate)
        //                 else if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Quaterly then
        //                     VarRunDate := CalcDate('1Q', VarRunDate);


        //                 //=======================================================================================Amortised
        //                 if ObjLoans."Repayment Method" = ObjLoans."repayment method"::Amortised then begin
        //                     ObjLoans.TestField(ObjLoans.Installments);
        //                     ObjLoans.TestField(ObjLoans.Interest);
        //                     ObjLoans.TestField(ObjLoans.Installments);
        //                     VarTotalMRepay := ROUND((VarInterestRate / 12 / 100) / (1 - Power((1 + (VarInterestRate / 12 / 100)), -VarRepayPeriod)) * VarLoanAmount, 1, '>');
        //                     VarTotalMRepay := (VarInterestRate / 12 / 100) / (1 - Power((1 + (VarInterestRate / 12 / 100)), -VarRepayPeriod)) * VarLoanAmount;
        //                     VarLInterest := ROUND(VarLBalance / 100 / 12 * VarInterestRate);

        //                     VarLPrincipal := VarTotalMRepay - VarLInterest;

        //                     ObjProductCharge.Reset;
        //                     ObjProductCharge.SetRange(ObjProductCharge."Product Code", ObjLoans."Loan Product Type");
        //                     ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
        //                     if ObjProductCharge.FindSet then begin
        //                         VarLInsurance := ObjLoans."Approved Amount" * (ObjProductCharge.Percentage / 100);
        //                     end;
        //                 end;

        //                 //=======================================================================================Strainght Line
        //                 if ObjLoans."Repayment Method" = ObjLoans."repayment method"::"Straight Line" then begin
        //                     ObjLoans.TestField(ObjLoans.Installments);
        //                     VarLPrincipal := ROUND(VarLoanAmount / VarRepayPeriod, 1, '>');
        //                     VarLInterest := ROUND((VarInterestRate / 1200) * VarLoanAmount, 1, '>');


        //                     ObjLoans.Repayment := VarLPrincipal + VarLInterest;
        //                     ObjLoans."Loan Principle Repayment" := VarLPrincipal;
        //                     ObjLoans."Loan Interest Repayment" := VarLInterest;
        //                     ObjLoans.Modify;

        //                     ObjProductCharge.Reset;
        //                     ObjProductCharge.SetRange(ObjProductCharge."Product Code", ObjLoans."Loan Product Type");
        //                     ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
        //                     if ObjProductCharge.FindSet then begin
        //                         VarLInsurance := ObjLoans."Approved Amount" * (ObjProductCharge.Percentage / 100);
        //                         if ObjLoans."Corporate Loan" = true then
        //                             VarLInsurance := 0;
        //                     end;
        //                 end;

        //                 //=======================================================================================Reducing Balance
        //                 if ObjLoans."Repayment Method" = ObjLoans."repayment method"::"Reducing Balance" then begin
        //                     ObjLoans.TestField(ObjLoans.Interest);
        //                     ObjLoans.TestField(ObjLoans.Installments);
        //                     VarLPrincipal := ROUND(VarLoanAmount / VarRepayPeriod, 1, '>');
        //                     VarLInterest := ROUND((VarInterestRate / 12 / 100) * VarLBalance, 1, '>');

        //                     ObjProductCharge.Reset;
        //                     ObjProductCharge.SetRange(ObjProductCharge."Product Code", ObjLoans."Loan Product Type");
        //                     ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
        //                     if ObjProductCharge.FindSet then begin
        //                         VarLInsurance := ObjLoans."Approved Amount" * (ObjProductCharge.Percentage / 100);
        //                     end;
        //                 end;

        //                 //=======================================================================================Constant
        //                 if ObjLoans."Repayment Method" = ObjLoans."repayment method"::Constants then begin
        //                     ObjLoans.TestField(ObjLoans.Repayment);
        //                     if VarLBalance < ObjLoans.Repayment then
        //                         VarLPrincipal := VarLBalance
        //                     else
        //                         VarLPrincipal := ObjLoans.Repayment;
        //                     VarLInterest := ObjLoans.Interest;

        //                     ObjProductCharge.Reset;
        //                     ObjProductCharge.SetRange(ObjProductCharge."Product Code", ObjLoans."Loan Product Type");
        //                     ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
        //                     if ObjProductCharge.FindSet then begin
        //                         VarLInsurance := ObjLoans."Approved Amount" * (ObjProductCharge.Percentage / 100);
        //                     end;
        //                 end;


        //                 //======================================================================================Grace Period
        //                 if VarGrPrinciple > 0 then begin
        //                     VarLPrincipal := 0
        //                 end else begin
        //                     if ObjLoans."Instalment Period" <> VarInPeriod then
        //                         VarLBalance := VarLBalance - VarLPrincipal;
        //                     VarScheduleBal := VarScheduleBal - VarLPrincipal;
        //                 end;

        //                 if VarGrInterest > 0 then
        //                     VarLInterest := 0;

        //                 VarGrPrinciple := VarGrPrinciple - 1;
        //                 VarGrInterest := VarGrInterest - 1;

        //                 //======================================================================================Insert Repayment Schedule Table
        //                 ObjRepaymentschedule.Init;
        //                 ObjRepaymentschedule."Repayment Code" := VarRepayCode;
        //                 ObjRepaymentschedule."Loan No." := ObjLoans."Loan  No.";
        //                 ObjRepaymentschedule."Loan Amount" := VarLoanAmount;
        //                 ObjRepaymentschedule."Instalment No" := VarInstalNo;
        //                 ObjRepaymentschedule."Repayment Date" := VarRunDate;//CALCDATE('CM',RunDate);
        //                 ObjRepaymentschedule."Member No." := ObjLoans."Client Code";
        //                 ObjRepaymentschedule."Loan Category" := ObjLoans."Loan Product Type";
        //                 ObjRepaymentschedule."Monthly Repayment" := VarLInterest + VarLPrincipal + VarLInsurance;
        //                 ObjRepaymentschedule."Monthly Interest" := VarLInterest;
        //                 ObjRepaymentschedule."Principal Repayment" := VarLPrincipal;
        //                 ObjRepaymentschedule."Monthly Insurance" := VarLInsurance;
        //                 ObjRepaymentschedule."Loan Balance" := VarScheduleBal;
        //                 ObjRepaymentschedule.Insert;
        //                 VarWhichDay := Date2dwy(ObjRepaymentschedule."Repayment Date", 1);

        //                 //======================================================================================Insert Repayment Schedule Temp Table
        //                 ObjRepaymentscheduleTemp.Init;
        //                 ObjRepaymentscheduleTemp."Repayment Code" := VarRepayCode;
        //                 ObjRepaymentscheduleTemp."Loan No." := ObjLoans."Loan  No.";
        //                 ObjRepaymentscheduleTemp."Loan Amount" := VarLoanAmount;
        //                 ObjRepaymentscheduleTemp."Instalment No" := VarInstalNo;
        //                 ObjRepaymentscheduleTemp."Repayment Date" := VarRunDate;//CALCDATE('CM',RunDate);
        //                 ObjRepaymentscheduleTemp."Member No." := ObjLoans."Client Code";
        //                 ObjRepaymentscheduleTemp."Loan Category" := ObjLoans."Loan Product Type";
        //                 ObjRepaymentscheduleTemp."Monthly Repayment" := VarLInterest + VarLPrincipal + VarLInsurance;
        //                 ObjRepaymentscheduleTemp."Monthly Interest" := VarLInterest;
        //                 ObjRepaymentscheduleTemp."Principal Repayment" := VarLPrincipal;
        //                 ObjRepaymentscheduleTemp."Monthly Insurance" := VarLInsurance;
        //                 ObjRepaymentscheduleTemp."Loan Balance" := VarScheduleBal;
        //                 ObjRepaymentscheduleTemp.Insert;
        //                 VarWhichDay := Date2dwy(ObjRepaymentscheduleTemp."Repayment Date", 1);


        //             until VarLBalance < 1
        //         end;
        //     end;
        // end;
        //*********************************************************************
        ObjLoans.RESET;
        ObjLoans.SETRANGE(ObjLoans."Loan  No.", VarLoanNo);
        ObjLoans.SETFILTER(ObjLoans."Approved Amount", '>%1', 0);
        //LoansRec.SETFILTER(LoansRec.Posted,'=%1',TRUE);
        IF ObjLoans.FIND('-') THEN BEGIN


            IF ((ObjLoans."Issued Date" <> 0D) AND (ObjLoans."Repayment Start Date" <> 0D)) THEN BEGIN
                ObjLoans.TESTFIELD(ObjLoans."Loan Disbursement Date");
                ObjLoans.TESTFIELD(ObjLoans."Repayment Start Date");

                ObjRepaymentschedule.RESET;
                ObjRepaymentschedule.SETRANGE(ObjRepaymentschedule."Loan No.", ObjLoans."Loan  No.");
                ObjRepaymentschedule.DELETEALL;

                //LoanAmount:=LoansRec."Approved Amount";
                VarLoanAmount := ObjLoans."Approved Amount";
                //Insurance:=LoansRec.Insurance;
                VarInterestRate := ObjLoans.Interest;
                VarRepayPeriod := ObjLoans.Installments;
                VarInitialInstal := ObjLoans.Installments + ObjLoans."Grace Period - Principle (M)";
                //LBalance:=LoansRec."Approved Amount";
                VarLBalance := ObjLoans."Approved Amount";
                VarRunDate := ObjLoans."Repayment Start Date";
                VarInstalNo := 0;

                //Installment 0

                ObjRepaymentschedule.INIT;
                ObjRepaymentschedule."Repayment Code" := VarRepayCode;
                ObjRepaymentschedule."Interest Rate" := VarInterestRate;
                ObjRepaymentschedule."Loan No." := ObjLoans."Loan  No.";
                ObjRepaymentschedule."Loan Amount" := VarLoanAmount;
                ObjRepaymentschedule."Instalment No" := VarInstalNo;
                ObjRepaymentschedule."Monthly Insurance" := varLInsurance;
                ObjRepaymentschedule."Monthly Tracking Fee" := ObjLoans."Monthly Tracking Fee";
                ObjRepaymentschedule."Repayment Date" := 0D;//CALCDATE('CM',RunDate);
                ObjRepaymentschedule."Member No." := ObjLoans."Client Code";
                ObjRepaymentschedule."Loan Category" := ObjLoans."Loan Product Type";
                IF (ObjLoans."Loan Product Type" = 'SUKUMA') OR (ObjLoans."Loan Product Type" = 'KARIBU') OR (ObjLoans."Loan Product Type" = 'INSTANT') THEN
    ObjRepaymentschedule."Monthly Repayment" := VarLPrincipal + ObjLoans."Monthly Tracking Fee" // UPDATED
ELSE
    ObjRepaymentschedule."Monthly Repayment" := VarLInterest + VarLPrincipal + ObjLoans."Monthly Tracking Fee"; // UPDATED
                IF ObjLoans."Loan Product Type" = 'SUKUMA' THEN
                    ObjRepaymentschedule."Monthly Interest" := ObjLoans."Loan Interest Repayment";
                ObjRepaymentschedule."Principal Repayment" := VarLPrincipal;
                ObjRepaymentschedule."Loan Balance" := VarLBalance;
                ObjRepaymentschedule.INSERT;

                //Repayment Frequency
                IF ObjLoans."Repayment Frequency" = ObjLoans."Repayment Frequency"::Daily THEN
                    VarRunDate := CALCDATE('-1D', VarRunDate)
                ELSE IF ObjLoans."Repayment Frequency" = ObjLoans."Repayment Frequency"::Weekly THEN
                    VarRunDate := CALCDATE('-1W', VarRunDate)
                ELSE IF ObjLoans."Repayment Frequency" = ObjLoans."Repayment Frequency"::Monthly THEN
                    VarRunDate := CALCDATE('-1M', VarRunDate)
                ELSE IF ObjLoans."Repayment Frequency" = ObjLoans."Repayment Frequency"::Quaterly THEN
                    VarRunDate := CALCDATE('-1Q', VarRunDate);
                //Repayment Frequency


                REPEAT
                    VarInstalNo := VarInstalNo + 1;
                    //Repayment Frequency
                    IF ObjLoans."Repayment Frequency" = ObjLoans."Repayment Frequency"::Daily THEN
                        VarRunDate := CALCDATE('1D', VarRunDate)
                    ELSE IF ObjLoans."Repayment Frequency" = ObjLoans."Repayment Frequency"::Weekly THEN
                        VarRunDate := CALCDATE('1W', VarRunDate)
                    ELSE IF ObjLoans."Repayment Frequency" = ObjLoans."Repayment Frequency"::Monthly THEN
                        VarRunDate := CALCDATE('1M', VarRunDate)
                    ELSE IF ObjLoans."Repayment Frequency" = ObjLoans."Repayment Frequency"::Quaterly THEN
                        VarRunDate := CALCDATE('1Q', VarRunDate);

                    IF ObjLoans."Loan Product Type" = 'MOTOR' THEN BEGIN
                        ObjLoans.TESTFIELD(ObjLoans.Installments);
                        VarLPrincipal := VarLoanAmount / VarRepayPeriod;
                    END;

                    IF VarInterestRate > 0 THEN BEGIN
                        IF ObjLoans."Repayment Method" = ObjLoans."Repayment Method"::Amortised THEN BEGIN
                            ObjLoans.TESTFIELD(ObjLoans.Installments);
                            VarTotalMRepay := ROUND((VarInterestRate / 12 / 100) / (1 - POWER((1 + (VarInterestRate / 12 / 100)), -(varRepayPeriod))) * (varLoanAmount), 0.0001, '>');
                            VarLInterest := ROUND(VarLBalance / 100 / 12 * VarInterestRate, 0.0001, '>');
                            VarLPrincipal := VarTotalMRepay - VarLInterest;
                        END;

                        IF ObjLoans."Repayment Method" = ObjLoans."Repayment Method"::"Straight Line" THEN BEGIN
                            ObjLoans.TESTFIELD(ObjLoans.Interest);
                            ObjLoans.TESTFIELD(ObjLoans.Installments);
                            VarLPrincipal := VarLoanAmount / VarRepayPeriod;
                            VarLInterest := (VarInterestRate / 12 / 100) * VarLoanAmount / VarRepayPeriod;
                        END;

                        IF ObjLoans."Repayment Method" = ObjLoans."Repayment Method"::"Reducing Balance" THEN BEGIN
                            ObjLoans.TESTFIELD(ObjLoans.Interest);
                            ObjLoans.TESTFIELD(ObjLoans.Installments);
                            VarLPrincipal := VarLoanAmount / VarRepayPeriod;
                            VarLInterest := (VarInterestRate / 12 / 100) * VarLBalance;
                        END;
                    END;
                    IF ObjLoans."Repayment Method" = ObjLoans."Repayment Method"::Constants THEN BEGIN
                        ObjLoans.TESTFIELD(ObjLoans.Repayment);
                        IF VarLBalance < ObjLoans.Repayment THEN
                            VarLPrincipal := VarLBalance
                        ELSE
                            VarLPrincipal := ObjLoans.Repayment;
                        VarLInterest := ObjLoans.Interest;
                    END;

                    //Grace Period
                    IF VarGrPrinciple > 0 THEN BEGIN
                        VarLPrincipal := 0
                    END ELSE BEGIN
                        VarLBalance := VarLBalance - VarLPrincipal;

                    END;

                    IF VarGrInterest > 0 THEN
                        VarLInterest := 0;

                    VarGrPrinciple := VarGrPrinciple - 1;
                    VarGrInterest := VarGrInterest - 1;
                    EVALUATE(VarRepayCode, FORMAT(VarInstalNo));


                    ObjRepaymentschedule.INIT;
                    ObjRepaymentschedule."Repayment Code" := VarRepayCode;
                    ObjRepaymentschedule."Interest Rate" := VarInterestRate;
                    ObjRepaymentschedule."Loan No." := ObjLoans."Loan  No.";
                    ObjRepaymentschedule."Loan Amount" := VarLoanAmount;
                    ObjRepaymentschedule."Instalment No" := VarInstalNo;
                    ObjRepaymentschedule."Monthly Tracking Fee" := ObjLoans."Monthly Tracking Fee";
                    //RSchedule."Repayment Date":=CALCDATE('CM',RunDate);
                    ObjRepaymentschedule."Repayment Date" := VarRunDate;
                    ObjRepaymentschedule."Member No." := ObjLoans."Client Code";
                    ObjRepaymentschedule."Loan Category" := ObjLoans."Loan Product Type";
                    IF (ObjLoans."Loan Product Type" = 'SUKUMA') OR (ObjLoans."Loan Product Type" = 'KARIBU') OR (ObjLoans."Loan Product Type" = 'INSTANT') THEN
    ObjRepaymentschedule."Monthly Repayment" := VarLPrincipal + ObjLoans."Monthly Tracking Fee" // UPDATED
ELSE
    ObjRepaymentschedule."Monthly Repayment" := VarLInterest + VarLPrincipal + ObjLoans."Monthly Tracking Fee"; // UPDATED
                    IF ObjLoans."Loan Product Type" <> 'SUKUMA' THEN
                        ObjRepaymentschedule."Monthly Interest" := VarLInterest;
                    ObjRepaymentschedule."Principal Repayment" := VarLPrincipal;
                    ObjRepaymentschedule."Loan Balance" := VarLBalance;
                    ObjRepaymentschedule.INSERT;
                    VarWhichDay := DATE2DWY(ObjRepaymentschedule."Repayment Date", 1);
                UNTIL VarLBalance < 1

            END;
        END;

        COMMIT;

    end;




    //Mjk
    procedure FnGenerateLoanRepaymentReSchedule(VarLoanNo: Code[30])
    var
        ObjLoans: Record "Loans Register";
        ObjRepaymentschedule: Record "Loan Repayment Schedule";
        ObjRepaymentscheduleTemp: Record "Loan Repayment Schedule Temp";
        ObjLoansII: Record "Loan Restructure";
        VarPeriodDueDate: Date;
        VarRunningDate: Date;
        VarGracePeiodEndDate: Date;
        VarInstalmentEnddate: Date;
        VarGracePerodDays: Integer;
        VarInstalmentDays: Integer;
        VarNoOfGracePeriod: Integer;
        VarLoanAmount: Decimal;
        VarInterestRate: Decimal;
        VarRepayPeriod: Integer;
        VarLBalance: Decimal;
        VarRunDate: Date;
        VarInstalNo: Decimal;
        VarRepayInterval: DateFormula;
        VarTotalMRepay: Decimal;
        VarLInterest: Decimal;
        VarLPrincipal: Decimal;
        VarLInsurance: Decimal;
        VarRepayCode: Code[40];
        VarGrPrinciple: Integer;
        VarGrInterest: Integer;
        VarQPrinciple: Decimal;
        VarQCounter: Integer;
        VarInPeriod: DateFormula;
        VarInitialInstal: Integer;
        VarInitialGraceInt: Integer;
        VarScheduleBal: Decimal;
        VarLNBalance: Decimal;
        ObjProductCharge: Record "Loan Product Charges";
        VarWhichDay: Integer;
    begin

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        if ObjLoans.FindSet then begin
            if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Daily then
                Evaluate(VarInPeriod, '1D')
            else if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Weekly then
                Evaluate(VarInPeriod, '1W')
            else if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Monthly then
                Evaluate(VarInPeriod, '1M')
            else if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Quaterly then
                Evaluate(VarInPeriod, '1Q');

            VarRunDate := 0D;
            VarQCounter := 0;
            VarQCounter := 3;
            VarScheduleBal := 0;

            VarGrPrinciple := ObjLoans."Grace Period - Principle (M)";
            VarGrInterest := ObjLoans."Grace Period - Interest (M)";
            VarInitialGraceInt := ObjLoans."Grace Period - Interest (M)";


            ObjLoansII.Reset;
            ObjLoansII.SetRange(ObjLoansII."Loan to Restructure", VarLoanNo);
            if ObjLoansII.Find('-') then begin
                ObjLoansII.CalcFields(ObjLoansII."Outstanding Loan");

                ObjLoans.TestField(ObjLoans."Loan Rescheduled Date");
                ObjLoans.TestField(ObjLoans."New Repayment Start Date");

                //=================================================================Delete From Tables
                ObjRepaymentschedule.Reset;
                ObjRepaymentschedule.SetRange(ObjRepaymentschedule."Loan No.", VarLoanNo);
                ObjRepaymentschedule.DeleteAll;

                ObjRepaymentscheduleTemp.Reset;
                ObjRepaymentscheduleTemp.SetRange(ObjRepaymentscheduleTemp."Loan No.", VarLoanNo);
                ObjRepaymentscheduleTemp.DeleteAll;


                if ObjLoansII.Get(VarLoanNo) then begin
                    VarLoanAmount := ObjLoansII."Outstanding Loan" + ObjLoansII."Outstanding Interest";
                    VarInterestRate := ObjLoansII."Loan Interest Rate";
                    VarRepayPeriod := ObjLoansII."New Loan Period";
                    VarInitialInstal := ObjLoansII."New Loan Period";
                    VarLBalance := ObjLoansII."Outstanding Loan" + ObjLoansII."Outstanding Interest";
                    VarLNBalance := ObjLoansII."Outstanding Loan" + ObjLoansII."Outstanding Interest";
                    VarRunDate := ObjLoansII."New Repayment Start Date";


                    VarInstalNo := 0;
                    Evaluate(VarRepayInterval, '1W');

                    //=================================================================================Repayment Frequency
                    if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Daily then
                        VarRunDate := CalcDate('-1D', VarRunDate)
                    else if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Weekly then
                        VarRunDate := CalcDate('-1W', VarRunDate)
                    else if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Monthly then
                        VarRunDate := CalcDate('-1M', VarRunDate)
                    else if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Quaterly then
                        VarRunDate := CalcDate('-1Q', VarRunDate);

                    repeat
                        VarInstalNo := VarInstalNo + 1;
                        VarScheduleBal := VarLBalance;

                        //=====================================================================================Repayment Frequency
                        if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Daily then
                            VarRunDate := CalcDate('1D', VarRunDate)
                        else if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Weekly then
                            VarRunDate := CalcDate('1W', VarRunDate)
                        else if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Monthly then
                            VarRunDate := CalcDate('1M', VarRunDate)
                        else if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Quaterly then
                            VarRunDate := CalcDate('1Q', VarRunDate);


                        //=======================================================================================Amortised
                        if ObjLoans."Repayment Method" = ObjLoans."repayment method"::Amortised then begin
                            ObjLoans.TestField(ObjLoans.Installments);
                            ObjLoans.TestField(ObjLoans.Interest);
                            ObjLoans.TestField(ObjLoans.Installments);
                            VarTotalMRepay := ROUND((VarInterestRate / 12 / 100) / (1 - Power((1 + (VarInterestRate / 12 / 100)), -VarRepayPeriod)) * VarLoanAmount, 1, '>');
                            VarTotalMRepay := (VarInterestRate / 12 / 100) / (1 - Power((1 + (VarInterestRate / 12 / 100)), -VarRepayPeriod)) * VarLoanAmount;
                            VarLInterest := ROUND(VarLBalance / 100 / 12 * VarInterestRate);

                            VarLPrincipal := VarTotalMRepay - VarLInterest;

                            ObjProductCharge.Reset;
                            ObjProductCharge.SetRange(ObjProductCharge."Product Code", ObjLoans."Loan Product Type");
                            ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                            if ObjProductCharge.FindSet then begin
                                VarLInsurance := ObjLoans."Approved Amount" * (ObjProductCharge.Percentage / 100);
                            end;
                        end;

                        //=======================================================================================Strainght Line
                        if ObjLoans."Repayment Method" = ObjLoans."repayment method"::"Straight Line" then begin
                            ObjLoans.TestField(ObjLoans.Installments);
                            VarLPrincipal := ROUND(VarLoanAmount / VarRepayPeriod, 1, '>');
                            VarLInterest := ROUND((VarInterestRate / 1200) * VarLoanAmount, 1, '>');


                            ObjLoans.Repayment := VarLPrincipal + VarLInterest;
                            ObjLoans."Loan Principle Repayment" := VarLPrincipal;
                            ObjLoans."Loan Interest Repayment" := VarLInterest;
                            ObjLoans.Modify;

                            ObjProductCharge.Reset;
                            ObjProductCharge.SetRange(ObjProductCharge."Product Code", ObjLoans."Loan Product Type");
                            ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                            if ObjProductCharge.FindSet then begin
                                VarLInsurance := ObjLoans."Approved Amount" * (ObjProductCharge.Percentage / 100);
                                if ObjLoans."Corporate Loan" = true then
                                    VarLInsurance := 0;
                            end;
                        end;

                        //=======================================================================================Reducing Balance
                        if ObjLoans."Repayment Method" = ObjLoans."repayment method"::"Reducing Balance" then begin
                            ObjLoans.TestField(ObjLoans.Interest);
                            ObjLoans.TestField(ObjLoans.Installments);
                            VarLPrincipal := ROUND(VarLoanAmount / VarRepayPeriod, 1, '>');
                            VarLInterest := ROUND((VarInterestRate / 12 / 100) * VarLBalance, 1, '>');

                            ObjProductCharge.Reset;
                            ObjProductCharge.SetRange(ObjProductCharge."Product Code", ObjLoans."Loan Product Type");
                            ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                            if ObjProductCharge.FindSet then begin
                                VarLInsurance := ObjLoans."Approved Amount" * (ObjProductCharge.Percentage / 100);
                            end;
                        end;

                        //=======================================================================================Constant
                        if ObjLoans."Repayment Method" = ObjLoans."repayment method"::Constants then begin
                            ObjLoans.TestField(ObjLoans.Repayment);
                            if VarLBalance < ObjLoans.Repayment then
                                VarLPrincipal := VarLBalance
                            else
                                VarLPrincipal := ObjLoans.Repayment;
                            VarLInterest := ObjLoans.Interest;

                            ObjProductCharge.Reset;
                            ObjProductCharge.SetRange(ObjProductCharge."Product Code", ObjLoans."Loan Product Type");
                            ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                            if ObjProductCharge.FindSet then begin
                                VarLInsurance := ObjLoans."Approved Amount" * (ObjProductCharge.Percentage / 100);
                            end;
                        end;


                        //======================================================================================Grace Period
                        if VarGrPrinciple > 0 then begin
                            VarLPrincipal := 0
                        end else begin
                            if ObjLoans."Instalment Period" <> VarInPeriod then
                                VarLBalance := VarLBalance - VarLPrincipal;
                            VarScheduleBal := VarScheduleBal - VarLPrincipal;
                        end;

                        if VarGrInterest > 0 then
                            VarLInterest := 0;

                        VarGrPrinciple := VarGrPrinciple - 1;
                        VarGrInterest := VarGrInterest - 1;

                        //======================================================================================Insert Repayment Schedule Table
                        ObjRepaymentschedule.Init;
                        ObjRepaymentschedule."Repayment Code" := VarRepayCode;
                        ObjRepaymentschedule."Loan No." := ObjLoans."Loan  No.";
                        ObjRepaymentschedule."Loan Amount" := VarLoanAmount;
                        ObjRepaymentschedule."Instalment No" := VarInstalNo;
                        ObjRepaymentschedule."Repayment Date" := VarRunDate;//CALCDATE('CM',RunDate);
                        ObjRepaymentschedule."Member No." := ObjLoans."Client Code";
                        ObjRepaymentschedule."Loan Category" := ObjLoans."Loan Product Type";
                        ObjRepaymentschedule."Monthly Repayment" := VarLInterest + VarLPrincipal + VarLInsurance;
                        ObjRepaymentschedule."Monthly Interest" := VarLInterest;
                        ObjRepaymentschedule."Principal Repayment" := VarLPrincipal;
                        ObjRepaymentschedule."Monthly Insurance" := VarLInsurance;
                        ObjRepaymentschedule."Loan Balance" := VarScheduleBal;
                        ObjRepaymentschedule.Insert;
                        VarWhichDay := Date2dwy(ObjRepaymentschedule."Repayment Date", 1);

                        //======================================================================================Insert Repayment Schedule Temp Table
                        ObjRepaymentscheduleTemp.Init;
                        ObjRepaymentscheduleTemp."Repayment Code" := VarRepayCode;
                        ObjRepaymentscheduleTemp."Loan No." := ObjLoans."Loan  No.";
                        ObjRepaymentscheduleTemp."Loan Amount" := VarLoanAmount;
                        ObjRepaymentscheduleTemp."Instalment No" := VarInstalNo;
                        ObjRepaymentscheduleTemp."Repayment Date" := VarRunDate;//CALCDATE('CM',RunDate);
                        ObjRepaymentscheduleTemp."Member No." := ObjLoans."Client Code";
                        ObjRepaymentscheduleTemp."Loan Category" := ObjLoans."Loan Product Type";
                        ObjRepaymentscheduleTemp."Monthly Repayment" := VarLInterest + VarLPrincipal + VarLInsurance;
                        ObjRepaymentscheduleTemp."Monthly Interest" := VarLInterest;
                        ObjRepaymentscheduleTemp."Principal Repayment" := VarLPrincipal;
                        ObjRepaymentscheduleTemp."Monthly Insurance" := VarLInsurance;
                        ObjRepaymentscheduleTemp."Loan Balance" := VarScheduleBal;
                        ObjRepaymentscheduleTemp.Insert;
                        VarWhichDay := Date2dwy(ObjRepaymentscheduleTemp."Repayment Date", 1);


                    until VarLBalance < 1
                end;
            end;
        end;
    end;

    procedure FnRunGetLoanPayoffAmountRestructure(VarLoanNo: Code[30]) VarLoanPayoffAmount: Decimal
    var
        ObjLoans: Record "Loans Register";
        VarInsurancePayoff: Decimal;
        ObjProductCharge: Record "Loan Product Charges";
        VarEndYear: Date;
        VarInsuranceMonths: Integer;
        VarAmountinArrears: Decimal;
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        VarOutstandingInterest: Decimal;
        ObjLoanSchedule: Record "Loan Repayment Schedule";
        VarLoanInsuranceCharged: Decimal;
        VarLoanInsurancePaid: Decimal;
        VarOutstandingInsurance: Decimal;
        VarOutstandingPenalty: Decimal;
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        if ObjLoans.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Loan Insurance Paid", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Interest Due",
            ObjLoans."Interest Paid", ObjLoans."Interest Paid Historical", ObjLoans."Penalty Paid Historical", ObjLoans."Insurance Paid Historical", ObjLoans."Principle Paid Historical");





            //============================================================Loan Insurance Repayment
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
            if ObjLoans.Find('-') then begin

                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
                if ObjLoans.FindSet then begin
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Loan Insurance Paid", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Interest Due",
                    ObjLoans."Interest Paid", ObjLoans."Interest Paid Historical", ObjLoans."Penalty Paid Historical", ObjLoans."Insurance Paid Historical", ObjLoans."Principle Paid Historical");

                    if ObjLoans."Outstanding Balance" <> 0 then begin
                        VarEndYear := CalcDate('CY', Today);
                        VarInsuranceMonths := ROUND((VarEndYear - Today) / 30, 1, '=');

                        ObjProductCharge.Reset;
                        ObjProductCharge.SetRange(ObjProductCharge."Product Code", ObjLoans."Loan Product Type");
                        ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                        if ObjProductCharge.FindSet then begin
                            VarInsurancePayoff := ROUND((ObjLoans."Approved Amount" * (ObjProductCharge.Percentage / 100)) * VarInsuranceMonths, 0.05, '>');
                        end;
                    end;
                end;

                FnGetLoanArrearsAmountII(VarLoanNo);//===========================Get Amount In Arrears

                ObjLoanSchedule.Reset;
                ObjLoanSchedule.SetRange(ObjLoanSchedule."Loan No.", VarLoanNo);
                ObjLoanSchedule.SetFilter(ObjLoanSchedule."Repayment Date", '<=%1', WorkDate);
                if ObjLoanSchedule.FindSet then begin
                    repeat
                        VarLoanInsuranceCharged := VarLoanInsuranceCharged + ObjLoanSchedule."Monthly Insurance";
                        VarLoanInsurancePaid := VarLoanInsurancePaid + ObjLoanSchedule."Insurance Paid";
                    until ObjLoanSchedule.Next = 0;
                end;

                VarOutstandingInsurance := VarLoanInsuranceCharged - VarLoanInsurancePaid;



                VarOutstandingInterest := ObjLoans."Interest Due" - (ObjLoans."Interest Paid" + ObjLoans."Interest Paid Historical");
                if VarOutstandingInterest < 0 then begin
                    VarOutstandingInterest := 0;
                end;

                VarOutstandingPenalty := ObjLoans."Penalty Charged" - (ObjLoans."Penalty Paid" + ObjLoans."Penalty Paid Historical");
                if VarOutstandingPenalty < 0 then begin
                    VarOutstandingPenalty := 0;
                end;

                if ObjLoans.Get(VarLoanNo) then begin
                    ObjLoans."Outstanding Penalty" := VarOutstandingPenalty;
                    ObjLoans."Outstanding Insurance" := VarOutstandingInsurance;
                    ObjLoans."Loan Insurance Charged" := VarLoanInsuranceCharged;
                    ObjLoans."Loan Insurance Paid" := VarLoanInsurancePaid;
                    ObjLoans.Modify;
                end;
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                VarLoanPayoffAmount := ObjLoans."Outstanding Balance" + VarOutstandingInterest + VarOutstandingPenalty + VarOutstandingInsurance;
                exit(VarLoanPayoffAmount);

            end;
        end;
    end;


    procedure FnRunGetLoanDebtCollectorFee(VarLoanNo: Code[30]; VarLSABalance: Decimal) VarDebtCollectorFee: Decimal
    var
        VarLoanDueAmount: Decimal;
        VarDebtCollectorBaseAmount: Decimal;
    begin
        ObjLoans.Reset;
        ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        ObjLoans.SetRange(ObjLoans."Loan Under Debt Collection", true);
        if ObjLoans.Find('-') then begin
            VarLoanDueAmount := FnRunLoanAmountDue(VarLoanNo);

            ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid");
            if VarLSABalance > 0 then begin

                if VarLSABalance > VarLoanDueAmount then begin
                    VarDebtCollectorBaseAmount := VarLoanDueAmount
                end else
                    VarDebtCollectorBaseAmount := VarLSABalance;

                VarDebtCollectorFee := VarDebtCollectorBaseAmount * (ObjLoans."Loan Debt Collector Interest %" / 100);
                VarDebtCollectorFee := VarDebtCollectorFee + (VarDebtCollectorFee * 0.16);
                exit(VarDebtCollectorFee);
            end;
        end;
    end;


    procedure FnRunCreateDebtCollectorFeeJournals(VarLoanNoRecovered: Code[30]; BATCH_TEMPLATE: Code[20]; BATCH_NAME: Code[20]; DOCUMENT_NO: Code[20]; VarMemberNo: Code[20]; VarPostingDate: Date; EXTERNAL_DOC_NO: Code[30]; VarLoanSettlementAcc: Code[30]; RunningBalance: Decimal; var LineNo: Integer) VarRunBal: Decimal
    var
        AmountToDeduct: Decimal;
        VarDebtCollectorBaseAmount: Decimal;
        VarDebtCollectorFee: Decimal;
    begin
        //============================================================Debt Collector Fee
        if RunningBalance > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            ObjLoans.SetRange(ObjLoans."Loan Under Debt Collection", true);
            if ObjLoans.Find('-') then begin
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid");
                if RunningBalance > 0 then begin
                    AmountToDeduct := 0;

                    if RunningBalance > ObjLoans."Outstanding Balance" then
                        VarDebtCollectorBaseAmount := ObjLoans."Outstanding Balance"
                    else
                        VarDebtCollectorBaseAmount := RunningBalance;

                    VarDebtCollectorFee := VarDebtCollectorBaseAmount * (ObjLoans."Loan Debt Collector Interest %" / 100);
                    VarDebtCollectorFee := VarDebtCollectorFee + (VarDebtCollectorFee * 0.16);

                    if RunningBalance > VarDebtCollectorFee then begin
                        AmountToDeduct := VarDebtCollectorFee
                    end else
                        AmountToDeduct := RunningBalance;

                    //------------------------------------1. Debit FOSA Account---------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"FOSA Account",
                    GenJournalLine."account type"::Vendor, VarLoanSettlementAcc, WorkDate, AmountToDeduct, 'FOSA', '',
                    'Debt Collection Charge + VAT from ' + VarLoanNoRecovered, '', GenJournalLine."application source"::" ");

                    LineNo := LineNo + 10000;
                    FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"FOSA Account",
                    GenJournalLine."account type"::Vendor, ObjLoans."Loan Debt Collector", WorkDate, AmountToDeduct * -1, 'BOSA', VarLoanNoRecovered,
                    'Debt Collection Charge + VAT from ' + VarLoanNoRecovered + ObjLoans."Client Name", VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);
                    VarRunBal := RunningBalance - AmountToDeduct;
                    exit(VarRunBal);
                end;
            end;
        end;
    end;


    procedure FnRunGetLoanDebtCollectorFeePayoff(VarLoanNo: Code[30]; VarLSABalance: Decimal) VarDebtCollectorFee: Decimal
    var
        VarLoanDueAmount: Decimal;
        VarDebtCollectorBaseAmount: Decimal;
    begin
        ObjLoans.Reset;
        ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        ObjLoans.SetRange(ObjLoans."Loan Under Debt Collection", true);
        if ObjLoans.Find('-') then begin
            VarLoanDueAmount := FnRunGetLoanPayoffAmount(VarLoanNo);

            ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid");
            if VarLSABalance > 0 then begin

                if VarLSABalance > VarLoanDueAmount then begin
                    VarDebtCollectorBaseAmount := VarLoanDueAmount
                end else
                    VarDebtCollectorBaseAmount := VarLSABalance;

                VarDebtCollectorFee := VarDebtCollectorBaseAmount * (ObjLoans."Loan Debt Collector Interest %" / 100);
                VarDebtCollectorFee := VarDebtCollectorFee + (VarDebtCollectorFee * 0.16);
                exit(VarDebtCollectorFee);
            end;
        end;
    end;


    procedure FnRunGetDepositArrearsPenalty(VarMemberNo: Code[30])
    var
        ObjMember: Record Customer;
        ObjDetailedVendorLedger: Record "Detailed Vendor Ledg. Entry";
        VarCurrMonthEndMonthDate: Date;
        VarCurrMonthBeginDate: Date;
        VarCurrBeginMonthDay: Integer;
        VarCurrMonthMonth: Integer;
        VarCurrMonthYear: Integer;
        VarMonthlyDepositContribution: Decimal;
        VarDateFilter: Text;
        VarTotalDepositsMade: Decimal;
        // ObjDepostPenaltyBuffer: Record "Deposit Arrears Penalty Buffer";
        VarDepositArrearsAmount: Decimal;
        ObjGeneralSetup: Record "Sacco General Set-Up";
        // ObjDepostPenaltyBufferII: Record "Deposit Arrears Penalty Buffer";
        VarEntryNo: Integer;
        ObjMemberLedgerHistorical: Record "Member Historical Ledger Entry";
        VarTotalDepositsMadeHistorical: Decimal;
    begin
        //==========================================Evaluate Dates
        VarCurrMonthEndMonthDate := CalcDate('CM', WorkDate);
        VarCurrBeginMonthDay := 1;
        VarCurrMonthMonth := Date2dmy(WorkDate, 2);
        VarCurrMonthYear := Date2dmy(WorkDate, 3);
        VarCurrMonthBeginDate := Dmy2date(VarCurrBeginMonthDay, VarCurrMonthMonth, VarCurrMonthYear);
        VarDateFilter := Format(VarCurrMonthBeginDate) + '..' + Format(VarCurrMonthEndMonthDate);

        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", VarMemberNo);
        if ObjMember.FindSet then begin
            VarMonthlyDepositContribution := ObjMember."Monthly Contribution";


            ObjMemberLedgerHistorical.Reset;
            ObjMemberLedgerHistorical.SetRange(ObjMemberLedgerHistorical."Account No.", ObjMember."Deposits Account No");
            ObjMemberLedgerHistorical.SetFilter(ObjMemberLedgerHistorical."Posting Date", VarDateFilter);
            if ObjMemberLedgerHistorical.FindSet then begin
                ObjMemberLedgerHistorical.CalcSums(ObjMemberLedgerHistorical."Credit Amount");
                VarTotalDepositsMadeHistorical := ObjMemberLedgerHistorical."Credit Amount";
            end;


            ObjDetailedVendorLedger.Reset;
            ObjDetailedVendorLedger.SetRange(ObjDetailedVendorLedger."Vendor No.", ObjMember."Deposits Account No");
            ObjDetailedVendorLedger.SetFilter(ObjDetailedVendorLedger."Posting Date", VarDateFilter);
            if ObjDetailedVendorLedger.FindSet then begin
                ObjDetailedVendorLedger.CalcSums(ObjDetailedVendorLedger."Credit Amount");
                VarTotalDepositsMade := ObjDetailedVendorLedger."Credit Amount";
            end;

            VarDepositArrearsAmount := VarMonthlyDepositContribution - (VarTotalDepositsMade + VarTotalDepositsMadeHistorical);
            if VarDepositArrearsAmount < 0 then
                VarDepositArrearsAmount := 0;

            ObjGenSetUp.Get();
            // ObjDepostPenaltyBufferII.Reset;
            // ObjDepostPenaltyBufferII.SetCurrentkey(ObjDepostPenaltyBufferII."Entry No.");
            // if ObjDepostPenaltyBufferII.FindLast then
            //   begin
            //     VarEntryNo:=ObjDepostPenaltyBufferII."Entry No.";
            //     end;

            // if VarDepositArrearsAmount>0  then
            //   begin
            // ObjDepostPenaltyBuffer.Init;
            // ObjDepostPenaltyBuffer."Entry No.":=VarEntryNo+1;
            // ObjDepostPenaltyBuffer."Account No.":=ObjMember."Deposits Account No";
            // ObjDepostPenaltyBuffer."Account Type":=ObjDepostPenaltyBuffer."account type"::"BOSA Account";
            // ObjDepostPenaltyBuffer."Member No":=ObjMember."No.";
            // ObjDepostPenaltyBuffer."Member Name":=ObjMember.Name;
            // ObjDepostPenaltyBuffer."Posting Date":=WorkDate;
            // ObjDepostPenaltyBuffer.Description:='Penalty: Deposit Arrears for '+Format(WorkDate,0,'<Month Text,3> <Year4>');
            // ObjDepostPenaltyBuffer."Base Amount":=VarDepositArrearsAmount;
            // ObjDepostPenaltyBuffer."Global Dimension 1 Code":=ObjMember."Global Dimension 1 Code";
            // ObjDepostPenaltyBuffer."Global Dimension 2 Code":=ObjMember."Global Dimension 2 Code";
            // ObjDepostPenaltyBuffer.Amount:=ObjGenSetUp."Penalty On Deposit Arrears";
            // ObjDepostPenaltyBuffer."User ID":=UserId;
            // ObjDepostPenaltyBuffer.Insert;
            // end;
        end;
    end;


    // procedure FnRunCreateDepositArrearsPenaltyJournals(VarAccountNo: Code[30];BATCH_TEMPLATE: Code[20];BATCH_NAME: Code[20];DOCUMENT_NO: Code[20];VarPostingDate: Date;EXTERNAL_DOC_NO: Code[30];RunningBalance: Decimal;var LineNo: Integer) VarRunBal: Decimal
    // var
    //     AmountToDeduct: Decimal;
    //     VarDebtCollectorBaseAmount: Decimal;
    //     VarDebtCollectorFee: Decimal;
    //     ObjDepositArrearsPenalty: Record "Deposit Arrears Penalty Buffer";
    //     VarPenaltyAmount: Decimal;
    //     ObjGensetup: Record "Sacco General Set-Up";
    //     VarTaxonDepositArrears: Decimal;
    //     VarActualPenalty: Decimal;
    //     VarActualTax: Decimal;
    //     ObjDepositArrearsPenaltyII: Record "Deposit Arrears Penalty Buffer";
    //     VarAmountRemaining: Decimal;
    //     VarAmountAllocated: Decimal;
    // begin
    //     //============================================================Deposit Arrrears Penalty
    //     ObjGensetup.Get();

    //     if RunningBalance > 0 then begin
    //     ObjDepositArrearsPenalty.Reset;
    //     ObjDepositArrearsPenalty.SetCurrentkey("Entry No.");
    //     ObjDepositArrearsPenalty.SetRange(ObjDepositArrearsPenalty."Account No.",VarAccountNo);
    //     ObjDepositArrearsPenalty.SetRange(ObjDepositArrearsPenalty.Settled,false);
    //     if ObjDepositArrearsPenalty.Find('-') then
    //       begin
    //           ObjDepositArrearsPenalty.CalcSums(ObjDepositArrearsPenalty.Amount,ObjDepositArrearsPenalty."Settled Amount");
    //           VarPenaltyAmount:=ObjDepositArrearsPenalty.Amount-ObjDepositArrearsPenalty."Settled Amount";
    //           VarTaxonDepositArrears:=VarPenaltyAmount*ObjGensetup."Excise Duty(%)"/100;

    //             if  RunningBalance > 0 then
    //               begin
    //                 if RunningBalance> (VarPenaltyAmount+VarTaxonDepositArrears) then
    //                   begin
    //                     AmountToDeduct:=(VarPenaltyAmount+VarTaxonDepositArrears)
    //                     end else
    //                     AmountToDeduct:=RunningBalance;

    //             VarActualTax:=AmountToDeduct*(ObjGensetup."Excise Duty(%)"/(100+ObjGensetup."Excise Duty(%)"));
    //             VarActualPenalty:=AmountToDeduct-VarActualTax;



    //             //------------------------------------1. Debit Deposit Contribution Account---------------------------------------------------------------------------------------------
    //             LineNo:=LineNo+10000;
    //             FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."transaction type"::"Deposit Contribution",
    //             GenJournalLine."account type"::Vendor,VarAccountNo,WorkDate,VarActualPenalty,'BOSA','',
    //             'BOSA Deposits Penalty','',GenJournalLine."application source"::" ");

    //             LineNo:=LineNo+10000;
    //             FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."transaction type"::" ",
    //             GenJournalLine."account type"::"G/L Account",ObjGensetup."Penalty On Deposit Arrears A/C",WorkDate,VarActualPenalty*-1,'BOSA','',
    //             'BOSA Deposits Penalty from '+VarAccountNo,'',GenJournalLine."recovery transaction type"::"Guarantor Recoverd",'');

    //             //=====================================================================Tax On Penalty Deducted
    //             LineNo:=LineNo+10000;
    //             FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."transaction type"::"Deposit Contribution",
    //             GenJournalLine."account type"::Vendor,VarAccountNo,WorkDate,VarActualTax,'BOSA','',
    //             'Tax: BOSA Deposits Penalty','',GenJournalLine."application source"::" ");

    //             LineNo:=LineNo+10000;
    //             FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."transaction type"::" ",
    //             GenJournalLine."account type"::"G/L Account",ObjGensetup."Excise Duty Account",WorkDate,VarActualTax*-1,'BOSA','',
    //             'Tax: BOSA Deposits Penalty from '+VarAccountNo,'',GenJournalLine."recovery transaction type"::"Guarantor Recoverd",'');




    //      VarAmountRemaining:= VarActualPenalty;
    //     //====================================================Update Settled Amount
    //     ObjDepositArrearsPenaltyII.Reset;
    //     ObjDepositArrearsPenaltyII.SetRange(ObjDepositArrearsPenaltyII."Account No.",VarAccountNo);
    //     ObjDepositArrearsPenaltyII.SetRange(ObjDepositArrearsPenaltyII.Settled,false);
    //     if ObjDepositArrearsPenaltyII.FindSet then
    //       begin
    //         repeat
    //           if VarAmountRemaining>0 then
    //             begin
    //               if VarAmountRemaining>=(ObjDepositArrearsPenaltyII.Amount-ObjDepositArrearsPenaltyII."Settled Amount") then
    //                 begin
    //                   VarAmountAllocated:=(ObjDepositArrearsPenaltyII.Amount-ObjDepositArrearsPenaltyII."Settled Amount");
    //                   ObjDepositArrearsPenaltyII.Settled:=true;
    //                   ObjDepositArrearsPenaltyII."Settled Amount":= ObjDepositArrearsPenaltyII."Settled Amount"+VarAmountAllocated;
    //                   ObjDepositArrearsPenaltyII.Modify;
    //                   end;

    //                      if VarAmountRemaining<(ObjDepositArrearsPenaltyII.Amount-ObjDepositArrearsPenaltyII."Settled Amount") then
    //                        begin
    //                         VarAmountAllocated:=VarAmountRemaining;
    //                         ObjDepositArrearsPenaltyII."Settled Amount":=ObjDepositArrearsPenaltyII."Settled Amount"+VarAmountAllocated;
    //                         ObjDepositArrearsPenaltyII.Modify;
    //                         end;
    //                         VarAmountRemaining:=VarAmountRemaining-VarAmountAllocated;
    //               end;
    //           until ObjDepositArrearsPenaltyII.Next=0;
    //         end;

    //          end;
    //          end;
    //     end;
    // end;


    procedure FnRunCreateDepositTransferJournalsMonthly(VarAccountNo: Code[30]; VarMemberNo: Code[30]) VarRunBal: Decimal
    var
        AmountToDeduct: Decimal;
        VarDebtCollectorBaseAmount: Decimal;
        VarDebtCollectorFee: Decimal;
        //ObjDepositArrearsPenalty: Record "Deposit Arrears Penalty Buffer";
        VarPenaltyAmount: Decimal;
        ObjGensetup: Record "Sacco General Set-Up";
        VarTaxonDepositArrears: Decimal;
        VarActualPenalty: Decimal;
        VarActualTax: Decimal;
        //ObjDepositArrearsPenaltyII: Record "Deposit Arrears Penalty Buffer";
        VarAmountRemaining: Decimal;
        VarAmountAllocated: Decimal;
        ObjAccount: Record Vendor;
        ObjVendors: Record Vendor;
        AvailableBal: Decimal;
        ObjAccTypes: Record "Account Types-Saving Products";
        BATCH_TEMPLATE: Code[20];
        BATCH_NAME: Code[20];
        DOCUMENT_NO: Code[20];
        LineNo: Integer;
        ObjDetailedVendorLedger: Record "Detailed Vendor Ledg. Entry";
        VarCurrentMonthTotalDepositCredits: Decimal;
        VarCurrentMonthBeginDay: Integer;
        VarCurrentMonthMonth: Integer;
        VarCurrentMonthYear: Integer;
        VarDateFilter: Text;
        VarCurrMonthBeginDate: Date;
        VarCurrMonthDepositArrears: Decimal;
        VarExpectedMonthContribution: Decimal;
        VarTotalPenaltyAmount: Decimal;
        VarTotalPenaltySettled: Decimal;
        VarTotalAmounttoRecover: Decimal;
        VarRunningBal: Decimal;
        ObjMemberLedgerHistorical: Record "Member Loans Historical Ledger";
        VarCurrentMonthTotalDepositCreditsHistorical: Decimal;
    begin
        //============================================================Deposit Arrrears Penalty
        ObjGensetup.Get();

        BATCH_TEMPLATE := 'PURCHASES';
        BATCH_NAME := 'FTRANS';
        DOCUMENT_NO := 'REC: ' + Format(WorkDate);

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;

        //================================================================================================Recover Penalty On Deposit Arrears
        // ObjDepositArrearsPenalty.Reset;
        // ObjDepositArrearsPenalty.SetCurrentkey("Entry No.");
        // ObjDepositArrearsPenalty.SetRange(ObjDepositArrearsPenalty."Account No.", VarAccountNo);
        // ObjDepositArrearsPenalty.SetRange(ObjDepositArrearsPenalty.Settled, false);
        // if ObjDepositArrearsPenalty.Find('-') then begin
        //     ObjDepositArrearsPenalty.CalcSums(ObjDepositArrearsPenalty.Amount);
        //     ObjDepositArrearsPenalty.CalcSums(ObjDepositArrearsPenalty."Settled Amount");
        //     VarTotalPenaltyAmount := ObjDepositArrearsPenalty.Amount;
        //     VarTotalPenaltySettled := ObjDepositArrearsPenalty."Settled Amount";
        //     VarPenaltyAmount := VarTotalPenaltyAmount - VarTotalPenaltySettled;
        // end;
        //mjk //===============================================================================================Recover Current Months UnPaid Deposits
        VarCurrentMonthBeginDay := 1;
        VarCurrentMonthMonth := Date2dmy(WorkDate, 2);
        VarCurrentMonthYear := Date2dmy(WorkDate, 3);
        VarCurrMonthBeginDate := Dmy2date(VarCurrentMonthBeginDay, VarCurrentMonthMonth, VarCurrentMonthYear);
        VarDateFilter := Format(VarCurrMonthBeginDate) + '..' + Format(CalcDate('CM', VarCurrMonthBeginDate));

        ObjDetailedVendorLedger.Reset;
        ObjDetailedVendorLedger.SetRange(ObjDetailedVendorLedger."Vendor No.", VarAccountNo);
        ObjDetailedVendorLedger.SetFilter(ObjDetailedVendorLedger."Posting Date", VarDateFilter);
        if ObjDetailedVendorLedger.FindSet then begin
            ObjDetailedVendorLedger.CalcSums(ObjDetailedVendorLedger."Credit Amount");
            VarCurrentMonthTotalDepositCredits := ObjDetailedVendorLedger."Credit Amount";
        end;

        ObjMemberLedgerHistorical.Reset;
        ObjMemberLedgerHistorical.SetRange(ObjMemberLedgerHistorical."Account No.", VarAccountNo);
        ObjMemberLedgerHistorical.SetFilter(ObjMemberLedgerHistorical."Posting Date", VarDateFilter);
        if ObjMemberLedgerHistorical.FindSet then begin
            ObjMemberLedgerHistorical.CalcSums(ObjMemberLedgerHistorical."Credit Amount");
            VarCurrentMonthTotalDepositCreditsHistorical := ObjMemberLedgerHistorical."Credit Amount";
        end;

        if ObjMembers.Get(VarMemberNo) then begin
            VarExpectedMonthContribution := ObjMembers."Monthly Contribution";
        end;
        VarCurrMonthDepositArrears := VarExpectedMonthContribution - (VarCurrentMonthTotalDepositCredits + VarCurrentMonthTotalDepositCreditsHistorical);

        if VarCurrMonthDepositArrears < 0 then
            VarCurrMonthDepositArrears := 0;
        //===============================================================================================End Recover Current Months UnPaid Deposits

        VarTotalAmounttoRecover := VarPenaltyAmount + VarCurrMonthDepositArrears;

        VarRunningBal := VarTotalAmounttoRecover;
        ObjAccount.Reset;
        ObjAccount.SetRange(ObjAccount."BOSA Account No", VarMemberNo);
        ObjAccount.SetFilter(ObjAccount."Account Type", '%1|%2|%3|%4|%5|%6|%7|%8|%9|%10', '401', '402', '403', '404', '405', '406', '501', '508', '509', '507');
        if ObjAccount.FindSet then begin
            repeat
                AmountToDeduct := 0;
                AvailableBal := 0;

                ObjVendors.Reset;
                ObjVendors.SetRange(ObjVendors."No.", ObjAccount."No.");
                if ObjVendors.Find('-') then begin
                    ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques");
                    AvailableBal := (ObjVendors.Balance - ObjVendors."Uncleared Cheques");

                    ObjAccTypes.Reset;
                    ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
                    if ObjAccTypes.Find('-') then
                        AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
                end;



                if (VarRunningBal > 0) and (AvailableBal > 0) then begin

                    if AvailableBal > VarRunningBal then begin
                        AmountToDeduct := VarRunningBal
                    end else
                        AmountToDeduct := AvailableBal;

                    //=================================================================================================Recover From FOSA Credit Deposit Contribution
                    LineNo := LineNo + 10000;
                    FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                    GenJournalLine."account type"::Vendor, VarAccountNo, WorkDate, AmountToDeduct * -1, 'BOSA', '',
                    'BOSA Deposits Transfer ' + Format(WorkDate, 0, '<Month Text,3> <Year4>') + ' from ' + ObjAccount."No.", '', GenJournalLine."application source"::" ");

                    LineNo := LineNo + 10000;
                    FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ObjAccount."No.", WorkDate, AmountToDeduct, 'BOSA', '',
                    'BOSA Deposits Transfer ' + Format(WorkDate, 0, '<Month Text,3> <Year4>'), '', GenJournalLine."recovery transaction type"::"Guarantor Recoverd", '');

                    VarRunningBal := VarRunningBal - AmountToDeduct;
                end;

            until ObjAccount.Next = 0;
        end;


        //CU posting
        // GenJournalLine.Reset;
        // GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        // GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        // if GenJournalLine.Find('-') then
        //   //  Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);

    end;

    local procedure FnRunCreateFOSASharesRecoveryJournals()
    begin
        /*
        VarAmountPosted:=0;
        CALCFIELDS("Current Shares","Shares Retained","Benevolent Fund");
        IF (VarBenfundCurrYearCredits<ObjGensetup."Benevolent Fund Contribution") AND ("Current Shares">0) THEN
          BEGIN
            VarBenfundVariance:=(ObjGensetup."Benevolent Fund Contribution"-VarBenfundCurrYearCredits);
            IF "Current Shares">=VarBenfundVariance THEN BEGIN
            IF "Current Shares">VarBenfundVariance THEN
              BEGIN
                VarAmountPosted:=VarBenfundVariance
                END ELSE
                VarAmountPosted:="Current Shares";
        
        
                    //======================================================================================================1. DEBIT MEMBER DEPOSITS A/C
                    LineNo:=LineNo+10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Deposit Contribution",
                    GenJournalLine."Account Type"::Vendor,"Deposits Account No",WORKDATE,VarAmountPosted,'BOSA','',
                    'Benevolent Fund Contribution to - '+"Benevolent Fund No",'');
        
        
                    //======================================================================================================2. CREDIT MEMBER BENFUND A/C
                    LineNo:=LineNo+10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Benevolent Fund",
                    GenJournalLine."Account Type"::Vendor,"Benevolent Fund No",WORKDATE,VarAmountPosted*-1,'BOSA','',
                    'Benevolent Fund Contribution from - '+"Deposits Account No",'');
        
        
                  //==========================================================================================================3. DEBIT BENFUND A/C
                    LineNo:=LineNo+10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Benevolent Fund",
                    GenJournalLine."Account Type"::Vendor,"Benevolent Fund No",WORKDATE,VarAmountPosted,'BOSA','',
                    'Benevolent Fund Transfer - '+"No.",'');
        
        
                    //=========================================================================================================4. CREDIT BENFUND G/L A/C
                    LineNo:=LineNo+10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Benevolent Fund",
                    GenJournalLine."Account Type"::"G/L Account",ObjGensetup."Benevolent Fund Account",WORKDATE,VarAmountPosted*-1,'BOSA','',
                    'Benevolent Fund Contribution - '+"No.",'');
        
                    //CU posting
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Journal Template Name",'GENERAL');
                    GenJournalLine.SETRANGE("Journal Batch Name",'DEFAULT');
                    IF GenJournalLine.FIND('-') THEN
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Sacco",GenJournalLine);
                      END;
         END;*/
        //=======================================================================================================================END Transfer Benevolent Fund Variance

    end;


    procedure FnRunGetStatementDateFilter(DateFilter: Text) VarNewDate: Date
    var
        myDate: Integer;
        myMonth: Integer;
        myYear: Integer;
        VarBalanceFilterBeginDate: Text;
    begin

        VarBalanceFilterBeginDate := CopyStr(DateFilter, 1, 8);
        Evaluate(myDate, CopyStr(VarBalanceFilterBeginDate, 1, 2));
        Evaluate(myMonth, CopyStr(VarBalanceFilterBeginDate, 4, 2));
        Evaluate(myYear, CopyStr(VarBalanceFilterBeginDate, 7, 4));

        VarNewDate := Dmy2date(myDate, myMonth, myYear + 2000) - 1;
    end;


    procedure FnRunSendSubscribedAccountSMSAlert()
    var
        ObjAccountLedger: Record "Vendor Ledger Entry";
        ObjMemberAccount: Record Vendor;
        ObjAccountSignatories: Record "FOSA Account Sign. Details";
        // CloudPesa: Codeunit "CloudPESA Mobile";
        VarSMSBody: Text;
        AvailableBal: Decimal;
        ObjAccTypes: Record "Account Types-Saving Products";
        ObjSaccoGensetup: Record "Sacco General Set-Up";
        JournalTemplate: Code[30];
        JournalBatch: Code[30];
        DocNo: Code[30];
        LineNo: Integer;
    begin
        // ObjMemberAccount.Reset;
        // ObjMemberAccount.SetFilter(ObjMemberAccount."Transaction Alerts", '<>%1', ObjMemberAccount."transaction alerts"::" ");
        // if ObjMemberAccount.FindSet then begin
        //     repeat
        //         ObjSaccoGensetup.Get;

        //         ObjMemberAccount.CalcFields(ObjMemberAccount."No Of Signatories", ObjMemberAccount.Balance, ObjMemberAccount."Uncleared Cheques");
        //         AvailableBal := (ObjMemberAccount.Balance - ObjMemberAccount."Uncleared Cheques");

        //         ObjAccTypes.Reset;
        //         ObjAccTypes.SetRange(ObjAccTypes.Code, ObjMemberAccount."Account Type");
        //         if ObjAccTypes.Find('-') then
        //             AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";

        //         if AvailableBal >= (ObjSaccoGensetup."SMS Alert Fees") + ((ObjSaccoGensetup."Excise Duty(%)" / 100) * ObjSaccoGensetup."SMS Alert Fees") then begin
        //             //==================================================================================================Credits and ALL
        //             if (ObjMemberAccount."Transaction Alerts" = ObjMemberAccount."transaction alerts"::"All Credit Transactions") or
        //                (ObjMemberAccount."Transaction Alerts" = ObjMemberAccount."transaction alerts"::"All Transactions") then begin

        //                 ObjAccountLedger.CalcFields(ObjAccountLedger."Credit Amount");
        //                 ObjAccountLedger.Reset;
        //                 ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", ObjMemberAccount."No.");
        //                 ObjAccountLedger.SetRange(ObjAccountLedger.Alerted, false);
        //                 ObjAccountLedger.SetFilter(ObjAccountLedger."Credit Amount", '<>%1', 0);
        //                 ObjAccountLedger.SetFilter(ObjAccountLedger.Description, '<>%1&<>%2&<>%3&<>%4&<>%5', '*Fee*', '*Charge*', '*Tax*', '*Excise*', '*Sweep*');
        //                 if ObjAccountLedger.FindSet then begin
        //                     repeat
        //                         ObjAccountLedger.CalcFields(ObjAccountLedger."Credit Amount");
        //                         if ObjMemberAccount."No Of Signatories" = 0 then begin
        //                             VarSMSBody := 'Ksh. ' + Format(ObjAccountLedger."Credit Amount") + ' credited to your Account No. ' + ObjAccountLedger."Vendor No." + ' - ' + ObjAccountLedger.Description + '. RUAI ENDELEA Sacco';
        //                             CloudPesa.SMSMessage(ObjAccountLedger."Document No.", ObjAccountLedger."Vendor No.", ObjMemberAccount."Mobile Phone No", VarSMSBody);
        //                         end else
        //                             ObjAccountSignatories.Reset;
        //                         ObjAccountSignatories.SetRange(ObjAccountSignatories."Account No", ObjMemberAccount."No.");
        //                         ObjAccountSignatories.SetFilter(ObjAccountSignatories."Mobile No", '<>%1', '');
        //                         if ObjAccountSignatories.FindSet then begin
        //                             repeat
        //                                 VarSMSBody := 'Ksh. ' + Format(ObjAccountLedger."Credit Amount") + ' credited to your Account No. ' + ObjAccountLedger."Vendor No." + ' - ' + ObjAccountLedger.Description + '. RUAI ENDELEA Sacco';
        //                                 CloudPesa.SMSMessage(ObjAccountLedger."Document No.", ObjAccountLedger."Vendor No.", ObjMemberAccount."Mobile Phone No", VarSMSBody);
        //                             until ObjAccountSignatories.Next = 0
        //                         end;
        //                         ObjAccountLedger.Alerted := true;
        //                         ObjAccountLedger.Modify;

        //                         //===================================================================================Post SMS FEE
        //                         JournalTemplate := 'GENERAL';
        //                         JournalBatch := 'DEFAULT';
        //                         DocNo := ObjAccountLedger."Document No.";


        //                         FnClearGnlJournalLine(JournalTemplate, JournalBatch);

        //                         //============================================================================================1. Debit SMS FOSA Account
        //                         LineNo := LineNo + 10000;
        //                         FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
        //                         GenJournalLine."account type"::Vendor, ObjAccountLedger."Vendor No.", WorkDate, ObjSaccoGensetup."SMS Alert Fees", 'FOSA', '',
        //                         'Credit Transaction Alert Fee', '', GenJournalLine."application source"::CBS);

        //                         //============================================================================================2. Credit SMS G/L Account
        //                         LineNo := LineNo + 10000;
        //                         FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
        //                         GenJournalLine."account type"::"G/L Account", ObjSaccoGensetup."SMS Alert Fee Account", WorkDate, ObjSaccoGensetup."SMS Alert Fees" * -1, 'FOSA', '',
        //                         'Credit Transaction Alert Fee ' + ObjAccountLedger."Vendor No.", '', GenJournalLine."application source"::CBS);
        //                         //=============================================================================================(Credit SMS G/L Account)

        //                         //===========================================================================================3. Debit SMS TAX FOSA Account
        //                         LineNo := LineNo + 10000;
        //                         FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
        //                         GenJournalLine."account type"::Vendor, ObjAccountLedger."Vendor No.", WorkDate, (ObjSaccoGensetup."SMS Alert Fees" * ObjSaccoGensetup."Excise Duty(%)" / 100), 'FOSA', '',
        //                         'Tax: Credit Transaction Alert Fee', '', GenJournalLine."application source"::CBS);

        //                         //===========================================================================================4. Credit SMS TAX G/L Account
        //                         LineNo := LineNo + 10000;
        //                         FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
        //                         GenJournalLine."account type"::"G/L Account", ObjSaccoGensetup."SMS Alert Fee Account", WorkDate, (ObjSaccoGensetup."SMS Alert Fees" * ObjSaccoGensetup."Excise Duty(%)" / 100) * -1, 'FOSA', '',
        //                         'Tax: Credit Transaction Alert Fee ' + ObjAccountLedger."Vendor No.", '', GenJournalLine."application source"::CBS);
        //                         //===========================================================================================(Credit SMS TAX G/L Account)

        //                         //CU posting
        //                         GenJournalLine.Reset;
        //                         GenJournalLine.SetRange("Journal Template Name", JournalTemplate);
        //                         GenJournalLine.SetRange("Journal Batch Name", JournalBatch);
        //                         if GenJournalLine.Find('-') then
        //                             Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
        //                     until ObjAccountLedger.Next = 0;
        //                 end;
        //             end;

        //             //==================================================================================================Debits and ALL
        //             if (ObjMemberAccount."Transaction Alerts" = ObjMemberAccount."transaction alerts"::"All Debit Transactions") or
        //               (ObjMemberAccount."Transaction Alerts" = ObjMemberAccount."transaction alerts"::"All Transactions") then begin

        //                 ObjAccountLedger.CalcFields(ObjAccountLedger."Debit Amount");
        //                 ObjAccountLedger.Reset;
        //                 ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", ObjMemberAccount."No.");
        //                 ObjAccountLedger.SetRange(ObjAccountLedger.Alerted, false);
        //                 ObjAccountLedger.SetFilter(ObjAccountLedger."Debit Amount", '<>%1', 0);
        //                 ObjAccountLedger.SetFilter(ObjAccountLedger.Description, '<>%1&<>%&<>%3&<>%4&<>%5', '*Fee*', '*Charge*', '*Tax*', '*Excise*', '*Sweep*');
        //                 if ObjAccountLedger.FindSet then begin
        //                     repeat
        //                         ObjAccountLedger.CalcFields(ObjAccountLedger."Credit Amount");
        //                         if ObjMemberAccount."No Of Signatories" = 0 then begin
        //                             VarSMSBody := 'Ksh. ' + Format(ObjAccountLedger."Debit Amount") + ' debited to your Account No. ' + ObjAccountLedger."Vendor No." + ' - ' + ObjAccountLedger.Description + '. RUAI ENDELEA Sacco';
        //                             CloudPesa.SMSMessage(ObjAccountLedger."Document No.", ObjAccountLedger."Vendor No.", ObjMemberAccount."Mobile Phone No", VarSMSBody);
        //                         end else
        //                             ObjAccountSignatories.Reset;
        //                         ObjAccountSignatories.SetRange(ObjAccountSignatories."Account No", ObjMemberAccount."No.");
        //                         ObjAccountSignatories.SetFilter(ObjAccountSignatories."Mobile No", '<>%1', '');
        //                         if ObjAccountSignatories.FindSet then begin
        //                             repeat
        //                                 VarSMSBody := 'Ksh. ' + Format(ObjAccountLedger."Debit Amount") + ' debited to your Account No. ' + ObjAccountLedger."Vendor No." + ' - ' + ObjAccountLedger.Description + '. RUAI ENDELEA Sacco';
        //                                 CloudPesa.SMSMessage(ObjAccountLedger."Document No.", ObjAccountLedger."Vendor No.", ObjMemberAccount."Mobile Phone No", VarSMSBody);
        //                             until ObjAccountSignatories.Next = 0
        //                         end;
        //                         //ObjAccountLedger.Alerted := true;
        //                         ObjAccountLedger.Modify;

        //                         JournalTemplate := 'GENERAL';
        //                         JournalBatch := 'DEFAULT';
        //                         DocNo := ObjAccountLedger."Document No.";


        //                         FnClearGnlJournalLine(JournalTemplate, JournalBatch);

        //                         ObjSaccoGensetup.Get;
        //                         //============================================================================================1. Debit SMS FOSA Account
        //                         LineNo := LineNo + 10000;
        //                         FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
        //                         GenJournalLine."account type"::Vendor, ObjAccountLedger."Vendor No.", WorkDate, ObjSaccoGensetup."SMS Alert Fees", 'FOSA', '',
        //                         'Debit Transaction Alert Fee', '', GenJournalLine."application source"::CBS);

        //                         //============================================================================================2. Credit SMS G/L Account
        //                         LineNo := LineNo + 10000;
        //                         FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
        //                         GenJournalLine."account type"::"G/L Account", ObjSaccoGensetup."SMS Alert Fee Account", WorkDate, ObjSaccoGensetup."SMS Alert Fees" * -1, 'FOSA', '',
        //                         'Debit Transaction Alert Fee ' + ObjAccountLedger."Vendor No.", '', GenJournalLine."application source"::CBS);
        //                         //=============================================================================================(Credit SMS G/L Account)

        //                         //===========================================================================================3. Debit SMS TAX FOSA Account
        //                         LineNo := LineNo + 10000;
        //                         FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
        //                         GenJournalLine."account type"::Vendor, ObjAccountLedger."Vendor No.", WorkDate, (ObjSaccoGensetup."SMS Alert Fees" * ObjSaccoGensetup."Excise Duty(%)" / 100), 'FOSA', '',
        //                         'Tax: Debit Transaction Alert Fee', '', GenJournalLine."application source"::CBS);

        //                         //===========================================================================================4. Credit SMS TAX G/L Account
        //                         LineNo := LineNo + 10000;
        //                         FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
        //                         GenJournalLine."account type"::"G/L Account", ObjSaccoGensetup."SMS Alert Fee Account", WorkDate, (ObjSaccoGensetup."SMS Alert Fees" * ObjSaccoGensetup."Excise Duty(%)" / 100) * -1, 'FOSA', '',
        //                         'Tax: Debit Transaction Alert Fee ' + ObjAccountLedger."Vendor No.", '', GenJournalLine."application source"::CBS);
        //                         //===========================================================================================(Credit SMS TAX G/L Account)

        //                         //CU posting
        //                         // GenJournalLine.Reset;
        //                         // GenJournalLine.SetRange("Journal Template Name", JournalTemplate);
        //                         // GenJournalLine.SetRange("Journal Batch Name", JournalBatch);
        //                         // if GenJournalLine.Find('-') then
        //                         //  Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
        //                     until ObjAccountLedger.Next = 0;
        //                 end;
        //             end;
        //         end;


        //     until ObjMemberAccount.Next = 0;
        // end;

    end;


    procedure FnRunEffectSweepingInstructions()
    var
        ObjSweepingInstructions: Record "Member Sweeping Instructions";
        VarDayofMonth: Integer;
        VarDayofMonthText: Text;
        WeekDay: Text;
        WeekDayOption: Option Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday;
    begin
        //======================================================================================Daily Sweeping
        ObjSweepingInstructions.Reset;
        ObjSweepingInstructions.SetRange(ObjSweepingInstructions.Effected, true);
        ObjSweepingInstructions.SetRange(ObjSweepingInstructions.Stopped, false);
        ObjSweepingInstructions.SetRange(ObjSweepingInstructions."Schedule Frequency", ObjSweepingInstructions."schedule frequency"::Daily);
        if ObjSweepingInstructions.FindSet then begin
            repeat
                FnRunPostSweepingInstruction(ObjSweepingInstructions."Document No");
            until ObjSweepingInstructions.Next = 0;
        end;

        //======================================================================================Weekly Sweeping
        WeekDay := Format(WorkDate, 0, '<Weekday Text>');

        if WeekDay = 'Sunday' then
            WeekDayOption := Weekdayoption::Sunday;
        if WeekDay = 'Monday' then
            WeekDayOption := Weekdayoption::Monday;
        if WeekDay = 'Tuesday' then
            WeekDayOption := Weekdayoption::Tuesday;
        if WeekDay = 'Wednesday' then
            WeekDayOption := Weekdayoption::Wednesday;
        if WeekDay = 'Thursday' then
            WeekDayOption := Weekdayoption::Thursday;
        if WeekDay = 'Friday' then
            WeekDayOption := Weekdayoption::Friday;
        if WeekDay = 'Saturday' then
            WeekDayOption := Weekdayoption::Saturday;

        ObjSweepingInstructions.Reset;
        ObjSweepingInstructions.SetRange(ObjSweepingInstructions.Effected, true);
        ObjSweepingInstructions.SetRange(ObjSweepingInstructions.Stopped, false);
        ObjSweepingInstructions.SetRange(ObjSweepingInstructions."Schedule Frequency", ObjSweepingInstructions."schedule frequency"::Weekly);
        ObjSweepingInstructions.SetRange(ObjSweepingInstructions."Day Of Week", WeekDayOption);
        if ObjSweepingInstructions.FindSet then begin
            repeat
                FnRunPostSweepingInstruction(ObjSweepingInstructions."Document No");
            until ObjSweepingInstructions.Next = 0;
        end;

        //=====================================================================================Monthly Sweeping
        VarDayofMonth := Date2dmy(WorkDate, 1);
        if VarDayofMonth < 10 then begin
            VarDayofMonthText := '*0' + Format(VarDayofMonth) + '*'
        end else
            VarDayofMonthText := '*' + Format(VarDayofMonth) + '*';

        ObjSweepingInstructions.Reset;
        ObjSweepingInstructions.SetRange(ObjSweepingInstructions.Effected, true);
        ObjSweepingInstructions.SetRange(ObjSweepingInstructions.Stopped, false);
        ObjSweepingInstructions.SetRange(ObjSweepingInstructions."Schedule Frequency", ObjSweepingInstructions."schedule frequency"::Monthly);
        ObjSweepingInstructions.SetFilter(ObjSweepingInstructions."Day Of Month", '%1', VarDayofMonthText);
        if ObjSweepingInstructions.FindSet then begin
            repeat
                FnRunPostSweepingInstruction(ObjSweepingInstructions."Document No");
            until ObjSweepingInstructions.Next = 0;
        end;
    end;


    procedure FnRunPostSweepingInstruction(VarDocumentNo: Code[30])
    var
        ObjSweepingInstructions: Record "Member Sweeping Instructions";
        ObjAccount: Record Vendor;
        VarMonitorAvailableBalance: Decimal;
        VarInvestmentAvailableBalance: Decimal;
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
        VarAmounttoTransferMin: Decimal;
        LineNo: Integer;
        JournalTemplate: Code[30];
        JournalBatch: Code[30];
        DocNo: Code[30];
        VarAmounttoTransferMax: Decimal;
    begin
        ObjSweepingInstructions.Reset;
        ObjSweepingInstructions.SetRange(ObjSweepingInstructions."Document No", VarDocumentNo);
        ObjSweepingInstructions.SetRange(ObjSweepingInstructions.Effected, true);
        ObjSweepingInstructions.SetRange(ObjSweepingInstructions.Stopped, false);
        if ObjSweepingInstructions.FindSet then begin
            //==========================================================Get Available Balance Monitor Account
            ObjVendors.Reset;
            ObjVendors.SetRange(ObjVendors."No.", ObjSweepingInstructions."Monitor Account");
            if ObjVendors.Find('-') then begin
                ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques");
                VarMonitorAvailableBalance := (ObjVendors.Balance - ObjVendors."Uncleared Cheques");

                ObjAccTypes.Reset;
                ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
                if ObjAccTypes.Find('-') then
                    VarMonitorAvailableBalance := VarMonitorAvailableBalance - ObjAccTypes."Minimum Balance";
            end;

            //==========================================================Get Available Balance Investment Account
            ObjVendors.Reset;
            ObjVendors.SetRange(ObjVendors."No.", ObjSweepingInstructions."Investment Account");
            if ObjVendors.Find('-') then begin
                ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques");
                VarInvestmentAvailableBalance := (ObjVendors.Balance - ObjVendors."Uncleared Cheques");

                ObjAccTypes.Reset;
                ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
                if ObjAccTypes.Find('-') then
                    VarInvestmentAvailableBalance := VarInvestmentAvailableBalance - ObjAccTypes."Minimum Balance";
            end;

            VarAmounttoTransferMin := (ObjSweepingInstructions."Minimum Account Threshold" - VarMonitorAvailableBalance);


            //=======================================================================================================Minimum Threshold
            if ObjSweepingInstructions."Check Minimum Threshold" = true then begin
                if (VarMonitorAvailableBalance < ObjSweepingInstructions."Minimum Account Threshold") and (VarInvestmentAvailableBalance > 0) then begin
                    if VarInvestmentAvailableBalance < VarAmounttoTransferMin then
                        VarAmounttoTransferMin := VarInvestmentAvailableBalance;

                    JournalTemplate := 'GENERAL';
                    JournalBatch := 'DEFAULT';
                    DocNo := ObjSweepingInstructions."Document No" + '_' + Format(WorkDate);


                    FnClearGnlJournalLine(JournalTemplate, JournalBatch);
                    //============================================================================================1. Debit Investment Account
                    LineNo := LineNo + 10000;
                    FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ObjSweepingInstructions."Investment Account", WorkDate, VarAmounttoTransferMin, 'FOSA', '',
                    'Sweep Instruction Transfer to ' + ObjSweepingInstructions."Monitor Account", '', GenJournalLine."application source"::CBS);

                    //============================================================================================2. Credit Monitor Account
                    LineNo := LineNo + 10000;
                    FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ObjSweepingInstructions."Monitor Account", WorkDate, VarAmounttoTransferMin * -1, 'FOSA', '',
                    'Sweep Instruction Transfer from ' + ObjSweepingInstructions."Investment Account", '', GenJournalLine."application source"::CBS);

                    //CU posting
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", JournalTemplate);
                    GenJournalLine.SetRange("Journal Batch Name", JournalBatch);
                    if GenJournalLine.Find('-') then
                        // Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);

                        ObjSweepingInstructions."Last Execution" := CurrentDatetime;
                end;
            end;


            //=======================================================================================================Maximum Threshold

            if ObjSweepingInstructions."Check Maximum Threshold" = true then begin

                if (VarMonitorAvailableBalance > ObjSweepingInstructions."Maximum Account Threshold") then begin
                    VarAmounttoTransferMax := VarMonitorAvailableBalance - ObjSweepingInstructions."Maximum Account Threshold";

                    JournalTemplate := 'GENERAL';
                    JournalBatch := 'DEFAULT';
                    DocNo := ObjSweepingInstructions."Document No" + '_' + Format(WorkDate);


                    FnClearGnlJournalLine(JournalTemplate, JournalBatch);
                    //============================================================================================1. Debit Monitor Account
                    LineNo := LineNo + 10000;
                    FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ObjSweepingInstructions."Monitor Account", WorkDate, VarAmounttoTransferMax, 'FOSA', '',
                    'Sweep Instruction Transfer to ' + ObjSweepingInstructions."Investment Account", '', GenJournalLine."application source"::CBS);

                    //============================================================================================2. Credit Investment Account
                    LineNo := LineNo + 10000;
                    FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ObjSweepingInstructions."Investment Account", WorkDate, VarAmounttoTransferMax * -1, 'FOSA', '',
                    'Sweep Instruction Transfer from ' + ObjSweepingInstructions."Monitor Account", '', GenJournalLine."application source"::CBS);

                    //CU posting
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", JournalTemplate);
                    GenJournalLine.SetRange("Journal Batch Name", JournalBatch);
                    if GenJournalLine.Find('-') then
                        // Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);

                        ObjSweepingInstructions."Last Execution" := CurrentDatetime;
                end;
            end;
        end;
    end;


    procedure FnRunProcessInterestOnFixedDepositAccount(VarAccountNo: Code[30])
    var
        ObjAccount: Record Vendor;
        ObjAccountType: Record "Account Types-Saving Products";
        VarInterestEarned: Decimal;
        LineNo: Integer;
        JournalTemplate: Code[30];
        JournalBatch: Code[30];
        DocNo: Code[30];
        ObjGenLedgerSetup: Record "General Ledger Setup";
        ObjInterestBuffer: Record "Interest Buffer";
        VarBufferEntryNo: Integer;
    begin
        ObjAccount.CalcFields(ObjAccount.Balance);
        ObjAccount.Reset;
        ObjAccount.SetRange(ObjAccount."No.", VarAccountNo);
        ObjAccount.SetFilter(ObjAccount."Account Type", '%1', '503');
        ObjAccount.SetFilter(ObjAccount.Balance, '>%1', 0);
        if ObjAccount.FindSet then begin
            ObjAccount.CalcFields(ObjAccount.Balance);
            if ObjAccountType.Get(ObjAccount."Account Type") then begin
                VarInterestEarned := ObjAccount.Balance * (ObjAccount."Interest rate" / 100 / 360);

                ObjGenLedgerSetup.Get;


                JournalTemplate := 'GENERAL';
                JournalBatch := 'DEFAULT';
                // DocNo := FnRunGetNextTransactionDocumentNo;

                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", JournalTemplate);
                GenJournalLine.SetRange("Journal Batch Name", JournalBatch);
                if GenJournalLine.Find('-') then begin
                    GenJournalLine.DeleteAll;
                end;

                //============================================================================================1. Debit Expense GL Account
                LineNo := LineNo + 10000;
                FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", ObjAccountType."Interest Expense Account", WorkDate, VarInterestEarned, 'FOSA', '',
                'Fixed Deposit Interest Earned for ' + ObjAccount."No.", '', GenJournalLine."application source"::CBS);

                //============================================================================================2. Credit Payable GL Account
                LineNo := LineNo + 10000;
                FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", ObjAccountType."Interest Payable Account", WorkDate, VarInterestEarned * -1, 'FOSA', '',
                'Fixed Deposit Interest Earned for ' + ObjAccount."No.", '', GenJournalLine."application source"::CBS);

                //CU posting
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", JournalTemplate);
                GenJournalLine.SetRange("Journal Batch Name", JournalBatch);
                if GenJournalLine.Find('-') then
                    // Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);

                    //=============================================================Insert Interest Buffer Entries
                    ObjInterestBuffer.Reset;
                ObjInterestBuffer.SetCurrentkey(ObjInterestBuffer.No);
                if ObjInterestBuffer.FindLast then begin
                    VarBufferEntryNo := ObjInterestBuffer.No + 1;
                end;

                ObjInterestBuffer.Init;
                ObjInterestBuffer.No := VarBufferEntryNo;
                ObjInterestBuffer."Account No" := ObjAccount."No.";
                ObjInterestBuffer."Account Type" := ObjAccount."Account Type";
                ObjInterestBuffer."Interest Date" := WorkDate;
                ObjInterestBuffer."Interest Amount" := VarInterestEarned;
                ObjInterestBuffer."User ID" := UserId;
                if ObjInterestBuffer."Interest Amount" <> 0 then
                    ObjInterestBuffer.Insert(true);
            end;
        end;
    end;


    procedure FnRunPostInterestOnFixedMaturity(VarAccountNo: Code[30])
    var
        ObjAccount: Record Vendor;
        ObjAccountType: Record "Account Types-Saving Products";
        VarInterestEarned: Decimal;
        LineNo: Integer;
        JournalTemplate: Code[30];
        JournalBatch: Code[30];
        DocNo: Code[30];
        ObjGenLedgerSetup: Record "General Ledger Setup";
        ObjInterestBuffer: Record "Interest Buffer";
        VarBufferEntryNo: Integer;
        ObjGenSetup: Record "Sacco General Set-Up";
        VarUntransferedInterest: Decimal;
    begin
        // ObjAccount.CalcFields(ObjAccount.Balance);
        // ObjAccount.Reset;
        // ObjAccount.SetRange(ObjAccount."No.", VarAccountNo);
        // ObjAccount.SetFilter(ObjAccount."Account Type", '%1', '503');
        // ObjAccount.SetFilter(ObjAccount.Balance, '>%1', 0);
        // ObjAccount.SetFilter(ObjAccount."FD Maturity Date", '%1', WorkDate);
        // if ObjAccount.FindSet then begin
        //     ObjGenLedgerSetup.Get;
        //     ObjGenSetup.Get;
        //     JournalTemplate := 'GENERAL';
        //     JournalBatch := 'DEFAULT';
        //     DocNo := FnRunGetNextTransactionDocumentNo;

        //     GenJournalLine.Reset;
        //     GenJournalLine.SetRange("Journal Template Name", JournalTemplate);
        //     GenJournalLine.SetRange("Journal Batch Name", JournalBatch);
        //     if GenJournalLine.Find('-') then begin
        //         GenJournalLine.DeleteAll;
        //     end;

        //     ObjAccount.CalcFields(ObjAccount.Balance, ObjAccount."Untranfered Interest");
        //     VarUntransferedInterest := ObjAccount."Untranfered Interest";
        //     //============================================================================================1. Debit Payable GL Account
        //     LineNo := LineNo + 10000;
        //     FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
        //     GenJournalLine."account type"::"G/L Account", ObjAccountType."Interest Payable Account", WorkDate, ObjAccount."Untranfered Interest",
        //     'FOSA', '', 'Fixed Deposit Interest Transfer to ' + ObjAccount."No.", '', GenJournalLine."application source"::CBS);

        //     //============================================================================================2. Credit Member FD Account
        //     LineNo := LineNo + 10000;
        //     FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
        //     GenJournalLine."account type"::Vendor, ObjAccount."No.", WorkDate, ObjAccount."Untranfered Interest" * -1,
        //     'FOSA', '', 'Fixed Deposit Interest Earned', '', GenJournalLine."application source"::CBS);

        //     //============================================================================================3. Tax: Debit Member FD Account
        //     LineNo := LineNo + 10000;
        //     FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
        //     GenJournalLine."account type"::Vendor, ObjAccount."No.", WorkDate, ObjAccount."Untranfered Interest" * (ObjGenSetup."Withholding Tax (%)" / 100), 'FOSA', '',
        //     'Tax: Fixed Deposit Interest Earned', '', GenJournalLine."application source"::CBS);

        //     //============================================================================================4. Tax:Credit Tax G/L Account
        //     LineNo := LineNo + 10000;
        //     FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::"",
        //     GenJournalLine."account type"::"G/L Account", ObjGenSetup."WithHolding Tax Account", WorkDate,
        //     ObjAccount."Untranfered Interest" * (ObjGenSetup."Withholding Tax (%)" / 100) * -1, 'FOSA', '',
        //     'Tax: Fixed Deposit Interest Earned for ' + ObjAccount."No.", '', GenJournalLine."application source"::CBS);

        //     //CU posting
        //     GenJournalLine.Reset;
        //     GenJournalLine.SetRange("Journal Template Name", JournalTemplate);
        //     GenJournalLine.SetRange("Journal Batch Name", JournalBatch);
        //     if GenJournalLine.Find('-') then
        //         //Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);

        //     //=============================================================Insert Interest Buffer Entries
        //     ObjInterestBuffer.Reset;
        //     ObjInterestBuffer.SetRange(ObjInterestBuffer."Account No", VarAccountNo);
        //     if ObjInterestBuffer.FindSet then begin
        //         repeat
        //             ObjInterestBuffer.Transferred := true;
        //             ObjInterestBuffer.Modify;
        //         until ObjInterestBuffer.Next = 0;
        //     end;

        //     //===============================================================================Pay to FOSA Deposit & Interest
        //     if ObjAccount."On Term Deposit Maturity" = ObjAccount."on term deposit maturity"::"Pay to FOSA Account_ Deposit+Interest" then begin
        //         JournalTemplate := 'GENERAL';
        //         JournalBatch := 'DEFAULT';
        //         DocNo := FnRunGetNextTransactionDocumentNo;

        //         ObjAccount.CalcFields(ObjAccount.Balance);
        //         //=====================================================================1. Debit Member FD Account
        //         LineNo := LineNo + 10000;
        //         FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
        //         GenJournalLine."account type"::Vendor, VarAccountNo, WorkDate, ObjAccount.Balance, 'FOSA', '',
        //         'Fixed Deposit Transfer to ' + ObjAccount."Savings Account No.", '', GenJournalLine."application source"::CBS);

        //         //=====================================================================2. Credit Member FOSA Account
        //         LineNo := LineNo + 10000;
        //         FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
        //         GenJournalLine."account type"::Vendor, ObjAccount."Savings Account No.", WorkDate, ObjAccount.Balance * -1, 'FOSA', '',
        //         'Fixed Deposit Maturity from ' + ObjAccount."No.", '', GenJournalLine."application source"::CBS);

        //         //CU posting
        //         GenJournalLine.Reset;
        //         GenJournalLine.SetRange("Journal Template Name", JournalTemplate);
        //         GenJournalLine.SetRange("Journal Batch Name", JournalBatch);
        //         if GenJournalLine.Find('-') then
        //           //  Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
        //     end;

        //     //===============================================================================Pay to FOSA Deposit & Interest
        //     if ObjAccount."On Term Deposit Maturity" = ObjAccount."on term deposit maturity"::"Roll Back Deposit Only" then begin
        //         JournalTemplate := 'GENERAL';
        //         JournalBatch := 'DEFAULT';
        //         DocNo := FnRunGetNextTransactionDocumentNo;

        //         ObjAccount.CalcFields(ObjAccount.Balance);
        //         //===================================================================1. Debit Member FD Account
        //         LineNo := LineNo + 10000;
        //         FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
        //         GenJournalLine."account type"::Vendor, VarAccountNo, WorkDate, VarUntransferedInterest, 'FOSA', '',
        //         'Fixed Deposit Interest Transfer to ' + ObjAccount."Savings Account No.", '', GenJournalLine."application source"::CBS);

        //         //==================================================================2. Credit Member FOSA Account
        //         LineNo := LineNo + 10000;
        //         FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
        //         GenJournalLine."account type"::Vendor, ObjAccount."Savings Account No.", WorkDate, VarUntransferedInterest * -1, 'FOSA', '',
        //         'Fixed Deposit Interest Earned from ' + ObjAccount."No.", '', GenJournalLine."application source"::CBS);

        //         //CU posting
        //         GenJournalLine.Reset;
        //         GenJournalLine.SetRange("Journal Template Name", JournalTemplate);
        //         GenJournalLine.SetRange("Journal Batch Name", JournalBatch);
        //         if GenJournalLine.Find('-') then
        //          //   Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
        //     end;
        // end;
    end;


    // procedure FnRunGetNextTransactionDocumentNo() VarDocumentNo: Code[30]
    // var
    //     ObjNoSeries: Record "General Ledger Setup";
    // begin
    //     if ObjNoSeries.Get then begin
    //         ObjNoSeries.TestField(ObjNoSeries."Transaction Document No");
    //         VarDocumentNo := NoSeriesMgt.GetNextNo(ObjNoSeries."Transaction Document No", 0D, true);
    //         exit(VarDocumentNo);
    //     end;
    // end;


    procedure FnRunFixedAssetDisposal(VarAssetNo: Code[30]; VarDisposalDate: Date)
    var
        ObjFA: Record "Fixed Asset";
        ObjFADepreciationBook: Record "FA Depreciation Book";
        ObjFAPostingGroup: Record "FA Posting Group";
        FAJournalTemplate: Code[30];
        FAJournalBatch: Code[30];
        DocNo: Code[30];
        LineNo: Integer;
        VarBookValuePreDisposal: Decimal;
        VarDeprValuePreDisposal: Decimal;
        VarBookValueInitialCost: Decimal;
        ObjFADepreciationBookII: Record "FA Depreciation Book";
    begin
        ObjFA.Reset;
        ObjFA.SetRange(ObjFA."No.", VarAssetNo);
        if ObjFA.FindSet then begin
            ObjFADepreciationBook.CalcFields(ObjFADepreciationBook."Book Value");
            ObjFADepreciationBook.Reset;
            ObjFADepreciationBook.SetRange(ObjFADepreciationBook."FA No.", VarAssetNo);
            if ObjFADepreciationBook.FindSet then begin
                // ObjFADepreciationBook.CalcFields(ObjFADepreciationBook."Book Value", ObjFADepreciationBook."Total Depr. Value to Date",
                //  ObjFADepreciationBook."Acquisition Cost", ObjFADepreciationBook."Initial Cost Value");
                // VarBookValuePreDisposal := ObjFADepreciationBook."Book Value";
                // VarDeprValuePreDisposal := ObjFADepreciationBook."Total Depr. Value to Date";
                // VarBookValueInitialCost := ObjFADepreciationBook."Initial Cost Value";

                FAJournalTemplate := 'ASSETS';
                FAJournalBatch := 'DEFAULT';
                //DocNo := FnRunGetNextTransactionDocumentNo;

                FAJournalLine.Reset;
                FAJournalLine.SetRange("Journal Template Name", FAJournalTemplate);
                FAJournalLine.SetRange("Journal Batch Name", FAJournalBatch);
                if FAJournalLine.Find('-') then begin
                    FAJournalLine.DeleteAll;
                end;

                ObjFAPostingGroup.Reset;
                ObjFAPostingGroup.SetRange(ObjFAPostingGroup.Code, ObjFADepreciationBook."FA Posting Group");
                if ObjFAPostingGroup.FindSet then begin

                    //===================================================1. Asset Cumm. Depreciation On Disposal
                    // LineNo := LineNo + 10000;
                    // FnCreateFAGLJournalLineBalanced(FAJournalTemplate, FAJournalBatch, DocNo, LineNo, GenJournalLine."fa posting type"::Depreciation,
                    // GenJournalLine."account type"::"Fixed Asset", VarAssetNo, VarDisposalDate, 'Cost Disposal of ' + VarAssetNo + ' - ' + ObjFA.Description,
                    // GenJournalLine."bal. account type"::"G/L Account", ObjFAPostingGroup."Asset Disposal Account", (ObjFADepreciationBook."Total Depr. Value to Date" * -1), '');

                    // //===================================================2.Asset Cost On Disposal
                    // LineNo := LineNo + 10000;
                    // FnCreateFAGLJournalLineBalanced(FAJournalTemplate, FAJournalBatch, DocNo, LineNo, GenJournalLine."fa posting type"::"Acquisition Cost",
                    // GenJournalLine."account type"::"Fixed Asset", VarAssetNo, VarDisposalDate, 'Cumm. Depr Disposal of ' + VarAssetNo + ' - ' + ObjFA.Description,
                    // GenJournalLine."bal. account type"::"G/L Account", ObjFAPostingGroup."Asset Disposal Account", ObjFADepreciationBook."Acquisition Cost" * -1, '');


                    //CU posting
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", FAJournalTemplate);
                    GenJournalLine.SetRange("Journal Batch Name", FAJournalBatch);
                    if GenJournalLine.Find('-') then
                        // Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);

                        ObjFADepreciationBookII.Reset;
                    ObjFADepreciationBookII.SetRange(ObjFADepreciationBookII."FA No.", VarAssetNo);
                    if ObjFADepreciationBookII.FindSet then begin
                        ObjFADepreciationBookII."Book Value on Disposal" := VarBookValuePreDisposal;
                        ObjFADepreciationBookII."Disposal Date" := VarDisposalDate;
                        // ObjFADepreciationBookII."Disposal Salvage Value" := VarBookValuePreDisposal;
                        // ObjFADepreciationBookII."Disposed/Writtenoff Cost" := VarBookValueInitialCost;
                        // ObjFADepreciationBookII."Disposed/Writtenoff Depr" := VarDeprValuePreDisposal;
                        ObjFADepreciationBookII.Modify;
                    end;
                end;
            end;
        end;
    end;


    procedure FnRunFixedAssetWriteOff(VarAssetNo: Code[30]; VarDisposalDate: Date)
    var
        ObjFA: Record "Fixed Asset";
        ObjFADepreciationBook: Record "FA Depreciation Book";
        ObjFAPostingGroup: Record "FA Posting Group";
        FAJournalTemplate: Code[30];
        FAJournalBatch: Code[30];
        DocNo: Code[30];
        LineNo: Integer;
        VarBookValuePreDisposal: Decimal;
        VarDeprValuePreDisposal: Decimal;
        VarBookValueInitialCost: Decimal;
        ObjFADepreciationBookII: Record "FA Depreciation Book";
    begin
        ObjFA.Reset;
        ObjFA.SetRange(ObjFA."No.", VarAssetNo);
        if ObjFA.FindSet then begin
            ObjFADepreciationBook.CalcFields(ObjFADepreciationBook."Book Value");
            ObjFADepreciationBook.Reset;
            ObjFADepreciationBook.SetRange(ObjFADepreciationBook."FA No.", VarAssetNo);
            if ObjFADepreciationBook.FindSet then begin
                // ObjFADepreciationBook.CalcFields(ObjFADepreciationBook."Book Value", ObjFADepreciationBook."Total Depr. Value to Date",
                //  ObjFADepreciationBook."Acquisition Cost", ObjFADepreciationBook."Initial Cost Value");
                // VarBookValuePreDisposal := ObjFADepreciationBook."Book Value";
                // VarDeprValuePreDisposal := ObjFADepreciationBook."Total Depr. Value to Date";
                // VarBookValueInitialCost := ObjFADepreciationBook."Initial Cost Value";

                FAJournalTemplate := 'ASSETS';
                FAJournalBatch := 'DEFAULT';
                // DocNo := FnRunGetNextTransactionDocumentNo;

                FAJournalLine.Reset;
                FAJournalLine.SetRange("Journal Template Name", FAJournalTemplate);
                FAJournalLine.SetRange("Journal Batch Name", FAJournalBatch);
                if FAJournalLine.Find('-') then begin
                    FAJournalLine.DeleteAll;
                end;

                ObjFAPostingGroup.Reset;
                ObjFAPostingGroup.SetRange(ObjFAPostingGroup.Code, ObjFADepreciationBook."FA Posting Group");
                if ObjFAPostingGroup.FindSet then begin

                    //===================================================1. Asset Cumm. Depreciation On Writeoff
                    // LineNo := LineNo + 10000;
                    // FnCreateFAGLJournalLineBalanced(FAJournalTemplate, FAJournalBatch, DocNo, LineNo, GenJournalLine."fa posting type"::Depreciation,
                    // GenJournalLine."account type"::"Fixed Asset", VarAssetNo, VarDisposalDate, 'Cost Writeoff of ' + VarAssetNo + ' - ' + ObjFA.Description,
                    // GenJournalLine."bal. account type"::"G/L Account", ObjFAPostingGroup."Asset Writeoff Account", (ObjFADepreciationBook."Total Depr. Value to Date" * -1), '');

                    // //===================================================2.Asset Cost On Writeoff
                    // LineNo := LineNo + 10000;
                    // FnCreateFAGLJournalLineBalanced(FAJournalTemplate, FAJournalBatch, DocNo, LineNo, GenJournalLine."fa posting type"::"Acquisition Cost",
                    // GenJournalLine."account type"::"Fixed Asset", VarAssetNo, VarDisposalDate, 'Cumm. Depr Writeoff of ' + VarAssetNo + ' - ' + ObjFA.Description,
                    // GenJournalLine."bal. account type"::"G/L Account", ObjFAPostingGroup."Asset Writeoff Account", ObjFADepreciationBook."Acquisition Cost" * -1, '');


                    //CU posting
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", FAJournalTemplate);
                    GenJournalLine.SetRange("Journal Batch Name", FAJournalBatch);
                    if GenJournalLine.Find('-') then
                        //Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);

                    ObjFADepreciationBookII.Reset;
                    ObjFADepreciationBookII.SetRange(ObjFADepreciationBookII."FA No.", VarAssetNo);
                    if ObjFADepreciationBookII.FindSet then begin
                        ObjFADepreciationBookII."Book Value on Disposal" := VarBookValuePreDisposal;
                        ObjFADepreciationBookII."Disposal Date" := VarDisposalDate;
                        // ObjFADepreciationBookII."Disposal Salvage Value" := VarBookValuePreDisposal;
                        // ObjFADepreciationBookII."Disposed/Writtenoff Cost" := VarBookValueInitialCost;
                        // ObjFADepreciationBookII."Disposed/Writtenoff Depr" := VarDeprValuePreDisposal;
                        ObjFADepreciationBookII.Modify;
                    end;
                end;
            end;
        end;

    end;


    procedure FnCreateFAGLJournalLineBalanced(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; FAPostingType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid"; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Member,Investor; AccountNo: Code[50]; TransactionDate: Date; TransactionDescription: Text; BalancingAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor; BalancingAccountNo: Code[50]; TransactionAmount: Decimal; DimensionActivity: Code[40])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."FA Posting Type" := FAPostingType;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := BalancingAccountType;
        GenJournalLine."Bal. Account No." := BalancingAccountNo;
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;

    procedure FnGetAccountUserBranch(UserAccount: Code[50]) branchCode: Code[20]
    begin
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID", UserAccount);
        if UserSetup.Find('-') then begin
            branchCode := UserSetup."Branch Code";
        end;
        exit(branchCode);
    end;

    procedure FnGetDocumentApprover(DocumentNo: Code[20]): Code[100]
    var
        ApprovedEntries: Record "Posted Approval Entry";
    begin
        ApprovedEntries.Reset();
        ApprovedEntries.SetRange(ApprovedEntries."Document No.", DocumentNo);
        if ApprovedEntries.Find('-') then begin
            exit(ApprovedEntries."Approver ID");
        end;
        exit('Direct Posting');
    end;

    procedure FnGetMemberMobileNumber(FOSAAccountNo: Code[50]): Text
    var
    begin

        ObjVendor.Reset();
        ObjVendor.SetRange(ObjVendor."No.", FOSAAccountNo);
        if ObjVendor.Find('-') then begin
            exit(ObjVendor."Phone No.");
        end;
    end;

    procedure FnGeneratePostedLoansMissingRepaymentSchedule(LoanNumber: Code[50])
    var
        LoansRec: Record "Loans Register";
        RSchedule: Record "Loan Repayment Schedule";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        InitialInstal: Decimal;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        GrPrinciple: Integer;
        GrInterest: Integer;
        RepayCode: Code[50];
        WhichDay: Integer;
        InterestVarianceOnlyNafaka: Decimal;
    begin
        LoansRec.Reset;
        LoansRec.SetRange(LoansRec."Loan  No.", LoanNumber);
        LoansRec.SetFilter(LoansRec."Approved Amount", '>%1', 0);
        LoansRec.SetRange(LoansRec.Posted, true);
        if LoansRec.Find('-') then begin
            if (LoansRec."Repayment Start Date" <> 0D) then begin
                if LoansRec."Loan Disbursement Date" = 0D then begin
                    LoansRec."Loan Disbursement Date" := 20170101D;
                end;
                if LoansRec."Repayment Start Date" = 0D then begin
                    LoansRec."Repayment Start Date" := 20170201D;
                end;
                LoansRec.TestField(LoansRec."Loan Disbursement Date");
                LoansRec.TestField(LoansRec."Repayment Start Date");
                if LoansRec.Interest = 0 then begin
                    LoansRec.Interest := 10;
                end;
                if LoansRec.Installments = 0 then begin
                    LoansRec.Installments := 12;
                end;
                RSchedule.Reset;
                RSchedule.SetRange(RSchedule."Loan No.", LoansRec."Loan  No.");
                if RSchedule.Find('-') = false then begin
                    LoanAmount := LoansRec."Approved Amount";
                    InterestRate := LoansRec.Interest;
                    RepayPeriod := LoansRec.Installments;
                    InitialInstal := LoansRec.Installments + LoansRec."Grace Period - Principle (M)";
                    LBalance := LoansRec."Approved Amount";
                    RunDate := LoansRec."Repayment Start Date";
                    InstalNo := 0;
                    //Repayment Frequency
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                        RunDate := CalcDate('-1D', RunDate)
                    else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                        RunDate := CalcDate('-1W', RunDate)
                    else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                        RunDate := CalcDate('-1M', RunDate)
                    else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then RunDate := CalcDate('-1Q', RunDate);
                    //Repayment Frequency
                    repeat
                        InstalNo := InstalNo + 1;
                        //Repayment Frequency
                        if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                            RunDate := CalcDate('1D', RunDate)
                        else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                            RunDate := CalcDate('1W', RunDate)
                        else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                            RunDate := CalcDate('1M', RunDate)
                        else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then RunDate := CalcDate('1Q', RunDate);
                        if LoansRec."Repayment Method" = LoansRec."repayment method"::Amortised then begin
                            //LoansRec.TESTFIELD(LoansRec.Interest);
                            LoansRec.TestField(LoansRec.Installments);
                            TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                            LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                            LPrincipal := TotalMRepay - LInterest;
                        end;
                        if LoansRec."Repayment Method" = LoansRec."repayment method"::"Straight Line" then begin
                            LoansRec.TestField(LoansRec.Interest);
                            LoansRec.TestField(LoansRec.Installments);
                            LPrincipal := LoanAmount / RepayPeriod;
                            LInterest := (InterestRate / 12 / 100) * LoanAmount / RepayPeriod;
                        end;
                        if LoansRec."Repayment Method" = LoansRec."repayment method"::"Reducing Balance" then begin
                            LoansRec.TestField(LoansRec.Interest);
                            LoansRec.TestField(LoansRec.Installments);
                            LPrincipal := LoanAmount / RepayPeriod;
                            LInterest := (InterestRate / 12 / 100) * LBalance;
                        end;
                        if LoansRec."Repayment Method" = LoansRec."repayment method"::Constants then begin
                            //LoansRec.TestField(LoansRec.Repayment);
                            // if LBalance < LoansRec.Repayment then
                            //     LPrincipal := LBalance
                            // else
                            LPrincipal := LoansRec.Repayment;
                            LInterest := Round((LoansRec."Loan Interest Repayment") / LoansRec.Installments, 0.0001, '>');
                        end;
                        //Grace Period
                        if GrPrinciple > 0 then begin
                            LPrincipal := 0
                        end
                        else begin
                            LBalance := LBalance - LPrincipal;
                        end;
                        GrPrinciple := GrPrinciple - 1;
                        GrInterest := GrInterest - 1;
                        Evaluate(RepayCode, Format(InstalNo));
                        RSchedule.Init;
                        RSchedule."Repayment Code" := RepayCode;
                        RSchedule."Interest Rate" := InterestRate;
                        RSchedule."Loan No." := LoansRec."Loan  No.";
                        RSchedule."Loan Amount" := LoanAmount;
                        RSchedule."Instalment No" := InstalNo;
                        RSchedule."Repayment Date" := CalcDate('CM', RunDate);
                        RSchedule."Member No." := LoansRec."Client Code";
                        RSchedule."Loan Category" := LoansRec."Loan Product Type";
                        RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                        RSchedule."Monthly Interest" := LInterest;
                        RSchedule."Principal Repayment" := LPrincipal;
                        RSchedule.Insert;
                        WhichDay := Date2dwy(RSchedule."Repayment Date", 1);
                    until LBalance < 1
                end;
            end;
        end;
        Commit;
    end;


    // procedure FnGenerateRepaymentSchedule(LoanNumber: Code[50])
    // var
    //     LoansRec: Record "Loans Register";
    //     TotalsInSchedule: Decimal;
    //     LoanAmountSchedule: Decimal;
    //     RSchedule: Record "Loan Repayment Schedule";
    //     LoanAmount: Decimal;
    //     InterestRate: Decimal;
    //     RepayPeriod: Integer;
    //     InitialInstal: Decimal;
    //     LBalance: Decimal;
    //     RunDate: Date;
    //     InstalNo: Decimal;
    //     TotalMRepay: Decimal;
    //     LInterest: Decimal;
    //     LPrincipal: Decimal;
    //     GrPrinciple: Integer;
    //     GrInterest: Integer;
    //     RepayCode: Code[50];
    //     WhichDay: Integer;
    //     InterestVarianceOnlyNafaka: Decimal;
    // begin
    //     LoansRec.Reset;
    //     LoansRec.SetRange(LoansRec."Loan  No.", LoanNumber);
    //     LoansRec.SetFilter(LoansRec."Approved Amount", '>%1', 0);
    //     //LoansRec.SetFilter(LoansRec.Posted, '=%1', false);
    //     if LoansRec.Find('-') then begin
    //         if (LoansRec."Repayment Start Date" <> 0D) then begin
    //             LoansRec.TestField(LoansRec."Loan Disbursement Date");
    //             LoansRec.TestField(LoansRec."Repayment Start Date");
    //             RSchedule.Reset;
    //             RSchedule.SetRange(RSchedule."Loan No.", LoansRec."Loan  No.");
    //             RSchedule.DeleteAll;
    //             LoanAmount := LoansRec."Approved Amount";
    //             InterestRate := LoansRec.Interest;
    //             RepayPeriod := LoansRec.Installments;
    //             InitialInstal := LoansRec.Installments + LoansRec."Grace Period - Principle (M)";
    //             LBalance := LoansRec."Approved Amount";
    //             RunDate := LoansRec."Repayment Start Date";
    //             InstalNo := 0;
    //             //Repayment Frequency
    //             if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
    //                 RunDate := CalcDate('-1D', RunDate)
    //             else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
    //                 RunDate := CalcDate('-1W', RunDate)
    //             else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
    //                 RunDate := CalcDate('-1M', RunDate)
    //             else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
    //                 RunDate := CalcDate('-1Q', RunDate)
    //             ELSE if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Yearly then RunDate := CalcDate('-1Y', RunDate);
    //             //Repayment Frequency
    //             repeat
    //                 InstalNo := InstalNo + 1;
    //                 //Repayment Frequency
    //                 if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
    //                     RunDate := CalcDate('1D', RunDate)
    //                 else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
    //                     RunDate := CalcDate('1W', RunDate)
    //                 else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
    //                     RunDate := CalcDate('1M', RunDate)
    //                 else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
    //                     RunDate := CalcDate('1Q', RunDate)
    //                 ELSE if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Yearly then RunDate := CalcDate('1Y', RunDate);
    //                 if LoansRec."Repayment Method" = LoansRec."repayment method"::Amortised then begin
    //                     LoansRec.TestField(LoansRec.Installments);
    //                     TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
    //                     LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
    //                     LPrincipal := TotalMRepay - LInterest;
    //                 end;
    //                 if LoansRec."Repayment Method" = LoansRec."repayment method"::"Straight Line" then begin
    //                     LoansRec.TestField(LoansRec.Interest);
    //                     LoansRec.TestField(LoansRec.Installments);
    //                     LPrincipal := LoanAmount / RepayPeriod;
    //                     LInterest := (InterestRate / 12 / 100) * LoanAmount / RepayPeriod;
    //                 end;
    //                 if LoansRec."Repayment Method" = LoansRec."repayment method"::"Reducing Balance" then begin
    //                     LoansRec.TestField(LoansRec.Interest);
    //                     LoansRec.TestField(LoansRec.Installments);
    //                     LPrincipal := LoanAmount / RepayPeriod;
    //                     LInterest := (InterestRate / 12 / 100) * LBalance;
    //                 end;
    //                 if LoansRec."Repayment Method" = LoansRec."repayment method"::Constants then begin
    //                     LoansRec.TestField(LoansRec.Repayment);
    //                     LPrincipal := LoansRec.Repayment;
    //                     LInterest := Round((LoansRec."Loan Interest Repayment") / LoansRec.Installments, 0.0001, '>');
    //                 end;
    //                 if LoansRec."Loan Product Type" = 'MOBILE LOAN' then begin
    //                     LInterest := Round((LoansRec."Loan Interest Repayment"), 0.0001, '>');
    //                 end;
    //                 //Grace Period
    //                 if GrPrinciple > 0 then begin
    //                     LPrincipal := 0
    //                 end
    //                 else begin
    //                     LBalance := LBalance - LPrincipal;
    //                 end;
    //                 GrPrinciple := GrPrinciple - 1;
    //                 GrInterest := GrInterest - 1;
    //                 Evaluate(RepayCode, Format(InstalNo));
    //                 RSchedule.Init;
    //                 RSchedule."Repayment Code" := RepayCode;
    //                 RSchedule."Interest Rate" := InterestRate;
    //                 RSchedule."Loan No." := LoansRec."Loan  No.";
    //                 RSchedule."Loan Amount" := LoanAmount;
    //                 RSchedule."Instalment No" := InstalNo;
    //                 RSchedule."Repayment Date" := RunDate;
    //                 //RSchedule."Repayment Date" := CalcDate('CM', RunDate);
    //                 RSchedule."Member No." := LoansRec."Client Code";
    //                 RSchedule."Loan Category" := LoansRec."Loan Product Type";
    //                 RSchedule."Monthly Repayment" := LInterest + LPrincipal;
    //                 RSchedule."Monthly Interest" := LInterest;
    //                 RSchedule."Principal Repayment" := LPrincipal;
    //                 RSchedule.Insert;
    //                 WhichDay := Date2dwy(RSchedule."Repayment Date", 1);
    //             until LBalance < 1;
    //         end;
    //     end;
    //     Commit;
    // end;
}

