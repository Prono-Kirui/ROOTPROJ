page 51111 "Property Expense Requests"
{
    ApplicationArea = All;
    Caption = 'Property Expense Requests';
    CardPageId = "Property Expense Request";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = Payments;
    SourceTableView = where("Payment Type" = const("Property Expense"),
                            Status = filter(Open | "Pending Approval"));
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field(Date; Rec.Date)
                {
                    Caption = 'Date';
                    ToolTip = 'Specifies the value of the Date field';
                }
                field("Staff No."; Rec."Staff No.")
                {
                    Caption = 'Staff No.';
                    ToolTip = 'Specifies the value of the Staff No. field';
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    Caption = 'Pay Mode';
                    ToolTip = 'Specifies the value of the Pay Mode field';
                }
                field(Payee; Rec.Payee)
                {
                    Caption = 'Payee';
                    ToolTip = 'Specifies the value of the Payee field';
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    Caption = 'User Remarks';
                    ToolTip = 'Specifies the value of the User Remarks field';
                }
                field("Created By"; Rec."Created By")
                {
                    Caption = 'Created By';
                    ToolTip = 'Specifies the value of the Created By field';
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                    ToolTip = 'Specifies the value of the Status field';
                }
                field(Currency; Rec.Currency)
                {
                    Caption = 'Currency';
                    ToolTip = 'Specifies the value of the Currency field';
                }
                field("Imprest Amount"; Rec."Imprest Amount")
                {
                    Caption = 'Imprest Amount';
                    ToolTip = 'Specifies the value of the Imprest Amount field';
                }
            }
        }
        area(FactBoxes)
        {
            part(Control26; "Pending Approval FactBox")
            {
                Caption = 'Pending Approval FactBox';
                SubPageLink = "Table ID" = const(Database::Payments),
                              "Document No." = field("No.");
                Visible = OpenApprovalEntriesExistForCurrUser;
            }
            part(Control25; "Approval FactBox")
            {
                Caption = 'Approval FactBox';
                SubPageLink = "Table ID" = const(Database::Payments),
                              "Document No." = field("No.");
                Visible = false;
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                Caption = 'Incoming Doc. Attach. FactBox';
                ShowFilter = false;
                Visible = false;
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                Caption = 'Workflow Status FactBox';
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            systempart(Control17; Links)
            {
            }
            systempart(Control16; Notes)
            {
            }
        }
    }

    var
        UserSetup: Record "User Setup";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        ShowWorkflowStatus: Boolean;

    trigger OnOpenPage()
    begin
        if UserSetup.Get(UserId) then begin
            if not UserSetup."Show All" then begin
                Rec.FilterGroup(2);
                Rec.SetRange("Created By", UserId);
            end;
        end else
            Error('%1 does not exist in the Users Setup', UserId);
    end;

    trigger OnAfterGetRecord()
    begin
        // DocStatus:=FormatStatus(Status);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Property Expense";
        Rec."Account Type" := Rec."Account Type"::Customer;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Property Expense";
        Rec."Account Type" := Rec."Account Type"::Customer;
    end;
}