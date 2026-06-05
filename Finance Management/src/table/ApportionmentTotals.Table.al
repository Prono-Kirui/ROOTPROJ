table 51016 "Apportionment Totals"
{
    Caption = 'Apportionment Totals';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "No."; Code[50])
        {
            Caption = 'No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "G/L Account No."; Code[50])
        {
            Caption = 'G/L Account No.';
            TableRelation = "G/L Account";
        }
        field(4; "Total Amount"; Decimal)
        {
            CalcFormula = sum("Apportion Lines".Amount where("No." = field("No."),
                                                              "G/L Account No." = field("G/L Account No.")));
            Caption = 'Total Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Document No."; Code[50])
        {
            Caption = 'Document No.';
        }
    }

    keys
    {
        key(Key1; "No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
