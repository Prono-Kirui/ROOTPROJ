page 51083 "Proposed G/L Budget Names"
{
    ApplicationArea = All;
    Caption = 'G/L Budget Names';
    PageType = List;
    SourceTable = "G/L Budget Name";
    SourceTableView = where("Budget Status" = filter(<> Approved));

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                ShowCaption = false;

                field(Name; Rec.Name)
                {
                    ApplicationArea = Suite;
                    Caption = 'Name';
                    ToolTip = 'Specifies the name of the general ledger budget.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Suite;
                    Caption = 'Description';
                    ToolTip = 'Specifies a description of the general ledger budget name.';
                }
                field("Global Dimension 1 Code"; GLSetup."Global Dimension 1 Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Global Dimension 1 Code';
                    Editable = false;
                    ToolTip = 'Specifies the global dimension that is set up in the Global Dimension 1 Code field in the General Ledger Setup window.';
                }
                field("Global Dimension 2 Code"; GLSetup."Global Dimension 2 Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Global Dimension 2 Code';
                    Editable = false;
                    ToolTip = 'Specifies the global dimension that is set up in the Global Dimension 2 Code field in the General Ledger Setup window.';
                }
                field("Budget Dimension 1 Code"; Rec."Budget Dimension 1 Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Budget Dimension 1 Code';
                    ToolTip = 'Specifies a code for a budget dimension. You can specify four additional dimensions on each budget that you create.';
                }
                field("Budget Dimension 2 Code"; Rec."Budget Dimension 2 Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Budget Dimension 2 Code';
                    ToolTip = 'Specifies a code for a budget dimension. You can specify four additional dimensions on each budget that you create.';
                }
                field("Budget Dimension 3 Code"; Rec."Budget Dimension 3 Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Budget Dimension 3 Code';
                    ToolTip = 'Specifies a code for a budget dimension. You can specify four additional dimensions on each budget that you create.';
                }
                field("Budget Dimension 4 Code"; Rec."Budget Dimension 4 Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Budget Dimension 4 Code';
                    ToolTip = 'Specifies a code for a budget dimension. You can specify four additional dimensions on each budget that you create.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Suite;
                    Caption = 'Blocked';
                    ToolTip = 'Specifies that entries cannot be created for the budget. ';
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
        area(Processing)
        {
            action(EditBudget)
            {
                ApplicationArea = Suite;
                Caption = 'Edit Budget';
                Image = EditLines;
                ShortcutKey = 'Return';
                ToolTip = 'Specify budgets that you can create in the general ledger application area. If you need several different budgets, you can create several budget names.';

                trigger OnAction()
                var
                    Budget: Page Budget;
                begin
                    Budget.SetBudgetName(Rec.Name);
                    Budget.Run();
                end;
            }
            group(ReportGroup)
            {
                Caption = 'Report';
                Image = "Report";

                action(ReportTrialBalance)
                {
                    ApplicationArea = Suite;
                    Caption = 'Trial Balance/Budget';
                    Image = "Report";
                    ToolTip = 'View budget details for the specified period.';

                    trigger OnAction()
                    begin
                        Report.Run(Report::"Trial Balance/Budget", true, false);
                    end;
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                action(SendApproval)
                {
                    Caption = 'Send Proposed Budget For Approval';
                    ToolTip = 'Executes the Send Proposed Budget For Approval action';

                    trigger OnAction()
                    begin
                        if Confirm(SendApprovalTxt, false) then
                            if GLBudgetNames.Get(Rec.Name) then
                                if ApprovalsMgt.CheckProposedBudgetWorkflowEnabled(GLBudgetNames) then
                                    ApprovalsMgt.OnSendProposedBudgetApproval(GLBudgetNames);
                    end;
                }
                action(CancelApproval)
                {
                    Caption = 'Cancel Approval Request';
                    ToolTip = 'Executes the Cancel Approval Request action';

                    trigger OnAction()
                    begin
                        if GLBudgetNames.Get(Rec.Name) then
                            ApprovalsMgt.OnCancelProposedBudgetApproval(GLBudgetNames);
                    end;
                }
                action(ViewApprovals)
                {
                    Caption = 'View Approvals';
                    ToolTip = 'Executes the View Approvals action';

                    trigger OnAction()
                    begin
                    end;
                }
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';
                actionref(EditBudget_Promoted; EditBudget)
                {
                }
            }
            group(Category_Report)
            {
                Caption = 'Report';
                actionref(ReportTrialBalance_Promoted; ReportTrialBalance)
                {
                }
            }
        }
    }

    var
        GLBudgetNames: Record "G/L Budget Name";
        GLSetup: Record "General Ledger Setup";
        ApprovalsMgt: Codeunit "Approval Mgt Finance Ext";
        SendApprovalTxt: Label 'Are you sure you want to send for approval?';

    trigger OnOpenPage()
    begin
        GLSetup.Get();
    end;

    procedure GetSelectionFilter(): Text
    var
        GLBudgetName: Record "G/L Budget Name";
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        CurrPage.SetSelectionFilter(GLBudgetName);
        exit(SelectionFilterManagement.GetSelectionFilterForGLBudgetName(GLBudgetName));
    end;
}
