pageextension 51007 VendorBankAccountPageExt extends "Vendor Bank Account Card"
{
    layout
    {
        moveafter(Name; "Bank Branch No.")
        moveafter("Bank Account No."; Name)

        modify(Code)
        {
            trigger OnAfterValidate()
            begin
                CurrPage.Update();
            end;
        }

        modify("Bank Branch No.")
        {
            trigger OnAfterValidate()
            begin
                CurrPage.Update();
            end;
        }

        addafter("Bank Branch No.")
        {
            field("Bank Branch Name"; Rec."Bank Branch Name")
            {
                ApplicationArea = All;
                Caption = 'Bank Branch Name';
                ToolTip = 'Specifies the value of the Bank Branch Name field';
            }
        }
        addafter(Code)
        {
            field("Bank Name"; Rec."Bank Name")
            {
                ApplicationArea = All;
                Caption = 'Bank Name';
                ToolTip = 'Specifies the value of the Bank Name field.';
            }
        }
    }
}
