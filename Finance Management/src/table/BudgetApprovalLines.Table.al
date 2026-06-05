table 51010 "Budget Approval Lines"
{
    Caption = 'Budget Approval Lines';
    DataClassification = CustomerContent;
    DrillDownPageId = "G/L Budget Entries";
    LookupPageId = "G/L Budget Entries";
    Permissions = tabledata "Analysis View Budget Entry" = rd;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Budget Name"; Code[10])
        {
            Caption = 'Budget Name';
            TableRelation = "G/L Budget Name";
        }
        field(3; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                if Rec."G/L Account No." <> xRec."G/L Account No." then begin
                    GLAccount.Get(Rec."G/L Account No.");
                    "G/L Account Name" := GLAccount.Name;
                end;
            end;
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
            ClosingDates = true;
        }
        field(5; "Global Dimension 1 Code"; Code[30])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));

            trigger OnValidate()
            begin
                if "Global Dimension 1 Code" = xRec."Global Dimension 1 Code" then
                    exit;
                GetGLSetup();
                ValidateDimValue(GLSetup."Global Dimension 1 Code", "Global Dimension 1 Code");
                UpdateDimensionSetId(GLSetup."Global Dimension 1 Code", "Global Dimension 1 Code");
            end;
        }
        field(6; "Global Dimension 2 Code"; Code[30])
        {
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = const(false));

            trigger OnValidate()
            begin
                if "Global Dimension 2 Code" = xRec."Global Dimension 2 Code" then
                    exit;
                GetGLSetup();
                ValidateDimValue(GLSetup."Global Dimension 2 Code", "Global Dimension 2 Code");
                UpdateDimensionSetId(GLSetup."Global Dimension 2 Code", "Global Dimension 2 Code");
            end;
        }
        field(7; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(8; "G/L Account Name"; Text[150])
        {
            Caption = 'G/L Account Name';
            Editable = false;
        }
        field(9; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(10; "Business Unit Code"; Code[20])
        {
            Caption = 'Business Unit Code';
            TableRelation = "Business Unit";
        }
        field(11; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Editable = false;
            TableRelation = User."User Name";

            //This property is currently not supported
            //TestTableRelation = false;
            trigger OnLookup()
            begin
                //UserMgt.LookupUserID("User ID");
            end;
        }
        field(12; "Budget Dimension 1 Code"; Code[20])
        {
            AccessByPermission = tabledata Dimension = R;
            Caption = 'Budget Dimension 1 Code';
            CaptionClass = GetCaptionClass(1);

            trigger OnValidate()
            begin
                if "Budget Dimension 1 Code" = xRec."Budget Dimension 1 Code" then
                    exit;
                if GLBudgetName.Name <> "Budget Name" then
                    GLBudgetName.Get("Budget Name");
                ValidateDimValue(GLBudgetName."Budget Dimension 1 Code", "Budget Dimension 1 Code");
                UpdateDimensionSetId(GLBudgetName."Budget Dimension 1 Code", "Budget Dimension 1 Code");
            end;

            trigger OnLookup()
            begin
                "Budget Dimension 1 Code" := OnLookupDimCode(2, "Budget Dimension 1 Code");
            end;
        }
        field(13; "Budget Dimension 2 Code"; Code[20])
        {
            AccessByPermission = tabledata Dimension = R;
            Caption = 'Budget Dimension 2 Code';
            CaptionClass = GetCaptionClass(2);

            trigger OnValidate()
            begin
                if "Budget Dimension 2 Code" = xRec."Budget Dimension 2 Code" then
                    exit;
                if GLBudgetName.Name <> "Budget Name" then
                    GLBudgetName.Get("Budget Name");
                ValidateDimValue(GLBudgetName."Budget Dimension 2 Code", "Budget Dimension 2 Code");
                UpdateDimensionSetId(GLBudgetName."Budget Dimension 2 Code", "Budget Dimension 2 Code");
            end;

            trigger OnLookup()
            begin
                "Budget Dimension 2 Code" := OnLookupDimCode(3, "Budget Dimension 2 Code");
            end;
        }
        field(14; "Budget Dimension 3 Code"; Code[20])
        {
            AccessByPermission = tabledata "Dimension Combination" = R;
            Caption = 'Budget Dimension 3 Code';
            CaptionClass = GetCaptionClass(3);

            trigger OnValidate()
            begin
                if "Budget Dimension 3 Code" = xRec."Budget Dimension 3 Code" then
                    exit;
                if GLBudgetName.Name <> "Budget Name" then
                    GLBudgetName.Get("Budget Name");
                ValidateDimValue(GLBudgetName."Budget Dimension 3 Code", "Budget Dimension 3 Code");
                UpdateDimensionSetId(GLBudgetName."Budget Dimension 3 Code", "Budget Dimension 3 Code");
            end;

            trigger OnLookup()
            begin
                "Budget Dimension 3 Code" := OnLookupDimCode(4, "Budget Dimension 3 Code");
            end;
        }
        field(15; "Budget Dimension 4 Code"; Code[20])
        {
            AccessByPermission = tabledata "Dimension Combination" = R;
            Caption = 'Budget Dimension 4 Code';
            CaptionClass = GetCaptionClass(4);

            trigger OnValidate()
            begin
                if "Budget Dimension 4 Code" = xRec."Budget Dimension 4 Code" then
                    exit;
                if GLBudgetName.Name <> "Budget Name" then
                    GLBudgetName.Get("Budget Name");
                ValidateDimValue(GLBudgetName."Budget Dimension 4 Code", "Budget Dimension 4 Code");
                UpdateDimensionSetId(GLBudgetName."Budget Dimension 4 Code", "Budget Dimension 4 Code");
            end;

            trigger OnLookup()
            begin
                "Budget Dimension 4 Code" := OnLookupDimCode(5, "Budget Dimension 4 Code");
            end;
        }
        field(16; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnValidate()
            begin
                if not DimMgt.CheckDimIDComb("Dimension Set ID") then
                    Error(DimMgt.GetDimCombErr());
            end;

            trigger OnLookup()
            begin
                ShowDimensions();
            end;
        }
        field(50000; "Global Dimension 3 Code"; Code[20])
        {
            Caption = 'Global Dimension 3 Code';
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));

            trigger OnValidate()
            begin
                if "Global Dimension 2 Code" = '' then
                    exit;
                GetGLSetup();
                ValidateDimValue(GLSetup."Global Dimension 2 Code", "Global Dimension 2 Code");
            end;
        }
        field(50001; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(50002; Proposed; Boolean)
        {
            Caption = 'Proposed';
        }
        field(50003; Posted; Boolean)
        {
            Caption = 'Posted';
        }
        field(50004; "Posted By"; Code[70])
        {
            Caption = 'Posted By';
        }
        field(50005; "Date-Time Posted"; DateTime)
        {
            Caption = 'Date-Time Posted';
        }
        field(50006; "Budget Status"; Option)
        {
            Caption = 'Budget Status';
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Budget Name", "G/L Account No.", Date)
        {
            SumIndexFields = Amount;
        }
        key(Key3; "Budget Name", "G/L Account No.", "Business Unit Code", "Global Dimension 1 Code", "Global Dimension 2 Code", "Budget Dimension 1 Code", "Budget Dimension 2 Code", "Budget Dimension 3 Code", "Budget Dimension 4 Code", Date)
        {
            SumIndexFields = Amount;
        }
        key(Key4; "Budget Name", "G/L Account No.", Description, Date)
        {
        }
        key(Key5; "G/L Account No.", Date, "Budget Name", "Dimension Set ID")
        {
            SumIndexFields = Amount;
        }
        key(Key6; "Last Date Modified", "Budget Name")
        {
        }
    }

    var
        BudgetHeader: Record "Budget Approval Header";
        DimVal: Record "Dimension Value";
        GLAccount: Record "G/L Account";
        GLBudgetName: Record "G/L Budget Name";
        GLSetup: Record "General Ledger Setup";
        DimMgt: Codeunit DimensionManagement;
        GLSetupRetrieved: Boolean;
        Text000: Label 'The dimension value %1 has not been set up for dimension %2.';
        Text001: Label '1,5,,Budget Dimension 1 Code';
        Text002: Label '1,5,,Budget Dimension 2 Code';
        Text003: Label '1,5,,Budget Dimension 3 Code';
        Text004: Label '1,5,,Budget Dimension 4 Code';

    trigger OnInsert()
    var
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
    begin
        CheckIfBlocked();
        TestField(Date);
        //TESTFIELD("G/L Account No.");
        TestField("Budget Name");
        LockTable();
        "User ID" := UserId;
        "Last Date Modified" := Today;
        if "Entry No." = 0 then
            "Entry No." := GetNextEntryNo();

        GetGLSetup();
        DimMgt.GetDimensionSet(TempDimSetEntry, "Dimension Set ID");
        UpdateDimSet(TempDimSetEntry, GLSetup."Global Dimension 1 Code", "Global Dimension 1 Code");
        UpdateDimSet(TempDimSetEntry, GLSetup."Global Dimension 2 Code", "Global Dimension 2 Code");
        UpdateDimSet(TempDimSetEntry, GLBudgetName."Budget Dimension 1 Code", "Budget Dimension 1 Code");
        UpdateDimSet(TempDimSetEntry, GLBudgetName."Budget Dimension 2 Code", "Budget Dimension 2 Code");
        UpdateDimSet(TempDimSetEntry, GLBudgetName."Budget Dimension 3 Code", "Budget Dimension 3 Code");
        UpdateDimSet(TempDimSetEntry, GLBudgetName."Budget Dimension 4 Code", "Budget Dimension 4 Code");
        Validate("Dimension Set ID", DimMgt.GetDimensionSetID(TempDimSetEntry));

        BudgetHeader.Get("Document No.");
        Validate("Global Dimension 1 Code", BudgetHeader."Global Dimension 1 Code");
        Validate("Global Dimension 2 Code", BudgetHeader."Global Dimension 2 Code");
    end;

    trigger OnModify()
    begin
        CheckIfBlocked();
        "User ID" := UserId;
        "Last Date Modified" := Today;
    end;

    trigger OnDelete()
    begin
        CheckIfBlocked();
        DeleteAnalysisViewBudgetEntries();
    end;

    procedure ShowDimensions()
    var
        DimSetEntry: Record "Dimension Set Entry";
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
            "Dimension Set ID", StrSubstNo('%1 %2 %3', "Budget Name", "G/L Account No.", "Entry No."));

        if OldDimSetID = "Dimension Set ID" then
            exit;

        GetGLSetup();
        GLBudgetName.Get("Budget Name");

        "Global Dimension 1 Code" := '';
        "Global Dimension 2 Code" := '';
        "Budget Dimension 1 Code" := '';
        "Budget Dimension 2 Code" := '';
        "Budget Dimension 3 Code" := '';
        "Budget Dimension 4 Code" := '';

        if DimSetEntry.Get("Dimension Set ID", GLSetup."Global Dimension 1 Code") then
            "Global Dimension 1 Code" := DimSetEntry."Dimension Value Code";
        if DimSetEntry.Get("Dimension Set ID", GLSetup."Global Dimension 2 Code") then
            "Global Dimension 2 Code" := DimSetEntry."Dimension Value Code";
        if DimSetEntry.Get("Dimension Set ID", GLBudgetName."Budget Dimension 1 Code") then
            "Budget Dimension 1 Code" := DimSetEntry."Dimension Value Code";
        if DimSetEntry.Get("Dimension Set ID", GLBudgetName."Budget Dimension 2 Code") then
            "Budget Dimension 2 Code" := DimSetEntry."Dimension Value Code";
        if DimSetEntry.Get("Dimension Set ID", GLBudgetName."Budget Dimension 3 Code") then
            "Budget Dimension 3 Code" := DimSetEntry."Dimension Value Code";
        if DimSetEntry.Get("Dimension Set ID", GLBudgetName."Budget Dimension 4 Code") then
            "Budget Dimension 4 Code" := DimSetEntry."Dimension Value Code";
    end;

    procedure UpdateDimSet(var TempDimSetEntry: Record "Dimension Set Entry" temporary; DimCode: Code[20]; DimValueCode: Code[20])
    begin
        if DimCode = '' then
            exit;
        if TempDimSetEntry.Get("Dimension Set ID", DimCode) then
            TempDimSetEntry.Delete();
        if DimValueCode = '' then
            DimVal.Init()
        else
            DimVal.Get(DimCode, DimValueCode);
        TempDimSetEntry.Init();
        TempDimSetEntry."Dimension Set ID" := "Dimension Set ID";
        TempDimSetEntry."Dimension Code" := DimCode;
        TempDimSetEntry."Dimension Value Code" := DimValueCode;
        TempDimSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
        TempDimSetEntry.Insert();
    end;

    local procedure CheckIfBlocked()
    begin
        if "Budget Name" = GLBudgetName.Name then
            exit;
        if GLBudgetName.Name <> "Budget Name" then
            GLBudgetName.Get("Budget Name");
        GLBudgetName.TestField(Blocked, false);
    end;

    local procedure DeleteAnalysisViewBudgetEntries()
    var
        AnalysisViewBudgetEntry: Record "Analysis View Budget Entry";
    begin
        AnalysisViewBudgetEntry.SetRange("Budget Name", "Budget Name");
        AnalysisViewBudgetEntry.SetRange("Entry No.", "Entry No.");
        AnalysisViewBudgetEntry.DeleteAll();
    end;

    local procedure GetCaptionClass(BudgetDimType: Integer): Text[250]
    begin
        if GetFilter("Budget Name") <> '' then begin
            GLBudgetName.SetFilter(Name, GetFilter("Budget Name"));
            if not GLBudgetName.FindFirst() then
                Clear(GLBudgetName);
        end;
        case BudgetDimType of
            1:
                begin
                    if GLBudgetName."Budget Dimension 1 Code" <> '' then
                        exit('1,5,' + GLBudgetName."Budget Dimension 1 Code");

                    exit(Text001);
                end;
            2:
                begin
                    if GLBudgetName."Budget Dimension 2 Code" <> '' then
                        exit('1,5,' + GLBudgetName."Budget Dimension 2 Code");

                    exit(Text002);
                end;
            3:
                begin
                    if GLBudgetName."Budget Dimension 3 Code" <> '' then
                        exit('1,5,' + GLBudgetName."Budget Dimension 3 Code");

                    exit(Text003);
                end;
            4:
                begin
                    if GLBudgetName."Budget Dimension 4 Code" <> '' then
                        exit('1,5,' + GLBudgetName."Budget Dimension 4 Code");

                    exit(Text004);
                end;
        end;
    end;

    local procedure GetGLSetup()
    begin
        if not GLSetupRetrieved then begin
            GLSetup.Get();
            GLSetupRetrieved := true;
        end;
    end;

    local procedure GetNextEntryNo(): Integer
    var
        GLBudgetEntry: Record "Budget Approval Lines";
    begin
        GLBudgetEntry.SetCurrentKey("Entry No.");
        if GLBudgetEntry.FindLast() then
            exit(GLBudgetEntry."Entry No." + 1);

        exit(1);
    end;

    local procedure OnLookupDimCode(DimOption: Option "Global Dimension 1","Global Dimension 2","Budget Dimension 1","Budget Dimension 2","Budget Dimension 3","Budget Dimension 4"; DefaultValue: Code[20]): Code[20]
    var
        DimValue: Record "Dimension Value";
        DimValueList: Page "Dimension Value List";
    begin
        if DimOption in [DimOption::"Global Dimension 1", DimOption::"Global Dimension 2"] then
            GetGLSetup()
        else
            if GLBudgetName.Name <> "Budget Name" then
                GLBudgetName.Get("Budget Name");
        case DimOption of
            DimOption::"Global Dimension 1":
                DimValue."Dimension Code" := GLSetup."Global Dimension 1 Code";
            DimOption::"Global Dimension 2":
                DimValue."Dimension Code" := GLSetup."Global Dimension 2 Code";
            DimOption::"Budget Dimension 1":
                DimValue."Dimension Code" := GLBudgetName."Budget Dimension 1 Code";
            DimOption::"Budget Dimension 2":
                DimValue."Dimension Code" := GLBudgetName."Budget Dimension 2 Code";
            DimOption::"Budget Dimension 3":
                DimValue."Dimension Code" := GLBudgetName."Budget Dimension 3 Code";
            DimOption::"Budget Dimension 4":
                DimValue."Dimension Code" := GLBudgetName."Budget Dimension 4 Code";
        end;
        DimValue.SetRange("Dimension Code", DimValue."Dimension Code");
        if DimValue.Get(DimValue."Dimension Code", DefaultValue) then;
        DimValueList.SetTableView(DimValue);
        DimValueList.SetRecord(DimValue);
        DimValueList.LookupMode := true;
        if DimValueList.RunModal() = Action::LookupOK then begin
            DimValueList.GetRecord(DimValue);
            exit(DimValue.Code);
        end;
        exit(DefaultValue);
    end;

    local procedure UpdateDimensionSetId(DimCode: Code[20]; DimValueCode: Code[20])
    var
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
    begin
        DimMgt.GetDimensionSet(TempDimSetEntry, "Dimension Set ID");
        UpdateDimSet(TempDimSetEntry, DimCode, DimValueCode);
        "Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);
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
