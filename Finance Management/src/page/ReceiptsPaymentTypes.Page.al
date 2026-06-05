page 51008 "Receipts & Payment Types"
{
    ApplicationArea = All;
    Caption = 'Receipts & Payment Types';
    PageType = List;
    SourceTable = "Receipts and Payment Types";
    UsageCategory = Lists;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Code"; Rec.Code)
                {
                    Caption = 'Code';
                    ToolTip = 'Specifies the value of the Code field';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Account Type"; Rec."Account Type")
                {
                    Caption = 'Account Type';
                    ToolTip = 'Specifies the value of the Account Type field';
                }
                field(Type; Rec.Type)
                {
                    Caption = 'Type';
                    ToolTip = 'Specifies the value of the Type field';
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    Caption = 'VAT Bus. Posting Group';
                    ToolTip = 'Specifies the value of the VAT Bus. Posting Group field';
                }
                field("VAT Chargeable"; Rec."VAT Chargeable")
                {
                    Caption = 'VAT Chargeable';
                    ToolTip = 'Specifies the value of the VAT Chargeable field';
                }
                field("Withholding Tax Chargeable"; Rec."Withholding Tax Chargeable")
                {
                    Caption = 'Withholding Tax Chargeable';
                    ToolTip = 'Specifies the value of the Withholding Tax Chargeable field';
                }
                field("VAT Code"; Rec."VAT Code")
                {
                    Caption = 'VAT Code';
                    ToolTip = 'Specifies the value of the VAT Code field';
                }
                field("Withholding Tax Code"; Rec."Withholding Tax Code")
                {
                    Caption = 'Withholding Tax Code';
                    ToolTip = 'Specifies the value of the Withholding Tax Code field';
                }
                field("Default Grouping"; Rec."Default Grouping")
                {
                    Caption = 'Default Grouping';
                    ToolTip = 'Specifies the value of the Default Grouping field';
                }
                field("Account No."; Rec."Account No.")
                {
                    Caption = 'Account No.';
                    ToolTip = 'Specifies the value of the Account No. field';
                }
                field("Pending Voucher"; Rec."Pending Voucher")
                {
                    Caption = 'Pending Voucher';
                    ToolTip = 'Specifies the value of the Pending Voucher field';
                }
                field("Bank Account"; Rec."Bank Account")
                {
                    Caption = 'Bank Account';
                    ToolTip = 'Specifies the value of the Bank Account field';
                }
                field("Transation Remarks"; Rec."Transation Remarks")
                {
                    Caption = 'Transation Remarks';
                    ToolTip = 'Specifies the value of the Transation Remarks field';
                }
                field("Payment Reference"; Rec."Payment Reference")
                {
                    Caption = 'Payment Reference';
                    ToolTip = 'Specifies the value of the Payment Reference field';
                }
                field("Customer Payment On Account"; Rec."Customer Payment On Account")
                {
                    Caption = 'Customer Payment On Account';
                    ToolTip = 'Specifies the value of the Customer Payment On Account field';
                }
                field("Direct Expense"; Rec."Direct Expense")
                {
                    Caption = 'Direct Expense';
                    ToolTip = 'Specifies the value of the Direct Expense field';
                }
                field("Calculate Retention"; Rec."Calculate Retention")
                {
                    Caption = 'Calculate Retention';
                    ToolTip = 'Specifies the value of the Calculate Retention field';
                }
                field("Retention Code"; Rec."Retention Code")
                {
                    Caption = 'Retention Code';
                    ToolTip = 'Specifies the value of the Retention Code field';
                }
                field(Blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                    ToolTip = 'Specifies the value of the Blocked field';
                }
                field("Based On Travel Rates Table"; Rec."Based On Travel Rates Table")
                {
                    Caption = 'Based On Travel Rates Table';
                    ToolTip = 'Specifies the value of the Based On Travel Rates Table field';
                }
                field("Receipt Reference"; Rec."Receipt Reference")
                {
                    Caption = 'Receipt Reference';
                    ToolTip = 'Specifies the value of the Receipt Reference field';
                }
                field("Based On a Table"; Rec."Based On a Table")
                {
                    Caption = 'Based On a Table';
                    ToolTip = 'Specifies the value of the Based On a Table field';
                }
                field("Old Account No"; Rec."Old Account No")
                {
                    Caption = 'Old Account No';
                    ToolTip = 'Specifies the value of the Old Account No field';
                }
                field("Do NOT Allow Apply Twice"; Rec."Do NOT Allow Apply Twice")
                {
                    Caption = 'Do NOT Allow Apply Twice';
                    ToolTip = 'Specifies the value of the Do NOT Allow Apply Twice field';
                }
                field("Payment Option"; Rec."Payment Option")
                {
                    Caption = 'Payment Option';
                    ToolTip = 'Specifies the value of the Payment Option field';
                }
                field("Imprest Payment"; Rec."Imprest Payment")
                {
                    Caption = 'Imprest Payment';
                    ToolTip = 'Specifies the value of the Imprest Payment field';
                }
                field("Claim Payment"; Rec."Claim Payment")
                {
                    Caption = 'Claim Payment';
                    ToolTip = 'Specifies the value of the Claim Payment field';
                }
                field("Cost of Sale"; Rec."Cost of Sale")
                {
                    Caption = 'Cost of Sale';
                    ToolTip = 'Specifies the value of the Cost of Sale field';
                }
                field("Check Medical Ceiling"; Rec."Check Medical Ceiling")
                {
                    Caption = 'Check Medical Ceiling';
                    ToolTip = 'Specifies the value of the Check Medical Ceiling field';
                }
                field("Property Receipt"; Rec."Property Receipt")
                {
                    Caption = 'Property Receipt';
                    ToolTip = 'Specifies the value of the Property Receipt field';
                }
                field("Property Receipt Type"; Rec."Property Receipt Type")
                {
                    Caption = 'Property Transaction Type';
                    ToolTip = 'Specifies the value of the Property Transaction Type field';
                }
                field("Manual Allocation"; Rec."Manual Allocation")
                {
                    Caption = 'Manual Allocation';
                    ToolTip = 'Specifies the value of the Manual Allocation field';
                }
            }
        }
    }
}
