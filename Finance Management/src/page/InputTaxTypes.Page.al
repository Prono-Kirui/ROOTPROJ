page 51102 "Input Tax Types"
{
    ApplicationArea = All;
    Caption = 'Input Tax Types';
    PageType = List;
    SourceTable = "Receipts and Payment Types";
    SourceTableView = where(Type = filter("Input Tax"));
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
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::"Input Tax";
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::"Input Tax";
    end;
}
