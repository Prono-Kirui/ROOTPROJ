page 51116 "Property Expense Surrender"
{
    ApplicationArea = All;
    Caption = 'Property Expense Surrender';
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
                    Editable = false;
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
                field("Payment Narration"; Rec."Payment Narration")
                {
                    Caption = 'Payment Narration';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Payment Narration field';
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
            part(Control19; "Property Exp Surrender Lines")
            {
                Caption = 'Property Exp Surrender Lines';
                Editable = Rec.Status = Rec.Status::Open;
                SubPageLink = No = field("No."),
                              "Payment Type" = field("Payment Type");
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
            action("Clear Lines")
            {
                Caption = 'Clear Lines';
                Image = DeleteRow;
                ToolTip = 'Executes the Clear Lines action';
                trigger OnAction()
                begin
                    PaymentLines.Reset();
                    PaymentLines.SetRange(No, Rec."No.");
                    PaymentLines.DeleteAll();
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
                        ApprovalEntry.SetRange("Table ID", Database::Payments);
                        ApprovalEntry.SetRange("Document No.", Rec."No.");
                        ApprovalEntries.SetTableView(ApprovalEntry);
                        ApprovalEntries.LookupMode(true);
                        ApprovalEntries.RunModal();
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

                        Payments.SetRange("No.", Rec."No.");
                        Report.Run(Report::"Imprest Surrender", true, true, Payments);
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
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';

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
        PaymentLines: Record "Payment Lines";
        ImprestRec: Record Payments;
        Payments: Record Payments;
        UserSetup: Record "User Setup";
        ModifyHODApprovals: Report "Modify HOD Approvals";
        ApprovalsMgmt: Codeunit "Approval Mgt Finance Ext";
        CanCancelApprovalForPayment: Boolean;
        DocPosted: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowCommentFactbox: Boolean;

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
        Rec."Payment Type" := Rec."Payment Type"::"Property Expense Surrender";
        Rec."Account Type" := Rec."Account Type"::Customer;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Property Expense Surrender";
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
        ApprovalsMgmts: Codeunit "Approvals Mgmt.";
    begin
        if (Rec.Status = Rec.Status::Released) or (Rec.Status = Rec.Status::Rejected) then
            OpenApprovalEntriesExist := ApprovalsMgmts.HasApprovalEntries(Rec.RecordId)
        else
            OpenApprovalEntriesExist := ApprovalsMgmts.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForPayment := ApprovalsMgmts.CanCancelApprovalForRecord(Rec.RecordId);
        DocPosted := Rec.Posted;
    end;
}
