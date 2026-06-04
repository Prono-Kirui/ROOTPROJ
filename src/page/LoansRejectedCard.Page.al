#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50392 "Loans Rejected Card"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Card;
    SourceTable = "Loans Register";
    SourceTableView = where("Loan Status" = const(Rejected));

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
                field("Staff No"; Rec."Staff No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Staff No';
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

                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
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
                    Editable = ApprovedAmountEditable;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }

                field("Amount to Disburse on Tranch 1"; Rec."Amount to Disburse on Tranch 1")
                {
                    ApplicationArea = Basic;
                }

                field("No of Tranch Disbursment"; Rec."No of Tranch Disbursment")
                {
                    ApplicationArea = Basic;
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

                field("Member House Group"; Rec."Member House Group")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Member House Group Name"; Rec."Member House Group Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Loan Status"; Rec."Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = LoanStatusEditable;

                    trigger OnValidate()
                    begin
                        //UpdateControl();
                    end;
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

                field("Loan Centre"; Rec."Loan Centre")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                    Editable = false;
                }

                field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                    AssistEdit = true;
                    Importance = Promoted;
                    NotBlank = true;
                    ShowMandatory = true;
                    Style = Attention;
                    StyleExpr = true;
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

                field("Repayment Start Date"; Rec."Repayment Start Date")
                {
                    ApplicationArea = Basic;
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

                // Continue with other fields that are missing Rec. prefix...

                field("Salary Total Income"; Rec."Salary Total Income")
                {
                    ApplicationArea = Basic;
                    Caption = 'Monthly Income';
                }

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

                field("Salary Net Utilizable"; Rec."Salary Net Utilizable")
                {
                    ApplicationArea = Basic;
                }

                field("Bank Statement Avarage Credits"; Rec."Bank Statement Avarage Credits")
                {
                    ApplicationArea = Basic;
                }

                field("Bank Statement Avarage Debits"; Rec."Bank Statement Avarage Debits")
                {
                    ApplicationArea = Basic;
                }

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

                field("Bank Statement Net Income"; Rec."Bank Statement Net Income")
                {
                    ApplicationArea = Basic;
                }

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
            part(Control2; "Loans Guarantee Details")
            {
                Caption = 'Guarantors  Detail';
                Editable = false;
                SubPageLink = "Loan No" = field("Loan  No.");
            }
            part(Control1; "Loan Collateral Security")
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
                action("Mark As Posted")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mark As Posted';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.Posted := true;
                        Rec.Modify;
                    end;
                }
                action("Loan Appraisal")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal';
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*LoanApp.RESET;
                        LoanApp.SETRANGE(LoanApp."Loan  No.","Loan  No.");
                        IF LoanApp.FIND('-') THEN BEGIN
                        REPORT.RUN(,TRUE,FALSE,LoanApp);
                        END;
                        END;
                        */

                    end;
                }
                separator(Action1102760046)
                {
                }
                action("View Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'View Schedule';
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    begin


                    end;
                }
                separator(Action1102760048)
                {
                }
                action("Loans Top Up")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Top Up';
                    // RunObject = Page "HR Job Requirements";
                    // RunPageLink = "Job ID" = field("Loan  No."),
                    //               "No of Posts" = field("Client Code");
                    // Visible = false;
                }
                separator(Action1102760039)
                {
                }
                separator(Action1102755021)
                {
                }
                action(Action1102760062)
                {
                    ApplicationArea = Basic;
                    Caption = 'Mark As Posted';
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to mark this loan as posted?') = true then begin
                            Rec.Posted := true;
                            Rec.Modify;
                        end;
                    end;
                }

                separator(Action1102755023)
                {
                }


                action("ReAppraise Loan Application")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if rec."Approval Status" = "approval status"::Rejected then begin
                            if Confirm('Are you sure you want to Reappraise this loan?', false) = true then begin

                                ApprovalComment.Reset;
                                ApprovalComment.SetRange(ApprovalComment."Document No.", Rec."Loan  No.");
                                if ApprovalComment.Find('-') then begin
                                    ApprovalComment.Comment := '';
                                    ApprovalComment.Modify;
                                end
                            end;
                            Rec."Loan Status" := Rec."loan status"::Application;
                            Rec."Approval Status" := Rec."approval status"::Open;
                            Rec.Modify
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;

        RejectionVisible := false;

        if Rec."Intent to Reject" = true then begin
            RejectionVisible := true;
        end;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        LoanAppPermisions();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Source := Rec.Source::" ";
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        RejectionVisible := false;


    end;

    var
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
        CustomerRecord: Record customer;
        Gnljnline: Record "Gen. Journal Line";
        //  Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
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
        GenSetUp: Record "Sales & Receivables Setup";
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
        //  GLPosting: Codeunit "Gen. Jnl.-Post Line";
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
        SMSMessage: Record customer;
        InstallNo2: Integer;
        currency: Record "Currency Exchange Rate";
        CURRENCYFACTOR: Decimal;
        LoanApps: Record "Loans Register";
        LoanDisbAmount: Decimal;
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        SchDate: Date;
        DisbDate: Date;
        WhichDay: Integer;
        LBatches: Record "Loans Register";
        //SalDetails: Record "Loan Appraisal Salary Details";
        LGuarantors: Record "Loans Guarantee Details";
        // DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Imprest,ImprestSurrender,Interbank;
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
        ApprovalComment: Record "Approval Comment Line";
        RejectionVisible: Boolean;


    procedure LoanAppPermisions()
    begin

        //CurrForm.EDITABLE:=TRUE;
        /*
        IF "Batch No." <> '' THEN BEGIN
        MovementTracker.RESET;
        MovementTracker.SETCURRENTKEY(MovementTracker."Document No.");
        MovementTracker.SETRANGE(MovementTracker."Document No.","Batch No.");
        IF MovementTracker.FIND('+') THEN BEGIN
        IF (MovementTracker.Station <> 'LOANS OFFICE') AND (MovementTracker.Station <> 'REGISTRY')
           AND (MovementTracker.Station <> 'ELD') AND (MovementTracker.Station <> 'PERSONAL LOANS')
           AND (MovementTracker.Station <> 'KCB - (PERSONAL LOANS)') THEN
        ERROR('You dont have permisions to modify loan applications.')//CurrForm.EDITABLE:=FALSE
        ELSE BEGIN
        ApprovalUsers.RESET;
        ApprovalUsers.SETRANGE(ApprovalUsers."Approval Type",MovementTracker."Approval Type");
        ApprovalUsers.SETRANGE(ApprovalUsers.Stage,MovementTracker.Stage);
        ApprovalUsers.SETRANGE(ApprovalUsers."User ID",USERID);
        IF ApprovalUsers.FIND('-') THEN BEGIN
        CurrForm.EDITABLE:=TRUE;
        END ELSE BEGIN
        ERROR('You dont have permisions to modify a loan application that is out of your desk.')//CurrForm.EDITABLE:=FALSE;
        
        END;
        END;
        END;
        END;
        */

    end;

    local procedure ClientCodeOnAfterValidate()
    begin
        Rec.TestField(Posted, false);
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;


        DiscountingAmount := 0;

        /*
        SpecialComm:=0;
        IF "Special Loan Amount" + "Other Commitments Clearance" > 0 THEN
        SpecialComm:=("Special Loan Amount"+"Other Commitments Clearance")*0.05;
        */

        //Special Commision
        SpecialComm := 0;
        BridgedLoans.Reset;
        BridgedLoans.SetCurrentkey(BridgedLoans."Loan No.");
        BridgedLoans.SetRange(BridgedLoans."Loan No.", Rec."Loan  No.");
        if BridgedLoans.Find('-') then begin
            repeat
                if BridgedLoans.Source = BridgedLoans.Source::FOSA then begin
                    if BridgedLoans."Loan Type" = 'SUPER' then
                        SpecialComm := SpecialComm + (BridgedLoans."Total Off Set" * 0.1)
                    else
                        SpecialComm := SpecialComm + (BridgedLoans."Total Off Set" * 0.1);
                end else begin
                    SpecialComm := SpecialComm + (BridgedLoans."Total Off Set" * 0.1);
                end;
            until BridgedLoans.Next = 0;
        end;



        /*IDNo:='';
        FOSAName:='';
        IF Cust.GET("Client Code") THEN BEGIN
        IDNo:=Cust."ID No.";
        IF Vend.GET("Account No") THEN BEGIN
        FOSAName:=Vend.Name;
        END;
        END; */

        //LoanAppPermisions();

    end;

    local procedure OtherCommitmentsClearanceOnDea()
    begin
        CurrPage.Update := true;
    end;
}

