page 51005 "Claim Types"
{
    ApplicationArea = All;
    Caption = 'Claim Types';
    PageType = List;
    SourceTable = "Receipts and Payment Types";
    SourceTableView = where(Type = filter("Staff Claim"));
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
                field("Account No."; Rec."Account No.")
                {
                    Caption = 'Account No.';
                    ToolTip = 'Specifies the value of the Account No. field';
                }
                field("Based On Travel Rates Table"; Rec."Based On Travel Rates Table")
                {
                    Caption = 'Based On Travel Rates Table';
                    ToolTip = 'Specifies the value of the Based On Travel Rates Table field';
                }
                field(Blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                    ToolTip = 'Specifies the value of the Blocked field';
                }
                field("VAT Chargeable"; Rec."VAT Chargeable")
                {
                    Caption = 'VAT Chargeable';
                    ToolTip = 'Specifies the value of the VAT Chargeable field';
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    Caption = 'VAT Bus. Posting Group';
                    ToolTip = 'Specifies the value of the VAT Bus. Posting Group field';
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
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code';
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code';
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    Caption = 'Shortcut Dimension 3 Code';
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field';
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::"Staff Claim";
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::"Staff Claim";
    end;
}
