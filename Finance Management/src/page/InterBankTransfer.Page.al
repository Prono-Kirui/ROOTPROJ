page 51045 "InterBank Transfer"
{
    ApplicationArea = All;
    Caption = 'InterBank Transfer';
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
                field("Transfer Type"; Rec."Transfer Type")
                {
                    Caption = 'Transfer Type';
                    ToolTip = 'Specifies the value of the Transfer Type field.';
                }
                group(Control49)
                {
                    Caption = 'Dimensions';
                    Editable = not OpenApprovalEntriesExist;
                    Visible = ShowDim;

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
                field("Payment Narration"; Rec."Payment Narration")
                {
                    Caption = 'Payment Narration';
                    Editable = not OpenApprovalEntriesExist;
                    ToolTip = 'Specifies the value of the Payment Narration field';
                }
                field("Payment Release Date"; Rec."Payment Release Date")
                {
                    Caption = 'Posting Date';
                    ToolTip = 'Specifies the value of the Posting Date field';
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field';
                }
                group("Source Bank Details")
                {
                    Caption = 'Source Bank Details';
                    Editable = not OpenApprovalEntriesExist;

                    field("Source Bank"; Rec."Source Bank")
                    {
                        Caption = 'Source Bank';
                        ToolTip = 'Specifies the value of the Source Bank field';
                        trigger OnValidate()
                        begin
                            GetSourceBankName();
                            CurrPage.Update();
                        end;
                    }
                    field(SourceBankName; SourceBankName)
                    {
                        Caption = 'Account Name';
                        Editable = false;
                        ToolTip = 'Specifies the value of the Account Name field';
                    }
                    field("Source Currency"; Rec."Source Currency")
                    {
                        Caption = 'Source Bank Currency';
                        ToolTip = 'Specifies the value of the Source Bank Currency field';
                    }
                    field("Source Bank Amount"; Rec."Source Bank Amount")
                    {
                        Caption = 'Source Bank Amount';
                        ToolTip = 'Specifies the value of the Source Bank Amount field';
                    }
                    field("Exchange Rate"; Rec."Exchange Rate")
                    {
                        Caption = 'Exchange Rate';
                        ToolTip = 'Specifies the value of the Exchange Rate field.';
                    }
                    field("Source Amount LCY"; Rec."Source Amount LCY")
                    {
                        Caption = 'Source Amount LCY';
                        ToolTip = 'Specifies the value of the Source Amount LCY field';
                    }
                }
                group("Payment Details")
                {
                    Caption = 'Receiving Bank Details';
                    Editable = not OpenApprovalEntriesExist;
                    Visible = Rec."Transfer Type" = Rec."Transfer Type"::"Single Bank";
                    grid("Receiving Bank Details")
                    {
                        Caption = 'Receiving Bank Details';
                        GridLayout = Rows;

                        group(Control44)
                        {
                            ShowCaption = false;

                            field("Account No."; Rec."Account No.")
                            {
                                Caption = 'Receiving Bank Account';
                                Editable = not OpenApprovalEntriesExist;
                                ToolTip = 'Specifies the value of the Receiving Bank Account field';
                            }
                            field("Account Name"; Rec."Account Name")
                            {
                                Caption = 'Account Name';
                                Editable = false;
                                ToolTip = 'Account Name';
                            }
                            field("Receiving Bank Amount"; Rec."Receiving Bank Amount")
                            {
                                Caption = 'Receiving Bank Amount';
                                ToolTip = 'Specifies the value of the Receiving Bank Amount field';
                            }
                            field(Currency; Rec.Currency)
                            {
                                Caption = 'Receiving Bank Currency';
                                Editable = not OpenApprovalEntriesExist;
                                ToolTip = 'Specifies the value of the Receiving Bank Currency field';
                            }
                            field("Receiving Amount LCY"; Rec."Receiving Amount LCY")
                            {
                                Caption = 'Receiving Amount LCY';
                                ToolTip = 'Specifies the value of the Receiving Amount LCY field';
                            }
                        }
                    }
                }
                group(Totals)
                {
                    Caption = 'Totals';
                    Visible = Rec."Transfer Type" = Rec."Transfer Type"::"Multiple Banks";

                    field("Petty Cash Amount"; Rec."Petty Cash Amount")
                    {
                        Caption = 'Total Receiving Bank Amount';
                        ToolTip = 'Specifies the value of the Total Receiving Bank Amount field';
                    }
                    field("Petty Cash Amount (LCY)"; Rec."Petty Cash Amount (LCY)")
                    {
                        Caption = 'Total Receiving Bank Amount LCY';
                        ToolTip = 'Specifies the value of the Total Receiving Bank Amount LCY field';
                    }
                }
                field("Created By"; Rec."Created By")
                {
                    Caption = 'Created By';
                    ToolTip = 'Specifies the value of the Created By field';
                }
                group(History)
                {
                    Caption = 'History';
                    Editable = false;
                    Visible = Rec.Posted;
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
                    field("Posted Date"; Rec."Posted Date")
                    {
                        Caption = 'Posted Date';
                        Editable = false;
                        ToolTip = 'Specifies the value of the Posted Date field';
                    }
                }
            }
            part("Interbank Transfer Lines"; "Interbank Lines")
            {
                Caption = 'Receiving Bank Details';
                Editable = not OpenApprovalEntriesExist;
                SubPageLink = No = field("No.");
                UpdatePropagation = Both;
                Visible = Rec."Transfer Type" = Rec."Transfer Type"::"Multiple Banks";
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
            systempart(Attachments; Links)
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
                        GeneralLedgerSetup.Get();
                        CashManagementSetup.Get();

                        Rec.TestField("Source Bank Amount");
                        Rec.TestField("Source Bank");
                        Rec.TestField("Payment Narration");
                        Rec.TestField(Date);

                        if Rec."Transfer Type" = Rec."Transfer Type"::"Multiple Banks" then begin
                            Rec.CalcFields("Petty Cash Amount (LCY)");
                            if Rec."Petty Cash Amount (LCY)" <> Rec."Source Amount LCY" then
                                Error('Please make sure both Receiving and Source Amounts are the same');
                        end;

                        if ApprovalsMgmt.CheckPaymentsApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendPaymentsForApproval(Rec);

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
                        if Rec."Transfer Type" = Rec."Transfer Type"::"Multiple Banks" then begin
                            Rec.SetRange("No.", Rec."No.");
                            Report.Run(Report::"InterBank Transfer-Multiple", true, false, Rec);
                        end else begin
                            Rec.SetRange("No.", Rec."No.");
                            Report.Run(Report::"InterBank Transfer", true, false, Rec);
                        end;
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
                    Enabled = Rec.Status = Rec.Status::Released;
                    Image = PostOrder;
                    ShortcutKey = 'F9';
                    ToolTip = 'Executes the P&ost action';
                    Visible = not DocPosted;

                    trigger OnAction()
                    begin
                        if Rec."Transfer Type" = Rec."Transfer Type"::"Multiple Banks" then
                            PaymentsPost.PostInterBankMultiple(Rec, false)
                        else
                            PaymentsPost.PostInterBank(Rec, false);

                        CurrPage.Close();
                    end;
                }
                action(PreviewPost)
                {
                    Caption = 'Preview Posting';
                    Enabled = Rec.Status = Rec.Status::Released;
                    Image = PreviewChecks;
                    ToolTip = 'Executes the Preview Posting action';
                    Visible = not DocPosted;

                    trigger OnAction()
                    begin
                        if Rec."Transfer Type" = Rec."Transfer Type"::"Multiple Banks" then
                            PaymentsPost.PostInterBankMultiple(Rec, true)
                        else
                            PaymentsPost.PostInterBank(Rec, true);

                        CurrPage.Close();
                    end;
                }
                action(Archive)
                {
                    Caption = 'Archive';
                    Image = Archive;
                    ToolTip = 'Executes the Archive action';
                    Visible = false;
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
                actionref(PreviewPost_Promoted; PreviewPost)
                {
                }
                actionref(Archive_Promoted; Archive)
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
                actionref(Reopen_Promoted; Reopen)
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
        Bank: Record "Bank Account";
        CashManagementSetup: Record "Cash Management Setups";
        GeneralLedgerSetup: Record "General Ledger Setup";
        ApprovalsMgmt: Codeunit "Approval Mgt Finance Ext";
        PaymentsPost: Codeunit "Payments Management";
        CanCancelApprovalForPayment: Boolean;
        DocPosted: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowCommentFactbox: Boolean;
        ShowDim: Boolean;
        SourceBankName: Text;

    trigger OnOpenPage()
    begin
        SetControlAppearance();
        //CurrPage..PAGE.ShowFields("Multi-Donor");
        //ShowDimFields();
        ShowDim := true;
        //DocStatus:=FormatStatus(Status);
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();

        //CurrPage. .PAGE.ShowFields("Multi-Donor");
        //ShowDimFields();
        //DocStatus:=FormatStatus(Status);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Bank Transfer";
        Rec."Account Type" := Rec."Account Type"::"Bank Account";
    end;

    trigger OnAfterGetCurrRecord()
    begin
        //CurrPage.ImprestLines.PAGE.ShowFields("Multi-Donor");

        ApprovalEntry.Reset();
        ApprovalEntry.SetRange("Document No.", Rec."No.");
        if ApprovalEntry.Find('-') then
            ShowCommentFactbox := CurrPage.CommentsFactBox.Page.SetFilterFromApprovalEntry(ApprovalEntry);
    end;

    local procedure GetSourceBankName()
    begin
        if Rec."Source Bank" <> '' then
            if Bank.Get(Rec."Source Bank") then
                SourceBankName := Bank.Name;
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
        GetSourceBankName();
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
