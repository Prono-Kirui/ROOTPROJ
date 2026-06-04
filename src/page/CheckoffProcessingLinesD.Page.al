#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50483 "Checkoff Processing Lines-D"
{
    DelayedInsert = false;
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Checkoff Lines-Distributed";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Payroll No"; Rec."Payroll No")
                {
                    ApplicationArea = Basic;
                    StyleExpr = CoveragePercentStyle;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Checkoff No"; Rec."Checkoff No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Deposits; Rec.Deposits)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(NORM_P; Rec.NORM_P)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(NORM_I; Rec.NORM_I)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(REFIN_P; Rec.REFIN_P)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(REFIN_I; Rec.REFIN_I)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(EMER_P; Rec.EMER_P)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(EMER_I; Rec.EMER_I)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(SCHOOL_P; Rec.SCHOOL_P)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(SCHOOL_I; Rec.SCHOOL_I)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(SPECIAL_P; Rec.SPECIAL_P)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(SPECIAL_I; Rec.SPECIAL_I)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(INSURANCE; Rec.INSURANCE)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(GOLDSAVE; Rec.GOLDSAVE)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(THIRDPARTY; Rec.THIRDPARTY)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(BENEVOLENT; Rec.BENEVOLENT)
                {
                    ApplicationArea = Basic;
                }
                field(ADVANCE_P; Rec.ADVANCE_P)
                {
                    ApplicationArea = Basic;
                }
                field(ADVANCE_I; Rec.ADVANCE_I)
                {
                    ApplicationArea = Basic;
                }
                field(PHONE_P; Rec.PHONE_P)
                {
                    ApplicationArea = Basic;
                }
                field(PHONE_I; Rec.PHONE_I)
                {
                    ApplicationArea = Basic;
                }
                field(ADVANCENSE_P; Rec.ADVANCENSE_P)
                {
                    ApplicationArea = Basic;
                }
                field(ADVANCENSE_I; Rec.ADVANCENSE_I)
                {
                    ApplicationArea = Basic;
                }
                field(SHARES; Rec.SHARES)
                {
                    ApplicationArea = Basic;
                }
                field(TOTAL_DISTRIBUTED; Rec.TOTAL_DISTRIBUTED)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        SetStyles();
    end;

    var
        CoveragePercentStyle: Text;

    local procedure SetStyles()
    begin
        CoveragePercentStyle := 'Strong';
        if Rec."Member No" = '' then
            CoveragePercentStyle := 'Unfavorable';
        if Rec."Member No" <> '' then
            CoveragePercentStyle := 'Favorable';
    end;
}

