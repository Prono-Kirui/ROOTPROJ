#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50799 "Loans Defaulter Aging - SASRA"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Loans Defaulter Aging-SASRA.rdlc';

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            //CalcFields = "Outstanding Balance", "Last Pay Date";
            DataItemTableView = sorting("Loan  No.") where("Outstanding Balance" = filter(> 0), "Loan Product Type" = filter(<> 'RUAIMOBI'));
            RequestFilterFields = Source, "Loan Product Type", "Outstanding Balance", "Date filter", "Account No", "Client Code", "Loan  No.";
            column(ReportForNavId_4645; 4645)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address_2; Company."Address 2")
            {
            }
            column(Company_Phone_No; Company."Phone No.")
            {
            }
            column(Company_Fax_No; Company."Fax No.")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(CompName; CompInfo.Name)
            {
            }
            column(CompAddress; CompInfo.Address)
            {
            }
            column(CompPhone; CompInfo."Phone No.")
            {
            }
            column(CompEmail; CompInfo."E-Mail")
            {
            }
            column(Logo; CompInfo.Picture)
            {
            }
            column(USERID; UserId)
            {
            }
            column(Loans__Loan__No__; "Loan  No.")
            {
            }
            column(Arrears; Arrears)
            {
            }
            column(DaysInArrears_LoansRegister; "Loans Register"."Loan Insurance")
            {
            }
            column(Loans__Loan_Product_Type_; "Loans Register"."Loan Product Type")
            {
            }
            column(Loans_Loans__Staff_No_; "Loans Register"."Staff No")
            {
            }
            column(Loans__Client_Name_; "Client Name")
            {
            }
            column(ClientCode_LoansRegister; "Loans Register"."Client Code")
            {
            }
            column(Loans_Loans__Outstanding_Balance_; "Loans Register"."Outstanding Balance")
            {
            }
            column(V2Month_; "2Month")
            {
            }
            column(V3Month_; "3Month")
            {
            }
            column(Over3Month; Over3Month)
            {
            }
            column(V1Month_; "1Month")
            {
            }
            column(V0Month_; "0Month")
            {
            }
            column(AmountinArrears_LoansRegister; "Loans Register"."Amount in Arrears")
            {
            }
            column(NoofMonthsinArrears_LoansRegister; "Loans Register"."No of Months in Arrears")
            {
            }
            column(Loans_Loans__Outstanding_Balance__Control1000000016; "Loans Register"."Outstanding Balance")
            {
            }
            column(InterestDue_LoansRegister; "Loans Register"."Interest Due")
            {
            }
            column(Loans__Approved_Amount_; "Approved Amount")
            {
            }
            column(Loans_Loans__Interest_Due_; "Loans Register"."Interest Due")
            {
            }
            column(TotalBalance; "Loans Register"."Outstanding Balance" + "Loans Register"."Interest Due")
            {
            }
            column(V1MonthC_; "1MonthC")
            {
            }
            column(V2MonthC_; "2MonthC")
            {
            }
            column(V3MonthC_; "3MonthC")
            {
            }
            column(Over3MonthC; Over3MonthC)
            {
            }
            column(NoLoans; NoLoans)
            {
            }
            column(GrandTotal; GrandTotal)
            {
            }
            column(V0Month__Control1102760031; "0Month")
            {
            }
            column(V1Month__Control1102760032; "1Month")
            {
            }
            column(V2Month__Control1102760033; "2Month")
            {
            }
            column(V3Month__Control1102760034; "3Month")
            {
            }
            column(Over3Month_Control1102760035; Over3Month)
            {
            }
            column(V0MonthC_; "0MonthC")
            {
            }
            column(Loans_Aging_Analysis__SASRA_Caption; Loans_Aging_Analysis__SASRA_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Loans__Loan__No__Caption; FieldCaption("Loan  No."))
            {
            }
            column(Loan_TypeCaption; Loan_TypeCaptionLbl)
            {
            }
            column(Staff_No_Caption; Staff_No_CaptionLbl)
            {
            }
            column(Loans__Client_Name_Caption; FieldCaption("Client Name"))
            {
            }
            column(Oustanding_BalanceCaption; Oustanding_BalanceCaptionLbl)
            {
            }
            column(PerformingCaption; PerformingCaptionLbl)
            {
            }
            column(V1___30_Days_Caption; V1___30_Days_CaptionLbl)
            {
            }
            column(V0_Days_Caption; V0_Days_CaptionLbl)
            {
            }
            column(WatchCaption; WatchCaptionLbl)
            {
            }
            column(V31___180_Days_Caption; V31___180_Days_CaptionLbl)
            {
            }
            column(SubstandardCaption; SubstandardCaptionLbl)
            {
            }
            column(V181___360_Days_Caption; V181___360_Days_CaptionLbl)
            {
            }
            column(DoubtfulCaption; DoubtfulCaptionLbl)
            {
            }
            column(Over_360_DaysCaption; Over_360_DaysCaptionLbl)
            {
            }
            column(LossCaption; LossCaptionLbl)
            {
            }
            column(TotalsCaption; TotalsCaptionLbl)
            {
            }
            column(CountCaption; CountCaptionLbl)
            {
            }
            column(Grand_TotalCaption; Grand_TotalCaptionLbl)
            {
            }
            column(LoanProductType; "Loans Register"."Loan Product Type")
            {
            }
            column(AsAt; AsAt)
            {
            }
            column(OutstandingBalance_LoansRegister; "Loans Register"."Outstanding Balance")
            {
            }
            column(Outstanding_Interest; "Outstanding Interest")
            { }
            column(TotalArrears; TotalArrears) { }

            trigger OnAfterGetRecord()
            begin

                CompletionDate := 0;
                PeriodMonth := 0;
                DaysAfterExpectedDate := 0;
                LBal := 0;
                Arrears := 0;
                "0Month" := 0;
                "1Month" := 0;
                "2Month" := 0;
                "3Month" := 0;
                Over3Month := 0;
                TotalArrears := 0;


                RepaymentPeriod := AsAt;
                //MESSAGE(FORMAT(AsAt));

                CalcFields("Loans Register"."Outstanding Interest");
                if "Loans Register"."Repayment Frequency" = "Loans Register"."repayment frequency"::Monthly then begin
                    if RepaymentPeriod = CalcDate('CM', RepaymentPeriod) then begin
                        LastMonth := RepaymentPeriod;
                    end else begin
                        LastMonth := CalcDate('-1M', RepaymentPeriod);
                    end;
                    LastMonth := CalcDate('CM', LastMonth);
                end;

                DateFilter := '..' + Format(AsAt);
                Loans.Reset;
                Loans.SetRange(Loans."Loan  No.", "Loans Register"."Loan  No.");
                Loans.SetFilter(Loans."Date filter", DateFilter);
                if Loans.Find('-') then begin
                    Loans.CalcFields(Loans."Outstanding Balance", Loans."Scheduled Principal to Date", Loans."Principal Paid", Loans."Schedule Repayments");
                    LBal := Loans."Outstanding Balance";

                end;

                // MESSAGE('Principal=%1 Balance=%2 ExepectedBal=%3 Arrear=%4,ScheduledLoanBal=%5', "Loans Register"."Approved Amount", LBal, ExpectedBalance, Arrears, ScheduledLoanBal);
                ///  Principal=1,200,000 Balance=1,149,512 ExepectedBal=0 Arrear=0,ScheduledLoanBal=0


                ExDate := "Loans Register"."Repayment Start Date";
                if ExDate <> 0D then
                    CompletionDate := ROUND(RepaymentPeriod - ExDate);
                PeriodMonth := ROUND(CompletionDate, 1, '=') / 30;
                DaysAfterExpectedDate := ROUND(PeriodMonth, 1, '=');
                //  MESSAGE('ExDate is %1... CompletionDate %2..  PeriodMonth %3.... DaysAfterExpectedDate is %4 ..RepaymentPeriod is %5', ExDate, CompletionDate, PeriodMonth, DaysAfterExpectedDate, RepaymentPeriod);
                //ExDate is 29/09/25... CompletionDate 93.. PeriodMonth 3.1.... DaysAfterExpectedDate is 3 ..RepaymentPeriod is 31/12/25


                if Cust.Get("Loans Register"."Client Code") then begin
                    PhoneNumber := Cust."Phone No.";
                    MemberDeposits := Cust."Current Shares";
                end;

                // ExpectedBalance := ROUND(DaysAfterExpectedDate * Repayment, 1, '>');
                // MESSAGE('ExpectedBalance is %1,..."Loan Principle Repayment  %2', ExpectedBalance, "Loan Principle Repayment");


                // varApprovedAmount := 0;
                // CustLedgerEntry.Reset;
                // CustLedgerEntry.SetRange(CustLedgerEntry."Customer No.", "Loans Register"."Client Code");
                // CustLedgerEntry.SetRange(CustLedgerEntry."Loan No", "Loans Register"."Loan  No.");
                // if CustLedgerEntry.FindSet() then begin
                //     // repeat
                //     varApprovedAmount := CustLedgerEntry.Amount;
                //     // until CustLedgerEntry.Next() = 0;
                // end;
                // if varApprovedAmount = "Loans Register"."Approved Amount" then
                //     varApprovedAmount := "Loans Register"."Approved Amount"
                // else
                //     varApprovedAmount := varApprovedAmount;

                //     ScheduledLoanBal := varApprovedAmount - ExpectedBalance;
                // //Arrears := ScheduledLoanBal - LBal;
                // Arrears := LBal - ScheduledLoanBal;

                DateFilter := '..' + Format(LastMonth);
                // Message('datefi is %1...last is%2', DateFilter, LastMonth);
                LSchedule.Reset();
                LSchedule.SetRange("Loan No.", "Loan  No.");
                LSchedule.SetCurrentKey("Repayment Date"); // Ensure proper sorting
                                                           // LSchedule.SetFilter("Repayment Date", '..%1', LastMonth); // Up to and including LastMonth
                LSchedule.SetFilter(LSchedule."Repayment Date", DateFilter);
                if LSchedule.FindLast then begin
                    //if LSchedule.Find('-') then begin
                    ScheduledLoanBal := LSchedule."Loan Balance"
                end; // Get the most recent entry

                //Message('ScheduledLoanBal is %1', ScheduledLoanBal);

                // DateFilter := '..' + Format(LastMonth);
                // Loans.Reset;
                // Loans.SetRange(Loans."Loan  No.", "Loan  No.");
                // Loans.SetFilter(Loans."Date filter", DateFilter);
                // if Loans.Find('-') then begin
                //     Loans.CalcFields(Loans."Outstanding Balance");
                //     LBal := Loans."Outstanding Balance";
                // end;

                Arrears := Round((LBal - ScheduledLoanBal), 1, '>');
                // Message('Lbal is %1 ... ScheduledLoanBal is %2 ... Arrears is %3', LBal, ScheduledLoanBal, Arrears);
                //Lbal is 1,149,512 ... ScheduledLoanBal is 1,120,413.6937 ... Arrears is 29,099

                if Arrears <= 0 then
                    Arrears := 0
                else
                    Arrears := Arrears;
                // MESSAGE('Arrears :is %1 ... ScheduledLoanBal  is %2..  LBal is %3', Arrears, ScheduledLoanBal, LBal);
                //MESSAGE('ExpectedBalance is %1',ExpectedBalance);
                // IF Arrears<> 0 THEN BEGIN
                if Loans."Loan Product Type" = 'MOBILE' then
                    "No.ofMonthsinArrears" := ROUND((Arrears / Loans.Repayment) * 30, 1, '>')
                else

                    if Loans."Loan Principle Repayment" > 0 then
                        //"No.ofMonthsinArrears":=ROUND((Arrears/Loans."Loan Principle Repayment")*30,1,'>');
                        if (DaysAfterExpectedDate > "Loans Register".Installments) then
                            "No.ofMonthsinArrears" := 999
                        else
                            "No.ofMonthsinArrears" := (ROUND(Arrears / "Loan Principle Repayment", 0.1, '>')) * 30;

                // MESSAGE('%1',"No.ofMonthsinArrears");
                if Loans."Loan Product Type" = 'FIXED ADV' then
                    "No.ofMonthsinArrears" := 0;
                if Loans."Loan Product Type" = 'MSADV' then begin
                    Numberofdays := AsAt - "Loans Register"."Loan Disbursement Date";
                    if Numberofdays <= 60 then
                        "No.ofMonthsinArrears" := 0;

                    Arrears := 0;
                    "Amount in Arrears" := Arrears;

                    MODIFY;
                end;
                if ((Arrears < 0) or (Arrears = 0)) then begin
                    Arrears := 0
                end else
                    Arrears := Arrears;
                //...
                TotalArrears := Arrears + "Loans Register"."Outstanding Interest";
                "Loans Register"."Amount in Arrears" := Arrears;
                "Loans Register".Modify;
                // Message('Arrears is %1', "Loans Register"."Amount in Arrears");

                //END;
                //"No.ofMonthsinArrears"*30;
                //  MESSAGE('%1 %2 %3', "No.ofMonthsinArrears", Arrears, Loans.Repayment);
                if (("No.ofMonthsinArrears" >= 0) and ("No.ofMonthsinArrears" <= 29)) then begin
                    "Loans Register"."Loans Category" := "Loans Register"."Loans Category"::Perfoming;
                    "Loans Register"."Loans Category-SASRA" := "Loans Register"."Loans Category-SASRA"::Perfoming;
                    //"Loans Register".Modify;
                end else
                    if (("No.ofMonthsinArrears" >= 30) and ("No.ofMonthsinArrears" <= 90)) then begin
                        "Loans Register"."Loans Category-SASRA" := "Loans Register"."Loans Category-SASRA"::Watch;
                        "Loans Register"."Loans Category" := "Loans Register"."Loans Category"::Watch;
                    end else
                        if ("No.ofMonthsinArrears" > 91) and ("No.ofMonthsinArrears" <= 180) then begin
                            "Loans Register"."Loans Category-SASRA" := "Loans Register"."Loans Category-SASRA"::Substandard;
                            "Loans Register"."Loans Category" := "Loans Register"."Loans Category"::Substandard;
                        end else
                            if ("No.ofMonthsinArrears" > 181) and ("No.ofMonthsinArrears" <= 360) then begin
                                "Loans Register"."Loans Category-SASRA" := "Loans Register"."Loans Category-SASRA"::Doubtful;
                                "Loans Register"."Loans Category" := "Loans Register"."Loans Category"::Doubtful;
                            end else
                                if ("No.ofMonthsinArrears" > 360) then begin
                                    "Loans Register"."Loans Category" := "Loans Register"."Loans Category"::Loss;
                                    "Loans Register"."Loans Category-SASRA" := "Loans Register"."Loans Category-SASRA"::Loss;

                                end;
                "No of Months in Arrears" := "No.ofMonthsinArrears";

                "Loans Register"."No of Months in Arrears" := "No.ofMonthsinArrears";
                "Loans Register".Modify;
                CurrReport.CreateTotals("0Month", "1Month", "2Month", "3Month", Over3Month);
                GrandTotal := 0;
                // Company.Get();
                // Company.CalcFields(Company.Picture);








                if "Loans Register"."Loans Category" = "Loans Register"."Loans Category-SASRA"::Perfoming then
                    "0Month" := "Loans Register"."Outstanding Balance"
                //"Loans Register".Modify
                // "0Month":="Loans Register"."Gross outstanding Balance"
                else
                    if "Loans Register"."Loans Category" = "Loans Register"."Loans Category-SASRA"::Watch then
                        "1Month" := "Loans Register"."Outstanding Balance"
                    //"1Month":="Loans Register"."Gross outstanding Balance"
                    else
                        if "Loans Register"."Loans Category" = "Loans Register"."Loans Category-SASRA"::Substandard then
                            "2Month" := "Loans Register"."Outstanding Balance"
                        // "2Month":="Loans Register"."Gross outstanding Balance"
                        else
                            if "Loans Register"."Loans Category" = "Loans Register"."Loans Category-SASRA"::Doubtful then
                                "3Month" := "Loans Register"."Outstanding Balance"
                            //"3Month":="Loans Register"."Gross outstanding Balance"
                            else
                                if "Loans Register"."Loans Category" = "Loans Register"."Loans Category-SASRA"::Loss then
                                    Over3Month := "Loans Register"."Outstanding Balance";
                // Over3Month:="Loans Register"."Gross outstanding Balance";
                "Loans Register".Modify;
                GrandTotal := GrandTotal + "Loans Register"."Outstanding Balance";
                //GrandTotal:=GrandTotal+"Loans Register"."Gross outstanding Balance";
                if ("1Month" + "2Month" + "3Month" + Over3Month) > 0 then
                    NoLoans := NoLoans + 1;

            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CreateTotals("0Month", "1Month", "2Month", "3Month", Over3Month);
                GrandTotal := 0;
                Company.Get();
                Company.CalcFields(Company.Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("As At"; AsAt)
                {
                    ApplicationArea = Basic;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompInfo.Get();
        CompInfo.CalcFields(Picture);
    end;

    var
        TotalArrears: Decimal;
        varApprovedAmount: Decimal;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        PeriodMonth: Decimal;
        "1Month": Decimal;
        "2Month": Decimal;
        "3Month": Decimal;
        Over3Month: Decimal;
        ShowLoan: Boolean;
        AsAt: Date;
        LastDueDate: Date;
        DFormula: DateFormula;
        "0MonthC": Integer;
        "1MonthC": Integer;
        "2MonthC": Integer;
        "3MonthC": Integer;
        Over3MonthC: Integer;
        NoLoans: Integer;
        PhoneNo: Text[30];
        Cust: Record Customer;
        "StaffNo.": Text[30];
        Deposits: Decimal;
        GrandTotal: Decimal;
        "0Month": Decimal;
        LoanProduct: Record "Loan Products Setup";
        FirstMonthDate: Date;
        EndMonthDate: Date;
        Loans_Aging_Analysis__SASRA_CaptionLbl: label 'Loans Aging Analysis (SASRA)';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Loan_TypeCaptionLbl: label 'Loan Type';
        Staff_No_CaptionLbl: label 'Staff No.';
        Oustanding_BalanceCaptionLbl: label 'Oustanding Balance';
        PerformingCaptionLbl: label 'Performing';
        V1___30_Days_CaptionLbl: label '(1 - 30 Days)';
        V0_Days_CaptionLbl: label '(0 Days)';
        WatchCaptionLbl: label 'Watch';
        V31___180_Days_CaptionLbl: label '(31 - 180 Days)';
        SubstandardCaptionLbl: label 'Substandard';
        V181___360_Days_CaptionLbl: label '(181 - 360 Days)';
        DoubtfulCaptionLbl: label 'Doubtful';
        Over_360_DaysCaptionLbl: label 'Over 360 Days';
        LossCaptionLbl: label 'Loss';
        TotalsCaptionLbl: label 'Totals';
        CountCaptionLbl: label 'Count';
        Grand_TotalCaptionLbl: label 'Grand Total';
        "0Day": Decimal;
        "1Day": Decimal;
        "2Day": Decimal;
        "3Day": Decimal;
        Over3Day: Decimal;
        LSchedule: Record "Loan Repayment Schedule";
        RepaymentPeriod: Date;
        Loans: Record "Loans Register";
        LastMonth: Date;
        ScheduledLoanBal: Decimal;
        DateFilter: Text;
        LBal: Decimal;
        Arrears: Decimal;
        "No.ofMonthsinArrears": Integer;
        Company: Record "Company Information";
        SFactory: Codeunit "Micropoint Factory";
        ExpectedBalance: Decimal;
        Numberofdays: Integer;
        CompInfo: Record "Company Information";
        ExDate: Date;
        CompletionDate: Decimal;
        DaysAfterExpectedDate: Decimal;
        DaysInArrears: Decimal;
        PhoneNumber: Code[20];
        MemberDeposits: Decimal;
}

