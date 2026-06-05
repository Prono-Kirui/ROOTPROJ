page 51067 "Pending Petty Cash List"
{
    ApplicationArea = All;
    Caption = 'Pending Petty Cash List';
    CardPageId = "Approved/Posted Petty Cash";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = Payments;
    SourceTableView = where("Payment Type" = const("Petty Cash"),
                            Status = filter("Pending Approval"),
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
                field("Petty Cash Amount"; Rec."Petty Cash Amount")
                {
                    Caption = 'Petty Cash Amount';
                    ToolTip = 'Specifies the value of the Petty Cash Amount field';
                }
                field(Cashier; Rec.Cashier)
                {
                    Caption = 'Cashier';
                    ToolTip = 'Specifies the value of the Cashier field';
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
        // IF UserSetup.GET(USERID) THEN
        //  BEGIN
        //    IF NOT UserSetup."Show All" THEN
        //      BEGIN
        //        FILTERGROUP(2);
        //        SETRANGE("Created By",USERID);
        //      END;
        //  END ELSE
        //    ERROR('%1 does not exist in the Users Setup',USERID);
    end;

    trigger OnAfterGetRecord()
    begin
        //DocStatus:=FormatStatus(Status);
    end;
}
