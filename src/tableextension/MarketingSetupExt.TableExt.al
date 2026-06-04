tableextension 50011 "MarketingSetupExt" extends "Marketing Setup"
{
    fields
    {
        field(50000; "Enquiries Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Serial No. Information";
            Caption = 'Enquiries Nos.';
        }
        field(50001; Interact; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Serial No. Information";
            ;
            Caption = 'Interact';
        }
    }
}





