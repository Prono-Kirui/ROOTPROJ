table 51001 "Receipts and Payment Types"
{
    Caption = 'Receipts and Payment Types';
    DataClassification = CustomerContent;
    DrillDownPageId = "Receipts & Payment Types";
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';

            trigger OnValidate()
            begin
                if "Account Type" = "Account Type"::"G/L Account" then
                    "Direct Expense" := true
                else
                    "Direct Expense" := false;
            end;
        }
        field(4; Type; Enum "Payments Mgt Type")
        {
            Caption = 'Type';
            NotBlank = true;
        }
        field(5; "VAT Chargeable"; Option)
        {
            Caption = 'VAT Chargeable';
            OptionMembers = No,Yes;
        }
        field(6; "Withholding Tax Chargeable"; Option)
        {
            Caption = 'Withholding Tax Chargeable';
            OptionMembers = No,Yes;
        }
        field(7; "VAT Code"; Code[20])
        {
            Caption = 'VAT Code';
            TableRelation = "VAT Product Posting Group";
        }
        field(8; "Withholding Tax Code"; Code[20])
        {
            Caption = 'Withholding Tax Code';
            TableRelation = "VAT Product Posting Group";
        }
        field(9; "Default Grouping"; Code[20])
        {
            Caption = 'Default Grouping';
            TableRelation = if ("Account Type" = const(Customer)) "Customer Posting Group"
            else
            if ("Account Type" = const(Vendor)) "Vendor Posting Group"
            else
            if ("Account Type" = const("Bank Account")) "Bank Account Posting Group"
            else
            if ("Account Type" = const("Fixed Asset")) "FA Posting Group"
            else
            if ("Account Type" = const("IC Partner")) "IC Partner";
        }
        field(10; "Account No."; Code[20])
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
                GLAcc.Reset();
                if GLAcc.Get("Account No.") then
                    // "Old Account No":=GLAcc."Old Account No";
                    // IF Type=Type::Payment THEN
                    // //Ensure all Income statement accounts are set for budget control
                    // IF GLAcc."Income/Balance"= GLAcc."Income/Balance"::"Income Statement" THEN
                    //     GLAcc.TESTFIELD(GLAcc."Budget Controlled",TRUE);
                    //
                    //   GLAcc.TESTFIELD(GLAcc."Budget Controlled",TRUE);
                    if GLAcc."Direct Posting" = false then
                        Error('Direct Posting must be True');

                if ("Account Type" = "Account Type"::"G/L Account") and (GLAcc."Income/Balance" = GLAcc."Income/Balance"::"Income Statement") then
                    "Direct Expense" := true
                else
                    "Direct Expense" := false;
            end;
        }
        field(11; "Pending Voucher"; Boolean)
        {
            Caption = 'Pending Voucher';
        }
        field(12; "Bank Account"; Code[20])
        {
            Caption = 'Bank Account';
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                if "Account Type" <> "Account Type"::"Bank Account" then
                    Error('You can only enter Bank No where Account Type is Bank Account');
            end;
        }
        field(13; "Transation Remarks"; Text[250])
        {
            Caption = 'Transation Remarks';
            NotBlank = true;
        }
        field(14; "Payment Reference"; Option)
        {
            Caption = 'Payment Reference';
            OptionMembers = Normal,"Farmer Purchase";
        }
        field(15; "Customer Payment On Account"; Boolean)
        {
            Caption = 'Customer Payment On Account';
        }
        field(16; "Direct Expense"; Boolean)
        {
            Caption = 'Direct Expense';
            Editable = false;
        }
        field(17; "Calculate Retention"; Option)
        {
            Caption = 'Calculate Retention';
            OptionMembers = No,Yes;
        }
        field(18; "Retention Code"; Code[20])
        {
            Caption = 'Retention Code';
            TableRelation = "VAT Product Posting Group";
        }
        field(19; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(20; "Based On Travel Rates Table"; Boolean)
        {
            Caption = 'Based On Travel Rates Table';
        }
        field(21; "Receipt Reference"; Option)
        {
            Caption = 'Receipt Reference';
            OptionMembers = Normal,"Travel Advance Refunds","Other Advance Refunds";

            trigger OnValidate()
            begin
                if "Receipt Reference" <> "Receipt Reference"::Normal then
                    TestField("Account Type", "Account Type"::Customer);
            end;
        }
        field(22; "Based On a Table"; Boolean)
        {
            Caption = 'Based On a Table';
        }
        field(23; "Old Account No"; Code[20])
        {
            Caption = 'Old Account No';
        }
        field(24; "Do NOT Allow Apply Twice"; Boolean)
        {
            Caption = 'Do NOT Allow Apply Twice';
        }
        field(25; "Payment Option"; Option)
        {
            Caption = 'Payment Option';
            OptionMembers = " ","Medical Claims",Training;
        }
        field(26; "Imprest Payment"; Boolean)
        {
            Caption = 'Imprest Payment';
        }
        field(27; "Claim Payment"; Boolean)
        {
            Caption = 'Claim Payment';
        }
        field(28; "Cost of Sale"; Boolean)
        {
            Caption = 'Cost of Sale';
        }
        field(29; "Check Medical Ceiling"; Boolean)
        {
            Caption = 'Check Medical Ceiling';
        }
        field(30; "Property Receipt"; Boolean)
        {
            Caption = 'Property Receipt';
        }
        field(32; "Property Receipt Type"; Option)
        {
            Caption = 'Property Transaction Type';
            OptionCaption = 'Rent Receipt,Property Expense,TPS Repayment,TPS Deposit';
            OptionMembers = "Rent Receipt","Property Expense","TPS Repayment","TPS Deposit";
        }
        field(33; "Manual Allocation"; Boolean)
        {
            Caption = 'Manual Allocation';
        }
        field(35; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));
        }
        field(36; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = const(false));
        }
        field(37; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(38; Training; Boolean)
        {
            Caption = 'Training';
        }
        field(39; "VAT Bus. Posting Group"; Code[20])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group".Code;
        }
    }

    keys
    {
        key(Key1; "Code", Type)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description, "Account Type", "Account No.")
        {
        }
    }

    var
        GLAcc: Record "G/L Account";
}
