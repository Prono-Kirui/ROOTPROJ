page 51033 "Posted Receipts"
{
    ApplicationArea = All;
    Caption = 'Posted Receipts';
    CardPageId = "Approved/Post Receipt Card";
    InsertAllowed = false;
    PageType = List;
    SourceTable = Payments;
    SourceTableView = where(Posted = const(true),
                            "Payment Type" = const(Receipt));
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
                field("Cheque No"; Rec."Cheque No")
                {
                    Caption = 'Cheque No';
                    ToolTip = 'Specifies the value of the Cheque No field';
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    Caption = 'Cheque Date';
                    ToolTip = 'Specifies the value of the Cheque Date field';
                }
                field("Received From"; Rec."Received From")
                {
                    Caption = 'Payee';
                    ToolTip = 'Specifies the value of the Received From field';
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    ToolTip = 'Specifies the value of the Payment Narration field';
                }
                field("Receipt Amount"; Rec."Receipt Amount")
                {
                    Caption = 'Receipt Amount';
                    ToolTip = 'Specifies the value of the Receipt Amount field';
                }
                field("Bank Code"; Rec."Paying Bank Account")
                {
                    Caption = 'Paying Bank Account';
                    ToolTip = 'Specifies the value of the Paying Bank Account field';
                }
                field(Currency; Rec.Currency)
                {
                    Caption = 'Currency';
                    ToolTip = 'Specifies the value of the Currency field';
                }
                field("Created By"; Rec."Created By")
                {
                    Caption = 'Created By';
                    ToolTip = 'Specifies the value of the Created By field';
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
                field("Time Posted"; Rec."Time Posted")
                {
                    Caption = 'Time Posted';
                    ToolTip = 'Specifies the value of the Time Posted field';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code';
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code';
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field';
                }
                field("Posted Document No."; Rec."Posted Document No.")
                {
                    Caption = 'Posted Document No.';
                    ToolTip = 'Specifies the value of the Posted Document No. field.';
                }
            }
        }
    }
}
