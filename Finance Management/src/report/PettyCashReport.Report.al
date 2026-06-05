report 51016 "Petty Cash Report"
{
    ApplicationArea = All;
    Caption = 'Bank Acc. - Detail Trial Bal.';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/PettyCashReport.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Bank Account"; "Bank Account")
        {
            DataItemTableView = sorting("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Bank Acc. Posting Group", "Date Filter";

            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(STRSUBSTNO_Text000_BankAccDateFilter_; StrSubstNo(PeriodLbl, BankAccDateFilter))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(USERID; UserId)
            {
            }
            column(STRSUBSTNO___1___2___Bank_Account__TABLECAPTION_BankAccFilter_; StrSubstNo('%1: %2', "Bank Account".TableCaption, BankAccFilter))
            {
            }
            column(Bank_Account__No__; "No.")
            {
            }
            column(Bank_Account_Name; Name)
            {
            }
            column(Bank_Account__Currency_Code_; "Currency Code")
            {
            }
            column(StartBalance; StartBalance)
            {
                AutoFormatExpression = "Bank Account Ledger Entry"."Currency Code";
                AutoFormatType = 1;
            }
            column(Cashier_ReportCaption; Cashier_ReportCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Bank_Account_Ledger_Entry__Posting_Date_Caption; "Bank Account Ledger Entry".FieldCaption("Posting Date"))
            {
            }
            column(Bank_Account_Ledger_Entry__Document_No__Caption; "Bank Account Ledger Entry".FieldCaption("Document No."))
            {
            }
            column(Bank_Account_Ledger_Entry_DescriptionCaption; "Bank Account Ledger Entry".FieldCaption(Description))
            {
            }
            column(BankAccBalance_StartBalance_tellerIssuesCaption; BankAccBalance_StartBalance_tellerIssuesCaptionLbl)
            {
            }
            column(Bank_Account_Ledger_Entry__Entry_No__Caption; "Bank Account Ledger Entry".FieldCaption("Entry No."))
            {
            }
            column(Account_NameCaption; Account_NameCaptionLbl)
            {
            }
            column(Bank_Account_Ledger_Entry__Debit_Amount_Caption; "Bank Account Ledger Entry".FieldCaption("Debit Amount"))
            {
            }
            column(Bank_Account_Ledger_Entry__Credit_Amount_Caption; "Bank Account Ledger Entry".FieldCaption("Credit Amount"))
            {
            }
            column(Account_No_Caption; Account_No_CaptionLbl)
            {
            }
            column(Bank_Account__Currency_Code_Caption; FieldCaption("Currency Code"))
            {
            }
            column(Teller__Sign_Date_Caption; Teller__Sign_Date_CaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(Accountant_Manager__Sign_Date_Caption; Accountant_Manager__Sign_Date_CaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102760026; EmptyStringCaption_Control1102760026Lbl)
            {
            }
            column(Bank_Account_Date_Filter; "Date Filter")
            {
            }
            column(Bank_Account_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {
            }
            column(Bank_Account_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {
            }
            column(Balance_At_date; "Bank Account"."Balance at Date (LCY)")
            {
            }
            column(Bank_Account_Cashier_ID; "Cashier User ID")
            {
            }
            column(Company_Name; CompanyInfo.Name)
            {
            }
            column(Company_pic; CompanyInfo.Picture)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = field("No."), "Posting Date" = field("Date Filter"), "Global Dimension 2 Code" = field("Global Dimension 2 Filter"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter");
                DataItemTableView = sorting("Bank Account No.", "Posting Date");

                column(StartBalance____Bank_Account_Ledger_Entry__Amount; StartBalance + "Bank Account Ledger Entry".Amount)
                {
                    AutoFormatExpression = "Bank Account Ledger Entry"."Currency Code";
                    AutoFormatType = 1;
                }
                column(Bank_Account_Ledger_Entry__Posting_Date_; "Posting Date")
                {
                }
                column(Bank_Account_Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Bank_Account_Ledger_Entry_Description; Description)
                {
                }
                column(BankAccBalance_StartBalance_tellerIssues; BankAccBalance)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(Bank_Account_Ledger_Entry__Entry_No__; "Entry No.")
                {
                }
                column(Bank_Account_Ledger_Entry_Amount; Amount)
                {
                }
                column(Names_Control1102760001; Names)
                {
                }
                column(Bank_Account_Ledger_Entry__Debit_Amount_; "Debit Amount")
                {
                }
                column(Bank_Account_Ledger_Entry__Credit_Amount_; "Credit Amount")
                {
                }
                column(Bank_Account_Ledger_Entry__Bank_Account_Ledger_Entry___Bal__Account_No__; "Bank Account Ledger Entry"."Bal. Account No.")
                {
                }
                column(StartBalance____Bank_Account_Ledger_Entry__Amount_Control47; StartBalance + "Bank Account Ledger Entry".Amount)
                {
                    AutoFormatExpression = "Bank Account Ledger Entry"."Currency Code";
                    AutoFormatType = 1;
                }
                column(ContinuedCaption; ContinuedCaptionLbl)
                {
                }
                column(ContinuedCaption_Control46; ContinuedCaption_Control46Lbl)
                {
                }
                column(Bank_Account_Ledger_Entry_Bank_Account_No_; "Bank Account No.")
                {
                }
                column(Bank_Account_Ledger_Entry_Global_Dimension_2_Code; "Global Dimension 2 Code")
                {
                }
                column(Bank_Account_Ledger_Entry_Global_Dimension_1_Code; "Global Dimension 1 Code")
                {
                }

                trigger OnPreDataItem()
                begin
                    BankAccLedgEntryExists := false;
                end;

                trigger OnAfterGetRecord()
                begin
                    if not PrintReversedEntries and Reversed then
                        CurrReport.Skip();
                    BankAccLedgEntryExists := true;
                    BankAccBalance := BankAccBalance + Amount;
                    BankAccBalanceLCY := BankAccBalanceLCY + "Amount (LCY)";

                    Names := '';
                    case "Bank Account Ledger Entry"."Bal. Account Type" of
                        "Bank Account Ledger Entry"."Bal. Account Type"::Customer:
                            if Cust.Get("Bank Account Ledger Entry"."Bal. Account No.") then
                                Names := CopyStr(Cust.Name, 1, MaxStrLen(Names));
                        "Bank Account Ledger Entry"."Bal. Account Type"::Vendor:
                            if Vend.Get("Bank Account Ledger Entry"."Bal. Account No.") then
                                Names := CopyStr(Vend.Name, 1, MaxStrLen(Names));
                        "Bank Account Ledger Entry"."Bal. Account Type"::"Bank Account":
                            if Bank.Get("Bank Account Ledger Entry"."Bal. Account No.") then
                                Names := CopyStr(Bank.Name, 1, MaxStrLen(Names));
                    end;
                    //ELSE
                    //IF "Bank Account Ledger Entry"."Bal. Account Type"="Bank Account Ledger Entry"."Bal. Account Type"::"G/L Account" THEN BEGIN
                    //IF Member.GET(ban)
                    TCredit := TCredit + "Bank Account Ledger Entry"."Credit Amount";
                    TDebit := TDebit + "Bank Account Ledger Entry"."Debit Amount";
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));

                column(Bank_Account__Name; "Bank Account".Name)
                {
                }
                column(Bank_Account_Ledger_Entry__Amount; "Bank Account Ledger Entry".Amount)
                {
                }
#pragma warning disable AA0205
                column(StartBalance____Bank_Account_Ledger_Entry__Amount_tellerIssues; StartBalance + "Bank Account Ledger Entry".Amount + tellerIssues)
#pragma warning restore AA0205
                {
                    AutoFormatExpression = "Bank Account Ledger Entry"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TDebit; TDebit)
                {
                }
                column(TCredit; TCredit)
                {
                }
                column(Integer_Number; Number)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if not BankAccLedgEntryExists and ((StartBalance = 0) or ExcludeBalanceOnly) then begin
                        StartBalanceLCY := 0;
                        CurrReport.Skip();
                    end;
                end;
            }

            trigger OnPreDataItem()
            begin

                if CompanyInfo.Get() then
                    CompanyInfo.CalcFields(CompanyInfo.Picture);
            end;

            trigger OnAfterGetRecord()
            begin
                StartBalance := 0;
                TCredit := 0;
                TDebit := 0;

                if BankAccDateFilter <> '' then
                    if GetRangeMin("Date Filter") <> 0D then begin
                        SetRange("Date Filter", 0D, GetRangeMin("Date Filter") - 1);
                        CalcFields("Net Change", "Net Change (LCY)");
                        StartBalance := "Net Change";
                        StartBalanceLCY := "Net Change (LCY)";
                        SetFilter("Date Filter", BankAccDateFilter);
                    end;
                //CurrReport.PrintOnlyIfDetail := ExcludeBalanceOnly or (StartBalance = 0);
                BankAccBalance := StartBalance;
                BankAccBalanceLCY := StartBalanceLCY;
            end;
        }
    }
    labels
    {
    }

    var
        Bank: Record "Bank Account";
        CompanyInfo: Record "Company Information";
        Cust: Record Customer;
        Vend: Record Vendor;
        BankAccLedgEntryExists: Boolean;
        ExcludeBalanceOnly: Boolean;
        PrintReversedEntries: Boolean;
        BankAccBalance: Decimal;
        BankAccBalanceLCY: Decimal;
        StartBalance: Decimal;
        StartBalanceLCY: Decimal;
        TCredit: Decimal;
        TDebit: Decimal;
        tellerIssues: Decimal;
        Account_NameCaptionLbl: Label 'Account Name';
        Account_No_CaptionLbl: Label 'Account No.';
        Accountant_Manager__Sign_Date_CaptionLbl: Label 'Accountant/Manager (Sign/Date)';
        BankAccBalance_StartBalance_tellerIssuesCaptionLbl: Label 'Balance';
        Cashier_ReportCaptionLbl: Label 'Cashier Report';
        ContinuedCaption_Control46Lbl: Label 'Continued';
        ContinuedCaptionLbl: Label 'Continued';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        EmptyStringCaption_Control1102760026Lbl: Label '.....................................................................';
        EmptyStringCaptionLbl: Label '.....................................................................';
        Teller__Sign_Date_CaptionLbl: Label 'Teller (Sign/Date)';
        PeriodLbl: Label 'Period: %1', Comment = '%1 = Period';
        BankAccDateFilter: Text[30];
        Names: Text[80];
        BankAccFilter: Text[250];

    trigger OnPreReport()
    begin
        BankAccFilter := CopyStr("Bank Account".GetFilters, 1, MaxStrLen(BankAccFilter));
        BankAccDateFilter := CopyStr("Bank Account".GetFilter("Date Filter"), 1, MaxStrLen(BankAccDateFilter));

        CompanyInfo.Get();
        CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;
}
