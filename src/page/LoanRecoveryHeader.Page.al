#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
//jose
Page 50045 "Loan Recovery Header"
{
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Loan Recovery Header";


    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                    Editable = MemberNoEditable;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Current Shares"; Rec."Current Shares")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Deposits';
                    Editable = false;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Total Outstanding Loans"; Rec."Total Outstanding Loans")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Transaction Date';
                    Editable = true;
                }
                field("Recovery Type"; Rec."Recovery Type")
                {
                    ApplicationArea = Basic;
                    Editable = RecoveryTypeEditable;

                    trigger OnValidate()
                    begin
                        ShareCapitalSellVisible := false;
                        if Rec."Recovery Type" = Rec."recovery type"::"Recover Loan From Sell of Share Capital" then begin
                            ShareCapitalSellVisible := true;
                        end;

                        ApportionmentVisible := false;
                        if Rec."Recovery Type" = Rec."recovery type"::"Recover From Guarantors Deposits" then begin
                            ApportionmentVisible := true;
                        end;
                    end;
                }
                field("Add Interest"; Rec."Add Interest")
                {
                    ApplicationArea = Basic;
                }
                field("Loan to Attach"; Rec."Loan to Attach")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan to Recover';
                    Editable = LoantoAttachEditable;
                }
                field("Loan Settlement Account"; Rec."Loan Settlement Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Loan Settlement Account Bal"; Rec."Loan Settlement Account Bal")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Total Guarantor Allocation"; Rec."Total Guarantor Allocation")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                group(Apportionment)
                {
                    Visible = ApportionmentVisible;
                    field("Guarantor Allocation Type"; Rec."Guarantor Allocation Type")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Liability Allocation Type';
                        Importance = Promoted;
                        Style = Strong;
                        StyleExpr = true;
                    }
                    field("Loan Current PayOff Amount"; Rec."Loan Current PayOff Amount")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                        Importance = Promoted;
                        Style = Attention;
                        StyleExpr = true;
                    }

                }
                field("Loan Distributed to Guarantors"; Rec."Loan Distributed to Guarantors")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = true;

                }

                field("Recovery Difference"; Rec."Recovery Difference")
                {
                    ApplicationArea = Basic;
                    Caption = 'Recovery Difference';
                    Editable = false;
                    Enabled = false;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Activity Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = Global1Editable;

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date Created';
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Loans Generated"; Rec."Loans Generated")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Repayment Start Date"; Rec."Repayment Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Share Capital Sold"; Rec."Share Capital Sold")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
            }
            part(Control1000000009; "Loan Recovery Details")
            {
                Editable = GuarantorLoansDetailsEdit;
                Enabled = true;
                SubPageLink = "Document No" = field("Document No"),
                              "Member No" = field("Member No");
                Visible = true;
            }
            group("Share Capital Sell")
            {
                Caption = 'Share Capital Sell';
                Visible = ShareCapitalSellVisible;
                field("Share Capital Balance"; Rec."Share Capital Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Share Capital Transfer Fee"; Rec."Share Capital Transfer Fee")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Share Capital Seller FOSA Acc"; Rec."Share Capital Seller FOSA Acc")
                {
                    ApplicationArea = Basic;
                    Caption = 'Seller FOSA Account';
                }
            }
            part("Share Capital Sell Line"; "Share Capital Sell")
            {
                SubPageLink = "Document No" = field("Document No"),
                              "Selling Member No" = field("Member No"),
                              "Selling Member Name" = field("Member Name");
                Visible = ShareCapitalSellVisible;
            }
        }
    }

    actions
    {
        area(creation)
        {
            group("Function")
            {
                Caption = 'Function';
                action("Post Transaction")
                {
                    ApplicationArea = Basic;
                    // Enabled = EnableCreateMember;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        LineNo: Integer;
                        TotalLoanRecovered: Decimal;
                    begin

                        // if ((Rec.Status = Rec.Status::Open) or (Rec.Status = Rec.Status::Pending) or (Rec.Posted = true)) then
                        //     Error('You cannot post a document which is not approved');
                        if Template.Get(UserId) then begin
                            BATCH_TEMPLATE := Template."Loan Recovery Template";
                            BATCH_NAME := Template."Loan Recovery Batch";
                        end;
                        DOCUMENT_NO := Rec."Document No";
                        EXTERNAL_DOC_NO := Rec."Loan to Attach";
                        Datefilter := '..' + Format(Rec."Loan Disbursement Date");

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        GenJournalLine.DeleteAll;

                        if Rec."Recovery Type" = Rec."recovery type"::"Attach Defaulted Loans to Guarantors" then begin
                            LineNo := 0;

                            FnGenerateDefaulterLoans();
                        end;

                        if Rec."Recovery Type" = Rec."recovery type"::"Recover From Loanee Deposits" then begin
                            LineNo := 0;
                            FnRunRecoverFromLoaneesDeposits(Rec."Loan Distributed to Guarantors");
                            //mjk
                        end;


                        if Rec."Recovery Type" = Rec."recovery type"::"Recover From Guarantors Deposits" then begin
                            // FnRunPostAmountAllocatedtoLSA(Rec."Document No", Rec."Loan Disbursement Date", Rec."Loan to Attach");

                            FnRunRecoverALLFromGuarantorsDeposits(Rec."Document No", Rec."Loan to Attach", Rec."Member No", Rec."Loan Disbursement Date");
                            //========================Post Guarantor Recovery to LSA
                            // FnRunCreateRecoveryLedgerEntry(Rec."Member No", Rec."Member Name", Rec."Loan Disbursement Date");//============================Create Recovery Ledger Entries
                            //mj
                        end;

                        if Rec."Recovery Type" = Rec."recovery type"::"Recover Loan From Sell of Share Capital" then begin
                            FnRunShareCapitalSell;
                            Rec.Validate("Loan Settlement Account");
                            SFactory.FnCreateLoanRecoveryJournals(Rec."Loan to Attach", BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, Rec."Member No",
                            Rec."Loan Disbursement Date", Rec."Document No", Rec."Loan Settlement Account", Rec."Member Name", Rec."Loan Settlement Account Bal");
                        end;

                        // // // //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        if GenJournalLine.Find('-') then begin
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco21", GenJournalLine);
                        end;

                        // Update header Posted status
                        Rec.Posted := true;
                        Rec."Posting Date" := Today;
                        Rec."Posted By" := UserId;
                        Rec.Modify;

                        Commit;  // Commit changes before closing page

                        Message('Loan Recovery Posted Successfully');
                        CurrPage.Close;
                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        text001: label 'This batch is already pending approval';
                        ApprovalsCodeUnit: Codeunit "Micropoint ApprovalsCodeUnit";
                    begin
                        if (Rec.Status = Rec.Status::Approved) or (Rec.Status = Rec.Status::Pending) then
                            Error(text001);
                        Rec.TestField("Global Dimension 1 Code");
                        //  Rec.TestField("Global Dimension 2 Code");
                        if ObjLoanGuarantorsIV."Document No" <> '' then begin
                            ObjLoanGuarantorsIV.Reset;
                            ObjLoanGuarantorsIV.SetRange(ObjLoanGuarantorsIV."Document No", Rec."Document No");
                            if ObjLoanGuarantorsIV.FindSet then begin

                                Error('Cannot send for approval when there are uploaded guarantor recoveries. Please upload all guarantor recoveries first.');
                            end;
                        end;

                        if Confirm('Send Approval Request ?', false) = false then begin
                            exit;
                        end
                        else begin
                            approvalsCodeUnit.SendLoanRecoveryForApproval(Rec."Document No", Rec);
                            CurrPage.Close();
                        end;


                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel A&pproval Request';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        text001: label 'This batch is already pending approval';
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                        ApprovalsCodeUnit: Codeunit "Micropoint ApprovalsCodeUnit";
                    begin
                        if (Rec.Status = Rec.Status::Open) or (Rec.Status = Rec.Status::Approved) then
                            Error(text001);

                        if Confirm('Cancel Approval Request ?', false) = false then begin
                            exit;
                        end
                        else begin
                            approvalsCodeUnit.CancelLoanRecoveryForApproval(Rec."Document No", Rec);
                            CurrPage.Close();
                        end;

                    end;
                }
                action(Approvals)
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
                        DocumentType := Documenttype::GuarantorRecovery;

                        ApprovalEntries.Setfilters(Database::"Loan Recovery Header", DocumentType, Rec."Document No");
                        ApprovalEntries.Run;
                    end;
                }
                action("Load Guarantors")
                {
                    ApplicationArea = Basic;
                    Image = CalculateLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        LoanDetails: Record "Loan Member Loans";
                        GCount: Integer;

                        NoSeriesMgt: Codeunit NoSeriesManagement;
                    begin
                        //mjk
                        if ((Rec.Status = Rec.Status::Pending) or (Rec.Posted = true)) then
                            Error('You cannot load guarantors for a document that is pending or posted.');

                        // Validate loan type exists before proceeding
                        if not ObjLoanType.Get('DEFAULTER') then
                            Error('DEFAULTER loan type must be configured before loading guarantors.');

                        // Validation for guarantor-based recovery types
                        if (Rec."Recovery Type" = Rec."Recovery Type"::"Recover From Guarantors Deposits") or
                           (Rec."Recovery Type" = Rec."Recovery Type"::"Attach Defaulted Loans to Guarantors") then begin
                            if Rec."Current Shares" >= (Rec."Loan Current PayOff Amount" + Rec."Outstanding Interest") then begin
                                Error('Member deposits (Ksh. %1) are sufficient to clear the loan (Ksh. %2). ' +
                                      'No guarantor recovery needed. Please use "Recover From Loanee Deposits" instead.',
                                      Rec."Current Shares", Rec."Loan Current PayOff Amount" + Rec."Outstanding Interest");
                            end;
                        end;

                        case Rec."Recovery Type" of
                            Rec."Recovery Type"::"Recover From Loanee Deposits":
                                FnLoadselfGuarantorsForRecovery();
                            Rec."Recovery Type"::"Recover From Guarantors Deposits":
                                FnLoadGuarantorsForRecovery();
                            Rec."Recovery Type"::"Attach Defaulted Loans to Guarantors":
                                FnLoadGuarantorsAndCreateDefaulterLoans();
                        end;


                    end;
                }
                action("Apportion Liability")
                {
                    ApplicationArea = Basic;
                    Image = CalculateLines;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        NewLoan: Record "Loans Register";
                        TotalLiability: Decimal;
                        AmountFromMember: Decimal;
                    begin
                        // Validation: Check recovery type
                        if Rec."Recovery Type" = Rec."Recovery Type"::"Recover From Loanee Deposits" then begin
                            Error('Apportion Liability is not applicable for "Recover From Loanee Deposits" recovery type. ' +
                                  'This recovery type automatically calculates the amount to recover from the loanee''s deposits.');
                        end;

                        //================================================================================Load Guarantors Check
                        ObjLoanGuarantors.Reset;
                        ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Document No", Rec."Document No");
                        if ObjLoanGuarantors.Find('-') = false then begin
                            Error('Ensure you Load Loan Guarantors');
                        end;

                        // Calculate total liability
                        if Rec."Add Interest" = true then
                            TotalLiability := Rec."Loan Current PayOff Amount" + Rec."Outstanding Interest"
                        else
                            TotalLiability := Rec."Loan Current PayOff Amount";

                        // Amount from member = minimum of their deposits or total liability
                        if Rec."Current Shares" < TotalLiability then
                            AmountFromMember := Rec."Current Shares"
                        else
                            AmountFromMember := TotalLiability;

                        // Amount for guarantors = remaining liability (or zero if member covers it all)
                        VarTotalLoanLiabilities := TotalLiability - AmountFromMember;
                        if VarTotalLoanLiabilities < 0 then
                            VarTotalLoanLiabilities := 0;

                        // Validation for guarantor recovery types
                        if VarTotalLoanLiabilities = 0 then begin
                            Error('Member deposits (Ksh. %1) are sufficient to clear the loan (Ksh. %2). ' +
                                  'No guarantor recovery needed. Please use "Recover From Loanee Deposits" instead.',
                                  Rec."Current Shares", TotalLiability);
                        end;

                        Message('Deposits Deducted from Loanee is Ksh. %1,.', AmountFromMember);
                        Message('Remaining Amount to be apportioned to other Guarantors  is Ksh. %1', VarTotalLoanLiabilities);
                        if Rec."Guarantor Allocation Type" = Rec."guarantor allocation type"::"Equally Liable" then begin
                            // Count only non-self guarantors
                            VarGuarantorCount := 0;
                            ObjLoanGuarantors.Reset;
                            ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Document No", Rec."Document No");
                            ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Self Guarantor", false);
                            if ObjLoanGuarantors.FindSet then
                                VarGuarantorCount := ObjLoanGuarantors.Count;

                            // Apportion equally among non-self guarantors
                            ObjLoanGuarantors.Reset;
                            ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Document No", Rec."Document No");
                            if ObjLoanGuarantors.FindSet then begin
                                repeat
                                    if ObjLoanGuarantors."Self Guarantor" = true then
                                        ObjLoanGuarantors."Guarantor Amount Apportioned" := ObjLoanGuarantors."Current Member Deposits"  // Store self guarantor deposits for display
                                    else
                                        ObjLoanGuarantors."Guarantor Amount Apportioned" := VarTotalLoanLiabilities / VarGuarantorCount;
                                    ObjLoanGuarantors.Appotioned := true;
                                    ObjLoanGuarantors.Modify;
                                until ObjLoanGuarantors.Next = 0;
                            end;
                        end;
                        //=======================================================================================Propotional Liability
                        if Rec."Guarantor Allocation Type" = Rec."guarantor allocation type"::"Proportionately Liable" then begin
                            ObjLoanGuarantors.Reset;
                            ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Document No", Rec."Document No");
                            ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Self Guarantor", false);
                            if ObjLoanGuarantors.FindSet then begin
                                ObjLoanGuarantors.CalcSums(ObjLoanGuarantors."Amont Guaranteed");
                                VarTotalGuaranteedAmount := ObjLoanGuarantors."Amont Guaranteed";
                            end;
                            // Message('Total Guaranteed Amount is Ksh. %1', VarTotalGuaranteedAmount);
                            ObjLoanGuarantors.Reset;
                            ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Document No", Rec."Document No");
                            if ObjLoanGuarantors.FindSet then begin
                                repeat
                                    if ObjLoanGuarantors."Self Guarantor" = true then
                                        ObjLoanGuarantors."Guarantor Amount Apportioned" := ObjLoanGuarantors."Current Member Deposits"  // Store self guarantor deposits for display
                                    else
                                        ObjLoanGuarantors."Guarantor Amount Apportioned" := (ObjLoanGuarantors."Amont Guaranteed" / VarTotalGuaranteedAmount) * VarTotalLoanLiabilities;
                                    ObjLoanGuarantors.Appotioned := true;
                                    ObjLoanGuarantors.Modify;
                                until ObjLoanGuarantors.Next = 0;
                            end;
                            // Error('Loan %1 already has a defaulter loan attached', ObjLoanGuarantors."Loan No.");
                        end;

                        //if Rec."Loan No".get
                        ObjLoanGuarantors.Reset;
                        ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Document No", Rec."Document No");
                        if ObjLoanGuarantors.FindSet then begin
                            repeat
                                NewLoan.Reset();
                                NewLoan.setrange(NewLoan."Client Code", ObjLoanGuarantors."Guarantor Number");
                                // NewLoan.setrange(NewLoan."Loan to Attach", ObjLoanGuarantors."Loan No.");
                                if NewLoan.Find('-') then
                                    repeat
                                        NewLoan."Approved Amount" := Round(ObjLoanGuarantors."Guarantor Amount Apportioned", 1, '=');  //ObjLoanGuarantors."Guarantor Amount Apportioned";
                                        NewLoan."Requested Amount" := NewLoan."Approved Amount";
                                        NewLoan.Modify;
                                    //Message('Loan %1 apportioned Ksh.%2 to guarantor %3', NewLoan."Loan  No.", NewLoan."Approved Amount", NewLoan."Client Code");
                                    until NewLoan.Next = 0;
                            until ObjLoanGuarantors.Next = 0;
                        end;
                        //=======================================================================================Propotional Liability
                    end;
                }
                action("Clear Guarantors")
                {
                    ApplicationArea = Basic;
                    Image = Delete;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        ObjLoanGuarantors.Reset;
                        ObjLoanGuarantors.SetRange("Document No", Rec."Document No");
                        if ObjLoanGuarantors.FindSet then begin
                            ObjLoanGuarantors.DeleteAll;
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls();
        UpdateControls();
        EnableCreateMember := false;
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Rec.Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
        if (Rec.Status = Rec.Status::Approved) then
            EnableCreateMember := true;

        ShareCapitalSellVisible := false;
        if Rec."Recovery Type" = Rec."recovery type"::"Recover Loan From Sell of Share Capital" then begin
            ShareCapitalSellVisible := true;
        end;


        ApportionmentVisible := false;
        if Rec."Recovery Type" = Rec."recovery type"::"Recover From Guarantors Deposits" then begin
            ApportionmentVisible := true;
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Created By" := UserId;
        Rec."Application Date" := Today;
        Rec."Loan Disbursement Date" := Today;
    end;

    trigger OnOpenPage()
    begin
        //UpdateControls();
        ShareCapitalSellVisible := false;
        if Rec."Recovery Type" = Rec."recovery type"::"Recover Loan From Sell of Share Capital" then begin
            ShareCapitalSellVisible := true;
        end;

        ApportionmentVisible := false;
        if Rec."Recovery Type" = Rec."recovery type"::"Recover From Guarantors Deposits" then begin
            ApportionmentVisible := true;
        end;
    end;

    var
        PayOffDetails: Record "Loans PayOff Details";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        LoanType: Record "Loan Products Setup";
        LoansRec: Record "Loans Register";
        TotalRecovered: Decimal;
        TotalInsuarance: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        GLoanDetails: Record "Loan Member Loans";
        TotalOustanding: Decimal;
        ClosingDepositBalance: Decimal;
        RemainingAmount: Decimal;
        AMOUNTTOBERECOVERED: Decimal;
        PrincipInt: Decimal;
        TotalLoansOut: Decimal;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        PDate: Date;
        Interest: Decimal;
        TextDateFormula2: Text[30];
        TextDateFormula1: Text[30];
        DateFormula2: DateFormula;
        DateFormula1: DateFormula;
        Lbal: Decimal;
        GenLedgerSetup: Record "General Ledger Setup";
        Hesabu: Integer;
        "Loan&int": Decimal;
        TotDed: Decimal;
        Available: Decimal;
        Distributed: Decimal;
        WINDOW: Dialog;
        PostingCode: Codeunit "Gen. Jnl.-Post Line";
        SHARES: Decimal;
        TOTALLOANS: Decimal;
        LineN: Integer;
        instlnclr: Decimal;
        appotbal: Decimal;
        PRODATA: Decimal;
        LOANAMOUNT2: Decimal;
        TOTALLOANSB: Decimal;
        NETSHARES: Decimal;
        Tinst: Decimal;
        Finst: Decimal;
        Floans: Decimal;
        GrAmount: Decimal;
        TGrAmount: Decimal;
        FGrAmount: Decimal;
        LOANBAL: Decimal;
        Serie: Integer;
        DLN: Code[10];
        "LN Doc": Code[20];
        INTBAL: Decimal;
        COMM: Decimal;
        loanTypes: Record "Loan Products Setup";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication;
        MemberNoEditable: Boolean;
        RecoveryTypeEditable: Boolean;
        Global1Editable: Boolean;
        Global2Editable: Boolean;
        LoantoAttachEditable: Boolean;
        GuarantorLoansDetailsEdit: Boolean;
        TotalRecoverable: Decimal;
        LoanGuarantors: Record "Loans Guarantee Details";
        AmounttoRecover: Decimal;
        BaltoRecover: Decimal;
        InstRecoveredAmount: Decimal;
        X: Decimal;
        ObjGuarantorML: Record "Loan Member Loans";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        RunBal: Decimal;
        TotalSharesUsed: Decimal;
        i: Integer;
        PeriodDueDate: Date;
        ScheduleRep: Record "Loan Repayment Schedule";
        LoanGuar: Record "Loans Guarantee Details";
        RunningDate: Date;
        G: Integer;
        IssuedDate: Date;
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;
        GracePeiodEndDate: Date;
        InstalmentEnddate: Date;
        GracePerodDays: Integer;
        InstalmentDays: Integer;
        NoOfGracePeriod: Integer;
        NewSchedule: Record "Loan Repayment Schedule";
        RSchedule: Record "Loan Repayment Schedule";
        GP: Text[30];
        ScheduleCode: Code[20];
        PreviewShedule: Record "Loan Repayment Schedule";
        PeriodInterval: Code[10];
        CustomerRecord: Record customer;
        Gnljnline: Record "Gen. Journal Line";
        Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
        CumInterest: Decimal;
        NewPrincipal: Decimal;
        PeriodPrRepayment: Decimal;
        GenBatch: Record "Gen. Journal Batch";
        GnljnlineCopy: Record "Gen. Journal Line";
        NewLNApplicNo: Code[10];
        Cust: Record customer;
        LoanApp: Record "Loans Register";
        TestAmt: Decimal;
        CustRec: Record customer;
        CustPostingGroup: Record "Customer Posting Group";
        GenSetUp: Record "Sacco General Set-Up";
        PCharges: Record "Loan Product Charges";
        TCharges: Decimal;
        LAppCharges: Record "Loan Applicaton Charges";
        LoansR: Record "Loans Register";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        RepayInterval: DateFormula;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[40];
        GrPrinciple: Integer;
        GrInterest: Integer;
        QPrinciple: Decimal;
        QCounter: Integer;
        InPeriod: DateFormula;
        InitialInstal: Integer;
        InitialGraceInt: Integer;
        FOSAComm: Decimal;
        BOSAComm: Decimal;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        LoanTopUp: Record "Loan Offset Details";
        Vend: Record Vendor;
        BOSAInt: Decimal;
        TopUpComm: Decimal;
        TotalTopupComm: Decimal;
        CustE: Record customer;
        DocN: Text[50];
        DocM: Text[100];
        DNar: Text[250];
        DocF: Text[50];
        MailBody: Text[250];
        ccEmail: Text[250];
        LoanG: Record "Loans Guarantee Details";
        SpecialComm: Decimal;
        FOSAName: Text[150];
        IDNo: Code[50];
        MovementTracker: Record "Movement Tracker";
        DiscountingAmount: Decimal;
        StatusPermissions: Record "Status Change Permision";
        BridgedLoans: Record "Loan Special Clearance";
        SMSMessage: Record "SMS Messages";
        InstallNo2: Integer;
        currency: Record "Currency Exchange Rate";
        CURRENCYFACTOR: Decimal;
        LoanApps: Record "Loans Register";
        LoanDisbAmount: Decimal;
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        Disbursement: Record "Loan Disburesment-Batching";
        SchDate: Date;
        DisbDate: Date;
        WhichDay: Integer;
        LBatches: Record "Loans Register";
        SalDetails: Record "Loan Appraisal Salary Details";
        LGuarantors: Record "Loans Guarantee Details";
        CurrpageEditable: Boolean;
        LoanStatusEditable: Boolean;
        MNoEditable: Boolean;
        ApplcDateEditable: Boolean;
        LProdTypeEditable: Boolean;
        InstallmentEditable: Boolean;
        AppliedAmountEditable: Boolean;
        ApprovedAmountEditable: Boolean;
        RepayMethodEditable: Boolean;
        RepaymentEditable: Boolean;
        BatchNoEditable: Boolean;
        RepayFrequencyEditable: Boolean;
        ModeofDisburesmentEdit: Boolean;
        DisbursementDateEditable: Boolean;
        AccountNoEditable: Boolean;
        LNBalance: Decimal;
        ApprovalEntries: Record "Approval Entry";
        RejectionRemarkEditable: Boolean;
        ApprovalEntry: Record "Approval Entry";
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Account Opening","Member Closure",Loan;
        GrossPay: Decimal;
        Nettakehome: Decimal;
        TotalDeductions: Decimal;
        UtilizableAmount: Decimal;
        NetUtilizable: Decimal;
        Deductions: Decimal;
        Benov: Decimal;
        TAXABLEPAY: Record "PAYE Brackets Credit";
        PAYE: Decimal;
        PAYESUM: Decimal;
        BAND1: Decimal;
        BAND2: Decimal;
        BAND3: Decimal;
        BAND4: Decimal;
        BAND5: Decimal;
        Taxrelief: Decimal;
        OTrelief: Decimal;
        Chargeable: Decimal;
        PartPay: Record "Loan Partial Disburesments";
        PartPayTotal: Decimal;
        AmountPayable: Decimal;
        RepaySched: Record "Loan Repayment Schedule";
        LoanReferee1NameEditable: Boolean;
        LoanReferee2NameEditable: Boolean;
        LoanReferee1MobileEditable: Boolean;
        LoanReferee2MobileEditable: Boolean;
        LoanReferee1AddressEditable: Boolean;
        LoanReferee2AddressEditable: Boolean;
        LoanReferee1PhyAddressEditable: Boolean;
        LoanReferee2PhyAddressEditable: Boolean;
        LoanReferee1RelationEditable: Boolean;
        LoanReferee2RelationEditable: Boolean;
        LoanPurposeEditable: Boolean;
        WitnessEditable: Boolean;
        compinfo: Record "Company Information";
        LoanRepa: Record "Loan Repayment Schedule";
        ObjGuarantorRec: Record "Loan Recovery Header";
        Text0001: label 'Please consider recovering from the Loanee Shares Before Attaching to Guarantors';
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        EXTERNAL_DOC_NO: Code[40];
        SFactory: Codeunit "Micropoint Factory";
        DLoan: Code[20];
        Datefilter: Text;
        LoanDetails: Record "Loan Member Loans";
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        EnableCreateMember: Boolean;
        RecoveryTransType: Option Normal,"Guarantor Recoverd","Guarantor Paid";
        ObjLoansRec: Record "Loans Register";
        ObjNoSeries: Record "No. Series Line";
        ObjSaccoNoSeries: Record "Sacco No. Series";
        LastNoUsed: Code[20];
        ObjLoanType: Record "Loan Products Setup";
        VarAmounttoDeduct: Decimal;
        ObjCust: Record customer;
        ObjLoanGuarantors: Record "Loan Member Loans";
        ObjLoanGuarantorsII: Record "Loan Member Loans";
        ObjLoanGuarantorsIII: Record "Loan Member Loans";
        ObjLoanGuarantorsIV: Record "Loan Member Loans";
        ObjLoanGuarantorsV: Record "Loan Member Loans";
        ObjLoanGuar: Record "Loan Member Loans";
        VarTotalGuarantorAmount: Decimal;
        VarGuarantorCount: Integer;
        VarTotalApprotionLess: Decimal;
        VarTotalApprotionGreater: Decimal;
        VarTotalApprotionLessCount: Integer;
        ShareCapitalSellVisible: Boolean;
        ApportionmentVisible: Boolean;
        VarTotalLoanLiabilities: Decimal;
        VarLoanInsuranceBalAccount: Code[20];
        VarTotalApprotionGreaterI: Decimal;
        VarTotalApprotionLessCountI: Integer;
        VarRemainingLiability: Decimal;
        VarCountRemainingGuarantors: Integer;
        VarTotalGuaranteedAmount: Decimal;
        Jtemplate: Code[10];
        Jbatch: Code[10];
        Template: Record "BOSA&FOSA User Template";


    procedure UpdateControls()
    begin

        if Rec.Status = Rec.Status::Open then begin
            MemberNoEditable := true;
            RecoveryTypeEditable := true;
            LoantoAttachEditable := true;
            Global1Editable := true;
            Global2Editable := true;
            GuarantorLoansDetailsEdit := true;
        end;
        if Rec.Status = Rec.Status::Pending then begin
            MemberNoEditable := false;
            RecoveryTypeEditable := false;
            LoantoAttachEditable := false;
            Global1Editable := false;
            Global2Editable := false;
            GuarantorLoansDetailsEdit := true;
        end;
        if Rec.Status = Rec.Status::Approved then begin
            MemberNoEditable := false;
            RecoveryTypeEditable := false;
            LoantoAttachEditable := false;
            Global1Editable := false;
            Global2Editable := false;
            GuarantorLoansDetailsEdit := true;
        end
    end;

    local procedure FnGetDefaultorLoanAmount(OutstandingBalance: Decimal; GuaranteedAmount: Decimal; TotalGuaranteedAmount: Decimal; GuarantorCount: Integer): Decimal
    begin
        if Rec."Guarantor Allocation Type" = Rec."guarantor allocation type"::"Equally Liable" then begin
            exit(OutstandingBalance / GuarantorCount)
        end else
            exit(ROUND(GuaranteedAmount / TotalGuaranteedAmount * (Rec."Loan Current PayOff Amount"), 0.05, '>'));

    end;


    procedure FnPostRepaymentJournal(TDefaulterLoan: Decimal)
    var
        ObjLoanDetails: Record "Loan Member Loans";
    begin
        if LoansRec.Get(Rec."Loan to Attach") then begin
            LineNo := LineNo + 10000;

            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
            GenJournalLine."account type"::customer, LoansRec."Client Code", Rec."Loan Disbursement Date", TDefaulterLoan * -1, Format(LoanApps.Source), EXTERNAL_DOC_NO,
            'Defaulted Loan Recovered-' + Rec."Loan to Attach", Rec."Loan to Attach", GenJournalLine."Source Type"::" ");//Maximum No of Parameters(13) Exceeded

        end;
    end;

    local procedure FnGetInterestForLoanToAttach(): Decimal
    var
        ObjLoansRegisterLocal: Record "Loans Register";
    begin
        ObjLoansRegisterLocal.Reset;
        ObjLoansRegisterLocal.SetRange(ObjLoansRegisterLocal."Loan  No.", Rec."Loan to Attach");
        if ObjLoansRegisterLocal.Find('-') then begin
            ObjLoansRegisterLocal.CalcFields(ObjLoansRegisterLocal."Outstanding Interest");
            exit(ObjLoansRegisterLocal."Outstanding Interest");
        end;

    end;

    local procedure FnRunInterest(RunningBalance: Decimal)
    var
        AmountToDeduct: Decimal;
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange("BOSA No", Rec."Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            if LoanApp.Find('-') then begin
                repeat
                    if RunningBalance > 0 then begin
                        AmountToDeduct := 0;
                        AmountToDeduct := FnCalculateTotalInterestDue(LoanApp);
                        if RunningBalance <= AmountToDeduct then
                            AmountToDeduct := RunningBalance;

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                        GenJournalLine."account type"::customer, LoanApp."Client Code", Rec."Loan Disbursement Date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                        Format(GenJournalLine."transaction type"::"Interest Paid"), LoanApp."Loan  No.", GenJournalLine."Source Type"::" ");
                        RunningBalance := RunningBalance - AmountToDeduct;
                    end;
                until LoanApp.Next = 0;
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                GenJournalLine."account type"::customer, Rec."Member No", Rec."Loan Disbursement Date", Rec."Total Interest Due Recovered", 'BOSA', EXTERNAL_DOC_NO,
                Format(GenJournalLine."transaction type"::"Deposit Contribution") + '-' + LoanApp."Loan Product Type", '', GenJournalLine."Source Type"::" ");
            end;
        end;
    end;

    local procedure FnRunPrinciple(RunningBalance: Decimal)
    var
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
    begin
        begin
            if LoansRec.Get(Rec."Loan to Attach") then begin
                //---------------------PAY-------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                GenJournalLine."account type"::customer, LoansRec."Client Code", Rec."Loan Disbursement Date", Rec."Loan Distributed to Guarantors" * -1, Format(LoansRec.Source), EXTERNAL_DOC_NO,
                Format(GenJournalLine."transaction type"::"Loan Repayment"), Rec."Loan to Attach", GenJournalLine."Source Type"::" ");
                //--------------------RECOVER-----------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                GenJournalLine."account type"::customer, Rec."Member No", Rec."Loan Disbursement Date", Rec."Deposits Aportioned", Format(LoansRec.Source), EXTERNAL_DOC_NO,
                Format(GenJournalLine."transaction type"::"Deposit Contribution") + '-' + LoansRec."Loan Product Type", '', GenJournalLine."Source Type"::" ");
            end;
        end;
    end;

    local procedure FnLoansGenerated()
    begin
    end;

    local procedure FnDefaulterLoansDisbursement(ObjLoanDetails: Record "Loan Member Loans"; LineNo: Integer): Code[40]
    var
        GenJournalLine: Record "Gen. Journal Line";
        CUNoSeriesManagement: Codeunit NoSeriesManagement;
        DocNumber: Code[100];
        loanTypes: Record "Loan Products Setup";
        ObjLoanX: Record "Loans Register";
    begin
        loanTypes.Reset;
        loanTypes.SetRange(loanTypes.Code, 'GUR');
        if loanTypes.Find('-') then begin
            DocNumber := CUNoSeriesManagement.GetNextNo('LOANSB', 0D, true);
            LoansRec.Init;
            LoansRec."Loan  No." := DocNumber;
            LoansRec.Insert;

            if LoansRec.Get(LoansRec."Loan  No.") then begin
                LoansRec."Client Code" := ObjLoanDetails."Guarantor Number";
                LoansRec.Validate(LoansRec."Client Code");
                LoansRec."Loan Product Type" := 'GUR';
                LoansRec.Validate(LoansRec."Loan Product Type");
                LoansRec.Interest := ObjLoanDetails."Interest Rate";
                LoansRec."Loan Status" := LoansRec."loan status"::Closed;
                LoansRec."Application Date" := Rec."Loan Disbursement Date";
                LoansRec."Issued Date" := Rec."Loan Disbursement Date";
                LoansRec."Loan Disbursement Date" := Rec."Loan Disbursement Date";
                LoansRec."Expected Date of Completion" := Rec."Expected Date of Completion";
                LoansRec.Validate(LoansRec."Loan Disbursement Date");
                LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::"Bank Transfer";
                LoansRec."Repayment Start Date" := Rec."Repayment Start Date";
                LoansRec."Global Dimension 1 Code" := Format(LoanApps.Source);
                LoansRec."Global Dimension 2 Code" := SFactory.FnGetUserBranch();
                LoansRec.Source := LoansRec.Source::BOSA;
                LoansRec."Approval Status" := LoansRec."approval status"::Approved;
                LoansRec.Repayment := ObjLoanDetails."Approved Loan Amount";
                LoansRec."Requested Amount" := 0;
                LoansRec."Approved Amount" := ObjLoanDetails."Approved Loan Amount";
                LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::"Bank Transfer";
                LoansRec.Posted := true;
                LoansRec."Advice Date" := Today;
                LoansRec.Modify;
            end;
        end;
        exit(DocNumber);
    end;

    local procedure FnGenerateRepaymentSchedule(LoanNumber: Code[50])
    begin
        LoansR.Reset;
        LoansR.SetRange(LoansR."Loan  No.", LoansRec."Loan  No.");
        LoansR.SetFilter(LoansR."Approved Amount", '>%1', 0);
        LoansR.SetFilter(LoansR.Posted, '=%1', true);
        if LoansR.Find('-') then begin
            if ((LoansR."Loan Product Type" = 'GUR') and (LoansR."Issued Date" <> 0D) and (LoansR."Repayment Start Date" <> 0D)) then begin
                LoansRec.TestField(LoansRec."Loan Disbursement Date");
                LoansRec.TestField(LoansRec."Repayment Start Date");

                RSchedule.Reset;
                RSchedule.SetRange(RSchedule."Loan No.", LoansR."Loan  No.");
                RSchedule.DeleteAll;

                LoanAmount := LoansR."Approved Amount";
                InterestRate := LoansR.Interest;
                RepayPeriod := LoansR.Installments;
                InitialInstal := LoansR.Installments + LoansRec."Grace Period - Principle (M)";
                LBalance := LoansR."Approved Amount";
                RunDate := Rec."Repayment Start Date";
                InstalNo := 0;

                //Repayment Frequency
                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                    RunDate := CalcDate('-1D', RunDate)
                else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                    RunDate := CalcDate('-1W', RunDate)
                else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                    RunDate := CalcDate('-1M', RunDate)
                else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                    RunDate := CalcDate('-1Q', RunDate);
                //Repayment Frequency


                repeat
                    InstalNo := InstalNo + 1;
                    //Repayment Frequency
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                        RunDate := CalcDate('1D', RunDate)
                    else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                        RunDate := CalcDate('1W', RunDate)
                    else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                        RunDate := CalcDate('1M', RunDate)
                    else if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                        RunDate := CalcDate('1Q', RunDate);

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::Amortised then begin
                        //LoansRec.TESTFIELD(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                        LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                        LPrincipal := TotalMRepay - LInterest;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::"Straight Line" then begin
                        LoansRec.TestField(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LoanAmount / RepayPeriod;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::"Reducing Balance" then begin
                        LoansRec.TestField(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LBalance;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::Constants then begin
                        LoansRec.TestField(LoansRec.Repayment);
                        if LBalance < LoansRec.Repayment then
                            LPrincipal := LBalance
                        else
                            LPrincipal := LoansRec.Repayment;
                        LInterest := LoansRec.Interest;
                    end;

                    //Grace Period
                    if GrPrinciple > 0 then begin
                        LPrincipal := 0
                    end else begin
                        LBalance := LBalance - LPrincipal;

                    end;

                    if GrInterest > 0 then
                        LInterest := 0;

                    GrPrinciple := GrPrinciple - 1;
                    GrInterest := GrInterest - 1;
                    Evaluate(RepayCode, Format(InstalNo));


                    RSchedule.Init;
                    RSchedule."Repayment Code" := RepayCode;
                    RSchedule."Interest Rate" := InterestRate;
                    RSchedule."Loan No." := LoansRec."Loan  No.";
                    RSchedule."Loan Amount" := LoanAmount;
                    RSchedule."Instalment No" := InstalNo;
                    RSchedule."Repayment Date" := RunDate;
                    RSchedule."Member No." := LoansRec."Client Code";
                    RSchedule."Loan Category" := LoansRec."Loan Product Type";
                    RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                    RSchedule."Monthly Interest" := LInterest;
                    RSchedule."Principal Repayment" := LPrincipal;
                    RSchedule.Insert;
                    WhichDay := Date2dwy(RSchedule."Repayment Date", 1);
                until LBalance < 1

            end;
        end;

        Commit;
    end;

    local procedure FnRecoverMobileLoanPrincipal(RunningBalance: Decimal)
    var
        AmountToDeduct: Decimal;
        varLRepayment: Decimal;
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."BOSA No", Rec."Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter(Source, Format(LoanApp.Source::FOSA));
            LoanApp.SetFilter("Loan Product Type", 'MSADV');
            LoanApp.SetFilter(Posted, 'Yes');
            if LoanApp.Find('-') then begin
                //---------------------PAY-------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                GenJournalLine."account type"::customer, LoanApp."Client Code", Rec."Loan Disbursement Date", Rec."Mobile Loan" * -1, 'FOSA', EXTERNAL_DOC_NO,
                Format(GenJournalLine."transaction type"::"Loan Repayment"), LoanApp."Loan  No.", GenJournalLine."Source Type"::" ");
                //--------------------RECOVER-----------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                GenJournalLine."account type"::customer, Rec."Member No", Rec."Loan Disbursement Date", Rec."Mobile Loan", 'BOSA', EXTERNAL_DOC_NO,
                Format(GenJournalLine."transaction type"::"Deposit Contribution") + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", GenJournalLine."Source Type"::" ");
            end;
        end;
    end;

    local procedure FnRunPrincipleThirdparty(RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ReceiptLine: Record "Checkoff Lines-Distributed";
    begin
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", Rec."Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter(LoanApp."Loan Product Type", 'GUR');
            if LoanApp.Find('-') then begin
                repeat
                    if RunningBalance > 0 then begin
                        LoanApp.CalcFields(LoanApp."Outstanding Balance");
                        if LoanApp."Outstanding Balance" > 0 then begin
                            varLRepayment := 0;
                            PRpayment := 0;
                            varLRepayment := LoanApp."Outstanding Balance";
                            if varLRepayment > 0 then begin
                                if RunningBalance > 0 then begin
                                    if RunningBalance > varLRepayment then begin
                                        AmountToDeduct := varLRepayment;
                                    end
                                    else
                                        AmountToDeduct := RunningBalance;
                                end;
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                GenJournalLine."account type"::customer, LoanApp."Client Code", Rec."Loan Disbursement Date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                                Format(GenJournalLine."transaction type"::"Loan Repayment"), LoanApp."Loan  No.", GenJournalLine."Source Type"::" ");
                                RunningBalance := RunningBalance - AmountToDeduct;
                            end;
                        end;
                    end;

                until LoanApp.Next = 0;
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                GenJournalLine."account type"::customer, Rec."Member No", Rec."Loan Disbursement Date", Rec."Total Thirdparty Loans", 'BOSA', EXTERNAL_DOC_NO,
                Format(GenJournalLine."transaction type"::"Deposit Contribution") + '-' + LoanApp."Loan Product Type", '', GenJournalLine."Source Type"::" ");
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnGenerateDefaulterLoans()
    var
        DLoanAmount: Decimal;
    begin
        LoanDetails.Reset;
        LoanDetails.SetRange(LoanDetails."Document No", Rec."Document No");
        LoanDetails.SetRange(LoanDetails."Loan No.", Rec."Loan to Attach");
        LoanDetails.SetRange(LoanDetails."Member No", Rec."Member No");
        if LoanDetails.FindSet then begin
            repeat
                LineNo := LineNo + 1000;
                DLoan := FnDefaulterLoansDisbursement(LoanDetails, LineNo);
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Loan,
                GenJournalLine."account type"::customer, LoanDetails."Guarantor Number", Rec."Loan Disbursement Date", LoanDetails."Guarantor Amount Apportioned", Format(LoansRec.Source::BOSA), Rec."Loan to Attach",
                'Defaulter Recovery-' + Rec."Loan to Attach", LoanDetails."Defaulter Loan No", GenJournalLine."Source Type"::" ");//DLoan
                DLoanAmount := DLoanAmount + LoanDetails."Guarantor Amount Apportioned";
            until LoanDetails.Next = 0;
        end;

        if LoansRec.Get(Rec."Loan to Attach") then begin
            LineNo := LineNo + 10000;
            /*SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Loan Repayment",
            GenJournalLine."Account Type"::Customer,LoansRec."Client Code","Loan Disbursement Date",DLoanAmount*-1,FORMAT(LoanApps.Source),EXTERNAL_DOC_NO,
            'Defaulted Loan Recovered-'+LoansRec."Loan Product Type","Loan to Attach");*///Maximum no of Parameters Exceeded

            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := BATCH_TEMPLATE;
            GenJournalLine."Journal Batch Name" := BATCH_NAME;
            GenJournalLine."Document No." := DOCUMENT_NO;
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::customer;
            GenJournalLine."Account No." := LoansRec."Client Code";
            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Loan Repayment";
            GenJournalLine."Loan No" := Rec."Loan to Attach";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := Rec."Loan Disbursement Date";
            GenJournalLine.Description := 'Defaulted Loan Recovered-' + Rec."Loan to Attach";
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := DLoanAmount * -1;
            GenJournalLine."External Document No." := Rec."Loan to Attach";
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Recovery Transaction Type" := GenJournalLine."recovery transaction type"::"Guarantor Recoverd";
            GenJournalLine."Recoverd Loan" := true;
            GenJournalLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
            GenJournalLine."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;
        end;

    end;

    local procedure FnCalculateTotalInterestDue(Loans: Record "Loans Register") InterestDue: Decimal
    var
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        "Loan Age": Integer;
    begin
        ObjRepaymentSchedule.Reset;
        ObjRepaymentSchedule.SetRange("Loan No.", Loans."Loan  No.");
        ObjRepaymentSchedule.SetFilter("Repayment Date", '<=%1', Rec."Loan Disbursement Date");
        if ObjRepaymentSchedule.Find('-') then
            "Loan Age" := ObjRepaymentSchedule.Count;
        Loans.CalcFields("Outstanding Balance", "Interest Paid");

        InterestDue := ((0.01 * Loans."Approved Amount" + 0.01 * Loans."Outstanding Balance") * Loans.Interest / 12 * ("Loan Age")) / 2 - Abs(Loans."Interest Paid");
        if (Date2dmy(Rec."Loan Disbursement Date", 1) > 15) then begin
            InterestDue := ((0.01 * Loans."Approved Amount" + 0.01 * Loans."Outstanding Balance") * Loans.Interest / 12 * ("Loan Age" + 1)) / 2 - Abs(Loans."Interest Paid");
        end;
        if InterestDue <= 0 then
            exit(0);
        //MESSAGE('Approved=%1 Loan Age=%2 OBalance=%3 InterestPaid=%4 InterestDue=%5',Loans."Approved Amount","Loan Age",Loans."Outstanding Balance",Loans."Interest Paid",InterestDue);
        exit(InterestDue);
    end;

    local procedure FnRunRecoverFromLoaneesDeposits(RunningBalance: Decimal)
    var
        AmountToDeduct: Decimal;
        CUST: Record Customer;
    begin
        Rec.CalcFields("Total Guarantor Allocation");
        VarAmounttoDeduct := 0;
        RunningBalance := Rec."Total Guarantor Allocation";
        CUST.reset();
        CUST.setrange("No.", Rec."Member No");
        if CUST.find('-') then
            CUST.calcfields("Current Shares");
        Message('RunningBal=%1..Current Shares is %2 ', RunningBalance, cust."Current Shares");
        //============================================================Loan Penalty Repayment
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan to Attach");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            if LoanApp.Find('-') then begin
                //REPEAT
                // Message(' Rec."Outstanding Interest"=%1 RunningBal=%2', Rec."Outstanding Interest", RunningBalance);

                AmountToDeduct := 0;
                if Rec."Outstanding Interest" > 0 then begin
                    if Rec."Outstanding Interest" < RunningBalance then begin
                        AmountToDeduct := Rec."Outstanding Interest"
                    end else
                        AmountToDeduct := RunningBalance;
                    // Message('Interest=%1 Deduct=%2 RunningBal=%3', Rec."Outstanding Interest", AmountToDeduct, RunningBalance);
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                    GenJournalLine."account type"::Customer, LoanApp."Client Code", Rec."Loan Disbursement Date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                    'interest Recovered From Deposits', LoanApp."Loan  No.", GenJournalLine."Source Type"::" ");
                    RunningBalance := RunningBalance - AmountToDeduct;
                    VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                end;

            end;
        end;
        //============================================================Loan Principle Repayment
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan to Attach");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            if LoanApp.Find('-') then begin
                LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Interest");
                if RunningBalance > 0 then begin
                    AmountToDeduct := 0;
                    if LoanApp."Outstanding Balance" > 0 then begin
                        if LoanApp."Outstanding Balance" < RunningBalance then begin
                            AmountToDeduct := LoanApp."Outstanding Balance"
                        end else
                            AmountToDeduct := RunningBalance;

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                        GenJournalLine."account type"::Customer, LoanApp."Client Code", Rec."Loan Disbursement Date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                        'Repayment Recovered From Deposits', LoanApp."Loan  No.", GenJournalLine."Source Type"::" ");
                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                    end;
                end;
            end;
        end;


        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
        GenJournalLine."account type"::Customer, Rec."Member No", Rec."Loan Disbursement Date", VarAmounttoDeduct, 'BOSA', EXTERNAL_DOC_NO,
        'Repayment Recovered From Deposits' + '-' + LoanApp."Loan Product Type Name", '', GenJournalLine."Source Type"::" ");
    end;

    local procedure FnRunRecoverFromGuarantorsDeposits(VarDocumentNo: Code[20]; VarLoanNo: Code[20]; VarMemberNo: Code[20]; VarPostingDate: Date)
    var
        AmountToDeduct: Decimal;
        RunningBalance: Decimal;
        VarInsuranceAmounttoDeduct: Decimal;
    begin


        ObjLoanGuarantors.Reset;
        ObjLoanGuarantors.SetRange("Document No", VarDocumentNo);
        if ObjLoanGuarantors.FindSet then begin
            repeat
                RunningBalance := ObjLoanGuarantors."Guarantor Amount Apportioned";

                if RunningBalance > 0 then begin

                    if (Rec."Charge Insurance" = true) and (Rec."Insurance Fully Recovered" = false) then begin

                        //============================================================Loan Insurance Repayment
                        LoanApp.Reset;
                        LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
                        //LoanApp.SETRANGE("BOSA No","Member No");
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan to Attach");
                        LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
                        if LoanApp.Find('-') then begin
                            //REPEAT
                            LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Interest", LoanApp."Outstanding Insurance", LoanApp."Outstanding Penalty");
                            if RunningBalance > 0 then begin
                                AmountToDeduct := 0;

                                VarInsuranceAmounttoDeduct := LoanApp."Outstanding Insurance" + Rec."Insurance:Remaining Period";

                                if Rec."Insurance Difference" <> 0 then begin
                                    VarInsuranceAmounttoDeduct := Rec."Insurance Difference"
                                end;

                                if VarInsuranceAmounttoDeduct > 0 then begin
                                    if VarInsuranceAmounttoDeduct <= RunningBalance then begin
                                        AmountToDeduct := VarInsuranceAmounttoDeduct
                                    end else
                                        AmountToDeduct := RunningBalance;

                                    if ObjLoanType.Get(LoanApp."Loan Product Type") then begin
                                        VarLoanInsuranceBalAccount := ObjLoanType."Receivable Insurance Accounts";
                                    end;
                                    //------------------------------------DEBIT INSURANCE FOR THE CURRENT YEAR  A/C---------------------------------------------------------------------------------------------

                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Charged",
                                    GenJournalLine."account type"::Customer, VarMemberNo, VarPostingDate, 'Loan Insurance:_' + Rec."Document No", GenJournalLine."bal. account type"::"G/L Account",
                                    VarLoanInsuranceBalAccount, AmountToDeduct, 'BOSA', VarLoanNo);
                                    //--------------------------------(Credit Loan Penalty Account)-------------------------------------------------------------------------------

                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Paid",
                                    GenJournalLine."account type"::Customer, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                                    'Loan Recovered From_' + ObjLoanGuarantors."Member Name" + ObjLoanGuarantors."Guarantor Number", VarLoanNo, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNo);

                                    RunningBalance := RunningBalance - AmountToDeduct;
                                    VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                                end;
                            end;
                        end;
                    end;
                end;

                //============================================================Loan Penalty Repayment
                if RunningBalance > 0 then begin
                    LoanApp.Reset;
                    LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
                    //LoanApp.SETRANGE("BOSA No","Member No");
                    LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan to Attach");
                    LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
                    if LoanApp.Find('-') then begin
                        //REPEAT
                        LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Interest", LoanApp."Outstanding Insurance", LoanApp."Outstanding Penalty");
                        if RunningBalance > 0 then begin
                            AmountToDeduct := 0;
                            if LoanApp."Outstanding Penalty" > 0 then begin
                                if LoanApp."Outstanding Penalty" < RunningBalance then begin
                                    AmountToDeduct := LoanApp."Outstanding Penalty"
                                end else
                                    AmountToDeduct := RunningBalance;

                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Paid",
                                GenJournalLine."account type"::Customer, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                                'Loan Recovered From_' + ObjLoanGuarantors."Member Name" + ObjLoanGuarantors."Guarantor Number", VarLoanNo, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNo);

                                RunningBalance := RunningBalance - AmountToDeduct;
                                VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                            end;
                        end;
                    end;
                end;

                //============================================================Loan Interest Repayment
                if RunningBalance > 0 then begin
                    LoanApp.Reset;
                    LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
                    //LoanApp.SETRANGE("BOSA No","Member No");
                    LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan to Attach");
                    LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
                    if LoanApp.Find('-') then begin
                        //REPEAT
                        LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Interest", LoanApp."Outstanding Insurance", LoanApp."Outstanding Penalty");
                        if RunningBalance > 0 then begin
                            AmountToDeduct := 0;
                            if LoanApp."Outstanding Interest" > 0 then begin
                                if LoanApp."Outstanding Interest" < RunningBalance then begin
                                    AmountToDeduct := LoanApp."Outstanding Interest"
                                end else
                                    AmountToDeduct := RunningBalance;

                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                GenJournalLine."account type"::Customer, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                                'Loan Recovered From_' + ObjLoanGuarantors."Member Name" + ObjLoanGuarantors."Guarantor Number", VarLoanNo, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNo);

                                RunningBalance := RunningBalance - AmountToDeduct;
                                VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                            end;
                        end;
                    end;
                end;






                //============================================================Loan Principle Repayment
                if RunningBalance > 0 then begin
                    LoanApp.Reset;
                    LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
                    //LoanApp.SETRANGE("BOSA No","Member No");
                    LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan to Attach");
                    LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
                    if LoanApp.Find('-') then begin
                        LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Interest", LoanApp."Outstanding Insurance", LoanApp."Outstanding Penalty");
                        if RunningBalance > 0 then begin
                            AmountToDeduct := 0;
                            if LoanApp."Outstanding Balance" > 0 then begin
                                if LoanApp."Outstanding Balance" < RunningBalance then begin
                                    AmountToDeduct := LoanApp."Outstanding Balance"
                                end else
                                    AmountToDeduct := RunningBalance;

                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                GenJournalLine."account type"::Customer, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                                'Loan Recovered From_' + ObjLoanGuarantors."Member Name" + ObjLoanGuarantors."Guarantor Number", VarLoanNo, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNo);
                                RunningBalance := RunningBalance - AmountToDeduct;
                                VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                            end;
                        end;
                    end;
                end;


                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                GenJournalLine."account type"::Customer, ObjLoanGuarantors."Guarantor Number", VarPostingDate, ObjLoanGuarantors."Guarantor Amount Apportioned", 'BOSA', EXTERNAL_DOC_NO,
                'Loan Recovery' + '-' + VarMemberNo + '-' + Rec."Member Name", '', GenJournalLine."Source Type"::" ");

                //Post New
                // GenJournalLine.Reset;
                // GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                // GenJournalLine.SetRange("Journal Batch Name", 'RECOVERIES');
                // if GenJournalLine.Find('-') then begin
                //     Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
                // end;

                if VarInsuranceAmounttoDeduct < ObjLoanGuarantors."Guarantor Amount Apportioned" then begin
                    Rec."Insurance Fully Recovered" := true;
                    Rec."Insurance Difference" := 0
                end else
                    Rec."Insurance Difference" := VarInsuranceAmounttoDeduct - ObjLoanGuarantors."Guarantor Amount Apportioned";
            until ObjLoanGuarantors.Next = 0;
        end;

        Rec.Validate("Member No");
    end;

    local procedure FnRunShareCapitalSell()
    var
        ObjShareCapSell: Record "Share Capital Sell";
        TemplateName: Code[30];
        BatchName: Code[30];
        SurestepFactory: Codeunit "Micropoint Factory";
        Generalsetup: Record "Sacco General Set-Up";
        VarBuyerMemberNo: Code[50];
    begin
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'RECOVERIES';
        DOCUMENT_NO := Rec."Document No";
        EXTERNAL_DOC_NO := Rec."Loan to Attach";
        Datefilter := '..' + Format(Rec."Loan Disbursement Date");

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;


        //====================================================BOSA Transactions
        VarBuyerMemberNo := '';
        //Credit Buyer Account
        ObjShareCapSell.Reset;
        ObjShareCapSell.SetRange(ObjShareCapSell."Document No", Rec."Document No");
        if ObjShareCapSell.FindSet then begin
            repeat
                LineNo := LineNo + 10000;
                SurestepFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, Rec."Document No", LineNo, GenJournalLine."transaction type"::"Share Capital",
                GenJournalLine."account type"::Vendor, ObjShareCapSell."Buyer Share Capital Account", Rec."Loan Disbursement Date",
                (ObjShareCapSell.Amount * -1), 'BOSA', Rec."Document No", 'Share Capital Purchase From ' + Rec."Member No", '', GenJournalLine."Source Type"::" ");
                VarBuyerMemberNo := VarBuyerMemberNo + ObjShareCapSell."Buyer Member No" + ', ';
            until ObjShareCapSell.Next = 0;
        end;

        if ObjCust.Get(Rec."Member No") then begin
            LineNo := LineNo + 10000;
            //Debit Seller Account
            Rec.CalcFields("Share Capital to Sell");
            SurestepFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, Rec."Document No", LineNo, GenJournalLine."transaction type"::"Share Capital",
            GenJournalLine."account type"::Vendor, ObjCust."Share Capital No", Rec."Loan Disbursement Date",
                (Rec."Share Capital to Sell"), 'BOSA', Rec."Document No", 'Share Capital Sell to ' + VarBuyerMemberNo, '', GenJournalLine."Source Type"::" ");
        end;
        //===============================================End BOSA Transactions


        //==================================================FOSA Transaction
        //Debit Buyer FOSA Account
        ObjShareCapSell.Reset;
        ObjShareCapSell.SetRange(ObjShareCapSell."Document No", Rec."Document No");
        if ObjShareCapSell.FindSet then begin
            repeat
                LineNo := LineNo + 10000;
                SurestepFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, Rec."Document No", LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, ObjShareCapSell."Buyer FOSA Account", Rec."Loan Disbursement Date",
                (ObjShareCapSell.Amount), 'FOSA', Rec."Document No", 'Share Capital Purchase From ' + Rec."Member No", '', GenJournalLine."Source Type"::" ");
            until ObjShareCapSell.Next = 0;
        end;

        LineNo := LineNo + 10000;
        //Credit Seller FOSA Account
        Rec.CalcFields("Share Capital to Sell");
        SurestepFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, Rec."Document No", LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, Rec."Share Capital Seller FOSA Acc", Rec."Loan Disbursement Date",
            (Rec."Share Capital to Sell" * -1), 'FOSA', Rec."Document No", 'Share Capital Sell to ' + VarBuyerMemberNo, '', GenJournalLine."Source Type"::" ");
        //==================================================FOSA Transaction

        /*
        LineNo:=LineNo+10000;
        //Post Transfer Fee
        Generalsetup.GET();
        
        SurestepFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE,BATCH_NAME,"Document No",LineNo,GenJournalLine."Transaction Type"::" ",GenJournalLine."Account Type"::Vendor,"Loan Settlement Account","Loan Disbursement Date"
        ,'Share Cap Sell Fee_'+FORMAT("Document No"),GenJournalLine."Bal. Account Type"::"G/L Account",Generalsetup."Share Capital Transfer Fee Acc",("Share Capital Transfer Fee"),'BOSA','');
        
        LineNo:=LineNo+10000;
        //Post Transfer Fee Excise Duty
        Generalsetup.GET();
        
        SurestepFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE,BATCH_NAME,"Document No",LineNo,GenJournalLine."Transaction Type"::" ",GenJournalLine."Account Type"::Vendor,"Loan Settlement Account","Loan Disbursement Date"
        ,'Share Cap Sell Excise_'+FORMAT("Document No"),GenJournalLine."Bal. Account Type"::"G/L Account",Generalsetup."Excise Duty Account",("Share Capital Transfer Fee"*(Generalsetup."Excise Duty(%)"/100)),'BOSA','');
        //Post Transfer Fee Excise Duty
        */

        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco21", GenJournalLine);
        end;
        Rec.Validate("Loan Settlement Account");

    end;

    local procedure FnRunPostAmountAllocatedtoLSA(VarDocumentNo: Code[30]; VarPostingDate: Date; VarLoanNo: Code[30])
    var
        GuarantorName: Text[100];
    begin
        ObjLoanGuarantors.Reset;
        ObjLoanGuarantors.SetRange("Document No", VarDocumentNo);
        if ObjLoanGuarantors.FindSet then begin
            repeat
                if ObjCust.Get(ObjLoanGuarantors."Guarantor Number") then begin
                    GuarantorName := ObjCust.Name;
                end;

                if ObjCust.Get(ObjLoanGuarantors."Guarantor Number") then begin

                    //--------------------------------(Credit LSA Account)-------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                    GenJournalLine."account type"::Customer, Rec."Member No", VarPostingDate, ObjLoanGuarantors."Guarantor Amount Apportioned" * -1, 'BOSA', EXTERNAL_DOC_NO,
                    'Loan Recovered:' + GuarantorName + ObjLoanGuarantors."Guarantor Number", VarLoanNo, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNo);

                    //--------------------------------(Debit Guarantor Account)-------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                    GenJournalLine."account type"::Customer, ObjLoanGuarantors."Guarantor Number", VarPostingDate, ObjLoanGuarantors."Guarantor Amount Apportioned", 'BOSA', EXTERNAL_DOC_NO,
                    'Loan Recovered:' + Rec."Member Name" + Rec."Member No", VarLoanNo, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNo);
                end;
            until ObjLoanGuarantors.Next = 0;
        end;


    end;

    local procedure FnRunCreateRecoveryLedgerEntry(VarMemberNo: Code[30]; VarMemberName: Text[100]; VarPostingDate: Date)
    var
        ObjGuarantorLedger: Record "Guarantor Recovery Ledger";
        EntryNo: Integer;
        VarGuarantorName: Text[100];
    begin
        ObjLoanGuarantors.Reset;
        ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Document No", Rec."Document No");
        if ObjLoanGuarantors.FindSet then begin
            repeat

                if ObjCust.Get(ObjLoanGuarantors."Guarantor Number") then begin
                    VarGuarantorName := ObjCust.Name;
                end;
                ObjGuarantorLedger.Reset;
                if ObjGuarantorLedger.FindLast then begin
                    EntryNo := ObjGuarantorLedger."Entry No.";
                end;

                EntryNo := EntryNo + 1;

                Rec.CalcFields("Total Guarantor Allocation");
                ObjGuarantorLedger.Init;
                ObjGuarantorLedger."Entry No." := EntryNo;
                ObjGuarantorLedger."Defaulter Member No" := Rec."Member No";
                ObjGuarantorLedger."Defaulter Name" := Rec."Member Name";
                ObjGuarantorLedger."Posting Date" := Rec."Loan Disbursement Date";
                ObjGuarantorLedger."Document No." := Rec."Document No";
                ObjGuarantorLedger."Guarantor No" := ObjLoanGuarantors."Guarantor Number";
                ObjGuarantorLedger."Guarantor Name" := VarGuarantorName;
                ObjGuarantorLedger."Amount Allocated" := ObjLoanGuarantors."Guarantor Amount Apportioned";
                ObjGuarantorLedger.Insert;
            until ObjLoanGuarantors.Next = 0;
        end;
    end;

    local procedure FnRunPostMemberDepositstoLSA(VarDocumentNo: Code[30]; VarPostingDate: Date; VarLoanNo: Code[30])
    var
        GuarantorName: Text[100];
        VarAmounttoRecover: Decimal;
    begin
        if ObjCust.Get(Rec."Member No") then begin
            if Rec."Current Shares" < Rec."Loan Current PayOff Amount" then begin
                VarAmounttoRecover := Rec."Current Shares"
            end else
                VarAmounttoRecover := Rec."Loan Current PayOff Amount";

            //--------------------------------(Credit LSA Account)-------------------------------------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, Rec."Loan Settlement Account", VarPostingDate, VarAmounttoRecover * -1, 'BOSA', EXTERNAL_DOC_NO,
            'Loan Recovered: ' + Rec."Member Name" + ' - ' + VarLoanNo, VarLoanNo, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNo);

            //--------------------------------(Debit Guarantor Account)-------------------------------------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
            GenJournalLine."account type"::Vendor, ObjCust."Deposits Account No", VarPostingDate, VarAmounttoRecover, 'BOSA', EXTERNAL_DOC_NO,
            'Loan Recovered: ' + Rec."Member Name" + ' - ' + VarLoanNo, VarLoanNo, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNo);


            //Post New
            // GenJournalLine.Reset;
            // GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
            // GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
            // if GenJournalLine.Find('-') then begin
            //     Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
            // end;
        end;
    end;

    local procedure FnLoadselfGuarantorsForRecovery()
    var
        LoanDetails: Record "Loan Member Loans";
        TotalLiability: Decimal;
        ActualRecoverableAmount: Decimal;
    begin
        // Clear existing records
        LoanDetails.Reset();
        LoanDetails.SetRange("Loan No.", Rec."Loan to Attach");
        LoanDetails.DeleteAll();

        // Calculate total liability (what actually needs to be recovered)
        if Rec."Add Interest" = true then
            TotalLiability := Rec."Loan Current PayOff Amount" + Rec."Outstanding Interest"
        else
            TotalLiability := Rec."Loan Current PayOff Amount";

        // Load guarantors with deposits
        LoanGuarantors.Reset();
        LoanGuarantors.SetRange("Loan No", Rec."Loan to Attach");
        LoanGuarantors.setrange(LoanGuarantors."Self Guarantee", true);
        if not LoanGuarantors.FindSet() then
            exit;

        repeat
            if ObjCust.Get(LoanGuarantors."Member No") then begin
                ObjCust.CalcFields("Current Shares");
                if ObjCust."Current Shares" > 0 then begin
                    // Calculate actual recoverable amount = minimum of (member deposits, total liability)
                    if ObjCust."Current Shares" < TotalLiability then
                        ActualRecoverableAmount := ObjCust."Current Shares"
                    else
                        ActualRecoverableAmount := TotalLiability;

                    LoanDetails.Init();
                    LoanDetails."Document No" := Rec."Document No";
                    LoanDetails."Member No" := Rec."Member No";
                    LoanDetails."Member Name" := LoanGuarantors.Name;
                    LoanDetails."Guarantor Number" := LoanGuarantors."Member No";
                    LoanDetails."Loan No." := LoanGuarantors."Loan No";
                    LoanDetails."Amont Guaranteed" := LoanGuarantors."Amont Guaranteed";
                    LoanDetails."Guarantors Current Shares" := ObjCust."Current Shares";
                    LoanDetails."Current Member Deposits" := ObjCust."Current Shares";
                    LoanDetails."Guarantor Amount Apportioned" := ActualRecoverableAmount;
                    LoanDetails.Insert();
                end;
            end;
        until LoanGuarantors.Next() = 0;
    end;

    local procedure FnLoadGuarantorsForRecovery()
    var
        LoanDetails: Record "Loan Member Loans";
    begin
        // Clear existing records
        LoanDetails.Reset();
        LoanDetails.SetRange("Loan No.", Rec."Loan to Attach");
        LoanDetails.DeleteAll();

        // Load guarantors with deposits
        LoanGuarantors.Reset();
        LoanGuarantors.SetRange("Loan No", Rec."Loan to Attach");
        // LoanGuarantors.setrange(LoanGuarantors."Self Guarantee", false); // Allow self guarantors to appear
        if not LoanGuarantors.FindSet() then
            exit;

        repeat
            // Allow self guarantors to appear in the list
            if ObjCust.Get(LoanGuarantors."Member No") then begin
                ObjCust.CalcFields("Current Shares");
                if ObjCust."Current Shares" > 0 then begin
                    LoanDetails.Init();
                    LoanDetails."Document No" := Rec."Document No";
                    LoanDetails."Member No" := Rec."Member No";
                    LoanDetails."Member Name" := LoanGuarantors.Name;

                    LoanDetails."Guarantor Number" := LoanGuarantors."Member No";
                    LoanDetails."Loan No." := LoanGuarantors."Loan No";
                    LoanDetails."Amont Guaranteed" := LoanGuarantors."Amont Guaranteed";
                    LoanDetails."Guarantors Current Shares" := ObjCust."Current Shares";
                    LoanDetails."Current Member Deposits" := ObjCust."Current Shares";
                    // Mark as self guarantor if it's the loanee
                    if LoanGuarantors."Member No" = Rec."Member No" then
                        LoanDetails."Self Guarantor" := true
                    else
                        LoanDetails."Self Guarantor" := false;
                    // LoanDetails."Guarantor Amount Apportioned" := LoanGuarantors."Amont Guaranteed" / Rec.tota * Rec."Loan Current PayOff Amount";
                    // Message('Amount Apportioned is %1', loanDetails."Guarantor Amount Apportioned");
                    LoanDetails.Insert();
                end;
            end;
        until
        LoanGuarantors.Next() = 0;

        // Self-guarantors are excluded from recovery lines as their deposits
        // are used to offset the total liability before apportioning to other guarantors
    end;

    local procedure FnLoadGuarantorsAndCreateDefaulterLoans()
    var
        LoanDetails: Record "Loan Member Loans";
        GCount: Integer;
        DefaulterAmount: Decimal;
        NewLoanNo: Code[20];
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        // Clear existing records
        LoanDetails.Reset();
        LoanDetails.SetRange("Loan No.", Rec."Loan to Attach");
        LoanDetails.DeleteAll();

        // Load guarantors
        LoanGuarantors.Reset();
        LoanGuarantors.SetRange("Loan No", Rec."Loan to Attach");
        if not LoanGuarantors.FindSet() then
            Error('No guarantors found for loan %1', Rec."Loan to Attach");

        GCount := LoanGuarantors.Count();
        ObjSaccoNoSeries.Get();

        repeat
            LoanGuarantors.CalcFields(
                "Outstanding Balance",
                "Oustanding Interest",
                "Total Loans Guaranteed"
            );

            // Calculate defaulter loan amount once
            // Message('liability is %1', Rec."Loan Liabilities");

            DefaulterAmount := Round(
                FnGetDefaultorLoanAmount(
                    Rec."Loan Distributed to Guarantors",
                    LoanGuarantors."Amont Guaranteed",
                    LoanGuarantors."Total Loans Guaranteed",
                    GCount
                ), 0.05, '>'
            );
            // Message(' LoanGuarantors."Amont Guaranteed" is %1,..Total Loans Guaranteed %2...GCount %3', LoanGuarantors."Amont Guaranteed", LoanGuarantors."Total Loans Guaranteed", GCount);
            //  DefaulterAmount := Abs(Rec."Loan Distributed to Guarantors");
            //  Message('Defaulter jmk Amount is %1', DefaulterAmount);
            // Create defaulter loan
            NewLoanNo := FnCreateDefaulterLoan(
                LoanGuarantors."Member No",
                DefaulterAmount,
                NoSeriesMgt
            );

            // Create loan detail record
            FnCreateLoanDetail(LoanGuarantors, DefaulterAmount, NewLoanNo);

        until LoanGuarantors.Next() = 0;

        Message('Successfully loaded %1 guarantors and created defaulter loans.', GCount);
    end;

    local procedure FnCreateDefaulterLoan(
        GuarantorNo: Code[20];
        LoanAmount: Decimal;
        var NoSeriesMgt: Codeunit NoSeriesManagement
    ): Code[20]
    var
        NewLoan: Record "Loans Register";
        LoanNo: Code[20];
    begin
        LoanNo := NoSeriesMgt.GetNextNo(ObjSaccoNoSeries."BOSA Loans Nos", Today, true);

        NewLoan.Init();
        NewLoan."Loan  No." := LoanNo;
        NewLoan."Application Date" := Today;
        NewLoan."Client Code" := GuarantorNo;
        NewLoan.Validate("Client Code");
        NewLoan."Requested Amount" := LoanAmount;
        NewLoan."Approved Amount" := LoanAmount;
        NewLoan."Loan Product Type" := 'DEFAULTER';
        NewLoan.Validate("Loan Product Type");

        NewLoan.Installments := ObjLoanType."No of Installment";
        NewLoan.Interest := ObjLoanType."Interest rate";
        NewLoan."Issued Date" := Today;
        NewLoan."Loan Disbursement Date" := Today;
        NewLoan.Validate("Loan Disbursement Date");
        NewLoan."Recovered Loan" := Rec."Loan to Attach";
        NewLoan."Loan to Attach" := Rec."Loan to Attach";
        NewLoan.Posted := true;
        NewLoan."Loan Status" := NewLoan."Loan Status"::Issued;
        NewLoan.SOURCE := NewLoan.SOURCE::BOSA;

        NewLoan.Insert(true);

        exit(LoanNo);
    end;

    local procedure FnCreateLoanDetail(
        var Guarantor: Record "Loans Guarantee Details";
        DefaulterAmount: Decimal;
        DefaulterLoanNo: Code[20]
    )
    var
        LoanDetails: Record "Loan Member Loans";
    begin
        LoanDetails.Init();
        LoanDetails."Document No" := Rec."Document No";
        LoanDetails."Member No" := Rec."Member No";
        LoanDetails."Loan Type" := 'GUR';

        if LoanType.Get('GUR') then begin
            LoanDetails."Loan Instalments" := LoanType."No of Installment";
            LoanDetails."Interest Rate" := LoanType."Interest rate";
        end;

        LoanDetails."Approved Loan Amount" := Guarantor."Amont Guaranteed";
        LoanDetails."Guarantor Number" := Guarantor."Member No";
        LoanDetails."Loan No." := Guarantor."Loan No";
        LoanDetails."Amont Guaranteed" := Guarantor."Amont Guaranteed";
        LoanDetails."Outstanding Balance" := Guarantor."Outstanding Balance";
        LoanDetails."Outstanding Interest" := FnGetInterestForLoanToAttach();
        LoanDetails."Defaulter Loan" := DefaulterAmount;
        LoanDetails."Defaulter Loan No" := DefaulterLoanNo;

        LoanDetails.Insert(true);
    end;

    local procedure FnRunRecoverALLFromGuarantorsDeposits(VarDocumentNo: Code[20]; VarLoanNo: Code[20]; VarMemberNo: Code[20]; VarPostingDate: Date)
    var
        AmountToDeduct: Decimal;
        RunningBalance: Decimal;
        VarInsuranceAmounttoDeduct: Decimal;
        TotalAmountUsedFromDeposits: Decimal;
    begin

        // First, recover from loanee's own deposits
        if Rec."Current Shares" > 0 then begin
            LoanApp.Reset;
            LoanApp.SetRange(LoanApp."Loan  No.", VarLoanNo);
            if LoanApp.Find('-') then begin
                LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Interest");

                RunningBalance := Rec."Current Shares";

                // Pay interest first (if Add Interest is enabled)
                if (Rec."Add Interest" = true) and (LoanApp."Outstanding Interest" > 0) and (RunningBalance > 0) then begin
                    if LoanApp."Outstanding Interest" < RunningBalance then
                        AmountToDeduct := LoanApp."Outstanding Interest"
                    else
                        AmountToDeduct := RunningBalance;

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo,
                        GenJournalLine."transaction type"::"Interest Paid",
                        GenJournalLine."account type"::Customer, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'Interest Recovered From Own Deposits', VarLoanNo,
                        GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNo);

                    RunningBalance := RunningBalance - AmountToDeduct;
                end;

                // Pay principal
                if (LoanApp."Outstanding Balance" > 0) and (RunningBalance > 0) then begin
                    if LoanApp."Outstanding Balance" < RunningBalance then
                        AmountToDeduct := LoanApp."Outstanding Balance"
                    else
                        AmountToDeduct := RunningBalance;

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo,
                        GenJournalLine."transaction type"::"Loan Repayment",
                        GenJournalLine."account type"::Customer, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'Loan Recovered From Own Deposits', VarLoanNo,
                        GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNo);

                    RunningBalance := RunningBalance - AmountToDeduct;
                end;

                // Calculate actual amount used from deposits (not the full balance)
                TotalAmountUsedFromDeposits := Rec."Current Shares" - RunningBalance;

                // Debit loanee's deposits - only the actual amount used
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo,
                    GenJournalLine."transaction type"::"Deposit Contribution",
                    GenJournalLine."account type"::Customer, VarMemberNo, VarPostingDate, TotalAmountUsedFromDeposits, 'BOSA', EXTERNAL_DOC_NO,
                    'Loan Recovery From Own Deposits', '', GenJournalLine."Source Type"::" ");
            end;
        end;

        // Then, recover from other guarantors (excluding self-guarantors)
        ObjLoanGuarantors.Reset;
        ObjLoanGuarantors.SetRange("Document No", VarDocumentNo);
        if ObjLoanGuarantors.FindSet then begin
            repeat
                // Skip self guarantor - already posted above to avoid double posting
                if ObjLoanGuarantors."Self Guarantor" = false then begin
                    RunningBalance := ObjLoanGuarantors."Guarantor Amount Apportioned";

                    //============================================================Loan Interest Repayment (if Add Interest is enabled)
                    if (Rec."Add Interest" = true) and (RunningBalance > 0) then begin
                        LoanApp.Reset;
                        LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan to Attach");
                        LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
                        if LoanApp.Find('-') then begin
                            LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Interest");

                            AmountToDeduct := 0;
                            if LoanApp."Outstanding Interest" > 0 then begin
                                if LoanApp."Outstanding Interest" < RunningBalance then begin
                                    AmountToDeduct := LoanApp."Outstanding Interest"
                                end else
                                    AmountToDeduct := RunningBalance;

                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                GenJournalLine."account type"::Customer, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                                'Interest Recovered From_' + ObjLoanGuarantors."Member Name" + ' ' + ObjLoanGuarantors."Guarantor Number", VarLoanNo, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNo);

                                RunningBalance := RunningBalance - AmountToDeduct;
                                VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                            end;
                        end;
                    end;


                    //============================================================Loan Principle Repayment
                    if RunningBalance > 0 then begin
                        LoanApp.Reset;
                        LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan to Attach");
                        LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
                        if LoanApp.Find('-') then begin
                            LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Interest");
                            if RunningBalance > 0 then begin
                                AmountToDeduct := 0;
                                if LoanApp."Outstanding Balance" > 0 then begin
                                    if LoanApp."Outstanding Balance" < RunningBalance then begin
                                        AmountToDeduct := LoanApp."Outstanding Balance"
                                    end else
                                        AmountToDeduct := RunningBalance;

                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                    GenJournalLine."account type"::Customer, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                                    'Loan Recovered From_' + ObjLoanGuarantors."Member Name" + ObjLoanGuarantors."Guarantor Number", VarLoanNo, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNo);
                                    RunningBalance := RunningBalance - AmountToDeduct;
                                    VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                                end;
                            end;
                        end;
                    end;


                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                    GenJournalLine."account type"::Customer, ObjLoanGuarantors."Guarantor Number", VarPostingDate, ObjLoanGuarantors."Guarantor Amount Apportioned", 'BOSA', EXTERNAL_DOC_NO,
                    'Loan Recovery' + '-' + VarMemberNo + '-' + Rec."Member Name", '', GenJournalLine."Source Type"::" ");
                end;

                ObjLoanGuarantors.Posted := true;
                ObjLoanGuarantors."Posting Date" := VarPostingDate;
                ObjLoanGuarantors.Modify();

            until ObjLoanGuarantors.Next = 0;
        end;

        Commit;  // Ensure guarantor records are saved to database
    end;
}