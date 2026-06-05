page 51035 "Payment Vouchers"
{
    ApplicationArea = All;
    Caption = 'Payment Vouchers';
    CardPageId = "Payment Voucher";
    Editable = false;
    PageType = List;
    SourceTable = Payments;
    SourceTableView = where("Payment Type" = const("Payment Voucher"),
                            Status = filter(<> Released),
                            Posted = const(false));
    UsageCategory = Lists;
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
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    Caption = 'Paying Bank Account';
                    ToolTip = 'Specifies the value of the Paying Bank Account field';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    Caption = 'Bank Name';
                    ToolTip = 'Specifies the value of the Bank Name field';
                }
                field(Payee; Rec.Payee)
                {
                    Caption = 'Payee';
                    ToolTip = 'Specifies the value of the Payee field';
                }
                field(Currency; Rec.Currency)
                {
                    Caption = 'Currency';
                    ToolTip = 'Specifies the value of the Currency field';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    Caption = 'Total Amount';
                    ToolTip = 'Specifies the value of the Total Amount field';
                }
                field("Total Amount (LCY)"; Rec."Total Amount (LCY)")
                {
                    ToolTip = 'Specifies the value of the Total Amount (LCY) field.';
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                    ToolTip = 'Specifies the value of the Status field';
                }
                field("Created By"; Rec."Created By")
                {
                    Caption = 'Created By';
                    ToolTip = 'Specifies the value of the Created By field';
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Control16; Notes)
            {
            }
            systempart(Control17; MyNotes)
            {
            }
            systempart(Control18; Links)
            {
            }
        }
    }

    trigger OnOpenPage()
    begin
        /* if UserSetup.Get(UserId) then begin
            if not UserSetup."Show All" then begin
                Rec.FilterGroup(2);
                Rec.SetRange("Created By", UserId);
            end;
        end else
            Error('%1 does not exist in the Users Setup', UserId); */
    end;
}
