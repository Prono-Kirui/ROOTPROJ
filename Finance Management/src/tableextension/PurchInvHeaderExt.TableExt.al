tableextension 51008 PurchInvHeaderExt extends "Purch. Inv. Header"
{
    fields
    {
        field(51000; Apportion; Boolean)
        {
            Caption = 'Apportion';
            DataClassification = CustomerContent;
        }
        field(51001; "Vendor Invoice Date"; Date)
        {
            Caption = 'Vendor Invoice Date';
            DataClassification = CustomerContent;
        }
    }
}
