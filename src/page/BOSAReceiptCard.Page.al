#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50499 "BOSA Receipt Card"
{
    DeleteAllowed = false;
    Editable = true;
    PageType = Card;
    SourceTable = "Receipts & Payments";
    SourceTableView = where(Posted = filter(false));

    layout
    {
        area(content)
        {
            group(Transaction)
            {
                Caption = 'Transaction';
                field("Transaction No."; Rec."Transaction No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Mobile Phone No."; Rec."Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Contact No.';
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Receipt Mode"; Rec."Receipt Mode")
                {
                    ApplicationArea = Basic;
                }
                // field("Excess Transaction Type"; Rec."Excess Transaction Type")
                // {
                //     ApplicationArea = Basic;
                // }
                field("Excess Transaction Type"; Rec."Excess Transaction Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Allocated Amount"; Rec."Allocated Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Un allocated Amount"; Rec."Un allocated Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employer No."; Rec."Employer No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Teller Till / Bank  No.';
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque / Slip  No.';
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque / Slip  Date';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Print Receipt"; Rec."Print Receipt")
                {
                    ApplicationArea = Basic;
                }

            }
            part("Receipt Allocation Line"; "Receipt Allocation-BOSA")
            {
                ApplicationArea = Basic;
                SubPageLink = "Document No" = field("Transaction No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Suggest)
            {
                Caption = 'Suggest';
                action("Cash/Cheque Clearance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cash/Cheque Clearance';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Cheque := false;
                        //SuggestBOSAEntries();
                    end;
                }
                separator(Action1102760032)
                {
                }
                action("Suggest Payments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Suggest Monthy Repayments';
                    Image = Suggest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ObjTransactions: Record "Receipt Allocation";
                        RunBal: Decimal;
                    //Datefilter: Text;
                    begin

                        Rec.TestField(Posted, false);
                        Rec.TestField("Account No.");
                        Rec.TestField(Amount);
                        // ,Registration Fee,Share Capital,Interest Paid,Loan Repayment,Deposit Contribution,Insurance Contribution,Benevolent Fund,Loan,Unallocated Funds,Dividend,FOSA Account
                        //mjk
                        ObjTransactions.Reset;
                        ObjTransactions.SetRange(ObjTransactions."Document No", Rec."Transaction No.");
                        if ObjTransactions.Find('-') then
                            ObjTransactions.DeleteAll;
                        Datefilter := '..' + Format(Rec."Transaction Date");
                        RunBal := 0;
                        RunBal := Rec.Amount;
                        RunBal := FnRunEntranceFee(Rec, RunBal);
                        RunBal := FnRunPassBookFee(Rec, RunBal);
                        RunBal := FnRunShareCapital(Rec, RunBal);
                        RunBal := FnRunInterest(Rec, RunBal);
                        RunBal := FnRunPrinciple(Rec, RunBal);
                        RunBal := FnRunDepositContribution(Rec, RunBal);
                        RunBal := FnRunInsuranceContribution(Rec, RunBal);
                        RunBal := FnRunBenevolentFund(Rec, RunBal);
                        if RunBal > 0 then begin
                            if Confirm('Excess Money will allocated to ' + Format(Rec."Excess Transaction Type") + '.Do you want to Continue?', true) = false then
                                exit;
                            case Rec."Excess Transaction Type" of
                                Rec."excess transaction type"::Deposits:
                                    FnRunDepositContributionFromExcess(Rec, RunBal);
                                Rec."excess transaction type"::"Fosa Saving":
                                    FnRunSavingsProductExcess(Rec, RunBal, 'SAVINGS');
                                Rec."excess transaction type"::"Gold Save":
                                    FnRunSavingsProductExcess(Rec, RunBal, 'GOLDSAVE');
                                Rec."excess transaction type"::"Junior A/c":
                                    FnRunSavingsProductExcess(Rec, RunBal, 'NFK-JUNIOR');
                                Rec."excess transaction type"::Loan:
                                    FnRunExcessToLoan(Rec, RunBal);
                            end;
                            // RunBal := FnRunUnallocatedAmount(Rec, RunBal);
                        end;

                        Rec.CalcFields("Allocated Amount");
                        Rec."Un allocated Amount" := (Rec.Amount - Rec."Allocated Amount");
                        Rec.Modify;
                    end;
                }
            }
        }
        area(processing)
        {
            action(Post)
            {
                ApplicationArea = Basic;
                Caption = 'Post (F11)';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if (Rec."Receipt Mode" = Rec."receipt mode"::Cash) and (Rec."Transaction Date" <> Today) then
                        Error('You cannot post cash transactions with a date not today');

                    if Rec.Posted then
                        Error('This receipt is already posted');

                    //Rec.TestField("Account No.");
                    Rec.TestField(Amount);
                    //TESTFIELD("Employer No.");
                    //TESTFIELD("Cheque No.");
                    //TESTFIELD("Cheque Date");
                    if FundsUSer.Get(UserId) then begin
                        Jtemplate := FundsUSer."Member receipt Template Name";
                        Jbatch := FundsUSer."Member receipt Batch Name";
                    end;

                    if (Rec."Account Type" = Rec."account type"::"G/L Account") or
                       (Rec."Account Type" = Rec."account type"::Debtor) then
                        TransType := 'Withdrawal'
                    else
                        TransType := 'Deposit';

                    BOSABank := Rec."Employer No.";
                    if (Rec."Account Type" = Rec."account type"::Member) or (Rec."Account Type" = Rec."account type"::"FOSA Loan") or (Rec."Account Type" = Rec."account type"::Micro) then begin

                        if Rec.Amount <> Rec."Allocated Amount" then
                            Error('Receipt amount must be equal to the allocated amount.');
                    end;

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                    GenJournalLine.SetRange("Journal Batch Name", Jbatch);
                    GenJournalLine.DeleteAll;


                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := Jtemplate;
                    GenJournalLine."Journal Batch Name" := Jbatch;
                    GenJournalLine."Document No." := Rec."Transaction No.";
                    GenJournalLine."External Document No." := Rec."Cheque No.";
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                    GenJournalLine."Account No." := Rec."Employer No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    //GenJournalLine."Posting Date":="Cheque Date";
                    GenJournalLine."Posting Date" := Rec."Cheque Date";
                    GenJournalLine.Description := 'BT-' + Rec."Account No." + '-' + Rec.Remarks;
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    ReceiptAllocations."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                    ReceiptAllocations."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                    if TransType = 'Withdrawal' then
                        GenJournalLine.Amount := -Rec.Amount
                    else
                        GenJournalLine.Amount := Rec.Amount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    if (Rec."Account Type" <> Rec."account type"::Member) and (Rec."Account Type" <> Rec."account type"::"FOSA Loan") and (Rec."Account Type" <> rec."account type"::Vendor) and
                      (Rec."Account Type" <> Rec."account type"::Micro) then begin
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := Jtemplate;
                        GenJournalLine."Journal Batch Name" := Jbatch;
                        GenJournalLine."Document No." := Rec."Transaction No.";
                        GenJournalLine."External Document No." := Rec."Cheque No.";
                        GenJournalLine."Line No." := LineNo;
                        if Rec."Account Type" = Rec."account type"::"G/L Account" then
                            GenJournalLine."Account Type" := Rec."Account Type"
                        else if Rec."Account Type" = Rec."account type"::Debtor then
                            GenJournalLine."Account Type" := Rec."Account Type"
                        else if Rec."Account Type" = Rec."account type"::Vendor then
                            GenJournalLine."Account Type" := Rec."Account Type"
                        else if Rec."Account Type" = Rec."account type"::Member then
                            GenJournalLine."Account Type" := Rec."Account Type"
                        else if Rec."Account Type" = Rec."account type"::Micro then
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                        GenJournalLine."Account No." := Rec."Account No.";
                        //   GenJournalLine.Validate(GenJournalLine."Account No.");
                        //GenJournalLine."Posting Date":="Cheque Date";
                        GenJournalLine."Posting Date" := Rec."Cheque Date";
                        GenJournalLine.Description := 'BT-' + Rec.Name + '-' + Rec."Account No." + '-' + Rec.Remarks;
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        if TransType = 'Withdrawal' then
                            GenJournalLine.Amount := Rec.Amount
                        else
                            GenJournalLine.Amount := -Rec.Amount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        ReceiptAllocations."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                        ReceiptAllocations."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                    end;

                    GenSetup.Get();

                    ReceiptAllocations.Reset;
                    ReceiptAllocations.SetRange(ReceiptAllocations."Document No", Rec."Transaction No.");
                    if ReceiptAllocations.Find('-') then begin
                        repeat
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := Jbatch;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Document No." := Rec."Transaction No.";
                            GenJournalLine."External Document No." := Rec."Cheque No.";

                            GenJournalLine."Posting Date" := Rec."Cheque Date";
                            GenJournalLine."Account Type" := ReceiptAllocations."Account Type";
                            GenJournalLine."Account No." := ReceiptAllocations."Member No";
                            ///GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine.Amount := -ReceiptAllocations.Amount;
                            GenJournalLine."Shortcut Dimension 1 Code" := ReceiptAllocations."Global Dimension 1 Code";
                            GenJournalLine."Shortcut Dimension 2 Code" := ReceiptAllocations."Global Dimension 2 Code";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine.Description := Format(ReceiptAllocations."Transaction Type") + '-' + Rec.Remarks + '-' + Format(Rec."Receipt Mode") + '-' + Rec."Cheque No.";
                            GenJournalLine."Transaction Type" := ReceiptAllocations."Transaction Type";
                            GenJournalLine."Loan No" := ReceiptAllocations."Loan No.";
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                        until ReceiptAllocations.Next = 0;
                    end;



                    //Post New
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                    GenJournalLine.SetRange("Journal Batch Name", Jbatch);
                    if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco21", GenJournalLine);
                    end;


                    //Post New

                    Rec."Posted By" := UserId;
                    Rec."Posted Date" := Today;
                    Rec."Posted Time" := Time;
                    Rec.Posted := true;
                    Rec.Modify;
                    //sms
                    //=====================================================================================================Send SMS
                    IF ObjGenSetUp."Send Receipt SMS" = TRUE THEN BEGIN
                        SFactory.FnSendSMS('Receipt', 'Your receipt of ' + Format(Rec."Amount") + ' has been posted successfully.', Rec."Account No.", Rec."Mobile Phone No");
                    END;
                    //Print Receipt
                    Message('Receipt Posted Successfully');
                    if Rec."Print Receipt" = true then begin
                        if (Rec."Receipt Mode" <> Rec."receipt mode"::Mpesa) then begin
                            BOSARcpt.Reset;
                            BOSARcpt.SetRange(BOSARcpt."Transaction No.", Rec."Transaction No.");
                            if BOSARcpt.Find('-') then
                                Report.Run(50387, false, true, BOSARcpt);
                        end;
                    end;
                    CurrPage.Close;

                end;
            }
            action("Reprint Frecipt")
            {
                ApplicationArea = Basic;
                Caption = 'Reprint Receipt';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    Rec.TestField(Posted);

                    BOSARcpt.Reset;
                    BOSARcpt.SetRange(BOSARcpt."Transaction No.", Rec."Transaction No.");
                    if BOSARcpt.Find('-') then
                        Report.Run(50387, true, true, BOSARcpt)
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        Rec.CalcFields("Allocated Amount");
        Rec."Un allocated Amount" := Rec.Amount - Rec."Allocated Amount";

        if Rec."Excess Transaction Type" <> Rec."excess transaction type"::Loan then begin
            Rec."Excess Transaction Type" := Rec."excess transaction type"::Loan;
            Rec.Modify;
        end;

         if Rec.Source <> Rec.Source::MICRO then begin
        Rec.Source := Rec.Source::MICRO;
        Rec.Modify;
        end;
    end;

    var
        ObjGenSetUp: Record "Sacco General Set-Up";
        SFactory: Codeunit "Micropoint Factory";
        GenJournalLine: Record "Gen. Journal Line";
        InterestPaid: Decimal;
        PaymentAmount: Decimal;
        RunBal: Decimal;
        Recover: Boolean;
        Cheque: Boolean;
        ReceiptAllocations: Record "Receipt Allocation";
        Loans: Record "Loans Register";
        Commision: Decimal;
        LOustanding: Decimal;
        TotalCommision: Decimal;
        TotalOustanding: Decimal;
        Cust: Record Customer;
        BOSABank: Code[20];
        LineNo: Integer;
        BOSARcpt: Record "Receipts & Payments";
        TellerTill: Record "Bank Account";
        CurrentTellerAmount: Decimal;
        TransType: Text[30];
        RCPintdue: Decimal;
        Text001: label 'This member has reached a maximum share contribution of Kshs. 5,000/=. Do you want to post this transaction as shares contribution?';
        BosaSetUp: Record "Sacco General Set-Up";
        MpesaCharge: Decimal;
        CustPostingGrp: Record "Customer Posting Group";
        MpesaAc: Code[30];
        GenSetup: Record "Sacco General Set-Up";
        ShareCapDefecit: Decimal;
        LoanApp: Record "Loans Register";
        Datefilter: Text;
        MicropointFactory: Codeunit "Micropoint Factory";
        FundsUSer: Record "BOSA&FOSA User Template";
        Jtemplate: Code[10];
        Jbatch: Code[10];


    local procedure AllocatedAmountOnDeactivate()
    begin
        CurrPage.Update := true;
    end;

    local procedure FnRunInterest(ObjRcptBuffer: Record "Receipts & Payments"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Account No.");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            if LoanApp.Find('-') then begin
                repeat

                    LoanApp.CalcFields("Outstanding Interest");
                    if LoanApp."Outstanding Interest" > 0 then begin
                        if RunningBalance > 0 then begin
                            AmountToDeduct := 0;
                            AmountToDeduct := ROUND(LoanApp."Outstanding Interest", 0.05, '>');
                            if RunningBalance <= AmountToDeduct then
                                AmountToDeduct := RunningBalance;
                            ObjReceiptTransactions.Init;
                            ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
                            ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Customer;
                            ObjReceiptTransactions."Member No" := ObjRcptBuffer."Account No.";
                            ObjReceiptTransactions."Loan No." := LoanApp."Loan  No.";
                            ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Interest Paid";
                            ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                            ObjReceiptTransactions."Global Dimension 2 Code" := MicropointFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
                            ObjReceiptTransactions.Amount := AmountToDeduct;
                            if ObjReceiptTransactions.Amount > 0 then
                                ObjReceiptTransactions.Insert(true);
                            RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunPrinciple(ObjRcptBuffer: Record "Receipts & Payments"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
    begin
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;

            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Account No.");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);

            if LoanApp.Find('-') then begin
                repeat

                    if RunningBalance > 0 then begin
                        LoanApp.CalcFields(LoanApp."Outstanding Balance", "Oustanding Interest to Date");
                        if LoanApp."Outstanding Balance" > 0 then begin
                            varLRepayment := 0;
                            PRpayment := 0;
                            PRpayment := LoanApp."Oustanding Interest to Date";
                            varLRepayment := LoanApp.Repayment - PRpayment;
                            if LoanApp."Loan Product Type" = 'GUR' then
                                varLRepayment := LoanApp.Repayment;
                            if varLRepayment > 0 then begin
                                if varLRepayment > LoanApp."Outstanding Balance" then
                                    varLRepayment := LoanApp."Outstanding Balance";

                                if RunningBalance > 0 then begin
                                    if RunningBalance > varLRepayment then begin
                                        ObjReceiptTransactions.Amount := varLRepayment;
                                    end
                                    else
                                        ObjReceiptTransactions.Amount := RunningBalance;
                                end;
                                ObjReceiptTransactions.Init;
                                ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
                                ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Customer;
                                ObjReceiptTransactions."Loan No." := LoanApp."Loan  No.";
                                ObjReceiptTransactions."Member No" := LoanApp."Client Code";
                                ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Loan Repayment";
                                ObjReceiptTransactions."Global Dimension 1 Code" := Format(LoanApp.Source);
                                ObjReceiptTransactions."Global Dimension 2 Code" := MicropointFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
                                if ObjReceiptTransactions.Amount > 0 then
                                    ObjReceiptTransactions.Insert(true);
                                RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                            end;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunEntranceFee(ObjRcptBuffer: Record "Receipts & Payments"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
    begin
        if RunningBalance > 0 then begin
            GenSetup.Get();
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Account No.");
            //31/07/2025
            ObjMember.SetFilter(ObjMember."Registration Date", '>%1', 20250731D); //To Ensure deduction is for New Members Only
            if ObjMember.Find('-') then begin
                ObjMember.CalcFields(ObjMember."Registration Fee Paid");
                if Abs(ObjMember."Registration Fee Paid") < 500 then begin
                    if ObjMember."Registration Date" <> 0D then begin

                        AmountToDeduct := 0;
                        AmountToDeduct := GenSetup."BOSA Registration Fee Amount" - Abs(ObjMember."Registration Fee Paid");
                        if RunningBalance <= AmountToDeduct then
                            AmountToDeduct := RunningBalance;
                        ObjReceiptTransactions.Init;
                        ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
                        ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Customer;
                        ObjReceiptTransactions."Member No" := ObjRcptBuffer."Account No.";
                        ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Registration Fee";
                        // ObjReceiptTransactions.Description := 'Entrance Fee';
                        ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                        ObjReceiptTransactions."Global Dimension 2 Code" := MicropointFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
                        ObjReceiptTransactions.Amount := AmountToDeduct;
                        if ObjReceiptTransactions.Amount <> 0 then
                            ObjReceiptTransactions.Insert(true);
                        RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                    end;
                end;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunPassBookFee(ObjRcptBuffer: Record "Receipts & Payments"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
        FormFee: Decimal;
    begin
        if RunningBalance > 0 then begin
            GenSetup.Get();
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Account No.");
            ObjMember.SetFilter(ObjMember."Registration Date", '>%1', 20171017D); //To Ensure deduction is for New Members Only
            if ObjMember.Find('-') then begin
                ObjMember.CalcFields(ObjMember."PassBook Fee Paid");
                // Message('passbook fee paid %1,...set up fee is%2 ', ObjMember."PassBook Fee Paid", GenSetup."PassBook Fee");
                // Check if member has posted receipts (old member indicator) - if yes, skip PassBook Fee
                if FnCheckIfOldMember(ObjRcptBuffer."Account No.") then
                    exit(RunningBalance);

                if Abs(ObjMember."PassBook Fee Paid") < GenSetup."PassBook Fee" then begin

                    AmountToDeduct := 0;
                    AmountToDeduct := GenSetup."PassBook Fee" - Abs(ObjMember."PassBook Fee Paid");
                    if RunningBalance <= AmountToDeduct then
                        AmountToDeduct := RunningBalance;

                    ObjReceiptTransactions.Init;
                    ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
                    ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Customer;
                    ObjReceiptTransactions."Member No" := ObjRcptBuffer."Account No.";
                    ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"PassBook Fee";
                    ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                    ObjReceiptTransactions."Global Dimension 2 Code" := MicropointFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
                    ObjReceiptTransactions.Amount := AmountToDeduct;
                    if ObjReceiptTransactions.Amount <> 0 then
                        ObjReceiptTransactions.Insert(true);
                    RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);

                    // Only charge Form Application Fee for truly new members (who haven't been charged before)
                    if not FnCheckIfFormFeePaid(ObjRcptBuffer."Account No.") then begin
                        FormFee := GenSetup."Form Application Fee Amount";
                        if RunningBalance <= FormFee then
                            FormFee := RunningBalance;
                        //...
                        ObjReceiptTransactions.Init;
                        ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
                        ObjReceiptTransactions."Member No" := GenSetup."BOSA Form Application Account";

                        ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::"G/L Account";
                        ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::" ";
                        ObjReceiptTransactions.Description := 'Form Appl. Fee ' + ObjRcptBuffer."Account No.";
                        ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                        ObjReceiptTransactions."Global Dimension 2 Code" := MicropointFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
                        ObjReceiptTransactions.Amount := FormFee;
                        if ObjReceiptTransactions.Amount <> 0 then
                            ObjReceiptTransactions.Insert(true);
                        RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                    end;
                end;
            end;
        end;
        exit(RunningBalance);
    end;


    local procedure FnRunShareCapital(ObjRcptBuffer: Record "Receipts & Payments"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
        SharesCap: Decimal;
        DIFF: Decimal;
    begin
        if RunningBalance > 0 then begin
            GenSetup.Get();
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Account No.");
            ObjMember.SetRange(ObjMember."Customer Type", ObjMember."customer type"::Member);
            if ObjMember.Find('-') then begin
                //REPEAT Deducted once unless otherwise advised
                ObjMember.CalcFields(ObjMember."Shares Retained");
                if ObjMember."Shares Retained" < GenSetup."Retained Shares" then begin
                    SharesCap := GenSetup."Retained Shares";
                    DIFF := SharesCap - ObjMember."Shares Retained";

                    if DIFF > 1 then begin
                        if RunningBalance > 0 then begin
                            AmountToDeduct := 0;
                            AmountToDeduct := DIFF;
                            if DIFF > 10000 then
                                AmountToDeduct := 10000;
                            if RunningBalance <= AmountToDeduct then
                                AmountToDeduct := RunningBalance;

                            ObjReceiptTransactions.Init;
                            ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
                            ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Customer;
                            ObjReceiptTransactions."Member No" := ObjRcptBuffer."Account No.";
                            ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Share Capital";
                            ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                            ObjReceiptTransactions."Global Dimension 2 Code" := MicropointFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
                            ObjReceiptTransactions.Amount := AmountToDeduct;
                            if ObjReceiptTransactions.Amount <> 0 then
                                ObjReceiptTransactions.Insert(true);
                            RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                        end;
                    end;
                end;
                //UNTIL RcptBufLines.NEXT=0;
            end;

            exit(RunningBalance);
        end;
    end;

    local procedure FnRunDepositContribution(ObjRcptBuffer: Record "Receipts & Payments"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
        SharesCap: Decimal;
        DIFF: Decimal;
    begin
        if RunningBalance > 0 then begin
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Account No.");
            ObjMember.SetRange(ObjMember."Customer Type", ObjMember."customer type"::Member);
            if ObjMember.Find('-') then begin
                AmountToDeduct := 0;
                AmountToDeduct := ROUND(ObjMember."Monthly Contribution", 0.05, '>');
                if RunningBalance <= AmountToDeduct then
                    AmountToDeduct := RunningBalance;

                ObjReceiptTransactions.Init;
                ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
                ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Customer;
                ObjReceiptTransactions."Member No" := ObjRcptBuffer."Account No.";

                ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Deposit Contribution";
                ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                ObjReceiptTransactions."Global Dimension 2 Code" := MicropointFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
                ObjReceiptTransactions.Amount := AmountToDeduct;
                if ObjReceiptTransactions.Amount <> 0 then
                    ObjReceiptTransactions.Insert(true);
                RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
            end;

            exit(RunningBalance);
        end;
    end;

    local procedure FnRunInsuranceContribution(ObjRcptBuffer: Record "Receipts & Payments"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
    begin
        GenSetup.Get();
        if RunningBalance > 0 then begin
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Account No.");
            if ObjMember.Find('-') then begin
                if ObjMember."Registration Date" <> 0D then begin
                    AmountToDeduct := 0;
                    AmountToDeduct := GenSetup."Benevolent Fund Contribution";
                    if RunningBalance <= AmountToDeduct then
                        AmountToDeduct := RunningBalance;
                    ObjReceiptTransactions.Init;
                    ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
                    ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Customer;
                    ObjReceiptTransactions."Member No" := ObjRcptBuffer."Account No.";
                    ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Insurance Contribution";
                    ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                    ObjReceiptTransactions."Global Dimension 2 Code" := MicropointFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
                    ObjReceiptTransactions.Amount := AmountToDeduct;
                    if ObjReceiptTransactions.Amount <> 0 then
                        ObjReceiptTransactions.Insert(true);
                    RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                end;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunBenevolentFund(ObjRcptBuffer: Record "Receipts & Payments"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
    begin
        if RunningBalance > 0 then begin
            GenSetup.Get();
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Account No.");
            if ObjMember.Find('-') then begin
                if ObjMember."Registration Date" <> 0D then begin

                    AmountToDeduct := 0;
                    AmountToDeduct := GenSetup."Risk Fund Amount";
                    if RunningBalance <= AmountToDeduct then
                        AmountToDeduct := RunningBalance;
                    ObjReceiptTransactions.Init;
                    ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
                    ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Customer;
                    ObjReceiptTransactions."Member No" := ObjRcptBuffer."Account No.";
                    ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Benevolent Fund";
                    ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                    ObjReceiptTransactions."Global Dimension 2 Code" := MicropointFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
                    ObjReceiptTransactions.Amount := AmountToDeduct;
                    if ObjReceiptTransactions.Amount <> 0 then
                        ObjReceiptTransactions.Insert(true);
                    RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                end;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunUnallocatedAmount(ObjRcptBuffer: Record "Receipts & Payments"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
    begin
        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Account No.");
        if ObjMember.Find('-') then begin
            begin
                AmountToDeduct := 0;
                AmountToDeduct := RunningBalance;
                ObjReceiptTransactions.Init;
                ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
                ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Customer;
                ObjReceiptTransactions."Member No" := ObjRcptBuffer."Account No.";
                ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Unallocated Funds";
                ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                ObjReceiptTransactions."Global Dimension 2 Code" := MicropointFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
                ObjReceiptTransactions.Amount := AmountToDeduct;
                if ObjReceiptTransactions.Amount <> 0 then
                    ObjReceiptTransactions.Insert(true);
            end;
        end;
    end;

    local procedure FnRunDepositContributionFromExcess(ObjRcptBuffer: Record "Receipts & Payments"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
        SharesCap: Decimal;
        DIFF: Decimal;
        TransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account";
    begin

        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Account No.");
        ObjMember.SetRange(ObjMember."Customer Type", ObjMember."customer type"::Member);
        if ObjMember.Find('-') then begin
            AmountToDeduct := 0;
            AmountToDeduct := RunningBalance + FnReturnAmountToClear(Transtype::"Deposit Contribution");
            ObjReceiptTransactions.Init;
            ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
            ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Customer;
            ObjReceiptTransactions."Member No" := ObjRcptBuffer."Account No.";
            ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Deposit Contribution";
            ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
            ObjReceiptTransactions."Global Dimension 2 Code" := MicropointFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
            ObjReceiptTransactions.Amount := AmountToDeduct;
            if ObjReceiptTransactions.Amount <> 0 then
                ObjReceiptTransactions.Insert(true);
        end;
    end;

    local procedure FnReturnAmountToClear(TransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account") AmountReturned: Decimal
    var
        ObjReceiptAllocation: Record "Receipt Allocation";
    begin
        ObjReceiptAllocation.Reset;
        ObjReceiptAllocation.SetRange("Document No", Rec."Transaction No.");
        ObjReceiptAllocation.SetRange("Transaction Type", TransType);
        if ObjReceiptAllocation.Find('-') then begin
            AmountReturned := ObjReceiptAllocation.Amount;
            ObjReceiptAllocation.Delete;
        end;
        exit;
    end;

    local procedure FnRunSavingsProductExcess(ObjRcptBuffer: Record "Receipts & Payments"; RunningBalance: Decimal; SavingsProduct: Code[100]): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
        SharesCap: Decimal;
        DIFF: Decimal;
        TransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account";
    begin

        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Account No.");
        ObjMember.SetRange(ObjMember."Customer Type", ObjMember."customer type"::Member);
        if ObjMember.Find('-') then begin
            AmountToDeduct := 0;
            AmountToDeduct := RunningBalance + FnReturnAmountToClear(Transtype::"FOSA Account");
            ObjReceiptTransactions.Init;
            ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
            ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Vendor;
            ObjReceiptTransactions."Member No" := ObjRcptBuffer."Account No.";
            //ObjReceiptTransactions."Fosa Account":=SavingsProduct;
            //ObjReceiptTransactions.VALIDATE(ObjReceiptTransactions."Fosa Account");
            ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"FOSA Account";
            ObjReceiptTransactions."Global Dimension 1 Code" := 'FOSA';
            ObjReceiptTransactions."Global Dimension 2 Code" := MicropointFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
            ObjReceiptTransactions.Amount := AmountToDeduct;
            if ObjReceiptTransactions.Amount <> 0 then
                ObjReceiptTransactions.Insert(true);
        end;
    end;

    local procedure FnCheckIfFormFeePaid(MemberNo: Code[20]): Boolean
    var
        GLEntry: Record "G/L Entry";
        SearchText: Text;
        ReceiptsPayments: Record "Receipts & Payments";
    begin
        // Check if member has already paid Form Application Fee by checking G/L Entry transactions
        GenSetup.Get();
        SearchText := 'Form Appl. Fee ' + MemberNo;
        GLEntry.Reset;
        GLEntry.SetRange("G/L Account No.", GenSetup."BOSA Form Application Account");
        GLEntry.SetRange("Global Dimension 2 Code", MicropointFactory.FnGetMemberBranch(MemberNo));
        if GLEntry.FindSet then begin
            repeat
                // Check the description for the exact pattern: 'Form Appl. Fee MEMBERNO'
                if StrPos(GLEntry.Description, SearchText) > 0 then
                    exit(true);
            until GLEntry.Next = 0;
        end;

        // Also check if member has any posted receipts (old/existing member indicator)
        ReceiptsPayments.Reset;
        ReceiptsPayments.SetRange("Account No.", MemberNo);
        ReceiptsPayments.SetRange(Posted, true);
        if not ReceiptsPayments.IsEmpty then
            exit(true);  // Has posted receipts = existing member = already paid form fee

        exit(false);
    end;

    local procedure FnCheckIfOldMember(MemberNo: Code[20]): Boolean
    var
        ReceiptsPayments: Record "Receipts & Payments";
    begin
        // Check if member has any posted receipts (indicates existing/old member)
        ReceiptsPayments.Reset;
        ReceiptsPayments.SetRange("Account No.", MemberNo);
        ReceiptsPayments.SetRange(Posted, true);
        if not ReceiptsPayments.IsEmpty then
            exit(true);  // Has posted receipts = old member
        exit(false);
    end;

    local procedure FnRunExcessToLoan(ObjRcptBuffer: Record "Receipts & Payments"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        TransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account";
    begin
        if RunningBalance <= 0 then
            exit(RunningBalance);

        LoanApp.Reset;
        LoanApp.SetCurrentKey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
        LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Account No.");
        LoanApp.SetFilter(LoanApp."Date filter", Datefilter);

        if LoanApp.Find('-') then begin
            repeat
                if RunningBalance > 0 then begin
                    LoanApp.CalcFields(LoanApp."Outstanding Balance");
                    if LoanApp."Outstanding Balance" > 0 then begin
                        AmountToDeduct := RunningBalance + FnReturnAmountToClear(TransType::"Loan Repayment");
                        if AmountToDeduct > LoanApp."Outstanding Balance" then
                            AmountToDeduct := LoanApp."Outstanding Balance";
                        ObjReceiptTransactions.Init;
                        ObjReceiptTransactions."Document No" := ObjRcptBuffer."Transaction No.";
                        ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Customer;
                        ObjReceiptTransactions."Member No" := ObjRcptBuffer."Account No.";
                        ObjReceiptTransactions."Loan No." := LoanApp."Loan  No.";
                        ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Loan Repayment";
                        ObjReceiptTransactions."Global Dimension 1 Code" := Format(LoanApp.Source);
                        ObjReceiptTransactions."Global Dimension 2 Code" := MicropointFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
                        ObjReceiptTransactions.Amount := AmountToDeduct;
                        if ObjReceiptTransactions.Amount > 0 then
                            ObjReceiptTransactions.Insert(true);
                        RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                    end;
                end;
            until LoanApp.Next = 0;
        end;

        exit(RunningBalance);
    end;
}

