table 50006 "Approval Stages"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Workflow User Group Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Workflow User Group";
            Caption = 'Workflow User Group Code';
        }
        field(2; "Approval Stage"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Approval Stage';
        }
        field(4; "Approval Stage Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Approval Stage Name';
        }
        field(6; "Minimum Approvers"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Minimum Approvers';
        }
    }

    keys
    {
        key(Key1; "Workflow User Group Code", "Approval Stage")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}





