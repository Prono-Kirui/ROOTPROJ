page 51104 "Input Tax Lines"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Input Tax Lines';
    PageType = ListPart;
    SourceTable = "Payment Lines";
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Expenditure Type"; Rec."Expenditure Type")
                {
                    Caption = 'Type';
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Type field';
                }
                field("Account Type"; Rec."Account Type")
                {
                    Caption = 'Account Type';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Account Type field';
                }
                field("Gen. Posting Type"; Rec."Gen. Posting Type")
                {
                    Caption = 'Gen. Posting Type';
                    ToolTip = 'Specifies the value of the Gen. Posting Type field';
                    Visible = not DocReleased;
                }
                field("Account No"; Rec."Account No")
                {
                    Caption = 'Account No';
                    ToolTip = 'Specifies the value of the Account No field';
                }
                field("Account Name"; Rec."Account Name")
                {
                    Caption = 'Account Name';
                    ToolTip = 'Specifies the value of the Account Name field';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                    ToolTip = 'Specifies the value of the Amount field';
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc Type")
                {
                    Caption = 'Applies-to Doc. Type';
                    ToolTip = 'Specifies the value of the Applies-to Doc. Type field';
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    Caption = 'Applies-to Doc. No.';
                    ToolTip = 'Specifies the value of the Applies-to Doc. No. field';
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    Caption = 'Applies-to ID';
                    ToolTip = 'Specifies the value of the Applies-to ID field';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Apply Entries")
            {
                Caption = 'Apply Entries';
                Ellipsis = true;
                Image = ApplyEntries;
                ShortcutKey = 'Shift+F11';
                ToolTip = 'Select one or more ledger entries that you want to apply this record to so that the related posted documents are closed as paid or refunded.';
                Visible = not DocPosted;

                trigger OnAction()
                begin
                    PaymentMgt.ApplyEntry(Rec);
                end;
            }
            action("View Applied Entries")
            {
                Caption = 'View Applied Entries';
                Image = Approve;
                ToolTip = 'Executes the View Applied Entries action';
                Visible = DocPosted;
                trigger OnAction()
                begin
                    PaymentMgt.ViewAppliedEntries(Rec);
                end;
            }
        }
    }

    var
        Payments: Record Payments;
        PaymentMgt: Codeunit "Payments Management";
        DocPosted: Boolean;
        DocReleased: Boolean;

    trigger OnInit()
    begin
        DocReleased := false;
    end;

    trigger OnOpenPage()
    begin
        SetPageView();
    end;

    trigger OnAfterGetRecord()
    begin
        SetPageView();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.InsertPaymentTypes();
    end;

    local procedure SetPageView()
    begin
        if Payments.Get(Rec.No) then begin
            if Payments.Status = Payments.Status::Released then
                DocReleased := true
            else
                DocReleased := false;

            if Payments.Posted then
                DocPosted := true
            else
                DocPosted := false;
        end;
    end;
}
