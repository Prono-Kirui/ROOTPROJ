page 51120 "Approved Property Exp Surr"
{
    ApplicationArea = All;
    Caption = 'Approved Property Expense Surrenders';
    CardPageId = "Approved/Post Prop Surr. Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Payments;
    SourceTableView = where("Payment Type" = const("Property Expense Surrender"),
                            Status = const(Released),
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

    trigger OnOpenPage()
    begin
        // DocStatus:=FormatStatus(Status);
        // IF UserSetup.GET(USERID) THEN
        //  BEGIN
        //    IF UserSetup."Show All"=FALSE THEN
        //      SETRANGE("Created By",USERID);
        //  END;
    end;

    trigger OnAfterGetRecord()
    begin
        //DocStatus:=FormatStatus(Status);
    end;
}
