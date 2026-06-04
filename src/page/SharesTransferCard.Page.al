page 50400 "Shares Transfer Card"
{
    ApplicationArea = All;
    Caption = 'SharesCapital Trading Card';
    PageType = Card;
    SourceTable = "Shares Transfer Header";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Reference No"; Rec."Reference No")
                {
                    ToolTip = 'Specifies the value of the Reference No field.';
                    Editable = false;
                }
                field("Transfer Type"; Rec."Transfer Type")
                {
                    ToolTip = 'Specifies the value of the Transfer Type field.';

                    trigger OnValidate()
                    begin
                        FnUpdateControls();
                    end;
                }
                field("Member No"; Rec."Member No")
                {
                    ToolTip = 'Specifies the value of the Reference No field.';
                    Enabled = MembeEnabled;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Reference No field.';
                    Editable = false;
                    Enabled = false;
                }
                field("Shares Amount"; Rec."Shares Amount")
                {
                    ToolTip = 'Specifies the value of the Reference No field.';
                    Caption = 'Member Shares';
                    Editable = false;
                    Enabled = false;
                }
                field("Amount To Transfer"; Rec."Amount To Transfer")
                {
                    ToolTip = 'Specifies the value of the Reference No field.';
                }
                field("Transfer Description"; Rec."Transfer Description")
                {
                    ToolTip = 'Specifies the value of the Transfer Description field.';
                }
                field("Charges Amount"; Rec."Charges Amount")
                {
                    ToolTip = 'Specifies the value of the Charges Amount field.';
                    Caption = 'Member Charges';
                    Editable = false;
                    Enabled = false;
                }
                field("Posting Date Used"; Rec."Posting Date Used")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                    Caption = 'Posting Date';
                }
                field("Line Amount To Transfer"; Rec."Line Amount To Transfer")
                {
                    ToolTip = 'Specifies the value of the Line Amount To Transfer field.';
                    Caption = 'Scheduled Transfer Amount';
                    Editable = false;
                    Enabled = false;
                    Style = AttentionAccent;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Reference No field.';
                    Editable = false;
                    Enabled = false;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ToolTip = 'Specifies the value of the Captured By field.';
                    Editable = false;
                    Enabled = false;
                }
                field("Date Captured"; Rec."Date Captured")
                {
                    ToolTip = 'Specifies the value of the Date Captured field.';
                    Editable = false;
                    Enabled = false;
                }
            }
            part(Control1102760014; "Shares Transfer Schedule")
            {
                //Editable = TransfersEditable;
                SubPageLink = "Reference No" = field("Reference No");
                Caption = 'Shares Schedule';
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action("Refresh")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = RefreshLines;

                trigger OnAction()
                begin
                    CurrPage.Update();
                end;
            }
            action("Post")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Enabled = PostTransferEnabled;
                Image = PostedDeposit;

                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::Approved then
                        Error('Only Approved Requests can be Posted !');
                    if Template.Get(UserId) then begin
                        Jtemplate := Template."Sharescapital Template";
                        Jbatch := Template."Sharescapital Batch";
                    end;
                    if Confirm('PAre you sure to POST shares debit transfer from Member share balance ?', false) = false then begin
                        exit;
                    end
                    else begin
                        //.............................Post Shares Transfer
                        FnPOSTTransfer();
                        FnSendNotifications();
                        FnMarkAsPosted();

                        Message('Shares Transfer Posted Successfully');
                    end;
                    FnUpdateControls();
                    CurrPage.Close();
                end;
            }
            action("Cancel Approval")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = Cancel;
                Enabled = CancelApproval;

                trigger OnAction()
                begin
                    if Confirm('Cancel Approval Request ?', false) = false then begin
                        exit;
                    end
                    else begin
                        ApprovalsCodeUnit.CancelShareTransApplicationsRequestForApproval(rec."Reference No", Rec);
                        CurrPage.Close();
                    end;
                    FnUpdateControls();
                end;
            }
        }
    }
    local procedure FnUpdateControls()
    begin

        if Rec."Transfer Type" = Rec."Transfer Type"::" " then begin
            MembeEnabled := false;
        end
        else if Rec."Transfer Type" <> Rec."Transfer Type"::" " then begin
            MembeEnabled := true;
        end;
        if Rec.Status = Rec.Status::Pending then begin
            CancelApproval := true;
        end;
        if Rec.Status = Rec.Status::Approved then begin
            PostTransferEnabled := true;
        end
        else if Rec.Status <> Rec.Status::Approved then begin
            PostTransferEnabled := false;
        end
    end;

    local procedure FnPOSTTransfer()
    var
        SharesToBeTransferred: Record "Shares Transfer List";
        MicropointFactory: Codeunit "Micropoint Factory";
        LineNo: Integer;
        DRTransactionType: enum TransactionTypesEnum;
        CRTransactionType: enum TransactionTypesEnum;
        AccountType: Enum "Gen. Journal Account Type";
        GenJournalLine: record "Gen. Journal Line";
        RunBalance: Decimal;
        Gensac: Record "Sacco General Set-Up";

    begin
        Gensac.Get();
        RunBalance := 0;
        GenJournalLine.Reset();
        GenJournalLine.SetRange(GenJournalLine."Journal Template Name", Jtemplate);
        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", Jbatch);
        GenJournalLine.DeleteAll();
        SharesToBeTransferred.Reset();
        SharesToBeTransferred.SetRange(SharesToBeTransferred."Reference No", Rec."Reference No");
        if SharesToBeTransferred.Find('-') then begin
            if Rec."Transfer Type" = Rec."Transfer Type"::"Deposit Contribution" then
                DRTransactionType := DRTransactionType::"Deposit Contribution"
            else if Rec."Transfer Type" = Rec."Transfer Type"::"Share Capital" then DRTransactionType := DRTransactionType::"Share Capital";

            //DR Person Transferring
            LineNo := LineNo + 1000;
            MicropointFactory.FnCreateGnlJournalLine(Jtemplate, Jbatch, 'SHARETRANS', LineNo, DRTransactionType, AccountType::Customer, Rec."Member No", Rec."Posting Date Used", Rec."Amount To Transfer", GetDimensionToUse(Rec."Member No"), 'SHARETRANSFER', Rec."Transfer Description", '', GenJournalLine."Source Type"::" ");



            repeat //CR Person Receiving

                if SharesToBeTransferred."Transaction Type" = SharesToBeTransferred."Transaction Type"::"Deposit Contribution" then
                    CRTransactionType := CRTransactionType::"Deposit Contribution"
                else if SharesToBeTransferred."Transaction Type" = SharesToBeTransferred."Transaction Type"::"Share Capital" then CRTransactionType := CRTransactionType::"Share Capital";
                RunBalance := RunBalance + Rec."Amount To Transfer";

                // charge to Member transferring
                if Rec."Charges Amount" > 0 then begin
                    LineNo := LineNo + 1000;
                    MicropointFactory.FnCreateGnlJournalLine(Jtemplate, Jbatch, 'SHARETRANS', LineNo, DRTransactionType, AccountType::"G/L Account", Gensac."Share Capital Transfer Fee Acc"
                    , Rec."Posting Date Used", (Rec."Charges Amount" * -1), GetDimensionToUse(Rec."Member No"), 'SHARETRANSFER', 'Share Transfer Charges', '', GenJournalLine."Source Type"::" ");
                    RunBalance := RunBalance - Rec."Charges Amount";
                end;

                LineNo := LineNo + 1000;
                MicropointFactory.FnCreateGnlJournalLine(Jtemplate, Jbatch, 'SHARETRANS', LineNo, CRTransactionType, AccountType::Customer, SharesToBeTransferred."Member No", Rec."Posting Date Used", (RunBalance * -1), GetDimensionToUse(SharesToBeTransferred."Member No"), 'SHARETRANSFER', Rec."Transfer Description", '', GenJournalLine."Source Type"::" ");

            until SharesToBeTransferred.Next = 0;
            MicropointFactory.FnPostGnlJournalLine(Jtemplate, Jbatch);
        end;
    end;

    local procedure GetDimensionToUse(MemberNo: Code[50]): Code[40]
    var
        Customer: Record Customer;
    begin
        Customer.SetRange(Customer."No.", MemberNo);
        if Customer.find('-') then begin
            exit(Customer."Global Dimension 1 Code");
        end;
    end;

    local procedure FnSendNotifications()
    var
        SharesToBeTransferred: Record "Shares Transfer List";
        MicropointFactory: Codeunit "Micropoint Factory";
        LineNo: Integer;
        DRTransactionType: enum TransactionTypesEnum;
        CRTransactionType: enum TransactionTypesEnum;
        AccountType: Enum "Gen. Journal Account Type";
        GenJournalLine: record "Gen. Journal Line";
        msg: Text;
    begin
        SharesToBeTransferred.Reset();
        SharesToBeTransferred.SetRange(SharesToBeTransferred."Reference No", Rec."Reference No");
        if SharesToBeTransferred.Find('-') then begin
            msg := 'Dear ' + Format(Rec."Member Name") + ', Your Share Transfer of Ksh. ' + Format(Rec."Amount To Transfer") + ' was successful. Thankyou for banking with us. SACCO';
            MicropointFactory.FnSendSMS('MOBILTRANS', msg, Rec."Member No", MicropointFactory.FnGetMemberMobileNumber(MicropointFactory.FnGetFosaAccount(Rec."Member No")));
            repeat
                msg := 'Dear ' + Format(SharesToBeTransferred."Member Name") + ',a share transfer of Ksh. ' + Format(SharesToBeTransferred.Amount) + ' has been made to your account by ' + Format(Rec."Member Name") + '. Incase of any queries contact  SACCO';
                MicropointFactory.FnSendSMS('MOBILTRANS', msg, SharesToBeTransferred."Member No", MicropointFactory.FnGetMemberMobileNumber(MicropointFactory.FnGetFosaAccount(SharesToBeTransferred."Member No")));
            until SharesToBeTransferred.Next = 0;
        end;
    end;

    local procedure FnMarkAsPosted()
    var
        SharesToBeTransferred: Record "Shares Transfer List";
        MicropointFactory: Codeunit "Micropoint Factory";
        LineNo: Integer;
        DRTransactionType: enum TransactionTypesEnum;
        CRTransactionType: enum TransactionTypesEnum;
        AccountType: Enum "Gen. Journal Account Type";
        GenJournalLine: record "Gen. Journal Line";
        msg: Text;
    begin
        SharesToBeTransferred.Reset();
        SharesToBeTransferred.SetRange(SharesToBeTransferred."Reference No", Rec."Reference No");
        if SharesToBeTransferred.Find('-') then begin
            repeat
                SharesToBeTransferred.Posted := true;
                SharesToBeTransferred."Date Posted" := Today;
                SharesToBeTransferred.Modify(true);
            until SharesToBeTransferred.Next = 0;
        end;
        Rec."Posted By" := UserId;
        Rec."Date Posted" := Today;
        Rec.Status := Rec.Status::Closed;
        Rec.Modify(true);
    end;

    trigger OnAfterGetCurrRecord()
    begin
        FnUpdateControls();
    end;

    trigger OnOpenPage()
    begin
        FnUpdateControls();
    end;

    var
        MembeEnabled: Boolean;
        PostTransferEnabled: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        EnableSendApproval: Boolean;
        CancelApproval: Boolean;
        ApprovalsCodeUnit: Codeunit "Micropoint ApprovalsCodeUnit";
        MicropointFactory: Codeunit "Micropoint Factory";
        Gensacc: Record "Sacco General Set-Up";
        // FundsUSer: Record "Funds User Setup";
        Jtemplate: Code[10];
        Jbatch: Code[10];
        Template: Record "BOSA&FOSA User Template";
}
