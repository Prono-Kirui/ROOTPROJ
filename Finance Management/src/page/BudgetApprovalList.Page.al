page 51075 "Budget Approval List"
{
    ApplicationArea = All;
    Caption = 'Budget Approval List';
    CardPageId = "Budget Approval Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Budget Approval Header";
    SourceTableView = where(Status = filter(<> Approved), "Budget Type" = const(Budget));
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Document No."; Rec."Document No.")
                {
                    Caption = 'Document No.';
                    ToolTip = 'Specifies the value of the Document No. field';
                }
                field("Date Created"; Rec."Date Created")
                {
                    Caption = 'Date Created';
                    ToolTip = 'Specifies the value of the Date Created field';
                }
                field("Time Created"; Rec."Time Created")
                {
                    Caption = 'Time Created';
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
                    ToolTip = 'Specifies the value of the Status field';
                }
                field("User ID"; Rec."User ID")
                {
                    Caption = 'User ID';
                    ToolTip = 'Specifies the value of the User ID field';
                }
                field(Approvals; Rec.Approvals)
                {
                    Caption = 'Approvals';
                    ToolTip = 'Specifies the value of the Approvals field';
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Control10; Notes)
            {
            }
            systempart(Control11; Links)
            {
            }
        }
    }

    var
        UserSetup: Record "User Setup";

    trigger OnOpenPage()
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Show All" then begin
            Rec.FilterGroup(2);
            Rec.SetRange("User ID", UserId);
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Budget Type" := Rec."Budget Type"::Budget;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Budget Type" := Rec."Budget Type"::Budget;
    end;
}
