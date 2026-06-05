table 51014 "Apportion Header"
{
    Caption = 'Apportion Header';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    CashSetup.Get();
                    CashSetup.TestField("Apportionment Nos");
                    NoSeries.TestManual(CashSetup."Apportionment Nos");
                end;
            end;
        }
        field(2; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
        }
        field(3; Posted; Boolean)
        {
            Caption = 'Posted';
        }
        field(4; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Open,Pending Approval,Released,Rejected';
            OptionMembers = Open,"Pending Approval",Released,Rejected;
        }
        field(5; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(6; "User ID"; Code[50])
        {
            Caption = 'User ID';
        }
        field(7; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,By Entry No.,By Document No.';
            OptionMembers = " ","By Entry No","By Document No";
        }
        field(8; "Total Amount"; Decimal)
        {
            CalcFormula = sum("Apportion Lines".Amount where("No." = field("No.")));
            Caption = 'Total Amount';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    var
        CashSetup: Record "Cash Management Setups";
        NoSeries: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            CashSetup.Get();
            CashSetup.TestField("Apportionment Nos");
            NoSeries.InitSeries(CashSetup."Apportionment Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Created Date" := CurrentDateTime;
        "User ID" := UserId;
    end;
}
