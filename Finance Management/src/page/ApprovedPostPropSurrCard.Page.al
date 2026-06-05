page 51121 "Approved/Post Prop Surr. Card"
{
    ApplicationArea = All;
    Caption = 'Approved/Post Property Surr. Card';
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
                    ToolTip = 'Specifies the value of the Surrender Date field';
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
                field("Property Expense Doc. No"; Rec."Property Expense Doc. No")
                {
                    Caption = 'Property Expense Doc. No.';
                    Editable = not OpenApprovalEntriesExist;
                    ToolTip = 'Specifies the value of the Imprest Issue Doc. No field';
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        ImprestRec.Reset();
                        ImprestRec.SetRange("Payment Type", Rec."Payment Type"::"Property Expense");
                        ImprestRec.SetRange(Surrendered, false);
                        ImprestRec.SetRange("Account No.", Rec."Account No.");
                        if Action::LookupOK = Page.RunModal(Page::"Posted Property Expenses", ImprestRec) then begin
                            Rec."Property Expense Doc. No" := ImprestRec."No.";
                            Rec.Validate("Property Expense Doc. No");
                        end;
                    end;
                }
                group(Control52)
                {
                    ShowCaption = false;

                    field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                    {
                        Caption = 'Shortcut Dimension 1 Code';
                        Editable = false;
                        ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                    }
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
                        Caption = 'Shortcut Dimension 2 Code';
                        Editable = false;
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
                    ToolTip = 'Specifies the value of the Paying Bank Account field';
                }
                field(Currency; Rec.Currency)
                {
                    Caption = 'Currency';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Currency field';
                }
                field(Payee; Rec.Payee)
                {
                    Caption = 'Payee';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Payee field';
                }
                field(Narration; Rec."Payment Narration")
                {
                    Caption = 'Payment Narration';
                    Editable = not OpenApprovalEntriesExist;
                    ToolTip = 'Specifies the value of the Payment Narration field';
                }
                group(Control47)
                {
                    Editable = false;
                    ShowCaption = false;

                    field(Destination; Rec.Destination)
                    {
                        Caption = 'Destination';
                        ToolTip = 'Specifies the value of the Destination field';
                    }
                    field("No of Days"; Rec."No of Days")
                    {
                        Caption = 'No of Days';
                        ToolTip = 'Specifies the value of the No of Days field';
                    }
                    field("Date of Project"; Rec."Date of Project")
                    {
                        Caption = 'Date of Project';
                        ToolTip = 'Specifies the value of the Date of Project field';
                    }
                    field("Date of Completion"; Rec."Date of Completion")
                    {
                        Caption = 'Date of Completion';
                        ToolTip = 'Specifies the value of the Date of Completion field';
                    }
                    field("Due Date"; Rec."Due Date")
                    {
                        Caption = 'Due Date';
                        ToolTip = 'Specifies the value of the Due Date field';
                    }
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
                field("Imprest Amount"; Rec."Imprest Amount")
                {
                    Caption = 'Imprest Amount';
                    ToolTip = 'Specifies the value of the Imprest Amount field';
                }
                field("Actual Amount Spent"; Rec."Actual Amount Spent")
                {
                    Caption = 'Actual Amount Spent';
                    ToolTip = 'Specifies the value of the Actual Amount Spent field';
                }
                field("Cash Receipt Amount"; Rec."Cash Receipt Amount")
                {
                    Caption = 'Cash Receipt Amount';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Cash Receipt Amount field';
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
            part(Control19; "Property Exp Surrender Lines")
            {
                Caption = 'Surrender Lines';
                SubPageLink = No = field("No."),
                              "Payment Type" = field("Payment Type");
            }
            part(Control61; "Apportionment Allocation Lines")
            {
                Caption = 'Apportionment Allocation Lines';
                Editable = not Rec.Posted;
                SubPageLink = "Document No." = field("No.");
                Visible = Rec.Apportion;
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
                    begin
                        Rec.TestField("Surrender Date");

                        Rec.ValidateSurrender();
                        // Committment.CheckImprestSurrenderCommittment(Rec);
                        // Committment.ImprestSurrenderCommittment(Rec,ErrorMsg);
                        //
                        // IF ErrorMsg<>'' THEN
                        //  ERROR(ErrorMsg);

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
                    begin
                        ApprovalsMgmt.OnCancelPaymentsApprovalRequest(Rec);

                        CurrPage.Close();
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

                        Rec.SetRange("No.", Rec."No.");
                        Report.Run(Report::"Imprest Surrender", true, true, Rec);
                    end;
                }
                action("Print Cash Receipt")
                {
                    Caption = 'Print Cash Receipt';
                    Ellipsis = true;
                    Image = PrintVoucher;
                    ToolTip = 'Executes the Print Cash Receipt action';

                    trigger OnAction()
                    begin
                        Rec.CalcFields("Cash Receipt No. Surr");
                        if Rec."Cash Receipt No. Surr" = '' then
                            Error('There is no posted receipt associated with Imprest Surrender No.%1', Rec."No.");

                        BankLedgerEntry.SetRange(BankLedgerEntry."Document No.", Rec."Cash Receipt No. Surr");
                        Report.Run(Report::Receipt, true, false, BankLedgerEntry);
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
                    var
                        ReleasePmt: Codeunit "Release Payments";
                    begin
                        if Confirm('Are you sure?', false) then
                            ReleasePmt.PerformManualReopen(Rec);
                        /* Status := Status::Open;
                        Modify();
                        Message('Reopened Successfully'); */
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
                    Visible = DocReleased and not DocPosted;

                    trigger OnAction()
                    begin
                        PaymentsPost.ConfirmPost(Rec);
                        PaymentsPost.PostPropertyExpenseSurrender(Rec);

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
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';

                actionref("Post & Print_Promoted"; "Post & Print")
                {
                }
            }
            group(Category_Report)
            {
                Caption = 'Report', Comment = 'Generated from the PromotedActionCategories property index 2.';

                actionref("&Print_Promoted"; "&Print")
                {
                }
                actionref("Print Cash Receipt_Promoted"; "Print Cash Receipt")
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
                actionref(Approve_Promoted; Approve)
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
                Caption = 'Navigate', Comment = 'Generated from the PromotedActionCategories property index 4.';

                actionref(Navigate_Promoted; Navigate)
                {
                }
            }
        }
    }

    var
        ApprovalEntry: Record "Approval Entry";
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        ImprestRec: Record Payments;
        UserSetup: Record "User Setup";
        ModifyHODApprovals: Report "Modify HOD Approvals";
        ApprovalsMgmt: Codeunit "Approval Mgt Finance Ext";
        PaymentsPost: Codeunit "Payments Management";
        CanCancelApprovalForPayment: Boolean;
        DocPosted: Boolean;
        DocReleased: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowCommentFactbox: Boolean;

    trigger OnOpenPage()
    begin
        SetControlAppearance();
        //SETRANGE("Created By",USERID);
        //DocStatus:=FormatStatus(Status);
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
        //DocStatus:=FormatStatus(Status);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Imprest Surrender";
        Rec."Account Type" := Rec."Account Type"::Customer;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Imprest Surrender";
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
            OpenApprovalEntriesExist := true //ApprovalsMgmt.HasApprovalEntries(RecordId)
        else
            OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForPayment := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        DocPosted := Rec.Posted;

        if Rec.Status = Rec.Status::Released then
            DocReleased := true;
    end;
}
