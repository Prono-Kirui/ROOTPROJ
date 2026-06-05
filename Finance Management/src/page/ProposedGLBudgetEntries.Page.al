page 51084 "Proposed G/L Budget Entries"
{
    ApplicationArea = All;
    Caption = 'G/L Budget Entries';
    DataCaptionFields = "G/L Account No.", "Budget Name";
    DelayedInsert = true;
    PageType = List;
    SourceTable = "G/L Budget Entry";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                ShowCaption = false;

                field("Budget Name"; Rec."Budget Name")
                {
                    ApplicationArea = Suite;
                    Caption = 'Budget Name';
                    Editable = false;
                    ToolTip = 'Specifies the name of the G/L budget that the entry belongs to.';
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Suite;
                    Caption = 'Date';
                    ToolTip = 'Specifies the date of the budget entry.';
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ApplicationArea = Suite;
                    Caption = 'G/L Account No.';
                    ToolTip = 'Specifies the number of the G/L account that the budget entry applies to, or, the account on the line where the budget figure has been entered.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Suite;
                    Caption = 'Description';
                    ToolTip = 'Specifies a description of the budget figure.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Global Dimension 1 Code';
                    Enabled = GlobalDimension1CodeEnable;
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                    Visible = GlobalDimension1CodeVisible;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Global Dimension 2 Code';
                    Enabled = GlobalDimension2CodeEnable;
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                    Visible = GlobalDimension2CodeVisible;
                }
                field("Budget Dimension 1 Code"; Rec."Budget Dimension 1 Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Budget Dimension 1 Code';
                    Enabled = BudgetDimension1CodeEnable;
                    ToolTip = 'Specifies the dimension value code for the Budget Dimension 1 Code the budget entry is linked to.';
                    Visible = BudgetDimension1CodeVisible;
                }
                field("Budget Dimension 2 Code"; Rec."Budget Dimension 2 Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Budget Dimension 2 Code';
                    Enabled = BudgetDimension2CodeEnable;
                    ToolTip = 'Specifies the dimension value code for the Budget Dimension 2 Code the budget entry is linked to.';
                    Visible = BudgetDimension2CodeVisible;
                }
                field("Budget Dimension 3 Code"; Rec."Budget Dimension 3 Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Budget Dimension 3 Code';
                    Enabled = BudgetDimension3CodeEnable;
                    ToolTip = 'Specifies the dimension value code for the Budget Dimension 3 Code the budget entry is linked to.';
                    Visible = BudgetDimension3CodeVisible;
                }
                field("Budget Dimension 4 Code"; Rec."Budget Dimension 4 Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Budget Dimension 4 Code';
                    Enabled = BudgetDimension4CodeEnable;
                    ToolTip = 'Specifies the dimension value code for the Budget Dimension 4 Code the budget entry is linked to.';
                    Visible = BudgetDimension4CodeVisible;
                }
                field("Business Unit Code"; Rec."Business Unit Code")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Business Unit Code';
                    ToolTip = 'Specifies the code for the business unit that the budget entry is linked to.';
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Suite;
                    Caption = 'Amount';
                    ToolTip = 'Specifies the amount of the budget entry.';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = Suite;
                    Caption = 'Entry No.';
                    Editable = false;
                    ToolTip = 'Specifies the budget line''s entry number.';
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = Suite;
                    Caption = 'Dimension Set ID';
                    ToolTip = 'Specifies a reference to a combination of dimension values. The actual values are stored in the Dimension Set Entry table.';
                    Visible = false;
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            group("Ent&ry")
            {
                Caption = 'Ent&ry';
                Image = Entry;

                action(Dimensions)
                {
                    AccessByPermission = tabledata Dimension = R;
                    ApplicationArea = Suite;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortcutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions();
                        CurrPage.SaveRecord();
                    end;
                }
                action(SetDimensionFilter)
                {
                    ApplicationArea = Suite;
                    Caption = 'Set Dimension Filter';
                    Ellipsis = true;
                    Image = "Filter";
                    ToolTip = 'Limit the entries according to dimension filters that you specify.';

                    trigger OnAction()
                    begin
                        Rec.SetFilter("Dimension Set ID", DimensionSetIDFilter.LookupFilter());
                    end;
                }
            }
        }
    }

    var
        GLBudgetName: Record "G/L Budget Name";
        GLSetup: Record "General Ledger Setup";
        DimensionSetIDFilter: Page "Dimension Set ID Filter";
        BudgetDimension1CodeEnable: Boolean;
        BudgetDimension1CodeVisible: Boolean;
        BudgetDimension2CodeEnable: Boolean;
        BudgetDimension2CodeVisible: Boolean;
        BudgetDimension3CodeEnable: Boolean;
        BudgetDimension3CodeVisible: Boolean;
        BudgetDimension4CodeEnable: Boolean;
        BudgetDimension4CodeVisible: Boolean;
        GlobalDimension1CodeEnable: Boolean;
        GlobalDimension1CodeVisible: Boolean;
        GlobalDimension2CodeEnable: Boolean;
        GlobalDimension2CodeVisible: Boolean;
        IsEditable: Boolean;
        LowestModifiedEntryNo: Integer;

    trigger OnInit()
    begin
        BudgetDimension4CodeEnable := true;
        BudgetDimension3CodeEnable := true;
        BudgetDimension2CodeEnable := true;
        BudgetDimension1CodeEnable := true;
        GlobalDimension2CodeEnable := true;
        GlobalDimension1CodeEnable := true;
        BudgetDimension4CodeVisible := true;
        BudgetDimension3CodeVisible := true;
        BudgetDimension2CodeVisible := true;
        BudgetDimension1CodeVisible := true;
        GlobalDimension2CodeVisible := true;
        GlobalDimension1CodeVisible := true;
        LowestModifiedEntryNo := 2147483647;
    end;

    trigger OnOpenPage()
    var
        GLBudgetName: Record "G/L Budget Name";
    begin
        if Rec.GetFilter("Budget Name") = '' then
            GLBudgetName.Init()
        else begin
            Rec.CopyFilter("Budget Name", GLBudgetName.Name);
            GLBudgetName.FindFirst();
        end;
        CurrPage.Editable := not GLBudgetName.Blocked and IsEditable;
        GLSetup.Get();
        GlobalDimension1CodeEnable := GLSetup."Global Dimension 1 Code" <> '';
        GlobalDimension2CodeEnable := GLSetup."Global Dimension 2 Code" <> '';
        BudgetDimension1CodeEnable := GLBudgetName."Budget Dimension 1 Code" <> '';
        BudgetDimension2CodeEnable := GLBudgetName."Budget Dimension 2 Code" <> '';
        BudgetDimension3CodeEnable := GLBudgetName."Budget Dimension 3 Code" <> '';
        BudgetDimension4CodeEnable := GLBudgetName."Budget Dimension 4 Code" <> '';
        GlobalDimension1CodeVisible := GLSetup."Global Dimension 1 Code" <> '';
        GlobalDimension2CodeVisible := GLSetup."Global Dimension 2 Code" <> '';
        BudgetDimension1CodeVisible := GLBudgetName."Budget Dimension 1 Code" <> '';
        BudgetDimension2CodeVisible := GLBudgetName."Budget Dimension 2 Code" <> '';
        BudgetDimension3CodeVisible := GLBudgetName."Budget Dimension 3 Code" <> '';
        BudgetDimension4CodeVisible := GLBudgetName."Budget Dimension 4 Code" <> '';
    end;

    trigger OnClosePage()
    var
        UpdateAnalysisView: Codeunit "Update Analysis View";
    begin
        if LowestModifiedEntryNo < 2147483647 then
            UpdateAnalysisView.SetLastBudgetEntryNo(LowestModifiedEntryNo - 1);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if Rec.GetFilter("Budget Name") <> '' then
            Rec."Budget Name" := Rec.GetRangeMin("Budget Name");
        if GLBudgetName.Name <> Rec."Budget Name" then
            GLBudgetName.Get(Rec."Budget Name");
        if Rec.GetFilter("G/L Account No.") <> '' then
            Rec."G/L Account No." := GetFirstGLAcc(Rec.GetFilter("G/L Account No."));
        Rec.Date := GetFirstDate(Rec.GetFilter(Date));
        Rec."User ID" := UserId;

        if Rec.GetFilter("Global Dimension 1 Code") <> '' then
            Rec."Global Dimension 1 Code" :=
              GetFirstDimValue(GLSetup."Global Dimension 1 Code", Rec.GetFilter("Global Dimension 1 Code"));

        if Rec.GetFilter("Global Dimension 2 Code") <> '' then
            Rec."Global Dimension 2 Code" :=
              GetFirstDimValue(GLSetup."Global Dimension 2 Code", Rec.GetFilter("Global Dimension 2 Code"));

        if Rec.GetFilter("Budget Dimension 1 Code") <> '' then
            Rec."Budget Dimension 1 Code" :=
              GetFirstDimValue(GLBudgetName."Budget Dimension 1 Code", Rec.GetFilter("Budget Dimension 1 Code"));

        if Rec.GetFilter("Budget Dimension 2 Code") <> '' then
            Rec."Budget Dimension 2 Code" :=
              GetFirstDimValue(GLBudgetName."Budget Dimension 2 Code", Rec.GetFilter("Budget Dimension 2 Code"));

        if Rec.GetFilter("Budget Dimension 3 Code") <> '' then
            Rec."Budget Dimension 3 Code" :=
              GetFirstDimValue(GLBudgetName."Budget Dimension 3 Code", Rec.GetFilter("Budget Dimension 3 Code"));

        if Rec.GetFilter("Budget Dimension 4 Code") <> '' then
            Rec."Budget Dimension 4 Code" :=
              GetFirstDimValue(GLBudgetName."Budget Dimension 4 Code", Rec.GetFilter("Budget Dimension 4 Code"));

        if Rec.GetFilter("Business Unit Code") <> '' then
            Rec."Business Unit Code" := GetFirstBusUnit(Rec.GetFilter("Business Unit Code"));
    end;

    trigger OnModifyRecord(): Boolean
    begin
        if Rec."Entry No." < LowestModifiedEntryNo then
            LowestModifiedEntryNo := Rec."Entry No.";
        exit(true);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        if Rec."Entry No." < LowestModifiedEntryNo then
            LowestModifiedEntryNo := Rec."Entry No.";
        exit(IsEditable);
    end;

    procedure SetEditable(NewIsEditable: Boolean)
    begin
        IsEditable := NewIsEditable;
    end;

    local procedure GetFirstBusUnit(BusUnitFilter: Text[250]): Code[20]
    var
        BusUnit: Record "Business Unit";
    begin
        BusUnit.SetFilter(Code, BusUnitFilter);
        if BusUnit.FindFirst() then
            exit(BusUnit.Code);

        exit('');
    end;

    local procedure GetFirstDate(DateFilter: Text[250]): Date
    var
        Period: Record Date;
    begin
        if DateFilter = '' then
            exit(0D);
        Period.SetRange("Period Type", Period."Period Type"::Date);
        Period.SetFilter("Period Start", DateFilter);
        if Period.FindFirst() then
            exit(Period."Period Start");

        exit(0D);
    end;

    local procedure GetFirstDimValue(DimCode: Code[20]; DimValFilter: Text[250]): Code[20]
    var
        DimVal: Record "Dimension Value";
    begin
        if (DimCode = '') or (DimValFilter = '') then
            exit('');
        DimVal.SetRange("Dimension Code", DimCode);
        DimVal.SetFilter(Code, DimValFilter);
        if DimVal.FindFirst() then
            exit(DimVal.Code);

        exit('');
    end;

    local procedure GetFirstGLAcc(GLAccFilter: Text[250]): Code[20]
    var
        GLAcc: Record "G/L Account";
    begin
        GLAcc.SetFilter("No.", GLAccFilter);
        if GLAcc.FindFirst() then
            exit(GLAcc."No.");

        exit('');
    end;
}
