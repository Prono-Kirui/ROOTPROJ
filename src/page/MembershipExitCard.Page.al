#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50409 "Membership Exit Card"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption';
    SourceTable = "Membership Exist";
    // SourceTableView = where(Posted = filter(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = MNoEditable;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Closing Date"; Rec."Closing Date")
                {
                    ApplicationArea = Basic;
                    Editable = ClosingDateEditable;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Closure Type"; Rec."Closure Type")
                {
                    ApplicationArea = Basic;
                    Editable = ClosureTypeEditable;
                }
                field("Sell Share Capital"; Rec."Sell Share Capital")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin

                        ShareCapitalTransferVisible := false;
                        ShareCapSellPageVisible := false;
                        if Rec."Sell Share Capital" = true then begin
                            ShareCapitalTransferVisible := true;
                            ShareCapSellPageVisible := true;
                        end;
                        UpdateControl();
                    end;
                }
                field("Total Loan"; Rec."Total Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Loan BOSA';
                    Editable = false;
                }
                field("Total Interest"; Rec."Total Interest")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Interest Due BOSA';
                    Editable = false;
                }
                field("Total Loans FOSA"; Rec."Total Loans FOSA")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Oustanding Int FOSA"; Rec."Total Oustanding Int FOSA")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Interest Due FOSA';
                    Editable = false;
                }
                field("Member Deposits"; Rec."Member Deposits")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Share Capital"; Rec."Share Capital")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member Liability"; Rec."Member Liability")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Share Capital to Sell"; Rec."Share Capital to Sell")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Risk Fund"; Rec."Risk Fund")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Risk Fund Arrears"; Rec."Risk Fund Arrears")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Risk Beneficiary"; Rec."Risk Beneficiary")
                {
                    ApplicationArea = Basic;
                }
                field("Mode Of Disbursement"; Rec."Mode Of Disbursement")
                {
                    ApplicationArea = Basic;
                }
                field("Paying Bank"; Rec."Paying Bank")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field("FOSA Account No."; Rec."FOSA Account No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = Basic;
                }
            }
            group("Share Capital Transfer Details")
            {
                Caption = 'Share Capital Transfer Details';
                Visible = ShareCapitalTransferVisible;
                field("Share Capital Transfer Fee"; Rec."Share Capital Transfer Fee")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part("Share Capital Sell"; "Share Capital Sell")
            {
                SubPageLink = "Document No" = field("No."),
                              "Selling Member No" = field("Member No."),
                              "Selling Member Name" = field("Member Name");
                Visible = ShareCapSellPageVisible;
            }
        }
        area(factboxes)
        {
            part(Control24; "Member Statistics FactBox")
            {
                Caption = 'Member Statistics FactBox';
                SubPageLink = "No." = field("Member No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                action("Member is  a Guarantor")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Guaranteed';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        cust.Reset;
                        cust.SetRange(cust."No.", Rec."Member No.");
                        if cust.Find('-') then
                            Report.Run(50503, true, false, cust);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::MembershipWithdrawal;
                        ApprovalEntries.Setfilters(Database::"Membership Exist", DocumentType, Rec."No.");
                        ApprovalEntries.Run;
                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        text001: label 'This batch is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if (Rec."Closure Type" = Rec."closure type"::"Member Exit - Normal") and (Rec."Member Liability" > 0) then
                            Error('Member has Liability of Ksh. %1 for Loans Guaranteed. Member Exit cannot be processed at the moment.', Rec."Member Liability");

                        if Rec.Status <> Rec.Status::Open then
                            Error(text001);
                        Rec.Status := Rec.Status::Approved;
                        Rec.Modify();

                        if Confirm('Send Approval Request for Membership Exit %1 ', false, Rec."Member Name") = false then begin
                            Message('Cancelled');
                            exit;
                        end
                        else begin
                            // Rec.Status := Rec.Status::Approved;
                            //Rec.Modify();
                            ApprovalsCodeUnit.SendMembershipExistForApproval(Rec."No.", Rec);

                        end;

                        GenSetUp.Get();

                        if Generalsetup."Send Membership Withdrawal SMS" = true then begin
                            FnSendWithdrawalApplicationSMS();
                        end;

                        FnRunCreateHouseGroupExitApplication;//===================================================================Exit Member From Group
                        CurrPage.Close();
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel A&pproval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        text001: label 'This batch is already pending approval';
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        if Rec.Status <> Rec.Status::Open then
                            Error(text001);

                        ApprovalsCodeUnit.CancelMembershipExistForApproval(Rec."No.", Rec);
                    end;
                }
                action("Account closure Slip")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        cust.Reset;
                        cust.SetRange(cust."No.", Rec."Member No.");
                        if cust.Find('-') then
                            Report.Run(50474, true, false, cust);
                    end;
                }

                action("Post Membership Exit")
                {
                    ApplicationArea = Basic;
                    Image = PostDocument;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        VarExitType: Option "Member Exit - Normal","Member Exit - Deceased";
                    begin
                        // Rec.TESTFIELD(Status, Rec.Status::Approved);

                        Rec.TESTFIELD("Paying Bank");

                        IF CONFIRM('Are you absolutely sure you want to recover the loans from member deposit') = FALSE THEN
                            EXIT;
                        //Delete journal line
                        Gnljnline.RESET;
                        Gnljnline.SETRANGE("Journal Template Name", 'GENERAL');
                        Gnljnline.SETRANGE("Journal Batch Name", 'ClOSURE');
                        Gnljnline.DELETEALL;
                        //End of deletion
                        //GETTING WITHDRWAL FEE
                        Generalsetup.GET();
                        Totalrecovered := 0;
                        TotalInsuarance := 0;

                        DActivity := cust."Global Dimension 1 Code";
                        DBranch := 'NAIROBI';
                        IF Rec."Net Payable to the Member" < 0 THEN
                            ERROR('The Member Does have enough Deposits to Clear Loans');
                        IF cust.GET(Rec."Member No.") THEN BEGIN
                            IF (Rec."Closure Type" = Rec."Closure Type"::"Member Exit - Normal") THEN BEGIN
                                cust.CALCFIELDS("Outstanding Balance", "Outstanding Interest");
                                IF (cust."Outstanding Balance" + cust."Outstanding Interest") > 0 THEN
                                    ERROR('You must Recover Member Loans Before Proceeding to Post Exit');
                                cust."Withdrawal Fee" := 0;

                                cust.CALCFIELDS(cust."Outstanding Balance", "Accrued Interest", "Current Shares");

                                cust.CALCFIELDS(cust."Outstanding Balance", cust."Outstanding Interest", "FOSA Outstanding Balance", "Accrued Interest", "Insurance Fund", "Current Shares");
                                TotalOustanding := cust."Outstanding Balance" + cust."Outstanding Interest";
                            end;
                            IF Rec."Closure Type" = Rec."Closure Type"::"Member Exit - Normal" THEN BEGIN
                                FnRunPostNormalExitApplication(Rec."Member No.");
                            end else
                                IF Rec."Closure Type" = Rec."Closure Type"::"Member Exit - Deceased" THEN BEGIN
                                    Message('"Member Deposits" is %1', Rec."Member Deposits");
                                    //Transfer Deposits
                                    LineNo := LineNo + 10000;
                                    GenJournalLine.INIT;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'CLOSURE';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Document No." := Rec."No.";
                                    GenJournalLine."Posting Date" := Rec."Posting Date";
                                    GenJournalLine."External Document No." := Rec."No.";

                                    GenJournalLine."Account Type" := Rec."Mode Of Disbursement";
                                    GenJournalLine."Account No." := Rec."Paying Bank";
                                    GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                    GenJournalLine.Description := 'Member Withdrawal' + ' ' + Rec."Member No.";
                                    GenJournalLine.Amount := -(Rec."Member Deposits");
                                    GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                    //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                    //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                    IF GenJournalLine.Amount <> 0 THEN
                                        GenJournalLine.INSERT;



                                    //Deposit
                                    LineNo := LineNo + 10000;
                                    GenJournalLine.INIT;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'CLOSURE';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Document No." := Rec."No.";
                                    GenJournalLine."Posting Date" := Rec."Posting Date";
                                    GenJournalLine."External Document No." := Rec."No.";
                                    GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
                                    GenJournalLine."Account No." := Rec."Member No.";
                                    GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                    GenJournalLine.Description := 'Membership Closure';
                                    GenJournalLine.Amount := Rec."Member Deposits";
                                    GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                    GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Deposit Contribution";
                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                    //  GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                    // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                    IF GenJournalLine.Amount <> 0 THEN
                                        GenJournalLine.INSERT;

                                end;

                        end;
                        // case VarExitType of
                        //     // Varexittype::"Member Exit - Normal":
                        //     //     FnRunPostNormalExitApplication(Rec."Member No.");


                        //     Varexittype::"Member Exit - Deceased":
                        //         FnRunPostExitDeceasedApplication(Rec."Member No.");
                        // end;
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'CLOSURE');
                        if GenJournalLine.Find('-') then
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco21", GenJournalLine);

                        ObjMember.CalcFields(ObjMember."Shares Retained", ObjMember."Current Shares");
                        if ObjMember.Get(Rec."Member No.") then begin
                            ObjMember.Status := ObjMember.Status::Blocked;
                            ObjMember.Blocked := ObjMember.Blocked::All;

                            if ObjMember."Shares Retained" = 0 then
                                ObjMember."Share Capital No" := '';


                            ObjMember.Modify;
                        end;


                        Rec.Posted := true;
                        Rec.Modify();
                        Message('Membership Exit Application Posted Successfully');
                        CurrPage.Close();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
    end;

    trigger OnAfterGetRecord()
    begin
        ShareCapitalTransferVisible := false;
        ShareCapSellPageVisible := false;
        if Rec."Sell Share Capital" = true then begin
            ShareCapitalTransferVisible := true;
            ShareCapSellPageVisible := true;
        end;

        UpdateControl();
    end;

    trigger OnOpenPage()
    begin
        ShareCapitalTransferVisible := false;
        ShareCapSellPageVisible := false;
        PostingDateEditable := false;
        if Rec."Sell Share Capital" = true then begin
            ShareCapitalTransferVisible := true;
            ShareCapSellPageVisible := true;
        end;
        UpdateControl();
    end;

    var
        Jtemplate: Code[200];
        Jbatch: Code[200];
        ApprovalsCodeUnit: Codeunit "Micropoint ApprovalsCodeUnit";
        Closure: Integer;
        Text001: label 'Not Approved';
        cust: Record customer;
        UBFRefund: Decimal;
        Generalsetup: Record "Sacco General Set-Up";
        Totalavailable: Decimal;
        UnpaidDividends: Decimal;
        TotalOustanding: Decimal;
        Vend: Record Vendor;
        value2: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        Totalrecovered: Decimal;
        Advice: Boolean;
        TotalDefaulterR: Decimal;
        AvailableShares: Decimal;
        Loans: Record "Loans Register";
        Value1: Decimal;
        Interest: Decimal;
        LineN: Integer;
        LRepayment: Decimal;
        Vendno: Code[20];
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval;
        MNoEditable: Boolean;
        ClosingDateEditable: Boolean;
        ClosureTypeEditable: Boolean;
        PostingDateEditable: Boolean;
        TotalFOSALoan: Decimal;
        TotalInsuarance: Decimal;
        DActivity: Code[30];
        DBranch: Code[30];
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        "Remaining Amount": Decimal;
        LoansR: Record "Loans Register";
        "AMOUNTTO BE RECOVERED": Decimal;
        PrincipInt: Decimal;
        TotalLoansOut: Decimal;
        ClosureR: Record "Membership Exist";
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval;
        PTEN: Text;
        DataSheet: Record "Data Sheet Main";
        Customer: Record customer;
        GenSetUp: Record "Sacco General Set-Up";
        compinfo: Record "Company Information";
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        ShareCapitalTransferVisible: Boolean;
        ShareCapSellPageVisible: Boolean;
        ObjShareCapSell: Record "Share Capital Sell";
        MicropointFactory: Codeunit "Micropoint Factory";
        JVTransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares";
        JVAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Member,Investor;
        TemplateName: Code[20];
        BatchName: Code[20];
        JVBalAccounttype: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        JVBalAccountNo: Code[20];
        TransferFee: Decimal;
        AvailableBal: Decimal;
        ObjMember: Record customer;
        VarMemberAvailableAmount: Decimal;
        ObjCust: Record customer;
        ObjGensetup: Record "Sacco General Set-Up";
        VarWithdrawalFee: Decimal;
        VarTaxonWithdrawalFee: Decimal;
        VarShareCapSellFee: Decimal;
        VarTaxonShareCapSellFee: Decimal;
        ObjNoSeries: Record "Sacco No. Series";
        VarDocumentNo: Code[30];
        // ObjHouseChangeAppl: Record "House Group Change Request";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        VarShareCapitalFee: Decimal;


    procedure UpdateControl()
    begin
        if Rec.Status = Rec.Status::Open then begin
            MNoEditable := true;
            ClosingDateEditable := false;
            ClosureTypeEditable := true;
            PostingDateEditable := false;
        end;

        if Rec.Status = Rec.Status::Pending then begin
            MNoEditable := false;
            ClosingDateEditable := false;
            ClosureTypeEditable := false;
            PostingDateEditable := false;
        end;

        if Rec.Status = Rec.Status::Rejected then begin
            MNoEditable := false;
            ClosingDateEditable := false;
            ClosureTypeEditable := false;
            PostingDateEditable := false;
        end;

        if Rec.Status = Rec.Status::Approved then begin
            MNoEditable := false;
            ClosingDateEditable := true;
            ClosureTypeEditable := false;
            PostingDateEditable := true;
        end;
    end;


    procedure FnSendWithdrawalApplicationSMS()
    begin
        GenSetUp.Get;
        compinfo.Get;

        //SMS MESSAGE
        SMSMessage.Reset;
        if SMSMessage.Find('+') then begin
            iEntryNo := SMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;

        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        SMSMessage."Batch No" := Rec."No.";
        SMSMessage."Document No" := Rec."No.";
        SMSMessage."Account No" := Rec."Member No.";
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := 'MEMBERSHIPWITH';
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := 'Dear Member,Your Membership Withdrawal Application has been received and is being Processed '
        + compinfo.Name + ' ' + GenSetUp."Customer Care No";
        cust.Reset;
        cust.SetRange(cust."No.", Rec."Member No.");
        if cust.Find('-') then begin
            SMSMessage."Telephone No" := cust."Mobile Phone No";
        end;
        if cust."Mobile Phone No" <> '' then
            SMSMessage.Insert;
    end;

    local procedure FnRunPostShareCapSell()
    var
        VarBuyerMemberNos: Code[50];
    begin
        TemplateName := 'GENERAL';
        BatchName := 'CLOSURE';

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", TemplateName);
        GenJournalLine.SetRange("Journal Batch Name", BatchName);
        GenJournalLine.DeleteAll;

        if ObjMember.Get(Rec."Member No.") then begin
            //=========================================================================================================Credit Buyer Account
            ObjShareCapSell.Reset;
            ObjShareCapSell.SetRange(ObjShareCapSell."Document No", Rec."No.");
            if ObjShareCapSell.FindSet then begin
                repeat
                    LineNo := LineNo + 10000;
                    MicropointFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Rec."No.", LineNo, GenJournalLine."transaction type"::"Share Capital",
                    GenJournalLine."account type"::Customer, ObjShareCapSell."Buyer Share Capital Account", Rec."Posting Date",
                    (ObjShareCapSell.Amount * -1), 'BOSA', Rec."No.", 'Share Capital Purchase From ' + Format(ObjShareCapSell."Selling Member No"), '', GenJournalLine."Source Type"::" ");
                    VarBuyerMemberNos := VarBuyerMemberNos + ObjShareCapSell."Buyer Member No" + ', ';

                    //***************************
                    LineNo := LineNo + 10000;
                    MicropointFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Rec."No.", LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Customer, ObjShareCapSell."Buyer Member No", Rec."Posting Date",
                    (ObjShareCapSell.Amount), 'FOSA', Rec."No.", 'Share Capital Purchase From ' + Format(ObjShareCapSell."Selling Member No"), '', GenJournalLine."Source Type"::" ");

                until ObjShareCapSell.Next = 0;
            end;




            LineNo := LineNo + 10000;
            //========================================================================================================Post Transfer Fee
            Generalsetup.Get();
            MicropointFactory.FnCreateGnlJournalLineBalanced(TemplateName, BatchName, Rec."No.", LineNo, GenJournalLine."transaction type"::"Deposit Contribution", GenJournalLine."account type"::customer, Rec."FOSA Account No.", Rec."Posting Date"
            , 'Share Capital Transfer Fee ' + Format(Rec."Member No."), GenJournalLine."bal. account type"::"G/L Account", Generalsetup."Share Capital Transfer Fee Acc", (Rec."Share Capital Transfer Fee"), 'BOSA', '');
            //========================================================================================================Post JV

            LineNo := LineNo + 10000;
            //==========================================================================================================Post Transfer Fee Excise Duty
            Generalsetup.Get();
            MicropointFactory.FnCreateGnlJournalLineBalanced(TemplateName, BatchName, Rec."No.", LineNo, GenJournalLine."transaction type"::"Deposit Contribution", GenJournalLine."account type"::Customer, Rec."Member No.", Rec."Posting Date"
            , 'Tax: Share Capital Transfer Fee ' + Format(Rec."Member No."), GenJournalLine."bal. account type"::"G/L Account", Generalsetup."Excise Duty Account", (Rec."Share Capital Transfer Fee" * (Generalsetup."Excise Duty(%)" / 100)), 'BOSA', '');
            //==========================================================================================================Post Transfer Fee Excise Duty
        end;
    end;

    local procedure FnRunCreateHouseGroupExitApplication()
    begin
        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", Rec."Member No.");
        ObjMember.SetRange(ObjMember."House Group Status", ObjMember."house group status"::Active);
        if ObjMember.FindSet then begin
            if ObjNoSeries.Get then begin
                ObjNoSeries.TestField(ObjNoSeries."House Change Request No");
                VarDocumentNo := NoSeriesMgt.GetNextNo(ObjNoSeries."House Change Request No", 0D, true);
                if VarDocumentNo <> '' then begin
                    // ObjHouseChangeAppl.Init;
                    // ObjHouseChangeAppl."Document No" := VarDocumentNo;
                    // ObjHouseChangeAppl."Member No" := ObjMember."No.";
                    // ObjHouseChangeAppl."Member Name" := ObjMember.Name;
                    // ObjHouseChangeAppl."House Group" := ObjMember."Member House Group";
                    // ObjHouseChangeAppl."House Group Name" := ObjMember."Member House Group Name";
                    // ObjHouseChangeAppl."Reason For Changing Groups" := 'Triggered By Membership Exit';
                    // ObjHouseChangeAppl."Date Group Changed" := WorkDate;
                    // ObjHouseChangeAppl."Changed By" := UserId;
                    // ObjHouseChangeAppl."Change Type" := ObjHouseChangeAppl."change type"::"Remove From Group";
                    // ObjHouseChangeAppl.Insert;

                    // ObjHouseChangeAppl.Validate(ObjHouseChangeAppl."Member No");
                    // ObjHouseChangeAppl.Modify;
                    Rec."House Group Exit Application" := VarDocumentNo;
                end;
            end;
        end;
    end;

    local procedure FnEffectHouseGroupExit()
    begin
        // ObjHouseChangeAppl.Reset;
        // ObjHouseChangeAppl.SetRange(ObjHouseChangeAppl."Document No", Rec."House Group Exit Application");
        // if ObjHouseChangeAppl.FindSet then begin
        //     if ObjCust.Get(ObjHouseChangeAppl."Member No") then begin
        //         ObjCust."Member House Group" := ObjHouseChangeAppl."Destination Cell";
        //         ObjCust."Member House Group Name" := ObjHouseChangeAppl."Destination Cell Group";
        //         ObjCust."House Group Status" := ObjCust."house group status"::Active;
        //         ObjHouseChangeAppl."Date Group Changed" := Today;
        //         ObjHouseChangeAppl."Changed By" := UserId;
        //         ObjHouseChangeAppl."Change Effected" := true;
        //         ObjCust.Modify;
        //         ObjHouseChangeAppl.Modify;
        //     end;
        // end;
    end;

    local procedure FnRunPostNormalExitApplication(VarMemberNo: Code[30])
    var
        ObjGensetup: Record "Sacco General Set-Up";
        ObjMember: Record customer;
        VarRunningBal: Decimal;
        ObjLoans: Record "Loans Register";
        ObjLoansII: Record "Loans Register";
        VarCurrentPayOff: Decimal;
        SFactory: Codeunit "Micropoint Factory";
        VarMemberTotalLoanLiability: Decimal;
        VarMembershipExitFee: Decimal;
        VarMemberTotalLiability: Decimal;
        VarMemberAvailableBal: Decimal;
        VarAmounttoDeduct: Decimal;
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        VarMembershipExit: Decimal;
        VarTaxOnExitFee: Decimal;
        VarAmounttoTransfertoFOSA: Decimal;
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";

        AmountToDeduct: Decimal;
        LineNo: Integer;
        RunBalance: Decimal;
    begin
        Generalsetup.Get();
        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", VarMemberNo);
        if ObjMember.FindSet then begin
            ObjMember.CalcFields(ObjMember."Current Shares", ObjMember."Shares Retained");
            ObjGensetup.Get;

            VarMemberAvailableBal := ObjMember."Current Shares";
            //Message('Available Balance is %1', VarMemberAvailableBal);
            VarMembershipExit := ObjGensetup."Withdrawal Fee";
            VarTaxOnExitFee := VarMembershipExit * (ObjGensetup."Excise Duty(%)" / 100);
            VarMembershipExitFee := VarMembershipExit + VarTaxOnExitFee;
            VarAmounttoTransfertoFOSA := VarMemberAvailableBal - VarMembershipExitFee;
            /// Message('Amount to VarMembershipExitFee is %1', VarMembershipExitFee);

            if Rec."Sell Share Capital" = true then begin
                VarShareCapitalFee := ObjGensetup."Share Capital Transfer Fee";
                VarShareCapitalFee := VarShareCapitalFee + (VarShareCapitalFee * (ObjGensetup."Excise Duty(%)" / 100));
            end;

            VarAmounttoTransfertoFOSA := VarMemberAvailableBal - VarMembershipExitFee - VarShareCapitalFee;

            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
            ObjLoans.Reset;
            ObjLoans.SetRange(ObjLoans."Client Code", VarMemberNo);
            ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
            if ObjLoans.FindSet then begin
                repeat
                    VarCurrentPayOff := SFactory.FnRunGetLoanPayoffAmount(ObjLoans."Loan  No.");
                    Message('Current Payoff is %1 for Loan %2', VarCurrentPayOff, ObjLoans."Loan  No.");
                    VarMemberTotalLoanLiability := VarMemberTotalLoanLiability + VarCurrentPayOff;
                until ObjLoans.Next = 0;
            end;
            VarMemberTotalLiability := VarMemberTotalLoanLiability + VarMembershipExitFee;
            Message('Total Liability is %1', VarMemberTotalLiability);

            if VarMemberTotalLiability > VarMemberAvailableBal then
                Error('Members Deposits is not enough to Clear Liability. Member Deposits # %1 Member Liability # %2', VarMemberAvailableBal, VarMemberTotalLiability);

            BATCH_TEMPLATE := 'GENERAL';
            BATCH_NAME := 'CLOSURE';
            DOCUMENT_NO := Rec."No.";

            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
            GenJournalLine.DeleteAll;

            VarMembershipExit := Rec."Member Deposits";
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
            GenJournalLine."account type"::Customer, VarMemberNo, Rec."Posting Date", VarMembershipExit, 'BOSA', '',
            'Membership Exit: ' + Rec."No.", '', GenJournalLine."Source Type"::" ");


            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", ObjGensetup."Withdrawal Fee Account", Rec."Posting Date", Generalsetup."Withdrawal Fee" * -1, 'BOSA', '',
            'Membership Exit Fee For ' + Rec."Member No.", '', GenJournalLine."Source Type"::" ");
            VarMembershipExit := VarMembershipExit - (Generalsetup."Withdrawal Fee");
            if VarMembershipExit > 0 then
                LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", ObjGensetup."Excise Duty Account", Rec."Posting Date", VarTaxOnExitFee * -1, 'BOSA', '',
            'Membership Exit Fee Tax For ' + Rec."Member No.", '', GenJournalLine."Source Type"::" ");
            VarMembershipExit := VarMembershipExit - (VarTaxOnExitFee);

            //============================================================================================================Post Loans Clearance

            if VarMembershipExit > 0 then begin
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans."Client Code", VarMemberNo);
                ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
                if ObjLoans.FindSet then begin
                    repeat
                        Message('Found Loan: ' + ObjLoans."Loan  No.");
                        VarCurrentPayOff := SFactory.FnRunGetLoanPayoffAmount(ObjLoans."Loan  No.");
                        if VarCurrentPayOff > VarMembershipExit then
                            VarCurrentPayOff := VarMembershipExit;
                        //============================================================================================================Post Loans Clearance
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                        GenJournalLine."account type"::Customer, VarMemberNo, Rec."Posting Date", VarCurrentPayOff * -1, 'BOSA', '',
                        'Loan Payoff: ' + ObjLoans."Loan  No.", ObjLoans."Loan  No.", GenJournalLine."Source Type"::" ");
                        VarMembershipExit := VarMembershipExit - (VarCurrentPayOff);
                        //============================================================================================================End Post Loans Clearance
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                        GenJournalLine."account type"::Customer, VarMemberNo, Rec."Posting Date", VarMembershipExit * -1, 'BOSA', '',
                        'Loan Payoff: ' + ObjLoans."Loan  No.", ObjLoans."Loan  No.", GenJournalLine."Source Type"::" ");
                        VarMembershipExit := VarMembershipExit - (VarMembershipExit);



                    // LineNo := LineNo + 10000;
                    // SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                    // GenJournalLine."account type"::Customer, VarMemberNo, WorkDate, VarCurrentPayOff, 'BOSA', '',
                    // 'Loan Payoff For ' + ObjLoans."Loan  No.", '', GenJournalLine."Source Type"::" ");
                    //============================================================================================================End Post Loans Clearance
                    until ObjLoans.Next = 0;
                end;
                //============================================================================================================Post Loans Clearance

            end;

            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"Bank Account", Rec."Paying Bank", Rec."Posting Date", VarMembershipExit * -1, 'BOSA', '',
            'Membership Exit For ' + Rec."Member No.", '', GenJournalLine."Source Type"::" ");

            //============================================================================================================End Post Membership Exit Fee

            //===========================================================================================================Post Remaining Amount to FOSA

            //=========================================================================================================Credit Buyer Account
            if Rec."Sell Share Capital" = true then begin
                RunBalance := 0;
                ObjShareCapSell.Reset;
                ObjShareCapSell.SetRange(ObjShareCapSell."Document No", Rec."No.");
                if ObjShareCapSell.FindSet then begin

                    //DR Person Transferring
                    LineNo := LineNo + 1000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Share Capital",
                    GenJournalLine."account type"::Customer, Rec."Member No.", Rec."Posting Date", Rec."Share Capital", 'BOSA', '',
                    'Exit Share Transfer Charges ' + Rec."Member No.", '', GenJournalLine."Source Type"::" ");
                    repeat
                        RunBalance := RunBalance + Rec."Share Capital";
                        // charge to Member transferring
                        if Rec."Share Capital Transfer Fee" > 0 then begin
                            LineNo := LineNo + 1000;

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Share Capital",
                            GenJournalLine."account type"::"G/L Account", Generalsetup."Share Capital Transfer Fee Acc", Rec."Posting Date", (Rec."Share Capital Transfer Fee" * -1), 'BOSA', '',
                            'Share Transfer Charges: ' + Rec."No.", '', GenJournalLine."Source Type"::" ");

                            RunBalance := RunBalance - Rec."Share Capital Transfer Fee";
                        end;
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Share Capital",
                        GenJournalLine."account type"::Customer, ObjShareCapSell."Buyer Member No", Rec."Posting Date", (RunBalance * -1), 'BOSA', '',
                        'Share Transfer Charges: ' + Rec."No.", '', GenJournalLine."Source Type"::" ");
                    //         // CU posting
                    //         // GenJournalLine.Reset;
                    //         // GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    //         // GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    //         // if GenJournalLine.Find('-') then
                    //         //     Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco21", GenJournalLine);

                    until ObjShareCapSell.Next = 0;
                end;

            end;
            ///************************************************************************end share capital sell fee

            // CU posting
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
            if GenJournalLine.Find('-') then
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco21", GenJournalLine);



        end;

        ObjMember.CalcFields(ObjMember."Shares Retained", ObjMember."Current Shares");
        if ObjMember.Get(VarMemberNo) then begin
            ObjMember.Status := ObjMember.Status::Blocked;
            ObjMember.Blocked := ObjMember.Blocked::All;

            if ObjMember."Shares Retained" = 0 then
                ObjMember."Share Capital No" := '';

            if ObjMember."Current Shares" = 0 then
                VarMemberNo := '';
            ObjMember.Modify;
        end;

        Message('Membership Exit Process Completed Successfully');
        CurrPage.Close();
    end;

    local procedure FnRunPostExitDeceasedApplication(VarMemberNo: Code[30])
    var
        ObjGensetup: Record "Sacco General Set-Up";
        ObjMember: Record customer;
        VarRunningBal: Decimal;
        ObjLoans: Record "Loans Register";
        ObjLoansII: Record "Loans Register";
        VarCurrentPayOff: Decimal;
        SFactory: Codeunit "Micropoint Factory";
        VarMemberTotalLoanLiability: Decimal;
        VarMembershipExitFee: Decimal;
        VarMemberTotalLiability: Decimal;
        VarMemberAvailableBal: Decimal;
        VarAmounttoDeduct: Decimal;
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        VarMembershipExit: Decimal;
        VarTaxOnExitFee: Decimal;
        VarAmounttoTransfertoFOSA: Decimal;
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
    begin
        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", VarMemberNo);
        if ObjMember.FindSet then begin
            ObjMember.CalcFields(ObjMember."Current Shares", ObjMember."Shares Retained");
            ObjGensetup.Get;

            VarAmounttoTransfertoFOSA := ObjMember."Current Shares";
            Message('Amount to Pay is %1', VarAmounttoTransfertoFOSA);


            BATCH_TEMPLATE := 'GENERAL';
            BATCH_NAME := 'CLOSURE';
            DOCUMENT_NO := Rec."No.";

            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
            GenJournalLine.DeleteAll;



            //===========================================================================================================Post Remaining Amount to FOSA
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
            GenJournalLine."account type"::Customer, VarMemberNo, Rec."Closing Date", VarAmounttoTransfertoFOSA, 'BOSA', '',
            'Membership Exit Deposit Transfer: ' + Rec."No.", '', GenJournalLine."Source Type"::" ");

            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
            GenJournalLine."account type"::"Bank Account", Rec."Paying Bank", Rec."Closing Date", VarAmounttoTransfertoFOSA * -1, 'BOSA', '',
            'Membership Exit Deposit Transfer: ' + Rec."No.", '', GenJournalLine."Source Type"::" ");

            //===========================================================================================================Post Remaining Amount to FOSA

            //CU posting
            // GenJournalLine.Reset;
            // GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
            // GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
            // if GenJournalLine.Find('-') then
            //     Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco21", GenJournalLine);







        end;

        // if ObjMember.Get(VarMemberNo) then begin
        //     ObjMember.Status := ObjMember.Status::Blocked;
        //     ObjMember.Blocked := ObjMember.Blocked::All;
        //     ObjMember.Modify;
        // end;
    end;

}

