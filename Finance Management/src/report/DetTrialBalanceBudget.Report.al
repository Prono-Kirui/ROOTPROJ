report 51037 "Det. Trial Balance-Budget"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/DetailedTrialBalanceByBudget.rdl';
    ApplicationArea = All;
    Caption = 'Detail Trial Balance by Budget';
    UsageCategory = ReportsAndAnalysis;
    DataAccessIntent = ReadOnly;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = where("Account Type" = const(Posting));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Income/Balance", "Debit/Credit", "Date Filter";
            column(PeriodGLDtFilter; StrSubstNo(PeriodLbl, GLDateFilter))
            {
            }
            column(CompanyName; COMPANYPROPERTY.DisplayName())
            {
            }
            column(ExcludeBalanceOnly; ExcludeBalanceOnly)
            {
            }
            column(PrintReversedEntries; PrintReversedEntries)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(PrintOnlyOnePerPage; PrintOnlyOnePerPage)
            {
            }
            column(PrintClosingEntries; PrintClosingEntries)
            {
            }
            column(PrintOnlyCorrections; PrintOnlyCorrections)
            {
            }
            column(GLAccTableCaption; TableCaption + ': ' + GLFilter)
            {
            }
            column(GLFilter; GLFilter)
            {
            }
            column(EmptyString; '')
            {
            }
            column(No_GLAcc; "No.")
            {
            }
            column(DetailTrialBalCaption; DetailTrialBalCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(PeriodCaption; PeriodCaptionLbl)
            {
            }
            column(OnlyCorrectionsCaption; OnlyCorrectionsCaptionLbl)
            {
            }
            column(NetChangeCaption; NetChangeCaptionLbl)
            {
            }
            column(GLEntryDebitAmtCaption; GLEntryDebitAmtCaptionLbl)
            {
            }
            column(GLEntryCreditAmtCaption; GLEntryCreditAmtCaptionLbl)
            {
            }
            column(GLBalCaption; GLBalCaptionLbl)
            {
            }
            dataitem(PageCounter; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(Name_GLAcc; "G/L Account".Name)
                {
                }
                column(StartBalance; StartBalance)
                {
                    AutoFormatType = 1;
                }
                dataitem("G/L Entry"; "G/L Entry")
                {
                    DataItemLink = "G/L Account No." = field("No."), "Posting Date" = field("Date Filter"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter"), "Global Dimension 2 Code" = field("Global Dimension 2 Filter"), "Business Unit Code" = field("Business Unit Filter"), "Dimension Set ID" = field("Dimension Set ID Filter");
                    DataItemLinkReference = "G/L Account";
                    DataItemTableView = sorting("G/L Account No.", "Posting Date");
                    column(VATAmount_GLEntry; "VAT Amount")
                    {
                        IncludeCaption = true;
                    }
                    column(DebitAmount_GLEntry; "Debit Amount")
                    {
                    }
                    column(CreditAmount_GLEntry; "Credit Amount")
                    {
                    }
                    column(PostingDate_GLEntry; Format("Posting Date"))
                    {
                    }
                    column(DocumentNo_GLEntry; "Document No.")
                    {
                    }
                    column(ExtDocNo_GLEntry; "External Document No.")
                    {
                        IncludeCaption = true;
                    }
                    column(Description_GLEntry; Description)
                    {
                    }
                    column(GLBalance; GLBalance)
                    {
                        AutoFormatType = 1;
                    }
                    column(EntryNo_GLEntry; "Entry No.")
                    {
                    }
                    column(ClosingEntry; ClosingEntry)
                    {
                    }
                    column(Reversed_GLEntry; Reversed)
                    {
                    }
                    column(BudgetCode_GLEntry; BudgetCode)
                    {
                    }
                    column(SubBudgetCode_GLEntry; SubBudgetCode)
                    {
                    }
                    column(BudgetCodeName_GLEntry; GetDimName(BudgetCode, 2))
                    {
                    }
                    column(SubBudgetCodeName_GLEntry; GetDimName(SubBudgetCode, 3))
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if PrintOnlyCorrections then
                            if not (("Debit Amount" < 0) or ("Credit Amount" < 0)) then
                                CurrReport.Skip();
                        if not PrintReversedEntries and Reversed then
                            CurrReport.Skip();

                        GLBalance := GLBalance + Amount;
                        if ("Posting Date" = ClosingDate("Posting Date")) and
                           not PrintClosingEntries
                        then begin
                            "Debit Amount" := 0;
                            "Credit Amount" := 0;
                        end;

                        if "Posting Date" = ClosingDate("Posting Date") then
                            ClosingEntry := true
                        else
                            ClosingEntry := false;

                        NumberOfGLEntryLines += 1;

                        Clear(ShortCutDimCode);

                        DimMgt.GetShortcutDimensions("G/L Entry"."Dimension Set ID", ShortCutDimCode);
                        BudgetCode := ShortCutDimCode[2];
                        SubBudgetCode := ShortCutDimCode[3];
                    end;

                    trigger OnPreDataItem()
                    begin
                        GLBalance := StartBalance;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    // CurrReport.PrintOnlyIfDetail := ExcludeBalanceOnly or (StartBalance = 0);
                end;
            }

            trigger OnAfterGetRecord()
            var
                Date: Record Date;
                GLEntry: Record "G/L Entry";
            begin
                StartBalance := 0;
                if GLDateFilter <> '' then begin
                    Date.SetRange("Period Type", Date."Period Type"::Date);
                    Date.SetFilter("Period Start", GLDateFilter);
                    if Date.FindFirst() then begin
                        SetRange("Date Filter", 0D, ClosingDate(Date."Period Start" - 1));
                        CalcFields("Net Change");
                        StartBalance := "Net Change";
                        SetFilter("Date Filter", GLDateFilter);
                    end;
                end;

                if PrintOnlyOnePerPage then begin
                    // GLEntry.Reset();
                    // GLEntry.SetRange("G/L Account No.", "No.");
                    // if CurrReport.PrintOnlyIfDetail and (not GLEntry.IsEmpty()) then
                    PageGroupNo := PageGroupNo + 1;
                end;
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 1;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NewPageperGLAcc; PrintOnlyOnePerPage)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New Page per G/L Acc.';
                        ToolTip = 'Specifies if each G/L account information is printed on a new page if you have chosen two or more G/L accounts to be included in the report.';
                    }
                    field(ExcludeGLAccsHaveBalanceOnly; ExcludeBalanceOnly)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Exclude G/L Accs. That Have a Balance Only';
                        MultiLine = true;
                        ToolTip = 'Specifies if you do not want the report to include entries for G/L accounts that have a balance but do not have a net change during the selected time period.';
                    }
                    field(InclClosingEntriesWithinPeriod; PrintClosingEntries)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Include Closing Entries Within the Period';
                        MultiLine = true;
                        ToolTip = 'Specifies if you want the report to include closing entries. This is useful if the report covers an entire fiscal year. Closing entries are listed on a fictitious date between the last day of one fiscal year and the first day of the next one. They have a C before the date, such as C123194. If you do not select this field, no closing entries are shown.';
                    }
                    field(IncludeReversedEntries; PrintReversedEntries)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Include Reversed Entries';
                        ToolTip = 'Specifies if you want to include reversed entries in the report.';
                    }
                    field(PrintCorrectionsOnly; PrintOnlyCorrections)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Print Corrections Only';
                        ToolTip = 'Specifies if you want the report to show only the entries that have been reversed and their matching correcting entries.';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        PostingDateCaption = 'Posting Date';
        DocNoCaption = 'Document No.';
        DescCaption = 'Description';
        VATAmtCaption = 'VAT Amount';
        EntryNoCaption = 'Entry No.';
    }

    trigger OnPreReport()
    begin
        StartDateTime := CurrentDateTime();
        GLFilter := "G/L Account".GetFilters();
        GLDateFilter := "G/L Account".GetFilter("Date Filter");
    end;

    trigger OnPostReport()
    begin
        FinishDateTime := CurrentDateTime();
    end;

    var
        DimMgt: Codeunit DimensionManagement;
        ClosingEntry: Boolean;
        ExcludeBalanceOnly: Boolean;
        PrintClosingEntries: Boolean;
        PrintOnlyCorrections: Boolean;
        PrintOnlyOnePerPage: Boolean;
        PrintReversedEntries: Boolean;
        BudgetCode: Code[20];
        ShortCutDimCode: array[8] of Code[20];
        SubBudgetCode: Code[20];
        GLBalance: Decimal;
        StartBalance: Decimal;
        PageGroupNo: Integer;
        BalanceCaptionLbl: Label 'This also includes general ledger accounts that only have a balance.';
        DetailTrialBalCaptionLbl: Label 'Detail Trial Balance by Budget';
        GLBalCaptionLbl: Label 'Balance';
        GLEntryCreditAmtCaptionLbl: Label 'Credit';
        GLEntryDebitAmtCaptionLbl: Label 'Debit';
        NetChangeCaptionLbl: Label 'Net Change';
        OnlyCorrectionsCaptionLbl: Label 'Only corrections are included.';
        PageCaptionLbl: Label 'Page';
        PeriodCaptionLbl: Label 'This report also includes closing entries within the period.';
        PeriodLbl: Label 'Period: %1', Comment = '%1 = Period';
        GLDateFilter: Text;

    protected var
        FinishDateTime: DateTime;
        StartDateTime: DateTime;
        NumberOfGLEntryLines: Integer;
        GLFilter: Text;

    procedure InitializeRequest(NewPrintOnlyOnePerPage: Boolean; NewExcludeBalanceOnly: Boolean; NewPrintClosingEntries: Boolean; NewPrintReversedEntries: Boolean; NewPrintOnlyCorrections: Boolean)
    begin
        PrintOnlyOnePerPage := NewPrintOnlyOnePerPage;
        ExcludeBalanceOnly := NewExcludeBalanceOnly;
        PrintClosingEntries := NewPrintClosingEntries;
        PrintReversedEntries := NewPrintReversedEntries;
        PrintOnlyCorrections := NewPrintOnlyCorrections;
    end;

    local procedure GetDimName(DimCode: Code[20]; DimNo: Integer): Text[100]
    var
        DimensionValue: Record "Dimension Value";
    begin
        DimensionValue.SetRange(Code, DimCode);
        DimensionValue.SetRange("Global Dimension No.", DimNo);
        if DimensionValue.FindFirst() then
            exit(DimensionValue.Name)
        else
            exit(DimCode);
    end;
}