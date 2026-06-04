table 50482 "Mobile Loan Appraisal Logs"
{
    Caption = 'Mobile Loan Appraisal Logs';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Member No"; Code[20])
        {
            Caption = 'Member No';
        }
        field(2; "Member Name"; Code[150])
        {
            Caption = 'Member Name';
        }
        field(3; "Qualified Amount"; Decimal)
        {
            Caption = 'Qualified Amount';
        }
        field(4; "Disqualification Reason"; Text[1000])
        {
            Caption = 'Disqualification Reason';
        }
        field(5; "Transaction Date"; Date)
        {
            Caption = 'Transaction Date';
        }
    }
    keys
    {
        key(PK; "Member No")
        {
            Clustered = true;
        }
    }
}
