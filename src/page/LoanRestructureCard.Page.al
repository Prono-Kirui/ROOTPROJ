#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50804 "Loan Restructure Card"
{
    PageType = Card;
    SourceTable = "Loan Restructure";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                    Editable = MemberNoEditable;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Loan to Restructure"; Rec."Loan to Restructure")
                {
                    ApplicationArea = Basic;
                    Editable = LoantoRestructureEditable;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Name"; Rec."Loan Product Name")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Loan"; Rec."Outstanding Loan")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Issued Date"; Rec."Loan Issued Date")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Interest Rate"; Rec."Loan Interest Rate")
                {
                    ApplicationArea = Basic;
                }
                field("Initial Instalment"; Rec."Initial Instalment")
                {
                    ApplicationArea = Basic;
                    Caption = 'Initial Loan Period';
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Repayment Start Date"; Rec."Repayment Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Date of Completion"; Rec."Expected Date of Completion")
                {
                    ApplicationArea = Basic;
                    Caption = 'Expected Date of Completion';
                    Editable = false;
                }
                field("Initial Monthly Repayment"; Rec."Initial Monthly Repayment")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Current Payoff Amount"; Rec."Current Payoff Amount")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Remaining Period(Months)"; Rec."Remaining Period(Months)")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = true;
                }






            }
            group(Other)
            {
                Caption = 'Restructure Details';
                field("New Loan Period"; Rec."New Loan Period")
                {
                    ApplicationArea = Basic;
                    Editable = NewPeriodEditable;
                }
                field("New Monthly Repayment"; Rec."New Monthly Repayment")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
                }

                field("Loan Rescheduled Date"; Rec."Loan Rescheduled Date")
                {
                    ApplicationArea = Basic;
                }
                field("New Repayment Start Date"; Rec."New Repayment Start Date")
                { }
                field("New Expected Date of Compl."; Rec."New Expected Date of Compl.")
                {
                    ApplicationArea = Basic;
                    Caption = 'New Expected Date of Completion';
                }
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = Basic;
            }
            field("Restructured By"; Rec."Restructured By")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = Basic;
            }
            field("Date Restructure"; Rec."Date Restructure")
            {
                Visible = false;
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(EnableEffectRetructure)
            {
                ApplicationArea = Basic;
                Caption = 'Effect Restructure';
                Enabled = EnableEffectRetructure;
                Image = Customer;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = false;

                trigger OnAction()
                begin
                    if Rec."Close Schedule" = true then
                        Error('This Restructure request has already been processed');
                    if Rec.Status <> Rec.Status::Approved then Error('kindly send to Approval First ...');
                    if Confirm('Effect Restructure?') then begin
                        FnDisburseToLSAAccount;
                    end;
                    Message('Loan Restructured Succesfully');
                    Rec."Date Restructure" := WorkDate;
                    Rec."Restructured By" := UserId;

                    CurrPage.Close;

                end;
            }
            action(EnableEffectReschedule)
            {
                ApplicationArea = Basic;
                Caption = 'Effect Reschedule';
                Enabled = EnableEffectRetructure;
                Image = Customer;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    //mjk
                    if Rec."Close Schedule" = true then
                        Error('This Restructure request has already been processed');
                    if Rec.Status <> Rec.Status::Approved then Error('kindly send to Approval First ...');

                    if Confirm('Effect Reschedule?') then begin
                        FnRescheduledLoan();
                    end;
                    Message('Loan Rescheduled Succesfully');
                    Rec."Date Restructure" := WorkDate;
                    Rec."Restructured By" := UserId;

                    CurrPage.Close;

                end;
            }
            action("Update  Schedule")
            {
                ApplicationArea = Basic;
                Caption = 'view Schedule';
                Image = ViewDetails;
                Promoted = true;
                PromotedCategory = "Report";
                ShortCutKey = 'Ctrl+F7';
                //Visible = false;

                trigger OnAction()
                begin


                    LoanApp.Reset();
                    LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan to Restructure");
                    if LoanApp.Find('-') then
                        Report.Run(50409, true, false, LoanApp);

                end;
            }

            action("Send Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Send Approval Request';
                Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    Text001: label 'This request is already pending approval';
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    //if Rec.Status <> Rec.Status::Open then Error('kindly send to Approval First ...');
                    if Confirm('Are you sure you want to Send this approval request', false) = true then
                        MicropointApprovalsCodeUnit.SendLoanRestructureForApproval(Rec."Document No", Rec);
                    CurrPage.close();

                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Cancel Approval Request';
                Enabled = CanCancelApprovalForRecord;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    Approvalmgt: Codeunit "Approvals Mgmt.";
                begin
                    if Confirm('Are you sure you want to cancel this approval request', false) = true then
                        MicropointApprovalsCodeUnit.CancelLoanRestructureForApproval(Rec."Document No", Rec);
                    Rec.Modify;

                end;
            }
            action(Approval)
            {
                ApplicationArea = Basic;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                begin
                    DocumentType := Documenttype::LoanRestructure;
                    ApprovalEntries.Setfilters(Database::"Loan Restructure", DocumentType, Rec."Document No");
                    ApprovalEntries.Run;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        EnableEffectRetructure := false;
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Rec.Status::Approved)) then
            EnableEffectRetructure := true;
        FnRecordRestriction;
    end;

    trigger OnOpenPage()
    begin

        EnableEffectRetructure := false;
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Rec.Status::Approved)) then
            EnableEffectRetructure := true;

        FnRecordRestriction;
    end;

    var
        LoanRestructure: Record "Loan Restructure";
        fngeneraterepaymentschedule: Codeunit "Generate Loan Repayment Sched";
        EnableEffectRetructure: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        EnabledApprovalWorkflowsExist: Boolean;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange,HouseRegistration,LoanPayOff,FixedDeposit,RTGS,DemandNotice,OverDraft,LoanRestructure;
        MemberNoEditable: Boolean;
        LoantoRestructureEditable: Boolean;
        NewPeriodEditable: Boolean;
        SFactory: Codeunit "Micropoint Factory";
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        DOCUMENT_NO: Code[40];
        ObjAccount: Record Vendor;
        VarLSAAccount: Code[30];
        ObjLoanType: Record "Loan Products Setup";
        ObjLoans: Record "Loans Register";
        ObjLoansII: Record "Loans Register";
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        VarNewLoanNo: Code[30];
        ObjAccounts: Record Vendor;
        AvailableBal: Decimal;
        ObjAccTypes: Record "Account Types-Saving Products";
        MicropointApprovalsCodeUnit: Codeunit "Micropoint ApprovalsCodeUnit";
        LoanApp: Record "Loans Register";
        RSchedule: Record "Loan Repayment Schedule";

    local procedure FnRecordRestriction()
    begin
        if (Rec.Status = Rec.Status::Open) then begin
            MemberNoEditable := true;
            LoantoRestructureEditable := true;
            NewPeriodEditable := true;
        end;

        if (Rec.Status = Rec.Status::"Pending Approval") or (Rec.Status = Rec.Status::Approved) then begin
            MemberNoEditable := false;
            LoantoRestructureEditable := false;
            NewPeriodEditable := false;
        end;

    end;


    local procedure FnRescheduledLoan()
    var
        ObjLoans: Record "Loans Register";
        ObjProductCharge: Record "Loan Product Charges";
        VarWhichDay: Integer;
        RSchedule: Record "Loan Restructure";
    begin


        IF CONFIRM('Are you sure you want to reschedule this loan', FALSE) = TRUE THEN BEGIN

            ObjLoans.Reset();
            ObjLoans.SetRange("Loan  No.", Rec."Loan to Restructure");
            if ObjLoans.Find('-') then begin
                ObjLoans."Loan Rescheduled Date" := WorkDate;

                ObjLoans."Repayment Start Date" := Rec."New Repayment Start Date";
                ObjLoans."New Repayment Start Date" := Rec."New Repayment Start Date";
                ObjLoans."Expected Date of Completion" := Rec."New Expected Date of Compl.";
                ObjLoans."Loan Reschedule" := true;
                ObjLoans."Loan Rescheduled By" := UserId;
                ObjLoans."Loan Rescheduled Date" := WorkDate;
                ObjLoans.Installments := Rec."New Loan Period";
                ObjLoans.Modify();
            end;


            //*********************************************************************************************************
            Rec."Restructured By" := USERID;
            Rec."Date Restructure" := WORKDATE;
            Rec."Close Schedule" := TRUE;
            Rec.MODIFY;
            fngeneraterepaymentschedule.FnGenerateLoanRepaymentReSchedule(Rec."Loan to Restructure");
            // SFactory.FnGenerateLoanRepaymentReSchedule(Rec."Loan to Restructure");
            // SFactory.FnGenerateLoanRepaymentSchedule(Rec."Loan to Restructure");
            Commit;

            LoanApp.Reset;
            LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan to Restructure");
            if LoanApp.Find('-') then
                Report.Run(50409, true, false, LoanApp);
        end;
    end;

    local procedure FnDisburseToLSAAccount()
    begin


        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'LOANS';
        DOCUMENT_NO := Rec."Document No";

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;



        VarNewLoanNo := FnRunGetNewLoanNo(Rec."Loan to Restructure");
        FnRunCreateNewLoan;


        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."BOSA Account No", Rec."Member No");
        ObjAccounts.SetRange(ObjAccounts."Account Type", '507');
        if ObjAccounts.FindSet then begin
            //------------------------------------1. DEBIT MEMBER LOAN A/C---------------------------------------------------------------------------------------------
            LineNo := LineNo + 10000;
            //     SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Loan,
            //     GenJournalLine."account type"::Customer, Rec."Member No", WorkDate, Rec."Current Payoff Amount", '', VarNewLoanNo,
            //    Rec."Loan Product Name" + ' Restructure -' + Rec."Loan to Restructure", VarNewLoanNo);
            //     //--------------------------------(Debit Member Loan Account)---------------------------------------------

            //     //------------------------------------2. CREDIT MEMBER LSA A/C---------------------------------------------------------------------------------------------
            //     LineNo := LineNo + 10000;
            //     SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            //     GenJournalLine."account type"::Customer, ObjAccounts."No.", WorkDate, Rec."Current Payoff Amount" * -1, 'BOSA', Rec."Loan to Restructure",
            //     'Loan Restructure Loan Account - ' + Rec."Loan to Restructure", Rec."Loan to Restructure",);
            //----------------------------------(Credit Member lsa Account)------------------------------------------------

            //CU posting
            // GenJournalLine.Reset;
            // GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
            // GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
            // if GenJournalLine.Find('-') then
            //     Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco21", GenJournalLine);
        end;

        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."BOSA Account No", Rec."Member No");
        ObjAccounts.SetRange(ObjAccounts."Account Type", '507');
        if ObjAccounts.FindSet then begin
            ObjAccounts.CalcFields(ObjAccounts.Balance, ObjAccounts."Uncleared Cheques");
            AvailableBal := (ObjAccounts.Balance - ObjAccounts."Uncleared Cheques");

            ObjAccTypes.Reset;
            ObjAccTypes.SetRange(ObjAccTypes.Code, ObjAccounts."Account Type");
            if ObjAccTypes.Find('-') then
                AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
            VarLSAAccount := ObjAccount."No.";

            // SFactory.FnCreateLoanRecoveryJournals(Rec."Loan to Restructure", BATCH_TEMPLATE, BATCH_NAME, Rec."Document No", Rec."Member No", WorkDate, Rec."Loan to Restructure", ObjAccounts."No.", Rec."Member Name", AvailableBal);

            //CU posting
            // GenJournalLine.Reset;
            // GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
            // GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
            // if GenJournalLine.Find('-') then
            //     Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco21", GenJournalLine);
        end;



        FnRunIncreamentLoansetUpNo(Rec."Loan to Restructure");


        /// SFactory.FnGenerateLoanRepaymentSchedule(VarNewLoanNo);
    end;

    local procedure FnRunCreateNewLoan()
    begin
        if ObjLoanType.Get(Rec."Loan Product Type") then begin
            if ObjLoans.Get(Rec."Loan to Restructure") then begin
                ObjLoansII.Init;
                ObjLoansII."Loan  No." := FnRunGetNewLoanNo(Rec."Loan to Restructure");
                ObjLoansII."Client Code" := ObjLoans."Client Code";
                ObjLoansII."Client Name" := ObjLoans."Client Name";
                ObjLoansII."Loan Product Type" := ObjLoans."Loan Product Type";
                ObjLoansII."Loan Product Type Name" := ObjLoans."Loan Product Type Name";
                ObjLoansII."Application Date" := ObjLoans."Application Date";
                ObjLoansII."Requested Amount" := Rec."Current Payoff Amount";
                ObjLoansII."Approved Amount" := Rec."Current Payoff Amount";
                ObjLoansII.Interest := Rec."Loan Interest Rate";
                ObjLoansII."Repayment Method" := Rec."Repayment Method";
                ObjLoansII.Installments := Rec."New Loan Period";
                ObjLoansII."Issued Date" := WorkDate;
                ObjLoansII."Loan Disbursement Date" := WorkDate;
                ObjLoansII.Posted := true;
                ObjLoansII."Reschedule by" := UserId;
                ObjLoansII.Rescheduled := true;
                ObjLoansII.Insert;
            end;
        end;

    end;

    local procedure FnRunGetNewLoanNo(VarExistingLoan: Code[30]) VarNewLoanNo: Code[30]
    begin


    end;

    local procedure FnRunIncreamentLoansetUpNo(VarExistingLoan: Code[30])
    begin


    end;
}

