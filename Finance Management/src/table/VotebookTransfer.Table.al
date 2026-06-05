table 51008 "Votebook Transfer"
{
    Caption = 'Votebook Transfer';
    DataClassification = CustomerContent;
    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    CashManagementSetup.Get();
                    CashManagementSetup.TestField("Proposed Budget Approval Nos");
                    NoSeriesManagement.TestManual(CashManagementSetup."Proposed Budget Approval Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
        }
        field(3; "Source Vote"; Code[20])
        {
            Caption = 'Source G/L Account';
            TableRelation = "G/L Account"."No.";
        }
        field(4; "Destination Vote"; Code[20])
        {
            Caption = 'Destination G/L Account';
            TableRelation = "G/L Account"."No.";
        }
        field(5; "Budget Name"; Code[20])
        {
            Caption = 'Budget Name';
            TableRelation = "G/L Budget Name".Name where(Blocked = const(false));
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(7; "Source Dimension 1"; Code[20])
        {
            Caption = 'Source Dimension 1';
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));
        }
        field(8; "Destination Dimension 1"; Code[20])
        {
            Caption = 'Destination Dimension 1';
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));

            trigger OnValidate()
            begin
                //IF (("Destination Dimension 1"<>'') AND ("Destination Dimension 1"<>"Source Dimension 1")) THEN
                // ERROR(DimError,FIELDCAPTION("Destination Dimension 1"),"Destination Dimension 1",FIELDCAPTION("Source Dimension 1"),"Source Dimension 1");
            end;
        }
        field(10; "Source Dimension 2"; Code[20])
        {
            Caption = 'Source Dimension 2';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = const(false));
        }
        field(11; "Destination Dimension 2"; Code[20])
        {
            Caption = 'Destination Dimension 2';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = const(false));

            trigger OnValidate()
            begin
                //IF (("Destination Dimension 2"<>'') AND ("Destination Dimension 2"<>"Source Dimension 2")) THEN
                // ERROR(DimError,FIELDCAPTION("Destination Dimension 2"),"Destination Dimension 2",FIELDCAPTION("Source Dimension 2"),"Source Dimension 2");
            end;
        }
        field(12; Remarks; Text[150])
        {
            Caption = 'Remarks';
        }
        field(13; "Raised By"; Code[25])
        {
            Caption = 'Raised By';
        }
        field(14; "Raised Date"; Date)
        {
            Caption = 'Raised Date';
        }
        field(15; "Approved By"; Code[20])
        {
            Caption = 'Approved By';
        }
        field(16; "Approved Date"; Date)
        {
            Caption = 'Approved Date';
        }
        field(17; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(18; Posted; Boolean)
        {
            Caption = 'Posted';
        }
        field(19; "Posted Date"; Date)
        {
            Caption = 'Posted Date';
        }
        field(20; "Posted By"; Code[25])
        {
            Caption = 'Posted By';
        }
        field(23; Status; Option)
        {
            Caption = 'Status';
            Editable = true;
            OptionCaption = 'Open,Approved,Pending Approval,Closed,Archived';
            OptionMembers = Open,Approved,"Pending Approval",Closed,Archived;
        }
        field(24; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(25; "Source Vote Name"; Text[100])
        {
            CalcFormula = lookup("G/L Account".Name where("No." = field("Source Vote")));
            Caption = 'Source G/L Account Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(26; "Destination Vote Name"; Text[100])
        {
            CalcFormula = lookup("G/L Account".Name where("No." = field("Destination Vote")));
            Caption = 'Destination G/L Account Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; "Balance As At"; Option)
        {
            Caption = 'Balance As At';
            OptionCaption = ' ,Today,End of Financial Year';
            OptionMembers = " ",Today,"End of Financial Year";
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    var
        CashManagementSetup: Record "Cash Management Setups";
        NoSeriesManagement: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        if No = '' then begin
            CashManagementSetup.Get();
            CashManagementSetup.TestField("Proposed Budget Approval Nos");
            NoSeriesManagement.InitSeries(CashManagementSetup."Proposed Budget Approval Nos", xRec."No. Series", 0D, No, "No. Series");
        end;

        "Raised By" := UserId;
        "Raised Date" := Today;
    end;
}
