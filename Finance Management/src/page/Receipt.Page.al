page 51031 Receipt
{
    ApplicationArea = All;
    Caption = 'Receipt';
    DeleteAllowed = false;
    PageType = Card;
    Permissions =;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = Payments;
    UsageCategory = None;
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
                    ToolTip = 'Specifies the value of the No. field';
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
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
                    Visible = ChequePayment;
                    Editable = ChequePayment;
                    ToolTip = 'Specifies the value of the Cheque No field';
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    Caption = 'Cheque Date';
                    Visible = ChequePayment;
                    Editable = ChequePayment;
                    ToolTip = 'Specifies the value of the Cheque Date field';
                }
                field("Imprest Surrender Receipt"; Rec."Imprest Surrender Receipt")
                {
                    Caption = 'Imprest Surrender Receipt';
                    ToolTip = 'Specifies the value of the Imprest Surrender Receipt field';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                    ToolTip = 'Specifies the value of the Responsibility Center field';
                }
                group(Dimensions)
                {
                    Caption = 'Dimensions';
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
                    field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                    {
                        Caption = 'Shortcut Dimension 3 Code';
                        ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field';
                        Visible = false;
                    }
                }
                group(Control30)
                {
                    ShowCaption = false;
                    Visible = Rec."Imprest Surrender Receipt" = true;

                    field("Imprest Surrender Doc. No"; Rec."Imprest Surrender Doc. No")
                    {
                        Caption = 'Imprest Surrender Doc. No';
                        ToolTip = 'Specifies the value of the Imprest Surrender Doc. No field';
                        trigger OnValidate()
                        begin
                            SetControlAppearance();
                            CurrPage.Update();
                        end;
                    }
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    Caption = 'Payment Narration';
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Payment Narration field';
                }
                field("Received From"; Rec."Received From")
                {
                    Caption = 'Payee';
                    Editable = DocPosted;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Received From field';
                }
                field("On behalf of"; Rec."On behalf of")
                {
                    Caption = 'On behalf of';
                    Editable = DocPosted;
                    ToolTip = 'Specifies the value of the On behalf of field';
                    Visible = false;
                }
                field("Bank Code"; Rec."Paying Bank Account")
                {
                    Caption = 'Receiving Bank Account';
                    Editable = DocPosted;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Paying Bank Account field';
                }
                field("Payment Release Date"; Rec."Payment Release Date")
                {
                    Caption = 'Posting Date';
                    ShowMandatory = true;
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
                group(Control19)
                {
                    ShowCaption = false;
                    Visible = ImprestReceiptLines;

                    field("Imp Surr Receipt Amount"; Rec."Imp Surr Receipt Amount")
                    {
                        Caption = 'Surrender Receipt Amount';
                        ToolTip = 'Specifies the value of the Surrender Receipt Amount field';
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
            part("Receipt Lines"; "Receipt Lines")
            {
                Caption = 'Receipt Lines';
                Editable = PostedEditable;
                SubPageLink = No = field("No.");
                Visible = NormalReceiptLines;
            }
            part(Control18; "Imprest Surrender Lines")
            {
                Caption = 'Imprest Surrender Lines';
                Editable = PostedEditable;
                SubPageLink = No = field("Imprest Surrender Doc. No");
                Visible = ImprestReceiptLines;
            }
        }
        area(FactBoxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::Payments),
                              "No." = field("No.");
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
                        ReceiptsPost.PostReceipt(Rec);

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
                        Payments2.Reset();
                        Payments2.SetRange("No.", Rec."No.");
                        Report.Run(Report::"Receipt Custom", false, true, Payments2);
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
                            Error(Text000Lbl, Rec."No.");
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
                        Payments2.Reset();
                        Payments2.SetRange("No.", Rec."No.");
                        Report.Run(Report::"Receipt Custom", true, false, Payments2);
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
                        Payments2.Reset();
                        Payments2.SetRange("No.", Rec."No.");
                        Report.Run(Report::"Receipt Custom", false, true, Payments2);
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
        Payments2: Record Payments;
        ReceiptsPost: Codeunit "Payments Management";
        ChequePayment: Boolean;
        DocPosted: Boolean;
        ImprestReceiptLines: Boolean;
        NormalReceiptLines: Boolean;
        PostedEditable: Boolean;
        Text000Lbl: Label 'Receipt No %1 has not been posted', Comment = '%1 = Receipt No';

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
        Rec."Payment Type" := Rec."Payment Type"::Receipt;
    end;

    local procedure SetControlAppearance()
    begin
        DocPosted := not Rec.Posted;
        if PaymentMethod.Get(Rec."Pay Mode") then;
        if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then
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
