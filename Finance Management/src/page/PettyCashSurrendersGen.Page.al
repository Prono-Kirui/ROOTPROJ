page 51049 "Petty Cash Surrenders-Gen"
{
    ApplicationArea = All;
    Caption = 'Petty Cash Surrenders-Gen';
    CardPageId = "Petty Cash Surrender";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = Payments;
    SourceTableView = where("Payment Type" = const("Petty Cash Surrender"),
                            Status = filter(<> Released & <> Archived),
                            Posted = const(false));
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
                    ToolTip = 'Specifies the value of the No. field';
                }
                field(Date; Rec.Date)
                {
                    Caption = 'Date';
                    ToolTip = 'Specifies the value of the Date field';
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
                    Caption = 'Payment Narration';
                    ToolTip = 'Specifies the value of the Payment Narration field';
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
                field("Actual Amount Spent"; Rec."Actual Amount Spent")
                {
                    Caption = 'Actual Amount Spent';
                    ToolTip = 'Specifies the value of the Actual Amount Spent field';
                }
                field("Staff No."; Rec."Staff No.")
                {
                    Caption = 'Staff No.';
                    ToolTip = 'Specifies the value of the Staff No. field';
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Control12; Notes)
            {
            }
            systempart(Control13; MyNotes)
            {
            }
            systempart(Control14; Links)
            {
            }
        }
    }

    var
        UserSetup: Record "User Setup";

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
}
