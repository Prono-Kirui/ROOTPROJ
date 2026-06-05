table 51003 "EFT File Naming"
{
    Caption = 'EFT File Naming';
    DataClassification = CustomerContent;
    fields
    {
        field(1; Value; Integer)
        {
            Caption = 'Value';
        }
        field(2; Character; Code[5])
        {
            Caption = 'Character';
        }
    }

    keys
    {
        key(Key1; Value)
        {
            Clustered = true;
        }
    }
}
