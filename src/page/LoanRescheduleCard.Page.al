Page 50921 "Loan Reschedule Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loans Register";
    SourceTableView = where(Posted = const(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Loan  No."; Rec."Loan  No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Client Code"; Rec."Client Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member';
                    Editable = MNoEditable;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                    Editable = AccountNoEditable;
                }
                field("Client Name"; Rec."Client Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID NO"; Rec."ID NO")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member Deposits"; Rec."Member Deposits")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = ApplcDateEditable;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }

                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Installments; Rec.Installments)
                {
                    ApplicationArea = Basic;
                    Editable = InstallmentEditable;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field(Interest; Rec.Interest)
                {
                    ApplicationArea = Basic;
                }
                field("Reason For Loan Reschedule"; Rec."Reason For Loan Reschedule")
                {
                    ApplicationArea = Basic;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount Applied';
                    Editable = false;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Recommended Amount"; Rec."Recommended Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Qualifying Amount';
                    Editable = false;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Amount';
                    Editable = false;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Loan Purpose"; Rec."Loan Purpose")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = true;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = true;
                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Repayment; Rec.Repayment)
                {
                    ApplicationArea = Basic;
                    Editable = RepaymentEditable;
                }
                field("Approved Repayment"; Rec."Approved Repayment")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Loan Status"; Rec."Loan Status")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        UpdateControl();
                    end;
                }
                field("Batch No."; Rec."Batch No.")
                {
                    ApplicationArea = Basic;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Top Up Amount"; Rec."Top Up Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Top Up Amount';
                }
                field("Total TopUp Commission"; Rec."Total TopUp Commission")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total TopUp Interest';
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                    ApplicationArea = Basic;
                    //Editable = RepaymentFrequencyEditable;
                }
                field("Mode of Disbursement"; Rec."Mode of Disbursement")
                {
                    ApplicationArea = Basic;
                    Editable = ModeofDisburesmentEdit;
                }
                field("Loan Rescheduled By"; Rec."Loan Rescheduled By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Rescheduled Date"; Rec."Loan Rescheduled Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                    Visible = true;

                    trigger OnValidate()
                    begin
                        if StrLen(Rec."Cheque No.") > 6 then Error('Document No. cannot contain More than 6 Characters.');
                    end;
                }
                field("Repayment Start Date"; Rec."Repayment Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Date of Completion"; Rec."Expected Date of Completion")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("External EFT"; Rec."External EFT")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Posted"; Rec."Posted")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                }
                field("Rejection  Remark"; Rec."Rejection  Remark")
                {
                    ApplicationArea = Basic;
                    Editable = RejectionRemarkEditable;
                }
            }
            part(Control1000000004; "Loans Guarantee Details")
            {
                Caption = 'Guarantors  Detail';
                SubPageLink = "Loan No" = field("Loan  No.");
            }
            part(Control1000000005; "Loan Collateral Security")
            {
                Caption = 'Other Securities';
                SubPageLink = "Loan No" = field("Loan  No.");
            }
        }
        area(factboxes)
        {
            part(Control1000000010; "Member Statistics FactBox")
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
                Caption = 'Loan';
                Image = AnalysisView;

                action("Member Statement")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."Client Code");
                        Report.Run(50363, true, false, Cust);
                    end;
                }
                separator(Action1102760046)
                {
                }
                action("View Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'View Schedule';
                    Image = ViewDetails;
                    Promoted = true;
                    PromotedCategory = "Report";
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    begin
                        if Rec."Repayment Frequency" = Rec."repayment frequency"::Daily then
                            Evaluate(InPeriod, '1D')
                        else if Rec."Repayment Frequency" = Rec."repayment frequency"::Weekly then
                            Evaluate(InPeriod, '1W')
                        else if Rec."Repayment Frequency" = Rec."repayment frequency"::Monthly then
                            Evaluate(InPeriod, '1M')
                        else if Rec."Repayment Frequency" = Rec."repayment frequency"::Quaterly then Evaluate(InPeriod, '1Q');
                        QCounter := 0;
                        QCounter := 3;
                        //EVALUATE(InPeriod,'1D');
                        // GrPrinciple:=Rec."Grace Period - Rec.Principle (M)";
                        // GrInterest:=Rec."Grace Period - Rec.Interest (M)";
                        // InitialGraceInt:=Rec."Grace Period - Rec.Interest (M)";
                        LoansR.Reset;
                        LoansR.SetRange(LoansR."Loan  No.", Rec."Loan  No.");
                        if LoansR.Find('-') then begin
                            Rec.TestField("Loan Disbursement Date");
                            Rec.TestField("Repayment Start Date");
                            RSchedule.Reset;
                            RSchedule.SetRange(RSchedule."Loan No.", Rec."Loan  No.");
                            RSchedule.DeleteAll;
                            LoanAmount := LoansR."Approved Amount";
                            InterestRate := LoansR.Interest;
                            RepayPeriod := LoansR.Installments;
                            InitialInstal := LoansR.Installments + Rec."Grace Period - Interest (M)" - Rec."Grace Period - Interest (M)";
                            LBalance := LoansR."Approved Amount";
                            LNBalance := LoansR."Outstanding Balance";
                            RunDate := Rec."Repayment Start Date";
                            InstalNo := 0;
                            Evaluate(RepayInterval, '1W');
                            //Repayment Frequency
                            if Rec."Repayment Frequency" = Rec."repayment frequency"::Daily then
                                RunDate := CalcDate('-1D', RunDate)
                            else if Rec."Repayment Frequency" = Rec."repayment frequency"::Weekly then
                                RunDate := CalcDate('-1W', RunDate)
                            else if Rec."Repayment Frequency" = Rec."repayment frequency"::Monthly then
                                RunDate := CalcDate('-1M', RunDate)
                            else if Rec."Repayment Frequency" = Rec."repayment frequency"::Quaterly then RunDate := CalcDate('-1Q', RunDate);
                            //Repayment Frequency
                            repeat
                                InstalNo := InstalNo + 1;
                                //*************Repayment Frequency***********************//
                                if Rec."Repayment Frequency" = Rec."repayment frequency"::Daily then
                                    RunDate := CalcDate('1D', RunDate)
                                else if Rec."Repayment Frequency" = Rec."repayment frequency"::Weekly then
                                    RunDate := CalcDate('1W', RunDate)
                                else if Rec."Repayment Frequency" = Rec."repayment frequency"::Monthly then
                                    RunDate := CalcDate('1M', RunDate)
                                else if Rec."Repayment Frequency" = Rec."repayment frequency"::Quaterly then RunDate := CalcDate('1Q', RunDate);
                                //*******************If Amortised****************************//
                                if Rec."Repayment Method" = Rec."repayment method"::Amortised then begin
                                    Rec.TestField(Installments);
                                    Rec.TestField(Interest);
                                    Rec.TestField(Installments);
                                    TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount, 1, '>');
                                    TotalMRepay := (InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount;
                                    LInterest := ROUND(LBalance / 100 / 12 * InterestRate);
                                    LPrincipal := TotalMRepay - LInterest;
                                end;
                                if Rec."Repayment Method" = Rec."repayment method"::"Straight Line" then begin
                                    Rec.TestField(Installments);
                                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
                                    if (Rec."Loan Product Type" = 'INST') or (Rec."Loan Product Type" = 'MAZAO') then begin
                                        LInterest := 0;
                                    end
                                    else begin
                                        LInterest := ROUND((InterestRate / 100) * LoanAmount, 1, '>');
                                    end;
                                    Rec.Repayment := LPrincipal + LInterest;
                                    Rec."Loan Principle Repayment" := LPrincipal;
                                    Rec."Loan Interest Repayment" := LInterest;
                                end;
                                if Rec."Repayment Method" = Rec."repayment method"::"Reducing Balance" then begin
                                    Rec.TestField(Interest);
                                    Rec.TestField(Installments);
                                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
                                    LInterest := ROUND((InterestRate / 12 / 100) * LBalance, 1, '>');
                                end;
                                if Rec."Repayment Method" = Rec."repayment method"::Constants then begin
                                    Rec.TestField(Repayment);
                                    if LBalance < Rec.Repayment then
                                        LPrincipal := LBalance
                                    else
                                        LPrincipal := Rec.Repayment;
                                    LInterest := Rec.Interest;
                                end;
                                //Grace Period
                                if GrPrinciple > 0 then begin
                                    LPrincipal := 0
                                end
                                else begin
                                    if Rec."Instalment Period" <> InPeriod then LBalance := LBalance - LPrincipal;
                                end;
                                if GrInterest > 0 then LInterest := 0;
                                GrPrinciple := GrPrinciple - 1;
                                GrInterest := GrInterest - 1;
                                //Grace Period
                                RSchedule.Init;
                                RSchedule."Repayment Code" := RepayCode;
                                RSchedule."Loan No." := Rec."Loan  No.";
                                RSchedule."Loan Amount" := LoanAmount;
                                RSchedule."Instalment No" := InstalNo;
                                RSchedule."Repayment Date" := RunDate;
                                RSchedule."Member No." := Rec."Client Code";
                                RSchedule."Loan Category" := Rec."Loan Product Type";
                                RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                                RSchedule."Monthly Interest" := LInterest;
                                RSchedule."Principal Repayment" := LPrincipal;
                                RSchedule.Insert;
                                WhichDay := Date2dwy(RSchedule."Repayment Date", 1);
                            until LBalance < 1
                        end;
                        Commit;
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then
                            if LoanApp."Loan Product Type" <> 'INST' then begin
                                Report.Run(50477, true, false, LoanApp);
                            end
                            else begin
                                Report.Run(50477, true, false, LoanApp);
                            end;
                    end;
                }
                separator(Action1102755012)
                {
                }
                action("Loans to Offset")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans to Offset';
                    Image = AddAction;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Offset Detail List";
                    RunPageLink = "Loan No." = field("Loan  No."), "Client Code" = field("Client Code");
                }
                separator(Action1102760039)
                {
                }
                action("Post Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Reschedule Loan';
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = true;

                    trigger OnAction()
                    begin
                        if Rec."Approval Status" <> "approval status"::Approved then begin
                            Error('You Can not post a loan that is not fully Approved')
                        end
                        else if Confirm('Are you Sure you want to reschedule this Loan', false) = true then begin
                            GenJournalLine.Init;
                            LineNo := LineNo + 10000;
                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                            GenJournalLine."Journal Batch Name" := 'LOANS';
                            GenJournalLine."Line No." := LineNo + 10000;
                            GenJournalLine."Document No." := Rec."Loan  No.";
                            GenJournalLine."Posting Date" := Rec."Loan Disbursement Date";
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                            GenJournalLine."Account No." := Rec."Client Code";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            // GenJournalLine.Description := 'loan Rescheduled' + '' + "Loan to Reschedule";
                            GenJournalLine.Amount := (Rec."Approved Amount") * -1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                            GenJournalLine."Shortcut Dimension 2 Code" := Rec."Branch Code";
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Loan Repayment";
                            //GenJournalLine."Loan No" := "Loan to Reschedule";
                            //GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            //GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then GenJournalLine.Insert;
                            GenJournalLine.Init;
                            LineNo := LineNo + 10000;
                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                            GenJournalLine."Journal Batch Name" := 'LOANS';
                            GenJournalLine."Line No." := LineNo + 10000;
                            GenJournalLine."Document No." := Rec."Loan  No.";
                            GenJournalLine."Posting Date" := Rec."Loan Disbursement Date";
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                            GenJournalLine."Account No." := Rec."Client Code";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine.Description := 'loan Rescheduled';
                            GenJournalLine.Amount := Rec."Approved Amount" + (Rec."Approved Amount" * (0.08));
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                            GenJournalLine."Shortcut Dimension 2 Code" := Rec."Branch Code";
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
                            //GenJournalLine."Loan No" := "Loan to Reschedule";
                            // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then GenJournalLine.Insert;
                            //Rescheduling Charges
                            GenJournalLine.Init;
                            LineNo := LineNo + 10000;
                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                            GenJournalLine."Journal Batch Name" := 'LOANS';
                            GenJournalLine."Line No." := LineNo + 10000;
                            GenJournalLine."Document No." := Rec."Loan  No.";
                            GenJournalLine."Posting Date" := Rec."Loan Disbursement Date";
                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No." := '5430';
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine.Description := 'loan Rescheduled charge' + '' + Rec."Loan  No.";
                            GenJournalLine.Amount := (Rec."Approved Amount" * (0.08)) * -1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                            GenJournalLine."Shortcut Dimension 2 Code" := Rec."Branch Code";
                            // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            // GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then GenJournalLine.Insert;
                            //End Rescheduling Charges
                            //Post
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                            GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                            if GenJournalLine.Find('-') then begin
                                // Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                            end;
                            Rec.Posted := true;
                            Rec."Loan Status" := Rec."loan status"::Issued;
                            Rec."Approval Status" := Rec."approval status"::Approved;
                            Rec.Modify;
                            //Post New
                            Rec."Loan Rescheduled Date" := Rec."Loan Disbursement Date";
                            Rec."Loan Rescheduled By" := UserId;
                            Rec."Loan Reschedule" := true;
                            Rec.Modify;
                            Message('Loan Rescheduled successfully.');
                        end
                        else begin
                            exit;
                        end;
                    end;
                }
                group("More details")
                {
                }
                action("Salary Details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salary Details';
                    Enabled = true;
                    Image = StatisticsGroup;
                    Promoted = true;
                    PromotedCategory = Process;
                    // RunObject = Page "Loan Appraisal Salary Details";
                    //RunPageLink = "Loan No"=field("Loan  No."), "Client Code"=field("Client Code");
                    Visible = true;
                }
                action(Guarantors)
                {
                    ApplicationArea = Basic;
                    Caption = 'Guarantors';
                    Image = ItemGroup;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loans Guarantee Details";
                    RunPageLink = "Loan No" = field("Loan  No.");
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';

                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Text001: label 'This transaction is already pending approval';
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                        ApprovalsCodeUnit: Codeunit "Micropoint ApprovalsCodeUnit";
                    begin
                        //ENSURE THAT REQUESTED AMOUNT IS ENTERED
                        Rec.TestField("Requested Amount");
                        if Rec."Approval Status" <> "approval status"::Open then Error(Text001);
                        //End allocate batch number
                        Doc_Type := Doc_type::Loan;
                        Table_id := Database::"Loans Register";
                        // if ApprovalsMgmt.CheckLoanAppApprovalsWorkflowEnabled(Rec) then
                        //   ApprovalsMgmt.OnSendLoanAppDocForApproval(Rec);
                        //........................
                        if Confirm('Send Approval Request?', false) = true then begin
                            //ApprovalsCodeUnit.SendLoanApplicationsRequestForApproval(rec."Loan  No.", Rec);
                            Rec."Approval Status" := Rec."approval status"::Approved;
                            Rec.Modify;
                        end;
                        //SMS MESSAGE
                        SMSMessages.Reset;
                        if SMSMessages.Find('+') then begin
                            iEntryNo := SMSMessages."Entry No";
                            iEntryNo := iEntryNo + 1;
                        end
                        else begin
                            iEntryNo := 1;
                        end;
                        SMSMessages.Reset;
                        SMSMessages.Init;
                        SMSMessages."Entry No" := iEntryNo;
                        SMSMessages."Account No" := Rec."Client Code";
                        SMSMessages."Date Entered" := Today;
                        SMSMessages."Time Entered" := Time;
                        SMSMessages.Source := 'LOAN APPL';
                        SMSMessages."Entered By" := UserId;
                        SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
                        SMSMessages."SMS Message" := 'Your loan application of KSHs.' + Format(Rec."Requested Amount") + ' has been received ' + CompanyInfo.Name + '.';
                        Cust.Reset;
                        if Cust.Get(Rec."Client Code") then SMSMessages."Telephone No" := Cust."Phone No.";
                        SMSMessages.Insert;
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                        ApprovalsCodeUnit: Codeunit "Micropoint ApprovalsCodeUnit";
                    begin
                        if Confirm('Cancel Approval?', false) = true then begin
                            //ApprovalsCodeUnit.CancelLoanApplicationsRequestForApproval(rec."Loan  No.", Rec);
                        end;
                    end;
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
    end;

    trigger OnModifyRecord(): Boolean
    begin
        LoanAppPermisions();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //Source:=Source::BOSA;
        //"Loan Appeal":=TRUE;
        //MODIFY
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        /*IF "Loan Status"="Loan Status"::Approved THEN
            CurrPage.EDITABLE:=FALSE; */
    end;

    trigger OnOpenPage()
    begin
        //SetRange(Posted, false);
        /*IF "Loan Status"="Loan Status"::Approved THEN
            CurrPage.EDITABLE:=FALSE;*/
    end;

    var
        i: Integer;
        LoanType: Record "Loan Products Setup";
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
        CustomerRecord: Record Customer;
        Gnljnline: Record "Gen. Journal Line";
        Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
        CumInterest: Decimal;
        NewPrincipal: Decimal;
        PeriodPrRepayment: Decimal;
        GenBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        GnljnlineCopy: Record "Gen. Journal Line";
        NewLNApplicNo: Code[10];
        Cust: Record Customer;
        LoanApp: Record "Loans Register";
        TestAmt: Decimal;
        CustRec: Record "Customer Posting Group";
        CustPostingGroup: Record "Customer Posting Group";
        GenSetUp: Record "Sacco General Set-Up";
        PCharges: Record "Loan Product Charges";
        TCharges: Decimal;
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
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
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
        BridgedLoans: Record "Loan Offset Details";
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
        Text001: label 'Status Must Be Open';
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Imprest,ImprestSurrender,Interbank;
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
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        GrossPay: Decimal;
        Nettakehome: Decimal;
        TotalDeductions: Decimal;
        UtilizableAmount: Decimal;
        NetUtilizable: Decimal;
        Deductions: Decimal;
        Benov: Decimal;
        //TAXABLEPAY: Record "Investment General Setup";
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
        PartPayTotal: Decimal;
        AmountPayable: Decimal;
        CompanyInfo: Record "Company Information";

    procedure UpdateControl()
    begin
        if Rec."Loan Status" = Rec."loan status"::Application then begin
            MNoEditable := true;
            ApplcDateEditable := false;
            LoanStatusEditable := false;
            LProdTypeEditable := true;
            InstallmentEditable := true;
            AppliedAmountEditable := true;
            ApprovedAmountEditable := true;
            RepayMethodEditable := true;
            RepaymentEditable := true;
            BatchNoEditable := false;
            RepayFrequencyEditable := true;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := false;
        end;
        if Rec."Loan Status" = Rec."loan status"::Appraisal then begin
            MNoEditable := false;
            ApplcDateEditable := false;
            LoanStatusEditable := false;
            LProdTypeEditable := false;
            InstallmentEditable := false;
            AppliedAmountEditable := false;
            ApprovedAmountEditable := true;
            RepayMethodEditable := true;
            RepaymentEditable := true;
            BatchNoEditable := false;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := false;
        end;
        if Rec."Loan Status" = Rec."loan status"::Rejected then begin
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
            RejectionRemarkEditable := false
        end;
        if Rec."Approval Status" = Rec."approval status"::Approved then begin
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
        end;
    end;

    procedure LoanAppPermisions()
    begin
    end;
}
