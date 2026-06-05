report 51032 "Journal Report"
{
    ApplicationArea = All;
    Caption = 'Journal Report';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/JournalReport.rdl';
    dataset
    {
        dataitem(GenJournalLine; "Gen. Journal Line")
        {
            column(BatchName; "Journal Batch Name")
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(DocumentDate; "Document Date")
            {
            }
            column(AccountType; "Account Type")
            {
            }
            column(AccountNo; "Account No.")
            {
            }
            column(AccountName; GetAccountName(GenJournalLine))
            {
            }
            column(Description; Description)
            {
            }
            column(ExternalDocNo; "External Document No.")
            {
            }
            column(DebitAmount; "Debit Amount")
            {
            }
            column(CreditAmount; "Credit Amount")
            {
            }
            column(BalAccountType; "Bal. Account Type")
            {
            }
            column(BalAccountNo; "Bal. Account No.")
            {
            }
            column(Dimension1Code; "Shortcut Dimension 1 Code")
            {
            }
            column(Dimension2Code; "Shortcut Dimension 2 Code")
            {
            }
            column(Currency; "Currency Code")
            {
            }
            column(UserID; "User ID")
            {
            }
            column(Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(CompanyAddr1; CompanyAddr[1])
            {
            }
            column(CompanyAddr2; CompanyAddr[2])
            {
            }
            column(CompanyAddr3; CompanyAddr[3])
            {
            }
            column(CompanyAddr4; CompanyAddr[4])
            {
            }
            column(NumberText1; NumberText[1])
            {
            }
            column(NumberText2; NumberText[2])
            {
            }
            column(Balance; Balance)
            {
            }
            column(BalanceLCY; BalanceLCY)
            {
            }
            column(Narration; Narration)
            {
            }
            column(DimVisible1; DimVisible1)
            {
            }
            column(DimVisible2; DimVisible2)
            {
            }
            column(DimVisible3; DimVisible3)
            {
            }
            column(DimVisible4; DimVisible4)
            {
            }
            column(DimVisible5; DimVisible5)
            {
            }
            column(DimVisible6; DimVisible6)
            {
            }
            column(DimVisible7; DimVisible7)
            {
            }
            column(DimVisible8; DimVisible8)
            {
            }
            column(ShortcutDimCode1; ShortcutDimCode[1])
            {
            }
            column(ShortcutDimCode2; ShortcutDimCode[2])
            {
            }
            column(ShortcutDimCode3; ShortcutDimCode[3])
            {
            }
            column(ShortcutDimCode4; ShortcutDimCode[4])
            {
            }
            column(ShortcutDimCode5; ShortcutDimCode[5])
            {
            }
            column(ShortcutDimCode6; ShortcutDimCode[6])
            {
            }
            column(ShortcutDimCode7; ShortcutDimCode[7])
            {
            }
            column(ShortcutDimCode8; ShortcutDimCode[8])
            {
            }
            column(GLSetupShortcutDimCode1Caption; GetDimCaption(GLSetupShortcutDimCode[1]))
            {
            }
            column(GLSetupShortcutDimCode2Caption; GetDimCaption(GLSetupShortcutDimCode[2]))
            {
            }
            column(GLSetupShortcutDimCode3Caption; GetDimCaption(GLSetupShortcutDimCode[3]))
            {
            }
            column(GLSetupShortcutDimCode4Caption; GetDimCaption(GLSetupShortcutDimCode[4]))
            {
            }
            column(GLSetupShortcutDimCode5Caption; GetDimCaption(GLSetupShortcutDimCode[5]))
            {
            }
            column(GLSetupShortcutDimCode6Caption; GetDimCaption(GLSetupShortcutDimCode[6]))
            {
            }
            column(GLSetupShortcutDimCode7Caption; GetDimCaption(GLSetupShortcutDimCode[7]))
            {
            }
            column(GLSetupShortcutDimCode8Caption; GetDimCaption(GLSetupShortcutDimCode[8]))
            {
            }

            trigger OnAfterGetRecord()
            begin
                LoadFooterBalance();
                i += 1;
                LoadNarration(i, "Journal Template Name", "Journal Batch Name", "Document No.");

                DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
            end;
        }
    }

    var
        CompanyInfo: Record "Company Information";
        GenJnlBatch: Record "Gen. Journal Batch";
        DimMgt: Codeunit DimensionManagement;
        FormatAddress: Codeunit "Format Address";
        PaymentsManagement: Codeunit "Payments Management";
        DimVisible1: Boolean;
        DimVisible2: Boolean;
        DimVisible3: Boolean;
        DimVisible4: Boolean;
        DimVisible5: Boolean;
        DimVisible6: Boolean;
        DimVisible7: Boolean;
        DimVisible8: Boolean;
        GLSetupShortcutDimCode: array[8] of Code[20];
        ShortcutDimCode: array[8] of Code[20];
        Balance, BalanceLCY, CheckAmount : Decimal;
        i: Integer;
        CompanyAddr: array[8] of Text;
        Narration: Text;
        NumberText: array[2] of Text;

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);

        FormatAddress.Company(CompanyAddr, CompanyInfo);
        SetDimensionVisibility();
        DimMgt.GetGLSetup(GLSetupShortcutDimCode);
    end;

    local procedure CalculateTotalBalanceLCY(GenJournalLine: Record "Gen. Journal Line"): Decimal
    var
        GenJournalLine2: Record "Gen. Journal Line";
    begin
        GenJournalLine2.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        GenJournalLine2.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        GenJournalLine2.SetFilter("Amount (LCY)", '>%1', 0);
        GenJournalLine2.CalcSums("Amount (LCY)");
        exit(GenJournalLine2."Amount (LCY)");
    end;

    local procedure CalculateTotalBalance(GenJournalLine: Record "Gen. Journal Line"): Decimal
    var
        GenJournalLine2: Record "Gen. Journal Line";
    begin
        GenJournalLine2.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        GenJournalLine2.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        GenJournalLine2.CalcSums("Debit Amount");
        exit(GenJournalLine2."Debit Amount");
    end;

    local procedure LoadFooterBalance()
    begin
        Balance := CalculateTotalBalance(GenJournalLine);
        BalanceLCY := CalculateTotalBalanceLCY(GenJournalLine);

        PaymentsManagement.InitTextVariable();
        CheckAmount := BalanceLCY;
        PaymentsManagement.FormatNoText(NumberText, CheckAmount, GenJournalLine."Currency Code");
    end;

    local procedure LoadNarration(k: Integer; JournalTemplate: Code[20]; JournalBatch: Code[20]; DocNo: Code[50])
    begin
        if k <= 1 then
            Narration := GenJnlBatch.GetNarration(JournalTemplate, JournalBatch, DocNo);
    end;

    local procedure GetAccountName(GeneralJournal: Record "Gen. Journal Line"): Text[100]
    var
        BankAccount: Record "Bank Account";
        Customer: Record Customer;
        Employee: Record Employee;
        FixedAsset: Record "Fixed Asset";
        GLAccount: Record "G/L Account";
        Vendor: Record Vendor;
    begin
        case GeneralJournal."Account Type" of
            GeneralJournal."Account Type"::"G/L Account":
                if GLAccount.Get(GenJournalLine."Account No.") then
                    exit(GLAccount.Name);
            GeneralJournal."Account Type"::Customer:
                if Customer.Get(GenJournalLine."Account No.") then
                    exit(Customer.Name);
            GeneralJournal."Account Type"::Vendor:
                if Vendor.Get(GenJournalLine."Account No.") then
                    exit(Vendor.Name);
            GeneralJournal."Account Type"::Employee:
                if Employee.Get(GenJournalLine."Account No.") then
                    exit(Employee.FullName());
            GeneralJournal."Account Type"::"Bank Account":
                if BankAccount.Get(GenJournalLine."Account No.") then
                    exit(BankAccount.Name);
            GeneralJournal."Account Type"::"Fixed Asset":
                if FixedAsset.Get(GenJournalLine."Account No.") then
                    exit(FixedAsset.Description);
        end;
    end;

    local procedure SetDimensionVisibility()
    begin
        DimVisible1 := false;
        DimVisible2 := false;
        DimVisible3 := false;
        DimVisible4 := false;
        DimVisible5 := false;
        DimVisible6 := false;
        DimVisible7 := false;
        DimVisible8 := false;

        DimMgt.UseShortcutDims(
          DimVisible1, DimVisible2, DimVisible3, DimVisible4, DimVisible5, DimVisible6, DimVisible7, DimVisible8);

        Clear(DimMgt);
    end;

    local procedure GetDimCaption(DimCode: Code[20]): Text[80]
    var
        Dimension: Record Dimension;
    begin
        if Dimension.Get(DimCode) then
            exit(Dimension."Code Caption")
        else
            exit(DimCode);
    end;
}
