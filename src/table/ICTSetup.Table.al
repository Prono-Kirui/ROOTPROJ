table 50004 "ICT Setup"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Primary Key';
        }
        field(2; "Incidence Nos"; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = "Serial No. Information";
            Caption = 'Incidence Nos';
        }
        field(3; "Registry E-Mail"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Registry E-Mail';
        }
        field(4; "Screenshot Path"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Screenshot Path';
        }
        field(5; "Security E-Mail"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Security E-Mail';
        }
        field(6; "Escalation E-mail"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Escalation E-mail';
        }
        field(7; "Communication Nos"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Serial No. Information";
            Caption = 'Communication Nos';
        }
        field(8; "Communication E-Mail"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Communication E-Mail';
        }
        field(9; "Registry BCC"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Registry BCC';
        }
        field(10; "Password Change Dateformula"; DateFormula)
        {
            Caption = 'Password Change Dateformula';
            DataClassification = SystemMetadata;
        }
        field(11; "Last Password Change Date"; Date)
        {
            Caption = 'Last Password Change Date';
            DataClassification = SystemMetadata;
            trigger OnValidate()
            begin
                "Next Password Change Date" := CalcDate("Password Change Dateformula", "Last Password Change Date")
            end;
        }
        field(12; "Next Password Change Date"; Date)
        {
            Caption = 'Next Password Change Date';
            DataClassification = SystemMetadata;
        }
        field(13; "Enforce Password Expiry"; Boolean)
        {
            Caption = 'Enforce Password Expiry';
            DataClassification = SystemMetadata;
        }
        field(14; "Password Reset Nos"; Code[20])
        {
            Caption = 'User Change Nos';
            TableRelation = "Serial No. Information";
        }
        field(15; "Working Hours Start Time"; Time)
        {
            Caption = 'Working Hours Start Time';
        }
        field(16; "Working Hours End Time"; Time)
        {
            Caption = 'Working Hours End Time';
        }
        field(17; "Enforce Working Hours Policy"; Boolean)
        {
            Caption = 'Enforce Working Hours Policy';
        }
        field(18; "Pwd Reset Requires Approval"; Boolean)
        {
            Caption = 'Password Reset Requires Approval';
            DataClassification = SystemMetadata;
        }
        field(19; "Role Change Requires Approval"; Boolean)
        {
            Caption = 'Role Change Requires Approval';
            DataClassification = SystemMetadata;
        }
        field(20; "Enforce Multiple Login Control"; Boolean)
        {
            Caption = 'Enforce Multiple Login Control';
        }
        field(21; "User Group/Permisison Approval"; Boolean)
        {
            Caption = 'User Group/Permisison Approval';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





