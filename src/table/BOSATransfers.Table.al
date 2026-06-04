Table 50264 "BOSA Transfers"
{
    DrillDownPageID = "BOSA Transfer List";
    LookupPageID = "BOSA Transfer List";

    fields
    {
        field(1; No; Code[10])
        {
            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    NoSetup.Get();
                    NoSeriesMgt.TestManual(NoSetup."BOSA Transfer Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Transaction Date"; Date)
        {
        }
        field(3; "Schedule Total"; Decimal)
        {
            CalcFormula = sum("BOSA Transfer Schedule"."Total Amount" where("No." = field(No)));
            FieldClass = FlowField;
        }
        field(4; Approved; Boolean)
        {
        }
        field(5; "Approved By"; Code[60])
        {
        }
        field(6; Posted; Boolean)
        {
        }
        field(7; "No. Series"; Code[20])
        {
        }
        field(8; "Responsibility Center"; Code[10])
        {
        }
        field(9; Remarks; Code[30])
        {
        }
        field(10; Description; Text[50])
        {
        }
        field(11; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(12; "Branch Code"; Code[10])
        {
        }
        field(13; "Captured By"; Code[50])
        {
        }
        //Charges
        field(14; "Transfer Fee"; Decimal)
        {
        }
        field(15; charges; Boolean)
        {

            Caption = 'Include Transfer Fee';
            DataClassification = CustomerContent;
            Description = 'Indicates that the transfer fee is to be included in the transaction.';
            Editable = true;
            trigger OnValidate()
            begin
                if charges then begin
                    if GenSaccSetup."Include Transfer Fee (%)" = true then
                        "Transfer Fee" := GenSaccSetup."Transfer Fee (%)" / 100 * "Schedule Total";
                    if GenSaccSetup."Include Transfer Fee (%)" = false then
                        "Transfer Fee" := GenSaccSetup."Transfer Fee (%)";
                end else begin
                    "Transfer Fee" := 0;
                end;
            end;
        }
    }
    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        if Approved or Posted then
            Error('Cannot delete posted or approved batch');
    end;

    trigger OnInsert()
    begin
        if No = '' then begin
            NoSetup.Get;
            NoSetup.TestField(NoSetup."BOSA Transfer Nos");
            NoSeriesMgt.InitSeries(NoSetup."BOSA Transfer Nos", xRec."No. Series", 0D, No, "No. Series");
        end;
        "Transaction Date" := Today;
        "Captured By" := UserId;
    end;

    trigger OnModify()
    begin
        if Posted then Error('Cannot modify a posted batch');
    end;

    trigger OnRename()
    begin
        if Posted then Error('Cannot rename a posted batch');
    end;

    var
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenSaccSetup: Record "Sacco General Set-Up";
}
