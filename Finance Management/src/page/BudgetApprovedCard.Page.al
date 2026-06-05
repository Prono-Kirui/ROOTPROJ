page 51079 "Budget Approved Card"
{
    ApplicationArea = All;
    Caption = 'Budget Approved Card';
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Budget Approval Header";
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = Rec.Status = Rec.Status::Open;
                field("Document No."; Rec."Document No.")
                {
                    Caption = 'Document No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Document No. field';
                }
                field("Date Created"; Rec."Date Created")
                {
                    Caption = 'Date Created';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date Created field';
                }
                field("Time Created"; Rec."Time Created")
                {
                    Caption = 'Time Created';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Time Created field';
                }
                field("Budget Name"; Rec."Budget Name")
                {
                    Caption = 'Budget Name';
                    ToolTip = 'Specifies the value of the Budget Name field';
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field';
                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                    end;
                }
                field("User ID"; Rec."User ID")
                {
                    Caption = 'User ID';
                    Editable = false;
                    ToolTip = 'Specifies the value of the User ID field';
                }
            }
            part(Control9; "Budget Approval Lines")
            {
                Caption = 'Budget Approval Lines';
                Editable = false;
                SubPageLink = "Document No." = field("Document No.");
            }
        }
        area(FactBoxes)
        {
            systempart(Control14; Notes)
            {
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SendApproval)
            {
                Caption = 'Send Approval Request';
                Enabled = not OpenApprovalsExist;
                Image = SendApprovalRequest;
                ToolTip = 'Executes the Send Approval Request action';
                Visible = false;

                trigger OnAction()
                begin
                    if ApprovalsMgmt.CheckBudgetWorkflowEnabled(Rec) then
                        ApprovalsMgmt.OnSendBudgetApproval(Rec);
                end;
            }
            action(CancelApproval)
            {
                Caption = 'Cancel Approval Request';
                Enabled = CanCancelApprovalRequest;
                Image = CancelApprovalRequest;
                ToolTip = 'Executes the Cancel Approval Request action';
                Visible = false;

                trigger OnAction()
                begin
                    ApprovalsMgmt.OnCancelBudgetApproval(Rec);
                end;
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approval;
                ToolTip = 'Executes the Approvals action';

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalEntries: Page "Approval Entries";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SetCurrentKey("Document No.");
                    ApprovalEntry.SetRange("Table ID", Database::"Budget Approval Header");
                    ApprovalEntry.SetRange("Document No.", Rec."Document No.");
                    ApprovalEntries.SetTableView(ApprovalEntry);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.RunModal();
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Category_Process';
                actionref(SendApproval_Promoted; SendApproval)
                {
                }
                actionref(CancelApproval_Promoted; CancelApproval)
                {
                }
                actionref(Approvals_Promoted; Approvals)
                {
                }
            }
        }
    }

    var
        ApprovalsMgmt: Codeunit "Approval Mgt Finance Ext";
        CanCancelApprovalRequest: Boolean;
        OpenApprovalsExist: Boolean;
        OpenApprovalsExistForCurrUser: Boolean;

    trigger OnOpenPage()
    begin
        SetControlAppearance();
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    local procedure SetControlAppearance()
    var
        BudgetApprovalHeader: Record "Budget Approval Header";
        ApprovalsMgmt2: Codeunit "Approvals Mgmt.";
    begin
        if BudgetApprovalHeader.Get(Rec."Document No.") then begin
            OpenApprovalsExistForCurrUser := ApprovalsMgmt2.HasOpenApprovalEntries(BudgetApprovalHeader.RecordId);
            OpenApprovalsExist := ApprovalsMgmt2.HasOpenApprovalEntries(BudgetApprovalHeader.RecordId);
            CanCancelApprovalRequest := ApprovalsMgmt2.CanCancelApprovalForRecord(BudgetApprovalHeader.RecordId);
        end;
    end;
}
