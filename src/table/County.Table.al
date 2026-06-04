table 50010 "County"
{
    DrillDownPageId = "County List";
    LookupPageId = "County List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; County; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'County Code';
        }
        field(2; "County Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'County Code';
        }
        field(3; Description; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; County)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; County, Description)
        {
        }
    }
}





