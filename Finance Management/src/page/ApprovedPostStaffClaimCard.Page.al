page 51065 "Approved/Post Staff Claim Card"
{
    ApplicationArea = All;
    Caption = 'Approved/Post Staff Claim Card';
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
                    Editable = not OpenApprovalEntriesExist;
                    ToolTip = 'Specifies the value of the Date field';
                }
                field("Staff No."; Rec."Staff No.")
                {
                    Caption = 'Staff No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Staff No. field';
                }
                field("Account No."; Rec."Account No.")
                {
                    Caption = 'Account No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Account No. field';
                    Visible = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    Caption = 'Account Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Account Name field';
                }
                field("Claim Type"; Rec."Claim Type")
                {
                    Caption = 'Claim Type';
                    Editable = not OpenApprovalEntriesExist;
                    ToolTip = 'Specifies the value of the Claim Type field';
                }
                group(Control49)
                {
                    Editable = not Rec.Posted;
                    ShowCaption = false;
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
                    Editable = OpenApprovalEntriesExist and not DocPosted;
                    ToolTip = 'Specifies the value of the Pay Mode field';
                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                    end;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    Caption = 'Cheque No';
                    Editable = OpenApprovalEntriesExist and ChequePayment and not DocPosted;
                    ToolTip = 'Specifies the value of the Cheque No field';
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    Caption = 'Cheque Date';
                    Editable = OpenApprovalEntriesExist and ChequePayment and not DocPosted;
                    ToolTip = 'Specifies the value of the Cheque Date field';
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    Caption = 'Paying Bank Account';
                    Editable = OpenApprovalEntriesExist and not DocPosted;
                    ToolTip = 'Specifies the value of the Paying Bank Account field';
                }
                field(Payee; Rec.Payee)
                {
                    Caption = 'Payee';
                    Editable = not OpenApprovalEntriesExist;
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
                    Caption = 'Purpose';
                    Editable = not OpenApprovalEntriesExist;
                    ToolTip = 'Specifies the value of the Purpose field';

                    trigger OnValidate()
                    begin
                        Rec.TestField("Payment Narration");
                    end;
                }
                field("Created By"; Rec."Created By")
                {
                    Caption = 'Created By';
                    ToolTip = 'Specifies the value of the Created By field';
                }
                field(Currency; Rec.Currency)
                {
                    Caption = 'Currency';
                    Editable = not OpenApprovalEntriesExist;
                    ToolTip = 'Specifies the value of the Currency field';
                }
                field("Petty Cash Amount"; Rec."Petty Cash Amount")
                {
                    Caption = 'Staff Claim Amount';
                    TableRelation = Payments."Petty Cash Net Amount";
                    ToolTip = 'Specifies the value of the Staff Claim Amount field';
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
            part(Control19; "Staff Claim Lines")
            {
                Caption = 'Staff Claim Lines';
                Editable = not OpenApprovalEntriesExist;
                SubPageLink = No = field("No.");
            }
            part(Control55; "Apportionment Allocation Lines")
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
                    var
                        Error001: Label 'Petty Cash Amount can not be less than or equal to 0';
                    begin
                        GeneralLedgerSetup.Get();
                        CashManagementSetup.Get();

                        if Rec."Claim Type" = Rec."Claim Type"::" " then
                            Error('Please define a claim type');

                        if Rec."Payment Narration" = '' then
                            Error('Please define the Purpose for this claim');

                        ClaimLines.Reset();
                        ClaimLines.SetRange(ClaimLines.No, Rec."No.");
                        if ClaimLines.Find('-') then
                            repeat
                                ClaimLines.TestField("Expenditure Date");
                                //ClaimLines.TESTFIELD("Claim Receipt No.");
                                ClaimLines.TestField("Expenditure Description");
                            until ClaimLines.Next() = 0;

                        Rec.CalcFields("Petty Cash Amount");
                        if Rec."Petty Cash Amount" <= 0 then
                            Error(Error001);

                        Committment.CheckStaffClaimCommittment(Rec);
                        Committment.StaffClaimCommittment(Rec, ErrorMsg);
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
                    begin
                        // IF CONFIRM(UncommitTxt,FALSE,"No.")=TRUE THEN
                        //  BEGIN
                        //    Committment.UncommitImprest(Rec);
                        ApprovalsMgmt.OnCancelPaymentsApprovalRequest(Rec);
                        //  END ELSE
                        //    EXIT;
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
                        Report.Run(Report::"Staff Claim Voucher", true, true, Rec)
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

                action(Post)
                {
                    Caption = 'P&ost';
                    Enabled = not Rec.Posted;
                    Image = PostOrder;
                    ShortcutKey = 'F9';
                    ToolTip = 'Executes the P&ost action';
                    Visible = PayingBankEditable;

                    trigger OnAction()
                    begin
                        PaymentsPost.ConfirmPost(Rec);
                        PaymentsPost.PostStaffClaim(Rec);
                        CurrPage.Close();
                    end;
                }
                action(Commit)
                {
                    Caption = 'Commit Funds';
                    Image = Confirm;
                    ToolTip = 'Executes the Commit Funds action';

                    trigger OnAction()
                    begin
                        Committment.StaffClaimCommittment(Rec, ErrorMsg);
                    end;
                }
                action("Reverse Commitment")
                {
                    Caption = 'Reverse Commitment';
                    ToolTip = 'Executes the Reverse Commitment action';
                    trigger OnAction()
                    begin
                        Committment.ReversePettyCashCommittment(Rec);
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
            group(Category_New)
            {
                Caption = 'Category_New';
                actionref(Approve_Promoted; Approve)
                {
                }
            }
            group(Category_Process)
            {
                Caption = 'Category_Process';
                actionref(Post_Promoted; Post)
                {
                }
                actionref(Commit_Promoted; Commit)
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
            group(Category_Category4)
            {
                Caption = 'Category_Category4';
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
        CashManagementSetup: Record "Cash Management Setups";
        GeneralLedgerSetup: Record "General Ledger Setup";
        ClaimLines: Record "Payment Lines";
        PaymentMethod: Record "Payment Method";
        UserSetup: Record "User Setup";
        ModifyHODApprovals: Report "Modify HOD Approvals";
        ApprovalsMgmt: Codeunit "Approval Mgt Finance Ext";
        Committment: Codeunit "Commitments Mgt Finance";
        PaymentsPost: Codeunit "Payments Management";
        CanCancelApprovalForPayment: Boolean;
        ChequePayment: Boolean;
        DocPosted: Boolean;
        DocReleased: Boolean;
        OpenApprovalEntriesExist: Boolean;
        PayingBankEditable: Boolean;
        ShowCommentFactbox: Boolean;
        ShowDim: Boolean;
        ErrorMsg: Text;

    trigger OnOpenPage()
    begin
        SetControlAppearance();
        //CurrPage..PAGE.ShowFields("Multi-Donor");
        //ShowDimFields();
        //ShowDim := true;
        //DocStatus:=FormatStatus(Status);
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();

        //CurrPage. .PAGE.ShowFields("Multi-Donor");
        //ShowDimFields();
        //DocStatus:=FormatStatus(Status);
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange("Document No.", Rec."No.");
        if ApprovalEntry.Find('-') then
            ShowCommentFactbox := CurrPage.CommentsFactBox.Page.SetFilterFromApprovalEntry(ApprovalEntry);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Staff Claim";
        Rec."Account Type" := Rec."Account Type"::Customer;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        //CurrPage.ImprestLines.PAGE.ShowFields("Multi-Donor");
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        if (Rec.Status = Rec.Status::Released) or (Rec.Status = Rec.Status::Rejected) then
            OpenApprovalEntriesExist := true //ApprovalsMgmt.HasApprovalEntries(RecordId)
        else
            OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        DocPosted := Rec.Posted;
        if Rec.Status = Rec.Status::Released then
            DocReleased := true
        else
            DocReleased := false;
        CanCancelApprovalForPayment := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);

        if PaymentMethod.Get(Rec."Pay Mode") then;
        if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then
            ChequePayment := true
        else
            ChequePayment := false;

        if Rec.Status = Rec.Status::Released then
            PayingBankEditable := true
        else
            PayingBankEditable := false;
    end;

    local procedure ShowDimFields()
    begin
        if Rec."Multi-Donor" then
            ShowDim := false
        else
            ShowDim := true;
        CurrPage.Update();
    end;
}
