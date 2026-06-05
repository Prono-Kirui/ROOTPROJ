tableextension 51004 "GL Budget Entry Ext" extends "G/L Budget Entry"
{
    fields
    {
        field(51000; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Global Dimension 3 Code';
            CaptionClass = '1,2,3';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));

            trigger OnValidate()
            begin
                if "Global Dimension 2 Code" = '' then
                    exit;
                GetGLSetup();
                ValidateDimValue(GLSetup."Global Dimension 2 Code", "Global Dimension 2 Code");
            end;
        }
        field(51001; "Budget Status"; Option)
        {
            Caption = 'Budget Status';
            DataClassification = CustomerContent;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(51002; Transferred; Boolean)
        {
            Caption = 'Transferred';
            DataClassification = CustomerContent;
        }
        field(51003; "Transferred from/To Ac."; Code[20])
        {
            Caption = 'Transferred from/To Ac.';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
        }
    }

    var
        GLSetup: Record "General Ledger Setup";
        GLSetupRetrieved: Boolean;
        Text000: Label 'The dimension value %1 has not been set up for dimension %2.';

    procedure GetNextEntryNo(): Integer
    var
        GLBudgetEntry: Record "G/L Budget Entry";
    begin
        GLBudgetEntry.SetCurrentKey("Entry No.");
        if GLBudgetEntry.FindLast() then
            exit(GLBudgetEntry."Entry No." + 1);

        exit(1);
    end;

    local procedure GetGLSetup()
    begin
        if not GLSetupRetrieved then begin
            GLSetup.Get();
            GLSetupRetrieved := true;
        end;
    end;

    local procedure ValidateDimValue(DimCode: Code[20]; var DimValueCode: Code[20])
    var
        DimValue: Record "Dimension Value";
    begin
        if DimValueCode = '' then
            exit;

        DimValue."Dimension Code" := DimCode;
        DimValue.Code := DimValueCode;
        DimValue.Find('=><');
        if DimValueCode <> CopyStr(DimValue.Code, 1, StrLen(DimValueCode)) then
            Error(Text000, DimValueCode, DimCode);
        DimValueCode := DimValue.Code;
    end;
}
