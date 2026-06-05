table 51019 "Email Header"
{
    Caption = 'Email Header';
    DataClassification = CustomerContent;
    fields
    {
        field(1; No; Code[30])
        {
            Caption = 'No';
        }
        field(2; Description; Text[60])
        {
            Caption = 'Description';
        }
        field(3; Date; Date)
        {
            Caption = 'Date';
        }
        field(4; "Created By"; Code[30])
        {
            Caption = 'Created By';
        }
        field(5; "Last Modified By"; Code[10])
        {
            Caption = 'Last Modified By';
        }
        field(6; "Total Items"; Decimal)
        {
            Caption = 'Total Items';
        }
        field(7; "Total Sent"; Decimal)
        {
            Caption = 'Total Sent';
        }
        field(8; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Pending,Complete';
            OptionMembers = Pending,Complete;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }
}
