page 51073 "Approved/Posted Petty Cash"
{
    ApplicationArea = All;
    Caption = 'Petty Cash';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = Payments;
    UsageCategory = None;

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
                    Editable = not OpenApprovalEntriesExist;
                    ToolTip = 'Specifies the value of the Date field';
                }
                field("Petty Cash Type"; Rec."Petty Cash Type")
                {
                    ToolTip = 'Specifies the value of the Petty Cash Type field.';
                }
                group(AccountGroup)
                {
                    ShowCaption = false;
                    Visible = Rec."Petty Cash Type" = Rec."Petty Cash Type"::Float;
                    field("Account No."; Rec."Account No.")
                    {
                        Caption = 'Account No.';
                        Enabled = not DocPosted;
                        ToolTip = 'Specifies the value of the Account No. field';
                    }
                    field("Account Name"; Rec."Account Name")
                    {
                        Caption = 'Account Name';
                        Editable = false;
                        ToolTip = 'Specifies the value of the Account Name field';
                    }
                }
                group(Control49)
                {
                    Caption = 'Dimensions';
                    Editable = not Rec.Posted;

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
                field("Pay Mode"; Rec."Pay Mode")
                {
                    Caption = 'Pay Mode';
                    Editable = not DocPosted;
                    ToolTip = 'Specifies the value of the Pay Mode field';
                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                    end;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Responsibility Center field';
                }
                group("Cheque Details")
                {
                    Caption = 'Cheque Details';
                    Visible = not OpenApprovalEntriesExist and ChequePayment;

                    field("Cheque No"; Rec."Cheque No")
                    {
                        Caption = 'Cheque No';
                        Editable = not OpenApprovalEntriesExist and ChequePayment;
                        ToolTip = 'Specifies the value of the Cheque No field';
                    }
                    field("Cheque Date"; Rec."Cheque Date")
                    {
                        Caption = 'Cheque Date';
                        Editable = not OpenApprovalEntriesExist and ChequePayment;
                        ToolTip = 'Specifies the value of the Cheque Date field';
                    }
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    Caption = 'Paying Bank Account';
                    Enabled = not DocPosted;
                    ToolTip = 'Specifies the value of the Paying Bank Account field';
                }
                field("Payment Release Date"; Rec."Payment Release Date")
                {
                    Caption = 'Posting Date';
                    Enabled = not DocPosted;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Posting Date field';
                }
                field(Payee; Rec.Payee)
                {
                    Caption = 'Payee';
                    Editable = not DocPosted;
                    ToolTip = 'Specifies the value of the Payee field';
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field';
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    Caption = 'Payment Narration';
                    Editable = not DocPosted;
                    ToolTip = 'Specifies the value of the Payment Narration field';
                }
                field("Created By"; Rec."Created By")
                {
                    Caption = 'Created By';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Created By field';
                }
                field(Currency; Rec.Currency)
                {
                    Caption = 'Currency';
                    Editable = not DocPosted;
                    ToolTip = 'Specifies the value of the Currency field';
                }
                field("Posted Date"; Rec."Posted Date")
                {
                    Caption = 'Posted Date';
                    Visible = DocPosted;
                    ToolTip = 'Specifies the value of the Posted Date field';
                }
                field("Petty Cash Amount"; Rec."Petty Cash Amount")
                {
                    Caption = 'Petty Cash Amount';
                    ToolTip = 'Specifies the value of the Petty Cash Amount field';
                }
                field("Petty Cash Amount (LCY)"; Rec."Petty Cash Amount (LCY)")
                {
                    ToolTip = 'Specifies the value of the Total Receiving Amount (LCY) field';
                }
            }
            part(ImprestLines; "Petty Cash Lines")
            {
                Caption = 'Petty Cash Lines';
                Editable = not DocPosted;
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
                    var
                        Error001Err: Label 'Petty Cash Amount can not be less than or equal to 0';
                        Error002Err: Label 'Petty Cash amount can not be greater than %1.%2', Comment = '%1 = LCY Code, %2 = Petty Cash Max';
                    begin
                        GeneralLedgerSetup.Get();
                        CashManagementSetup.Get();
                        CashManagementSetup.TestField("Petty Cash Max");

                        Rec.CalcFields("Petty Cash Amount");
                        if Rec."Petty Cash Amount" <= 0 then
                            Error(Error001Err);

                        if Rec."Petty Cash Amount" > CashManagementSetup."Petty Cash Max" then
                            Error(Error002Err, GeneralLedgerSetup."LCY Code", CashManagementSetup."Petty Cash Max");

                        Committment.CheckPettyCashCommittment(Rec);
                        Committment.PettyCashCommittment(Rec, ErrorMsg);
                        if ErrorMsg <> '' then
                            Error(ErrorMsg);

                        if ApprovalsMgmt.CheckPaymentsApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendPaymentsForApproval(Rec);

                        //Check HOD approver
                        if UserSetup.Get(UserId) then
                            if UserSetup."HOD User" then begin
                                ApprovalEntry.Reset();
                                ApprovalEntry.SetRange("Table ID", Database::Payments);
                                ApprovalEntry.SetRange("Document No.", Rec."No.");
                                ModifyHODApprovals.SetTableView(ApprovalEntry);
                                ModifyHODApprovals.RunModal();
                            end;

                        CurrPage.Close();
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForPayment;
                    Image = Cancel;
                    ToolTip = 'Executes the Cancel Approval Re&quest action';

                    trigger OnAction()
                    var
                        UncommitTxt: Label 'Are you sure you want to cancel the approval request. This will uncommit already committed entries on Document No. %1', Comment = '%1 = Document No.';
                    begin
                        if Confirm(UncommitTxt, false, Rec."No.") = true then begin
                            //Committment.UncommitPettyCash(Rec);
                            Committment.CancelPaymentsCommitments(Rec);
                            ApprovalsMgmt.OnCancelPaymentsApprovalRequest(Rec);
                        end else
                            exit;

                        CurrPage.Close();
                    end;
                }
                action(Reopen)
                {
                    Caption = 'Reopen Document';
                    Image = ReOpen;
                    ToolTip = 'Executes the Reopen Document action';
                    Visible = (Rec.Status = Rec.Status::Released);

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

                        Payments.SetRange("No.", Rec."No.");
                        Report.Run(Report::"Petty Cash Voucher", true, false, Payments)
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;

                action(Post)
                {
                    Caption = 'P&ost';
                    Image = PostOrder;
                    ShortcutKey = 'F9';
                    ToolTip = 'Executes the P&ost action';
                    Visible = not DocPosted;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to post the Petty Cash Voucher No. ' + Rec."No." + '?') then begin
                            PaymentsPost.PostPettyCash(Rec, false);
                            CurrPage.Close();
                        end;
                    end;
                }
                action(PreviewPost)
                {
                    Caption = 'Preview Post';
                    ShortcutKey = 'F9';
                    ToolTip = 'Executes the P&ost action';
                    Visible = not DocPosted;
                    Image = PreviewChecks;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to preview post the Petty Cash Voucher No. ' + Rec."No." + '?') then
                            PaymentsPost.PostPettyCash(Rec, true);
                    end;
                }
                action(Commit)
                {
                    Caption = 'Commit';
                    Image = Confirm;
                    ToolTip = 'Executes the Commit action';
                    Visible = false;
                    trigger OnAction()
                    begin
                        Committment.PettyCashCommittment(Rec, ErrorMsg);
                    end;
                }
                action("Reverse Commitment")
                {
                    Caption = 'Reverse Commitment';
                    ToolTip = 'Executes the Reverse Commitment action';
                    Image = ReverseLines;
                    trigger OnAction()
                    begin
                        Committment.ReversePettyCashCommittment(Rec);
                    end;
                }
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Category_Process';
                actionref(Post_Promoted; Post)
                {
                }
                actionref(Commit_Promoted; Commit)
                {
                }
                actionref(PreviewPost_Promoted; PreviewPost)
                {
                }
            }
            group(Category_Category4)
            {
                Caption = 'Approvals';
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
            group(Category_Report)
            {
                Caption = 'Report';
                actionref("&Print_Promoted"; "&Print")
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
        CashManagementSetup: Record "Cash Management Setups";
        GeneralLedgerSetup: Record "General Ledger Setup";
        PaymentMethod: Record "Payment Method";
        Payments: Record Payments;
        UserSetup: Record "User Setup";
        ModifyHODApprovals: Report "Modify HOD Approvals";
        ApprovalsMgmt: Codeunit "Approval Mgt Finance Ext";
        Committment: Codeunit "Commitments Mgt Finance";
        PaymentsPost: Codeunit "Payments Management";
        CanCancelApprovalForPayment: Boolean;
        ChequePayment: Boolean;
        DocPosted: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowCommentFactbox: Boolean;
        ErrorMsg: Text;

    trigger OnOpenPage()
    begin
        SetControlAppearance();
        //CurrPage.ImprestLines.PAGE.ShowFields("Multi-Donor");
        //ShowDimFields();
        //ShowDim:=TRUE;
        //DocStatus:=FormatStatus(Status);
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();

        //CurrPage.ImprestLines.PAGE.ShowFields("Multi-Donor");
        //ShowDimFields();
        //DocStatus:=FormatStatus(Status);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Petty Cash";
        Rec."Account Type" := Rec."Account Type"::Customer;
        Rec."Pay Mode" := Rec.DefaultPettyCash(Rec."Paying Bank Account");
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
        ApprovalsMgmts: Codeunit "Approvals Mgmt.";
    begin
        if (Rec.Status = Rec.Status::Released) or (Rec.Status = Rec.Status::Rejected) then
            OpenApprovalEntriesExist := ApprovalsMgmts.HasApprovalEntries(Rec.RecordId)
        else
            OpenApprovalEntriesExist := ApprovalsMgmts.HasOpenApprovalEntries(Rec.RecordId);
        DocPosted := Rec.Posted;

        CanCancelApprovalForPayment := ApprovalsMgmts.CanCancelApprovalForRecord(Rec.RecordId);

        if PaymentMethod.Get(Rec."Pay Mode") then
            if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then
                ChequePayment := true
            else
                ChequePayment := false;
    end;
}
