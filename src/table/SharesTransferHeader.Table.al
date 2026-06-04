table 50327 "Shares Transfer Header"
{
    Caption = 'Shares Transfer Header';
    DataClassification = ToBeClassified;
    LookupPageId = "Share Transfer List";
    DrillDownPageId = "Share Transfer List";

    fields
    {
        field(1; "Reference No"; Code[50])
        {
            Caption = 'Reference No';

            trigger OnValidate()
            begin
                SalesSetup.Get;
                NoSeriesMgt.TestManual(SalesSetup."Shares Transfers Nos");
                "No. Series" := '';
            end;
        }
        field(2; "Transfer Type"; Enum TransactionTypesEnum)
        {
            Caption = 'Transfer Type';
            InitValue = 'Share Capital';
            Editable = false;
        }
        field(3; "Member No"; Code[50])
        {
            Caption = 'Member No';
            TableRelation = Customer."No.";

            trigger OnValidate()
            var
                Cust: Record Customer;
            begin
                Cust.reset;
                Cust.SetRange(Cust."No.", "Member No");
                Cust.SetAutoCalcFields(cust."Current Shares", cust."Shares Retained");
                if Cust.find('-') then begin
                    "Member Name" := Cust.Name;
                    if "Transfer Type" = "Transfer Type"::"Deposit Contribution" then
                        "Shares Amount" := cust."Current Shares"
                    else if "Transfer Type" = "Transfer Type"::"Share Capital" then
                        "Shares Amount" := cust."Shares Retained"



                    else if "Transfer Type" = "Transfer Type"::" " then
                        Error('You Must choose The type of Share Transfer before proceeding !')
                    else
                        Error('The Type of Transfer Is Not Enabled,Contact IT Department');
                end;
                if "Shares Amount" < "Amount To Transfer" then Error('You cannot Transfer More than the Available Share Amount !');
            end;
        }
        field(4; "Member Name"; Text[100])
        {
            Caption = 'Member Name';
        }
        field(5; "Date Captured"; Date)
        {
            Caption = 'Date Captured';
        }
        field(6; "Captured By"; Code[50])
        {
            Caption = 'Captured By';
        }
        field(7; Status; Enum "Record Status")
        {
            Caption = 'Status';
        }
        field(8; "Approved By"; Code[50])
        {
            Caption = 'Approved By';
        }
        field(9; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
        }
        field(10; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
        }
        field(11; "Transfer Description"; Text[100])
        {
        }
        field(12; "Shares Amount"; Decimal)
        {
            Editable = false;
        }
        field(13; "Amount To Transfer"; Decimal)
        {
            trigger OnValidate()
            begin
                if "Shares Amount" < "Amount To Transfer" then Error('You cannot Transfer More than the Available Share Amount !');
                "Total Amount" := "Amount To Transfer" + "Charges Amount";
            end;
        }
        field(14; "Line Amount To Transfer"; Decimal)
        {
            CalcFormula = sum("Shares Transfer Header"."Amount To Transfer" where("Reference No" = field("Reference No")));
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
            end;
        }
        field(15; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(16; "Posting Date Used"; Date)
        {
            Caption = 'Posting Date';
        }
        field(17; "Transfer Reason"; Text[100])
        {
            Caption = 'Transfer Reason';
        }
        field(18; "Charges Amount"; Decimal)
        {
            Caption = 'Charges Amount';
            trigger OnValidate()
            begin
                if "Charges Amount" < 0 then
                    Error('Charges Amount cannot be negative !');
                "Total Amount" := "Amount To Transfer" + "Charges Amount";
            end;
        }
        field(19; "Charge Fee"; boolean)
        {
            Caption = 'Charge Fee';
            InitValue = false;
            trigger OnValidate()
            begin
                GenSaccSetup.Get;
                if "Charge Fee" = true then
                    "Charges Amount" := GenSaccSetup."Shares Transfer Fee (%)" / 100 * "Amount To Transfer"
                else
                    "Charges Amount" := 0;
            end;
        }
        field(20; "Total Amount"; Decimal)
        {
            // CalcFormula = field("Amount To Transfer") + field("Charges Amount");
            //     Editable = false;
            //     FieldClass = FlowField;
            Caption = 'Total Amount';
            Description = 'Specifies the Total Amount field.';
        }



    }
    keys
    {
        key(PK; "Reference No")
        {
            Clustered = true;
        }
    }
    trigger OnDelete()
    begin
        if Status = Status::Closed then begin
            Error('A Posted Transfer cannot be deleted !');
        end;
    end;

    trigger OnInsert()
    begin
        SalesSetup.Get;
        SalesSetup.TestField(SalesSetup."Shares Transfers Nos");
        NoSeriesMgt.InitSeries(SalesSetup."Shares Transfers Nos", xRec."No. Series", 0D, "Reference No", "No. Series");
        "Captured By" := UserId;
        "Date Captured" := Today;
        "Posting Date Used" := Today;
    end;

    var
        SalesSetup: record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenSaccSetup: Record "Sacco General Set-Up";
}
