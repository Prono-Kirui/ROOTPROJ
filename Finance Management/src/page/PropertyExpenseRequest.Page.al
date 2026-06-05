page 51112 "Property Expense Request"
{
    ApplicationArea = All;
    Caption = 'Property Expense Request';
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
                Editable = PageEditable;
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
                field("Time Inserted"; Rec."Time Inserted")
                {
                    Caption = 'Time';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Time field';
                }
                field("Apply on behalf"; Rec."Apply on behalf")
                {
                    Caption = 'Apply on behalf';
                    ToolTip = 'Specifies the value of the Apply on behalf field';
                }
                group(Control76)
                {
                    Enabled = false;
                    ShowCaption = false;
                    field("Staff No."; Rec."Staff No.")
                    {
                        Caption = 'Staff No.';
                        Enabled = false;
                        ToolTip = 'Specifies the value of the Staff No. field';
                    }
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
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Responsibility Center field';
                }
                group(Control54)
                {
                    Caption = 'Dimensions';
                    Editable = not OpenApprovalEntriesExist;
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
                group(Control65)
                {
                    ShowCaption = false;
                    Visible = false;
                    field("Pay Mode"; Rec."Pay Mode")
                    {
                        Caption = 'Pay Mode';
                        Editable = OpenApprovalEntriesExist and not DocPosted;
                        ToolTip = 'Specifies the value of the Pay Mode field';
                        Visible = DocReleased;
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
                        Visible = DocReleased;
                    }
                    field("Cheque Date"; Rec."Cheque Date")
                    {
                        Caption = 'Cheque Date';
                        Editable = OpenApprovalEntriesExist and ChequePayment and not DocPosted;
                        ToolTip = 'Specifies the value of the Cheque Date field';
                        Visible = DocReleased;
                    }
                    field("Paying Bank Account"; Rec."Paying Bank Account")
                    {
                        Caption = 'Paying Bank Account';
                        Enabled = OpenApprovalEntriesExist and not DocPosted;
                        ToolTip = 'Specifies the value of the Paying Bank Account field';
                        Visible = DocReleased;
                    }
                }
                group(Control64)
                {
                    ShowCaption = false;
                    field(Currency; Rec.Currency)
                    {
                        Caption = 'Currency';
                        Editable = not OpenApprovalEntriesExist;
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
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Purpose field';
                }
                field("User Id"; Rec."User Id")
                {
                    Caption = 'User Id';
                    Enabled = false;
                    ToolTip = 'Specifies the value of the User Id field';
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
                group("EFT Details")
                {
                    Caption = 'EFT Details';
                    Editable = not DocPosted;
                    Visible = EFTPayment;
                    field("EFT Reference"; Rec."EFT Reference")
                    {
                        Caption = 'EFT Reference';
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
                        ToolTip = 'Specifies the value of the EFT Date field';
                    }
                }
            }
            part(PropertyExpenseLines; "Property Expense Request Lines")
            {
                Caption = 'Property Expense Lines';
                Editable = not OpenApprovalEntriesExist and PageEditable;
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
            //     action(Navigate)
            //     {
            //         Caption = '&Navigate';
            //         Image = Navigate;
            //         Promoted = true;
            //         PromotedCategory = Category5;
            //         PromotedIsBig = true;
            //         ToolTip = 'Find all entries and documents that exist for the document number and posting date on the posted purchase document.';
            //         Visible = DocPosted;

            //         trigger OnAction()
            //         begin
            //             Navigate;
            //         end;
            //     }
            // }
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
                        AmountCantBeZeroErr: Label 'Imprest Amount can not be less than or equal to 0';
                    begin
                        Rec.CalcFields("Imprest Amount");
                        if Rec."Imprest Amount" <= 0 then
                            Error(AmountCantBeZeroErr);

                        Rec.TestField("Payment Narration");

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
                    Enabled = CanCancelApprovalForRecord;
                    Image = Cancel;
                    ToolTip = 'Executes the Cancel Approval Re&quest action';

                    trigger OnAction()
                    var
                        UncommitTxt: Label 'Are you sure you want to cancel the approval request. This will uncommit already committed entries on Document No. %1', Comment = '%1 = Document No.';
                    begin
                        if Confirm(UncommitTxt, false, Rec."No.") = true then begin
                            //Committment.UncommitImprest(Rec);
                            Committment.CancelPaymentsCommitments(Rec);
                            ApprovalsMgmt.OnCancelPaymentsApprovalRequest(Rec);
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

                        Payments.Reset();
                        Payments.SetRange("No.", Rec."No.");
                        Report.Run(Report::Imprest, true, false, Payments);
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

                        Payments.Reset();
                        Payments.SetRange("No.", Rec."No.");
                        Report.Run(Report::"Login Management", true, true, Payments);
                    end;
                }
            }
        }
        area(Promoted)
        {
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
                actionref(Approvals_Promoted; Approvals)
                {
                }
            }
        }
    }

    var
        ApprovalEntry: Record "Approval Entry";
        PaymentMethod: Record "Payment Method";
        Payments: Record Payments;
        UserSetup: Record "User Setup";
        ModifyHODApprovals: Report "Modify HOD Approvals";
        ApprovalsMgmt: Codeunit "Approval Mgt Finance Ext";
        Committment: Codeunit "Commitments Mgt Finance";
        CanCancelApprovalForRecord: Boolean;
        ChequePayment: Boolean;
        DocPosted: Boolean;
        DocReleased: Boolean;
        EFTPayment: Boolean;
        OpenApprovalEntriesExist: Boolean;
        PageEditable: Boolean;
        ShowCommentFactbox: Boolean;
        ShowWorkflowStatus: Boolean;
        ErrorMsg: Text;

    trigger OnInit()
    begin
        PageEditable := true;
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
        Rec."Payment Type" := Rec."Payment Type"::"Property Expense";
        Rec."Account Type" := Rec."Account Type"::Customer;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Property Expense";
        Rec."Account Type" := Rec."Account Type"::Customer;
    end;

    trigger OnAfterGetCurrRecord()
    begin
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
            OpenApprovalEntriesExist := ApprovalsMgmts.HasApprovalEntries(Rec.RecordId) //TRUE
        else
            OpenApprovalEntriesExist := ApprovalsMgmts.HasOpenApprovalEntries(Rec.RecordId); //FALSE
        CanCancelApprovalForRecord := ApprovalsMgmts.CanCancelApprovalForRecord(Rec.RecordId);
        DocPosted := Rec.Posted;
        if PaymentMethod.Get(Rec."Pay Mode") then;
        if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then
            ChequePayment := true
        else
            ChequePayment := false;
        if (Rec.Status = Rec.Status::Released) then begin
            DocReleased := true;
            PageEditable := false
        end

        else
            if (Rec.Status = Rec.Status::"Pending Approval") then
                PageEditable := false
            else
                DocReleased := false;
        if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::EFT then
            EFTPayment := true
        else
            EFTPayment := false;
    end;
}