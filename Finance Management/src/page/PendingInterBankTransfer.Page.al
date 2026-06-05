page 51074 "Pending InterBank Transfer"
{
    ApplicationArea = All;
    Caption = 'Pending InterBank Transfer';
    CardPageId = "App/Posted InterBank Transfer";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = Payments;
    SourceTableView = where("Payment Type" = const("Bank Transfer"),
                            Status = const("Pending Approval"),
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
                field("Source Amount LCY"; Rec."Source Amount LCY")
                {
                    Caption = 'Source Bank Amount LCY';
                    ToolTip = 'Specifies the value of the Source Bank Amount LCY field';
                }
                field("Petty Cash Amount (LCY)"; Rec."Petty Cash Amount (LCY)")
                {
                    Caption = 'Total Receiving Amount (LCY)';
                    ToolTip = 'Specifies the value of the Total Receiving Amount (LCY) field';
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
            systempart(Control3; Notes)
            {
            }
            systempart(Control2; MyNotes)
            {
            }
            systempart(Control1; Links)
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
