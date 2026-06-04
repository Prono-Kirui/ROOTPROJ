table 50013 "Bank Branches"
{
    DrillDownPageID = "Bank Branches List";
    LookupPageID = "Bank Branches List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Bank Code"; Code[50])
        {
            NotBlank = true;
            TableRelation = Banks;
            DataClassification = CustomerContent;
            Caption = 'Bank Code';
        }
        field(2; "Branch Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Branch Code';
        }
        field(3; "Branch Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Branch Name';
        }
        field(4; Address; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Address';
        }
        field(5; "Address 2"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Address 2';
        }
        field(6; City; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'City';
        }
        field(7; "Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
            Caption = 'Post Code';

            trigger OnValidate()
            begin
                if PostCode.Get("Post Code") then
                    City := PostCode.City;
            end;
        }
        field(8; Contact; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Contact';
        }
        field(9; "Phone No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Phone No.';
        }
        field(10; "Telex No."; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Telex No.';
        }
        field(12; "Bank Branch No."; Text[20])
        {
            NotBlank = false;
            DataClassification = CustomerContent;
            Caption = 'Bank Branch No.';
        }
        field(13; "Bank Account No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Bank Account No.';
        }
        field(14; "Transit No."; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Transit No.';
        }
        field(15; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
            DataClassification = CustomerContent;
            Caption = 'Currency Code';
        }
        field(16; "Country Code"; Code[10])
        {
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
            Caption = 'Country Code';
        }
        field(17; County; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'County';
        }
        field(18; "Fax No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Fax No.';
        }
        field(19; "Telex Answer Back"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Telex Answer Back';
        }
        field(20; "Language Code"; Code[10])
        {
            TableRelation = Language;
            DataClassification = CustomerContent;
            Caption = 'Language Code';
        }
        field(21; "E-Mail"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'E-Mail';
        }
        field(22; "Home Page"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Home Page';
        }
        field(23; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            Caption = 'Pay Period Filter';
        }
        field(24; "Rounding Type"; Option)
        {
            OptionCaption = 'Nearest,Up,Down';
            OptionMembers = Nearest,Up,Down;
            DataClassification = CustomerContent;
            Caption = 'Rounding Type';
        }
        field(25; "Rounding Precision"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
            Caption = 'Rounding Precision';
        }
        field(26; "SWIFT Code"; Code[20])
        {
            Caption = 'SWIFT Code';
            DataClassification = CustomerContent;
        }
        field(27; Stopped; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(28; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Closed;
            OptionCaption = 'Open,Closed';
        }
    }

    keys
    {
        key(Key1; "Bank Code", "Branch Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Bank Code", "Branch Code", "Branch Name")
        {
        }
    }

    var
        PostCode: Record "Post Code";
}





