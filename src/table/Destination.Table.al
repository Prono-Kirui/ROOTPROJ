table 50002 "Destination"
{
    DrillDownPageID = "Destination Code";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Destination Code"; Code[10])
        {
            NotBlank = true;
            DataClassification = CustomerContent;
            Caption = 'Destination Code';
        }
        field(2; "Destination Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Destination Name';
        }
        field(3; "Destination Type"; Option)
        {
            OptionMembers = "Local",Foreign;
            DataClassification = CustomerContent;
            Caption = 'Destination Type';
        }
        field(4; "Other Area"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Other Area';
        }
        field(5; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Destination Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





