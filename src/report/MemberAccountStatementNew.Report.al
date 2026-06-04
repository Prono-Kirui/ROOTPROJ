#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50136 "Member Account Statement-New"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Member Account Statement-New.rdlc';

    dataset
    {
        dataitem("Members Register"; customer)
        {
            RequestFilterFields = "No.", "Loan Product Filter", "Outstanding Balance", "Date Filter", "Loan No. Filter";
            column(ReportForNavId_1102755000; 1102755000)
            {
            }
            column(USERID; UserId)
            {
            }
            column(PayrollStaffNo_Members; "Members Register"."Personal No")
            {
            }
            column(No_Members; "Members Register"."No.")
            {
            }
            column(Name_Members; "Members Register".Name)
            {
            }
            column(EmployerCode_Members; "Members Register"."Employer Code")
            {
            }
            column(EmployerName; EmployerName)
            {
            }
            column(PageNo_Members; CurrReport.PageNo)
            {
            }
            column(Shares_Retained; "Members Register"."Shares Retained")
            {
            }
            column(ShareCapBF; ShareCapBF)
            {
            }
            column(IDNo_Members; "Members Register"."ID No.")
            {
            }
            column(GlobalDimension2Code_Members; "Members Register"."Global Dimension 2 Code")
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            dataitem(Shares; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Transaction Type", "Loan No", "Posting Date") where("Transaction Type" = const("Share Capital"), Reversed = filter(false));
                column(ReportForNavId_1102755022; 1102755022)
                {
                }
                column(openBalances; OpenBalance)
                {
                }
                column(CLosingBalances; CLosingBalance)
                {
                }
                column(Description_Shares; Shares.Description)
                {
                }
                column(DocumentNo_Shares; Shares."Document No.")
                {
                }
                column(PostingDate_Shares; Shares."Posting Date")
                {
                }
                column(CreditAmount_Shares; CreditAmount)
                {
                }
                column(DebitAmount_Shares; DebitAmount)
                {
                }
                column(Amount_Shares; Shares."Amount Posted")
                {
                }
                column(TransactionType_Shares; Shares."Transaction Type")
                {
                }
                column(Shares_Description; Shares.Description)
                {
                }
                column(USER1; Shares."User ID")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CreditAmount := 0;
                    DebitAmount := 0;
                    CLosingBalance := CLosingBalance - Shares."Amount Posted";
                    if Shares."Amount Posted" < 0 then begin
                        CreditAmount := (Shares."Amount Posted") * -1;
                    end else
                        if Shares."Amount Posted" > 0 then begin
                            DebitAmount := Shares."Amount Posted";
                        end;
                end;

                trigger OnPreDataItem()
                begin
                    CLosingBalance := ShareCapBF;
                    OpeningBal := ShareCapBF * -1;
                end;
            }
            dataitem(Deposits; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Transaction Type", "Loan No", "Posting Date") where("Transaction Type" = const("Deposit Contribution"), Reversed = filter(false));
                PrintOnlyIfDetail = false;
                column(ReportForNavId_1102755004; 1102755004)
                {
                }
                column(OpeningBal; OpeningBal)
                {
                }
                column(ClosingBal; ClosingBal)
                {
                }
                column(TransactionType_Deposits; Deposits."Transaction Type")
                {
                }
                column(Amount_Deposits; Deposits."Amount Posted")
                {
                }
                column(Description_Deposits; Deposits.Description)
                {
                }
                column(DocumentNo_Deposits; Deposits."Document No.")
                {
                }
                column(PostingDate_Deposits; Deposits."Posting Date")
                {
                }
                column(DebitAmount_Deposits; DebitAmount)
                {
                }
                column(CreditAmount_Deposits; CreditAmount)
                {
                }
                column(Deposits_Description; Deposits.Description)
                {
                }
                column(USER2; Deposits."User ID")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    CreditAmount := 0;
                    DebitAmount := 0;
                    ClosingBal := ClosingBal + Deposits."Amount Posted";
                    if Deposits."Amount Posted" < 0 then begin
                        CreditAmount := (Deposits."Amount Posted") * -1;
                    end else
                        if Deposits."Amount Posted" > 0 then begin
                            DebitAmount := Deposits."Amount Posted";
                        end;
                end;

                trigger OnPreDataItem()
                begin
                    ClosingBal := SharesBF;
                    OpeningBal := SharesBF * -1;
                end;
            }
            dataitem(Dividend; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Transaction Type", "Loan No", "Posting Date") where("Transaction Type" = const(Dividend));
                column(ReportForNavId_1102755055; 1102755055)
                {
                }
                column(OpenBalancesDividend; OpenBalanceDividend)
                {
                }
                column(CLosingBalancesDividend; ClosingBalanceDividend)
                {
                }
                column(Description_Dividend; Dividend.Description)
                {
                }
                column(DocumentNo_Dividend; Dividend."Document No.")
                {
                }
                column(PostingDate_Dividend; Dividend."Posting Date")
                {
                }
                column(CreditAmount_Dividend; DebitAmount)
                {
                }
                column(DebitAmount_Dividend; CreditAmount)
                {
                }
                column(Amount_Dividend; Dividend."Amount Posted")
                {
                }
                column(TransactionType_Dividend; Dividend."Transaction Type")
                {
                }
                column(USER3; Dividend."User ID")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CreditAmount := 0;
                    DebitAmount := 0;
                    ClosingBalanceDividend := ClosingBalanceDividend - Dividend."Amount Posted";
                    if Dividend."Amount Posted" < 0 then begin
                        CreditAmount := (Dividend."Amount Posted") * -1;
                    end else
                        if Dividend."Amount Posted" > 0 then begin
                            DebitAmount := Dividend."Amount Posted";
                        end;
                end;

                trigger OnPreDataItem()
                begin
                    ClosingBalanceDividend := DividendBF;
                    OpenBalanceDividend := DividendBF * -1;
                end;
            }
            dataitem(Holiday_Savers; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Transaction Type", "Loan No", "Posting Date") where("Transaction Type" = const(Withdrawal), Reversed = filter(false));
                column(ReportForNavId_1000000026; 1000000026)
                {
                }
                column(OpenBalancesHoliday; OpenBalanceHoliday)
                {
                }
                column(CLosingBalancesHoliday; ClosingBalanceHoliday)
                {
                }
                column(DescriptionHoliday; Holiday_Savers.Description)
                {
                }
                column(DocumentNoHoliday; Holiday_Savers."Document No.")
                {
                }
                column(PostingDateHoliday; Holiday_Savers."Posting Date")
                {
                }
                column(CreditAmountHoliday; CreditAmount)
                {
                }
                column(DebitAmountHoliday; DebitAmount)
                {
                }
                column(AmountHoliday; Holiday_Savers."Amount Posted")
                {
                }
                column(TransactionTypeHoliday; Holiday_Savers."Transaction Type")
                {
                }
                column(User4; Holiday_Savers."User ID")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CreditAmount := 0;
                    DebitAmount := 0;
                    CLosingBalanceHse := CLosingBalanceHse - Holiday_Savers."Amount Posted";
                    if Holiday_Savers."Amount Posted" < 0 then begin
                        CreditAmount := (Holiday_Savers."Amount Posted") * -1;
                    end else
                        if Holiday_Savers."Amount Posted" > 0 then begin
                            DebitAmount := Holiday_Savers."Amount Posted";
                        end;
                end;

                trigger OnPreDataItem()
                begin
                    CLosingBalanceHse := Dep1BF;
                    OpenBalanceHse := Dep1BF * -1;
                end;
            }
            dataitem(Risk; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Transaction Type", "Loan No", "Posting Date") where("Transaction Type" = filter("Benevolent Fund"));
                column(ReportForNavId_1000000036; 1000000036)
                {
                }
                column(OpenBalancesRisk; OpenBalanceRisk)
                {
                }
                column(CLosingBalancesRisk; CLosingBalanceRisk)
                {
                }
                column(DescriptionRisk; Risk.Description)
                {
                }
                column(DocumentNoRisk; Risk."Document No.")
                {
                }
                column(PostingDateRisk; Risk."Posting Date")
                {
                }
                column(CreditAmountRisk; CreditAmount)
                {
                }
                column(DebitAmountRisk; DebitAmount)
                {
                }
                column(AmountRisk; Risk."Amount Posted")
                {
                }
                column(TransactionTypeRisk; Risk."Transaction Type")
                {
                }
                column(User5; Risk."User ID")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CreditAmount := 0;
                    DebitAmount := 0;
                    CLosingBalanceRisk := CLosingBalanceRisk - Risk."Amount Posted";
                    if Risk."Amount Posted" < 0 then begin
                        CreditAmount := (Risk."Amount Posted") * -1;
                    end else
                        if Risk."Amount Posted" > 0 then begin
                            DebitAmount := Risk."Amount Posted";
                        end;
                end;

                trigger OnPreDataItem()
                begin
                    CLosingBalanceRisk := RiskBF;
                    OpenBalanceRisk := RiskBF * -1;
                end;
            }
            dataitem(Loans; "Loans Register")
            {
                DataItemLink = "Client Code" = field("No."), "Loan Product Type" = field("Loan Product Filter"), "Date filter" = field("Date Filter");
                DataItemTableView = sorting("Loan  No.") where(Posted = const(true), "Loan  No." = filter(<> '"'));
                column(ReportForNavId_1102755024; 1102755024)
                {
                }
                column(PrincipleBF; PrincipleBF)
                {
                }
                column(LoanNumber; Loans."Loan  No.")
                {
                }
                column(ProductType; LoanName)
                {
                }
                column(RequestedAmount; Loans."Requested Amount")
                {
                }
                column(Interest; Loans.Interest)
                {
                }
                column(Installments; Loans.Installments)
                {
                }
                column(LoanPrincipleRepayment; Loans."Loan Principle Repayment")
                {
                }
                column(ApprovedAmount_Loans; Loans."Approved Amount")
                {
                }
                column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
                {
                }
                column(Repayment_Loans; Loans.Repayment)
                {
                }
                column(ModeofDisbursement_Loans; Loans."Mode of Disbursement")
                {
                }
                dataitem(loan; "Cust. Ledger Entry")
                {
                    DataItemLink = "Customer No." = field("Client Code"), "Loan No" = field("Loan  No."), "Posting Date" = field("Date filter");
                    DataItemTableView = sorting("Posting Date") where("Transaction Type" = filter(Loan | "Loan Repayment"), "Loan No" = filter(<> ''), Description = filter(<> 'Interest on salary advance'), Reversed = filter(false));
                    column(ReportForNavId_1102755031; 1102755031)
                    {
                    }
                    column(PostingDate_loan; loan."Posting Date")
                    {
                    }
                    column(DocumentNo_loan; loan."Document No.")
                    {
                    }
                    column(Description_loan; loan.Description)
                    {
                    }
                    column(DebitAmount_Loan; loan."Debit Amount")
                    {
                    }
                    column(CreditAmount_Loan; loan."Credit Amount")
                    {
                    }
                    column(Amount_Loan; loan."Amount Posted")
                    {
                    }
                    column(openBalance_loan; OpenBalance)
                    {
                    }
                    column(CLosingBalance_loan; CLosingBalance)
                    {
                    }
                    column(TransactionType_loan; loan."Transaction Type")
                    {
                    }
                    column(LoanNo; loan."Loan No")
                    {
                    }
                    column(PrincipleBF_loans; PrincipleBF)
                    {
                    }
                    column(Loan_Description; loan.Description)
                    {
                    }
                    column(User7; loan."User ID")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        /*CLosingBalance:=CLosingBalance+loan."Amount Posted";
                        ClosingBalInt:=ClosingBalInt+loan."Amount Posted";
                        
                        //interest
                        ClosingBal:=ClosingBal+LoanInterest."Amount Posted";
                        OpeningBal:=ClosingBal-LoanInterest."Amount Posted";
                        */
                        CLosingBalance := CLosingBalance + loan."Amount Posted";
                        if Loans."Loan  No." = '' then begin
                        end;

                        if loan."Transaction Type" = loan."transaction type"::"Interest Paid" then begin
                            InterestPaid := loan."Credit Amount";
                            SumInterestPaid := InterestPaid + SumInterestPaid;
                        end;
                        if loan."Transaction Type" = loan."transaction type"::"Loan Repayment" then begin
                            loan."Credit Amount" := loan."Credit Amount"//+InterestPaid;
                        end;

                    end;

                    trigger OnPreDataItem()
                    begin
                        CLosingBalance := PrincipleBF;
                        OpeningBal := PrincipleBF;
                    end;
                }
                dataitem(Interest; "Cust. Ledger Entry")
                {
                    DataItemLink = "Customer No." = field("Client Code"), "Loan No" = field("Loan  No."), "Posting Date" = field("Date filter");
                    DataItemTableView = sorting("Transaction Type", "Loan No", "Posting Date") where("Transaction Type" = filter("Interest Due" | "Interest Paid"), "Loan No" = filter(<> ''), Description = filter(<> 'Interest on salary advance'));
                    column(ReportForNavId_1102755077; 1102755077)
                    {
                    }
                    column(PostingDate_Interest; Interest."Posting Date")
                    {
                    }
                    column(DocumentNo_Interest; Interest."Document No.")
                    {
                    }
                    column(Description_Interest; Interest.Description)
                    {
                    }
                    column(DebitAmount_Interest; Interest."Debit Amount")
                    {
                    }
                    column(CreditAmount_Interest; Interest."Credit Amount")
                    {
                    }
                    column(Amount_Interest; Interest."Amount Posted")
                    {
                    }
                    column(OpeningBalInt; OpeningBalInt)
                    {
                    }
                    column(ClosingBalInt; ClosingBalInt)
                    {
                    }
                    column(TransactionType_Interest; Interest."Transaction Type")
                    {
                    }
                    column(LoanNo_Interest; Interest."Loan No")
                    {
                    }
                    column(InterestBF; InterestBF)
                    {
                    }
                    column(User8; Interest."User ID")
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                        //Loans.SETFILTER(Loans."Loan  No.","Members Register".GETFILTER("Members Register"."Loan No. Filter"));
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    if LoanSetup.Get(Loans."Loan Product Type") then
                        LoanName := LoanSetup."Product Description";
                    if DateFilterBF <> '' then begin
                        LoansR.Reset;
                        LoansR.SetRange(LoansR."Loan  No.", "Loan  No.");
                        LoansR.SetFilter(LoansR."Date filter", DateFilterBF);
                        if LoansR.Find('-') then begin
                            LoansR.CalcFields(LoansR."Outstanding Balance");
                            PrincipleBF := LoansR."Outstanding Balance";
                            //InterestBF:=LoansR."Interest Paid";
                        end;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    Loans.SetFilter(Loans."Date filter", "Members Register".GetFilter("Members Register"."Date Filter"));
                    //Loans.SETFILTER(Loans."Loan  No.","Members Register".GETFILTER("Members Register"."Loan No. Filter"));
                end;
            }
            dataitem("Loans Guarantee Details"; "Loans Guarantee Details")
            {
                DataItemLink = "Member No" = field("No.");
                column(ReportForNavId_1000000042; 1000000042)
                {
                }
                column(LoanNumb; "Loans Guarantee Details"."Loan No")
                {
                }
                column(MembersNo; "Loans Guarantee Details"."Member No")
                {
                }
                column(Name; "Loans Guarantee Details".Name)
                {
                }
                column(LBalance; "Loans Guarantee Details"."Loan Balance")
                {
                }
                column(Shares; "Loans Guarantee Details".Shares)
                {
                }
                column(LoansGuaranteed; "Loans Guarantee Details"."No Of Loans Guaranteed")
                {
                }
                column(Substituted; "Loans Guarantee Details".Substituted)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                SaccoEmp.Reset;
                SaccoEmp.SetRange(SaccoEmp.Code, "Members Register"."Employer Code");
                if SaccoEmp.Find('-') then
                    EmployerName := SaccoEmp.Description;

                SharesBF := 0;
                InsuranceBF := 0;
                ShareCapBF := 0;
                RiskBF := 0;
                HseBF := 0;
                Dep1BF := 0;
                Dep2BF := 0;
                if DateFilterBF <> '' then begin
                    Cust.Reset;
                    Cust.SetRange(Cust."No.", "No.");
                    Cust.SetFilter(Cust."Date Filter", DateFilterBF);
                    if Cust.Find('-') then begin
                        Cust.CalcFields(Cust."Shares Retained", Cust."Current Shares", Cust."Insurance Fund");
                        SharesBF := Cust."Current Shares";
                        ShareCapBF := Cust."Shares Retained";
                        RiskBF := Cust."Insurance Fund";
                        //XmasBF:=Cust."Holiday Savings";
                        //HseBF:=Cust."Household Item Deposit";
                        //Dep1BF:=Cust."Dependant 1";
                        //Dep2BF:=Cust."Dependant 2";
                    end;
                end;
            end;

            trigger OnPreDataItem()
            begin

                if "Members Register".GetFilter("Members Register"."Date Filter") <> '' then
                    DateFilterBF := '..' + Format(CalcDate('-1D', "Members Register".GetRangeMin("Members Register"."Date Filter")));
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        Company.Get();
        Company.CalcFields(Company.Picture);
    end;

    var
        OpenBalance: Decimal;
        CLosingBalance: Decimal;
        OpenBalanceXmas: Decimal;
        CLosingBalanceXmas: Decimal;
        Cust: Record Customer;
        OpeningBal: Decimal;
        ClosingBal: Decimal;
        FirstRec: Boolean;
        PrevBal: Integer;
        BalBF: Decimal;
        LoansR: Record "Loans Register";
        DateFilterBF: Text[150];
        SharesBF: Decimal;
        InsuranceBF: Decimal;
        LoanBF: Decimal;
        PrincipleBF: Decimal;
        DebitAmount: Decimal;
        CreditAmount: Decimal;
        InterestBF: Decimal;
        ShowZeroBal: Boolean;
        ClosingBalSHCAP: Decimal;
        ShareCapBF: Decimal;
        RiskBF: Decimal;
        DividendBF: Decimal;
        Company: Record "Company Information";
        OpenBalanceHse: Decimal;
        CLosingBalanceHse: Decimal;
        OpenBalanceDep1: Decimal;
        CLosingBalanceDep1: Decimal;
        OpenBalanceDep2: Decimal;
        CLosingBalanceDep2: Decimal;
        HseBF: Decimal;
        Dep1BF: Decimal;
        Dep2BF: Decimal;
        OpeningBalInt: Decimal;
        ClosingBalInt: Decimal;
        InterestPaid: Decimal;
        SumInterestPaid: Decimal;
        OpenBalanceRisk: Decimal;
        CLosingBalanceRisk: Decimal;
        OpenBalanceDividend: Decimal;
        ClosingBalanceDividend: Decimal;
        OpenBalanceHoliday: Decimal;
        ClosingBalanceHoliday: Decimal;
        LoanSetup: Record "Loan Products Setup";
        LoanName: Text[50];
        SaccoEmp: Record "Sacco Employers";
        EmployerName: Text[100];
}

