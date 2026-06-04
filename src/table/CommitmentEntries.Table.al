table 50003 "Commitment Entries"
{
    DrillDownPageID = "Commitment Entries";
    LookupPageID = "Commitment Entries";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No';
        }
        field(2; "Commitment No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Commitment No';
        }
        field(3; "Commitment Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Commitment Date';
        }
        field(4; "Commitment Type"; Enum "Commitment Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Commitment Type';
        }
        field(5; Account; Code[20])
        {
            TableRelation = "G/L Account"."No.";
            DataClassification = CustomerContent;
            Caption = 'Account';
        }
        field(6; "Committed Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Committed Amount';
        }
        field(7; User; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'User';
        }
        field(8; "Document No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No';
        }
        field(9; No; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No';
        }
        field(10; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 1';
        }
        field(11; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 2';
        }
        field(12; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(13; "Account No."; Code[20])
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const(Vendor)) Vendor
            else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset";
            DataClassification = CustomerContent;
            Caption = 'Account No.';
        }
        field(14; "Account Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Account Name';
        }
        field(15; Description; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(16; "Account Type"; Enum "Gen. Journal Account Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Account Type';
        }
        field(17; "Uncommittment Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Uncommittment Date';
        }
        field(18; "Dimension Set ID"; Integer)
        {
            Editable = true;
            TableRelation = "Dimension Set Entry";
            DataClassification = CustomerContent;
            Caption = 'Dimension Set ID';

            trigger OnLookup()
            begin
                ShowDimensions();
            end;
        }
        field(19; "Last Modified By"; Code[50])
        {
            TableRelation = "User Setup";
            DataClassification = CustomerContent;
            Caption = 'Last Modified By';
        }
        field(20; "Document Type"; Enum "Commitment Document Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Document Type';
        }
        field(21; "Budget Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "G/L Budget Name".Name;
            Caption = 'Budget Code';
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
            SumIndexFields = "Committed Amount";
        }
        key(Key2; "Commitment No", "Commitment Type", No)
        {
            SumIndexFields = "Committed Amount";
        }
        key(Key3; "Document No", "Commitment Type")
        {
            SumIndexFields = "Committed Amount";
        }
        key(Key4; Account, "Commitment Date", "Global Dimension 1 Code", "Global Dimension 2 Code")
        {
            SumIndexFields = "Committed Amount";
        }
        key(Key5; No, "Commitment Date")
        {
            SumIndexFields = "Committed Amount";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*
       if "Commitment No" = '' then begin
         GenLedgerSetup.Get(GenLedgerSetup."Commitment No");
         GenLedgerSetup.TestField(GenLedgerSetup."Commitment No");
         NoSeriesMgt.InitSeries(GenLedgerSetup."Commitment No",xRec."No. Series",0D,"Commitment No","No. Series");
       end;
        */

    end;

    var
        DimMgt: Codeunit DimensionManagement;

    procedure ShowDimensions()
    begin

        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1', "Entry No"));
        //VerifyItemLineDim;
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1 Code", "Global Dimension 2 Code");
    end;
}





