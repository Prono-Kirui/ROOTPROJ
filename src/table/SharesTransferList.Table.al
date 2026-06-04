table 50028 "Shares Transfer List"
{
    Caption = 'Shares Transfer List';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Reference No"; Code[20])
        {
            Caption = 'Reference No';
            TableRelation = "Shares Transfer Header"."Reference No";
        }
        field(2; "Count Number"; Integer)
        {
            Caption = 'Count Number';
            AutoIncrement = true;
        }
        field(3; "Member No"; Code[50])
        {
            Caption = 'Member No';

            trigger OnValidate()
            var
                Cust: Record Customer;
            begin
                Cust.reset;
                Cust.SetRange(Cust."No.", "Member No");
                Cust.SetAutoCalcFields(cust."Current Shares", cust."Shares Retained");
                if Cust.find('-') then begin
                    "Member Name" := Cust.Name;
                    if "Transaction Type" = "Transaction Type"::"Deposit Contribution" then
                        "Shares Currently" := cust."Current Shares"
                    else if "Transaction Type" = "Transaction Type"::"Share Capital" then
                        "Shares Currently" := cust."Shares Retained"
                end;

                SharesTransferHeader.Reset();
                SharesTransferHeader.SetRange("Reference No", "Reference No");
                if SharesTransferHeader.Find('-') then begin
                    Rec."Transaction Type" := SharesTransferHeader."Transfer Type";
                    Rec.Amount := SharesTransferHeader."Amount To Transfer" - SharesTransferHeader."Charges Amount";

                end;

            end;
        }
        field(4; "Member Name"; Text[100])
        {
            Caption = 'Member Name';
        }
        field(5; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(6; Posted; Boolean)
        {
            Caption = 'Posted';
        }
        field(7; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
        }
        field(8; "Transaction Type"; Enum TransactionTypesEnum)
        {
            Caption = 'Transaction Type';
            //InitValue = 'Share Capital ';
            trigger OnValidate()
            var
                Cust: Record Customer;
            begin
                Cust.reset;
                Cust.SetRange(Cust."No.", "Member No");
                Cust.SetAutoCalcFields(cust."Current Shares", cust."Shares Retained");
                if Cust.find('-') then begin
                    "Member Name" := Cust.Name;
                    if "Transaction Type" = "Transaction Type"::"Deposit Contribution" then
                        "Shares Currently" := cust."Current Shares"
                    else if "Transaction Type" = "Transaction Type"::"Share Capital" then
                        "Shares Currently" := cust."Shares Retained"

                end;
            end;
        }
        field(9; "Shares Currently"; Decimal)
        {
        }
    }
    keys
    {
        key(PK; "Reference No", "Count Number")
        {
            Clustered = true;
        }
    }
    var
        Cust: Record Customer;
        SharesTransferHeader: Record "Shares Transfer Header";
}
