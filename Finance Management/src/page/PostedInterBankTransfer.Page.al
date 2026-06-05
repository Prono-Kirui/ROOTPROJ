page 51047 "Posted InterBank Transfer"
{
    ApplicationArea = All;
    Caption = 'Posted InterBank Transfer';
    CardPageId = "App/Posted InterBank Transfer";
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ShowFilter = true;
    SourceTable = Payments;
    SourceTableView = where("Payment Type" = const("Bank Transfer"),
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
                field("Posted By"; Rec."Posted By")
                {
                    Caption = 'Posted By';
                    ToolTip = 'Specifies the value of the Posted By field';
                }
                field("Posted Date"; Rec."Posted Date")
                {
                    Caption = 'Posted Date';
                    ToolTip = 'Specifies the value of the Posted Date field';
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
            group(Category_Process)
            {
                Caption = 'Category_Process';
                actionref(Navigate_Promoted; Navigate)
                {
                }
            }
        }
    }
}
