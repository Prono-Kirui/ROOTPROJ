page 51016 "Petty Cash Surrender"
{
    ApplicationArea = All;
    Caption = 'Petty Cash Surrender';
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = Payments;
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = Rec.Status = Rec.Status::Open;
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
                field("Surrender Date"; Rec."Surrender Date")
                {
                    Caption = 'Surrender Date';
                    Editable = not OpenApprovalEntriesExist;
                    ToolTip = 'Specifies the value of the Surrender Date field';
                }
                field("Apply on behalf"; Rec."Apply on behalf")
                {
                    Caption = 'Apply on behalf';
                    ToolTip = 'Specifies the value of the Apply on behalf field';
                }
                field("Account No."; Rec."Account No.")
                {
                    Caption = 'Account No.';
                    Enabled = Rec."Apply on behalf";
                    ToolTip = 'Specifies the value of the Account No. field';
                }
                field("Account Name"; Rec."Account Name")
                {
                    Caption = 'Account Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Account Name field';
                }
                field("Petty Cash Issue Doc.No"; Rec."Petty Cash Issue Doc.No")
                {
                    Caption = 'Petty Cash Issue Doc.No';
                    LookupPageId = "Posted Petty cash";
                    ToolTip = 'Specifies the value of the Petty Cash Issue Doc.No field';
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        PettyCash.Reset();
                        PettyCash.SetRange("Payment Type", Rec."Payment Type"::"Petty Cash");
                        PettyCash.SetRange(Surrendered, false);
                        PettyCash.SetRange("Account No.", Rec."Account No.");
                        if Action::LookupOK = Page.RunModal(Page::"Posted Petty cash", PettyCash) then begin
                            Rec."Petty Cash Issue Doc.No" := PettyCash."No.";
                            Rec.Validate("Petty Cash Issue Doc.No");
                        end;
                    end;
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    Caption = 'Pay Mode';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Pay Mode field';
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    Caption = 'Cheque No';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Cheque No field';
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    Caption = 'Cheque Date';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Cheque Date field';
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    Caption = 'Paying Bank Account';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Paying Bank Account field';
                }
                field(Payee; Rec.Payee)
                {
                    Caption = 'Payee';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Payee field';
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    Caption = 'Payment Narration';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Payment Narration field';
                }
                field("Payment Release Date"; Rec."Payment Release Date")
                {
                    Caption = 'Posting Date';
                    Editable = Rec.Status = Rec.Status::Released;
                    ToolTip = 'Specifies the value of the Posting Date field';
                }
                field("Created By"; Rec."Created By")
                {
                    Caption = 'Created By';
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Created By field';
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field';
                }
                field(Currency; Rec.Currency)
                {
                    Caption = 'Currency';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Currency field';
                }
                field("Petty Cash Amount"; Rec."Petty Cash Amount")
                {
                    Caption = 'Petty Cash Amount';
                    ToolTip = 'Specifies the value of the Petty Cash Amount field';
                }
                field("Actual Petty Cash Amount Spent"; Rec."Actual Petty Cash Amount Spent")
                {
                    Caption = 'Actual Petty Cash Amount Spent';
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Actual Petty Cash Amount Spent field';
                }
                field("Receipted Petty Cash Amount"; Rec."Receipted Petty Cash Amount")
                {
                    Caption = 'Receipted Petty Cash Amount';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Receipted Petty Cash Amount field';
                }
                field("Staff No."; Rec."Staff No.")
                {
                    Caption = 'Staff No.';
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Staff No. field';
                }
                field(Cashier; Rec.Cashier)
                {
                    Caption = 'Cashier';
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Cashier field';
                }
            }
            part("Petty Cash Surrender Lines"; "Imprest Surrender Lines")
            {
                Caption = 'Petty Cash Surrender Lines';
                Editable = Rec.Status = Rec.Status::Open;
                SubPageLink = No = field("No.");
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
            part(CommentsFactBox; "Approval Comments FactBox")
            {
                ApplicationArea = Suite;
                Caption = 'Approval Comments FactBox';
                SubPageLink = "Document No." = field("No.");
                Visible = ShowCommentFactbox;
            }
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

    actions
    {
        area(Processing)
        {
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approval;
                ToolTip = 'Executes the Approvals action';

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalEntries: Page "Approval Entries";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SetCurrentKey("Document No.");
                    ApprovalEntry.SetRange("Table ID", Database::Payments);
                    ApprovalEntry.SetRange("Document No.", Rec."No.");
                    ApprovalEntries.SetTableView(ApprovalEntry);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.RunModal();
                end;
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Enabled = not OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    ToolTip = 'Executes the Send A&pproval Request action';

                    trigger OnAction()
                    begin
                        // Committment.CheckPettyCashSurrenderCommittment(Rec);
                        // Committment.PettyCashSurrenderCommittment(Rec,ErrorMsg);
                        // IF ErrorMsg<>'' THEN
                        //   ERROR(ErrorMsg);

                        if ApprovalsMgmt.CheckPaymentsApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendPaymentsForApproval(Rec);

                        CurrPage.Close();
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = Rec.Status = Rec.Status::"Pending Approval";
                    Image = Cancel;
                    ToolTip = 'Executes the Cancel Approval Re&quest action';

                    trigger OnAction()
                    begin
                        ApprovalsMgmt.OnCancelPaymentsApprovalRequest(Rec);
                    end;
                }
                action(ArchiveDoc)
                {
                    Caption = 'Archive Document';
                    Image = Archive;
                    ToolTip = 'Executes the Archive Document action';

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to archive?', false) then begin
                            PaymentsPost.ArchiveDocument(Rec);
                            CurrPage.Close();
                        end;
                    end;
                }
                action(Reopen)
                {
                    Caption = 'Reopen Document';
                    Image = ReOpen;
                    ToolTip = 'Executes the Reopen Document action';
                    Visible = Rec.Status = Rec.Status::Released;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to reopen?', false) then
                            PaymentsPost.ReopenDocument(Rec);
                    end;
                }
                separator(Action33)
                {
                }
                action("Clear Lines")
                {
                    Caption = 'Clear Lines';
                    Image = DeleteRow;
                    ToolTip = 'Executes the Clear Lines action';
                    trigger OnAction()
                    begin
                        PCLines.Reset();
                        PCLines.SetRange(No, Rec."No.");
                        PCLines.DeleteAll();
                    end;
                }
            }
            group(Print)
            {
                Caption = 'Print';
                Image = Print;

                action("&Print")
                {
                    Caption = '&Print';
                    Ellipsis = true;
                    Image = Print;
                    ToolTip = 'Executes the &Print action';

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);

                        Rec.SetRange("No.", Rec."No.");
                        Report.Run(Report::"Petty Cash Surrender", true, true, Rec)
                    end;
                }
                action("Print Receipt")
                {
                    Caption = 'Print Receipt';
                    Enabled = DocPosted;
                    Image = "Report";
                    ToolTip = 'Executes the Print Receipt action';
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
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';
                actionref(ArchiveDoc_Promoted; ArchiveDoc)
                {
                }
                actionref(Reopen_Promoted; Reopen)
                {
                }
                actionref("Clear Lines_Promoted"; "Clear Lines")
                {
                }
            }
            group(Category_Report)
            {
                Caption = 'Report', Comment = 'Generated from the PromotedActionCategories property index 2.';

                actionref("&Print_Promoted"; "&Print")
                {
                }
                actionref("Print Receipt_Promoted"; "Print Receipt")
                {
                }
            }
            group(Category_Category4)
            {
                Caption = 'Approvals', Comment = 'Generated from the PromotedActionCategories property index 3.';

                actionref(SendApprovalRequest_Promoted; SendApprovalRequest)
                {
                }
                actionref(CancelApprovalRequest_Promoted; CancelApprovalRequest)
                {
                }
                actionref(Approvals_Promoted; Approvals)
                {
                }
            }
        }
    }

    var
        ApprovalEntry: Record "Approval Entry";
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        PCLines: Record "Payment Lines";
        PettyCash: Record Payments;
        ApprovalsMgmt: Codeunit "Approval Mgt Finance Ext";
        PaymentsPost: Codeunit "Payments Management";
        DocPosted: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowCommentFactbox: Boolean;
        Text000: Label 'Receipt No %1 has not been posted';

    trigger OnOpenPage()
    begin
        SetControlAppearance();

        //DocStatus:=FormatStatus(Status);
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();

        //DocStatus:=FormatStatus(Status);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Petty Cash Surrender";
        Rec."Account Type" := Rec."Account Type"::Customer;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Petty Cash Surrender";
        Rec."Account Type" := Rec."Account Type"::Customer;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange("Document No.", Rec."No.");
        if ApprovalEntry.Find('-') then
            ShowCommentFactbox := CurrPage.CommentsFactBox.Page.SetFilterFromApprovalEntry(ApprovalEntry);
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        if (Rec.Status = Rec.Status::Released) or (Rec.Status = Rec.Status::Rejected) then
            OpenApprovalEntriesExist := ApprovalsMgmt.HasApprovalEntries(Rec.RecordId)
        else
            OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        DocPosted := Rec.Posted;
    end;
}
