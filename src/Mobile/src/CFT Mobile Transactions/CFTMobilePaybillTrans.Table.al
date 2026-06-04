table 50806 "CFT Mobile Paybill Trans"
{
    Caption = 'CFT Mobile Paybill Transanction Table';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No"; Code[20])
        {
            Caption = 'Document No';
        }
        field(2; "Transaction Date"; Date)
        {
            Caption = 'Transaction Date';
        }
        field(3; "Account No"; Code[20])
        {
            Caption = 'Account No';
        }
        field(4; Description; Text[220])
        {
            Caption = 'Description';
        }
        field(5; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(6; Posted; Boolean)
        {
            Caption = 'Posted';
        }
        field(7; "Transaction Type"; Text[30])
        {
            Caption = 'Transaction Type';
        }
        field(8; "Transaction Time"; Time)
        {
            Caption = 'Transaction Time';
        }
        field(9; "Paybill Acc Balance"; Decimal)
        {
            Caption = 'Paybill Acc Balance';
        }
        field(10; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(11; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
        }
        field(12; "Time Posted"; Date)
        {
            Caption = 'Time Posted';
        }
        field(13; Changed; Boolean)
        {
            Caption = 'Changed';
        }
        field(14; "Date Changed"; Date)
        {
            Caption = 'Date Changed';
        }
        field(15; "Time Changed"; Date)
        {
            Caption = 'Time Changed';
        }
        field(16; "Changed By"; Code[30])
        {
            Caption = 'Changed By';
        }
        field(17; "Approved By"; Code[30])
        {
            Caption = 'Approved By';
        }
        field(18; "Key Word"; Text[70])
        {
            Caption = 'Key Word';
        }
        field(19; Telephone; Text[150])
        {
            Caption = 'Telephone';
        }
        field(20; "Account Name"; Text[140])
        {
            Caption = 'Account Name';
        }
        field(21; "Needs Manual Posting"; Boolean)
        {
            Caption = 'Needs Manual Posting';
        }

    }
    keys
    {
        key(PK; "Document No")
        {
            Clustered = true;
        }
    }
}
