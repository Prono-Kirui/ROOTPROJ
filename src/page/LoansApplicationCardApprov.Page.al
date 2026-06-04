#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50574 "Loans Application Card(Approv)"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Card;
    ShowFilter = false;
    SourceTable = "Loans Register";

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
                field("Car Tracker"; Rec."Car Tracker")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = LProdTypeEditable;
                }
                field("Loan Product Type Name"; Rec."Loan Product Type Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Product Name';
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
                    Editable = false;
                }
                field("Product Currency Code"; Rec."Product Currency Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = true;
                    Visible = false;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount Applied';
                    Editable = AppliedAmountEditable;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Boost this Loan"; Rec."Boost this Loan")
                {
                    ApplicationArea = Basic;
                    Editable = AppliedAmountEditable;
                }
                field("Boosted Amount"; Rec."Boosted Amount")
                {
                    ApplicationArea = Basic;
                    Editable = AppliedAmountEditable;
                }
                field("Recommended Amount"; Rec."Recommended Amount")
                {
                    ApplicationArea = Basic;
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
                group("Tranch Details")
                {
                    Caption = 'Tranch Details';
                    Visible = TrunchDetailsVisible;
                    field("Amount to Disburse on Tranch 1"; Rec."Amount to Disburse on Tranch 1")
                    {
                        ApplicationArea = Basic;
                    }
                    field("No of Tranch Disbursment"; Rec."No of Tranch Disbursment")
                    {
                        ApplicationArea = Basic;
                    }
                }
                field("Loan Purpose"; Rec."Loan Purpose")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = false;
                }
                field("Loan Purpose Description"; Rec."Loan Purpose Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = RemarksEditable;
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
                field("Batch No."; Rec."Batch No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Credit Officer II"; Rec."Credit Officer II")
                {
                    ApplicationArea = Basic;
                    Caption = 'Credit Officer';
                }


                field("Loan Offset Amount"; Rec."Loan Offset Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bridged Amount';
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                    ApplicationArea = Basic;
                    Editable = RepayFrequencyEditable;
                }
                field("Mode of Disbursement"; Rec."Mode of Disbursement")
                {
                    ApplicationArea = Basic;
                    // Editable = false;
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
                field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                    AssistEdit = true;
                    Editable = EditableField;
                    Enabled = EditableField;
                    Importance = Promoted;
                    NotBlank = true;
                    ShowMandatory = true;
                    Style = Attention;
                    StyleExpr = true;
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
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("partially Bridged"; Rec."partially Bridged")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Total Offset Commission"; Rec."Total Offset Commission")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Disburesment Type"; Rec."Disburesment Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Stages"; Rec."Loan Stages")
                {
                    ApplicationArea = Basic;
                }

            }
            group("Salary Details")
            {
                Caption = 'Salary Details';
                Visible = PayslipDetailsVisible;
                group("Monthly Income Details")
                {
                    field("Salary Total Income"; Rec."Salary Total Income")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Monthly Income';
                    }
                }
                group("MonthlyExpenses Details")
                {
                    Caption = 'Monthly Expenses Details';
                    field("SExpenses Rent"; Rec."SExpenses Rent")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Rent';
                    }
                    field("SExpenses Transport"; Rec."SExpenses Transport")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Transport';
                    }
                    field("SExpenses Education"; Rec."SExpenses Education")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Education';
                    }
                    field("SExpenses Food"; Rec."SExpenses Food")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Food';
                    }
                    field("SExpenses Utilities"; Rec."SExpenses Utilities")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Utilities';
                    }
                    field("SExpenses Others"; Rec."SExpenses Others")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Others';
                    }
                }
                field("Salary Net Utilizable"; Rec."Salary Net Utilizable")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Statement Details")
            {
                Caption = 'Statement Details';
                Visible = BankStatementDetailsVisible;
                field("Bank Statement Avarage Credits"; Rec."Bank Statement Avarage Credits")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Statement Avarage Debits"; Rec."Bank Statement Avarage Debits")
                {
                    ApplicationArea = Basic;
                }
                group("Monthly Expenses Details")
                {
                    Caption = 'Monthly Expenses Details';
                    field("BSExpenses Rent"; Rec."BSExpenses Rent")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Rent';
                    }
                    field("BSExpenses Transport"; Rec."BSExpenses Transport")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Transport';
                    }
                    field("BSExpenses Education"; Rec."BSExpenses Education")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Education';
                    }
                    field("BSExpenses Food"; Rec."BSExpenses Food")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Food';
                    }
                    field("BSExpenses Utilities"; Rec."BSExpenses Utilities")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Utilities';
                    }
                    field("BSExpenses Others"; Rec."BSExpenses Others")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Others';
                    }
                }
                field("Bank Statement Net Income"; Rec."Bank Statement Net Income")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Rejection Details")
            {
                Visible = RejectionDetailsVisible;
                field("Rejection  Remark"; Rec."Rejection  Remark")
                {
                    ApplicationArea = Basic;
                }
                field("Rejected By"; Rec."Rejected By")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Rejection"; Rec."Date of Rejection")
                {
                    ApplicationArea = Basic;
                    Caption = 'Rejection Date';
                }

            }
            part(Control1000000001; "Loans Guarantee Details")
            {
                Caption = 'Guarantors  Detail';
                Editable = false;
                SubPageLink = "Loan No" = field("Loan  No.");
            }
            part(Control1000000000; "Loan Collateral Security")
            {
                Caption = 'Other Securities';
                SubPageLink = "Loan No" = field("Loan  No.");
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
                action("Loan Appraisal")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal';
                    Enabled = true;
                    Image = GanttChart;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        //Rec.TestField("Mode of Disbursement");
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            // if LoanApp.Source = LoanApp.Source::BOSA then
                            // Report.Run(50244, true, false, LoanApp)
                            // else
                            Report.Run(50384, true, false, LoanApp)
                        end;
                    end;
                }


                action("Member Statement")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."Client Code");
                        Report.Run(50886, true, false, Cust);
                    end;
                }

                action("House Group Statement")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        ObjMemberCellG.Reset;
                        ObjMemberCellG.SetRange(ObjMemberCellG."Cell Group Code", Rec."Member House Group");
                        Report.Run(50920, true, false, ObjMemberCellG);
                    end;
                }
                action("View Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'View Schedule';
                    Image = "Table";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    begin
                        // SFactory.FnGenerateLoanRepaymentSchedule(Rec."Loan  No.");
                        // Commit;
                        // LoanApp.Reset;
                        // LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        // if LoanApp.Find('-') then begin
                        //     Commit;
                        //     Report.Run(50477, true, false, LoanApp);
                        // end;

                        //  fngeneraterepaymentschedule.FnGenerateLoanRepaymentSchedule(Rec."Loan  No.");
                        SFactory.FnGenerateLoanRepaymentSchedule(Rec."Loan  No.");

                        Commit;
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then
                            Report.Run(50269, true, false, LoanApp);
                    end;
                }
                action("Loans to Offset")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans to Offset';
                    Image = AddAction;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Loan Offset Detail List-P";
                    RunPageLink = "Loan No." = field("Loan  No."),
                                  "Client Code" = field("Client Code");
                }
                action("Post Loans")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Loan';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        VarMailSubject: Text[200];
                        VarMailBody: Text[250];
                    begin
                        FnRunCheckLoanStages;//=======================Check that All loan Stages are Succesful
                        if Rec."Disburesment Type" = Rec."disburesment type"::"Tranche/Multiple Disbursement" then
                            Error('You cannot post a Tranche/Multiple Disbursement Loan from this window. Go to the Partial Loan Disbursement List to post this loan');


                        //Check if Collateral Details have been Updated
                        ObjCollateral.Reset;
                        ObjCollateral.SetRange(ObjCollateral."Loan No", Rec."Loan  No.");
                        if ObjCollateral.FindSet = true then begin
                            if ObjCollateral."Collateral Registe Doc" = '' then begin
                                Error('Update the Collateral details on the Collateral register # Go to collateral details>>Collateral register Doc');
                            end;
                            if ObjCollateral.Value = 0 then begin
                                Error('Update the Collateral market value')
                            end;
                            if ObjCollateral."Registered Owner" = '' then begin
                                Error('Update the Collateral Registered Owner')
                            end;
                            if ObjCollateral."Reference No" = '' then begin
                                Error('Update the Collateral Reference No')
                            end;
                        end;



                        if Rec.Posted = true then
                            Error('Loan already posted.');
                        if Rec."Approved Amount" <= 0 then
                            Error('You cannot post this Amount Less or Equal to Zero');
                        if Confirm('Are you sure you want to post this loan?', true) = false then
                            exit;
                        RepaySched.Reset;
                        RepaySched.SetRange(RepaySched."Loan No.", Rec."Loan  No.");
                        if not RepaySched.Find('-') then begin
                            FnGenerateSchedule();
                        end;

                        LoanGuar.Reset;
                        LoanGuar.SetRange(LoanGuar."Loan No", Rec."Loan  No.");
                        if LoanGuar.Find('-') then begin
                            repeat
                                Cust.Reset;
                                Cust.SetRange(Cust."No.", LoanGuar."Member No");
                                if Cust.Find('-') then begin
                                    SFactory.FnSendSMS('LOAN GUARANTORS', 'You have guaranteed an amount of ' + Format(LoanGuar."Amont Guaranteed")
                                   + ' to ' + Rec."Client Name" + ' Staff No:-' + Rec."Staff No" + ' ' +
                                   'Loan Type ' + Rec."Loan Product Type" + ' of ' + Format(Rec."Requested Amount") + ' at RUAI ENDELEA Sacco Ltd.', Cust."FOSA Account No.", Cust."Phone No.");
                                end;
                            until LoanGuar.Next = 0;
                        end;
                        SFactory.FnSendSMS('LOAN ISSUE', 'Your loan application of KSHs.' + Format(Rec."Approved Amount") + ' has been issued.', Cust."FOSA Account No.", Cust."Phone No.");

                        Rec.TestField("Loan Disbursement Date");
                        Rec."Posting Date" := Rec."Loan Disbursement Date";

                        if Template.Get(UserId) then begin
                            Jtemplate := Template."loan Template Name";
                            Jbatch := Template."loan Batch Name";
                        end else begin
                            Error('Set up your user details on the User Template Page # Go to Home >> Settings >> My Settings >>  User Template');
                        end;


                        DOCUMENT_NO := Rec."Loan  No.";
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                        GenJournalLine.SetRange("Journal Batch Name", Jbatch);
                        GenJournalLine.DeleteAll;


                        //============================================================Send Repayment Schedule Via Mail
                        ObjLoans.Reset;
                        ObjLoans.SetRange(ObjLoans."Loan  No.", Rec."Loan  No.");
                        if ObjLoans.FindSet then begin
                            if ObjMember.Get(Rec."Client Code") then begin
                                if (ObjMember."Email Indemnified" = true) and (ObjMember."E-Mail" <> '') then begin
                                    VarMemberEmail := Lowercase(ObjMember."E-Mail");

                                    // SMTPSetup.Get();
                                    // Filename:='';
                                    // Filename:= SMTPSetup."Path to Save Report"+'Loan Repayment Schedule.pdf';
                                    // Report.SaveAsPdf(Report::"Loans Repayment Schedule",Filename,ObjLoans);

                                    // VarMailSubject:='Loan Repayment Schedule - '+"Loan  No.";
                                    // VarMailBody:='Please find attached the loan repayment schedule for your '+"Loan Product Type Name"+' Account '+"Loan  No."+' of Ksh. '+Format("Approved Amount");

                                    // EmailSend:=SFactory.FnSendStatementViaMail("Client Name",VarMailSubject,VarMailBody, VarMemberEmail,'Loan Repayment Schedule.pdf','');
                                    //============================================================End Send Repayment Schedule Via Mail
                                end;
                            end;
                        end;

                        //if Rec."Mode of Disbursement" = Rec."mode of disbursement"::"Bank Transfer" then begin
                        // FnDisburseToCurrentAccount(Rec);

                        LoanApps.Reset;
                        LoanApps.SetRange(LoanApps."Loan  No.", Rec."Loan  No.");
                        if LoanApps.FindSet then begin
                            FnInsertBOSALines(LoanApps, LoanApps."Loan  No.");
                        end;



                        //CU posting
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                        GenJournalLine.SetRange("Journal Batch Name", Jbatch);
                        if GenJournalLine.Find('-') then
                            //mjk
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco21", GenJournalLine);

                        Rec.Posted := true;
                        Rec."Loan Status" := Rec."loan status"::Disbursed;
                        Rec."Issued Date" := Today;
                        Rec."Offset Eligibility Amount" := Rec."Approved Amount" * 0.5;
                        if (Rec."Disburesment Type" = Rec."disburesment type"::" ") or (Rec."Disburesment Type" = Rec."disburesment type"::"Full/Single disbursement") then begin
                            Rec."Tranch Amount Disbursed" := Rec."Approved Amount"
                        end else
                            Rec."Tranch Amount Disbursed" := Rec."Amount to Disburse on Tranch 1";
                        Rec.Modify;
                        // end;


                        //Update Share Boosted Deposits
                        FnUpdateShareBoostedTrans();
                        // FnRunCreateLSAfor1sttimeLoanees;//=======================================Create LSA Account For 1st time Loanees
                        FnRunUpdateDisburesmentLoanStage;//======================================Update Disburesment Loan Stage on the Loan Application Stages
                        Message('Loan Posted successfully. The Member and the attached guarantors will be notified via an SMS.');
                        CurrPage.Close;
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        //ApprovalMgt.SendLoanApprRequest(Rec);
                        if Confirm('Are you sure you want to cancel the approval request', false) = true then begin
                            Rec."Loan Status" := Rec."loan status"::Application;
                            Rec."Approval Status" := Rec."approval status"::Open;
                            Rec.Modify;
                        end;
                    end;
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin

                        DocumentType := Documenttype::LoanApplication;
                        ApprovalEntries.Setfilters(Database::"Loans Register", DocumentType, Rec."Loan  No.");
                        ApprovalEntries.Run;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        EditableField := true;
    end;

    trigger OnAfterGetRecord()
    begin
        EditableField := true;
        UpdateControl();

        TrunchDetailsVisible := false;

        if (Rec."Disburesment Type" = Rec."disburesment type"::"Full/Single disbursement") or (Rec."Disburesment Type" = Rec."disburesment type"::" ") then begin
            TrunchDetailsVisible := false;
        end else
            TrunchDetailsVisible := true;
    end;

    trigger OnOpenPage()
    begin
        EditableField := true;

        TrunchDetailsVisible := false;

        if (Rec."Disburesment Type" = Rec."disburesment type"::"Full/Single disbursement") or (Rec."Disburesment Type" = Rec."disburesment type"::" ") then begin
            TrunchDetailsVisible := false;
        end else
            TrunchDetailsVisible := true;
    end;

    var
        fngeneraterepaymentschedule: Codeunit "Generate Loan Repayment Sched";
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
        CustomerRecord: Record customer;
        Gnljnline: Record "Gen. Journal Line";
        Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
        CumInterest: Decimal;
        NewPrincipal: Decimal;
        PeriodPrRepayment: Decimal;
        GenBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
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
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal;
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
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
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
        // PartPay: Record "Loan Partial Disburesments";
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
        CummulativeGuarantee: Decimal;
        LoansRec: Record "Loans Register";
        RecoveryModeEditable: Boolean;
        RemarksEditable: Boolean;
        CopyofIDEditable: Boolean;
        CopyofPayslipEditable: Boolean;
        ScheduleBal: Decimal;
        SFactory: Codeunit "Micropoint Factory";
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        ReschedulingFees: Decimal;
        ReschedulingFeeAccount: Code[50];
        LoanProcessingFee: Decimal;
        ExciseDuty: Decimal;
        EditableField: Boolean;
        DOCUMENT_NO: Code[40];
        PayslipDetailsVisible: Boolean;
        BankStatementDetailsVisible: Boolean;
        ObjProductCharge: Record "Loan Product Charges";
        ObjAccountLedger: Record "Detailed Vendor Ledg. Entry";
        ObjStatementB: Record "Loan Appraisal Statement Buffe";
        StatementStartDate: Date;
        StatementDateFilter: Date;
        StatementEndDate: Date;
        VerStatementAvCredits: Decimal;
        VerStatementsAvDebits: Decimal;
        VerMonth1Date: Integer;
        VerMonth1Month: Integer;
        VerMonth1Year: Integer;
        VerMonth1StartDate: Date;
        VerMonth1EndDate: Date;
        VerMonth1DebitAmount: Decimal;
        VerMonth1CreditAmount: Decimal;
        VerMonth2Date: Integer;
        VerMonth2Month: Integer;
        VerMonth2Year: Integer;
        VerMonth2StartDate: Date;
        VerMonth2EndDate: Date;
        VerMonth2DebitAmount: Decimal;
        VerMonth2CreditAmount: Decimal;
        VerMonth3Date: Integer;
        VerMonth3Month: Integer;
        VerMonth3Year: Integer;
        VerMonth3StartDate: Date;
        VerMonth3EndDate: Date;
        VerMonth3DebitAmount: Decimal;
        VerMonth3CreditAmount: Decimal;
        VerMonth4Date: Integer;
        VerMonth4Month: Integer;
        VerMonth4Year: Integer;
        VerMonth4StartDate: Date;
        VerMonth4EndDate: Date;
        VerMonth4DebitAmount: Decimal;
        VerMonth4CreditAmount: Decimal;
        VerMonth5Date: Integer;
        VerMonth5Month: Integer;
        VerMonth5Year: Integer;
        VerMonth5StartDate: Date;
        VerMonth5EndDate: Date;
        VerMonth5DebitAmount: Decimal;
        VerMonth5CreditAmount: Decimal;
        VerMonth6Date: Integer;
        VerMonth6Month: Integer;
        VerMonth6Year: Integer;
        VerMonth6StartDate: Date;
        VerMonth6EndDate: Date;
        VerMonth6DebitAmount: Decimal;
        VerMonth6CreditAmount: Decimal;
        VarMonth1Datefilter: Text;
        VarMonth2Datefilter: Text;
        VarMonth3Datefilter: Text;
        VarMonth4Datefilter: Text;
        VarMonth5Datefilter: Text;
        VarMonth6Datefilter: Text;
        ObjCollateral: Record "Loan Collateral Details";
        ObjCust: Record customer;
        ObjMemberLedg: Record "Cust. Ledger Entry";
        ObjMemberCellG: Record "Member House Groups";
        VarAmounttoDisburse: Decimal;
        TrunchDetailsVisible: Boolean;
        LInsurance: Decimal;
        RejectionDetailsVisible: Boolean;
        ObjLoanStages: Record "Loan Stages";
        ObjLoanApplicationStages: Record "Loan Application Stages";
        EmailSend: Boolean;
        ObjMember: Record customer;
        VarMemberEmail: Text[50];
        Filename: Text[100];
        //  SMTPSetup: Record "SMTP Mail Setup";
        ObjLoans: Record "Loans Register";
        Template: Record "BOSA&FOSA User Template";
        Jtemplate: Code[100];
        Jbatch: Code[100];


    procedure UpdateControl()
    begin
        if Rec."Approval Status" = Rec."approval status"::Open then begin
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
            BatchNoEditable := false;
            RemarksEditable := false;
        end;

        if Rec."Approval Status" = Rec."approval status"::Pending then begin
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
            BatchNoEditable := false;
            RemarksEditable := false;
        end;

        if Rec."Approval Status" = Rec."approval status"::Rejected then begin
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
            BatchNoEditable := false;
            RemarksEditable := false;
        end;

        if Rec."Approval Status" = Rec."approval status"::Approved then begin
            MNoEditable := false;
            AccountNoEditable := false;
            LoanStatusEditable := false;
            ApplcDateEditable := false;
            LProdTypeEditable := false;
            InstallmentEditable := true;
            AppliedAmountEditable := false;
            RepayMethodEditable := false;
            RepaymentEditable := false;
            BatchNoEditable := true;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := true;
            RejectionRemarkEditable := false;
            BatchNoEditable := true;
            RemarksEditable := false;
            ApprovedAmountEditable := false;
            ObjCollateral.Reset;
            ObjCollateral.SetRange(ObjCollateral."Loan No", Rec."Loan  No.");
            if ObjCollateral.FindSet = true then begin
                ApprovedAmountEditable := true;
            end;

        end;
    end;


    procedure LoanAppPermisions()
    begin
    end;

    local procedure FnGenerateSchedule()
    begin
        if Rec."Repayment Frequency" = Rec."repayment frequency"::Daily then
            Evaluate(InPeriod, '1D')
        else if Rec."Repayment Frequency" = Rec."repayment frequency"::Weekly then
            Evaluate(InPeriod, '1W')
        else if Rec."Repayment Frequency" = Rec."repayment frequency"::Monthly then
            Evaluate(InPeriod, '1M')
        else if Rec."Repayment Frequency" = Rec."repayment frequency"::Quaterly then
            Evaluate(InPeriod, '1Q');


        QCounter := 0;
        QCounter := 3;
        ScheduleBal := 0;
        // GrPrinciple := "Grace Period;//- Principle (M)";
        // GrInterest := "Grace Period - Interest (M)";
        // InitialGraceInt := "Grace Period - Interest (M)";

        LoansR.Reset;
        LoansR.SetRange(LoansR."Loan  No.", Rec."Loan  No.");
        if LoansR.Find('-') then begin

            Rec.TestField("Loan Disbursement Date");
            Rec.TestField("Repayment Start Date");

            RSchedule.Reset;
            RSchedule.SetRange(RSchedule."Loan No.", Rec."Loan  No.");
            RSchedule.DeleteAll;

            LoanAmount := LoansR."Approved Amount" + LoansR."Capitalized Charges";
            InterestRate := LoansR.Interest;
            RepayPeriod := LoansR.Installments;
            InitialInstal := LoansR.Installments + Rec."Grace Period - Principle (M)";
            LBalance := LoansR."Approved Amount" + LoansR."Capitalized Charges";
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
            else if Rec."Repayment Frequency" = Rec."repayment frequency"::Quaterly then
                RunDate := CalcDate('-1Q', RunDate);
            //Repayment Frequency


            repeat
                InstalNo := InstalNo + 1;
                ScheduleBal := LBalance;

                //*************Repayment Frequency***********************//
                if Rec."Repayment Frequency" = Rec."repayment frequency"::Daily then
                    RunDate := CalcDate('1D', RunDate)
                else if Rec."Repayment Frequency" = Rec."repayment frequency"::Weekly then
                    RunDate := CalcDate('1W', RunDate)
                else if Rec."Repayment Frequency" = Rec."repayment frequency"::Monthly then
                    RunDate := CalcDate('1M', RunDate)
                else if Rec."Repayment Frequency" = Rec."repayment frequency"::Quaterly then
                    RunDate := CalcDate('1Q', RunDate);






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
                    end else begin
                        LInterest := ROUND((InterestRate / 1200) * LoanAmount, 1, '>');
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
                end else begin
                    if Rec."Instalment Period" <> InPeriod then
                        LBalance := LBalance - LPrincipal;
                    ScheduleBal := ScheduleBal - LPrincipal;
                end;

                if GrInterest > 0 then
                    LInterest := 0;

                GrPrinciple := GrPrinciple - 1;
                GrInterest := GrInterest - 1;
                LInterest := ROUND(LoansR."Approved Amount" * LoansR.Interest / 12 * (RepayPeriod + 1) / (200 * RepayPeriod), 0.05, '>'); //For Nafaka Only
                                                                                                                                          //Grace Period
                RSchedule.Init;
                RSchedule."Repayment Code" := RepayCode;
                RSchedule."Loan No." := Rec."Loan  No.";
                RSchedule."Loan Amount" := LoanAmount;
                RSchedule."Instalment No" := InstalNo;
                RSchedule."Repayment Date" := CalcDate('CM', RunDate);
                RSchedule."Member No." := Rec."Client Code";
                RSchedule."Loan Category" := Rec."Loan Product Type";
                RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                RSchedule."Monthly Interest" := LInterest;
                RSchedule."Principal Repayment" := LPrincipal;
                RSchedule."Loan Balance" := ScheduleBal;
                RSchedule.Insert;
                WhichDay := Date2dwy(RSchedule."Repayment Date", 1);


            until LBalance < 1

        end;
        Commit;
    end;

    local procedure FnDisburseToCurrentAccount(LoanApps: Record "Loans Register")
    var
        ProcessingFees: Decimal;
        ProcessingFeesAcc: Code[50];
        PChargeAmount: Decimal;
        BLoan: Code[30];
        ObjLoans: Record "Loans Register";
        ObjLoanType: Record "Loan Products Setup";
        VarLoanInsuranceBalAccount: Code[30];
    begin
        /*
        No JtemplateText
        No JbatchText
        NoDocumentNoCode30
        NoLineNoInteger
        NoTransactionTypeOption
        NoAccountTypeOption
        NoAccountNoCode50
        NoTransactionDateDate
        NoTransactionAmountDecimal
        NoDimensionActivityCode40
        NoExternalDocumentNoCode50
        NoTransactionDescriptionText
        NoLoanNumberCode50
        */

        GenSetUp.Get();
        LoanApps.CalcFields(LoanApps."Loan Offset Amount", LoanApps."Offset iNTEREST");
        TCharges := 0;
        TopUpComm := 0;
        TotalTopupComm := LoanApps."Loan Offset Amount";

        if (Rec."Disburesment Type" = Rec."disburesment type"::"Full/Single disbursement") or (Rec."Disburesment Type" = Rec."disburesment type"::" ") then begin
            VarAmounttoDisburse := Rec."Approved Amount"
        end else
            VarAmounttoDisburse := Rec."Amount to Disburse on Tranch 1";

        Message('amount Disburse is  %1', VarAmounttoDisburse);

        //------------------------------------1. DEBIT MEMBER LOAN A/C---------------------------------------------------------------------------------------------
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Loan,
        GenJournalLine."account type"::Customer, LoanApps."Client Code", Rec."Posting Date", VarAmounttoDisburse, Format(LoanApps.Source), LoanApps."Loan  No.",
        LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."application source"::" ");
        //--------------------------------(Debit Member Loan Account)---------------------------------------------

        //------------------------------------2. CREDIT MEMBER FOSA A/C---------------------------------------------------------------------------------------------
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Customer, LoanApps."Client Code", Rec."Posting Date", VarAmounttoDisburse * -1, 'BOSA', LoanApps."Loan  No.",
        'Loan Issued- ' + LoanApps."Loan Product Type Name", LoanApps."Loan  No.", GenJournalLine."application source"::" ");
        //----------------------------------(Credit Member Fosa Account)------------------------------------------------

        //------------------------------------3. EARN/RECOVER PRODUCT CHARGES FROM FOSA A/C--------------------------------------
        PCharges.Reset;
        PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
        PCharges.SetFilter(PCharges."Loan Charge Type", '<>%1', PCharges."loan charge type"::"Loan Insurance");
        if PCharges.Find('-') then begin
            repeat
                PCharges.TestField(PCharges."G/L Account");
                GenSetUp.TestField(GenSetUp."Excise Duty Account");
                PChargeAmount := PCharges.Amount;
                if PCharges."Use Perc" = true then
                    PChargeAmount := (LoanApps."Approved Amount" * PCharges.Percentage / 100);//LoanDisbAmount
                //-------------------EARN CHARGE-------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", PCharges."G/L Account", Rec."Posting Date", PChargeAmount * -1, '', LoanApps."Loan  No.",
                PCharges.Description + '-' + LoanApps."Client Code" + '-' + '-' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."application source"::" ");
                //-------------------RECOVER-----------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Customer, LoanApps."Client Code", Rec."Posting Date", PChargeAmount, '', LoanApps."Loan  No.",
                PCharges.Description + '-' + LoanApps."Loan Product Type Name", LoanApps."Loan  No.", GenJournalLine."application source"::" ");

                //------------------10% EXCISE DUTY----------------------------------------
                if SFactory.FnChargeExcise(PCharges.Code) then begin
                    //-------------------Earn---------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", GenSetUp."Excise Duty Account", Rec."Posting Date", (PChargeAmount * -1) * 0.1, '', LoanApps."Loan  No.",
                    PCharges.Description + '-' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No." + '- Excise(10%)', LoanApps."Loan  No.", GenJournalLine."application source"::" ");
                    //-----------------Recover---------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Customer, LoanApps."Client Code", Rec."Posting Date", PChargeAmount * 0.1, '', LoanApps."Loan  No.",
                    PCharges.Description + '-' + LoanApps."Loan Product Type Name" + ' - Excise(10%)', LoanApps."Loan  No.", GenJournalLine."application source"::" ");
                end
            //----------------END 10% EXCISE--------------------------------------------
            until PCharges.Next = 0;
        end;


        //----------------------------------------4. PAY/RECOVER TOP UPS------------------------------------------------------------------------------------------
        if LoanApps."Loan Offset Amount" > 0 then begin
            LoanTopUp.Reset;
            LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
            if LoanTopUp.Find('-') then begin
                repeat
                    //------------------------------------PAY-----------------------------------------------------------------------------------------------------------
                    //------------------------------------Principal---------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                    GenJournalLine."account type"::Customer, LoanApps."Client Code", Rec."Posting Date", LoanTopUp."Principle Top Up" * -1, 'BOSA', LoanTopUp."Loan Top Up",
                    'Off Set By - ' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                    //------------------------------------Outstanding Interest----------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                    GenJournalLine."account type"::Customer, LoanApps."Client Code", Rec."Posting Date", LoanTopUp."Interest Top Up" * -1, 'BOSA', LoanTopUp."Loan Top Up",
                    'Interest Paid- ' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                    //-------------------------------------Levy--------------------------
                    LineNo := LineNo + 10000;
                    if LoanType.Get(LoanApps."Loan Product Type") then begin
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::"G/L Account", LoanType."Top Up Commision Account", Rec."Posting Date", LoanTopUp.Commision * -1, 'BOSA', LoanTopUp."Loan Top Up",
                        'Levy on Bridging -' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                    end;

                    //-------------------------------------Loan Insurance--------------------------
                    LineNo := LineNo + 10000;
                    if LoanType.Get(LoanApps."Loan Product Type") then begin
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Paid",
                        GenJournalLine."account type"::Customer, LoanApps."Client Code", Rec."Posting Date", LoanTopUp."Loan Insurance: Current Year" * -1, 'BOSA', LoanTopUp."Loan Top Up",
                        'Insurance on Loan Clearance -' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                    end;

                    if ObjLoans.Get(LoanTopUp."Loan Top Up") then begin
                        if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                            VarLoanInsuranceBalAccount := ObjLoanType."Receivable Insurance Accounts";
                        end;
                    end;


                    //------------------------------------DEBIT INSURANCE FOR THE CURRENT YEAR  A/C---------------------------------------------------------------------------------------------

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Charged",
                    GenJournalLine."account type"::Customer, LoanApps."Client Code", WorkDate, 'Loan Insurance:Diff. Calender Year _' + LoanTopUp."Loan Top Up", GenJournalLine."bal. account type"::"G/L Account",
                    VarLoanInsuranceBalAccount, LoanTopUp."Loan Insurance: Current Year", 'FOSA', LoanTopUp."Loan Top Up");
                    //--------------------------------(Credit Loan Penalty Account)-------------------------------------------------------------------------------

                    //-------------------------------------RECOVER-------------------------------------------------------------------------------------------------------
                    //-------------------------------------Principal-----------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Customer, LoanApps."Client Code", Rec."Posting Date", LoanTopUp."Principle Top Up", 'BOSA', LoanTopUp."Loan Top Up",
                    'Loan Offset  - ' + LoanApps."Loan Product Type Name", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                    //-------------------------------------Outstanding Interest-------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Customer, LoanApps."Client Code", Rec."Posting Date", LoanTopUp."Interest Top Up", 'BOSA', LoanTopUp."Loan Top Up",
                    'Interest Paid on topup - ' + LoanApps."Loan Product Type Name", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");

                    //-------------------------------------Insurance For the Year-------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Customer, LoanApps."Client Code", Rec."Posting Date", LoanTopUp."Loan Insurance: Current Year", 'BOSA', LoanTopUp."Loan Top Up",
                    'Insurance on Loan Clearance - ' + LoanApps."Loan Product Type Name", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                    //--------------------------------------Levies--------------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    if LoanType.Get(LoanApps."Loan Product Type") then begin
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Customer, LoanApps."Client Code", Rec."Posting Date", LoanTopUp.Commision, 'BOSA', LoanTopUp."Loan Top Up",
                        'Levy on Bridging - ' + LoanApps."Loan Product Type Name", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                    end;

                    //------------------------------Credit Excise Duty Account-----------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", GenSetUp."Excise Duty Account", Rec."Posting Date", (LoanTopUp.Commision * (GenSetUp."Excise Duty(%)" / 100)) * -1, 'BOSA', BLoan,
                    'Excise Duty_Levy on Bridging', BLoan, GenJournalLine."application source"::" ");

                    //----------------------Debit FOSA A/C Excise Duty on Bridging Fee-----------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Customer, LoanApps."Client Code", Rec."Posting Date", (LoanTopUp.Commision * (GenSetUp."Excise Duty(%)" / 100)), 'BOSA', BLoan,
                    'Excise Duty_Levy on Bridging', BLoan, GenJournalLine."application source"::" ");
                until LoanTopUp.Next = 0;
            end;
        end;

        //-----------------------------------------Accrue Interest Disburesment--------------------------------------------------------------------------------------------
        if LoanType.Get(LoanApps."Loan Product Type") then begin
            if LoanType."Accrue Total Insurance&Interes" = true then begin

                //----------------------Debit interest Receivable Account a/c-----------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Due",
                GenJournalLine."account type"::Customer, LoanApps."Client Code", Rec."Posting Date", (LoanApps."Approved Amount" * (LoanType."Interest rate" / 1200)) * LoanType."No of Installment", 'BOSA', BLoan,
                'Interest Due' + '_' + LoanApps."Loan  No.", BLoan, GenJournalLine."application source"::" ");

                //----------------------Credit interest Income Account a/c-----------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", LoanType."Loan Interest Account", Rec."Posting Date", ((LoanApps."Approved Amount" * (LoanType."Interest rate" / 1200)) * LoanType."No of Installment") * -1, 'BOSA', BLoan,
                'Interest Due' + '_' + LoanApps."Loan  No.", BLoan, GenJournalLine."application source"::" ");
            end;
        end;


        //-----------------------------------------Accrue insurance on Disburesment--------------------------------------------------------------------------------------------

        if LoanType.Get(LoanApps."Loan Product Type") then begin
            if LoanType."Accrue Total Insurance&Interes" = true then begin


                PCharges.Reset;
                PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
                PCharges.SetRange(PCharges."Loan Charge Type", PCharges."loan charge type"::"Loan Insurance");
                if PCharges.Find('-') then begin
                    PCharges.TestField(PCharges."G/L Account");
                    GenSetUp.TestField(GenSetUp."Excise Duty Account");
                    PChargeAmount := PCharges.Amount;
                    if PCharges."Use Perc" = true then
                        PChargeAmount := (LoanApps."Approved Amount" * PCharges.Percentage / 100);
                    //----------------------Debit insurance Receivable Account a/c-----------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Charged",
                    GenJournalLine."account type"::Customer, LoanApps."Client Code", Rec."Posting Date", PChargeAmount * LoanType."No of Installment", 'BOSA', BLoan,
                    'Insurance Charged' + '_' + LoanApps."Loan  No.", BLoan, GenJournalLine."application source"::" ");

                    //----------------------Credit Insurance Payable Account a/c-----------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", LoanType."Loan Insurance Accounts", Rec."Posting Date", (PChargeAmount * LoanType."No of Installment") * -1, 'BOSA', BLoan,
                    'Insurance Charged' + '_' + LoanApps."Loan  No.", BLoan, GenJournalLine."application source"::" ");
                end;
            end;
        end;



        //-----------------------------------------5. BOOST DEPOSITS COMMISSION / RECOVER FROM FOSA A/C--------------------------------------------------------------------------------------------
        if LoanApps."Share Boosting Comission" > 0 then begin

            //----------------------Debit FOSA a/c-----------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Customer, SFactory.FnGetFosaAccount(LoanApps."Client Code"), Rec."Posting Date", LoanApps."Share Boosting Comission", 'BOSA', BLoan,
            'Deposits Boosting Fee', BLoan, GenJournalLine."application source"::" ");

            GenSetUp.Get();
            //------------------------------Credit Income G/L-----------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", GenSetUp."Boosting Fees Account", Rec."Posting Date", LoanApps."Share Boosting Comission" * -1, 'BOSA', BLoan,
            'Deposits Boosting Fee', BLoan, GenJournalLine."application source"::" ");

            //----------------------Debit FOSA A/C Excise Duty on Boosting Fee-----------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Customer, SFactory.FnGetFosaAccount(LoanApps."Client Code"), Rec."Posting Date", (LoanApps."Share Boosting Comission" * (GenSetUp."Excise Duty(%)" / 100)), 'BOSA', BLoan,
            'Excise Duty_Boosting Fee', BLoan, GenJournalLine."application source"::" ");

            GenSetUp.Get();
            //------------------------------Credit Excise Duty Account-----------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", GenSetUp."Excise Duty Account", Rec."Posting Date", (LoanApps."Share Boosting Comission" * (GenSetUp."Excise Duty(%)" / 100)) * -1, 'BOSA', BLoan,
            'Excise Duty_Boosting Fee', BLoan, GenJournalLine."application source"::" ");


        end;




        LoanApps."Net Payment to FOSA" := LoanApps."Approved Amount";
        LoanApps."Processed Payment" := true;
        Rec.Modify;

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
    begin
        AmountTop := 0;
        NetAmount := 0;

        //--------------------Generate Schedule
        if Template.Get(UserId) then begin

            Jbatch := Template."loan Batch Name";
        end else begin
            Error('Set up your user details on the User Template Page # Go to Home >> Settings >> My Settings >>  User Template');
        end;
        DirbursementDate := Rec."Loan Disbursement Date";

        if (Rec."Disburesment Type" = Rec."disburesment type"::" ") or (Rec."Disburesment Type" = Rec."disburesment type"::"Full/Single disbursement") then begin
            VarAmounttoDisburse := Round(Rec."Approved Amount", 1, '=');
        end else
            VarAmounttoDisburse := Rec."Amount to Disburse on Tranch 1";
        Rec.Validate("Amount to Disburse on Tranch 1");


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
        SFactory.FnCreateGnlJournalLine(Jtemplate, Jbatch, Rec."Loan  No.", LineNo, GenJournalLine."Transaction Type"::Loan,
         GenJournalLine."Account Type"::Customer, LoanApps."Client Code", DirbursementDate, VarAmounttoDisburse, 'BOSA',
         LoanApps."Loan  No.", 'Loan Disbursement - ' + LoanApps."Loan Product Type", LoanApps."Loan  No.", GenJournalLine."application source"::" ");



        //--------------------------------RECOVER OVERDRAFT()-------------------------------------------------------

        //Code Here

        //...................Cater for Loan Offset Now !
        Rec.CalcFields("Top Up Amount");
        // if Rec."Top Up Amount" > 0 then begin
        if Rec."Loan Offset Amount" > 0 then begin
            LoanTopUp.RESET;
            LoanTopUp.SETRANGE(LoanTopUp."Loan No.", Rec."Loan  No.");
            IF LoanTopUp.FIND('-') THEN BEGIN
                repeat
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(Jtemplate, Jbatch, Rec."Loan  No.", LineNo, GenJournalLine."Transaction Type"::"Loan Repayment", GenJournalLine."Account Type"::Customer, LoanApps."Client Code", DirbursementDate, LoanTopUp."Principle Top Up" * -1, 'BOSA', LoanApps."Loan  No.", 'Loan OffSet By - ' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                    //..................Recover Interest On Top Up
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(Jtemplate, Jbatch, Rec."Loan  No.", LineNo, GenJournalLine."Transaction Type"::"Interest Paid", GenJournalLine."Account Type"::Customer, LoanApps."Client Code", DirbursementDate, LoanTopUp."Interest Top Up" * -1, 'BOSA', LoanApps."Loan  No.", 'Interest Due Paid on top up - ', LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                    //If there is top up commission charged write it here start
                    LineNo := LineNo + 10000;
                    AmountTop := (LoanTopUp."Principle Top Up" + LoanTopUp."Interest Top Up" + LoanTopUp.Commision);
                    VarAmounttoDisburse := VarAmounttoDisburse - (LoanTopUp."Principle Top Up" + LoanTopUp."Interest Top Up" + LoanTopUp.Commision);
                UNTIL LoanTopUp.NEXT = 0;
            END;
        end;


        //***************************Loan Product Charges code


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
                // Message('Charge Amount is %1', PChargeAmount);
                //Jtemplate, Jbatch, LoanApps."Loan  No."
                // Message('T.%1...#B.%2...#Doc.%3', Jtemplate, Jbatch, LoanApps."Loan  No.");
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(Jtemplate, Jbatch, LoanApps."Loan  No.", LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", PCharges."G/L Account", DirbursementDate, PChargeAmount * -1, 'BOSA', LoanApps."Loan  No.",
                PCharges.Description + '-' + LoanApps."Client Code" + '-' + '-' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."application source"::" ");
                VarAmounttoDisburse := VarAmounttoDisburse - PChargeAmount;


                //-------------------RECOVER-----------------------------------------------

                //------------------10% EXCISE DUTY----------------------------------------
                if SFactory.FnChargeExcise(PCharges.Code) then begin
                    //-------------------Earn---------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(Jtemplate, Jbatch, LoanApps."Loan  No.", LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", GenSetUp."Excise Duty Account", DirbursementDate, (PChargeAmount * -1) * 0.1, 'BOSA', LoanApps."Loan  No.",
                    PCharges.Description + '-' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No." + '- Excise(10%)', LoanApps."Loan  No.", GenJournalLine."application source"::" ");
                    //-----------------Recover---------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(Jtemplate, Jbatch, LoanApps."Loan  No.", LineNo, GenJournalLine."transaction type"::" ",
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
                SFactory.FnCreateGnlJournalLine(Jtemplate, Jbatch, LoanApps."Loan  No.", LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", PCharges."G/L Account", DirbursementDate, PChargeAmount * -1, 'BOSA', LoanApps."Loan  No.",
                PCharges.Description + '-' + LoanApps."Client Code" + '-' + '-' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."application source"::" ");
                VarAmounttoDisburse := VarAmounttoDisburse - PChargeAmount;


                //-------------------RECOVER-----------------------------------------------

                //------------------10% EXCISE DUTY----------------------------------------
                if SFactory.FnChargeExcise(PCharges.Code) then begin
                    //-------------------Earn---------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(Jtemplate, Jbatch, LoanApps."Loan  No.", LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", GenSetUp."Excise Duty Account", DirbursementDate, (PChargeAmount * -1) * 0.1, 'BOSA', LoanApps."Loan  No.",
                    PCharges.Description + '-' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No." + '- Excise(10%)', LoanApps."Loan  No.", GenJournalLine."application source"::" ");
                    //-----------------Recover---------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(Jtemplate, Jbatch, LoanApps."Loan  No.", LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Customer, LoanApps."Client Code", DirbursementDate, PChargeAmount * 0.1, 'BOSA', LoanApps."Loan  No.",
                    PCharges.Description + '-' + LoanApps."Loan Product Type Name" + ' - Excise(10%)', LoanApps."Loan  No.", GenJournalLine."application source"::" ");
                end
            //----------------END 10% EXCISE--------------------------------------------
            until PCharges.Next = 0;
        end;


        NetAmount := Rec."Approved Amount" - (Rec."Loan Processing Fee" + Rec."Loan Appraisal Fee" + Rec."Loan Insurance" + AmountTop);

        //------------------------------------2. CREDIT MEMBER BANK A/C---------------------------------------------------------------------------------------------
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(Jtemplate, Jbatch, Rec."Loan  No.", LineNo, GenJournalLine."Transaction Type"::" ", GenJournalLine."Account Type"::"Bank Account", LoanApps."Paying Bank Account No", DirbursementDate, VarAmounttoDisburse * -1, 'BOSA', LoanApps."Loan  No.", 'Loan Principle Amount ' + Format(Rec."Loan  No."), '', GenJournalLine."application source"::" ");
    end;

    local procedure FnBoosterLoansDisbursement(ObjLoanDetails: Record "Loans Register"; LineNo: Integer): Code[40]
    var
        GenJournalLine: Record "Gen. Journal Line";
        CUNoSeriesManagement: Codeunit NoSeriesManagement;
        DocNumber: Code[100];
        loanTypes: Record "Loan Products Setup";
        ObjLoanX: Record "Loans Register";
    begin
        loanTypes.Reset;
        loanTypes.SetRange(loanTypes.Code, 'BLOAN');
        if loanTypes.Find('-') then begin
            DocNumber := CUNoSeriesManagement.GetNextNo('LOANSB', 0D, true);
            LoansRec.Init;
            LoansRec."Loan  No." := DocNumber;
            LoansRec.Insert;

            if LoansRec.Get(LoansRec."Loan  No.") then begin
                LoansRec."Client Code" := ObjLoanDetails."Client Code";
                LoansRec.Validate(LoansRec."Client Code");
                LoansRec."Loan Product Type" := 'BLOAN';
                LoansRec.Validate(LoansRec."Loan Product Type");
                LoansRec.Interest := ObjLoanDetails.Interest;
                LoansRec."Loan Status" := LoansRec."loan status"::Closed;
                LoansRec."Application Date" := ObjLoanDetails."Application Date";
                LoansRec."Issued Date" := ObjLoanDetails."Posting Date";
                LoansRec."Loan Disbursement Date" := ObjLoanDetails."Loan Disbursement Date";
                LoansRec.Validate(LoansRec."Loan Disbursement Date");
                LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::"Bank Transfer";
                LoansRec."Repayment Start Date" := ObjLoanDetails."Repayment Start Date";
                LoansRec."Global Dimension 1 Code" := 'BOSA';
                LoansRec."Global Dimension 2 Code" := SFactory.FnGetUserBranch();
                LoansRec.Source := ObjLoanDetails.Source;
                LoansRec."Approval Status" := ObjLoanDetails."Approval Status";
                LoansRec.Repayment := ObjLoanDetails."Boosted Amount";
                LoansRec."Requested Amount" := ObjLoanDetails."Boosted Amount";
                LoansRec."Approved Amount" := ObjLoanDetails."Boosted Amount";
                LoansRec.Interest := ObjLoanDetails.Interest;
                LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::"Bank Transfer";
                LoansRec.Posted := true;
                LoansRec."Advice Date" := Today;
                LoansRec.Modify;
            end;
        end;
        exit(DocNumber);
    end;

    local procedure FnUpdateShareBoostedTrans()
    begin

        ObjCust.Reset;
        ObjCust.SetRange(ObjCust."No.", Rec."Client Code");
        if ObjCust.Find('-') then begin
            Rec."Employer Code" := ObjCust."Employer Code";
            Rec.Modify;

            GenSetUp.Get();

            ObjMemberLedg.Reset;
            ObjMemberLedg.SetRange(ObjMemberLedg."Customer No.", Rec."Client Code");
            ObjMemberLedg.SetRange(ObjMemberLedg."Journal Batch Name", 'FTRANS');
            ObjMemberLedg.SetRange(ObjMemberLedg."No Boosting", false);
            ObjMemberLedg.SetRange(ObjMemberLedg."Transaction Type", ObjMemberLedg."transaction type"::"Deposit Contribution");
            if ObjMemberLedg.FindSet then begin
                if ObjMemberLedg."No Boosting" = false then begin //>
                    repeat
                        if ObjMemberLedg."Posting Date" > CalcDate(GenSetUp."Boosting Shares Maturity (M)", Today) then begin

                            if ((ObjMemberLedg."Credit Amount") > ObjCust."Monthly Contribution") then begin
                                ObjMemberLedg."Share Boosting Fee Charged" := true;
                                ObjMemberLedg.Modify;
                            end;
                        end;
                    until ObjMemberLedg.Next = 0;
                end;
            end;
        end;
    end;

    local procedure FnRunSendScheduleViaMail(LoanNo: Code[30]; ClientCode: Code[30])
    var
        Filename: Text[100];
        // SMTPSetup: Record "SMTP Mail Setup";
        // SMTPMail: Codeunit UnknownCodeunit400;
        VarMemberEmail: Text[50];
        ObjMember: Record customer;
        Attachment: Text[250];
        ObjLoanType: Record "Loan Products Setup";
        VarProductDescription: Code[50];
        ObjLoans: Record "Loans Register";
        VarNewMemberName: Text[100];
    begin
        // SMTPSetup.Get();

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", LoanNo);
        if ObjLoans.FindSet then begin
            if ObjMember.Get(ClientCode) then begin
                VarMemberEmail := Lowercase(ObjMember."E-Mail");
            end;
            // Filename := '';
            // Filename := SMTPSetup."Path to Save Report" + 'Loan Repayment Schedule.pdf';
            // Report.SaveAsPdf(Report::"Loans Repayment Schedule", Filename, ObjLoans);

            // VarProductDescription := ObjLoans."Loan Product Type Name";
            // VarNewMemberName := UpperCase(CopyStr("Client Name", 1, 1)) + Lowercase(CopyStr("Client Name", 2));

            // SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address", VarMemberEmail, 'Loan Repayment Schedule', '', true);
            // SMTPMail.AppendBody('Dear ,' + VarNewMemberName);
            // SMTPMail.AppendBody('<br><br>');
            // SMTPMail.AppendBody('Please find attached your loan repayment schedule.');
            // SMTPMail.AppendBody('<br><br>');
            // SMTPMail.AppendBody('Thank you for choosing RUAI ENDELEA SACCO');
            // SMTPMail.AppendBody('<br><br>');
            // SMTPMail.AppendBody('Kind Regards');
            // SMTPMail.AppendBody('<br><br>');
            // SMTPMail.AppendBody(UserId);
            // SMTPMail.AppendBody('<br><br>');
            // SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
            // SMTPMail.AppendBody('<br><br>');
            // SMTPMail.AppendBody('<HR>');
            // SMTPMail.AddAttachment(Filename, Attachment);
            // SMTPMail.Send;
        end;
    end;

    local procedure FnRunCreateLSAfor1sttimeLoanees()
    var
        ObjAccount: Record Vendor;
        ObjAccountType: Record "Account Types-Saving Products";
        VarAcctNo: Code[30];
    begin
        ObjAccount.Reset;
        ObjAccount.SetRange(ObjAccount."BOSA Account No", Rec."Client Code");
        ObjAccount.SetRange(ObjAccount."Account Type", '507');
        if ObjAccount.Find('-') = false then begin

            //========================================================Front Office Accounts

            ObjAccountType.Reset;
            ObjAccountType.SetRange(ObjAccountType.Code, '507');
            if ObjAccountType.FindSet then begin
                if Rec."Global Dimension 2 Code" = 'NAIROBI' then begin
                    VarAcctNo := ObjAccountType."Last Account No Used(HQ)"
                end else
                    if Rec."Global Dimension 2 Code" = 'NAIVASHA' then begin
                        VarAcctNo := ObjAccountType."Last Account No Used(NAIV)"
                    end else
                        if Rec."Global Dimension 2 Code" = 'NAKURU' then begin
                            VarAcctNo := ObjAccountType."Last Account No Used(NKR)"
                        end else
                            if Rec."Global Dimension 2 Code" = 'ELDORET' then begin
                                VarAcctNo := ObjAccountType."Last Account No Used(ELD)"
                            end else
                                if Rec."Global Dimension 2 Code" = 'MOMBASA' then begin
                                    VarAcctNo := ObjAccountType."Last Account No Used(MSA)";
                                end;

            end;



            //=========================================================Create FOSA account
            if ObjCust.Get(Rec."Client Code") then begin
                ObjAccount.Init;
                ObjAccount."No." := VarAcctNo;
                ObjAccount."Date of Birth" := ObjCust."Date of Birth";
                ObjAccount.Name := ObjCust.Name;
                ObjAccount."Creditor Type" := ObjAccount."creditor type"::"FOSA Account";
                ObjAccount."Personal No." := ObjCust."Personal No";
                ObjAccount."ID No." := ObjCust."ID No.";
                ObjAccount."Mobile Phone No" := ObjCust."Mobile Phone No";
                ObjAccount."Phone No." := ObjCust."Mobile Phone No";
                ObjAccount."Registration Date" := ObjCust."Registration Date";
                ObjAccount."Post Code" := ObjCust."Post Code";
                ObjAccount.County := ObjCust.City;
                ObjAccount."BOSA Account No" := ObjCust."No.";

                ObjAccount.Signature := ObjCust.Signature;
                ObjAccount."Passport No." := ObjCust."Passport No.";
                ObjAccount."Employer Code" := ObjCust."Employer Code";
                ObjAccount.Status := ObjAccount.Status::Deceased;
                ObjAccount."Account Type" := '507';
                ObjAccount."Date of Birth" := ObjCust."Date of Birth";
                ObjAccount."Global Dimension 1 Code" := 'FOSA';
                ObjAccount."Global Dimension 2 Code" := ObjCust."Global Dimension 2 Code";
                ObjAccount.Address := ObjCust.Address;
                ObjAccount."Address 2" := ObjCust."Address 2";
                ObjAccount."Phone No." := ObjCust."Mobile Phone No";
                ObjAccount."Registration Date" := Today;
                ObjAccount.Status := ObjAccount.Status::Active;
                ObjAccount.Section := ObjCust.Section;
                ObjAccount."Home Address" := ObjCust."Home Address";
                ObjAccount.District := ObjCust.District;
                ObjAccount.Location := ObjCust.Location;
                ObjAccount."Sub-Location" := ObjCust."Sub-Location";
                ObjAccount."Registration Date" := WorkDate;
                ObjAccount."Monthly Contribution" := ObjCust."Monthly Contribution";
                ObjAccount."E-Mail" := ObjCust."E-Mail (Personal)";

                ObjAccount."Registration Date" := ObjCust."Registration Date";
                ObjAccount.Insert;
            end;

            ObjAccount.Reset;
            if ObjAccount.Get(VarAcctNo) then begin
                ObjAccount.Validate(ObjAccount.Name);
                ObjAccount.Validate(ObjAccount."Account Type");
                ObjAccount.Modify;

                ObjAccountType.Reset;
                ObjAccountType.SetRange(ObjAccountType.Code, '507');
                if ObjAccountType.Find('-') then begin
                    if Rec."Global Dimension 2 Code" = 'NAIROBI' then begin
                        ObjAccountType."Last Account No Used(HQ)" := IncStr(ObjAccountType."Last Account No Used(HQ)")
                    end else
                        if Rec."Global Dimension 2 Code" = 'NAIVASHA' then begin
                            ObjAccountType."Last Account No Used(NAIV)" := IncStr(ObjAccountType."Last Account No Used(NAIV)")
                        end else
                            if Rec."Global Dimension 2 Code" = 'NAKURU' then begin
                                ObjAccountType."Last Account No Used(NKR)" := IncStr(ObjAccountType."Last Account No Used(NKR)")
                            end else
                                if Rec."Global Dimension 2 Code" = 'ELDORET' then begin
                                    ObjAccountType."Last Account No Used(ELD)" := IncStr(ObjAccountType."Last Account No Used(ELD)")
                                end else
                                    if Rec."Global Dimension 2 Code" = 'MOMBASA' then begin
                                        ObjAccountType."Last Account No Used(MSA)" := IncStr(ObjAccountType."Last Account No Used(MSA)");
                                    end;
                    ObjAccountType.Modify;
                end;

            end;
        end;
    end;

    local procedure FnRunCheckLoanStages()
    var
        ObjLoanApplicationStages: Record "Loan Application Stages";
    begin
        ObjLoanApplicationStages.Reset;
        ObjLoanApplicationStages.SetRange(ObjLoanApplicationStages."Loan No", Rec."Loan  No.");
        ObjLoanApplicationStages.SetFilter(ObjLoanApplicationStages."Stage Status", '<>%1', ObjLoanApplicationStages."stage status"::Succesful);
        ObjLoanApplicationStages.SetFilter(ObjLoanApplicationStages."Loan Stage", '<>%1', '015');
        if ObjLoanApplicationStages.FindSet then begin
            Error('This Loan Application has Loan Stages that are not Succesful. Kindly Review Before Posting the Loan');
        end;
    end;

    local procedure FnRunUpdateDisburesmentLoanStage()
    var
        ObjLoanApplicationStages: Record "Loan Application Stages";
    begin
        ObjLoanApplicationStages.Reset;
        ObjLoanApplicationStages.SetRange(ObjLoanApplicationStages."Loan No", Rec."Loan  No.");
        ObjLoanApplicationStages.SetFilter(ObjLoanApplicationStages."Loan Stage", '%1', '015');
        if ObjLoanApplicationStages.FindSet then begin
            ObjLoanApplicationStages."Stage Status" := ObjLoanApplicationStages."stage status"::Succesful;
            ObjLoanApplicationStages.Modify;
        end;
    end;
}

