pageextension 51008 BankAccountCardExt extends "Bank Account Card"
{
    layout
    {
        modify("No.")
        {
            Editable = true;
            Visible = true;
        }
        modify(Name)
        {
            ShowMandatory = true;
        }
        modify("Bank Account No.")
        {
            ShowMandatory = true;
        }
        modify("Bank Acc. Posting Group")
        {
            ShowMandatory = true;
        }
        modify("Currency Code")
        {
            ShowMandatory = true;
        }
        modify("SWIFT Code")
        {
            ShowMandatory = true;
        }

        addlast(General)
        {
            field("Payment Document Nos"; Rec."Payment Document Nos")
            {
                ApplicationArea = All;
                Caption = 'Payment Document Nos';
                ToolTip = 'Specifies the value of the Payment Document Nos field.';
            }
        }

        addlast(Posting)
        {
            field("Bank Type"; Rec."Bank Type")
            {
                ApplicationArea = All;
                Caption = 'Bank Type';
                ToolTip = 'Specifies the value of the Bank Type field';
            }
            field(CashierID; Rec."Cashier User ID")
            {
                ApplicationArea = All;
                Caption = 'Cashier ID';
                ToolTip = 'Specifies the value of the CashierID field';
            }
            field("Sort Code"; Rec."Sort Code")
            {
                ApplicationArea = All;
                Caption = 'Sort Code';
                ToolTip = 'Specifies the value of the Sort Code field';
            }
            field("Check Bank Limit"; Rec."Check Bank Limit")
            {
                ApplicationArea = All;
                Caption = 'Check Bank Limit';
                ToolTip = 'Specifies the value of the Check Bank Limit field';
            }
            field("Bank Limit (LCY)"; Rec."Bank Limit (LCY)")
            {
                ApplicationArea = All;
                Caption = 'Bank Limit (LCY)';
                Editable = Rec."Check Bank Limit";
                ToolTip = 'Specifies the value of the Bank Limit (LCY) field';
            }
        }
    }
}
