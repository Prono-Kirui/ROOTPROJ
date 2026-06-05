page 51106 "Input Tax Card-Post Card"
{
    ApplicationArea = All;
    Caption = 'Input Tax Card-Post Card';
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    Permissions =;
    RefreshOnActivate = true;
    SourceTable = Payments;
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = PostedEditable;
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field(Date; Rec.Date)
                {
                    Caption = 'Date';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date field';
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    Caption = 'Pay Mode';
                    Editable = DocPosted;
                    ToolTip = 'Specifies the value of the Pay Mode field';
                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                    end;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    Caption = 'Cheque No';
                    Editable = ChequePayment;
                    ToolTip = 'Specifies the value of the Cheque No field';
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    Caption = 'Cheque Date';
                    Editable = ChequePayment;
                    ToolTip = 'Specifies the value of the Cheque Date field';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                    ToolTip = 'Specifies the value of the Responsibility Center field';
                }
                group("Account Details")
                {
                    Caption = 'Account Details';
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
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    Caption = 'Payment Narration';
                    ToolTip = 'Specifies the value of the Payment Narration field';
                }
                field("Payment Release Date"; Rec."Payment Release Date")
                {
                    Caption = 'Posting Date';
                    ToolTip = 'Specifies the value of the Posting Date field';
                }
                field("Created By"; Rec."Created By")
                {
                    Caption = 'Created By';
                    ToolTip = 'Specifies the value of the Created By field';
                }
                group(Control17)
                {
                    ShowCaption = false;
                    Visible = NormalReceiptLines;

                    field("Receipt Amount"; Rec."Receipt Amount")
                    {
                        Caption = 'Receipt Amount';
                        ToolTip = 'Specifies the value of the Receipt Amount field';
                    }
                }
                field(Currency; Rec.Currency)
                {
                    Caption = 'Currency';
                    Editable = DocPosted;
                    ToolTip = 'Specifies the value of the Currency field';
                }
                field(Cashier; Rec.Cashier)
                {
                    Caption = 'Cashier';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Cashier field';
                }
                field(Posted; Rec.Posted)
                {
                    Caption = 'Posted';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Posted field';
                }
            }
            part(Lines; "Input Tax Lines")
            {
                Caption = 'Input Tax Lines';
                Editable = PostedEditable;
                SubPageLink = No = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;

                action(Post)
                {
                    Caption = 'P&ost';
                    Enabled = DocPosted;
                    Image = PostOrder;
                    ShortcutKey = 'F9';
                    ToolTip = 'Executes the P&ost action';

                    trigger OnAction()
                    begin
                        Rec.TestField("Pay Mode");
                        Rec.TestField("Received From");
                        //TESTFIELD("On behalf of");
                        ReceiptsPost.PostInputTax(Rec);

                        CurrPage.Close();
                    end;
                }
                action("Post and Print")
                {
                    Caption = 'P&ost and Print';
                    Enabled = DocPosted;
                    Image = PostPrint;
                    ShortcutKey = 'F9';
                    ToolTip = 'Executes the P&ost and Print action';

                    trigger OnAction()
                    begin

                        ReceiptsPost.PostReceipt(Rec);
                        //RESET;
                        //BankLedgerEntry.SETRANGE(BankLedgerEntry."Document No.","No.");
                        //REPORT.RUN(report::"Receipt",FALSE,TRUE,BankLedgerEntry);
                        //RESET;
                        Payments.Reset();
                        Payments.SetRange("No.", Rec."No.");
                        Report.Run(Report::"Receipt Custom", false, true, Payments);
                    end;
                }
                action("Print Receipt")
                {
                    Caption = 'Print Receipt';
                    Enabled = not DocPosted;
                    Image = "Report";
                    ToolTip = 'Executes the Print Receipt action';
                    Visible = false;
                    trigger OnAction()
                    begin
                        if Rec.Posted = false then
                            Error(Text000, Rec."No.");
                        Rec.Reset();
                        BankLedgerEntry.SetRange(BankLedgerEntry."Document No.", Rec."No.");
                        Report.Run(Report::Receipt, true, true, BankLedgerEntry);
                        Rec.Reset();
                    end;
                }
                action(Preview)
                {
                    Caption = 'Preview';
                    Image = Print;
                    ToolTip = 'Executes the Preview action';
                    trigger OnAction()
                    begin
                        Payments.Reset();
                        Payments.SetRange("No.", Rec."No.");
                        Report.Run(Report::"Receipt Custom", true, false, Payments);
                    end;
                }
                action("Reprint Receipt")
                {
                    Caption = 'Reprint Receipt';
                    Image = PrintInstallment;
                    ToolTip = 'Executes the Reprint Receipt action';
                    Visible = not DocPosted;
                    trigger OnAction()
                    begin
                        Payments.Reset();
                        Payments.SetRange("No.", Rec."No.");
                        Report.Run(Report::"Receipt Custom", false, true, Payments);
                    end;
                }
                action(Archive)
                {
                    Caption = 'Archive';
                    Image = Archive;
                    ToolTip = 'Executes the Archive action';
                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to archive this document?', false) = true then begin
                            Rec.Status := Rec.Status::Archived;
                            Rec.Modify();
                        end;
                    end;
                }
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';
                actionref(Post_Promoted; Post)
                {
                }
                actionref("Post and Print_Promoted"; "Post and Print")
                {
                }
                actionref(Archive_Promoted; Archive)
                {
                }
            }
            group(Category_Report)
            {
                Caption = 'Report';
                actionref("Print Receipt_Promoted"; "Print Receipt")
                {
                }
                actionref(Preview_Promoted; Preview)
                {
                }
                actionref("Reprint Receipt_Promoted"; "Reprint Receipt")
                {
                }
            }
        }
    }

    var
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        PaymentMethod: Record "Payment Method";
        Payments: Record Payments;
        ReceiptsPost: Codeunit "Payments Management";
        ChequePayment: Boolean;
        DocPosted: Boolean;
        ImprestReceiptLines: Boolean;
        NormalReceiptLines: Boolean;
        PostedEditable: Boolean;
        BalAccType: Enum "Payment Balance Account Type";
        Text000: Label 'Receipt No %1 has not been posted';

    trigger OnOpenPage()
    begin
        SetControlAppearance();
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Input Tax";
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Input Tax";
    end;

    local procedure SetControlAppearance()
    begin
        DocPosted := not Rec.Posted;
        if PaymentMethod.Get(Rec."Pay Mode") then
            BalAccType := PaymentMethod."Bal. Account Type";

        if BalAccType = BalAccType::Cheque then
            ChequePayment := true
        else
            ChequePayment := false;
        if ChequePayment and not DocPosted then
            ChequePayment := false;
        if Rec."Imprest Surrender Doc. No" = '' then begin
            ImprestReceiptLines := false;
            NormalReceiptLines := true;
        end else begin
            ImprestReceiptLines := true;
            NormalReceiptLines := false;
        end;
        if Rec.Posted then
            PostedEditable := false
        else
            PostedEditable := true;
    end;
}
