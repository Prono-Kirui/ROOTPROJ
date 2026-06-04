#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50564 "Loans Application Card(Posted)"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
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
                Editable = false;
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
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member Deposits"; Rec."Member Deposits")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        REC.TestField(Posted, false);
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
                    Editable = false;

                    trigger OnValidate()
                    begin
                        REC.TestField(Posted, false);
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
                    Editable = false;

                    trigger OnValidate()
                    begin
                        REC.TestField(Posted, false);
                    end;
                }
                field("Boost this Loan"; Rec."Boost this Loan")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Boosted Amount"; Rec."Boosted Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                        REC.TestField(Posted, false);
                    end;
                }
                field("Loan Purpose"; Rec."Loan Purpose")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                    Editable = false;
                }
                field("Loan Principle Repayment"; Rec."Loan Principle Repayment")
                {
                    ApplicationArea = Basic;
                    Caption = 'Principle Repayment';
                    Editable = false;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Loan Interest Repayment"; Rec."Loan Interest Repayment")
                {
                    ApplicationArea = Basic;
                    Caption = 'Interest Repayment';
                    Editable = false;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Approved Repayment"; Rec."Approved Repayment")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Loan Status"; Rec."Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;

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
                    Editable = false;
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                    Editable = false;
                    Enabled = EditableField;
                    Importance = Promoted;

                    ShowMandatory = true;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                    Editable = false;
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
                    Editable = false;
                    Visible = false;
                }
                field("Posted"; Rec."Posted")
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
                field("Rejection  Remark"; Rec."Rejection  Remark")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                part(Control42; "Loan Application Stages")
                {
                    Caption = 'Loan Stages';
                    SubPageLink = "Loan No" = field("Loan  No.");
                }
            }
            group("Salary Details")
            {
                Caption = 'Salary Details';
                Editable = false;
                group("Monthly Income Details")
                {
                    field("Salary Total Income"; Rec."Salary Total Income")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Monthly Income';
                    }
                }
                group("Monthly Expenses Details")
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
                Editable = false;
                field("Bank Statement Avarage Credits"; Rec."Bank Statement Avarage Credits")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Statement Avarage Debits"; Rec."Bank Statement Avarage Debits")
                {
                    ApplicationArea = Basic;
                }

                field("Bank Statement Net Income"; Rec."Bank Statement Net Income")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control16; "Loans Guarantee Details")
            {
                Caption = 'Guarantors  Detail';
                Editable = false;
                SubPageLink = "Loan No" = field("Loan  No.");
            }
            part(Control15; "Loan Collateral Security")
            {
                Caption = 'Other Securities';
                Editable = false;
                SubPageLink = "Loan No" = field("Loan  No.");
            }
            group("Repayment Date Change")
            {
                Editable = DateChangedEditable;
                field("Reschedule Effective Date"; Rec."Reschedule Effective Date")
                {
                    ApplicationArea = Basic;
                }
                field("New Repayment Start Date"; Rec."New Repayment Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Dates Rescheduled"; Rec."Repayment Dates Rescheduled")
                {
                    ApplicationArea = Basic;
                    Caption = 'Repayment Dates Changed';
                    Editable = false;
                }
                field("Repayment Dates Rescheduled On"; Rec."Repayment Dates Rescheduled On")
                {
                    ApplicationArea = Basic;
                    Caption = 'Repayment Dates Changed On';
                    Editable = false;
                }
                field("Repayment Dates Rescheduled By"; Rec."Repayment Dates Rescheduled By")
                {
                    ApplicationArea = Basic;
                    Caption = 'Repayment Dates Changed By';
                    Editable = false;
                }
            }
            group("Debt Collections Details")
            {
                Caption = 'Debt Collections Details';
                field("Loan Debt Collector"; Rec."Loan Debt Collector")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Debt Collector Interest %"; Rec."Loan Debt Collector Interest %")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Debt Collection date Assigned"; Rec."Debt Collection date Assigned")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Debt Collector Name"; Rec."Debt Collector Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Bal As At Debt Collection"; Rec."Loan Bal As At Debt Collection")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Bal As At Debt Collection Assignment';
                    Editable = false;
                }
            }
            part(Control1000000000; "Loan Collateral Security")
            {
                Caption = 'Other Securities';
                Editable = false;
                SubPageLink = "Loan No" = field("Loan  No.");
                Visible = false;
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
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.Run(50199, true, false, LoanApp);
                        end;
                    end;
                }
                action("Member Ledger Entries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ledger Entries';
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    RunObject = Page "Customer Ledger Entries";
                    RunPageLink = "Loan No" = field("Loan  No.");
                    RunPageView = sorting("Customer No.");
                }
                action("Loan Statement")
                {
                    ApplicationArea = Basic;
                    Image = SelectReport;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."Client Code");
                        Cust.SetFilter("Loan No. Filter", Rec."Loan  No.");
                        Cust.SetFilter("Loan Product Filter", Rec."Loan Product Type");
                        if Cust.Find('-') then
                            Report.Run(50531, true, false, Cust);
                    end;
                }
                action("Guarantors' Report")
                {
                    ApplicationArea = Basic;
                    Image = SelectReport;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."Client Code");
                        Cust.SetFilter("Loan No. Filter", Rec."Loan  No.");
                        Cust.SetFilter("Loan Product Filter", Rec."Loan Product Type");
                        if Cust.Find('-') then
                            Report.Run(50504, true, false, Cust);
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
                action("View Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Repayment Schedule';
                    Image = "Table";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    begin
                        if Rec.Rescheduled = true then
                            fngeneraterepaymentschedule.FnGenerateLoanRepaymentReSchedule(Rec."Loan  No.")
                        else
                            SFactory.FnGenerateLoanRepaymentSchedule(Rec."Loan  No.");
                        Commit;
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then
                            if Rec.Rescheduled = true then
                                Report.Run(50409, true, false, LoanApp)
                            else
                                Report.Run(50269, true, false, LoanApp);
                    end;
                }
                action("View ScheduleNew")
                {
                    ApplicationArea = Basic;
                    Caption = 'Repayments Schedule Updated Payments';
                    Image = "Table";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F7';
                    Visible = false;

                    trigger OnAction()
                    begin
                        // SFactory.FnRunLoanAmountDue("Loan  No.");
                        // Commit;

                        // LoanApp.Reset;
                        // LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        // if LoanApp.Find('-') then
                        //     Report.Run(50949, true, false, LoanApp);
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
                    //Visible = false;
                }
                action("Reschedule Repayment Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Repayment:Date Change';
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        VarScheduleDay: Integer;
                        VarScheduleMonth: Integer;
                        VarScheduleYear: Integer;
                    begin
                        Rec.TestField("New Repayment Start Date");
                        if Confirm('Confirm you Want to Change Repayment Dates for  this Loan?', false) = true then begin

                            VarNewInstalmentDate := Rec."New Repayment Start Date";
                            //=======================================================================Loan Repayment Schedule
                            ObjLoanRepaymentSchedule.Reset;
                            ObjLoanRepaymentSchedule.SetCurrentkey(ObjLoanRepaymentSchedule."Repayment Date");
                            ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule."Loan No.", Rec."Loan  No.");
                            ObjLoanRepaymentSchedule.SetFilter(ObjLoanRepaymentSchedule."Repayment Date", '>=%1', Rec."Reschedule Effective Date");
                            if ObjLoanRepaymentSchedule.FindSet then begin
                                repeat
                                    ObjLoanRepaymentSchedule."Repayment Date" := VarNewInstalmentDate;
                                    ObjLoanRepaymentSchedule.Modify;
                                    VarNewInstalmentDate := CalcDate('1M', VarNewInstalmentDate);
                                until ObjLoanRepaymentSchedule.Next = 0;
                            end;
                            //=======================================================================Loan Repayment Schedule  Temp
                            // ObjLoanRepaymentScheduleTemp.Reset;
                            // ObjLoanRepaymentScheduleTemp.SetCurrentkey(ObjLoanRepaymentScheduleTemp."Repayment Date");
                            // ObjLoanRepaymentScheduleTemp.SetRange(ObjLoanRepaymentScheduleTemp."Loan No.", Rec."Loan  No.");
                            // ObjLoanRepaymentScheduleTemp.SetFilter(ObjLoanRepaymentScheduleTemp."Repayment Date", '>=%1', Rec."Reschedule Effective Date");
                            // if ObjLoanRepaymentScheduleTemp.FindSet then begin
                            //     repeat
                            //         ObjLoanRepaymentScheduleTemp."Repayment Date" := VarNewInstalmentDate;
                            //         ObjLoanRepaymentScheduleTemp.Modify;
                            //         VarNewInstalmentDate := CalcDate('1M', VarNewInstalmentDate);
                            //     until ObjLoanRepaymentScheduleTemp.Next = 0;
                            // end;
                            Rec."Repayment Dates Rescheduled" := true;
                            Rec."Repayment Dates Rescheduled By" := UserId;
                            Rec."Repayment Dates Rescheduled On" := Today;
                            Message('Loan Repayment Date Changed Succesfully');
                        end;
                    end;
                }
                action("FOSA Statement")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;
                    Image = SelectReport;
                    trigger OnAction()
                    begin
                        Vend.Reset;
                        Vend.SetRange(Vend."No.", Rec."Account No");
                        if Vend.Find('-') then begin
                            Report.Run(50890, true, false, Vend);
                        end;


                        /*Cust.RESET;
                        Cust.SETRANGE(Cust."FOSA Account No.","FOSA Account No.");
                        IF Cust.FIND('-') THEN
                        REPORT.RUN(50890,TRUE,FALSE,Cust);
                        */

                    end;
                }
                action("Generate Repayment Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'Generate Repayment Schedule';
                    Image = "Table";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F7';
                    visible = false;

                    trigger OnAction()
                    begin
                        //IF Posted=TRUE THEN
                        //ERROR('Loan has been posted, Can only preview schedule');

                        if Rec."Repayment Frequency" = Rec."repayment frequency"::Daily then
                            Evaluate(InPeriod, '1D')
                        else if Rec."Repayment Frequency" = Rec."repayment frequency"::Weekly then
                            Evaluate(InPeriod, '1W')
                        else if Rec."Repayment Frequency" = Rec."repayment frequency"::Monthly then
                            Evaluate(InPeriod, '1M')
                        else if Rec."Repayment Frequency" = Rec."repayment frequency"::Quaterly then
                            Evaluate(InPeriod, '1Q');

                        RunDate := 0D;
                        QCounter := 0;
                        QCounter := 3;
                        ScheduleBal := 0;
                        //EVALUATE(InPeriod,'1D');
                        // GrPrinciple := Rec."Grace Period -Rec. Principle (M)";
                        // GrInterest := Rec."Grace Period - Rec.Interest (M)";
                        // InitialGraceInt := Rec."Grace Period - Rec.Interest (M)";


                        LoansR.Reset;
                        LoansR.SetRange(LoansR."Loan  No.", Rec."Loan  No.");
                        if LoansR.Find('-') then begin
                            LoansR.CalcFields(LoansR."Outstanding Balance");

                            Rec.TestField("Loan Disbursement Date");
                            Rec.TestField("Repayment Start Date");

                            RSchedule.Reset;
                            RSchedule.SetRange(RSchedule."Loan No.", Rec."Loan  No.");
                            RSchedule.DeleteAll;

                            if LoansR.Get(Rec."Loan  No.") then begin
                                LoanAmount := LoansR."Approved Amount" + LoansR."Capitalized Charges";
                                InterestRate := LoansR.Interest;
                                RepayPeriod := LoansR.Installments;
                                // InitialInstal := LoansR.Installments + Rec."Grace Period - Rec.Principle (M)";
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

                                //RunDate:=0D;
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

                                        ObjProductCharge.Reset;
                                        ObjProductCharge.SetRange(ObjProductCharge."Product Code", Rec."Loan Product Type");
                                        ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                                        if ObjProductCharge.FindSet then begin
                                            LInsurance := Rec."Approved Amount" * (ObjProductCharge.Percentage / 100);
                                        end;

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

                                        ObjProductCharge.Reset;
                                        ObjProductCharge.SetRange(ObjProductCharge."Product Code", Rec."Loan Product Type");
                                        ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                                        if ObjProductCharge.FindSet then begin
                                            LInsurance := Rec."Approved Amount" * (ObjProductCharge.Percentage / 100);
                                        end;
                                    end;


                                    if Rec."Repayment Method" = Rec."repayment method"::"Reducing Balance" then begin
                                        Rec.TestField(Interest);
                                        Rec.TestField(Installments);
                                        LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
                                        LInterest := ROUND((InterestRate / 12 / 100) * LBalance, 1, '>');

                                        ObjProductCharge.Reset;
                                        ObjProductCharge.SetRange(ObjProductCharge."Product Code", Rec."Loan Product Type");
                                        ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                                        if ObjProductCharge.FindSet then begin
                                            LInsurance := Rec."Approved Amount" * (ObjProductCharge.Percentage / 100);
                                        end;
                                    end;

                                    if Rec."Repayment Method" = Rec."repayment method"::Constants then begin
                                        Rec.TestField(Repayment);
                                        if LBalance < Rec.Repayment then
                                            LPrincipal := LBalance
                                        else
                                            LPrincipal := Rec.Repayment;
                                        LInterest := Rec.Interest;

                                        ObjProductCharge.Reset;
                                        ObjProductCharge.SetRange(ObjProductCharge."Product Code", Rec."Loan Product Type");
                                        ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                                        if ObjProductCharge.FindSet then begin
                                            LInsurance := Rec."Approved Amount" * (ObjProductCharge.Percentage / 100);
                                        end;
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

                                    //Grace Period
                                    RSchedule.Init;
                                    RSchedule."Repayment Code" := RepayCode;
                                    RSchedule."Loan No." := Rec."Loan  No.";
                                    RSchedule."Loan Amount" := LoanAmount;
                                    RSchedule."Instalment No" := InstalNo;
                                    RSchedule."Repayment Date" := CalcDate('CM', RunDate);
                                    RSchedule."Member No." := Rec."Client Code";
                                    RSchedule."Loan Category" := Rec."Loan Product Type";
                                    RSchedule."Monthly Repayment" := LInterest + LPrincipal + LInsurance;
                                    RSchedule."Monthly Interest" := LInterest;
                                    RSchedule."Principal Repayment" := LPrincipal;
                                    RSchedule."Monthly Insurance" := LInsurance;
                                    RSchedule."Loan Balance" := ScheduleBal;
                                    RSchedule.Insert;
                                    WhichDay := Date2dwy(RSchedule."Repayment Date", 1);


                                until LBalance < 1
                            end;
                        end;

                        Commit;

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then
                            if LoanApp."Loan Product Type" <> 'INST' then begin
                                Report.Run(50477, true, false, LoanApp);
                            end else begin
                                Report.Run(50477, true, false, LoanApp);
                            end;
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
        DateChangedEditable := true;
        if Rec."Repayment Dates Rescheduled" = true then begin
            DateChangedEditable := false;
        end;

        Rec."Working Date" := WorkDate;
    end;

    trigger OnOpenPage()
    begin
        EditableField := true;

        EditableField := true;
        DateChangedEditable := true;
        if Rec."Repayment Dates Rescheduled" = true then begin
            DateChangedEditable := false;
        end;
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
        ObjLoanRepaymentSchedule: Record "Loan Repayment Schedule";
        DateChangedEditable: Boolean;
        ObjProductCharge: Record "Loan Product Charges";
        LInsurance: Decimal;
        VarNewInstalmentDate: Date;
        ObjLoanRepaymentScheduleTemp: Record "Loan Repayment Schedule Temp";


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
            BatchNoEditable := true;
            RemarksEditable := false;
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
        //GrPrinciple := g
        // GrInterest := Rec."Grace Period - Rec.Interest (M)";
        // InitialGraceInt := Rec."Grace Period - Rec.Interest (M)";

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
            InitialInstal := LoansR.Installments;
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

        LoanApp.Reset;
        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
        if LoanApp.Find('-') then
            if LoanApp."Loan Product Type" <> 'INST' then begin
                Report.Run(50477, true, false, LoanApp);
            end else begin
                Report.Run(50477, true, false, LoanApp);
            end;
    end;
}

