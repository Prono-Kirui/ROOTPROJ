page 51101 "Input Tax Computation"
{
    ApplicationArea = All;
    Caption = 'Input Tax Computation';
    CardPageId = "Input Tax Card";
    DeleteAllowed = false;
    Editable = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Payments;
    SourceTableView = sorting("No.")
                      where(Posted = const(false),
                            "Payment Type" = const("Input Tax"));
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
                field("Account Type"; Rec."Account Type")
                {
                    Caption = 'Account Type';
                    ToolTip = 'Specifies the value of the Account Type field';
                }
                field("Account No."; Rec."Account No.")
                {
                    Caption = 'Account No.';
                    ToolTip = 'Specifies the value of the Account No. field';
                }
                field("Account Name"; Rec."Account Name")
                {
                    Caption = 'Account Name';
                    ToolTip = 'Specifies the value of the Account Name field';
                }
                field("Receipt Amount"; Rec."Receipt Amount")
                {
                    Caption = 'Receipt Amount';
                    ToolTip = 'Specifies the value of the Receipt Amount field';
                }
                field("Created By"; Rec."Created By")
                {
                    Caption = 'Created By';
                    ToolTip = 'Specifies the value of the Created By field';
                }
                field(Posted; Rec.Posted)
                {
                    Caption = 'Posted';
                    Editable = false;
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
            }
        }
    }
}
