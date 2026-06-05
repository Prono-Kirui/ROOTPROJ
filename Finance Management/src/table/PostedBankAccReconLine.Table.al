table 51021 "Posted Bank Acc. Recon Line"
{
    Caption = 'Posted Bank Acc. Recon Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            TableRelation = "Bank Account";
        }
        field(2; "Statement No."; Code[20])
        {
            Caption = 'Statement No.';
            TableRelation = "Bank Acc. Reconciliation"."Statement No." where("Bank Account No." = field("Bank Account No."));
        }
        field(3; "Statement Line No."; Integer)
        {
            Caption = 'Statement Line No.';
        }
        field(4; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(5; "Transaction Date"; Date)
        {
            Caption = 'Transaction Date';
        }
        field(6; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(7; "Statement Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 1;
            Caption = 'Statement Amount';

            trigger OnValidate()
            begin
                Difference := "Statement Amount" - "Applied Amount";
            end;
        }
        field(8; Difference; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Difference';

            trigger OnValidate()
            begin
                "Statement Amount" := "Applied Amount" + Difference;
            end;
        }
        field(9; "Applied Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Applied Amount';
            Editable = false;

            trigger OnValidate()
            begin
                Difference := "Statement Amount" - "Applied Amount";
            end;
        }
        field(10; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Bank Account Ledger Entry,Check Ledger Entry,Difference';
            OptionMembers = "Bank Account Ledger Entry","Check Ledger Entry",Difference;
        }
        field(11; "Applied Entries"; Integer)
        {
            Caption = 'Applied Entries';
            Editable = false;

            trigger OnLookup()
            begin
                Rec.DisplayApplication();
            end;
        }
        field(12; "Value Date"; Date)
        {
            Caption = 'Value Date';
        }
        field(13; "Ready for Application"; Boolean)
        {
            Caption = 'Ready for Application';
        }
        field(14; "Check No."; Code[20])
        {
            Caption = 'Check No.';
        }
        field(15; "Related-Party Name"; Text[250])
        {
            Caption = 'Related-Party Name';
        }
        field(16; "Additional Transaction Info"; Text[100])
        {
            Caption = 'Additional Transaction Info';
        }
        field(17; "Data Exch. Entry No."; Integer)
        {
            Caption = 'Data Exch. Entry No.';
            Editable = false;
            TableRelation = "Data Exch.";
        }
        field(18; "Data Exch. Line No."; Integer)
        {
            Caption = 'Data Exch. Line No.';
            Editable = false;
        }
        field(20; "Statement Type"; Enum "Bank Acc. Rec. Stmt. Type")
        {
            Caption = 'Statement Type';
        }
        field(21; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
        }
        field(22; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting),
                                                                                          Blocked = const(false))
            else
            if ("Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const(Vendor)) Vendor
            else
            if ("Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Account Type" = const("IC Partner")) "IC Partner"
            else
            if ("Account Type" = const(Employee)) Employee;

            trigger OnValidate()
            begin
                TestField("Applied Amount", 0);
            end;
        }
        field(23; "Transaction Text"; Text[140])
        {
            Caption = 'Transaction Text';

            trigger OnValidate()
            begin
                if ("Statement Type" = "Statement Type"::"Payment Application") or (Description = '') then
                    Description := CopyStr("Transaction Text", 1, MaxStrLen(Description));
            end;
        }
        field(24; "Related-Party Bank Acc. No."; Text[100])
        {
            Caption = 'Related-Party Bank Acc. No.';
        }
        field(25; "Related-Party Address"; Text[100])
        {
            Caption = 'Related-Party Address';
        }
        field(26; "Related-Party City"; Text[50])
        {
            Caption = 'Related-Party City';
        }
        field(27; "Payment Reference No."; Code[50])
        {
            Caption = 'Payment Reference';
        }
        field(31; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));
        }
        field(32; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          Blocked = const(false));
        }
        //    field(50; "Match Confidence"; Enum "Bank Rec. Match Confidence")
        //     {
        //         CalcFormula = max("Applied Payment Entry"."Match Confidence" where("Statement Type" = field("Statement Type"),
        //                                                                             "Bank Account No." = field("Bank Account No."),
        //                                                                             "Statement No." = field("Statement No."),
        //                                                                             "Statement Line No." = field("Statement Line No.")));
        //         Caption = 'Match Confidence';
        //         Editable = false;
        //         FieldClass = FlowField;
        //         InitValue = "None";
        //     }
        field(51; "Match Quality"; Integer)
        {
            CalcFormula = max("Applied Payment Entry".Quality where("Bank Account No." = field("Bank Account No."),
                                                                     "Statement No." = field("Statement No."),
                                                                     "Statement Line No." = field("Statement Line No."),
                                                                     "Statement Type" = field("Statement Type")));
            Caption = 'Match Quality';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60; "Sorting Order"; Integer)
        {
            Caption = 'Sorting Order';
        }
        field(61; "Parent Line No."; Integer)
        {
            Caption = 'Parent Line No.';
            Editable = false;
        }
        field(70; "Transaction ID"; Text[50])
        {
            Caption = 'Transaction ID';
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;

            trigger OnLookup()
            begin
                Rec.ShowDimensions();
            end;
        }
        field(50000; Reconciled; Boolean)
        {
            Caption = 'Reconciled';
        }
        field(50001; Imported; Boolean)
        {
            Caption = 'Imported';
        }
    }

    keys
    {
        key(Key1; "Statement Type", "Bank Account No.", "Statement No.", "Statement Line No.")
        {
            Clustered = true;
            SumIndexFields = "Statement Amount", Difference;
        }
    }

    var
        DimMgt: Codeunit DimensionManagement;
        AmountOustideToleranceRangeTok: Label '<%1|>%2', Comment = 'Do not translate.';
        AmountWithinToleranceRangeTok: Label '>=%1&<=%2', Comment = 'Do not translate.';

    procedure DisplayApplication()
    begin
    end;

    procedure GetCurrencyCode(): Code[10]
    var
        BankAcc: Record "Bank Account";
    begin
        if "Bank Account No." = BankAcc."No." then
            exit(BankAcc."Currency Code");

        if BankAcc.Get("Bank Account No.") then
            exit(BankAcc."Currency Code");

        exit('');
    end;

    procedure GetStyle(): Text
    begin
        if "Applied Entries" <> 0 then
            exit('Favorable');

        exit('');
    end;

    procedure ShowDimensions()
    begin
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2 %3', TableCaption, "Statement No.", "Statement Line No."));
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;

    procedure SetUpNewLine()
    begin
        "Transaction Date" := WorkDate();
        // "Match Confidence" := "Match Confidence"::None;
        "Document No." := '';
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

    procedure AcceptAppliedPaymentEntriesSelectedLines()
    begin
        if FindSet() then
            repeat
                AcceptApplication();
            until Next() = 0;
    end;

    procedure RejectAppliedPaymentEntriesSelectedLines()
    begin
        if FindSet() then
            repeat
                RejectAppliedPayment();
            until Next() = 0;
    end;

    procedure RejectAppliedPayment()
    begin
        RemoveAppliedPaymentEntries();
        DeletePaymentMatchingDetails();
    end;

    procedure AcceptApplication()
    begin
    end;

    local procedure RemoveApplication(AppliedType: Option)
    begin
    end;

    procedure SetManualApplication()
    begin
    end;

    local procedure RemoveAppliedPaymentEntries()
    begin
    end;

    local procedure DeletePaymentMatchingDetails()
    begin
    end;

    procedure GetAppliedToName(): Text
    var
        Customer: Record Customer;
        GLAccount: Record "G/L Account";
        Vendor: Record Vendor;
        Name: Text;
    begin
        Name := '';

        case "Account Type" of
            "Account Type"::Customer:
                if Customer.Get("Account No.") then
                    Name := Customer.Name;
            "Account Type"::Vendor:
                if Vendor.Get("Account No.") then
                    Name := Vendor.Name;
            "Account Type"::"G/L Account":
                if GLAccount.Get("Account No.") then
                    Name := GLAccount.Name;
        end;

        exit(Name);
    end;

    procedure AppliedToDrillDown()
    var
        Customer: Record Customer;
        GLAccount: Record "G/L Account";
        Vendor: Record Vendor;
    begin
        case "Account Type" of
            "Account Type"::Customer:
                begin
                    Customer.Get("Account No.");
                    Page.Run(Page::"Customer Card", Customer);
                end;
            "Account Type"::Vendor:
                begin
                    Vendor.Get("Account No.");
                    Page.Run(Page::"Vendor Card", Vendor);
                end;
            "Account Type"::"G/L Account":
                begin
                    GLAccount.Get("Account No.");
                    Page.Run(Page::"G/L Account Card", GLAccount);
                end;
        end;
    end;

    procedure DrillDownOnNoOfLedgerEntriesWithinAmountTolerance()
    begin
        DrillDownOnNoOfLedgerEntriesBasedOnAmount(AmountWithinToleranceRangeTok);
    end;

    procedure DrillDownOnNoOfLedgerEntriesOutsideOfAmountTolerance()
    begin
        DrillDownOnNoOfLedgerEntriesBasedOnAmount(AmountOustideToleranceRangeTok);
    end;

    local procedure DrillDownOnNoOfLedgerEntriesBasedOnAmount(AmountFilter: Text)
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        MaxAmount: Decimal;
        MinAmount: Decimal;
    begin
        GetAmountRangeForTolerance(MinAmount, MaxAmount);

        case "Account Type" of
            "Account Type"::Customer:
                begin
                    GetCustomerLedgerEntriesInAmountRange(CustLedgerEntry, "Account No.", AmountFilter, MinAmount, MaxAmount);
                    Page.Run(Page::"Customer Ledger Entries", CustLedgerEntry);
                end;
            "Account Type"::Vendor:
                begin
                    GetVendorLedgerEntriesInAmountRange(VendorLedgerEntry, "Account No.", AmountFilter, MinAmount, MaxAmount);
                    Page.Run(Page::"Vendor Ledger Entries", VendorLedgerEntry);
                end;
        end;
    end;

    procedure GetCustomerLedgerEntriesInAmountRange(var CustLedgerEntry: Record "Cust. Ledger Entry"; AccountNo: Code[20]; AmountFilter: Text; MinAmount: Decimal; MaxAmount: Decimal): Integer
    var
        BankAccount: Record "Bank Account";
    begin
        CustLedgerEntry.SetAutoCalcFields("Remaining Amount", "Remaining Amt. (LCY)");
        BankAccount.Get("Bank Account No.");
        GetApplicableCustomerLedgerEntries(CustLedgerEntry, BankAccount."Currency Code", AccountNo);

        // if BankAccount.IsInLocalCurrency() then
        //     CustLedgerEntry.SetFilter("Remaining Amt. (LCY)", AmountFilter, MinAmount, MaxAmount)
        // else
        CustLedgerEntry.SetFilter("Remaining Amount", AmountFilter, MinAmount, MaxAmount);

        exit(CustLedgerEntry.Count);
    end;

    procedure GetVendorLedgerEntriesInAmountRange(var VendorLedgerEntry: Record "Vendor Ledger Entry"; AccountNo: Code[20]; AmountFilter: Text; MinAmount: Decimal; MaxAmount: Decimal): Integer
    var
        BankAccount: Record "Bank Account";
    begin
        VendorLedgerEntry.SetAutoCalcFields("Remaining Amount", "Remaining Amt. (LCY)");

        BankAccount.Get("Bank Account No.");
        GetApplicableVendorLedgerEntries(VendorLedgerEntry, BankAccount."Currency Code", AccountNo);

        // if BankAccount.IsInLocalCurrency() then
        //     VendorLedgerEntry.SetFilter("Remaining Amt. (LCY)", AmountFilter, MinAmount, MaxAmount)
        // else
        VendorLedgerEntry.SetFilter("Remaining Amount", AmountFilter, MinAmount, MaxAmount);

        exit(VendorLedgerEntry.Count);
    end;

    local procedure GetApplicableCustomerLedgerEntries(var CustLedgerEntry: Record "Cust. Ledger Entry"; CurrencyCode: Code[10]; AccountNo: Code[20])
    begin
        CustLedgerEntry.SetRange(Open, true);
        CustLedgerEntry.SetRange("Applies-to ID", '');
        CustLedgerEntry.SetFilter("Document Type", '<>%1&<>%2',
          CustLedgerEntry."Document Type"::Payment,
          CustLedgerEntry."Document Type"::Refund);

        if CurrencyCode <> '' then
            CustLedgerEntry.SetRange("Currency Code", CurrencyCode);

        if AccountNo <> '' then
            CustLedgerEntry.SetFilter("Customer No.", AccountNo);
    end;

    local procedure GetApplicableVendorLedgerEntries(var VendorLedgerEntry: Record "Vendor Ledger Entry"; CurrencyCode: Code[10]; AccountNo: Code[20])
    begin
        VendorLedgerEntry.SetRange(Open, true);
        VendorLedgerEntry.SetRange("Applies-to ID", '');
        VendorLedgerEntry.SetFilter("Document Type", '<>%1&<>%2',
          VendorLedgerEntry."Document Type"::Payment,
          VendorLedgerEntry."Document Type"::Refund);

        if CurrencyCode <> '' then
            VendorLedgerEntry.SetRange("Currency Code", CurrencyCode);

        if AccountNo <> '' then
            VendorLedgerEntry.SetFilter("Vendor No.", AccountNo);
    end;

    procedure FilterBankRecLines(BankAccRecon: Record "Bank Acc. Reconciliation")
    begin
        Reset();
        SetRange("Statement Type", BankAccRecon."Statement Type");
        SetRange("Bank Account No.", BankAccRecon."Bank Account No.");
        SetRange("Statement No.", BankAccRecon."Statement No.");
    end;

    procedure LinesExist(BankAccRecon: Record "Bank Acc. Reconciliation"): Boolean
    begin
        FilterBankRecLines(BankAccRecon);
        exit(FindSet());
    end;

    procedure GetAppliedToDocumentNo(): Text
    var
        ApplyType: Option "Document No.","Entry No.";
    begin
        exit(GetAppliedNo(ApplyType::"Document No."));
    end;

    procedure GetAppliedToEntryNo(): Text
    var
        ApplyType: Option "Document No.","Entry No.";
    begin
        exit(GetAppliedNo(ApplyType::"Entry No."));
    end;

    local procedure GetAppliedNo(ApplyType: Option "Document No.","Entry No."): Text
    var
        AppliedPaymentEntry: Record "Applied Payment Entry";
        AppliedNumbers: Text;
    begin
        AppliedPaymentEntry.SetRange("Statement Type", "Statement Type");
        AppliedPaymentEntry.SetRange("Bank Account No.", "Bank Account No.");
        AppliedPaymentEntry.SetRange("Statement No.", "Statement No.");
        AppliedPaymentEntry.SetRange("Statement Line No.", "Statement Line No.");

        AppliedNumbers := '';
        if AppliedPaymentEntry.FindSet() then
            repeat
                if ApplyType = ApplyType::"Document No." then begin
                    if AppliedPaymentEntry."Document No." <> '' then
                        if AppliedNumbers = '' then
                            AppliedNumbers := AppliedPaymentEntry."Document No."
                        else
                            AppliedNumbers := AppliedNumbers + ', ' + AppliedPaymentEntry."Document No.";
                end else
                    if AppliedPaymentEntry."Applies-to Entry No." <> 0 then
                        if AppliedNumbers = '' then
                            AppliedNumbers := Format(AppliedPaymentEntry."Applies-to Entry No.")
                        else
                            AppliedNumbers := AppliedNumbers + ', ' + Format(AppliedPaymentEntry."Applies-to Entry No.");
            until AppliedPaymentEntry.Next() = 0;

        exit(AppliedNumbers);
    end;

    procedure TransferRemainingAmountToAccount()
    begin
    end;

    procedure GetAmountRangeForTolerance(var MinAmount: Decimal; var MaxAmount: Decimal)
    var
        BankAccount: Record "Bank Account";
        TempAmount: Decimal;
    begin
        BankAccount.Get("Bank Account No.");
        case BankAccount."Match Tolerance Type" of
            BankAccount."Match Tolerance Type"::Amount:
                begin
                    MinAmount := "Statement Amount" - BankAccount."Match Tolerance Value";
                    MaxAmount := "Statement Amount" + BankAccount."Match Tolerance Value";

                    if ("Statement Amount" >= 0) and (MinAmount < 0) then
                        MinAmount := 0
                    else
                        if ("Statement Amount" < 0) and (MaxAmount > 0) then
                            MaxAmount := 0;
                end;
            BankAccount."Match Tolerance Type"::Percentage:
                begin
                    MinAmount := "Statement Amount" / (1 + BankAccount."Match Tolerance Value" / 100);
                    MaxAmount := "Statement Amount" / (1 - BankAccount."Match Tolerance Value" / 100);

                    if "Statement Amount" < 0 then begin
                        TempAmount := MinAmount;
                        MinAmount := MaxAmount;
                        MaxAmount := TempAmount;
                    end;
                end;
        end;

        MinAmount := Round(MinAmount);
        MaxAmount := Round(MaxAmount);
    end;
}