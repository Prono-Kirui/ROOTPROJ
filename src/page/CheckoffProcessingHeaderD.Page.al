#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50482 "Checkoff Processing Header-D"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Checkoff Header-Distributed";
    SourceTableView = where(Posted = const(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Entered By"; Rec."Entered By")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting date"; Rec."Posting date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Loan CutOff Date"; Rec."Loan CutOff Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Document No./ Cheque No.';
                    ShowMandatory = true;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Total Scheduled"; Rec."Total Scheduled")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Total Count"; Rec."Total Count")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
                }
            }
            part("Checkoff Lines-Distributed"; "Checkoff Processing Lines-D")
            {
                Caption = 'Checkoff Lines-Distributed';
                SubPageLink = "Checkoff No" = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Clear Lines")
            {
                ApplicationArea = Basic;
                Enabled = ActionEnabled;
                Image = CheckList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Confirm('This Action will clear all the Lines for the current Check off. Do you want to Continue') = false then
                        exit;
                    ReceiptLine.Reset;
                    ReceiptLine.SetRange(ReceiptLine."Checkoff No", Rec.No);
                    ReceiptLine.DeleteAll;

                    BATCH_TEMPLATE := 'GENERAL';
                    BATCH_NAME := 'CHECKOFF';
                    DOCUMENT_NO := Rec.Remarks;
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    GenJournalLine.DeleteAll;
                end;
            }
            action("Import Checkoff Distributed")
            {
                ApplicationArea = Basic;
                Caption = 'Import Checkoff';
                Enabled = ActionEnabled;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = XMLport "Import Checkoff Distributed";
            }
            group(ActionGroup1102755021)
            {
            }
            action("Validate Checkoff")
            {
                ApplicationArea = Basic;
                Caption = 'Validate Checkoff';
                Enabled = ActionEnabled;
                Image = ViewCheck;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Rec.TestField("Document No");
                    Rec.TestField(Amount);

                    BATCH_TEMPLATE := 'GENERAL';
                    BATCH_NAME := 'CHECKOFF';
                    DOCUMENT_NO := Rec.Remarks;
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    GenJournalLine.DeleteAll;

                    MembLedg.Reset;
                    MembLedg.SetRange(MembLedg."Document No.", Rec."Document No");
                    if MembLedg.Find('-') = true then
                        Error('Sorry,You have already posted this Document. Validation not Allowed.');
                    ReceiptLine.Reset;
                    ReceiptLine.SetRange(ReceiptLine."Checkoff No", Rec.No);
                    if ReceiptLine.FindSet(true, true) then begin
                        repeat
                            ReceiptLine."Member No" := '';
                            ReceiptLine."Employee Name" := '';
                            ReceiptLine.TOTAL_DISTRIBUTED := 0;
                            ReceiptLine.Modify;
                        until ReceiptLine.Next = 0;
                    end;

                    ReceiptLine.Reset;
                    ReceiptLine.SetRange(ReceiptLine."Checkoff No", Rec.No);
                    if ReceiptLine.Find('-') then begin
                        repeat
                            Memb.Reset;
                            Memb.SetRange(Memb."Personal No", ReceiptLine."Payroll No");
                            if Memb.Find('-') then begin
                                ReceiptLine."Member No" := Memb."No.";
                                ReceiptLine."Employee Name" := Memb.Name;
                                ReceiptLine.TOTAL_DISTRIBUTED :=
                                ReceiptLine.Deposits +
                                ReceiptLine.NORM_P +
                                ReceiptLine.NORM_I +
                                ReceiptLine.REFIN_P +
                                ReceiptLine.REFIN_I +
                                ReceiptLine.EMER_P +
                                ReceiptLine.EMER_I +
                                ReceiptLine.SCHOOL_P +
                                ReceiptLine.SCHOOL_I +
                                ReceiptLine.SPECIAL_P +
                                ReceiptLine.SPECIAL_I +
                                ReceiptLine.INSURANCE +
                                ReceiptLine.GOLDSAVE +
                                ReceiptLine.THIRDPARTY +
                                ReceiptLine.BENEVOLENT +
                                ReceiptLine.ADVANCE_P +
                                ReceiptLine.ADVANCE_I +
                                ReceiptLine.PHONE_P +
                                ReceiptLine.PHONE_I +
                                ReceiptLine.ADVANCENSE_P +
                                ReceiptLine.ADVANCENSE_I +
                                ReceiptLine.SHARES;
                                ReceiptLine.Modify;
                            end;
                        until ReceiptLine.Next = 0;
                    end;
                    Message('Validation was successfully completed');
                end;
            }
            action("Unallocated Funds")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = "Report";
                Visible = false;

                trigger OnAction()
                begin
                    ReptProcHeader.Reset;
                    ReptProcHeader.SetRange(ReptProcHeader.No, Rec.No);
                    if ReptProcHeader.Find('-') then
                        Report.Run(50542, true, false, ReptProcHeader);
                end;
            }
            group(ActionGroup1102755019)
            {
            }
            action("Process Checkoff Distributed")
            {
                ApplicationArea = Basic;
                Caption = 'Process Checkoff';
                Enabled = ActionEnabled;
                Image = Apply;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to Transfer this Checkoff to Journals ?') = true then begin
                        Rec.TestField("Document No");
                        Rec.TestField(Amount);
                        if Rec.Amount <> Rec."Total Scheduled" then
                            Error('Scheduled Amount must be equal to the Cheque Amount');

                        Datefilter := '..' + Format(Rec."Posting date");

                        BATCH_TEMPLATE := 'GENERAL';
                        BATCH_NAME := 'CHECKOFF';
                        DOCUMENT_NO := Rec.Remarks;
                        Counter := 0;
                        Percentage := 0;
                        TotalCount := 0;

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        GenJournalLine.DeleteAll;
                        LineNo := 0;
                        ReceiptLine.Reset;
                        ReceiptLine.SetRange("Checkoff No", Rec.No);
                        if ReceiptLine.Find('-') then begin
                            Window.Open('@1@');
                            TotalCount := ReceiptLine.Count;
                            repeat
                                FnUpdateProgressBar();

                                if ReceiptLine."Member No" <> '' then begin
                                    //----------------------------1. DEPOSITS----------------------------------------------------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                                    GenJournalLine."account type"::Employee, ReceiptLine."Member No", Rec."Posting date", ReceiptLine.Deposits * -1, 'BOSA', Rec."Document No",
                                    Format(GenJournalLine."transaction type"::"Deposit Contribution"), '', GenJournalLine."application source"::" ");




                                    //----------------------------2. NORM_P------------------------------------------------------------------
                                    if FnCheckLoanErrors('NORM', ReceiptLine.NORM_P, ReceiptLine."Member No") then begin
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                                        GenJournalLine."account type"::Employee, ReceiptLine."Member No", Rec."Posting date", (ReceiptLine.NORM_P + ReceiptLine.NORM_I) * -1, 'BOSA', Rec."Document No",
                                        Format(GenJournalLine."transaction type"::"Deposit Contribution"), '', GenJournalLine."application source"::" ");
                                    end else begin
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                        GenJournalLine."account type"::Employee, ReceiptLine."Member No", Rec."Posting date", ReceiptLine.NORM_P * -1, 'BOSA', Rec."Document No",
                                        Format(GenJournalLine."transaction type"::"Loan Repayment"), FnGetLoanNumber(ReceiptLine."Member No", 'NORM'), GenJournalLine."application source"::" ");
                                        //----------------------------3. NORM_I------------------------------------------------------------------
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                        GenJournalLine."account type"::Employee, ReceiptLine."Member No", Rec."Posting date", ReceiptLine.NORM_I * -1, 'BOSA', Rec."Document No",
                                        Format(GenJournalLine."transaction type"::"Interest Paid"), FnGetLoanNumber(ReceiptLine."Member No", 'NORM'), GenJournalLine."application source"::" ");
                                    end;


                                    //----------------------------4. REFIN_P------------------------------------------------------------------
                                    if FnCheckLoanErrors('REFIN', ReceiptLine.REFIN_P, ReceiptLine."Member No") then begin
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                                        GenJournalLine."account type"::Employee, ReceiptLine."Member No", Rec."Posting date", (ReceiptLine.REFIN_P + ReceiptLine.REFIN_I) * -1, 'BOSA', Rec."Document No",
                                        Format(GenJournalLine."transaction type"::"Deposit Contribution"), '', GenJournalLine."application source"::" ");
                                    end else begin
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                        GenJournalLine."account type"::Employee, ReceiptLine."Member No", Rec."Posting date", ReceiptLine.REFIN_P * -1, 'BOSA', Rec."Document No",
                                        Format(GenJournalLine."transaction type"::"Loan Repayment"), FnGetLoanNumber(ReceiptLine."Member No", 'REFIN'), GenJournalLine."application source"::" ");
                                        //----------------------------5. REFIN_I------------------------------------------------------------------
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                        GenJournalLine."account type"::Employee, ReceiptLine."Member No", Rec."Posting date", ReceiptLine.REFIN_I * -1, 'BOSA', Rec."Document No",
                                        Format(GenJournalLine."transaction type"::"Interest Paid"), FnGetLoanNumber(ReceiptLine."Member No", 'REFIN'), GenJournalLine."application source"::" ");
                                    end;


                                    //----------------------------6. EMER_P------------------------------------------------------------------
                                    if FnCheckLoanErrors('EMER', ReceiptLine.EMER_P, ReceiptLine."Member No") then begin
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                                        GenJournalLine."account type"::Employee, ReceiptLine."Member No", Rec."Posting date", (ReceiptLine.EMER_P + ReceiptLine.EMER_I) * -1, 'BOSA', Rec."Document No",
                                        Format(GenJournalLine."transaction type"::"Deposit Contribution"), '', GenJournalLine."application source"::" ");
                                    end else begin
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                        GenJournalLine."account type"::Employee, ReceiptLine."Member No", Rec."Posting date", ReceiptLine.EMER_P * -1, 'BOSA', Rec."Document No",
                                        Format(GenJournalLine."transaction type"::"Loan Repayment"), FnGetLoanNumber(ReceiptLine."Member No", 'EMER'), GenJournalLine."application source"::" ");
                                        //----------------------------7. EMER_I------------------------------------------------------------------
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                        GenJournalLine."account type"::Employee, ReceiptLine."Member No", Rec."Posting date", ReceiptLine.EMER_I * -1, 'BOSA', Rec."Document No",
                                        Format(GenJournalLine."transaction type"::"Interest Paid"), FnGetLoanNumber(ReceiptLine."Member No", 'EMER'), GenJournalLine."application source"::" ");
                                    end;


                                    //----------------------------8. SCHOOL_P------------------------------------------------------------------
                                    if FnCheckLoanErrors('SCH LOAN', ReceiptLine.SCHOOL_P, ReceiptLine."Member No") then begin
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                                        GenJournalLine."account type"::Employee, ReceiptLine."Member No", Rec."Posting date", (ReceiptLine.SCHOOL_P + ReceiptLine.SCHOOL_I) * -1, 'BOSA', Rec."Document No",
                                        Format(GenJournalLine."transaction type"::"Deposit Contribution"), '', GenJournalLine."application source"::" ");
                                    end else begin
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                        GenJournalLine."account type"::Employee, ReceiptLine."Member No", Rec."Posting date", ReceiptLine.SCHOOL_P * -1, 'BOSA', Rec."Document No",
                                        Format(GenJournalLine."transaction type"::"Loan Repayment"), FnGetLoanNumber(ReceiptLine."Member No", 'SCH LOAN'), GenJournalLine."application source"::" ");
                                        //----------------------------9. SCHOOL_I------------------------------------------------------------------
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                        GenJournalLine."account type"::Employee, ReceiptLine."Member No", Rec."Posting date", ReceiptLine.SCHOOL_I * -1, 'BOSA', Rec."Document No",
                                        Format(GenJournalLine."transaction type"::"Interest Paid"), FnGetLoanNumber(ReceiptLine."Member No", 'SCH LOAN'), GenJournalLine."application source"::" ");
                                    end;


                                    //----------------------------10. SPECIAL_P------------------------------------------------------------------
                                    if FnCheckLoanErrors('SP', ReceiptLine.SPECIAL_P, ReceiptLine."Member No") then begin
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                                        GenJournalLine."account type"::Employee, ReceiptLine."Member No", Rec."Posting date", (ReceiptLine.SPECIAL_P + ReceiptLine.SPECIAL_I) * -1, 'BOSA', Rec."Document No",
                                        Format(GenJournalLine."transaction type"::"Deposit Contribution"), '', GenJournalLine."application source"::" ");
                                    end else begin
                                        FnCheckLoanErrors('SP', ReceiptLine.SPECIAL_P, ReceiptLine."Member No");
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                        GenJournalLine."account type"::Employee, ReceiptLine."Member No", Rec."Posting date", ReceiptLine.SPECIAL_P * -1, 'BOSA', Rec."Document No",
                                        Format(GenJournalLine."transaction type"::"Loan Repayment"), FnGetLoanNumber(ReceiptLine."Member No", 'SP'), GenJournalLine."application source"::" ");
                                        //----------------------------11. SPECIAL_I------------------------------------------------------------------
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                        GenJournalLine."account type"::Employee, ReceiptLine."Member No", Rec."Posting date", ReceiptLine.SPECIAL_I * -1, 'BOSA', Rec."Document No",
                                        Format(GenJournalLine."transaction type"::"Interest Paid"), FnGetLoanNumber(ReceiptLine."Member No", 'SP'), GenJournalLine."application source"::" ");
                                    end;


                                    //----------------------------12.INSURANCE-------------------------------------------------------------------

                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Insurance Contribution",
                                    GenJournalLine."account type"::Employee, ReceiptLine."Member No", Rec."Posting date", ReceiptLine.INSURANCE * -1, 'BOSA', Rec."Document No",
                                    Format(GenJournalLine."transaction type"::"Insurance Contribution"), '', GenJournalLine."application source"::" ");

                                    //----------------------------13.GOLDSAVE-------------------------------------------------------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                    GenJournalLine."account type"::Vendor, FnGetFosaAccountNo(ReceiptLine."Member No", 'GOLDSAVE'), Rec."Posting date", ReceiptLine.GOLDSAVE * -1, 'BOSA', Rec."Document No",
                                    'Gold Save', '', GenJournalLine."application source"::" ");

                                    //----------------------------15.THIRDPARTY(GUR) Loan------------------------------------------------------------------
                                    RunBal := 0;
                                    RunBal := ReceiptLine.THIRDPARTY;
                                    RunBal := FnRunPrinciple(ReceiptLine, RunBal);
                                    LineNo := LineNo + 10000;
                                    FnRunPrincipleExcessThirdParty(ReceiptLine, RunBal);

                                    //---------------------------16.BENEVOLENT------------------------------------------------------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Benevolent Fund",
                                    GenJournalLine."account type"::Employee, ReceiptLine."Member No", Rec."Posting date", ReceiptLine.BENEVOLENT * -1, 'BOSA', Rec."Document No",
                                    Format(GenJournalLine."transaction type"::"Benevolent Fund"), '', GenJournalLine."application source"::" ");


                                    //----------------------------17.ADVANCE_P------------------------------------------------------------------
                                    if FnCheckLoanErrors('SAL ADV', ReceiptLine.ADVANCE_P, ReceiptLine."Member No") then begin
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                                        GenJournalLine."account type"::Employee, ReceiptLine."Member No", Rec."Posting date", (ReceiptLine.ADVANCE_P + ReceiptLine.ADVANCE_I) * -1, 'BOSA', Rec."Document No",
                                        Format(GenJournalLine."transaction type"::"Deposit Contribution"), '', GenJournalLine."application source"::" ");
                                    end else begin
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                        GenJournalLine."account type"::Employee, ReceiptLine."Member No", Rec."Posting date", ReceiptLine.ADVANCE_P * -1, 'BOSA', Rec."Document No",
                                        Format(GenJournalLine."transaction type"::"Loan Repayment"), FnGetLoanNumber(ReceiptLine."Member No", 'SAL ADV'), GenJournalLine."application source"::" ");
                                        //----------------------------18.ADVANCE_I------------------------------------------------------------------
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                        GenJournalLine."account type"::Employee, ReceiptLine."Member No", Rec."Posting date", ReceiptLine.ADVANCE_I * -1, 'BOSA', Rec."Document No",
                                        Format(GenJournalLine."transaction type"::"Interest Paid"), FnGetLoanNumber(ReceiptLine."Member No", 'SAL ADV'), GenJournalLine."application source"::" ");
                                    end;
                                    //17.PHONE_P
                                    //18.PHONE_I

                                    //----------------------------19.ADVANCENSE_P------------------------------------------------------------------
                                    if FnCheckLoanErrors('NSE', ReceiptLine.ADVANCENSE_P, ReceiptLine."Member No") then begin
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                                        GenJournalLine."account type"::Employee, ReceiptLine."Member No", Rec."Posting date", (ReceiptLine.ADVANCENSE_P + ReceiptLine.ADVANCENSE_I) * -1, 'BOSA', Rec."Document No",
                                        Format(GenJournalLine."transaction type"::"Deposit Contribution"), '', GenJournalLine."application source"::" ");
                                    end else begin
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                        GenJournalLine."account type"::Employee, ReceiptLine."Member No", Rec."Posting date", ReceiptLine.ADVANCENSE_P * -1, 'BOSA', Rec."Document No",
                                        Format(GenJournalLine."transaction type"::"Loan Repayment"), FnGetLoanNumber(ReceiptLine."Member No", 'NSE'), GenJournalLine."application source"::" ");

                                        //----------------------------20.ADVANCENSE_I------------------------------------------------------------------
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                        GenJournalLine."account type"::Employee, ReceiptLine."Member No", Rec."Posting date", ReceiptLine.ADVANCENSE_I * -1, 'BOSA', Rec."Document No",
                                        Format(GenJournalLine."transaction type"::"Interest Paid"), FnGetLoanNumber(ReceiptLine."Member No", 'NSE'), GenJournalLine."application source"::" ");
                                    end;
                                    //-----------------------------21.SHARES--------------------------------------------------------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Share Capital",
                                    GenJournalLine."account type"::Employee, ReceiptLine."Member No", Rec."Posting date", ReceiptLine.SHARES * -1, 'BOSA', Rec."Document No",
                                    Format(GenJournalLine."transaction type"::"Share Capital"), '', GenJournalLine."application source"::" ");
                                end;
                            until ReceiptLine.Next = 0;
                        end;
                        //Balancing Journal Entry
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        Rec."Account Type", Rec."Account No", Rec."Posting date", Rec.Amount, 'BOSA', Rec."Document No",
                        Rec.Remarks, '', GenJournalLine."application source"::" ");

                        Window.Close;
                        Message('Checkoff successfully Generated Journals ready for posting');
                    end;
                end;
            }
            action("Process Checkoff Unallocated")
            {
                ApplicationArea = Basic;
                Visible = false;

                trigger OnAction()
                begin
                    MembLedg.Reset;
                    MembLedg.SetRange(MembLedg."Document No.", Rec.Remarks);
                    if MembLedg.Find('-') = false then begin
                        Error('You Can Only do this process on Already Posted Checkoffs')
                    end;
                    ReceiptLine.Reset;
                    //ReceiptLine.SETRANGE(ReceiptLine."Receipt Header No",No);
                    //IF ReceiptLine.FIND('-') THEN
                    //REPORT.RUN(50543,TRUE,FALSE,ReceiptLine);
                end;
            }
            action("Process Annual Charge")
            {
                ApplicationArea = Basic;
                Image = AuthorizeCreditCard;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    Rec.TestField("Document No");
                    Rec.TestField(Amount);
                    ReceiptLine.Reset;
                    //ReceiptLine.SETRANGE(ReceiptLine."Receipt Header No",No);
                    //IF ReceiptLine.FIND('-') THEN
                    //REPORT.RUN(50100,TRUE,FALSE,ReceiptLine);
                end;
            }
            action("Mark as Posted")
            {
                ApplicationArea = Basic;
                Enabled = not ActionEnabled;
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to mark this Checkoff as Posted ?', false) = true then begin
                        MembLedg.Reset;
                        MembLedg.SetRange(MembLedg."Document No.", Rec.Remarks);
                        if MembLedg.Find('-') = false then
                            Error('Sorry,You can only do this process on already posted Checkoffs');
                        Rec.Posted := true;
                        Rec."Posted By" := UserId;
                        Rec."Posting date" := Today;
                        Rec.Modify;
                    end;
                end;
            }
            action(Journals)
            {
                ApplicationArea = Basic;
                Caption = 'General Journal';
                Image = Journals;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedOnly = true;
                RunObject = Page "General Journal";
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ActionEnabled := true;
        MembLedg.Reset;
        MembLedg.SetRange(MembLedg."Document No.", Rec.Remarks);
        MembLedg.SetRange(MembLedg."External Document No.", "Cheque No.");
        if MembLedg.Find('-') then begin
            ActionEnabled := false;
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Posting date" := Today;
        Rec."Date Entered" := Today;

    end;

    var
        Gnljnline: Record "Gen. Journal Line";
        PDate: Date;
        DocNo: Code[20];
        RunBal: Decimal;
        ReceiptsProcessingLines: Record "Checkoff Lines-Distributed";
        LineNo: Integer;
        LBatches: Record "Loan Disburesment-Batching";
        Jtemplate: Code[30];
        JBatch: Code[30];
        "Cheque No.": Code[20];
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        ReptProcHeader: Record "Checkoff Header-Distributed";
        Cust: Record customer;
        MembPostGroup: Record "Customer Posting Group";
        Loantable: Record "Loans Register";
        LRepayment: Decimal;
        RcptBufLines: Record "Checkoff Lines-Distributed";
        LoanType: Record "Loan Products Setup";
        LoanApp: Record "Loans Register";
        Interest: Decimal;
        LineN: Integer;
        TotalRepay: Decimal;
        MultipleLoan: Integer;
        LType: Text;
        MonthlyAmount: Decimal;
        ShRec: Decimal;
        SHARESCAP: Decimal;
        DIFF: Decimal;
        DIFFPAID: Decimal;
        genstup: Record "Sacco General Set-Up";
        Memb: Record customer;
        INSURANCE: Decimal;
        GenBatches: Record "Gen. Journal Batch";
        Datefilter: Text[50];
        ReceiptLine: Record "Checkoff Lines-Distributed";
        MembLedg: Record "Cust. Ledger Entry";
        SFactory: Codeunit "Micropoint Factory";
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        DOCUMENT_NO: Code[40];
        GenJournalLine: Record "Gen. Journal Line";
        ActionEnabled: Boolean;
        // XMLCheckOff: XmlPort UnknownXmlPort50003;
        Window: Dialog;
        TotalCount: Integer;
        Counter: Integer;
        Percentage: Integer;

    local procedure FnGetLoanNumber(MemberNo: Code[40]; "Loan Product Code": Code[100]): Code[100]
    var
        ObjLoans: Record "Loans Register";
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange("Client Code", MemberNo);
        ObjLoans.SetRange("Loan Product Type", "Loan Product Code");
        if ObjLoans.FindFirst then
            exit(ObjLoans."Loan  No.");
    end;

    local procedure FnGetFosaAccountNo(BosaAccountNo: Code[40]; "Product Code": Code[100]): Code[100]
    var
        ObjVendor: Record Vendor;
    begin
        ObjVendor.Reset;
        ObjVendor.SetRange("BOSA Account No", BosaAccountNo);
        ObjVendor.SetRange("Account Type", "Product Code");
        if ObjVendor.Find('-') then
            exit(ObjVendor."No.");
    end;

    local procedure FnCheckLoanErrors(LoanProduct: Code[100]; Amount: Decimal; MemberNo: Code[40]) IsInvalidLoan: Boolean
    var
        ObjLoans: Record "Loans Register";
    begin
        if Amount > 0 then begin
            IsInvalidLoan := true;
            ObjLoans.Reset;
            ObjLoans.SetRange("Client Code", MemberNo);
            ObjLoans.SetRange("Loan Product Type", LoanProduct);
            ObjLoans.SetFilter("Date filter", Datefilter);
            if ObjLoans.FindFirst then begin
                IsInvalidLoan := false;
            end
        end;
        exit(IsInvalidLoan);
    end;

    local procedure FnRunPrinciple(ObjRcptBuffer: Record "Checkoff Lines-Distributed"; RunningBalance: Decimal): Decimal
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
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter(LoanApp."Loan Product Type", 'GUR');
            if LoanApp.Find('-') then begin
                repeat
                    if RunningBalance > 0 then begin
                        LoanApp.CalcFields(LoanApp."Outstanding Balance");
                        if LoanApp."Outstanding Balance" > 0 then begin
                            varLRepayment := 0;
                            PRpayment := 0;
                            varLRepayment := LoanApp."Loan Principle Repayment";
                            if varLRepayment > 0 then begin
                                if varLRepayment > LoanApp."Outstanding Balance" then
                                    varLRepayment := LoanApp."Outstanding Balance";

                                if RunningBalance > 0 then begin
                                    if RunningBalance > varLRepayment then begin
                                        AmountToDeduct := varLRepayment;
                                    end
                                    else
                                        AmountToDeduct := RunningBalance;
                                end;
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                GenJournalLine."account type"::Employee, LoanApp."Client Code", Rec."Posting date", AmountToDeduct * -1, Format(LoanApp.Source), Rec."Document No",
                                Format(GenJournalLine."transaction type"::"Loan Repayment"), LoanApp."Loan  No.", GenJournalLine."application source"::" ");
                                RunningBalance := RunningBalance - AmountToDeduct;
                            end;
                        end;
                    end;

                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunPrincipleExcessThirdParty(ObjRcptBuffer: Record "Checkoff Lines-Distributed"; RunningBalance: Decimal)
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
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter(LoanApp."Loan Product Type", 'GUR');
            if LoanApp.FindFirst then begin
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                GenJournalLine."account type"::Employee, LoanApp."Client Code", Rec."Posting date", RunningBalance * -1, Format(LoanApp.Source), Rec."Document No",
                Format(GenJournalLine."transaction type"::"Loan Repayment"), LoanApp."Loan  No.", GenJournalLine."application source"::" ");
            end;
        end;
    end;

    local procedure FnInitiateProgressBar()
    begin
    end;

    local procedure FnUpdateProgressBar()
    begin
        Percentage := (ROUND(Counter / TotalCount * 10000, 1));
        Counter := Counter + 1;
        Window.Update(1, Percentage);
    end;
}

