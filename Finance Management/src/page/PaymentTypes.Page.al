page 51002 "Payment Types"
{
    ApplicationArea = All;
    Caption = 'Payment Types';
    PageType = List;
    SourceTable = "Receipts and Payment Types";
    SourceTableView = where(Type = filter("Payment Voucher"));
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
                field(Blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                    ToolTip = 'Specifies the value of the Blocked field';
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
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::"Payment Voucher";
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::"Payment Voucher";
    end;
}
