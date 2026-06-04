pageextension 50015 "VendorCardExt" extends "Vendor Card"
{
    layout
    {

        addlast(General)
        {
            field("Vendor Type"; Rec."Vendor Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Type field';
            }
            field("KRA PIN"; Rec."KRA PIN")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the KRA PIN field.';
                ShowMandatory = true;
            }
            field("PIN Certificate Expiry"; Rec."PIN Certificate Expiry")
            {
                Caption = 'Tax compliance expiry date';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Tax compliance expiry date field';
            }
        }
    }
}





