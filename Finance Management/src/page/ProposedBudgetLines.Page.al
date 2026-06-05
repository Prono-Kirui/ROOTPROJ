page 51082 "Proposed Budget Lines"
{
    ApplicationArea = All;
    Caption = 'Proposed Budget Lines';
    PageType = ListPart;
    SourceTable = "Budget Approval Lines";
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Entry No."; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                    ToolTip = 'Specifies the value of the Entry No. field';
                    Visible = false;
                }
                field("Budget Name"; Rec."Budget Name")
                {
                    Caption = 'Budget Name';
                    ToolTip = 'Specifies the value of the Budget Name field';
                    Visible = false;
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    Caption = 'G/L Account No.';
                    ToolTip = 'Specifies the value of the G/L Account No. field';
                }
                field(Date; Rec.Date)
                {
                    Caption = 'Date';
                    ToolTip = 'Specifies the value of the Date field';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code';
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field';
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                    ToolTip = 'Specifies the value of the Amount field';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Business Unit Code"; Rec."Business Unit Code")
                {
                    Caption = 'Business Unit Code';
                    ToolTip = 'Specifies the value of the Business Unit Code field';
                }
                field("User ID"; Rec."User ID")
                {
                    Caption = 'User ID';
                    ToolTip = 'Specifies the value of the User ID field';
                }
                field("Budget Dimension 1 Code"; Rec."Budget Dimension 1 Code")
                {
                    Caption = 'Budget Dimension 1 Code';
                    ToolTip = 'Specifies the value of the Budget Dimension 1 Code field';
                }
                field("Budget Dimension 2 Code"; Rec."Budget Dimension 2 Code")
                {
                    Caption = 'Budget Dimension 2 Code';
                    ToolTip = 'Specifies the value of the Budget Dimension 2 Code field';
                }
                field("Budget Dimension 3 Code"; Rec."Budget Dimension 3 Code")
                {
                    Caption = 'Budget Dimension 3 Code';
                    ToolTip = 'Specifies the value of the Budget Dimension 3 Code field';
                }
                field("Budget Dimension 4 Code"; Rec."Budget Dimension 4 Code")
                {
                    Caption = 'Budget Dimension 4 Code';
                    ToolTip = 'Specifies the value of the Budget Dimension 4 Code field';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Caption = 'Last Date Modified';
                    ToolTip = 'Specifies the value of the Last Date Modified field';
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID';
                    ToolTip = 'Specifies the value of the Dimension Set ID field';
                }
                field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
                {
                    Caption = 'Global Dimension 3 Code';
                    ToolTip = 'Specifies the value of the Global Dimension 3 Code field';
                }
                field(Proposed; Rec.Proposed)
                {
                    Caption = 'Proposed';
                    ToolTip = 'Specifies the value of the Proposed field';
                }
                field(Posted; Rec.Posted)
                {
                    Caption = 'Posted';
                    ToolTip = 'Specifies the value of the Posted field';
                }
                field("Posted By"; Rec."Posted By")
                {
                    Caption = 'Posted By';
                    ToolTip = 'Specifies the value of the Posted By field';
                }
                field("Date-Time Posted"; Rec."Date-Time Posted")
                {
                    Caption = 'Date-Time Posted';
                    ToolTip = 'Specifies the value of the Date-Time Posted field';
                }
            }
        }
    }

    var
        BudgetApprovalHeader: Record "Budget Approval Header";

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if Rec."Document No." <> '' then begin
            BudgetApprovalHeader.Reset();
            BudgetApprovalHeader.SetRange(BudgetApprovalHeader."Document No.", Rec."Document No.");
            if BudgetApprovalHeader.FindFirst() then
                if BudgetApprovalHeader."Budget Name" = '' then
                    BudgetApprovalHeader.TestField("Budget Name")
                else begin
                    Rec."Budget Name" := BudgetApprovalHeader."Budget Name";
                    Rec.Date := Today;
                    Rec."User ID" := UserId;
                end;
        end;
    end;
}
