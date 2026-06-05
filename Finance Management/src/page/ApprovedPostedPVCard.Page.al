page 51062 "Approved/Posted PV Card"
{
    ApplicationArea = All;
    Caption = 'Approved/Posted PV Card';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = Payments;
    SourceTableView = where("Payment Type" = const("Payment Voucher"));
    UsageCategory = None;
    layout
    {
        area(Content)
        {
            group("Payment Voucher")
            {
                Caption = 'Payment Voucher';
                Editable = not DocPosted;
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field(Date; Rec.Date)
                {
                    Caption = 'Date';
                    Editable = not Rec.Posted;
                    ToolTip = 'Specifies the value of the Date field';
                }
                field("Time Inserted"; Rec."Time Inserted")
                {
                    Caption = 'Time';
                    ToolTip = 'Specifies the value of the Time field';
                }
                group(Control54)
                {
                    Editable = not Rec.Posted;
                    Caption = 'Dimensions';
                    field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                    {
                        Caption = 'Shortcut Dimension 1 Code';
                        Editable = true;
                        ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                    }
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
                        Caption = 'Shortcut Dimension 2 Code';
                        Editable = true;
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
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    Caption = 'Paying Bank Account';
                    Editable = not DocPosted;
                    ToolTip = 'Specifies the value of the Paying Bank Account field';
                }
                field("Posting Date"; Rec."Payment Release Date")
                {
                    Caption = 'Posting Date';
                    Editable = true;
                    ToolTip = 'Specifies the value of the Payment Release Date field';
                    ShowMandatory = true;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                    ToolTip = 'Specifies the value of the Responsibility Center field';
                }
                group(Control66)
                {
                    ShowCaption = false;
                    Visible = ChequePayment;

                    field("Cheque Type"; Rec."Cheque Type")
                    {
                        Caption = 'Cheque Type';
                        Editable = ChequePayment and not DocPosted;
                        ToolTip = 'Specifies the value of the Cheque Type field';
                    }
                    field("Cheque No"; Rec."Cheque No")
                    {
                        Caption = 'Cheque No';
                        Editable = ChequePayment and not DocPosted;
                        ToolTip = 'Specifies the value of the Cheque No field';
                    }
                    field("Cheque Date"; Rec."Cheque Date")
                    {
                        Caption = 'Cheque Date';
                        Editable = ChequePayment and not DocPosted;
                        ToolTip = 'Specifies the value of the Cheque Date field';
                    }
                }
                field(Payee; Rec.Payee)
                {
                    Caption = 'Payee';
                    Editable = not Rec.Posted;
                    ToolTip = 'Specifies the value of the Payee field';
                }
                group(Control64)
                {
                    ShowCaption = false;
                    Visible = ChequePayment;

                    field("Check Printed"; Rec."Check Printed")
                    {
                        Caption = 'Check Printed';
                        Editable = false;
                        ToolTip = 'Specifies the value of the Check Printed field';
                        Visible = ChequePayment;
                    }
                }
                field("On behalf of"; Rec."On behalf of")
                {
                    Caption = 'On behalf of';
                    Editable = not Rec.Posted;
                    ToolTip = 'Specifies the value of the On behalf of field';
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    Caption = 'Payment Narration';
                    Editable = not Rec.Posted;
                    ToolTip = 'Specifies the value of the Payment Narration field';
                }
                field("Payee PIN"; Rec."Payee PIN")
                {
                    Caption = 'Payee PIN';
                    ToolTip = 'Specifies the value of the Payee PIN field';
                    Visible = false;
                }
                field(Currency; Rec.Currency)
                {
                    Caption = 'Currency';
                    Editable = not DocPosted;
                    ToolTip = 'Specifies the value of the Currency field';
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
                field(Posted; Rec.Posted)
                {
                    Caption = 'Posted';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Posted field';
                }
                field("Posted By"; Rec."Posted By")
                {
                    Caption = 'Posted By';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Posted By field';
                }
                group("RTGS Details")
                {
                    Caption = 'RTGS Details';
                    Editable = not DocPosted;
                    Visible = RTGSPayment;

                    field("RTGS Date"; Rec."RTGS Date")
                    {
                        Caption = 'RTGS Date';
                        ToolTip = 'Specifies the value of the RTGS Date field';
                    }
                }
                group("EFT Details")
                {
                    Caption = 'EFT Details';
                    Editable = not DocPosted;
                    Visible = EFTPayment;

                    field("EFT Reference"; Rec."EFT Reference")
                    {
                        Caption = 'EFT Reference';
                        Editable = not DocPosted;
                        ToolTip = 'Specifies the value of the EFT Reference field';
                    }
                    field("EFT File Generated"; Rec."EFT File Generated")
                    {
                        Caption = 'EFT File Generated';
                        Editable = false;
                        ToolTip = 'Specifies the value of the EFT File Generated field';
                    }
                    field("EFT Date"; Rec."EFT Date")
                    {
                        Caption = 'EFT Date';
                        Editable = not DocPosted;
                        ToolTip = 'Specifies the value of the EFT Date field';
                    }
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
                group(Summary)
                {
                    Caption = 'Summary';
                    field("Total Amount"; Rec."Total Amount")
                    {
                        Caption = 'Total Amount';
                        ToolTip = 'Specifies the value of the Total Amount field';
                    }
                    field("Total Amount (LCY)"; Rec."Total Amount (LCY)")
                    {
                        Caption = 'Total Amount (LCY)';
                        ToolTip = 'Specifies the value of the Total Amount (LCY) field.';
                    }
                    field("Total VAT Amount"; Rec."Total VAT Amount")
                    {
                        Caption = 'Total VAT Amount';
                        ToolTip = 'Specifies the value of the Total VAT Amount field';
                    }
                    field("Total Witholding Tax Amount"; Rec."Total Witholding Tax Amount")
                    {
                        Caption = 'Total Witholding Tax Amount';
                        ToolTip = 'Specifies the value of the Total Witholding Tax Amount field';
                    }
                    field("Total Witholding VAT Tax"; Rec."Total Witholding VAT Tax")
                    {
                        Caption = 'Total Witholding VAT Tax';
                        ToolTip = 'Specifies the value of the Total Witholding VAT Tax field';
                    }
                    field("Total Retention Amount"; Rec."Total Retention Amount")
                    {
                        Caption = 'Total Retention Amount';
                        ToolTip = 'Specifies the value of the Total Retention Amount field';
                    }
                    field("Total Net Amount"; Rec."Total Net Amount")
                    {
                        Caption = 'Total Net Amount';
                        ToolTip = 'Specifies the value of the Total Net Amount field';
                    }
                    field("Total Payment Amount LCY"; Rec."Total Payment Amount LCY")
                    {
                        Caption = 'Total Net Amount (LCY)';
                        ToolTip = 'Specifies the value of the Total Payment Amount LCY field';
                    }
                }
            }
            part(Control26; "PV Subform")
            {
                Caption = 'PV Subform';
                Editable = not Rec.Posted;
                SubPageLink = No = field("No.");
            }
            part(Control35; "Apportionment Allocation Lines")
            {
                Caption = 'Apportionment Allocation Lines';
                SubPageLink = "Document No." = field("No.");
                Visible = Rec.Apportion;
            }
        }
        area(FactBoxes)
        {
            part("Payment Amounts"; "Payment Amounts Factbox")
            {
                Caption = 'Payment Amounts';
                SubPageLink = "No." = field("No.");
            }
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
            systempart(Control19; Links)
            {
                Caption = 'Attachments';
            }
            systempart(Control21; Notes)
            {
            }
            systempart(Control20; MyNotes)
            {
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            group(Action38)
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
                        Rec.TestField("Paying Bank Account");
                        /* Rec.TestField("Shortcut Dimension 1 Code");
                        Rec.TestField("Shortcut Dimension 2 Code"); */
                        Rec.TestField(Payee);
                        Rec.TestField("Payment Narration");
                        /*
                        if PayMethod.Get("Pay Mode") then
                          begin
                            if PayMethod."Bal. Account Type"=PayMethod."Bal. Account Type"::Cheque then
                              TestField("Cheque No");
                              TestField("Cheque Date");
                          end;
                          */
                        if Rec."Direct Expense" = true then
                            if Confirm('You have indicated that %1 is a direct expense hence will be committed. Continue?', false, Rec."No.") = true then begin
                                Committment.CheckPVCommittment(Rec);
                                Committment.PVCommittment(Rec, ErrorMsg);
                                if ErrorMsg <> '' then
                                    Error(ErrorMsg);
                            end else
                                exit;

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
                    Enabled = CanCancelApprovalForPayment and not DocPosted;
                    Image = Cancel;
                    ToolTip = 'Executes the Cancel Approval Re&quest action';

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to cancel the approval request?', false) = true then begin
                            if Rec."Direct Expense" = true then begin
                                Message('Please note this will uncommit previous committments regarding %1', Rec."No.");
                                Committment.ReversePVCommittment(Rec);
                            end;
                            ApprovalsMgmt.OnCancelPaymentsApprovalRequest(Rec);
                        end;
                    end;
                }
                separator(Action30)
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
                        PaymentRec.Reset();
                        PaymentRec.SetRange(PaymentRec."No.", Rec."No.");
                        if PaymentRec.FindFirst() then begin
                            PLines.Reset();
                            PLines.SetRange(No, PaymentRec."No.");
                            if PLines.FindFirst() then
                                if PLines."Account Type" <> PLines."Account Type"::Vendor then
                                    Report.Run(Report::"Payment Voucher", true, false, PaymentRec)
                                else
                                    Report.Run(Report::"Payment Voucher-Vendor", true, false, PaymentRec);
                        end;
                    end;
                }
                action(PaymentAdvice)
                {
                    Caption = 'Payment Advice';
                    Image = PrintAcknowledgement;
                    ToolTip = 'Executes the Payment Advice report';

                    trigger OnAction()
                    begin
                        PaymentRec.Reset();
                        PaymentRec.SetRange(PaymentRec."No.", Rec."No.");
                        if PaymentRec.FindFirst() then
                            Report.Run(Report::"Payment Advice", true, false, PaymentRec);
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
                        PaymentsPost.ConfirmPost(Rec);

                        PaymentsPost."Post Payment Voucher"(Rec, false);
                        CurrPage.Close();
                    end;
                }
                action(PreviewPosting)
                {
                    Caption = 'Preview Posting';
                    Image = PreviewChecks;
                    ToolTip = 'Executes the Preview Posting action';
                    Visible = not DocPosted;

                    trigger OnAction()
                    begin
                        PaymentsPost."Post Payment Voucher"(Rec, true);
                    end;
                }
                /*   action(GenerateEFT)
                  {
                      Caption = 'Generate EFT File';
                      Enabled = EFTpayment;
                      Image = ExportToExcel;
                      Promoted = true;
                      PromotedCategory = Category4;
                      Visible = not DocPosted;
                      ApplicationArea = All;
                      ToolTip = 'Executes the Generate EFT File action';

                      trigger OnAction()
                      begin
                          if Confirm('Are you sure you want to generate an EFT file for PV %1', false, Rec."No.") = true then begin
                              if PayMethod.Get(Rec."Pay Mode") then begin
                                  if PayMethod."Bal. Account Type" <> PayMethod."Bal. Account Type"::EFT then
                                      Error('Payment mode must be EFT');
                              end else
                                  Error('Pay mode %1 has not been set up', Rec."Pay Mode");

                              CashManagementSetup.Get();
                              CashManagementSetup.TestField("EFT Path");

                              PLines.Reset();
                              PLines.SetRange(No, Rec."No.");
                              if not PLines.FindFirst() then
                                  Error('Payment Lines are empty');

                              Rec.TestField("EFT File Generated", false);

                              PaymentRec.Reset();
                              PaymentRec.SetRange(PaymentRec."No.", Rec."No.");
                              if PaymentRec.FindFirst() then
                                  Report.RunModal(Report::"Generate EFT", false, false, PaymentRec);
                          end;
                      end;
                  } */

                action(GenerateEFT)
                {
                    Caption = 'Generate EFT File';
                    //Enabled = EFTpayment;
                    Enabled = true;
                    Image = ExportToExcel;
                    ToolTip = 'Executes the Generate EFT File action';
                    //Visible = not DocPosted;
                    Visible = true;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to generate an EFT file for PV %1', false, Rec."No.") = true then begin
                            if PayMethod.Get(Rec."Pay Mode") then begin
                                if PayMethod."Bal. Account Type" <> PayMethod."Bal. Account Type"::EFT then
                                    Error('Payment mode must be EFT');
                            end else
                                Error('Pay mode %1 has not been set up', Rec."Pay Mode");
                            PaymentsPost.GenerateEFT(Rec);
                        end;
                    end;
                }
                action(PrintCheck)
                {
                    Caption = 'Print Cheque';
                    Image = PrintCheck;
                    ToolTip = 'Executes the Print Cheque action';
                    Visible = not DocPosted;

                    trigger OnAction()
                    begin
                        if PayMethod.Get(Rec."Pay Mode") then
                            if PayMethod."Bal. Account Type" <> PayMethod."Bal. Account Type"::Cheque then
                                Error('Payment mode must be Cheque');

                        Rec.TestField("Check Printed", false);
                        Rec.TestField("Cheque No");
                        Rec.TestField("Cheque Date");

                        PaymentRec.Reset();
                        PaymentRec.SetRange("No.", Rec."No.");
                        if PaymentRec.FindFirst() then
                            Report.Run(Report::"PV Check", true, false, PaymentRec);
                    end;
                }
                action(ImportPayments)
                {
                    Caption = 'Import Bulk Payments';
                    Image = Import;
                    ToolTip = 'Executes the Import Bulk Payments action';
                    Visible = not DocPosted;

                    trigger OnAction()
                    begin
                        Clear(ImportPVLines);
                        ImportPVLines.GetHeaderNo(Rec);
                        ImportPVLines.Run();
                    end;
                }
                action(Reopen)
                {
                    Caption = 'Reopen Document';
                    Image = ReOpen;
                    ToolTip = 'Executes the Reopen Document action';
                    Visible = DocReleased;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to reopen?', false) then
                            PaymentsPost.ReopenDocument(Rec);
                    end;
                }
                action(SendPaymentAdviceViaMail)
                {
                    Caption = 'Send Payment Advice via Mail';
                    Enabled = not Rec."Payment Advice Sent";
                    Image = SendMail;
                    ToolTip = 'Executes the Send Payment Advice via Mail action';

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to send the payment advice via mail?', false) then
                            PaymentsPost.SendPaymentAdviceViaMail(Rec);
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
                actionref(PreviewPosting_Promoted; PreviewPosting)
                {
                }
                actionref(SendPaymentAdviceViaMail_Promoted; SendPaymentAdviceViaMail)
                {
                }
            }
            group(Category_Report)
            {
                Caption = 'Report', Comment = 'Generated from the PromotedActionCategories property index 2.';
                actionref("&Print_Promoted"; "&Print")
                {
                }
                actionref(PaymentAdvice_Promoted; PaymentAdvice)
                {
                }
            }
            group(Category_Category4)
            {
                Caption = 'Documents', Comment = 'Generated from the PromotedActionCategories property index 3.';

                actionref(GenerateEFT_Promoted; GenerateEFT)
                {
                }
                actionref(PrintCheck_Promoted; PrintCheck)
                {
                }
                actionref(ImportPayments_Promoted; ImportPayments)
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
            group(Category_Category6)
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
                actionref(Reopen_Promoted; Reopen)
                {
                }
            }
        }
    }

    var
        ApprovalEntry: Record "Approval Entry";
        PLines: Record "Payment Lines";
        PayMethod: Record "Payment Method";
        PaymentRec: Record Payments;
        UserSetup: Record "User Setup";
        ModifyHODApprovals: Report "Modify HOD Approvals";
        ApprovalsMgmt: Codeunit "Approval Mgt Finance Ext";
        Committment: Codeunit "Commitments Mgt Finance";
        PaymentsPost: Codeunit "Payments Management";
        ImportPVLines: XmlPort "Import PV Lines";
        CanCancelApprovalForPayment: Boolean;
        ChequePayment: Boolean;
        DocPosted: Boolean;
        DocReleased: Boolean;
        EFTPayment: Boolean;
        OpenApprovalEntriesExist: Boolean;
        RTGSPayment: Boolean;
        ShowCommentFactbox: Boolean;
        ErrorMsg: Text;

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
        Rec."Payment Type" := Rec."Payment Type"::"Payment Voucher";
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Payment Voucher";
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
        PaymentMethod: Record "Payment Method";
        ApprovalsMgmts: Codeunit "Approvals Mgmt.";
    begin
        if (Rec.Status = Rec.Status::Released) or (Rec.Status = Rec.Status::Rejected) then
            OpenApprovalEntriesExist := true //ApprovalsMgmt.HasApprovalEntries(RecordId)
        else
            OpenApprovalEntriesExist := ApprovalsMgmts.HasOpenApprovalEntries(Rec.RecordId);

        DocPosted := Rec.Posted;
        CanCancelApprovalForPayment := ApprovalsMgmts.CanCancelApprovalForRecord(Rec.RecordId);
        if PaymentMethod.Get(Rec."Pay Mode") then;
        if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then
            ChequePayment := true
        else
            ChequePayment := false;
        if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::EFT then
            EFTPayment := true
        else
            EFTPayment := false;
        if (Rec.Status = Rec.Status::Released) then
            DocReleased := true
        else
            DocReleased := false;

        if Rec.Posted then
            DocPosted := true
        else
            DocPosted := false;

        if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::RTGS then
            RTGSPayment := true
        else
            RTGSPayment := false;
    end;
}
