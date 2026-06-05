table 51020 "Expense Code"
{
    Caption = 'Expense Code';
    DataClassification = CustomerContent;
    DrillDownPageId = "Expense Code";
    LookupPageId = "Expense Code";
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Name; Text[30])
        {
            Caption = 'Name';
        }
        field(3; "G/L Account"; Code[20])
        {
            Caption = 'G/L Account';
            TableRelation = "G/L Account"."No.";
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,G/L Account,Item,,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,,"Fixed Asset","Charge (Item)";
        }
        field(6; "Expense Type"; Option)
        {
            Caption = 'Expense Type';
            OptionCaption = 'Training,Admin,Investment,Property';
            OptionMembers = Training,Admin,Investment,Property;
        }
        field(7; "Per Diem"; Boolean)
        {
            Caption = 'Per Diem';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }
}
