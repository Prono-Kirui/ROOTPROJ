#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50385 "Loan Application Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loans Register";

    //SourceTableView = where(Posted = const(false));
    SourceTableView = where(Source = const(MICRO),
                            Posted = const(false));

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


                    trigger OnValidate()
                    begin
                        //...........................................Check If Member kYC data is missing
                        //  if fngeneraterepaymentschedule.FnIsMemberKYCMissing("Client Code") = false then begin
                        //     Error('key member details are missing');
                        //end;
                        //..............................................................................
                    end;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;

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
                    showMandatory = true;
                }
                field("Pension No"; Rec."Pension No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                // field("Member Deposits"; Rec."Member Deposits")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Normal Shares';
                // }
                field("Outstanding Loan"; Rec."Outstanding Loan")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    //Editable = false;
                }
                field("1st Time Loanee"; Rec."1st Time Loanee")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    // Editable = false;

                    trigger OnValidate()
                    begin
                        // Rec.TestField(Posted, false);
                    end;
                }
                field("Car Tracker"; Rec."Car Tracker")
                {
                    ApplicationArea = Basic;
                    // Editable =;
                }

                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Source';
                    Editable = false;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        //Rec."Loan Product Type" := '';
                        CurrPage.Update(false);
                    end;
                }

                field("Loan Product Type-Dropdown"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Product Type';


                    trigger OnValidate()
                    var
                        AmountBal: Decimal;
                        LoansRe: Record "Loans Register";
                        loanproduCtsEtup: Record "Loan Products Setup";
                    begin
                        
                        //Rec.CalculateRecurringCharges();

                        //             if Rec.Source = Rec.Source::" " then
                        // Error('Please select a Loan Source before selecting the Loan Product Type.');

                        //................check on if member qualifies for the loan from the new changes on setup
                        //........................................
                        AmountBal := 0;

                        LoansRe.Reset();
                        LoansRe.SetRange(LoansRe."Client Code", Rec."Client Code");
                        LoansRe.SetAutocalcFields(LoansRe."Outstanding Balance");
                        LoansRe.SetRange(LoansRe.Source, LoansRe.Source::BOSA);
                        LoansRe.SetRange(LoansRe."Loan Product Type", Rec."Loan Product Type");
                        if LoansRe.Find('-') then begin
                            repeat
                                AmountBal += LoansRe."Outstanding Balance";
                            until LoansRe.Next = 0;
                            if Rec."Top Up Amount" > 0 then begin
                                //Allow Top up even if there is an outstanding loan of the same type
                            end else
                                if AmountBal > 1 then begin
                                    Error('You cannot apply for the same loan product type (%1) when you have an outstanding loan of the same type', Rec."Loan Product Type");
                                end;
                        end;
                        //     LoansRe.Reset();
                        //     LoansRe.SetRange(LoansRe."Client Code", Rec."Client Code");
                        //     LoansRe.SetAutocalcFields(LoansRe."Outstanding Balance");
                        //     LoansRe.SetRange(LoansRe.Source, LoansRe.Source::BOSA);
                        //    // LoansRe.set
                        //     if LoansRe.Find('-') then begin
                        //         repeat
                        //             AmountBal += LoansRe."Outstanding Balance";
                        //         until LoansRe.Next = 0;
                        //         if AmountBal > 1 then begin
                        //          //   Error('You cannot apply for a loan product when you have other outstanding BOSA Loans');
                        //         end;
                        //     end;


                    end;
                }
                field(Installments; Rec.Installments)
                {
                    ApplicationArea = Basic;


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
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount Applied';
                    ShowMandatory = true;
                    Editable = AppliedAmountEditable;


                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);

                        if Rec."Requested Amount" <= 0 then
                            Error('Requested Amount must be greater than zero');
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
                    ShowMandatory = true;
                    Editable = ApprovedAmountEditable;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                        // Set Recommended Amount equal to Approved Amount

                        if Rec."Approved Amount" <= 0 then
                            Error('Approved Amount must be greater than zero');

                        Rec."Recommended Amount" := Rec."Approved Amount";
                        //Rec.Modify(true);
                        CurrPage.Update(false);
                    end;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;

                    Visible = true;
                }
                field("Loan Purpose"; Rec."Loan Purpose")
                {
                    ApplicationArea = Basic;

                    ShowMandatory = true;
                }
                // field("Main Sector"; Rec."Main Sector")
                // {
                //     ApplicationArea = Basic;
                //     // ShowMandatory = true;


                //     trigger OnValidate()
                //     begin
                //         Rec.TestField(Posted, false);
                //     end;
                // }
                // field("Sub-Sector"; Rec."Sub-Sector")
                // {
                //     ApplicationArea = Basic;

                //     //ShowMandatory = true;


                //     trigger OnValidate()
                //     begin
                //         Rec.TestField(Posted, false);
                //     end;
                // }
                // field("Specific Sector"; Rec."Specific Sector")
                // {
                //     ApplicationArea = Basic;

                //     //ShowMandatory = true;


                //     trigger OnValidate()
                //     begin
                //         Rec.TestField(Posted, false);
                //     end;
                // }
                field("Received Copy Of ID"; Rec."Received Copy Of ID")
                {
                    ApplicationArea = Basic;

                }
                field("Received Payslip/Bank Statemen"; Rec."Received Payslip/Bank Statemen")
                {
                    ApplicationArea = Basic;

                }
                field("Witnessed By"; Rec."Witnessed By")
                {
                    ApplicationArea = Basic;

                    ShowMandatory = true;
                }
                field("Witness Name"; Rec."Witness Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Principle Repayment"; Rec."Loan Principle Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Attention;
                    Caption = 'Monthly Principle Repayment';
                }
                field("Loan Interest Repayment"; Rec."Loan Interest Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Attention;
                    Caption = 'Monthly Interest Repayment';
                }
                field("Total Tracking Fee"; Rec."Total Tracking Fee")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Attention;
                    Caption = 'Total Tracking Fee';
                    // Visible = Rec."Car Tracker"; // Only show when car tracker is checked

                    // trigger OnValidate()
                    // begin
                    //     CurrPage.Update(false);
                    // end;
                }
                field("Monthly Tracking Fee"; Rec."Monthly Tracking Fee")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Style = Attention;
                    Caption = 'Monthly Tracking Fee';
                    // Visible = Rec."Car Tracker"; // Only show when car tracker is checked
                }
                field(Repayment; Rec.Repayment)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Attention;
                    Caption = 'Monthly Total Repayment';
                }
                field("Loan Status"; Rec."Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        UpdateControl();
                    end;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Top Up Amount"; Rec."Top Up Amount")
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    Caption = 'Top Up Amount';
                    Editable = false;
                }
                field("Total TopUp Commission"; Rec."Total TopUp Commission")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total TopUp Interest';
                    Style = Attention;
                    Editable = false;
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                    ApplicationArea = Basic;

                }

                field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;

                }
                field("Repayment Start Date"; Rec."Repayment Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Expected Date of Completion"; Rec."Expected Date of Completion")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }

                // field("Repayment Method"; Rec."Repayment Method")
                // {
                //     ApplicationArea = Basic;
                //     // Editable = false;
                // }

                // field("Recovery Mode"; Rec."Recovery Mode")
                // {
                //     ApplicationArea = Basic;
                //     // Visible = false;

                // }
                field("Mode of Disbursement"; Rec."Mode of Disbursement")
                {
                    ApplicationArea = Basic;
                    Visible = false;

                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

            }


            // group("Salary Details")
            // {
            //     Caption = 'Salary Details';
            //     Visible = PayslipDetailsVisible;
            //     group(Earnings)
            //     {
            //         Caption = 'Earnings';

            //         field("Basic Pay H"; Rec."Basic Pay H")
            //         {
            //             ApplicationArea = Basic;
            //             Caption = 'Basic Pay';
            //         }
            //         field("House AllowanceH"; Rec."House AllowanceH")
            //         {
            //             ApplicationArea = Basic;
            //             Caption = 'House Allowance';
            //         }
            //         field("Medical AllowanceH"; Rec."Medical AllowanceH")
            //         {
            //             ApplicationArea = Basic;
            //             Caption = 'Medical Allowance';
            //         }
            //         field("Transport/Bus Fare"; Rec."Transport/Bus Fare")
            //         {
            //             ApplicationArea = Basic;
            //         }
            //         field("Other Income"; Rec."Other Income")
            //         {
            //             ApplicationArea = Basic;
            //         }
            //         field(GrossPay; GrossPay)
            //         {
            //             ApplicationArea = Basic;
            //         }
            //         field(Nettakehome; Nettakehome)
            //         {
            //             ApplicationArea = Basic;
            //         }
            //     }
            //     group("Non-Taxable Deductions")
            //     {
            //         Caption = 'Non-Taxable Deductions';
            //         Visible = false;
            //         field("Pension Scheme"; Rec."Pension Scheme")
            //         {
            //             ApplicationArea = Basic;
            //         }
            //         field("Other Non-Taxable"; Rec."Other Non-Taxable")
            //         {
            //             ApplicationArea = Basic;
            //         }
            //         field("Other Tax Relief"; Rec."Other Tax Relief")
            //         {
            //             ApplicationArea = Basic;
            //         }
            //     }
            //     group(Deductions)
            //     {
            //         Caption = 'Deductions';

            //         field("Monthly Contribution"; Rec."Monthly Contribution")
            //         {
            //             ApplicationArea = Basic;
            //         }
            //         field(NHIF; Rec.NHIF)
            //         {
            //             ApplicationArea = Basic;
            //         }
            //         field(NSSF; Rec.NSSF)
            //         {
            //             ApplicationArea = Basic;
            //         }
            //         field(PAYE; PAYE)
            //         {
            //             ApplicationArea = Basic;
            //         }
            //         field("Risk MGT"; Rec."Risk MGT")
            //         {
            //             ApplicationArea = Basic;
            //         }
            //         field("Medical Insurance"; Rec."Medical Insurance")
            //         {
            //             ApplicationArea = Basic;
            //         }
            //         field("Life Insurance"; Rec."Life Insurance")
            //         {
            //             ApplicationArea = Basic;
            //         }
            //         field("Other Liabilities"; Rec."Other Liabilities")
            //         {
            //             ApplicationArea = Basic;
            //         }
            //         field("Sacco Deductions"; Rec."Sacco Deductions")
            //         {
            //             ApplicationArea = Basic;
            //         }
            //         field("Other Loans Repayments"; Rec."Other Loans Repayments")
            //         {
            //             ApplicationArea = Basic;
            //             Caption = 'Bank Loan Repayments';
            //         }
            //         field(TotalDeductions; TotalDeductions)
            //         {
            //             ApplicationArea = Basic;
            //             Caption = 'Total Deductions';
            //         }
            //         field(UtilizableAmount; Rec."Utilizable Amount")
            //         {
            //             ApplicationArea = Basic;
            //         }
            //         field("Bridge Amount Release"; Rec."Bridge Amount Release")
            //         {
            //             ApplicationArea = Basic;
            //             Caption = 'Cleared Loan Repayment';
            //         }

            //     }
            //     field(NetUtilizable; NetUtilizable)
            //     {
            //         ApplicationArea = Basic;
            //         Caption = 'Net Utilizable Amount';
            //     }
            // }
            // group("Statement Details")
            // {
            //     Caption = 'Statement Details';
            //     Visible = BankStatementDetailsVisible;
            //     field("Bank Statement Avarage Credits"; Rec."Bank Statement Avarage Credits")
            //     {
            //         ApplicationArea = Basic;
            //     }
            //     field("Bank Statement Avarage Debits"; Rec."Bank Statement Avarage Debits")
            //     {
            //         ApplicationArea = Basic;
            //     }

            //     group("Monthly Expenses Details")
            //     {
            //         Caption = 'Monthly Expenses Details';
            //         field("BSExpenses Rent"; Rec."BSExpenses Rent")
            //         {
            //             ApplicationArea = Basic;
            //             Caption = 'Rent';
            //         }
            //         field("BSExpenses Transport"; Rec."BSExpenses Transport")
            //         {
            //             ApplicationArea = Basic;
            //             Caption = 'Transport';
            //         }
            //         field("BSExpenses Education"; Rec."BSExpenses Education")
            //         {
            //             ApplicationArea = Basic;
            //             Caption = 'Education';
            //         }
            //         field("BSExpenses Food"; Rec."BSExpenses Food")
            //         {
            //             ApplicationArea = Basic;
            //             Caption = 'Food';
            //         }
            //         field("BSExpenses Utilities"; Rec."BSExpenses Utilities")
            //         {
            //             ApplicationArea = Basic;
            //             Caption = 'Utilities';
            //         }
            //         field("BSExpenses Others"; Rec."BSExpenses Others")
            //         {
            //             ApplicationArea = Basic;
            //             Caption = 'Others';
            //         }
            //         field("<Exisiting Loans Repayments.>"; Rec."Exisiting Loans Repayments")
            //         {
            //             ApplicationArea = Basic;
            //             Caption = 'Exisiting Loans Repayments.';
            //         }
            //     }
            //     field("Bank Statement Net Income"; Rec."Bank Statement Net Income")
            //     {
            //         ApplicationArea = Basic;
            //     }
            // }
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
            part(Control1000000005; "Loan Collateral Security")
            {
                Caption = 'Securities';
                SubPageLink = "Loan No" = field("Loan  No.");
                Editable = true;
            }
            part(Control1000000004; "Loans Guarantee Details")
            {
                Caption = 'Guarantors Detail';
                SubPageLink = "Loan No" = field("Loan  No.");
                Editable = true;
            }
        }
        area(factboxes)
        {
            part(Control1000000010; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("Client Code");
            }
            // part(WorkflowStatus; "Workflow Status FactBox")
            // {
            //     Editable = false;
            //     Enabled = false;
            //     ShowFilter = false;
            // }
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
                action("Loan Application Form")
                {
                    ApplicationArea = Basic;
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = "Report";
                    // Visible = false;

                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.Run(50896, true, false, LoanApp);
                        end;
                    end;
                }
                action("Reject Loan Application")
                {
                    ApplicationArea = Basic;
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Confirm Rejection?', false) = true then begin
                            Rec."Intent to Reject" := true;

                            RejectionDetailsVisible := false;
                            if Rec."Intent to Reject" = true then begin
                                RejectionDetailsVisible := true;
                            end;

                            if Rec."Rejection  Remark" = '' then begin
                                Error('Specify the Rejection Remarks/Reason on the Rejection Details Tab');
                            end else
                                Rec."Rejected By" := UserId;
                            Rec."Date of Rejection" := WorkDate;
                            Rec."Approval Status" := "approval status"::Rejected;
                            Rec."Loan Status" := Rec."loan status"::Rejected;

                            //=========================================================================================Loan Stages Common On All Applications
                            ObjLoanStages.Reset;
                            ObjLoanStages.SetRange(ObjLoanStages."Loan Security Applicable", ObjLoanStages."loan security applicable"::Declined);
                            ObjLoanStages.SetFilter("Min Loan Amount", '=%1', 0);
                            if ObjLoanStages.FindSet then begin
                                repeat
                                    ObjLoanApplicationStages.Init;
                                    ObjLoanApplicationStages."Loan No" := Rec."Loan  No.";
                                    ObjLoanApplicationStages."Member No" := Rec."Client Code";
                                    ObjLoanApplicationStages."Member Name" := Rec."Client Name";
                                    ObjLoanApplicationStages."Loan Stage" := ObjLoanStages."Loan Stage";
                                    ObjLoanApplicationStages."Loan Stage Description" := ObjLoanStages."Loan Stage Description";
                                    ObjLoanApplicationStages."Stage Status" := ObjLoanApplicationStages."stage status"::Succesful;
                                    ObjLoanApplicationStages."Updated By" := UserId;
                                    ObjLoanApplicationStages."Date Upated" := WorkDate;
                                    ObjLoanApplicationStages.Insert;
                                until ObjLoanStages.Next = 0;
                            end;

                        end;

                        CurrPage.Close;
                    end;
                }
                action("Account Statement Transactions ")
                {
                    ApplicationArea = Basic;
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Appraisal Statement Buffe";
                    RunPageLink = "Loan No" = field("Loan  No.");
                }
                action("Member Deposit Saving History")
                {
                    ApplicationArea = Basic;
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Deposit Saving History";
                    RunPageLink = "Loan No" = field("Loan  No.");
                }

                action("Loan Appraisal")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal';
                    // Enabled = EditableAction;
                    Image = GanttChart;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        //mjk
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.Run(50199, true, false, LoanApp);
                            //50384
                            // Report.Run(50384, true, false, LoanApp);
                        end;
                        //=========================================================================================Loan Stages Common On All Applications
                        FnRunCreateLoanStages;//========================================================Update Loan Stages

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

                        SFactory.FnGenerateLoanRepaymentSchedule(Rec."Loan  No.");
                        Commit;
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then begin

                            Report.Run(50477, true, false, LoanApp);
                        end;
                    end;
                }
                action("Reset Loan Application")
                {
                    ApplicationArea = Basic;
                    Enabled = EditableAction;
                    Image = RefreshExcise;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            Rec."Client Code" := '';
                            Rec."Client Name" := '';
                            Rec."ID NO" := '';
                            Rec."Staff No" := '';
                            //  Rec.Installments := 0;
                            Rec.Interest := 0;
                            Rec."Requested Amount" := 0;
                            Rec."Approved Amount" := 0;
                        end;
                    end;
                }
                action("Loan Partial Disburesment")
                {
                    ApplicationArea = Basic;
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    // RunObject = Page "Tranch Disbursment Details";
                    // RunPageLink = "Loan No"=field("Loan  No.");

                    trigger OnAction()
                    begin
                        //ObjTranch.RESET;
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
                    RunObject = Page "Loan Offset Detail List";
                    RunPageLink = "Loan No." = field("Loan  No."),
                                  "Client Code" = field("Client Code");
                }
                action("Update PAYE")
                {
                    ApplicationArea = Basic;
                    Enabled = EditableAction;
                    Image = PayrollStatistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        GenSetUp.Get();
                        Nettakehome := Rec."Gross Pay" * 1 / 3; //Normally should be 1/3 of Basic
                                                                //MESSAGE('%1',Nettakehome);
                                                                /*IF GenSetUp."Minimum Take home"<>0 THEN BEGIN
                                                                  Nettakehome:=GenSetUp."Minimum Take home";
                                                                  END;*/
                        Rec.Modify;


                        GrossPay := Rec."Basic Pay H" + Rec."Medical AllowanceH" + Rec."House AllowanceH" + Rec."Other Income" + Rec."Transport/Bus Fare";
                        Rec."Gross Pay" := GrossPay;
                        Rec.Modify;

                        // CalcFields("Bridge Amount Release");

                        // "Utilizable Amount":=0;
                        // NetUtilizable:=0;

                        // OTrelief:="Other Tax Relief";
                        // "Chargeable Pay":="Gross Pay"+"Other Tax Relief"-"Provident Fund"-"Pension Scheme";
                        // if Disabled<>true then
                        //  begin
                        //      Rec.PAYE:=SFactory.FnCalculatePaye("Chargeable Pay");
                        // end;
                        // TotalDeductions:="Monthly Contribution"+NSSF+NHIF+PAYE+"Risk MGT"+"Staff Union Contribution"+"Medical Insurance"
                        // +"Life Insurance"+"Other Liabilities"+"Other Loans Repayments"+"Sacco Deductions"+"Provident Fund (Self)"+"Existing Loan Repayments";

                        // "Utilizable Amount":=(2*GrossPay)/3-TotalDeductions;

                        // TotalDeductions:="Monthly Contribution"+NSSF+NHIF+PAYE+"Risk MGT"+"Staff Union Contribution"+"Medical Insurance"
                        // +"Life Insurance"+"Other Liabilities"+"Other Loans Repayments"+"Sacco Deductions"+"Provident Fund (Self)"+"Existing Loan Repayments";


                        // NetUtilizable:="Utilizable Amount"+"Bridge Amount Release"+"Non Payroll Payments";
                        // "Net Utilizable Amount":=NetUtilizable;
                        // "Total DeductionsH":=TotalDeductions;
                        // "Net take Home":=Nettakehome;
                        // Modify;

                    end;
                }
                action("Move to Appraisal")
                {
                    ApplicationArea = Basic;
                    Image = Recalculate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to move this Loan to Appraisal Stage ?', true) = false then
                            exit;
                        Rec."Loan Status" := Rec."loan status"::Appraisal;
                        Rec.Modify;
                    end;
                }
                action("Notify Guarantors")
                {
                    ApplicationArea = Basic;
                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        compinfo.Get();
                        if Confirm('Are you sure you want to notify Guarantors about this Loan ?', true) = false then
                            exit;
                        if Rec."Notify Guarantor SMS" then begin
                            if Confirm('You have already notified Guarantors about this Loan.Do you want to send another SMS ?', true) = false then
                                exit;
                        end;
                        Rec."Notify Guarantor SMS" := true;
                        LoanGuar.Reset;
                        LoanGuar.SetRange(LoanGuar."Loan No", Rec."Loan  No.");
                        if LoanGuar.Find('-') then begin
                            repeat
                                Cust.Reset;
                                Cust.SetRange(Cust."No.", LoanGuar."Member No");
                                if Cust.Find('-') then begin
                                    SFactory.FnSendSMS('LOAN GUARANTORS', 'You have guaranteed ' + Rec."Client Name" + ' a ' + Rec."Loan Product Type Name" + ' of ' + Format(Rec."Approved Amount")
                                   + '. Call 0728102039 if in dispute.RUAI ENDELEA Sacco Ltd.', SFactory.FnGetFosaAccount(Rec."Client Code"), SFactory.FnGetPhoneNumber(Rec));
                                end;
                            until LoanGuar.Next = 0;
                        end;
                        SFactory.FnSendSMS('LOAN ISSUE', 'Your loan application of KSHs.' + Format(Rec."Requested Amount") + ' has been received and your qualification is KSHs.' + Format(Rec."Approved Amount") + ' The application is being processed.RUAI ENDELEA Sacco Ltd',
                        SFactory.FnGetFosaAccount(Rec."Client Code"), SFactory.FnGetPhoneNumber(Rec));
                        Rec.Modify;
                    end;
                }
                action("Load Account Statement Details")
                {
                    ApplicationArea = Basic;
                    Image = InsertAccount;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        //Clear Buffer
                        ObjStatementB.Reset;
                        ObjStatementB.SetRange(ObjStatementB."Loan No", Rec."Loan  No.");
                        if ObjStatementB.FindSet then begin
                            ObjStatementB.DeleteAll;
                        end;



                        //Initialize Variables
                        VerMonth1CreditAmount := 0;
                        VerMonth1DebitAmount := 0;
                        VerMonth2CreditAmount := 0;
                        VerMonth2DebitAmount := 0;
                        VerMonth3CreditAmount := 0;
                        VerMonth3DebitAmount := 0;
                        VerMonth4CreditAmount := 0;
                        VerMonth4DebitAmount := 0;
                        VerMonth5CreditAmount := 0;
                        VerMonth5DebitAmount := 0;
                        VerMonth6CreditAmount := 0;
                        VerMonth6DebitAmount := 0;
                        GenSetUp.Get();

                        //Month 1
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth1Date := Date2dmy(StatementStartDate, 1);
                        VerMonth1Month := Date2dmy(StatementStartDate, 2);
                        VerMonth1Year := Date2dmy(StatementStartDate, 3);


                        VerMonth1StartDate := Dmy2date(1, VerMonth1Month, VerMonth1Year);
                        VerMonth1EndDate := CalcDate('CM', VerMonth1StartDate);

                        VarMonth1Datefilter := Format(VerMonth1StartDate) + '..' + Format(VerMonth1EndDate);
                        VerMonth1CreditAmount := 0;
                        VerMonth1DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", Rec."Statement Account");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth1Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth1DebitAmount := VerMonth1DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth1CreditAmount := VerMonth1CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := Rec."Loan  No.";
                            ObjStatementB."Transaction Date" := VerMonth1EndDate;
                            ObjStatementB."Transaction Description" := 'Month 1 Transactions';
                            ObjStatementB."Amount Out" := VerMonth1DebitAmount;
                            ObjStatementB."Amount In" := VerMonth1CreditAmount * -1;
                            ObjStatementB.Insert;

                        end;


                        //Month 2
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth2Date := Date2dmy(StatementStartDate, 1);
                        VerMonth2Month := (VerMonth1Month + 1);
                        VerMonth2Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth2Month > 12 then begin
                            VerMonth2Month := VerMonth2Month - 12;
                            VerMonth2Year := VerMonth2Year + 1;
                        end;

                        VerMonth2StartDate := Dmy2date(1, VerMonth2Month, VerMonth1Year);
                        VerMonth2EndDate := CalcDate('CM', VerMonth2StartDate);
                        VarMonth2Datefilter := Format(VerMonth2StartDate) + '..' + Format(VerMonth2EndDate);
                        VerMonth2CreditAmount := 0;
                        VerMonth2DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", Rec."Statement Account");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth2Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth2DebitAmount := VerMonth2DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth2CreditAmount := VerMonth2CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := Rec."Loan  No.";
                            ObjStatementB."Transaction Date" := VerMonth2EndDate;
                            ObjStatementB."Transaction Description" := 'Month 2 Transactions';
                            ObjStatementB."Amount Out" := VerMonth2DebitAmount;
                            ObjStatementB."Amount In" := VerMonth2CreditAmount * -1;
                            ObjStatementB.Insert;

                        end;

                        VerMonth3CreditAmount := 0;
                        VerMonth3DebitAmount := 0;
                        //Month 3
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth3Date := Date2dmy(StatementStartDate, 1);
                        VerMonth3Month := (VerMonth1Month + 2);
                        VerMonth3Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth3Month > 12 then begin
                            VerMonth3Month := VerMonth3Month - 12;
                            VerMonth3Year := VerMonth3Year + 1;
                        end;

                        VerMonth3StartDate := Dmy2date(1, VerMonth3Month, VerMonth3Year);
                        VerMonth3EndDate := CalcDate('CM', VerMonth3StartDate);
                        VarMonth3Datefilter := Format(VerMonth3StartDate) + '..' + Format(VerMonth3EndDate);
                        VerMonth3CreditAmount := 0;
                        VerMonth3DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", Rec."Statement Account");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth3Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth3DebitAmount := VerMonth3DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth3CreditAmount := VerMonth3CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := Rec."Loan  No.";
                            ObjStatementB."Transaction Date" := VerMonth3EndDate;
                            ObjStatementB."Transaction Description" := 'Month 3 Transactions';
                            ObjStatementB."Amount Out" := VerMonth3DebitAmount;
                            ObjStatementB."Amount In" := VerMonth3CreditAmount * -1;
                            ObjStatementB.Insert;
                        end;


                        //Month 4
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth4Date := Date2dmy(StatementStartDate, 1);
                        VerMonth4Month := (VerMonth1Month + 3);
                        VerMonth4Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth4Month > 12 then begin
                            VerMonth4Month := VerMonth4Month - 12;
                            VerMonth4Year := VerMonth4Year + 1;
                        end;

                        VerMonth4StartDate := Dmy2date(1, VerMonth4Month, VerMonth4Year);
                        VerMonth4EndDate := CalcDate('CM', VerMonth4StartDate);
                        VarMonth4Datefilter := Format(VerMonth4StartDate) + '..' + Format(VerMonth4EndDate);

                        VerMonth4CreditAmount := 0;
                        VerMonth4DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", Rec."Statement Account");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth4Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth4DebitAmount := VerMonth4DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth4CreditAmount := VerMonth4CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := Rec."Loan  No.";
                            ObjStatementB."Transaction Date" := VerMonth4EndDate;
                            ObjStatementB."Transaction Description" := 'Month 4 Transactions';
                            ObjStatementB."Amount Out" := VerMonth4DebitAmount;
                            ObjStatementB."Amount In" := VerMonth4CreditAmount * -1;
                            ObjStatementB.Insert;
                        end;


                        //Month 5
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth5Date := Date2dmy(StatementStartDate, 1);
                        VerMonth5Month := (VerMonth1Month + 4);
                        VerMonth5Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth5Month > 12 then begin
                            VerMonth5Month := VerMonth5Month - 12;
                            VerMonth5Year := VerMonth5Year + 1;
                        end;

                        VerMonth5StartDate := Dmy2date(1, VerMonth5Month, VerMonth5Year);
                        VerMonth5EndDate := CalcDate('CM', VerMonth5StartDate);
                        VarMonth5Datefilter := Format(VerMonth5StartDate) + '..' + Format(VerMonth5EndDate);

                        VerMonth5CreditAmount := 0;
                        VerMonth5DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", Rec."Statement Account");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth5Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth5DebitAmount := VerMonth5DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth5CreditAmount := VerMonth5CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := Rec."Loan  No.";
                            ObjStatementB."Transaction Date" := VerMonth5EndDate;
                            ObjStatementB."Transaction Description" := 'Month 5 Transactions';
                            ObjStatementB."Amount Out" := VerMonth5DebitAmount;
                            ObjStatementB."Amount In" := VerMonth5CreditAmount * -1;
                            ObjStatementB.Insert;
                        end;


                        //Month 6
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth6Date := Date2dmy(StatementStartDate, 1);
                        VerMonth6Month := (VerMonth1Month + 5);
                        VerMonth6Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth6Month > 12 then begin
                            VerMonth6Month := VerMonth6Month - 12;
                            VerMonth6Year := VerMonth6Year + 1;
                        end;

                        VerMonth6StartDate := Dmy2date(1, VerMonth6Month, VerMonth6Year);
                        VerMonth6EndDate := CalcDate('CM', VerMonth6StartDate);
                        VarMonth6Datefilter := Format(VerMonth6StartDate) + '..' + Format(VerMonth6EndDate);

                        VerMonth6CreditAmount := 0;
                        VerMonth6DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", Rec."Statement Account");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth6Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat

                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth6DebitAmount := VerMonth6DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth6CreditAmount := VerMonth6CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := Rec."Loan  No.";
                            ObjStatementB."Transaction Date" := VerMonth6EndDate;
                            ObjStatementB."Transaction Description" := 'Month 6 Transactions';
                            ObjStatementB."Amount Out" := VerMonth6DebitAmount;
                            ObjStatementB."Amount In" := VerMonth6CreditAmount * -1;
                            ObjStatementB.Insert;
                        end;

                        VerStatementAvCredits := 0;
                        //Get Statement Avarage Credits
                        ObjStatementB.Reset;
                        ObjStatementB.SetRange(ObjStatementB."Loan No", Rec."Loan  No.");
                        //ObjStatementB.SETFILTER(ObjStatementB.Amount,'<%1',0);
                        if ObjStatementB.FindSet then begin
                            repeat
                                VerStatementAvCredits := VerStatementAvCredits + ObjStatementB."Amount In";
                                Rec."Bank Statement Avarage Credits" := VerStatementAvCredits / 6;
                                Rec.Modify;
                            until ObjStatementB.Next = 0;
                        end;

                        VerStatementsAvDebits := 0;
                        //Get Statement Avarage Debits
                        ObjStatementB.Reset;
                        ObjStatementB.SetRange(ObjStatementB."Loan No", Rec."Loan  No.");
                        //ObjStatementB.SETFILTER(ObjStatementB.Amount,'>%1',0);
                        if ObjStatementB.FindSet then begin
                            repeat
                                VerStatementsAvDebits := VerStatementsAvDebits + ObjStatementB."Amount Out";
                                Rec."Bank Statement Avarage Debits" := VerStatementsAvDebits / 6;
                                Rec.Modify;
                            until ObjStatementB.Next = 0;
                        end;

                        Rec."Bank Statement Net Income" := Rec."Bank Statement Avarage Credits" - Rec."Bank Statement Avarage Debits";
                        Rec.Modify;
                    end;
                }
                action("FOSA Statement")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

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
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Text001: label 'This transaction is already pending approval';
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                        ObjLoanRepaySchedule: Record "Loan Repayment Schedule";
                    begin
                        //Check for Existing Loan of the Same Product
                        LoansRec.Reset;
                        LoansRec.SetRange(LoansRec."BOSA No", Rec."BOSA No");
                        LoansRec.SetRange(LoansRec."Loan Product Type", Rec."Loan Product Type");
                        if LoansRec.Find('-') then begin
                            repeat
                                if LoansRec."Loan Product Type" <> 'GUR' then begin
                                    LoansRec.CalcFields(LoansRec."Outstanding Balance", LoansRec."Loan Offset Amount");
                                    if (LoansRec."Outstanding Balance" > 1) and (Rec."Loan Offset Amount" = 0) and (Rec."Loan to Reschedule" = '') then begin
                                        if Rec."Top Up Amount" > 0 then begin
                                            //Allow Top up even if there is an outstanding loan of the same type
                                        end else
                                            Error('The Member has an exsiting %1', Rec."Loan Product Type");
                                    end;
                                end;
                            until LoansRec.Next = 0;
                        end;
                        //End Check for Existing Loan of the Same Product

                        //View Loan Repayment Schedule----------------------------------------------------------------------------
                        // ObjLoanRepaySchedule.Reset;
                        // ObjLoanRepaySchedule.SetRange(ObjLoanRepaySchedule."Loan No.", Rec."Loan  No.");
                        // if ObjLoanRepaySchedule.Find('-') = false then begin
                        //     ('Kindly View the Loan Repayment Schedule before sending this application for Approval!');
                        // end;
                        //End View Loan Repayment Schedule----------------------------------------------------------------------------



                        Rec.TestField("Requested Amount");
                        //Rec.TestField("Recovery Mode");

                        if Rec."Approved Amount" <= 0 then begin
                            Error(ErrorApproval);
                        end;

                        MicropointApprovalsCodeUnit.SendLoansRegisterRequestForApproval(rec."Loan  No.", Rec);
                        // CurrPage.close();
                        GenSetUp.Get();

                        if GenSetUp."Send Loan App SMS" = true then begin
                            FnSendReceivedApplicationSMS();
                        end;
                        if GenSetUp."Send Loan App Email" = true then begin
                            FnSendReceivedLoanApplEmail(Rec."Loan  No.");
                        end;

                        if GenSetUp."Send Guarantorship SMS" = true then begin
                            //  FnSendGuarantorAppSMS(Rec."Loan  No.");
                        end;

                        CurrPage.Close;
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

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
        UpdateControl();
        EnableCreateMember := false;
        // EditableAction:=true;
        // ShowWorkflowStatus := CurrPage.WorkflowStatus.Page.SetFilterOnWorkflowRecord(RecordId);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        // CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec."Approval Status" = Rec."approval status"::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
        if (Rec."Approval Status" = Rec."approval status"::Approved) then
            EnableCreateMember := true;

        if Rec."Approval Status" <> Rec."approval status"::Open then
            EditableAction := false;
    end;

    trigger OnAfterGetRecord()
    begin
        //Rec.Source := Rec.Source::BOSA;
        Rec.Source := Rec.Source::MICRO;
        FnVisibility();

        TrunchDetailsVisible := false;

        if (Rec."Disburesment Type" = Rec."disburesment type"::"Full/Single disbursement") or (Rec."Disburesment Type" = Rec."disburesment type"::" ") then begin
            TrunchDetailsVisible := false;
        end else
            TrunchDetailsVisible := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        /*LoansR.RESET;
        LoansR.SETRANGE(LoansR.Posted,FALSE);
        LoansR.SETRANGE(LoansR."Captured By",USERID);
        IF LoansR."Client Name"='' THEN BEGIN
          IF LoansR.COUNT >1 THEN
          BEGIN
            IF CONFIRM('There are still some Unused Loan Nos. Continue?',FALSE)=FALSE THEN
              BEGIN
                ERROR('There are still some Unused Loan Nos. Please utilise them first');
              END;
          END;
          END;*/

    end;

    trigger OnModifyRecord(): Boolean
    begin
        LoanAppPermisions();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Source := Rec.Source::MICRO;
        Rec."Mode of Disbursement" := Rec."mode of disbursement"::"Bank Transfer";

    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        /*IF "Loan Status"="Loan Status"::Approved THEN
        CurrPage.EDITABLE:=FALSE; */

    end;

    trigger OnOpenPage()
    begin
        //SETRANGE(Posted,FALSE);
        /*IF "Loan Status"="Loan Status"::Approved THEN
        CurrPage.EDITABLE:=FALSE;*/
        Rec.Source := Rec.Source::MICRO;
        FnVisibility();
        TrunchDetailsVisible := false;

        if (Rec."Disburesment Type" = Rec."disburesment type"::"Full/Single disbursement") or (Rec."Disburesment Type" = Rec."disburesment type"::" ") then begin
            TrunchDetailsVisible := false;
        end else
            TrunchDetailsVisible := true;

    end;

    var
        MicropointApprovalsCodeUnit: Codeunit "Micropoint ApprovalsCodeUnit";
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
        LInsurance: Decimal;
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
        //SalDetails: Record "Loan Appraisal Salary Details";
        LGuarantors: Record "Loans Guarantee Details";
        Text001: label 'Status Must Be Open';
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
        LoanAppMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to RUAI ENDELEA Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your Loan Application has been received and Undergoing Approval</p><p style="font-family:Verdana,Arial;font-size:9pt"> </b></p><br>Regards<p>%3</p><p><b>RUAI ENDELEA SACCO LTD</b></p>';
        ScheduleBal: Decimal;
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        EnableCreateMember: Boolean;
        EditableAction: Boolean;
        SFactory: Codeunit "Micropoint Factory";
        SMSMessageText: label 'Your loan application of KSHs.%1 has been received and your qualification is KSHs.%2 The application is being processed.%3.';
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
        ObjMemberCellG: Record "Member House Groups";
        TrunchDetailsVisible: Boolean;
        ObjTranch: Record "Tranch Disburesment Details";
        ErrorApproval: label 'Approved Amount of Zero or Less Can not be sent for Approval';
        RejectionDetailsVisible: Boolean;
        ObjLoanStages: Record "Loan Stages";
        ObjLoanApplicationStages: Record "Loan Application Stages";
        ShowWorkflowStatus: Boolean;


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
            LoanReferee1NameEditable := true;
            LoanReferee2NameEditable := true;
            LoanReferee1MobileEditable := true;
            LoanReferee2MobileEditable := true;
            LoanReferee1AddressEditable := true;
            LoanReferee2AddressEditable := true;
            LoanReferee1PhyAddressEditable := true;
            LoanReferee2PhyAddressEditable := true;
            LoanReferee1RelationEditable := true;
            LoanReferee2RelationEditable := true;
            WitnessEditable := true;
            LoanPurposeEditable := true;
            RecoveryModeEditable := true;
            RemarksEditable := true;
            LoanPurposeEditable := true;
            CopyofIDEditable := true;
            CopyofPayslipEditable := true;
            AccountNoEditable := true;
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
            LoanReferee1NameEditable := false;
            LoanReferee2NameEditable := false;
            LoanReferee1MobileEditable := false;
            LoanReferee2MobileEditable := false;
            LoanReferee1AddressEditable := false;
            LoanReferee2AddressEditable := false;
            LoanReferee1PhyAddressEditable := false;
            LoanReferee2PhyAddressEditable := false;
            LoanReferee1RelationEditable := false;
            LoanReferee2RelationEditable := false;
            WitnessEditable := false;
            LoanPurposeEditable := false;
            RecoveryModeEditable := false;
            RemarksEditable := false;
            LoanPurposeEditable := false;
            CopyofIDEditable := false;
            CopyofPayslipEditable := false;
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
            LoanReferee1NameEditable := false;
            LoanReferee2NameEditable := false;
            LoanReferee1MobileEditable := false;
            LoanReferee2MobileEditable := false;
            LoanReferee1AddressEditable := false;
            LoanReferee2AddressEditable := false;
            LoanReferee1PhyAddressEditable := false;
            LoanReferee2PhyAddressEditable := false;
            LoanReferee1RelationEditable := false;
            LoanReferee2RelationEditable := false;
            WitnessEditable := false;
            LoanPurposeEditable := false;
            RecoveryModeEditable := false;
            RemarksEditable := false;
            LoanPurposeEditable := false;
            CopyofIDEditable := false;
            CopyofPayslipEditable := false;
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
            LoanReferee1NameEditable := false;
            LoanReferee2NameEditable := false;
            LoanReferee1MobileEditable := false;
            LoanReferee2MobileEditable := false;
            LoanReferee1AddressEditable := false;
            LoanReferee2AddressEditable := false;
            LoanReferee1PhyAddressEditable := false;
            LoanReferee2PhyAddressEditable := false;
            LoanReferee1RelationEditable := false;
            LoanReferee2RelationEditable := false;
            WitnessEditable := false;
            LoanPurposeEditable := false;
            RecoveryModeEditable := false;
            RemarksEditable := false;
            LoanPurposeEditable := false;
        end;
    end;


    procedure LoanAppPermisions()
    begin
    end;


    procedure FnSendReceivedApplicationSMS()
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
        SMSMessage."Batch No" := Rec."Batch No.";
        SMSMessage."Document No" := Rec."Loan  No.";
        SMSMessage."Account No" := Rec."Account No";
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := 'LOANAPP';
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := 'Dear Member,Your Loan of amount ' + Format(Rec."Requested Amount") + ' for ' +
        Rec."Client Code" + ' ' + Rec."Client Name" + ' has been received and is being Processed '
        + compinfo.Name + ' ' + GenSetUp."Customer Care No";
        Cust.Reset;
        Cust.SetRange(Cust."No.", Rec."Client Code");
        if Cust.Find('-') then begin
            SMSMessage."Telephone No" := Cust."Mobile Phone No";
        end;
        if Cust."Mobile Phone No" <> '' then
            SMSMessage.Insert;
    end;

    local procedure FnSendReceivedLoanApplEmail(LoanNo: Code[20])
    var
        LoanRec: Record "Loans Register";
        //  SMTPMail: Codeunit UnknownCodeunit400;
        // SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
        Cust: Record Customer;
        Email: Text[50];
    begin
        // SMTPSetup.Get();

        LoanRec.Reset;
        LoanRec.SetRange(LoanRec."Loan  No.", LoanNo);
        if LoanRec.Find('-') then begin
            if Cust.Get(LoanRec."Client Code") then begin
                Email := Cust."E-Mail (Personal)";
                if Cust."E-Mail (Personal)" <> '' then begin

                    if Email = '' then begin
                        Error('Email Address Missing for LoanRecer Application number' + '-' + LoanRec."Loan  No.");
                    end;
                    //   if Email<>'' then
                    //     SMTPMail.CreateMessage(SMTPSetup."Email Sender Name",SMTPSetup."Email Sender Address",Email,'Loan Application','',true);
                    //     SMTPMail.AppendBody(StrSubstNo(LoanAppMessage,LoanRec."Client Name",IDNo,UserId));
                    //     SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
                    //     SMTPMail.AppendBody('<br><br>');
                    //     SMTPMail.AddAttachment(FileName,Attachment);
                    //     SMTPMail.Send;
                end;
            end;
        end;
    end;

    local procedure FnSendGuarantorAppSMS(LoanNo: Code[20])
    var
        Cust: Record Customer;
        Sms: Record "SMS Messages";
    begin
        LGuarantors.Reset;
        LGuarantors.SetRange(LGuarantors."Loan No", Rec."Loan  No.");
        if LGuarantors.FindFirst then begin
            repeat
                if Cust.Get(LGuarantors."Member No") then
                    if Cust."Mobile Phone No" <> '' then


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
                SMSMessage."Batch No" := Rec."Batch No.";
                SMSMessage."Document No" := Rec."Loan  No.";
                SMSMessage."Account No" := Rec."Account No";
                SMSMessage."Date Entered" := Today;
                SMSMessage."Time Entered" := Time;
                SMSMessage.Source := 'GUARANTORSHIP';
                SMSMessage."Entered By" := UserId;
                SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                SMSMessage."SMS Message" := 'Dear Member,You have guaranteed ' + Format(Rec."Client Name")
                + ' ' + Rec."Loan Product Type" + ' of KES. ' + Format(Rec."Approved Amount") + ',' + ' ' + 'Call,' + ' ' + compinfo."Phone No." + ',if in dispute .' + ' ' + compinfo.Name + ' ' + GenSetUp."Customer Care No";
                Cust.Reset;
                Cust.SetRange(Cust."No.", Rec."Client Code");
                if Cust.Find('-') then begin
                    SMSMessage."Telephone No" := Cust."Mobile Phone No";
                end;
                if Cust."Mobile Phone No" <> '' then
                    SMSMessage.Insert;

            until LGuarantors.Next = 0;
        end
    end;

    local procedure FnVisibility()
    begin
        PayslipDetailsVisible := false;
        BankStatementDetailsVisible := false;

        if Rec."Income Type" = Rec."income type"::"Bank Statement" then begin
            BankStatementDetailsVisible := true;
            PayslipDetailsVisible := false
        end else
            if Rec."Income Type" = Rec."income type"::Payslip then begin
                PayslipDetailsVisible := true;
                BankStatementDetailsVisible := false;
            end else
                if Rec."Income Type" = Rec."income type"::"Payslip & Bank Statement" then begin
                    PayslipDetailsVisible := true;
                    BankStatementDetailsVisible := true;
                end;
    end;

    local procedure FnRunCreateLoanStages()
    var
        ObjLoanStages: Record "Loan Stages";
        ObjLoanApplicationStages: Record "Loan Application Stages";
        ObjLoanGuarantors: Record "Loans Guarantee Details";
        ObjLoanCollateral: Record "Loan Collateral Details";
    begin
        ObjLoanApplicationStages.Reset;
        ObjLoanApplicationStages.SetRange("Loan No", Rec."Loan  No.");
        if ObjLoanApplicationStages.FindSet then begin
            ObjLoanApplicationStages.DeleteAll;
        end;

        //=========================================================================================Loan Stages Based On Amount
        ObjLoanStages.Reset;
        ObjLoanStages.SetRange("Mobile App Specific", false);
        if ObjLoanStages.Find('-') then begin
            repeat
                if (Rec."Requested Amount" >= ObjLoanStages."Min Loan Amount") and (Rec."Requested Amount" <= ObjLoanStages."Max Loan Amount") then begin

                    ObjLoanApplicationStages.Init;
                    ObjLoanApplicationStages."Loan No" := Rec."Loan  No.";
                    ObjLoanApplicationStages."Member No" := Rec."Client Code";
                    ObjLoanApplicationStages."Member Name" := Rec."Client Name";
                    ObjLoanApplicationStages."Loan Stage" := ObjLoanStages."Loan Stage";
                    ObjLoanApplicationStages."Loan Stage Description" := ObjLoanStages."Loan Stage Description";
                    ObjLoanApplicationStages.Insert;
                end;
            until ObjLoanStages.Next = 0;
        end;

        //=========================================================================================Loan Stages Based On Group Guarantorship
        ObjLoanGuarantors.Reset;
        ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Loan No", Rec."Loan  No.");
        if ObjLoanGuarantors.Find('-') = true then begin
            if Rec."Member House Group" <> '' then begin
                ObjLoanStages.Reset;
                ObjLoanStages.SetRange("Mobile App Specific", false);
                ObjLoanStages.SetRange(ObjLoanStages."Loan Security Applicable", ObjLoanStages."loan security applicable"::"Group Guarantorship");
                if ObjLoanStages.FindSet then begin
                    repeat
                        ObjLoanApplicationStages.Init;
                        ObjLoanApplicationStages."Loan No" := Rec."Loan  No.";
                        ObjLoanApplicationStages."Member No" := Rec."Client Code";
                        ObjLoanApplicationStages."Member Name" := Rec."Client Name";
                        ObjLoanApplicationStages."Loan Stage" := ObjLoanStages."Loan Stage";
                        ObjLoanApplicationStages."Loan Stage Description" := ObjLoanStages."Loan Stage Description";
                        ObjLoanApplicationStages.Insert;
                    until ObjLoanStages.Next = 0;
                end;
            end;
        end;

        //=========================================================================================Loan Stages Based On Collateral Security
        ObjLoanCollateral.Reset;
        ObjLoanCollateral.SetRange(ObjLoanCollateral."Loan No", Rec."Loan  No.");
        if ObjLoanCollateral.Find('-') = true then begin

            ObjLoanStages.Reset;
            ObjLoanStages.SetRange("Mobile App Specific", false);
            ObjLoanStages.SetRange(ObjLoanStages."Loan Security Applicable", ObjLoanStages."loan security applicable"::"Collateral Security");
            if ObjLoanStages.FindSet then begin
                repeat
                    ObjLoanApplicationStages.Init;
                    ObjLoanApplicationStages."Loan No" := Rec."Loan  No.";
                    ObjLoanApplicationStages."Member No" := Rec."Client Code";
                    ObjLoanApplicationStages."Member Name" := Rec."Client Name";
                    ObjLoanApplicationStages."Loan Stage" := ObjLoanStages."Loan Stage";
                    ObjLoanApplicationStages."Loan Stage Description" := ObjLoanStages."Loan Stage Description";
                    ObjLoanApplicationStages.Insert;
                until ObjLoanStages.Next = 0;
            end;
        end;

        //=========================================================================================Loan Stages Common On All Applications
        ObjLoanStages.Reset;
        ObjLoanStages.SetRange("Mobile App Specific", false);
        ObjLoanStages.SetFilter("Loan Purpose", '=%1', '');
        ObjLoanStages.SetRange(ObjLoanStages."Loan Security Applicable", ObjLoanStages."loan security applicable"::All);
        ObjLoanStages.SetFilter("Min Loan Amount", '=%1', 0);
        if ObjLoanStages.FindSet then begin
            repeat
                ObjLoanApplicationStages.Init;
                ObjLoanApplicationStages."Loan No" := Rec."Loan  No.";
                ObjLoanApplicationStages."Member No" := Rec."Client Code";
                ObjLoanApplicationStages."Member Name" := Rec."Client Name";
                ObjLoanApplicationStages."Loan Stage" := ObjLoanStages."Loan Stage";
                ObjLoanApplicationStages."Loan Stage Description" := ObjLoanStages."Loan Stage Description";
                ObjLoanApplicationStages.Insert;
            until ObjLoanStages.Next = 0;
        end;

        //=========================================================================================Loan Stages Based On Education Finance
        if Rec."Loan Purpose" <> '' then begin
            ObjLoanStages.Reset;
            ObjLoanStages.SetRange("Mobile App Specific", false);
            ObjLoanStages.SetFilter("Loan Purpose", '<>%1', '');
            ObjLoanStages.SetRange(ObjLoanStages."Loan Purpose", Rec."Loan Purpose");
            if ObjLoanStages.FindSet then begin
                repeat
                    ObjLoanApplicationStages.Init;
                    ObjLoanApplicationStages."Loan No" := Rec."Loan  No.";
                    ObjLoanApplicationStages."Member No" := Rec."Client Code";
                    ObjLoanApplicationStages."Member Name" := Rec."Client Name";
                    ObjLoanApplicationStages."Loan Stage" := ObjLoanStages."Loan Stage";
                    ObjLoanApplicationStages."Loan Stage Description" := ObjLoanStages."Loan Stage Description";
                    ObjLoanApplicationStages.Insert;
                until ObjLoanStages.Next = 0;
            end;
        end;
    end;

    local procedure fncheckifmemberqualifiesforproduct(memberno: Code[50]; loantype: Code[20])
    var
        loanptsEtuptable: Record "Loan Products Setup";
        membersreg: record Customer;
    begin
        // loanptsEtuptable.RESET;
        // loanptsEtuptable.SETRANGE(loanptsEtuptable.Code, loantype);
        // IF loanptsEtuptable.FIND('-') THEN BEGIN
        //     IF (loanptsEtuptable."Minimum Deposit For Loan Appl" > 0) OR (loanptsEtuptable."Minimum Deposit For Loan Appl" > 0) OR (loanptsEtuptable.mi > 0) THEN BEGIN
        //         membersreg.RESET;
        //         membersreg.SETRANGE(membersreg."No.", memberno);
        //         membersreg.SETAUTOCALCFIELDS(membersreg."Current Shares", membersreg."Shares Retained");
        //         IF membersreg.FIND('-') THEN BEGIN
        //             //...............check on depOsits contributions minimum
        //             IF membersreg."Monthly Contribution" < loanptsEtuptable."minimum deposits contrib" THEN BEGIN
        //                 ERROR('member monthly contributions of ' + FORMAT(membersreg."Monthly Contribution") + ' do not qualify for this loan.' +
        //                 'one must have a minimum monthly contribution of ' + FORMAT(loanptsEtuptable."minimum deposits contrib"));
        //             END;
        //             //...............check on depOsits amounts
        //             IF membersreg."Current Shares" < loanptsEtuptable."minimum deposits amounts" THEN BEGIN
        //                 ERROR('member current share deposits of ' + FORMAT(membersreg."Current Shares") + ' do not qualify for this loan.' +
        //                 'one must have a minimum current share deposits of ' + FORMAT(loanptsEtuptable."minimum deposits amounts"));
        //             END;
        //             //...............check on share amounts
        //             IF membersreg."Shares Retained" < loanptsEtuptable."minimum share capital amount" THEN BEGIN
        //                 ERROR('member share capital of ' + FORMAT(membersreg."Shares Retained") + ' do not qualify for this loan.' +
        //                 'one must have a minimum share capital of ' + FORMAT(loanptsEtuptable."minimum share capital amount"));
        //             END;
        //         END;
        //     END;
        // END;
    end;

}

