page 51072 "Approved Petty Cash Surrender"
{
    ApplicationArea = All;
    Caption = 'Approved Petty Cash Surrender';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = Payments;
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
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
                field("Surrender Date"; Rec."Surrender Date")
                {
                    Caption = 'Surrender Date';
                    Editable = not OpenApprovalEntriesExist;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Surrender Date field';
                }
                field("Petty Cash Issue Doc.No"; Rec."Petty Cash Issue Doc.No")
                {
                    Caption = 'Petty Cash Issue Doc.No';
                    Editable = not OpenApprovalEntriesExist;
                    LookupPageId = "Posted Petty cash";
                    ToolTip = 'Specifies the value of the Petty Cash Issue Doc.No field';
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        PettyCash.Reset();
                        PettyCash.SetRange("Payment Type", Rec."Payment Type"::"Petty Cash");
                        PettyCash.SetRange(Surrendered, false);
                        PettyCash.SetRange("Account No.", Rec."Account No.");
                        if Action::LookupOK = Page.RunModal(80323, PettyCash) then begin
                            Rec."Petty Cash Issue Doc.No" := PettyCash."No.";
                            Rec.Validate("Petty Cash Issue Doc.No");
                        end;
                    end;
                }
                field("Account No."; Rec."Account No.")
                {
                    Caption = 'Account No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Account No. field';
                }
                field("Account Name"; Rec."Account Name")
                {
                    Caption = 'Account Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Account Name field';
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
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Posting Date field';
                }
                field("Created By"; Rec."Created By")
                {
                    Caption = 'Created By';
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
                    ToolTip = 'Specifies the value of the Actual Petty Cash Amount Spent field';
                }
                field("Receipted Petty Cash Amount"; Rec."Receipted Petty Cash Amount")
                {
                    Caption = 'Receipted Petty Cash Amount';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Receipted Petty Cash Amount field';
                }
                group("Apportion?")
                {
                    Caption = 'Apportion?';
                    Visible = false;

                    field("No Apportion"; Rec."No Apportion")
                    {
                        Caption = 'No';
                        ToolTip = 'Specifies the value of the No field';
                    }
                    field(Apportion; Rec.Apportion)
                    {
                        Caption = 'Yes';
                        ToolTip = 'Specifies the value of the Yes field';
                    }
                }
            }
            part("Petty Cash Surrender Lines"; "Imprest Surrender Lines")
            {
                Caption = 'Petty Cash Surrender Lines';
                Editable = not Rec.Posted;
                SubPageLink = No = field("No.");
            }
            part(Control54; "Apportionment Allocation Lines")
            {
                Caption = 'Apportionment Allocation Lines';
                Editable = not Rec.Posted;
                SubPageLink = "Document No." = field("No.");
                Visible = Rec.Apportion;
            }
        }
        area(FactBoxes)
        {
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
        area(Navigation)
        {
            group("Payment Voucher")
            {
                Caption = 'Payment Voucher';
                Image = "Order";

                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = page "Comment Sheet";
                    ToolTip = 'Executes the Co&mments action';
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortcutKey = 'Shift+Ctrl+D';
                    ToolTip = 'Executes the Dimensions action';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim();
                        CurrPage.SaveRecord();
                    end;
                }
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
                action(Navigate)
                {
                    Caption = '&Navigate';
                    Image = Navigate;
                    ToolTip = 'Find all entries and documents that exist for the document number and posting date on the posted purchase document.';
                    Visible = DocPosted;

                    trigger OnAction()
                    begin
                        Rec.Navigate();
                    end;
                }
            }
        }
        area(Processing)
        {
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
            group(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;

                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortcutKey = 'Ctrl+F9';
                    ToolTip = 'Executes the Re&lease action';
                    Visible = false;

                    trigger OnAction()
                    begin
                        //ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    ToolTip = 'Executes the Re&open action';
                    Visible = false;

                    trigger OnAction()
                    begin
                        //ReleasePurchDoc.PerformManualReopen(Rec);
                        //ReleasePurchDoc.ReopenPV(Rec);
                    end;
                }
                separator(Action27)
                {
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;

                action("Post & Print")
                {
                    Caption = 'P&ost';
                    Image = PostOrder;
                    ShortcutKey = 'F9';
                    ToolTip = 'Executes the P&ost action';
                    Visible = not DocPosted;

                    trigger OnAction()
                    begin
                        PaymentsPost.ConfirmPost(Rec);
                        PaymentsPost.PostPettyCashSurrender(Rec);

                        // IF Posted THEN BEGIN
                        //
                        // BankLedgerEntry.SETRANGE(BankLedgerEntry."Document No.","No.");
                        // REPORT.RUN(report::"Receipt",FALSE,FALSE,BankLedgerEntry);
                        //
                        // END;

                        CurrPage.Close();
                    end;
                }
                action(Approve)
                {
                    Caption = 'Approve';
                    Image = Approve;
                    ToolTip = 'Executes the Approve action';
                }
                action(Reject)
                {
                    Caption = 'Reject';
                    Image = Reject;
                    ToolTip = 'Executes the Reject action';
                }
                action(Delegate)
                {
                    Caption = 'Delegate';
                    Image = Delegate;
                    ToolTip = 'Executes the Delegate action';
                }
            }
        }
        area(Promoted)
        {
            group(Category_New)
            {
                Caption = 'New', Comment = 'Generated from the PromotedActionCategories property index 0.';

                actionref(Approve_Promoted; Approve)
                {
                }
            }
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';

                actionref("Post & Print_Promoted"; "Post & Print")
                {
                }
                actionref(SendApprovalRequest_Promoted; SendApprovalRequest)
                {
                }
                actionref(CancelApprovalRequest_Promoted; CancelApprovalRequest)
                {
                }
                actionref("&Print_Promoted"; "&Print")
                {
                }
            }
            group(Category_Report)
            {
                Caption = 'Report', Comment = 'Generated from the PromotedActionCategories property index 2.';

                actionref("Print Receipt_Promoted"; "Print Receipt")
                {
                }
            }
            group(Category_Category4)
            {
                Caption = 'Misc', Comment = 'Generated from the PromotedActionCategories property index 3.';

                actionref(ArchiveDoc_Promoted; ArchiveDoc)
                {
                }
                actionref(Reopen_Promoted; Reopen)
                {
                }
                actionref(Approvals_Promoted; Approvals)
                {
                }
            }
            group(Category_Category5)
            {
                Caption = 'Navigate';
                actionref(Navigate_Promoted; Navigate)
                {
                }
            }
        }
    }

    var
        ApprovalEntry: Record "Approval Entry";
        BankLedgerEntry: Record "Bank Account Ledger Entry";
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
