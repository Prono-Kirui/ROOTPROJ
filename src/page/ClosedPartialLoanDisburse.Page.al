page 50143 "Closed Partial Loan Disburse"
{
    ApplicationArea = All;
    Caption = 'Closed Partial Loan Disbursements';
    PageType = List;
    CardPageID = "Partial Loan Disbursement Card";
    SourceTable = "Partial Loan Disbursments";
    UsageCategory = Lists;
    DeleteAllowed = false;
    Editable = false;
    SourceTableView = where("Approval Status" = const(Closed));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date"; Rec."Date Created")
                {
                    ApplicationArea = Basic;
                }
                field("Client Code"; Rec."Client Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member  No';
                }
                field("Client Name"; Rec."Client Name")
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                }
                field("Disbursement Number"; Rec."Disbursement Number")
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                }
                field("Amount To Disburse"; Rec."Amount To Disburse")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                    Style = Ambiguous;
                    Caption = 'Status';
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000000; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("Client Code");
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        If FnCanPostLoans(UserId) = false then begin
            //SetRange("Captured By", UserId);
        end;
    end;

    local procedure FnCanPostLoans(UserId: Text): Boolean
    var
        UserSetUp: Record "User Setup";
    begin
        if UserSetUp.get(UserId) then begin
            if UserSetUp."Can POST Loans" = true then begin
                exit(true);
            end;
        end;
        exit(false);
    end;
}
