page 51042 "Posted Staff Claim"
{
    ApplicationArea = All;
    Caption = 'Posted Staff Claim';
    CardPageId = "Approved/Post Staff Claim Card";
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Payments;
    SourceTableView = where("Payment Type" = const("Staff Claim"),
                            Status = const(Released),
                            Posted = const(true));
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
                field(Currency; Rec.Currency)
                {
                    Caption = 'Currency';
                    ToolTip = 'Specifies the value of the Currency field';
                }
                field("Petty Cash Amount"; Rec."Petty Cash Amount")
                {
                    Caption = 'Petty Cash Amount';
                    ToolTip = 'Specifies the value of the Petty Cash Amount field';
                }
                field("Staff No."; Rec."Staff No.")
                {
                    Caption = 'Staff No.';
                    ToolTip = 'Specifies the value of the Staff No. field';
                }
                field("Posted Document No."; Rec."Posted Document No.")
                {
                    Caption = 'Posted Document No.';
                    ToolTip = 'Specifies the value of the Posted Document No. field.';
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

    actions
    {
        area(Processing)
        {
            action(Navigate)
            {
                Caption = '&Navigate';
                Image = Navigate;
                ToolTip = 'Find all entries and documents that exist for the document number and posting date on the posted purchase document.';

                trigger OnAction()
                begin
                    Rec.Navigate();
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Category5)
            {
                Caption = 'Navigate';
                actionref(Navigate_Promoted; Navigate)
                {
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        //DocStatus:=FormatStatus(Status);
    end;

    trigger OnAfterGetRecord()
    begin
        //DocStatus:=FormatStatus(Status);
    end;
}
