table 51012 "Apportionment Entry"
{
    Caption = 'Apportionment Entry';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Document No."; Code[50])
        {
            Caption = 'Document No.';
        }
        field(2; Company; Text[50])
        {
            Caption = 'Company';
            TableRelation = Company.Name;
        }
        field(3; Allocation; Decimal)
        {
            Caption = 'Allocation (%)';
        }
        field(4; "Posted Doc No."; Code[50])
        {
            Caption = 'Posted Doc No.';
        }
        field(5; Processed; Boolean)
        {
            Caption = 'Processed';
        }
        field(6; "Expense Account"; Code[30])
        {
            Caption = 'Expense Account';
            TableRelation = "G/L Account";
        }
        field(7; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(8; "Apportioned Amount"; Decimal)
        {
            Caption = 'Apportioned Amount';
        }
        field(9; "Line No"; Integer)
        {
            Caption = 'Line No';
        }
        field(10; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(11; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(12; "G/L Entry No"; Integer)
        {
            Caption = 'G/L Entry No';
        }
        field(23; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));
        }
        field(24; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = const(false));
        }
        field(55; "Document Date"; Date)
        {
            Caption = 'Document Date';
            ClosingDates = true;
        }
        field(56; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
        }
        field(57; "Amount To Post"; Decimal)
        {
            Caption = 'Amount To Post';
        }
        field(58; "Apportion Doc No."; Code[20])
        {
            Caption = 'Apportion Doc No.';
        }
        field(59; "Processed Date-Time"; DateTime)
        {
            Caption = 'Processed Date-Time';
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                //ShowDimensions;
            end;
        }
        field(481; "Prepared Date-Time"; DateTime)
        {
            Caption = 'Prepared Date-Time';
        }
        field(482; "From Company"; Text[50])
        {
            Caption = 'From Company';
            TableRelation = Company.Name;
        }
    }

    keys
    {
        key(Key1; "Document No.", Company, "G/L Entry No", "Apportion Doc No.")
        {
            Clustered = true;
        }
    }
}
