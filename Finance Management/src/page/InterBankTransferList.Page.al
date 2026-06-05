page 51044 "InterBank Transfer List"
{
    ApplicationArea = All;
    Caption = 'InterBank Transfer List';
    CardPageId = "InterBank Transfer";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = Payments;
    SourceTableView = where("Payment Type" = const("Bank Transfer"),
                            Status = filter(<> Released),
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
                field("Source Bank"; Rec."Source Bank")
                {
                    Caption = 'Source Bank';
                    ToolTip = 'Specifies the value of the Source Bank field';
                }
                field("Source Bank Amount"; Rec."Source Bank Amount")
                {
                    Caption = 'Source Bank Amount';
                    ToolTip = 'Specifies the value of the Source Bank Amount field';
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
