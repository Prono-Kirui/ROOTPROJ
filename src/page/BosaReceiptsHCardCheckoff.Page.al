#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50404 "Bosa Receipts H Card-Checkoff"
{


    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "ReceiptsProcessing_H-Checkoff";
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
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Total Count"; Rec."Total Count")
                {
                    ApplicationArea = Basic;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Scheduled Amount"; Rec."Scheduled Amount")
                {
                    ApplicationArea = Basic;
                }
            }
            part("Bosa receipt lines"; "Bosa Receipt line-Checkoff")
            {
                SubPageLink = "Receipt Header No" = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("<XMLport Import receipts>")
            {
                ApplicationArea = Basic;
                Caption = 'Import Receipts';
                //RunObject = XMLport UnknownXMLport50002;
            }
            group(ActionGroup1102755021)
            {
            }
            action("Validate Receipts")
            {
                ApplicationArea = Basic;
                Caption = 'Validate Receipts';
                //RunObject = Report UnknownReport50074;

                trigger OnAction()
                begin
                    /*
                    ReceiptsProcessingLines.MODIFYALL(ReceiptsProcessingLines."Staff Not Found",FALSE);
                    ReceiptsProcessingLines.MODIFYALL(ReceiptsProcessingLines."Multiple Receipts",FALSE);
                    
                    ReceiptsProcessingLines.RESET;
                    ReceiptsProcessingLines.SETRANGE(ReceiptsProcessingLines."Staff/Payroll No",Cust."No.");
                    IF ReceiptsProcessingLines.COUNT > 1 THEN BEGIN
                    ReceiptsProcessingLines."Multiple Receipts":=TRUE;
                    ReceiptsProcessingLines.MODIFY;
                    END;
                    
                    Cust.RESET;
                    Cust.SETCURRENTKEY(Cust."Payroll/Staff No");
                    Cust.SETRANGE(Cust."Customer Type",Cust."Customer Type"::Member);
                    Cust.SETRANGE(Cust."Payroll/Staff No",ReceiptsProcessingLines."Staff/Payroll No");
                    IF Cust.FIND('-') = FALSE THEN BEGIN
                    ReceiptsProcessingLines."Staff Not Found":=TRUE;
                    ReceiptsProcessingLines.MODIFY;
                    END ELSE BEGIN
                    ReceiptsProcessingLines.Name:=Cust.Name;
                    ReceiptsProcessingLines.MODIFY;
                    //SharesAmount:=Cust."Monthly Contribution"+Cust."Jipange Contribution"+Cust."FOSA Contribution";
                    LRepayment:=0;
                    Loantable.RESET;
                    Loantable.SETRANGE(Loantable."Client Code",Cust."No.");
                    IF Loantable.FIND('-') THEN BEGIN
                    REPEAT
                    Loantable.CALCFIELDS(Loantable."Outstanding Balance");
                    IF (Loantable."Outstanding Balance")>0 THEN BEGIN
                    
                    LRepayment:=LRepayment;
                    END;
                    UNTIL Loantable.NEXT=0;
                    END;
                    END;
                    //MESSAGE(FORMAT(LRepayment));
                    //"Expected amount":=LRepayment+SharesAmount;
                    //MODIFY;
                    
                    */

                    // Original code
                    /*
                   IF "Employer Code"='' THEN
                   ERROR('Please specify the Empoyer code on receiptlines');
                    */
                    //Check if Member Exist

                    Cust.Reset;
                    Cust.SetRange(Cust."No.", ReceiptsProcessingLines."Member No");
                    if Cust.Find('-') then begin
                        //REPEAT
                        ReceiptsProcessingLines."Member Found" := true;
                        ReceiptsProcessingLines.Modify;
                        //UNTIL Cust.NEXT=0;
                    end;

                end;
            }
            group(ActionGroup1102755019)
            {
            }
            action("Post check off")
            {
                ApplicationArea = Basic;
                Caption = 'Post check off';

                trigger OnAction()
                begin

                    genstup.Get();
                    if Rec.Posted = true then
                        Error('This Check Off has already been posted');
                    if Rec."Account No" = '' then
                        Error('You must specify the Account No.');
                    if Rec."Document No" = '' then
                        Error('You must specify the Document No.');
                    if Rec."Posting date" = 0D then
                        Error('You must specify the Posting date.');
                    Datefilter := '..' + Format(Rec."Loan CutOff Date");

                    PDate := Rec."Posting date";
                    DocNo := Rec."Document No";
                    GenBatches.Reset;
                    GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                    GenBatches.SetRange(GenBatches.Name, Rec.No);
                    if GenBatches.Find('-') = false then begin
                        GenBatches.Init;
                        GenBatches."Journal Template Name" := 'GENERAL';
                        GenBatches.Name := Rec.No;
                        GenBatches.Description := 'cHECK OFF PROCESS';
                        GenBatches.Validate(GenBatches."Journal Template Name");
                        GenBatches.Validate(GenBatches.Name);
                        GenBatches.Insert;
                    end;



                    //Delete journal
                    Gnljnline.Reset;
                    Gnljnline.SetRange("Journal Template Name", 'GENERAL');
                    Gnljnline.SetRange("Journal Batch Name", Rec.No);
                    Gnljnline.DeleteAll;
                    //End of deletion





                    RunBal := 0;
                    Rec.CalcFields("Scheduled Amount");
                    /*
                   IF "Scheduled Amount" <>   Amount THEN BEGIN
                   ERROR('Scheduled Amount Is Not Equal To Cheque Amount');
                   END;
                   */

                    genstup.Get();
                    // MWMBER NOT FOUND
                    RcptBufLines.Reset;
                    RcptBufLines.SetRange(RcptBufLines."Receipt Header No", Rec.No);
                    RcptBufLines.SetRange(RcptBufLines.Posted, false);
                    if RcptBufLines.Find('-') then begin
                        repeat


                            RunBal := RcptBufLines.Amount;

                            if RunBal > 0 then begin

                                Cust.Reset;
                                Cust.SetRange(Cust."No.", RcptBufLines."Member No");
                                //Cust.SETRANGE(Cust."Personal No",RcptBufLines."Staff/Payroll No");
                                //Cust.SETRANGE(Cust."Employer Code",RcptBufLines."Employer Code");
                                if Cust.Find('-') then begin
                                    repeat
                                        Cust.CalcFields(Cust."Registration Fee Paid");
                                        if Cust."Registration Fee Paid" = 0 then begin
                                            if Cust."Registration Date" <> 0D then begin


                                                LineN := LineN + 10000;
                                                Gnljnline.Init;
                                                Gnljnline."Journal Template Name" := 'GENERAL';
                                                Gnljnline."Journal Batch Name" := Rec.No;
                                                Gnljnline."Line No." := LineN;
                                                Gnljnline."Account Type" := Gnljnline."account type"::Employee;
                                                Gnljnline."Account No." := RcptBufLines."Member No";
                                                Gnljnline.Validate(Gnljnline."Account No.");
                                                Gnljnline."Document No." := Rec."Document No";
                                                Gnljnline."Posting Date" := Rec."Posting date";
                                                Gnljnline.Description := 'Registration Fee ' + Rec.Remarks;
                                                Gnljnline.Amount := 500 * -1;
                                                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Registration Fee";
                                                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                                                Gnljnline."Shortcut Dimension 2 Code" := 'Nairobi';
                                                Gnljnline.Validate(Gnljnline.Amount);
                                                if Gnljnline.Amount <> 0 then
                                                    Gnljnline.Insert;
                                                RunBal := RunBal + (Gnljnline.Amount);

                                            end;
                                        end;
                                    until Cust.Next = 0;
                                end;
                            end;

                            //++++++++++++++Recover Insurance+++++++++++++++++++//
                            LoanType.Reset;
                            LoanType.SetCurrentkey(LoanType."Recovery Priority");
                            LoanType.SetRange(LoanType."Check Off Recovery", true);
                            if LoanType.Find('-') then begin
                                repeat
                                    LoanApp.Reset;
                                    LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code");
                                    LoanApp.SetRange(LoanApp."Loan Product Type", LoanType.Code);
                                    LoanApp.SetRange(LoanApp."Client Code", RcptBufLines."Member No");
                                    LoanApp.SetFilter(LoanApp."Issued Date", Datefilter);
                                    if LoanApp.Find('-') then begin

                                        repeat
                                            if RunBal > 0 then begin
                                                LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Loans Insurance");
                                                if LoanApp."Outstanding Balance" > 0 then begin

                                                    if LoanApp."Issued Date" <= PDate then begin
                                                        if LoanApp."Approved Amount" > 100000 then begin
                                                            LineN := LineN + 10000;

                                                            Gnljnline.Init;
                                                            Gnljnline."Journal Template Name" := 'GENERAL';
                                                            Gnljnline."Journal Batch Name" := Rec.No;
                                                            Gnljnline."Line No." := LineN;
                                                            Gnljnline."Account Type" := Gnljnline."bal. account type"::Employee;
                                                            Gnljnline."Account No." := LoanApp."Client Code";
                                                            Gnljnline.Validate(Gnljnline."Account No.");
                                                            Gnljnline."Document No." := Rec."Document No";
                                                            Gnljnline."Posting Date" := Rec."Posting date";
                                                            Gnljnline.Description := 'Insurance ' + Rec.Remarks;
                                                            //Gnljnline.Amount:=-ROUND(LoanApp."Outstanding Balance"*0.00016667,1,'>');
                                                            Gnljnline.Amount := -ROUND(LoanApp."Loans Insurance", 1, '>');
                                                            // INSURANCE:=ROUND(LoanApp."Outstanding Balance"*0.00016667,1,'>');
                                                            //MESSAGE('INSURANCE%1',ROUND(LoanApp."Outstanding Balance"*0.00016667,1,'>'));
                                                            Gnljnline.Validate(Gnljnline.Amount);
                                                            Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Development Shares";
                                                            Gnljnline."Loan No" := LoanApp."Loan  No.";
                                                            if Gnljnline.Amount <> 0 then
                                                                Gnljnline.Insert;
                                                            RunBal := RunBal + (Gnljnline.Amount);
                                                        end;
                                                    end;
                                                end;
                                            end;
                                        until LoanApp.Next = 0;
                                    end;
                                until LoanType.Next = 0;
                            end;

                            //++++++++++++++bbf+++++++++++++++++++//
                            //Cust.RESET;
                            //Cust.SETRANGE(Cust."No.",RcptBufLines."Member No");
                            //Cust.SETRANGE(Cust."Customer Type",Cust."Customer Type"::Member);
                            Cust.Reset;
                            //Cust.SETRANGE(Cust."No.",RcptBufLines."Member No");
                            Cust.SetRange(Cust."Personal No", RcptBufLines."Staff/Payroll No");
                            Cust.SetRange(Cust."Employer Code", RcptBufLines."Employer Code");

                            if Cust.Find('-') then begin
                                //++++++++++Recover Shares Deposits++++++++++++++++++//
                                if (Cust.Status = Cust.Status::Active) or
                                   (Cust.Status = Cust.Status::Dormant) or
                                   (Cust.Status = Cust.Status::Deceased) then begin

                                    if RunBal > 0 then begin

                                        LineN := LineN + 10000;

                                        Gnljnline.Init;
                                        Gnljnline."Journal Template Name" := 'GENERAL';
                                        Gnljnline."Journal Batch Name" := Rec.No;
                                        Gnljnline."Line No." := LineN;
                                        Gnljnline."Account Type" := Gnljnline."account type"::Employee;
                                        Gnljnline."Account No." := RcptBufLines."Member No";
                                        Gnljnline.Validate(Gnljnline."Account No.");
                                        Gnljnline."Document No." := Rec."Document No";
                                        Gnljnline."Posting Date" := Rec."Posting date";
                                        Gnljnline.Description := 'Benevolent Fund ' + Rec.Remarks;
                                        Gnljnline.Amount := genstup."Risk Fund Amount" * -1;
                                        Gnljnline.Validate(Gnljnline.Amount);
                                        Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Benevolent Fund";
                                        if Gnljnline.Amount <> 0 then
                                            Gnljnline.Insert;
                                        RunBal := RunBal + (Gnljnline.Amount);
                                    end;
                                end;
                            end;

                            //++++++++++++++Recover Interest+++++++++++++++++++//
                            LoanType.Reset;
                            LoanType.SetCurrentkey(LoanType."Recovery Priority");
                            LoanType.SetRange(LoanType."Check Off Recovery", true);
                            if LoanType.Find('-') then begin
                                repeat
                                    LoanApp.Reset;
                                    LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
                                    LoanApp.SetRange(LoanApp."Loan Product Type", LoanType.Code);
                                    LoanApp.SetRange(LoanApp."Client Code", RcptBufLines."Member No");
                                    //LoanApp.SETRANGE(LoanApp."Staff No",RcptBufLines."Staff/Payroll No");
                                    //LoanApp.SETRANGE(LoanApp."Employer Code",RcptBufLines."Employer Code");
                                    LoanApp.SetFilter(LoanApp."Issued Date", Datefilter);
                                    if LoanApp.Find('-') then begin

                                        repeat
                                            LoanApp.CalcFields(LoanApp."Outstanding Interest");

                                            if LoanApp."Outstanding Interest" > 0 then begin

                                                if RunBal > 0 then begin

                                                    Interest := 0;
                                                    Interest := LoanApp."Outstanding Interest";

                                                    if Interest > 0 then begin
                                                        //IF LoanApp."Issued Date" <= PDate THEN BEGIN>NIC

                                                        if LoanApp."Issued Date" < Rec."Loan CutOff Date" then begin

                                                            LineN := LineN + 10000;
                                                            Gnljnline.Init;
                                                            Gnljnline."Journal Template Name" := 'GENERAL';
                                                            Gnljnline."Journal Batch Name" := Rec.No;
                                                            Gnljnline."Line No." := LineN;
                                                            Gnljnline."Account Type" := Gnljnline."bal. account type"::Employee;
                                                            Gnljnline."Account No." := LoanApp."Client Code";
                                                            Gnljnline.Validate(Gnljnline."Account No.");
                                                            Gnljnline."Document No." := Rec."Document No";
                                                            Gnljnline."Posting Date" := Rec."Posting date";
                                                            Gnljnline.Description := 'Interest Paid ' + Rec.Remarks;
                                                            if RunBal > Interest then
                                                                Gnljnline.Amount := -1 * Interest
                                                            else
                                                                Gnljnline.Amount := -1 * RunBal;
                                                            Gnljnline.Validate(Gnljnline.Amount);
                                                            Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Insurance Contribution";
                                                            Gnljnline."Loan No" := LoanApp."Loan  No.";
                                                            if Gnljnline.Amount <> 0 then
                                                                Gnljnline.Insert;
                                                            RunBal := RunBal + (Gnljnline.Amount);
                                                        end;

                                                    end;
                                                end;
                                            end;
                                        until LoanApp.Next = 0;
                                    end;
                                until LoanType.Next = 0;
                            end;




                            //++++++++++++++Recover Repayment++++++++++++++++++++//
                            TotalRepay := 0;
                            LoanType.Reset;
                            LoanType.SetCurrentkey(LoanType."Recovery Priority");
                            LoanType.SetRange(LoanType."Check Off Recovery", true);
                            if LoanType.Find('-') then begin
                                repeat
                                    MultipleLoan := 0;

                                    //+++++++++++++++Check if Multiple Loan++++++++++++++++++++++++++++++++++++//
                                    LoanApp.Reset;
                                    LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
                                    LoanApp.SetRange(LoanApp."Loan Product Type", LoanType.Code);
                                    LoanApp.SetRange(LoanApp."Client Code", RcptBufLines."Member No");
                                    //LoanApp.SETRANGE(LoanApp."Staff No",RcptBufLines."Staff/Payroll No");
                                    //LoanApp.SETRANGE(LoanApp."Employer Code",RcptBufLines."Employer Code");
                                    LoanApp.SetFilter(LoanApp."Issued Date", Datefilter);
                                    if LoanApp.Find('-') then begin
                                        repeat
                                            LoanApp.CalcFields(LoanApp."Outstanding Balance");
                                            if LoanApp."Outstanding Balance" > 0 then begin
                                                MultipleLoan := MultipleLoan + 1;
                                            end;
                                        until LoanApp.Next = 0;
                                    end;

                                    //+++++++++++++++++++++Check if Multiple Loan+++++++++++++++++++++++++++++++//

                                    LoanApp.Reset;
                                    LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
                                    LoanApp.SetRange(LoanApp."Loan Product Type", LoanType.Code);
                                    LoanApp.SetRange(LoanApp."Client Code", RcptBufLines."Member No");
                                    //LoanApp.SETRANGE(LoanApp."Staff No",RcptBufLines."Staff/Payroll No");
                                    //LoanApp.SETRANGE(LoanApp."Employer Code",RcptBufLines."Employer Code");
                                    LoanApp.SetFilter(LoanApp."Issued Date", Datefilter);
                                    if LoanApp.Find('-') then begin
                                        repeat

                                            if RunBal > 0 then begin

                                                LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Interest");

                                                if LoanApp."Outstanding Balance" > 0 then begin

                                                    if LoanApp."Approved Amount" > 100000 then begin
                                                        INSURANCE := 0;
                                                        INSURANCE := ROUND(LoanApp."Outstanding Balance" * 0.00016667, 1, '>');
                                                    end;



                                                    LType := LoanApp."Loan Product Type";
                                                    LRepayment := 0;
                                                    if LoanApp."Outstanding Interest" > 0 then
                                                        LRepayment := (LoanApp.Repayment - LoanApp."Outstanding Interest" - INSURANCE)
                                                    else
                                                        LRepayment := LoanApp.Repayment - INSURANCE;

                                                    if LRepayment > LoanApp."Outstanding Balance" then
                                                        LRepayment := LoanApp."Outstanding Balance";
                                                    if LRepayment = 0 then begin
                                                        RcptBufLines."No Repayment" := true;
                                                        RcptBufLines.Modify;
                                                    end;

                                                    //IF LoanApp."Issued Date"<= PDate THEN BEGIN>NIC
                                                    if LoanApp."Issued Date" < Rec."Loan CutOff Date" then begin
                                                        if LRepayment > 0 then begin
                                                            LineN := LineN + 10000;
                                                            Gnljnline.Init;
                                                            Gnljnline."Journal Template Name" := 'GENERAL';
                                                            Gnljnline."Journal Batch Name" := Rec."No";
                                                            Gnljnline."Line No." := LineN;
                                                            Gnljnline."Account Type" := Gnljnline."bal. account type"::Employee;
                                                            Gnljnline."Account No." := LoanApp."Client Code";
                                                            Gnljnline.Validate(Gnljnline."Account No.");
                                                            Gnljnline."Document No." := Rec."Document No";
                                                            Gnljnline."Posting Date" := Rec."Posting date";
                                                            Gnljnline.Description := 'Repayment ' + Rec.Remarks;

                                                            if RunBal > 0 then begin

                                                                if RunBal > LRepayment then
                                                                    Gnljnline.Amount := LRepayment * -1
                                                                else
                                                                    Gnljnline.Amount := RunBal * -1;
                                                            end;

                                                            Gnljnline.Validate(Gnljnline.Amount);
                                                            Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                                                            Gnljnline."Loan No" := LoanApp."Loan  No.";
                                                            if Gnljnline.Amount <> 0 then
                                                                Gnljnline.Insert;

                                                            RunBal := RunBal + (Gnljnline.Amount);
                                                        end;
                                                    end;
                                                end;
                                            end;

                                        until LoanApp.Next = 0;
                                    end;
                                until LoanType.Next = 0;
                            end;


                            //++++++++++Recover Shares SHARE CAPIAL++++++++++++++++++//
                            genstup.Get();

                            Cust.Reset;
                            //Cust.SETRANGE(Cust."No.",RcptBufLines."Member No");
                            Cust.SetRange(Cust."Personal No", RcptBufLines."Staff/Payroll No");
                            Cust.SetRange(Cust."Employer Code", RcptBufLines."Employer Code");
                            Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                            if Cust.Find('-') then begin
                                Cust.CalcFields(Cust."Shares Retained");
                                if Cust."Shares Retained" < genstup."Retained Shares" then begin

                                    SHARESCAP := genstup."Retained Shares";


                                    DIFF := SHARESCAP - Cust."Shares Retained";
                                    if DIFF > 250 then begin
                                        DIFF := 250;
                                    end else begin
                                        DIFF := SHARESCAP - Cust."Shares Retained";
                                    end;
                                    if (Cust.Status = Cust.Status::Active) or
                                       (Cust.Status = Cust.Status::Dormant) or
                                       (Cust.Status = Cust.Status::Deceased) then begin

                                        if RunBal > 0 then begin
                                            ShRec := Cust."Monthly Contribution";

                                            if RunBal > ShRec then
                                                ShRec := ShRec
                                            else
                                                ShRec := RunBal;

                                            LineN := LineN + 10000;

                                            Gnljnline.Init;
                                            Gnljnline."Journal Template Name" := 'GENERAL';
                                            Gnljnline."Journal Batch Name" := Rec.No;
                                            Gnljnline."Line No." := LineN;
                                            Gnljnline."Account Type" := Gnljnline."account type"::Employee;
                                            Gnljnline."Account No." := RcptBufLines."Member No";
                                            Gnljnline.Validate(Gnljnline."Account No.");
                                            Gnljnline."Document No." := Rec."Document No";
                                            Gnljnline."Posting Date" := Rec."Posting date";
                                            Gnljnline.Description := 'Shares Contr ' + Rec.Remarks;
                                            if RunBal > DIFF then begin
                                                Gnljnline.Amount := DIFF * -1;
                                            end else begin
                                                Gnljnline.Amount := RunBal * -1;
                                            end;
                                            Gnljnline.Validate(Gnljnline.Amount);
                                            Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Recovery Account";
                                            if Gnljnline.Amount <> 0 then
                                                Gnljnline.Insert;
                                            RunBal := RunBal + (Gnljnline.Amount);
                                        end;
                                    end;
                                end;
                            end;




                            Cust.Reset;
                            //Cust.SETRANGE(Cust."No.",RcptBufLines."Member No");
                            Cust.SetRange(Cust."Personal No", RcptBufLines."Staff/Payroll No");
                            Cust.SetRange(Cust."Employer Code", RcptBufLines."Employer Code");
                            Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                            if Cust.Find('-') then begin


                                //++++++++++Recover Shares Deposits++++++++++++++++++//
                                if (Cust.Status = Cust.Status::Active) or
                                   (Cust.Status = Cust.Status::Dormant) or
                                   (Cust.Status = Cust.Status::Deceased) then begin

                                    if RunBal > 0 then begin
                                        ShRec := Cust."Monthly Contribution";

                                        if RunBal > ShRec then
                                            ShRec := ShRec
                                        else
                                            ShRec := RunBal;

                                        LineN := LineN + 10000;

                                        Gnljnline.Init;
                                        Gnljnline."Journal Template Name" := 'GENERAL';
                                        Gnljnline."Journal Batch Name" := Rec.No;
                                        Gnljnline."Line No." := LineN;
                                        Gnljnline."Account Type" := Gnljnline."account type"::Employee;
                                        Gnljnline."Account No." := RcptBufLines."Member No";
                                        Gnljnline.Validate(Gnljnline."Account No.");
                                        Gnljnline."Document No." := Rec."Document No";
                                        Gnljnline."Posting Date" := Rec."Posting date";
                                        Gnljnline.Description := 'Shares Contr. ' + Rec.Remarks;
                                        if RunBal > ShRec then begin
                                            Gnljnline.Amount := ShRec * -1;
                                        end else begin
                                            Gnljnline.Amount := RunBal * -1;
                                        end;
                                        Gnljnline.Validate(Gnljnline.Amount);
                                        Gnljnline."Transaction Type" := Gnljnline."transaction type"::Loan;
                                        if Gnljnline.Amount <> 0 then
                                            Gnljnline.Insert;
                                        RunBal := RunBal + (Gnljnline.Amount);
                                    end;
                                end;
                            end;


                            //++++++++++++Excess to Deposit Contribution++++++++++++++++//
                            if RunBal > 0 then begin
                                LineN := LineN + 10000;

                                Gnljnline.Init;
                                Gnljnline."Journal Template Name" := 'GENERAL';
                                Gnljnline."Journal Batch Name" := Rec.No;
                                Gnljnline."Line No." := LineN;
                                Gnljnline."Account Type" := Gnljnline."account type"::Employee;
                                Gnljnline."Account No." := RcptBufLines."Member No";
                                Gnljnline.Validate(Gnljnline."Account No.");
                                Gnljnline."Document No." := Rec."Document No";
                                Gnljnline."Posting Date" := Rec."Posting date";
                                Gnljnline.Description := Rec.Remarks;
                                Gnljnline.Amount := RunBal * -1;
                                Gnljnline.Validate(Gnljnline.Amount);
                                Gnljnline."Transaction Type" := Gnljnline."transaction type"::Loan;
                                if Gnljnline.Amount <> 0 then
                                    Gnljnline.Insert;
                                RunBal := RunBal - (Gnljnline.Amount * -1);
                            end;
                        until RcptBufLines.Next = 0;
                    end;



                    Rec.CalcFields("Scheduled Amount");
                    // END OF MEMBER NOT FOUND
                    //++++++++++++++++++Balance With Bank Entry+++++++++++++++++++++++//
                    LineN := LineN + 100;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := Rec.No;
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := Rec."Account Type";
                    Gnljnline."Account No." := Rec."Account No";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := Rec."Document No";
                    Gnljnline."Posting Date" := Rec."Posting date";
                    Gnljnline.Description := 'CHECKOFF ' + Rec.Remarks;
                    //Gnljnline.Amount:=Amount;
                    Gnljnline.Amount := Rec."Scheduled Amount";
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;

                    /*
                    //Post New
                    Gnljnline.RESET;
                    Gnljnline.SETRANGE("Journal Template Name",'GENERAL');
                    Gnljnline.SETRANGE("Journal Batch Name",'RCPT');
                    IF Gnljnline.FIND('-') THEN BEGIN
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post B",Gnljnline);
                    END;
                    */
                    //Posted:=TRUE;
                    Rec."Posted By" := Rec.No;
                    Rec.Modify;

                    Message('CheckOff Successfully Generated');
                    /*
                    Posted:=True;
                    MODIFY;
                     */

                end;
            }
        }
    }

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
        ReceiptsProcessingLines: Record "ReceiptsProcessing_L-Checkoff";
        LineNo: Integer;
        LBatches: Record "Loan Disburesment-Batching";
        Jtemplate: Code[30];
        JBatch: Code[30];
        "Cheque No.": Code[20];
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        ReptProcHeader: Record "ReceiptsProcessing_H-Checkoff";
        Cust: Record Customer;
        MembPostGroup: Record "Customer Posting Group";
        Loantable: Record "Loans Register";
        LRepayment: Decimal;
        RcptBufLines: Record "ReceiptsProcessing_L-Checkoff";
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
        Memb: Record Customer;
        INSURANCE: Decimal;
        GenBatches: Record "Gen. Journal Batch";
        Datefilter: Text[50];
        ReceiptLine: Record "ReceiptsProcessing_L-Checkoff";
}

