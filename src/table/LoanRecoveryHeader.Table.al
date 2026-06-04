#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50550 "Loan Recovery Header"
{

    fields
    {
        field(1; "Document No"; Code[20])
        {

            trigger OnValidate()
            begin
                if "Document No" <> xRec."Document No" then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Loan Recovery Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Member No"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                Clear("Loan to Attach");
                Clear("Deposits Aportioned");
                Clear("Current Shares");
                Clear("Total Outstanding Loans");
                Clear("Loan Liabilities");
                Clear("Loan Distributed to Guarantors");
                Clear("Member Name");
                Clear("FOSA Account No");
                "Global Dimension 2 Code" := SFactory.FnGetUserBranch();
                if Cust.Get("Member No") then begin
                    Cust.CalcFields(Cust."Current Shares", Cust."Shares Retained");
                    "Member Name" := Cust.Name;
                    "FOSA Account No" := Cust."FOSA Account No.";
                    "Personal No" := Cust."Personal No";
                    "Current Shares" := Cust."Current Shares";
                    "Share Capital Balance" := Cust."Shares Retained";
                    "Free Shares" := Cust."Current Shares" - FnCalculateEffectiveGuarantees("Member No");

                    LoanDetails.Reset;
                    LoanDetails.SetRange(LoanDetails."Guarantor Number", "Member No");
                    if LoanDetails.Find('-') then begin
                        LoanDetails."Guarantors Free Shares" := (LoanGuarantors."Deposits variance" - LoanGuarantors."Share capital");

                        if "Loan Liabilities" > 0 then begin
                            "Recovery Difference" := "Free Shares" - "Loan Liabilities";
                            if "Loan Liabilities" < 1 then
                                "Recovery Difference" := 0;
                        end;
                    end;

                    //Clear Existing Lines
                    LoanDetails.Reset;
                    LoanDetails.SetRange(LoanDetails."Document No", "Document No");
                    if LoanDetails.FindSet(true) then begin
                        LoanDetails.DeleteAll;
                    end;


                end;
                FnCalculateTotalOutstandingLoans();
                //VALIDATE("Loan to Attach");
            end;
        }
        field(3; "Member Name"; Code[30])
        {
        }
        field(4; "Application Date"; Date)
        {
        }
        field(7; "Created By"; Code[50])
        {
        }
        field(8; "No. Series"; Code[20])
        {
        }
        field(9; "FOSA Account No"; Code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(10; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(11; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(12; Posted; Boolean)
        {
        }
        field(13; "Posting Date"; Date)
        {
        }
        field(14; "Posted By"; Code[20])
        {
        }
        field(15; "Personal No"; Code[100])
        {
        }
        field(16; "Recovery Type"; Option)
        {
            OptionCaption = ' ,Recover From Loanee Deposits,Attach Defaulted Loans to Guarantors,Attach Defaulted Loans to GuarantorsFOSA,Recover From Guarantors Deposits,Recover Loan From Sell of Share Capital';
            OptionMembers = " ","Recover From Loanee Deposits","Attach Defaulted Loans to Guarantors","Attach Defaulted Loans to GuarantorsFOSA","Recover From Guarantors Deposits","Recover Loan From Sell of Share Capital";

            trigger OnValidate()
            var
                LoanDetails: Record "Loan Member Loans";
            begin
            end;
        }
        field(17; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected,closed';
            OptionMembers = Open,Pending,Approved,Rejected,closed;
        }
        field(18; "Current Shares"; Decimal)
        {
        }
        field(19; "Loan Liabilities"; Decimal)
        {
        }
        field(20; "Loan to Attach"; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("Member No"),
                                                                "Outstanding Balance" = filter(> 0));

            trigger OnValidate()
            var
                TotalInterestDue: Decimal;
                TotalThirdParty: Decimal;
                RunBal: Decimal;
                VarOutstandingPenalty: Decimal;
                VarOutstandingInterest: Decimal;
                VarOutstandingInsurance: Decimal;
            begin

                "Outstanding Interest" := SFactory.FnRunGetLoanPayoffinterest("Loan to Attach");

                "Loan Current PayOff Amount" := SFactory.FnRunGetLoanPayoffRecoveryAmount("Loan to Attach");
                // if Rec."Add Interest" = true then
                //     "Loan Distributed to Guarantors" := "Loan Current PayOff Amount" + "Outstanding Interest" //SFactory.FnRunGetLoanPayoffRecoveryAmount("Loan to Attach");
                // else
                "Loan Distributed to Guarantors" := "Loan Current PayOff Amount";

            end;
        }
        field(21; "Committed Shares"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Amont Guaranteed" where("Member No" = field("Member No")));
            FieldClass = FlowField;
        }
        field(22; "Free Shares"; Decimal)
        {
        }
        field(23; "Recovery Difference"; Decimal)
        {
        }
        field(24; "Interest Repayment"; Decimal)
        {
        }
        field(25; "Principal Repayment"; Decimal)
        {
        }
        field(26; "Loan No"; Code[40])
        {
            NotBlank = true;
            TableRelation = "Loans Guarantee Details"."Loan No";
        }
        field(27; "Amont Guaranteed"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Amont Guaranteed" where("Loan No" = field("Loan to Attach")));
            FieldClass = FlowField;
        }
        field(28; "Guarantor Number"; Code[50])
        {
        }
        field(29; "Repayment Start Date"; Date)
        {
        }
        field(30; "Loan Disbursement Date"; Date)
        {

            trigger OnValidate()
            begin
                "Issued Date" := "Loan Disbursement Date";
                GenSetUp.Get;
                currYear := Date2dmy(Today, 3);
                StartDate := 0D;
                EndDate := 0D;
                Month := Date2dmy("Loan Disbursement Date", 2);
                DAY := Date2dmy("Loan Disbursement Date", 1);
                StartDate := Dmy2date(1, Month, currYear);
                if Month = 12 then begin
                    Month := 0;
                    currYear := currYear + 1;
                end;
                EndDate := Dmy2date(1, Month + 1, currYear) - 1;
                if DAY <= 23 then begin
                    "Repayment Start Date" := CalcDate('CM', "Loan Disbursement Date");
                end else begin
                    "Repayment Start Date" := CalcDate('CM', CalcDate('CM+1M', "Loan Disbursement Date"));
                end;
                "Expected Date of Completion" := CalcDate(Format(Installments) + 'M', "Loan Disbursement Date");
            end;
        }
        field(31; "Loans Generated"; Boolean)
        {
        }
        field(32; "Issued Date"; Date)
        {
        }
        field(33; "Expected Date of Completion"; Date)
        {
        }
        field(34; "Total Interest Due Recovered"; Decimal)
        {
        }
        field(35; "Total Thirdparty Loans"; Decimal)
        {
        }
        field(36; "Deposits Aportioned"; Decimal)
        {
        }
        field(37; "Loan Distributed to Guarantors"; Decimal)
        {
        }
        field(38; "Mobile Loan"; Decimal)
        {
        }
        field(39; "Total Outstanding Loans"; Decimal)
        {
        }
        field(40; "Guarantor Allocation Type"; Option)
        {
            OptionCaption = ' ,Equally Liable,Proportionately Liable';
            OptionMembers = " ","Equally Liable","Proportionately Liable";
        }
        field(41; "Share Capital Transfer Fee"; Decimal)
        {
        }
        field(42; "Share Capital Seller FOSA Acc"; Code[30])
        {
            TableRelation = Vendor."No." where("BOSA Account No" = field("Member No"));

            trigger OnValidate()
            begin
                "Loan Settlement Account" := "Share Capital Seller FOSA Acc";
            end;
        }
        field(43; "Share Capital to Sell"; Decimal)
        {
            CalcFormula = sum("Share Capital Sell".Amount where("Document No" = field("Document No")));
            FieldClass = FlowField;
        }
        field(44; "Share Capital Sold"; Boolean)
        {
        }
        field(45; "Outstanding Insurance"; Decimal)
        {
        }
        field(46; "Outstanding Penalty"; Decimal)
        {
        }
        field(47; "Insurance:Remaining Period"; Decimal)
        {
        }
        field(48; "Charge Insurance"; Boolean)
        {
        }
        field(49; "Insurance Fully Recovered"; Boolean)
        {
        }
        field(50; "Insurance Difference"; Decimal)
        {
        }
        field(51; "Loan Settlement Account"; Code[20])
        {
            TableRelation = Vendor."No." where("BOSA Account No" = field("Member No"),
                                                "Account Type" = filter(507));

            trigger OnValidate()
            begin
                if ObjAccount.Get("Loan Settlement Account") then begin
                    ObjAccount.CalcFields(ObjAccount."Balance (LCY)");
                    "Loan Settlement Account Bal" := ObjAccount."Balance (LCY)";
                end;
            end;
        }
        field(52; "Loan Settlement Account Bal"; Decimal)
        {
        }
        field(53; "Share Capital Balance"; Decimal)
        {
        }
        field(54; "Total Guarantor Allocation"; Decimal)
        {
            CalcFormula = sum("Loan Member Loans"."Guarantor Amount Apportioned" where("Document No" = field("Document No")));
            FieldClass = FlowField;
        }
        field(55; "Loan Current PayOff Amount"; Decimal)
        {
        }
        //"Approved Date"
        field(56; "Approved By"; Code[20])
        {
        }
        field(57; "Approved Date"; Date)
        {
        }
        field(90; "Outstanding Interest"; Decimal)
        {
        }
        field(91; "Add Interest"; Boolean)
        { }
    }

    keys
    {
        key(Key1; "Document No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        ObjGensetup: Record "Sacco General Set-Up";
    begin

        if "Document No" = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Loan Recovery Nos");
            NoSeriesMgt.InitSeries(SalesSetup."Loan Recovery Nos", xRec."No. Series", 0D, "Document No", "No. Series");
        end;

        ObjGensetup.Get();
        "Share Capital Transfer Fee" := ObjGensetup."Share Capital Transfer Fee";
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Cust: Record Customer;
        LoanDetails: Record "Loan Member Loans";
        LoanRec: Record "Loans Register";
        LoanGuarantors: Record "Loans Guarantee Details";
        GenSetUp: Record "Sacco General Set-Up";
        currYear: Integer;
        StartDate: Date;
        EndDate: Date;
        Month: Integer;
        DAY: Integer;
        Installments: Integer;
        TotalDepositsDeducted: Decimal;
        DepositsBalance: Decimal;
        SFactory: Codeunit "Micropoint Factory";
        ObjAccount: Record Vendor;

    local procedure FnCalculateTotalInterestDue(Loans: Record "Loans Register") InterestDue: Decimal
    var
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        "Loan Age": Integer;
    begin
        ObjRepaymentSchedule.Reset;
        ObjRepaymentSchedule.SetRange("Loan No.", Loans."Loan  No.");
        ObjRepaymentSchedule.SetFilter("Repayment Date", '<=%1', "Loan Disbursement Date");
        if ObjRepaymentSchedule.Find('-') then
            "Loan Age" := ObjRepaymentSchedule.Count;
        Loans.CalcFields("Outstanding Balance", "Interest Paid");

        InterestDue := ((0.01 * Loans."Approved Amount" + 0.01 * Loans."Outstanding Balance") * Loans.Interest / 12 * ("Loan Age")) / 2 - Abs(Loans."Interest Paid");
        if (Date2dmy("Loan Disbursement Date", 1) > 15) then begin
            InterestDue := ((0.01 * Loans."Approved Amount" + 0.01 * Loans."Outstanding Balance") * Loans.Interest / 12 * ("Loan Age" + 1)) / 2 - Abs(Loans."Interest Paid");
        end;
        if InterestDue <= 0 then
            exit(0);
        //MESSAGE('Approved=%1 Loan Age=%2 OBalance=%3 InterestPaid=%4 InterestDue=%5',Loans."Approved Amount","Loan Age",Loans."Outstanding Balance",Loans."Interest Paid",InterestDue);
        exit(InterestDue);
    end;

    local procedure FnCalculateTotalThirdpartyLoans(RunningBal: Decimal): Decimal
    var
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        "Loan Age": Integer;
        ObjLoans: Record "Loans Register";
        RecAmount: Decimal;
    begin
        if RunningBal > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetRange("Client Code", "Member No");
            ObjLoans.SetRange("Loan Product Type", 'GUR');
            ObjLoans.SetFilter("Date filter", '..' + Format("Loan Disbursement Date"));
            if ObjLoans.Find('-') then begin
                repeat
                    if RunningBal > 0 then begin
                        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                        if ObjLoans."Outstanding Balance" > 0 then begin
                            RecAmount := ObjLoans."Outstanding Balance" + RecAmount;
                            RunningBal := RunningBal - ObjLoans."Outstanding Balance";
                        end;
                    end;
                until ObjLoans.Next = 0;
            end;
            "Total Thirdparty Loans" := RecAmount;
            exit(RunningBal);
        end;
    end;

    local procedure FnCalculateMobileLoan(RunningBal: Decimal): Decimal
    var
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        "Loan Age": Integer;
        ObjLoans: Record "Loans Register";
        RecAmount: Decimal;
    begin
        if RunningBal > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetRange("BOSA No", "Member No");
            ObjLoans.SetRange("Loan Product Type", 'MSADV');
            ObjLoans.SetFilter("Date filter", '..' + Format("Loan Disbursement Date"));
            if ObjLoans.Find('-') then begin
                repeat
                    if RunningBal > 0 then begin
                        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                        if ObjLoans."Outstanding Balance" > 0 then begin
                            RecAmount := ObjLoans."Outstanding Balance" + RecAmount;
                            RunningBal := RunningBal - ObjLoans."Outstanding Balance";
                        end;
                    end;
                until ObjLoans.Next = 0;
            end;
            "Mobile Loan" := RecAmount;
            exit(RunningBal);
        end;
    end;

    local procedure FnCalculateLoanPrincipalAportionment(LoanAmount: Decimal; DepositsBalance: Decimal)
    var
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        "Loan Age": Integer;
        ObjLoans: Record "Loans Register";
        RecAmount: Decimal;
    begin
        /*ObjLoans.RESET;
        ObjLoans.SETRANGE("BOSA No","Member No");
        ObjLoans.SETFILTER("Date filter",'..'+FORMAT("Loan Disbursement Date"));
        IF ObjLoans.FIND('-') THEN BEGIN
          REPEAT
            ObjLoans.CALCFIELDS(ObjLoans."Outstanding Balance");
            IF ObjLoans."Outstanding Balance" > 0 THEN BEGIN
            RecAmount:=ObjLoans."Outstanding Balance"+RecAmount;
            END;
        UNTIL ObjLoans.NEXT=0;
        END;
        "Deposits Aportioned":=ROUND((LoanAmount/RecAmount)*DepositsBalance,0.05,'>');
        */

    end;

    local procedure FnCalculateTotalOutstandingLoans()
    var
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        "Loan Age": Integer;
        ObjLoans: Record "Loans Register";
        RecAmount: Decimal;
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Client Code", "Member No");
        ObjLoans.SetFilter(ObjLoans."Date filter", '..' + Format("Loan Disbursement Date"));
        if ObjLoans.Find('-') then begin
            repeat
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                if ObjLoans."Outstanding Balance" > 0 then begin
                    RecAmount := ObjLoans."Outstanding Balance" + RecAmount;
                end;
            until ObjLoans.Next = 0;
        end;
        "Total Outstanding Loans" := RecAmount;
    end;

    local procedure FnRunGetInsuranceForPeriodRemaining() VarInsurancePayoff: Decimal
    var
        ObjLoans: Record "Loans Register";
        ObjProductCharge: Record "Loan Product Charges";
        VarEndYear: Date;
        VarInsuranceMonths: Integer;
        VarAmountinArrears: Decimal;
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        VarLoanPayoffAmount: Decimal;
        ObjLoanType: Record "Loan Products Setup";
        VarLoanInsuranceBalAccount: Code[30];
        LineNo: Integer;
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        EXTERNAL_DOC_NO: Code[40];
        SFactory: Codeunit "Micropoint Factory";
        GenJournalLine: Record "Gen. Journal Line";
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", "Loan to Attach");
        if ObjLoans.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance", "Outstanding Interest", "Outstanding Insurance", "Outstanding Penalty");
            if ObjLoans."Outstanding Balance" <> 0 then begin
                VarEndYear := CalcDate('CY', Today);
                VarInsuranceMonths := ROUND((VarEndYear - Today) / 30, 1, '=');

                ObjProductCharge.Reset;
                ObjProductCharge.SetRange(ObjProductCharge."Product Code", ObjLoans."Loan Product Type");
                ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                if ObjProductCharge.FindSet then begin
                    VarInsurancePayoff := ROUND((ObjLoans."Approved Amount" * (ObjProductCharge.Percentage / 100)) * VarInsuranceMonths, 0.05, '>');
                end;

                VarLoanPayoffAmount := ObjLoans."Outstanding Balance" + ObjLoans."Outstanding Interest" + ObjLoans."Outstanding Insurance" + ObjLoans."Outstanding Penalty" + VarInsurancePayoff;
                ObjLoans."Loan Current Payoff Amount" := VarLoanPayoffAmount;
                ObjLoans.Modify;

                //"Outstanding Insurance":=ObjLoans."Outstanding Insurance"+VarInsurancePayoff;


                if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                    VarLoanInsuranceBalAccount := ObjLoanType."Receivable Insurance Accounts";
                end;


                BATCH_TEMPLATE := 'GENERAL';
                BATCH_NAME := 'RECOVERIES';
                DOCUMENT_NO := "Document No";
                EXTERNAL_DOC_NO := "Loan to Attach";

                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                GenJournalLine.DeleteAll;
                //------------------------------------DEBIT INSURANCE FOR THE CURRENT YEAR  A/C---------------------------------------------------------------------------------------------

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Charged",
                GenJournalLine."account type"::Customer, "Member No", "Loan Disbursement Date", 'Loan Insurance:_' + "Document No", GenJournalLine."bal. account type"::"G/L Account",
                VarLoanInsuranceBalAccount, VarInsurancePayoff, 'BOSA', "Loan to Attach");
                //--------------------------------(Credit Loan Penalty Account)-------------------------------------------------------------------------------

                //Post New
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'RECOVERIES');
                if GenJournalLine.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco21", GenJournalLine);
                end;
            end;
        end;
    end;

    local procedure FnCalculateEffectiveGuarantees(MemberNo: Code[20]): Decimal
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
}