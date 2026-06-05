page 51012 "Petty Cash"
{
    ApplicationArea = All;
    Caption = 'Petty Cash';
    DeleteAllowed = false;
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
                    Editable = not OpenApprovalEntriesExist;
                    ToolTip = 'Specifies the value of the Date field';
                }
                field("Petty Cash Type"; Rec."Petty Cash Type")
                {
                    ToolTip = 'Specifies the value of the Petty Cash Type field.';
                    ShowMandatory = true;
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
                    Editable = not OpenApprovalEntriesExist;

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
                    Editable = not OpenApprovalEntriesExist;
                    ShowMandatory = true;
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
                    Editable = not OpenApprovalEntriesExist;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Payment Narration field';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field';
                }
                field(Currency; Rec.Currency)
                {
                    Caption = 'Currency';
                    ToolTip = 'Specifies the value of the Currency field';
                }
                field("Posted Date"; Rec."Posted Date")
                {
                    Caption = 'Posted Date';
                    Editable = false;
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
                field("Staff No."; Rec."Staff No.")
                {
                    Caption = 'Staff No.';
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Staff No. field';
                    Importance = Additional;
                }
                field(Cashier; Rec.Cashier)
                {
                    Caption = 'Cashier';
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Cashier field';
                    Importance = Additional;
                }
            }
            part(ImprestLines; "Petty Cash Lines")
            {
                Caption = 'Petty Cash Lines';
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
        // area(navigation)
        // {
        //     group("Payment Voucher")
        //     {
        //         Caption = 'Payment Voucher';
        //         Image = "Order";
        //         action("Co&mments")
        //         {
        //             Caption = 'Co&mments';
        //             Image = ViewComments;
        //             RunObject = Page "Comment Sheet";
        //         }
        //         action(Dimensions)
        //         {
        //             Caption = 'Dimensions';
        //             Image = Dimensions;
        //             ShortCutKey = 'Shift+Ctrl+D';
        //             trigger OnAction()
        //             begin
        //                 ShowDocDim;
        //                 CurrPage.SaveRecord;
        //             end;
        //         }
        //         action(Approvals)
        //         {
        //             Caption = 'Approvals';
        //             Image = Approval;
        //             Promoted = true;
        //             PromotedCategory = Category4;
        //             trigger OnAction()
        //             var
        //                 ApprovalEntries: Page "Approval Entries";
        //                 ApprovalEntry: Record "Approval Entry";
        //             begin
        //                 ApprovalEntry.Reset();
        //                 ApprovalEntry.SetCurrentKey("Document No.");
        //                 ApprovalEntry.SetRange("Table ID", Database::Payments);
        //                 ApprovalEntry.SetRange("Document No.", "No.");
        //                 ApprovalEntries.SetTableView(ApprovalEntry);
        //                 ApprovalEntries.LookupMode(true);
        //                 ApprovalEntries.RunModal();
        //             end;
        //         }
        //         action(Navigate)
        //         {
        //             Caption = '&Navigate';
        //             Image = Navigate;
        //             Promoted = true;
        //             PromotedCategory = Category5;
        //             PromotedIsBig = true;
        //             ToolTip = 'Find all entries and documents that exist for the document number and posting date on the posted purchase document.';
        //             Visible = DocPosted;
        //             trigger OnAction()
        //             begin
        //                 Navigate;
        //             end;
        //         }
        //     }
        // }
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
                        SelectPettyCashTypeErr: Label 'Please select a Petty Cash Type';
                    begin
                        GeneralLedgerSetup.Get();
                        CashManagementSetup.Get();
                        CashManagementSetup.TestField("Petty Cash Max");

                        Rec.CalcFields("Petty Cash Amount");
                        if Rec."Petty Cash Amount" <= 0 then
                            Error(Error001Err);

                        if Rec."Petty Cash Amount" > CashManagementSetup."Petty Cash Max" then
                            Error(Error002Err, GeneralLedgerSetup."LCY Code", CashManagementSetup."Petty Cash Max");

                        if Rec."Petty Cash Type" = Rec."Petty Cash Type"::" " then
                            Error(SelectPettyCashTypeErr);

                        Rec.TestField("Shortcut Dimension 1 Code");
                        Rec.TestField("Shortcut Dimension 2 Code");

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
        }
        area(Promoted)
        {
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
                Caption = 'Reports';
                actionref("&Print_Promoted"; "&Print")
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

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Petty Cash";
        Rec."Account Type" := Rec."Account Type"::Customer;
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

    /* local procedure ShowDimFields()
    begin
        if Rec."Multi-Donor" then
            ShowDim := false
        else
            ShowDim := true;
        CurrPage.Update();
    end; */
}
