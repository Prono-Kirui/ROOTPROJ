page 51085 "Interbank Lines"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Interbank Lines';
    PageType = ListPart;
    SourceTable = "Payment Lines";
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Account No"; Rec."Account No")
                {
                    Caption = 'Account No';
                    ToolTip = 'Specifies the value of the Account No field';
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Account Name"; Rec."Account Name")
                {
                    Caption = 'Bank Account Name';
                    ToolTip = 'Specifies the value of the Bank Account Name field';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(Currency; Rec.Currency)
                {
                    Caption = 'Currency';
                    ToolTip = 'Specifies the value of the Currency field';
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                    ToolTip = 'Specifies the value of the Amount field';
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    Caption = 'Amount (LCY)';
                    ToolTip = 'Specifies the value of the Amount (LCY) field';
                }
            }
        }
    }

    var
        Payments: Record Payments;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.InsertPaymentTypes();
        GetPaymentHeader();
        Rec."Account Type" := Rec."Account Type"::"Bank Account";
        if Payments."Payment Narration" <> '' then
            Rec.Description := Payments."Payment Narration";
    end;

    local procedure GetPaymentHeader()
    begin
        if Payments.Get(Rec.No) then;
    end;
}
