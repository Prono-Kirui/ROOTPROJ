page 51119 "Approved Property Expense Card"
{
    ApplicationArea = All;
    Caption = 'Approved Property Expense Card';
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
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date field';
                }
                field("Time Inserted"; Rec."Time Inserted")
                {
                    Caption = 'Time';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Time field';
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
                field("Staff No."; Rec."Staff No.")
                {
                    Caption = 'Staff No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Staff No. field';
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
                group("Payment Details")
                {
                    Caption = 'Payment Details';
                    Visible = DocReleased;
                    field("Payment Release Date"; Rec."Payment Release Date")
                    {
                        Caption = 'Posting Date';
                        ToolTip = 'Specifies the value of the Posting Date field';
                    }
                    field("Pay Mode"; Rec."Pay Mode")
                    {
                        Caption = 'Pay Mode';
                        Editable = OpenApprovalEntriesExist and not DocPosted;
                        ShowMandatory = true;
                        ToolTip = 'Specifies the value of the Pay Mode field';
                        Visible = DocReleased;
                        trigger OnValidate()
                        begin
                            SetControlAppearance();
                        end;
                    }
                    field("Paying Bank Account"; Rec."Paying Bank Account")
                    {
                        Caption = 'Paying Bank Account';
                        Enabled = OpenApprovalEntriesExist and not DocPosted;
                        ShowMandatory = true;
                        ToolTip = 'Specifies the value of the Paying Bank Account field';
                        Visible = DocReleased;
                    }
                    group(Control69)
                    {
                        ShowCaption = false;
                        Visible = ChequePayment;
                        field("Cheque Type"; Rec."Cheque Type")
                        {
                            Caption = 'Cheque Type';
                            Editable = OpenApprovalEntriesExist and ChequePayment and not DocPosted;
                            ToolTip = 'Specifies the value of the Cheque Type field';
                        }
                        field("Cheque No"; Rec."Cheque No")
                        {
                            Caption = 'Cheque No';
                            Editable = OpenApprovalEntriesExist and ChequePayment and not DocPosted;
                            ToolTip = 'Specifies the value of the Cheque No field';
                            Visible = DocReleased;
                        }
                        field("Cheque Date"; Rec."Cheque Date")
                        {
                            Caption = 'Cheque Date';
                            Editable = OpenApprovalEntriesExist and ChequePayment and not DocPosted;
                            ToolTip = 'Specifies the value of the Cheque Date field';
                            Visible = DocReleased;
                        }
                    }
                }
                group(Control64)
                {
                    ShowCaption = false;
                    field(Currency; Rec.Currency)
                    {
                        Caption = 'Currency';
                        Editable = not OpenApprovalEntriesExist and not DocPosted;
                        ToolTip = 'Specifies the value of the Currency field';
                    }
                }
                field(Payee; Rec.Payee)
                {
                    Caption = 'Imprest Payee';
                    Editable = not OpenApprovalEntriesExist;
                    ToolTip = 'Specifies the value of the Imprest Payee field';
                }
                field("Payment Voucher Payee"; Rec."On behalf of")
                {
                    Caption = 'On behalf of';
                    Editable = not DocPosted;
                    ToolTip = 'Specifies the value of the On behalf of field';
                    Visible = DocReleased;
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    Caption = 'Purpose';
                    Editable = not OpenApprovalEntriesExist;
                    ToolTip = 'Specifies the value of the Purpose field';
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
                field("Imprest Amount"; Rec."Imprest Amount")
                {
                    Caption = 'Imprest Amount';
                    ToolTip = 'Specifies the value of the Imprest Amount field';
                }
                field(Posted; Rec.Posted)
                {
                    Caption = 'Posted';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Posted field';
                    Visible = DocPosted;
                }
                field("Posted By"; Rec."Posted By")
                {
                    Caption = 'Posted By';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Posted By field';
                    Visible = DocPosted;
                }
                field("Posted Date"; Rec."Posted Date")
                {
                    Caption = 'Posted Date';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Posted Date field';
                    Visible = DocPosted;
                }
            }
            part(ImprestLines; "Property Expense Request Lines")
            {
                Caption = 'Property Expense Lines';
                Editable = not OpenApprovalEntriesExist;
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
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                Caption = 'Incoming Doc. Attach. FactBox';
                ShowFilter = false;
                Visible = false;
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                Caption = 'Workflow Status FactBox';
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            systempart(Control53; Links)
            {
            }
            systempart(Control52; Notes)
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
                        imprestAmountInvalidErr: Label 'Imprest Amount can not be less than or equal to 0';
                    begin
                        Rec.CalcFields("Imprest Amount");
                        if Rec."Imprest Amount" <= 0 then
                            Error(imprestAmountInvalidErr);

                        Rec.TestField("Payment Narration");
                        // ImpLines.RESET;
                        // ImpLines.SETRANGE(No,"No.");
                        // IF ImpLines.FIND('-') THEN
                        //   //BEGIN
                        //    RPTypes.RESET;
                        //    RPTypes.SETRANGE(Code,ImpLines."Expenditure Type");
                        //    IF RPTypes.FIND('-') THEN
                        //         IF RPTypes."Cost of Sale"=TRUE THEN
                        //          MESSAGE('%1,%2,%3',RPTypes.Code,ImpLines."Expenditure Type",RPTypes."Cost of Sale");

                        Committment.CheckImprestCommittment(Rec);
                        Committment.ImprestCommittment(Rec, ErrorMsg);
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
                    Enabled = not DocReleased;
                    Image = Cancel;
                    ToolTip = 'Executes the Cancel Approval Re&quest action';

                    trigger OnAction()
                    var
                        UncommitTxt: Label 'Are you sure you want to cancel the approval request. This will uncommit already committed entries on Document No. %1', Comment = '%1 = Document No.';
                    begin
                        if Confirm(UncommitTxt, false, Rec."No.") = true then begin
                            //Committment.UncommitImprest(Rec);
                            ApprovalsMgmt.OnCancelPaymentsApprovalRequest(Rec);
                            Committment.CancelPaymentsCommitments(Rec);
                        end else
                            exit;
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
                        //DocPrint.PrintPurchHeader(Rec);

                        Rec.SetRange("No.", Rec."No.");
                        Report.Run(Report::Imprest, true, true, Rec)
                    end;
                }
                action("&Print Payment Voucher")
                {
                    Caption = '&Print Payment Voucher';
                    Ellipsis = true;
                    Image = Print;
                    ToolTip = 'Executes the &Print Payment Voucher action';
                    Visible = false;

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);

                        Rec.SetRange("No.", Rec."No.");
                        Report.Run(Report::"Login Management", true, true, Rec)
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
                    Enabled = DocReleased and not DocPosted;
                    Image = PostOrder;
                    ShortcutKey = 'F9';
                    ToolTip = 'Executes the P&ost action';

                    trigger OnAction()
                    begin
                        PaymentsPost.ConfirmPost(Rec);
                        PaymentsPost.PostPropertyExpenseImprest(Rec);
                        CurrPage.Close();
                    end;
                }
                action(Commit)
                {
                    Caption = 'Commit';
                    Image = Confirm;
                    ToolTip = 'Executes the Commit action';                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Committment.ImprestCommittment(Rec, ErrorMsg);
                    end;
                }
                action("Reverse Commitment")
                {
                    Caption = 'Reverse Commitment';
                    ToolTip = 'Executes the Reverse Commitment action';
                    Image = ReverseLines;
                    trigger OnAction()
                    begin
                        Committment.ReverseImprestCommittment(Rec);
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
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';

                actionref(Post_Promoted; Post)
                {
                }
            }
            group(Category_Report)
            {
                Caption = 'Report', Comment = 'Generated from the PromotedActionCategories property index 2.';

                actionref("&Print_Promoted"; "&Print")
                {
                }
                actionref("&Print Payment Voucher_Promoted"; "&Print Payment Voucher")
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
        PaymentMethod: Record "Payment Method";
        UserSetup: Record "User Setup";
        ModifyHODApprovals: Report "Modify HOD Approvals";
        ApprovalsMgmt: Codeunit "Approval Mgt Finance Ext";
        Committment: Codeunit "Commitments Mgt Finance";
        PaymentsPost: Codeunit "Payments Management";
        //CanCancelApprovalForRecord: Boolean;
        ChequePayment: Boolean;
        //CurVisible: Boolean;
        DocPosted: Boolean;
        DocReleased: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowCommentFactbox: Boolean;
        //ShowDim: Boolean;
        ShowWorkflowStatus: Boolean;
        ErrorMsg: Text;

    trigger OnInit()
    begin
    end;

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
        Rec."Payment Type" := Rec."Payment Type"::Imprest;
        Rec."Account Type" := Rec."Account Type"::Customer;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Payment Type" := Rec."Payment Type"::Imprest;
        Rec."Account Type" := Rec."Account Type"::Customer;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        //CurrPage.ImprestLines.PAGE.ShowFields("Multi-Donor");
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange("Document No.", Rec."No.");
        if ApprovalEntry.Find('-') then
            ShowCommentFactbox := CurrPage.CommentsFactBox.Page.SetFilterFromApprovalEntry(ApprovalEntry);
    end;

    procedure GetCustMaxImprest(EmpNo: Code[20]) Slot: Integer
    begin
        // IF Customer.GET(EmpNo) THEN
        //  BEGIN
        //    Customer.TESTFIELD("Max Imprest Available");
        //    Slot:=Customer."Max Imprest Available";
        //  END;
        // EXIT(Slot);
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmts: Codeunit "Approvals Mgmt.";
    begin
        if (Rec.Status = Rec.Status::Released) or (Rec.Status = Rec.Status::Rejected) then
            OpenApprovalEntriesExist := true //ApprovalsMgmt.HasApprovalEntries(RecordId) //TRUE
        else
            OpenApprovalEntriesExist := ApprovalsMgmts.HasOpenApprovalEntries(Rec.RecordId); //FALSE
        //CanCancelApprovalForRecord := ApprovalsMgmts.CanCancelApprovalForRecord(Rec.RecordId);
        DocPosted := Rec.Posted;
        if PaymentMethod.Get(Rec."Pay Mode") then;
        if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then
            ChequePayment := true
        else
            ChequePayment := false;
        if (Rec.Status = Rec.Status::Released) then
            DocReleased := true
        else
            DocReleased := false;

        // IF "Travel Type"="Travel Type"::Foreign THEN
        //  CurVisible:=TRUE
        // ELSE
        //CurVisible := true;
    end;
}
