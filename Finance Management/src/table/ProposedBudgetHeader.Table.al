table 51011 "Proposed Budget Header"
{
    Caption = 'Proposed Budget Header';
    DataClassification = CustomerContent;
    fields
    {
        field(1; Name; Code[10])
        {
            Caption = 'Name';
            NotBlank = true;
        }
        field(2; Description; Text[80])
        {
            Caption = 'Description';
        }
        field(3; Posted; Boolean)
        {
            Caption = 'Posted';
        }
        field(4; "Posted By"; Code[70])
        {
            Caption = 'Posted By';
        }
        field(5; "Date-Time Posted"; DateTime)
        {
            Caption = 'Date-Time Posted';
        }
        field(9; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));
        }
        field(10; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = const(false));
        }
        field(11; Approvals; Integer)
        {
            CalcFormula = count("Approval Entry" where("Document No." = field(Name)));
            Caption = 'Approvals';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; Name)
        {
            Clustered = true;
        }
    }
}
