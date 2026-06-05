tableextension 51013 VendLedgerExt extends "Vendor Ledger Entry"
{
    fields
    {
        modify("Applies-to ID")
        {
            trigger OnAfterValidate()
            begin
                if "Applies-to ID" <> '' then
                    if "Applies-to ID" <> xRec."Appl. To ID Copy" then
                        "Appl. To ID Copy" := "Applies-to ID";
            end;
        }
        field(51000; "Appl. To ID Copy"; Code[50])
        {
            Caption = 'Appl. To ID Copy';
            DataClassification = CustomerContent;
        }
    }
}
