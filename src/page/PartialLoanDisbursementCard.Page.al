page 50146 "Partial Loan Disbursement Card"
{
    ApplicationArea = All;
    Caption = 'Partial Loan Disbursement Card';
    PageType = Card;
    InsertAllowed = true;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Partial Loan Disbursments";

    layout
    {
        area(content)
        {
            group("Tranche Disbursement Details")
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Client Code"; Rec."Client Code")
                {
                    ApplicationArea = Basic;
                    Enabled = EnableClientCode;
                }
                field("Client Name"; Rec."Client Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Partial Loan No.';
                    Enabled = PartialLoanNoEnabled;

                    trigger OnValidate()
                    var
                        LoansRegTable: record "Loans Register";
                        PartialLoanTable: record "Partial Loan Disbursments";
                    begin
                        LoansRegTable.Reset();
                        LoansRegTable.SetRange(LoansRegTable."Loan  No.", Rec."Loan No");
                        if LoansRegTable.Find('-') then begin
                            PartialLoanTable.Reset();
                            PartialLoanTable.SetRange(PartialLoanTable."Loan No", Rec."Loan No");
                            PartialLoanTable.SetRange(PartialLoanTable.Posted, true);
                            if PartialLoanTable.FindLast() then begin
                                Rec."New Loan Installements" := LoansRegTable.Installments - Round((Today - PartialLoanTable."Date Disbursed") / 30, 1, '=');
                            end
                            else begin
                                LoansRegTable.Reset();
                                LoansRegTable.SetRange(LoansRegTable."Loan  No.", Rec."Loan No");
                                if LoansRegTable.Find('-') then begin
                                    Rec."New Loan Installements" := LoansRegTable.Installments;
                                end;
                            end;


                            Rec.Modify();
                        end;
                        Rec."New Loan Installements" := Rec."New Loan Installements";
                        Rec.Modify();
                    end;
                }
                field("Paying Bank Account No"; Rec."Paying Bank Account No")
                {
                    ApplicationArea = Basic;
                    // Editable = false;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        if StrLen(Rec."Cheque No.") > 6 then
                            Error('Document No. cannot contain More than 6 Characters.');
                    end;
                }
                field(Charge; Rec.Charge)
                {
                    ApplicationArea = Basic;
                    Caption = 'Charge';
                }
                field("Mode of Disbursement"; Rec."Mode of Disbursement")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Enabled = PartialLoanNoEnabled;
                }
                field("Amount To Disburse"; Rec."Amount To Disburse")
                {
                    ApplicationArea = Basic;
                    Enabled = PartialLoanNoEnabled;
                }
                field("Total Disbursed Amount"; Rec."Total Disbursed Amount")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Style = Unfavorable;
                }
                field("Remaining Amount To Disburse"; Rec."Remaining Amount To Disburse")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Style = Unfavorable;
                }
                field("Disbursement Number"; Rec."Disbursement Number")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Date Disbursed"; Rec."Date Disbursed")
                {
                    ApplicationArea = Basic;
                    // Enabled = false;
                    Caption = 'Trunch Disbursement Date';
                    ShowMandatory = true;
                }
            }
            group(General)
            {
                Caption = 'General Loan Details';
                Editable = false;
                Enabled = false;

                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                    Editable = false;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                    end;
                }
                field("Loan Installements"; Rec."Loan Installements")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Loan Interest"; Rec."Loan Interest")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Interest Rate';
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount Applied';
                    Editable = AppliedAmountEditable;
                    ShowMandatory = true;
                    Style = Strong;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Amount';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Loan offset Amount"; Rec."Loan offset Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Offset Amount';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Main Sector"; Rec."Main Sector")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Style = Ambiguous;
                    Editable = false;
                }
                field("Sub-Sector"; Rec."Sub-Sector")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Style = Ambiguous;
                    Editable = MNoEditable;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Specific Sector"; Rec."Specific Sector")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                    Style = Ambiguous;
                    Editable = MNoEditable;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Recovery Mode"; Rec."Recovery Mode")
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                    ShowMandatory = true;
                    Editable = false;
                }
            }
            part(Control1000000004; "Disbursed Loan Trunches")
            {
                Caption = 'Disbursed Loan Trunches';
                SubPageLink = "Loan No" = field("Loan No");
                Editable = false;
            }
        }
        area(factboxes)
        {
            part("Member Statistics FactBox"; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("Client Code");
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group(Loan)
            {
                action("POST")
                {
                    Caption = 'POST Trunch Loan';
                    Enabled = POSTLoan;
                    Image = PrepaymentPostPrint;
                    PromotedIsBig = true;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        If FnCanPostLoans(UserId) = false then begin
                            Error('Prohibited ! You are not allowed to POST this Loan');
                        end;
                        if Rec."Mode of Disbursement" <> Rec."Mode of Disbursement"::"Tranche/Multiple Disbursement" then begin
                            Error('Prohibited ! Mode of disbursement cannot be ' + Format(Rec."Mode of Disbursement"));
                        end;
                        if Rec.Posted = true then begin
                            Error('Prohibited ! The Trunch is already Posted');
                        end;
                        if Rec."Approval Status" <> Rec."Approval Status"::Approved then begin
                            Error('Prohibited ! The Trunch Status MUST be Approved');
                        end;
                        if Confirm('Are you sure you want to POST partial trunch amount of Ksh. ' + Format(Rec."Amount To Disburse") + ' to member -' + Format(Rec."Client Name") + ' ?', false) = false then begin
                            exit;
                        end
                        else begin
                            if Template.Get(UserId) then begin
                                TemplateName := Template."Loan Template Name";
                                BatchName := Template."Loan Batch Name";
                            end
                            else begin
                                Error('You must setup your General Journal Template and Batch Names in User Template Setup');
                            end;

                            LoanApps.Reset();
                            LoanApps.SetRange(LoanApps."Loan  No.", Rec."Loan No");
                            if LoanApps.Find('-') then begin
                                LoanApps.Installments := Rec."New Loan Installements";
                                LoanApps."Loan Disbursement Date" := Today;
                                if Date2dmy(LoanApps."Loan Disbursement Date", 1) <= 15 then begin
                                    LoanApps."Repayment Start Date" := CalcDate('CM', LoanApps."Loan Disbursement Date");
                                end
                                else begin
                                    LoanApps."Repayment Start Date" := CalcDate('CM', CalcDate('CM+1M', LoanApps."Loan Disbursement Date"));
                                end;
                                LoanApps."Expected Date of Completion" := CalcDate('CM', CalcDate('CM+' + Format(LoanApps.Installments) + 'M', LoanApps."Loan Disbursement Date"));
                                LoanApps.Modify();
                            end;

                            LoanApps.Reset;
                            LoanApps.SetRange(LoanApps."Loan  No.", Rec."Loan No");
                            if LoanApps.FindSet then begin
                                FnInsertBOSALines(LoanApps, LoanApps."Loan  No.");
                            end;


                            GenJournalLine.RESET;
                            GenJournalLine.SETRANGE("Journal Template Name", TemplateName);
                            GenJournalLine.SETRANGE("Journal Batch Name", BatchName);
                            if GenJournalLine.Find('-') then begin
                                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Sacco21", GenJournalLine);
                                FnSendNotifications(); //Send Notifications
                                Rec.Posted := true;
                                Rec."Disbursement Number" := FnGetTrunchNumber(Rec."Loan No");
                                Rec."Date Disbursed" := Today;
                                Rec."Posted By" := UserId;
                                Rec."Approval Status" := Rec."Approval Status"::Closed;
                                Rec."Total Disbursed Amount" := Rec."Amount To Disburse" + Rec."Total Disbursed Amount";
                                Rec.Modify();
                                LoanApps.Reset();
                                LoanApps.SetRange(LoanApps."Loan  No.", Rec."Loan No");
                                if LoanApps.Find('-') then begin
                                    LoanApps.Posted := true;
                                    LoanApps."Captured By" := UserId;
                                    LoanApps."Loan Status" := LoanApps."Loan Status"::Issued;
                                    LoanApps.Modify();
                                end;
                                //.................................................
                                Message('Loan has successfully been posted and member notified');
                            end;
                        end;
                        CurrPage.close();
                    end;
                }
                action("Send Approvals")
                {
                    Caption = 'Send For Approval';
                    Enabled = (not OpenApprovalEntriesExist) AND EnabledApprovalWorkflowsExist AND (not RecordApproved);
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        PartialLoanDisbursments: Record "Partial Loan Disbursments";
                        LoanApp: Record "Loans Register";
                    begin
                        FnCheckForTestFields();

                        if Rec."Mode of Disbursement" <> Rec."Mode of Disbursement"::"Tranche/Multiple Disbursement" then begin
                            Error('Prohibited ! Mode of disbursement cannot be ' + Format(Rec."Mode of Disbursement"));
                        end;
                        if Confirm('Send Approval Request For partial loan disbursement of Ksh. ' + Format(rec."Amount To Disburse") + ' applied by ' + Format(rec."Client Name") + ' ?', false) = false then begin
                            exit;
                        end
                        else begin
                            MicropointApprovalsCodeUnit.SendPartialLoanDisbursementsRequestForApproval(rec."Document No", Rec);
                            UpdateControl();
                            CurrPage.close();
                        end;
                    end;
                }
                action("Cancel Approvals")
                {
                    Caption = 'Cancel For Approval';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Cancel Approval request?', false) = false then begin
                            exit;
                        end
                        else begin
                            MicropointApprovalsCodeUnit.CancelPartialLoanDisbursementsForApproval(rec."Document No", Rec);
                            UpdateControl();
                        end;
                    end;
                }
                action(Refresh)
                {
                    PromotedIsBig = true;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        CurrPage.Update();
                    end;
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(REC.RecordId); //Return No and allow sending of approval request.
        EnabledApprovalWorkflowsExist := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        LoansR.Reset;
        LoansR.SetRange(LoansR.Posted, false);
        LoansR.SetRange(LoansR."Captured By", UserId);
        if LoansR."Client Name" = '' then begin
            if LoansR.Count > 1 then begin
                if Confirm('There are still some Unused Loan Nos. Continue?', false) = false then begin
                    Error('There are still some Unused Loan Nos. Please utilise them first');
                end;
            end;
        end;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        LoanAppPermisions();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
    end;

    trigger OnOpenPage()
    begin
    end;

    var
        LoanGuar: Record "Loans Guarantee Details";
        SMSMessages: Record "SMS Messages";
        i: Integer;
        LoanType: Record "Loan Products Setup";
        PeriodDueDate: Date;
        ScheduleRep: Record "Loan Repayment Schedule";
        RunningDate: Date;
        G: Integer;
        IssuedDate: Date;
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
        CustomerRecord: Record Customer;
        Gnljnline: Record "Gen. Journal Line";
        //  Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
        CumInterest: Decimal;
        NewPrincipal: Decimal;
        PeriodPrRepayment: Decimal;
        GenBatch: Record "BOSA&FOSA User Template";
        LineNo: Integer;
        GnljnlineCopy: Record "Gen. Journal Line";
        NewLNApplicNo: Code[10];
        Cust: Record Customer;
        LoanApp: Record "Loans Register";
        TestAmt: Decimal;
        CustRec: Record Customer;
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
        GenJournalLine: Record "Gen. Journal Line";
        FOSAComm: Decimal;
        BOSAComm: Decimal;
        LoanTopUp: Record "Loan Offset Details";
        Vend: Record Vendor;
        BOSAInt: Decimal;
        TopUpComm: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        TotalTopupComm: Decimal;
        Notification: Codeunit Mail;
        CustE: Record Customer;
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
        POSTLoan: Boolean;
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
        Text001: label 'Status Must Be Open';
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation","Overdraft ",BLA,"Member Editable","FOSA Opening","Loan Batching",Leave,"Imprest Requisition","Imprest Surrender","Stores Requisition","Funds Transfer","Change Request","Staff Claims","BOSA Transfer","Loan Tranche","Loan TopUp","Memb Opening","Member Withdrawal";
        CurrpageEditable: Boolean;
        LoanStatusEditable: Boolean;
        MNoEditable: Boolean;
        ApplcDateEditable: Boolean;
        LProdTypeEditable: Boolean;
        EnableClientCode: Boolean;
        PartialLoanNoEnabled: Boolean;
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
        PepeaShares: Decimal;
        SaccoDeposits: Decimal;
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Account Opening","Member Closure",Loan;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        compinfo: Record "Company Information";
        NotPosted: Boolean;
        iEntryNo: Integer;
        eMAIL: Text;
        "Telephone No": Integer;
        Text002: label 'The Loan has already been approved';
        LoanSecurities: Integer;
        EditableField: Boolean;
        SFactory: Codeunit "Micropoint Factory";
        OpenApprovalEntriesExist: Boolean;
        TemplateName: Code[50];
        BatchName: Code[50];
        Template: Record "BOSA&FOSA User Template";
        EnabledApprovalWorkflowsExist: Boolean;
        RecordApproved: Boolean;
        MicropointApprovalsCodeUnit: Codeunit "Micropoint ApprovalsCodeUnit";
        CanCancelApprovalForRecord: Boolean;

    procedure UpdateControl()
    begin
        if Rec."Approval Status" = Rec."Approval Status"::Rejected then begin
            RecordApproved := true;
            POSTLoan := false;
            MNoEditable := false;
            AccountNoEditable := false;
            ApplcDateEditable := false;
            LoanStatusEditable := false;
            LProdTypeEditable := false;
            InstallmentEditable := false;
            AppliedAmountEditable := false;
            ApprovedAmountEditable := false;
            RepayMethodEditable := false;
            RepaymentEditable := false;
            BatchNoEditable := false;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := false;
            DisbursementDateEditable := false;
            RejectionRemarkEditable := false;
            CanCancelApprovalForRecord := false;
            EnableClientCode := true;
        end;
        if (Rec."Approval Status" = Rec."Approval Status"::Open) then begin
            EnableClientCode := true;
            PartialLoanNoEnabled := true;
            CanCancelApprovalForRecord := false;
        end;
        if (Rec."Approval Status" = Rec."Approval Status"::Pending) then begin
            EnableClientCode := false;
            PartialLoanNoEnabled := false;
            CanCancelApprovalForRecord := true;
        end;
        if Rec."Approval Status" = Rec."Approval Status"::Approved then begin
            EnableClientCode := false;
            PartialLoanNoEnabled := false;
            CanCancelApprovalForRecord := false;
            POSTLoan := true;
            RecordApproved := true;
            MNoEditable := false;
            AccountNoEditable := false;
            LoanStatusEditable := false;
            ApplcDateEditable := false;
            LProdTypeEditable := false;
            InstallmentEditable := false;
            AppliedAmountEditable := false;
            ApprovedAmountEditable := false;
            RepayMethodEditable := false;
            RepaymentEditable := false;
            BatchNoEditable := true;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := true;
            RejectionRemarkEditable := false;
            RecordApproved := true;
            CanCancelApprovalForRecord := false;
        end;
    end;

    procedure LoanAppPermisions()
    begin
    end;

    procedure SendSMS()
    begin
        GenSetUp.Get;
        compinfo.Get;
        if GenSetUp."Send SMS Notifications" = true then begin
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
            SMSMessage."Batch No" := Rec."Document No";
            SMSMessage."Document No" := Rec."Loan No";
            SMSMessage."Account No" := Rec."Client Code";
            SMSMessage."Date Entered" := Today;
            SMSMessage."Time Entered" := Time;
            SMSMessage.Source := 'LOANS';
            SMSMessage."Entered By" := UserId;
            SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
            SMSMessage."SMS Message" := 'Your partial loan disbursement of amount ' + Format(Rec."Amount To Disburse") + ' for ' + Rec."Client Code" + ' ' + Rec."Client Name" + ' has been received and is being Processed ' + compinfo.Name + ' ' + GenSetUp."Customer Care No";
            Cust.Reset;
            Cust.SetRange(Cust."No.", Rec."Client Code");
            if Cust.Find('-') then begin
                SMSMessage."Telephone No" := Cust."Mobile Phone No";
            end;
            SMSMessage.Insert;
        end;
    end;

    procedure SendMail()
    begin
    end;

    local procedure FnCheckForTestFields()
    var
        LoanType: Record "Loan Products Setup";
        LoanGuarantors: Record "Loans Guarantee Details";
    begin
        //--------------------
        if Rec."Approval Status" = Rec."Approval Status"::Approved then begin
            Error('The loan has already been approved');
        end;
        if Rec."Approval Status" <> Rec."Approval Status"::Open then begin
            Error('Approval status MUST be Open');
        end;
        Rec.TestField("Requested Amount");

        Rec.TestField("Loan Product Type");
        Rec.TestField("Mode of Disbursement");
        //----------------------
        if LoanType.get(Rec."Loan Product Type") then begin
            if LoanType."Appraise Guarantors" = true then begin
                LoanGuarantors.Reset();
                LoanGuarantors.SetRange(LoanGuarantors."Loan No", Rec."Loan No");
                if LoanGuarantors.find('-') then begin
                    Error('Please Insert Loan Applicant Guarantor Details!');
                end;
            end;
        end;
    end;

    local procedure FnSendLoanApprovalNotifications()
    var
    begin
        //...........................Notify Loaner
        SMSMessages.RESET;
        IF SMSMessages.FIND('+') THEN BEGIN
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        END
        ELSE BEGIN
            iEntryNo := 1;
        END;
        SMSMessages.RESET;
        SMSMessages.INIT;
        SMSMessages."Entry No" := iEntryNo;
        SMSMessages."Account No" := Rec."Client Code";
        SMSMessages."Date Entered" := TODAY;
        SMSMessages."Time Entered" := TIME;
        SMSMessages.Source := 'LOAN APPL';
        SMSMessages."Entered By" := USERID;
        SMSMessages."Sent To Server" := SMSMessages."Sent To Server"::No;
        SMSMessages."SMS Message" := 'Your loan application of KSHs.' + FORMAT(Rec."Requested Amount") + ' has been received.  Sacco Ltd.';
        Cust.RESET;
        IF Cust.GET(Rec."Client Code") THEN
            if Cust."Mobile Phone No" <> '' then begin
                SMSMessages."Telephone No" := Cust."Mobile Phone No";
            end
            else if (Cust."Mobile Phone No" = '') and (Cust."Mobile Phone No." <> '') then begin
                SMSMessages."Telephone No" := Cust."Mobile Phone No.";
            end;
        SMSMessages.INSERT;
        //.......................................Notify Guarantors
        LoanGuar.RESET;
        LoanGuar.SETRANGE(LoanGuar."Loan No", Rec."Loan No");
        IF LoanGuar.FIND('-') THEN BEGIN
            REPEAT
                Cust.RESET;
                Cust.SETRANGE(Cust."No.", LoanGuar."Member No");
                IF Cust.FIND('-') THEN BEGIN
                    SMSMessages.RESET;
                    IF SMSMessages.FIND('+') THEN BEGIN
                        iEntryNo := SMSMessages."Entry No";
                        iEntryNo := iEntryNo + 1;
                    END
                    ELSE BEGIN
                        iEntryNo := 1;
                    END;
                    SMSMessages.INIT;
                    SMSMessages."Entry No" := iEntryNo;
                    SMSMessages."Account No" := LoanGuar."Member No";
                    SMSMessages."Date Entered" := TODAY;
                    SMSMessages."Time Entered" := TIME;
                    SMSMessages.Source := 'LOAN GUARANTORS';
                    SMSMessages."Entered By" := USERID;
                    SMSMessages."Sent To Server" := SMSMessages."Sent To Server"::No;
                    IF LoanApp.GET(LoanGuar."Loan No") THEN SMSMessages."SMS Message" := 'You have guaranteed an amount of ' + FORMAT(LoanGuar."Amont Guaranteed") + ' to ' + Rec."Client Name" + '  ' + 'Loan Type ' + Rec."Loan Product Type" + ' ' + 'of ' + FORMAT(Rec."Requested Amount") + ' at Sacco Ltd. Call 0726****89 if in dispute';
                    ;
                    SMSMessages."Telephone No" := Cust."Phone No.";
                    SMSMessages.INSERT;
                END;
            UNTIL LoanGuar.NEXT = 0;
        END;
    end;

    local procedure FnMemberHasAnExistingLoanSameProduct(): Boolean
    var
        LoansReg: Record "Loans Register";
        Balance: Decimal;
    begin
        Balance := 0;
        LoansReg.Reset();
        LoansReg.SetRange(LoansReg."Client Code", Rec."Client Code");
        LoansReg.SetRange(LoansReg."Loan Product Type", Rec."Loan Product Type");
        LoansReg.SetRange(LoansReg.Posted, true);
        LoansReg.SetAutoCalcFields(LoansReg."Outstanding Balance", LoansReg."Outstanding Interest");
        if LoansReg.Find('-') then begin
            repeat
                Balance += LoansReg."Outstanding Balance" + LoansReg."Outstanding Interest";
            until LoansReg.Next = 0;
        end;
        if Balance > 0 then begin
            exit(true)
        end
        else if Balance <= 0 then begin
            exit(false);
        end;
    end;

    local procedure FnGetProductOutstandingBal(): Decimal
    var
        LoansReg: Record "Loans Register";
        Balance: Decimal;
    begin
        Balance := 0;
        LoansReg.Reset();
        LoansReg.SetRange(LoansReg."Client Code", Rec."Client Code");
        LoansReg.SetRange(LoansReg."Loan Product Type", Rec."Loan Product Type");
        LoansReg.SetRange(LoansReg.Posted, true);
        LoansReg.SetAutoCalcFields(LoansReg."Outstanding Balance", LoansReg."Outstanding Interest");
        if LoansReg.Find('-') then begin
            repeat
                Balance += LoansReg."Outstanding Balance" + LoansReg."Outstanding Interest";
            until LoansReg.Next = 0;
        end;
        exit(Balance);
    end;

    local procedure FnInsertBOSALines(var LoanApps: Record "Loans Register"; LoanNo: Code[30])
    var
        EndMonth: Date;
        RemainingDays: Integer;
        TMonthDays: Integer;
        Sfactorycode: Codeunit "Micropoint Factory";
        AmountTop: Decimal;
        NetAmount: Decimal;
        DirbursementDate: Date;
        jtemplate: Code[20];
        jbatch: Code[20];
        ProcessingFees: Decimal;
        ProcessingFeesAcc: Code[50];
        PChargeAmount: Decimal;
        BLoan: Code[30];
        ObjLoans: Record "Loans Register";
        ObjLoanType: Record "Loan Products Setup";
        VarLoanInsuranceBalAccount: Code[30];
        VarAmounttoDisburse: Decimal;
    begin
        AmountTop := 0;
        NetAmount := 0;

        //--------------------Generate Schedule
        if Template.Get(UserId) then begin
            Jtemplate := Template."loan Template Name";
            Jbatch := Template."loan Batch Name";
        end else begin
            Error('Set up your user details on the User Template Page # Go to Home >> Settings >> My Settings >>  User Template');
        end;

        DirbursementDate := Rec."Date Disbursed";
        VarAmounttoDisburse := Rec."Amount To Disburse";



        //Message('Approved amt is %1', VarAmounttoDisburse);
        //....................PRORATED DAYS
        EndMonth := CALCDATE('-1D', CALCDATE('1M', DMY2DATE(1, DATE2DMY(Today, 2), DATE2DMY(Today, 3))));
        RemainingDays := (EndMonth - Today) + 1;
        TMonthDays := DATE2DMY(EndMonth, 1);
        //....................Ensure that If Batch doesnt exist then create

        //....................Reset General Journal Lines
        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name", Jtemplate);
        GenJournalLine.SETRANGE("Journal Batch Name", Jbatch);
        GenJournalLine.DELETEALL;
        //....................Loan Posting Lines
        GenSetUp.GET;
        DActivity := '';
        DBranch := '';
        IF Cust.GET(LoanApps."Client Code") THEN BEGIN
            DActivity := Cust."Global Dimension 1 Code";
            DBranch := Cust."Global Dimension 2 Code";
        END;
        //**************Loan Principal Posting**********************************
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(Jtemplate, Jbatch, Rec."Document No", LineNo, GenJournalLine."Transaction Type"::Loan,
         GenJournalLine."Account Type"::Customer, LoanApps."Client Code", DirbursementDate, VarAmounttoDisburse, 'BOSA',
         LoanApps."Loan  No.", 'Partial Loan Disbursement - ' + LoanApps."Loan Product Type", LoanApps."Loan  No.", GenJournalLine."application source"::" ");



        //--------------------------------RECOVER OVERDRAFT()-------------------------------------------------------

        //Code Here

        //...................Cater for Loan Offset Now !


        LoanApps.CalcFields("Top Up Amount");
        if Rec."Loan offset Amount" > 0 then begin
            LoanApps.CalcFields("Top Up Amount");
            // if LoanApps."Loan Offset Amount" > 0 then begin
            Message('Loan Offset Amount is %1', LoanApps."Top Up Amount");

            LoanTopUp.RESET;
            LoanTopUp.SETRANGE(LoanTopUp."Loan No.", LoanApps."Loan  No.");
            IF LoanTopUp.FIND('-') THEN BEGIN
                repeat
                    Message('Top Up Principle is %1', LoanTopUp."Principle Top Up");
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(Jtemplate, Jbatch, Rec."Document No", LineNo, GenJournalLine."Transaction Type"::"Loan Repayment", GenJournalLine."Account Type"::Customer, LoanApps."Client Code", DirbursementDate, LoanTopUp."Principle Top Up" * -1, 'BOSA', LoanApps."Loan  No.", 'Loan OffSet By - ' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                    //..................Recover Interest On Top Up
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(Jtemplate, Jbatch, Rec."Document No", LineNo, GenJournalLine."Transaction Type"::"Interest Paid", GenJournalLine."Account Type"::Customer, LoanApps."Client Code", DirbursementDate, LoanTopUp."Interest Top Up" * -1, 'BOSA', LoanApps."Loan  No.", 'Interest Due Paid on top up - ', LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                    //If there is top up commission charged write it here start
                    LineNo := LineNo + 10000;
                    AmountTop := (LoanTopUp."Principle Top Up" + LoanTopUp."Interest Top Up" + LoanTopUp.Commision);
                    VarAmounttoDisburse := VarAmounttoDisburse - (LoanTopUp."Principle Top Up" + LoanTopUp."Interest Top Up" + LoanTopUp.Commision);
                UNTIL LoanTopUp.NEXT = 0;
            END;
        end;


        //***************************Loan Product Charges code

        if Rec.Charge = true then begin
            //------------------------------------3. EARN/RECOVER PRODUCT CHARGES FROM FOSA A/C--------------------------------------
            PCharges.Reset;
            PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
            PCharges.SetFilter(PCharges."Loan Charge Type", '<>%1', PCharges."loan charge type"::"Loan Insurance");
            if PCharges.Find('-') then begin
                repeat

                    if PCharges."Use Perc" = true then begin
                        PChargeAmount := (LoanApps."Approved Amount" * PCharges.Percentage / 100);//LoanDisbAmount
                        if PChargeAmount < PCharges."Minimum Amount" then begin
                            PChargeAmount := PCharges."Minimum Amount"
                        end else if PChargeAmount > PCharges."MAXIMUM Amount" then begin
                            PChargeAmount := PCharges."MAXIMUM Amount"
                        end else
                            PChargeAmount := (LoanApps."Approved Amount" * PCharges.Percentage / 100);//LoanDisbAmount
                    end else
                        PChargeAmount := PCharges.Amount;
                    //-------------------EARN CHARGE-------------------------------------------

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(Jtemplate, Jbatch, Rec."Document No", LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", PCharges."G/L Account", DirbursementDate, PChargeAmount * -1, 'BOSA', LoanApps."Loan  No.",
                    PCharges.Description + '-' + LoanApps."Client Code" + '-' + '-' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."application source"::" ");
                    VarAmounttoDisburse := VarAmounttoDisburse - PChargeAmount;


                    //-------------------RECOVER-----------------------------------------------

                    //------------------10% EXCISE DUTY----------------------------------------
                    if SFactory.FnChargeExcise(PCharges.Code) then begin
                        //-------------------Earn---------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(Jtemplate, Jbatch, Rec."Document No", LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::"G/L Account", GenSetUp."Excise Duty Account", DirbursementDate, (PChargeAmount * -1) * 0.1, 'BOSA', LoanApps."Loan  No.",
                        PCharges.Description + '-' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No." + '- Excise(10%)', LoanApps."Loan  No.", GenJournalLine."application source"::" ");
                        //-----------------Recover---------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(Jtemplate, Jbatch, Rec."Document No", LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Customer, LoanApps."Client Code", DirbursementDate, PChargeAmount * 0.1, 'BOSA', LoanApps."Loan  No.",
                        PCharges.Description + '-' + LoanApps."Loan Product Type Name" + ' - Excise(10%)', LoanApps."Loan  No.", GenJournalLine."application source"::" ");
                    end
                //----------------END 10% EXCISE--------------------------------------------
                until PCharges.Next = 0;
            end;

            //************************************insurance on Loan Disbursement***************************************

            PCharges.Reset;
            PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
            PCharges.SetFilter(PCharges."Loan Charge Type", '=%1', PCharges."loan charge type"::"Loan Insurance");
            if PCharges.Find('-') then begin
                repeat

                    if PCharges."Use Perc" = true then begin
                        PChargeAmount := (LoanApps."Approved Amount" * PCharges.Percentage / 100);//LoanDisbAmount
                        if PChargeAmount < PCharges."Minimum Amount" then begin
                            PChargeAmount := PCharges."Minimum Amount"
                        end else if PChargeAmount > PCharges."MAXIMUM Amount" then begin
                            PChargeAmount := PCharges."MAXIMUM Amount"
                        end else
                            PChargeAmount := (LoanApps."Approved Amount" * PCharges.Percentage / 100);//LoanDisbAmount
                    end else
                        PChargeAmount := PCharges.Amount;
                    //-------------------EARN CHARGE-------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(Jtemplate, Jbatch, Rec."Document No", LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", PCharges."G/L Account", DirbursementDate, PChargeAmount * -1, 'BOSA', LoanApps."Loan  No.",
                    PCharges.Description + '-' + LoanApps."Client Code" + '-' + '-' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."application source"::" ");
                    VarAmounttoDisburse := VarAmounttoDisburse - PChargeAmount;


                    //-------------------RECOVER-----------------------------------------------

                    //------------------10% EXCISE DUTY----------------------------------------
                    if SFactory.FnChargeExcise(PCharges.Code) then begin
                        //-------------------Earn---------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(Jtemplate, Jbatch, Rec."Document No", LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::"G/L Account", GenSetUp."Excise Duty Account", DirbursementDate, (PChargeAmount * -1) * 0.1, 'BOSA', LoanApps."Loan  No.",
                        PCharges.Description + '-' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No." + '- Excise(10%)', LoanApps."Loan  No.", GenJournalLine."application source"::" ");
                        //-----------------Recover---------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(Jtemplate, Jbatch, Rec."Document No", LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Customer, LoanApps."Client Code", DirbursementDate, PChargeAmount * 0.1, 'BOSA', LoanApps."Loan  No.",
                        PCharges.Description + '-' + LoanApps."Loan Product Type Name" + ' - Excise(10%)', LoanApps."Loan  No.", GenJournalLine."application source"::" ");
                    end
                //----------------END 10% EXCISE--------------------------------------------
                until PCharges.Next = 0;
            end;


            NetAmount := Rec."Approved Amount" - (LoanApps."Loan Processing Fee" + LoanApps."Loan Appraisal Fee" + LoanApps."Loan Insurance" + AmountTop);
        End;
        //------------------------------------2. CREDIT MEMBER BANK A/C---------------------------------------------------------------------------------------------
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(Jtemplate, Jbatch, Rec."Document No", LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"Bank Account", LoanApps."Paying Bank Account No", DirbursementDate, VarAmounttoDisburse * -1, 'BOSA', LoanApps."Loan  No.", 'Loan Principle Amount ' + Format(LoanApps."Loan  No."), '', GenJournalLine."application source"::" ");
    end;

    local procedure FnSendNotifications()
    var
        msg: Text[250];
        PhoneNo: Text[250];
    begin
        LoansR.Reset();
        LoansR.SetRange(LoansR."Loan  No.", Rec."Loan No");
        if LoansR.Find('-') then begin
            msg := '';
            msg := 'Dear ' + Format(LoansR."Client Name") + ', Your ' + Format(LoansR."Loan Product Type") + ' partial Loan disbursement of KSHs.' + Format(Rec."Amount To Disburse") + ' has been processed and deposited to your Account.Ruai Sacco.';
            PhoneNo := FnGetPhoneNo(Rec."Client Code");
            SendSMSMessage(Rec."Client Code", msg, PhoneNo);
        end;
    end;

    local procedure SendSMSMessage(BOSANo: Code[20]; msg: Text[250]; PhoneNo: Text[250])
    begin
        SMSMessages.Reset;
        if SMSMessages.Find('+') then begin
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;
        //--------------------------------------------------
        SMSMessages.Reset;
        SMSMessages.Init;
        SMSMessages."Entry No" := iEntryNo;
        SMSMessages."Account No" := BOSANo;
        SMSMessages."Date Entered" := Today;
        SMSMessages."Time Entered" := Time;
        SMSMessages.Source := 'MOBILETRAN';
        SMSMessages."Entered By" := UserId;
        SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
        SMSMessages."SMS Message" := msg;
        SMSMessages."Telephone No" := PhoneNo;
        SMSMessages.Insert;
    end;

    local procedure FnGetPhoneNo(ClientCode: Code[50]): Text[250]
    var
        Member: Record Customer;
        Vendor: Record Vendor;
    begin
        Vendor.Reset();
        Vendor.SetRange(Vendor."BOSA Account No", ClientCode);
        if Vendor.Find('-') then begin
            exit(Vendor."Phone No.");
        end;
    end;

    local procedure FnCanPostLoans(UserId: Text): Boolean
    var
        UserSetUp: Record "User Setup";
    begin
        if UserSetUp.get(UserId) then begin
            if UserSetUp."Can POST Loans" = true then begin
                exit(true);
            end;
        end;
        exit(false);
    end;

    local procedure FnGetTrunchNumber(LoanNo: Code[20]): Integer
    var
        PartialLoanDisburse: record "Partial Loan Disbursments";
    begin
        PartialLoanDisburse.Reset();
        PartialLoanDisburse.SetRange(PartialLoanDisburse."Loan No", LoanNo);
        if PartialLoanDisburse.FindLast() then begin
            exit(1 + PartialLoanDisburse."Disbursement Number");
        end;
        exit(1);
    end;

    local procedure FnGetNewLoanInstallments(LoanNo: Code[20]): Integer
    begin
        LoanApp.Reset();
        LoanApp.SetRange(LoanApp."Loan  No.", LoanNo);
        if LoanApp.Find('-') then begin
            exit(Round((loanapp."Expected Date of Completion" - Today) / 30, 1, '<'));
        end;
    end;
}
