page 51122 "Posted Property Expenses"
{
    ApplicationArea = All;
    Caption = 'Posted Property Expenses';
    CardPageId = "Approved Property Expense Card";
    DeleteAllowed = false;
    Editable = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Payments;
    SourceTableView = where("Payment Type" = const("Property Expense"),
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
                field("Account No."; Rec."Account No.")
                {
                    Caption = 'Account No.';
                    ToolTip = 'Specifies the value of the Account No. field';
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    Caption = 'Pay Mode';
                    ToolTip = 'Specifies the value of the Pay Mode field';
                }
                field("Staff No."; Rec."Staff No.")
                {
                    Caption = 'Staff No.';
                    ToolTip = 'Specifies the value of the Staff No. field';
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
                field("Imprest Amount"; Rec."Imprest Amount")
                {
                    Caption = 'Imprest Amount';
                    ToolTip = 'Specifies the value of the Imprest Amount field';
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
                field("Posted Date"; Rec."Posted Date")
                {
                    Caption = 'Posted Date';
                    ToolTip = 'Specifies the value of the Posted Date field';
                }
                field("Imprest Posted by PV"; Rec."Imprest Posted by PV")
                {
                    Caption = 'Imprest Posted by PV';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Imprest Posted by PV field';
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
}
