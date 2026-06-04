table 50012 "Banks"
{
    DrillDownPageID = "Banks List";
    LookupPageID = "Banks List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[50])
        {
            NotBlank = true;
            DataClassification = CustomerContent;
            Caption = 'Code';
        }
        field(2; Name; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Name';
        }
        field(3; Address; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Address';
        }
        field(4; "Address 2"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Address 2';
        }
        field(5; City; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'City';
        }
        field(6; "Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
            Caption = 'Post Code';

            trigger OnValidate()
            begin
                if PostCode.Get("Telex No.") then
                    "Phone No." := PostCode.City;
            end;
        }
        field(7; Contact; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Contact';
        }
        field(8; "Phone No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Phone No.';
        }
        field(9; "Telex No."; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Telex No.';
        }
        field(10; "Bank No."; Text[20])
        {
            NotBlank = false;
            DataClassification = CustomerContent;
            Caption = 'Bank No.';
        }
        field(11; "Bank Account No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Bank Account No.';
        }
        field(12; "Transit No."; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Transit No.';
        }
        field(13; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
            DataClassification = CustomerContent;
            Caption = 'Currency Code';
        }
        field(14; "Country Code"; Code[10])
        {
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
            Caption = 'Country Code';
        }
        field(15; County; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'County';
        }
        field(16; "Fax No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Fax No.';
        }
        field(17; "Telex Answer Back"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Telex Answer Back';
        }
        field(18; "Language Code"; Code[10])
        {
            TableRelation = Language;
            DataClassification = CustomerContent;
            Caption = 'Language Code';
        }
        field(19; "E-Mail"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'E-Mail';
        }
        field(20; "Home Page"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Home Page';
        }
        field(21; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            Caption = 'Pay Period Filter';
        }
        field(22; "Rounding Type"; Option)
        {
            OptionCaption = 'Nearest,Up,Down';
            OptionMembers = Nearest,Up,Down;
            DataClassification = CustomerContent;
            Caption = 'Rounding Type';
        }
        field(23; "Rounding Precision"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
            Caption = 'Rounding Precision';
        }
        field(24; "Swift Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Swift Code';
        }
        field(25; "Sort Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Sort Code';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PostCode: Record "Post Code";
}





