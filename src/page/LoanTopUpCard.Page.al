Page 50615 "Loan Top-Up Card"
{
    Caption = 'Loan Refinance Card';
    DeleteAllowed = false;
    PageType = Card;
    Editable = true;
    SourceTable = "Loan Top Up.";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = ApprovedEditable;

                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan To Top Up';
                }
                field("Issue Date"; Rec."Issue Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Original Issue Date';
                    Editable = false;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Original Requested Amount';
                    Editable = false;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Original Approved Amount';
                    Editable = false;
                }
                field("Outstanding Loan Amount"; Rec."Outstanding Loan Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Outstanding Balance';
                    Editable = false;
                }
                field("Top Up Amount"; Rec."Top Up Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Top Up Amount';

                    trigger OnValidate()
                    var
                    begin
                        LoansReg2.Reset();
                        LoansReg2.SetRange(LoansReg2."Loan  No.", Rec."Document No");
                        if LoansReg2.Find('-') then begin
                            LoansReg2."Approved Amount" := Rec."Top Up Amount";
                            LoansReg2.Modify();
                        end;
                        Rec.Modify();
                    end;
                }
                field("Original Installments"; Rec."Original Installments")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Remaining Installments"; Rec."Remaining Installments")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Repayment Start Date"; Rec."Repayment Start Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Loan Insurance"; Rec."Loan Insurance")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Commision; Rec.Commision)
                {
                    ApplicationArea = Basic;
                    Caption = 'Refinance Commission';
                    Editable = false;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        if Rec.Status <> Rec.Status::Open then
                            ApprovedEditable := false
                        else
                            ApprovedEditable := true;
                    end;
                }
                field("Topped-Up"; Rec."Topped-Up")
                {
                    ApplicationArea = Basic;
                    Caption = 'Topped-Up';
                    Editable = false;
                }
                field("Top Up Loan No"; Rec."Top Up Loan No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Top Up Loan No';
                    Editable = false;
                }
                field("New TopUp Installments"; Rec."New TopUp Installments")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Topped-Up By"; Rec."Topped-Up By")
                {
                    ApplicationArea = Basic;
                    Caption = 'Topped-Up By';
                    Editable = false;
                }
                field("Refinance Application Date"; Rec."Top Up Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Caption = 'Top Up Application Date';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                group(Control1000000025)
                {
                    Editable = ApprovedEditable;
                    Visible = Rec."Partial Top-Up" = true;

                    field("Original Top-Up"; Rec."Original Top-Up")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Original Refinance';
                        Editable = false;
                    }
                    field("Amount To Disburse"; Rec."Amount To Disburse")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Disbursed Amount"; Rec."Disbursed Amount")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Balance After"; Rec."Balance After")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                }
            }
            group("Guarantors  Detail")
            {
                Editable = ApprovedEditable;

                part(Control1000000004; "Loans Guarantee Details")
                {
                    Caption = 'Guarantors  Detail';
                    SubPageLink = "Loan No" = field("Document No");
                }
            }
            group("Collateral Detail")
            {
                Editable = ApprovedEditable;

                part(Control1000000005; "Loan Collateral Security")
                {
                    Caption = 'Other Securities';
                    SubPageLink = "Loan No" = field("Document No");
                }
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

                action("Post Loan Appeal")
                {
                    ApplicationArea = Basic;
                    Caption = 'POST';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."Member No");
                        if Cust.FindFirst then begin
                            DBranch := Cust."Global Dimension 2 Code";
                        end;
                        if Confirm('Are you sure you want to post this Loan Top Up ?', true) = false then exit;
                        //Temp.Get(UserId);
                        Jtemplate := 'PAYMENTS'; //Temp."Receipt Journal Template";
                        JBatch := 'LOANS'; //Temp."Receipt Journal Batch";
                        Rec."Posting Date" := Today;
                        Rec.Modify();
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                        GenJournalLine.SetRange("Journal Batch Name", JBatch);
                        GenJournalLine.DeleteAll;
                        GenSetUp.Get();
                        LoanApps.Reset;
                        LoanApps.SetRange(LoanApps."Loan  No.", Rec."Loan No");
                        LoanApps.SetRange(LoanApps."System Created", false);
                        LoanApps.SetFilter(LoanApps."Approval Status", '<>Rejected');
                        if LoanApps.Find('-') then begin
                            if LoanApps."Approval Status" <> LoanApps."approval status"::Approved then Error('Loan status must be Approved for you to post Loan. - ' + LoanApps."Loan  No.");
                            //Generate and post Approved Loan Amount
                            if not GenBatch.Get(Jtemplate, JBatch) then begin
                                GenBatch.Init;
                                GenBatch."Journal Template Name" := Jtemplate;
                                GenBatch.Name := JBatch;
                                GenBatch.Insert;
                            end;
                            Rec."Posting Date" := Today;
                            //1)Create New Loan
                            NewLoan := '';
                            NewLoan := FnCreateNewLoan(Rec."Loan No", Rec."Document No");
                            If NewLoan = '' then begin
                                Error('Could not create Process Request,Contact System Administrator');
                            end;
                            NewLoan := Rec."Document No";
                            //2)Generate Schedule For New Loan
                            RepaymentSchedule.Reset();
                            RepaymentSchedule.SetRange(RepaymentSchedule."Loan No.", Rec."Document No");
                            if RepaymentSchedule.Find('-') = true then begin
                                RepaymentSchedule.DeleteAll();
                                //MicropointFactory.FnGenerateRepaymentSchedule(Rec."Document No");
                            end
                            else if RepaymentSchedule.Find('-') = false then begin
                                /// MicropointFactory.FnGenerateRepaymentSchedule(Rec."Document No");
                            end;
                            //3)Create The New Loan lines
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                            GenJournalLine."Account No." := Rec."Member No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := Rec."Document No";
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := 'TopUp Loan Principle topping-' + Format(Rec."Loan No");
                            GenJournalLine.Amount := (Rec."Top Up Amount");
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Loan No" := NewLoan;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            if GenJournalLine.Amount <> 0 then GenJournalLine.Insert;
                            //Take to FOSA Account
                            LoanApps.Reset;
                            LoanApps.SetRange(LoanApps."Loan  No.", NewLoan);
                            LoanApps.SetRange(LoanApps."System Created", false);
                            LoanApps.SetFilter(LoanApps."Approval Status", '<>Rejected');
                            if LoanApps.Find('-') then begin
                                if LoanApps."Mode of Disbursement" = LoanApps."mode of disbursement"::"Bank Transfer" then begin
                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Journal Batch Name" := JBatch;
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := LoanApps."Account No";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := Rec."Document No";
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := 'Top up Amount for Loan-' + Format(Rec."Loan No");
                                    GenJournalLine.Amount := (Rec."Top Up Amount") * -1;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Loan No" := NewLoan;
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                    if GenJournalLine.Amount <> 0 then GenJournalLine.Insert;
                                end
                                else if LoanApps.Find('-') then begin
                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Journal Batch Name" := JBatch;
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := LoanApps."Account No";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := Rec."Document No";
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := 'Top Up for ' + LoanApps."Loan Product Type" + ' Loan.';
                                    GenJournalLine.Amount := (Rec."Top Up Amount") * -1;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Loan No" := NewLoan;
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                    if GenJournalLine.Amount <> 0 then GenJournalLine.Insert;
                                end;
                            end;
                            //
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := LoanApps."Account No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := Rec."Document No";
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := 'Crediting Interest';
                            GenJournalLine.Amount := 500;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := '5218';
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            if GenJournalLine.Amount <> 0 then GenJournalLine.Insert;
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := LoanApps."Account No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := Rec."Document No";
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := 'FOSA Shares Recovery';
                            GenJournalLine.Amount := ((Rec."Top Up Amount" * 1) / 100);
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            if GenJournalLine.Amount <> 0 then GenJournalLine.Insert;
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                            GenJournalLine."Account No." := Rec."Member No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := Rec."Document No";
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := 'FOSA Shares';
                            GenJournalLine.Amount := ((Rec."Top Up Amount" * 1) / 100) * -1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"FOSA Shares";
                            GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            if GenJournalLine.Amount <> 0 then GenJournalLine.Insert;
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := LoanApps."Account No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := Rec."Document No";
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := 'Upfront Interest';
                            GenJournalLine.Amount := ((Rec."Top Up Amount" * 4) / 100);
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := '5218';
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            if GenJournalLine.Amount <> 0 then GenJournalLine.Insert;
                            //-----------------------------------------------------------------------------------
                            //................Offset Details start
                            Rec.CalcFields("Offsetted Amount");
                            if Rec."Offsetted Amount" > 0 then begin
                                LoanTopUp.RESET;
                                LoanTopUp.SETRANGE(LoanTopUp."Loan No.", Rec."Top Up Loan No");
                                IF LoanTopUp.FIND('-') THEN BEGIN
                                    REPEAT //Maybe there are multiple topup loans
                                           //Principle
                                        LineNo := LineNo + 10000;
                                        GenJournalLine.INIT;
                                        GenJournalLine."Journal Template Name" := Jtemplate;
                                        GenJournalLine."Journal Batch Name" := JBatch;
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Document No." := Rec."Document No";
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine."External Document No." := Rec."Top Up Loan No";
                                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
                                        GenJournalLine."Account No." := Rec."Member No";
                                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                        GenJournalLine.Description := 'Loan OffSet By - ' + Rec."Top Up Loan No";
                                        GenJournalLine.Amount := LoanTopUp."Principle Top Up" * -1;
                                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                        GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Loan Repayment";
                                        GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                        LoansReg2.Reset();
                                        if LoansReg2.Get(LoanTopUp."Loan No.") then GenJournalLine."Shortcut Dimension 1 Code" := Format(LoansReg2.Source);
                                        GenJournalLine."Shortcut Dimension 2 Code" := MicropointFactory.FnGetMemberBranch(Rec."Member No");
                                        IF GenJournalLine.Amount <> 0 THEN GenJournalLine.INSERT;
                                        //****************************Debit Vendor To pay loan principle*******************************
                                        LineNo := LineNo + 10000;
                                        GenJournalLine.INIT;
                                        GenJournalLine."Journal Template Name" := Jtemplate;
                                        GenJournalLine."Journal Batch Name" := JBatch;
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Document No." := Rec."Document No";
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine."External Document No." := Rec."Top Up Loan No";
                                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                                        GenJournalLine."Account No." := LoanApps."Account No";
                                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                        GenJournalLine.Description := 'Loan offset Principal to loan-' + LoanTopUp."Loan Top Up" + '-' + LoanTopUp."Loan Type";
                                        GenJournalLine.Amount := LoanTopUp."Principle Top Up";
                                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                        LoansReg2.Reset();
                                        if LoansReg2.Get(LoanTopUp."Loan No.") then GenJournalLine."Shortcut Dimension 1 Code" := Format(LoansReg2.Source);
                                        GenJournalLine."Shortcut Dimension 2 Code" := MicropointFactory.FnGetMemberBranch(Rec."Member No");
                                        IF GenJournalLine.Amount <> 0 THEN GenJournalLine.INSERT;
                                        //..................Recover Interest On Top Up
                                        LineNo := LineNo + 10000;
                                        GenJournalLine.INIT;
                                        GenJournalLine."Journal Template Name" := Jtemplate;
                                        GenJournalLine."Journal Batch Name" := JBatch;
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Account Type" := GenJournalLine."Bal. Account Type"::Customer;
                                        GenJournalLine."Account No." := Rec."Member No";
                                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                        GenJournalLine."Document No." := Rec."Document No";
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine.Description := 'Interest Due Paid on top up';
                                        GenJournalLine.Amount := -LoanTopUp."Interest Top Up";
                                        GenJournalLine."External Document No." := Rec."Top Up Loan No";
                                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                        GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Interest Paid";
                                        GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                        LoansReg2.Reset();
                                        if LoansReg2.Get(LoanTopUp."Loan No.") then GenJournalLine."Shortcut Dimension 1 Code" := Format(LoansReg2.Source);
                                        GenJournalLine."Shortcut Dimension 2 Code" := MicropointFactory.FnGetMemberBranch(Rec."Member No");
                                        IF GenJournalLine.Amount <> 0 THEN GenJournalLine.INSERT;
                                        //Recover Loan Interest From FOSA Account
                                        LineNo := LineNo + 10000;
                                        GenJournalLine.INIT;
                                        GenJournalLine."Journal Template Name" := Jtemplate;
                                        GenJournalLine."Journal Batch Name" := JBatch;
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                                        GenJournalLine."Account No." := LoanApps."Account No";
                                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                        GenJournalLine."Document No." := Rec."Document No";
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine.Description := 'Loan offset Interest to loan-' + LoanTopUp."Loan Top Up" + '-' + LoanTopUp."Loan Type";
                                        GenJournalLine.Amount := LoanTopUp."Interest Top Up";
                                        GenJournalLine."External Document No." := Rec."Top Up Loan No";
                                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                        GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                        LoansReg2.Reset();
                                        if LoansReg2.Get(LoanTopUp."Loan No.") then GenJournalLine."Shortcut Dimension 1 Code" := Format(LoansReg2.Source);
                                        GenJournalLine."Shortcut Dimension 2 Code" := MicropointFactory.FnGetMemberBranch(Rec."Member No");
                                        IF GenJournalLine.Amount <> 0 THEN GenJournalLine.INSERT;
                                        //......................Top Up commission start
                                        IF LoanType.GET(LoanTopUp."Loan Type") THEN BEGIN
                                            GenJournalLine.INIT;
                                            LineNo := LineNo + 10000;
                                            GenJournalLine."Journal Template Name" := Jtemplate;
                                            GenJournalLine."Journal Batch Name" := JBatch;
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                                            GenJournalLine."Account No." := LoanType."Top Up Commision Account";
                                            GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                            GenJournalLine."Document No." := Rec."Document No";
                                            GenJournalLine."Posting Date" := Today;
                                            GenJournalLine.Description := 'Advance to clear Interest on' + LoanTopUp."Loan No." + '-' + LoanTopUp."Loan Type";
                                            GenJournalLine.Amount := LoanTopUp.Commision * -1;
                                            GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                            LoansReg2.Reset();
                                            if LoansReg2.Get(LoanTopUp."Loan No.") then GenJournalLine."Shortcut Dimension 1 Code" := Format(LoansReg2.Source);
                                            GenJournalLine."Shortcut Dimension 2 Code" := MicropointFactory.FnGetMemberBranch(Rec."Member No");
                                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                            IF GenJournalLine.Amount <> 0 THEN GenJournalLine.INSERT;
                                            //...........
                                            GenJournalLine.INIT;
                                            LineNo := LineNo + 10000;
                                            GenJournalLine."Journal Template Name" := Jtemplate;
                                            GenJournalLine."Journal Batch Name" := JBatch;
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                                            GenJournalLine."Account No." := LoanApps."Account No";
                                            GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                            GenJournalLine."Document No." := Rec."Document No";
                                            GenJournalLine."Posting Date" := Today;
                                            GenJournalLine.Description := 'Advance to clear Interest on' + LoanTopUp."Loan No." + '-' + LoanTopUp."Loan Type";
                                            GenJournalLine.Amount := LoanTopUp.Commision;
                                            GenJournalLine."External Document No." := Rec."Top Up Loan No";
                                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                            GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                            LoansReg2.Reset();
                                            if LoansReg2.Get(LoanTopUp."Loan No.") then GenJournalLine."Shortcut Dimension 2 Code" := MicropointFactory.FnGetMemberBranch(Rec."Member No");
                                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                            IF GenJournalLine.Amount <> 0 THEN GenJournalLine.INSERT;
                                        END;
                                    //......................Topup commission stop
                                    UNTIL LoanTopUp.NEXT = 0;
                                END;
                            end;
                            //................Offset Details Stop
                            //)Now post loan and  Mark the loan As posted In Loans Register
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                            GenJournalLine.SetRange("Journal Batch Name", JBatch);
                            if GenJournalLine.Find('-') then begin
                                GenJournalLine.SendToPosting(Codeunit::"Gen. Jnl.-Post");
                                //---------------New Code
                                Rec."Topped-Up" := true;
                                Rec."Topped-Up By" := UserId;
                                Rec."Posting Date" := Today;
                                Rec.Status := Rec.Status::Approved;
                                Rec.Posted := true;
                                Rec.Modify(true);
                                //4)Notify Member
                                //Message('Successfully Posted');
                                CurrPage.Close();
                            end;
                            //......................................................................
                        end;
                    end;
                }
                separator(Action1000000036)
                {
                    Caption = '-';
                }
                action("OffSet Loans")
                {
                    ApplicationArea = Basic;
                    Caption = 'Offset Member Loans';
                    Image = ActivateDiscounts;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Loan Offset Detail List";
                    RunPageLink = "Loan No." = FIELD("Top Up Loan No"), "Client Code" = FIELD("Member No");

                    trigger OnAction()
                    var
                    begin
                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        Text001: label 'This request is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        ScheduleError: label 'Please View the Loan Schedule First';
                        MicropointApprovalsCodeUnit: Codeunit "Micropoint ApprovalsCodeUnit";
                    begin
                        if Confirm('Send Approval Request?', false) = true then begin
                            //MicropointApprovalsCodeUnit.SendLoanTopUpRequestForApproval(rec."Document No", Rec);
                        end;
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        Approvalmgt: Codeunit "Approvals Mgmt.";
                        MicropointApprovalsCodeUnit: Codeunit "Micropoint ApprovalsCodeUnit";
                    begin
                        if Confirm('Cancel Approval Request?', false) = true then begin
                            //MicropointApprovalsCodeUnit.CancelLoanTopUpRequestForApproval(rec."Document No", Rec);
                        end;
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        if Rec.Status <> Rec.Status::Open then
            ApprovedEditable := false
        else
            ApprovedEditable := true;
    end;

    trigger OnOpenPage()
    begin
        if Rec.Status <> Rec.Status::Open then
            ApprovedEditable := false
        else
            ApprovedEditable := true;
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        GenBatch: Record "Gen. Journal Batch";
        LoanApps: Record "Loans Register";
        //Temp: Record "Funds User Setup";
        LoanSchedule: Record "Loan Repayment Schedule";
        Cust: Record Customer;
        InsuranceContribution: Decimal;
        SharesContribution: Decimal;
        Jtemplate: Code[10];
        JBatch: Code[10];
        GenSetUp: Record "Sacco General Set-Up";
        DActivity: Code[20];
        DBranch: Code[20];
        LineNo: Integer;
        LoanTopUp: Record "Loan Offset Details";
        ApprovedEditable: Boolean;
        DisbAmount: Decimal;
        BalanceAfter: Decimal;
        LoanType: record "Loan Products Setup";
        LoansOffset: Record "Loan Offset Details";
        ScheduleError: label 'Please view the loan schedule first!';
        TotalOffset: Decimal;
        RepayCode: Code[10];
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        NewLoan: Code[30];

        RepaymentSchedule: Record "Loan Repayment Schedule";
        MicropointFactory: Codeunit "Micropoint Factory";
        LoansReg2: Record "Loans Register";

    local procedure FnCreateNewLoan(LoanNo: Code[20]; DocumentNo: Code[20]): Code[30]
    var
        LoansRegister: Record "Loans Register";
        LoanApp: Record "Loans Register";
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        LoanApp.Reset();
        LoanApp.SetRange(LoanApp."Loan  No.", LoanNo);
        LoanApp.SetAutoCalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Interest");
        if LoanApp.Find('-') then begin
            LoansRegister.Reset();
            LoansRegister.SetRange(LoansRegister."Loan  No.", Rec."Document No");
            if LoansRegister.Find('-') then begin
                LoansRegister."Approved Amount" := Rec."Top Up Amount";
                LoansRegister.Interest := LoanApp.Interest;
                LoansRegister."Instalment Period" := LoanApp."Instalment Period";
                LoansRegister.Installments := Rec."New TopUp Installments";
                LoansRegister."Loan Disbursement Date" := Today;
                if Date2DMY(LoansRegister."Loan Disbursement Date", 1) <= 15 then begin
                    LoansRegister."Repayment Start Date" := CalcDate('CM', LoansRegister."Loan Disbursement Date");
                end
                else if Date2DMY(LoansRegister."Loan Disbursement Date", 1) > 15 then begin
                    LoansRegister."Repayment Start Date" := CalcDate('CM', CalcDate('CM+1M', LoansRegister."Loan Disbursement Date"));
                end;
                LoansRegister."Expected Date of Completion" := CALCDATE('CM', CalcDate('CM+' + Format(LoansRegister.Installments) + 'M', LoansRegister."Loan Disbursement Date"));
                LoansRegister."Requested Amount" := Rec."Top Up Amount";
                LoansRegister."Client Code" := Rec."Member No";
                LoansRegister."BOSA No" := LoanApp."Client Code";
                LoansRegister."Client Name" := LoanApp."Client Name";
                LoansRegister."Employer Code" := LoanApp."Employer Code";
                LoansRegister."Employer Name" := LoanApp."Employer Name";
                LoansRegister."Staff No" := LoanApp."Staff No";
                LoansRegister."Main Sector" := LoanApp."Main Sector";
                LoansRegister."Sub-Sector" := LoanApp."Sub-Sector";
                LoansRegister."Specific Sector" := LoanApp."Specific Sector";
                LoansRegister."ID NO" := LoanApp."ID NO";
                LoansRegister."Group Code" := LoanApp."Group Code";

                LoansRegister."Branch Code" := LoanApp."Branch Code";
                LoansRegister."Issued Date" := TODAY;
                LoansRegister."Repayment Start Date" := TODAY;
                LoansRegister.Source := LoanApp.Source;
                LoansRegister."Loan Disbursed Amount" := Rec."Top Up Amount";
                LoansRegister.Gender := LoanApp.Gender;
                LoansRegister."Branch Code" := LoanApp."Branch Code";
                LoansRegister."No. Series" := LoanApp."No. Series";
                LoansRegister."Doc No Used" := Rec."Document No"; //("Top Up Amount" * 4) / 100
                IF LoanApp."Repayment Method" = LoanApp."Repayment Method"::"Reducing Balance" THEN BEGIN
                    LoansRegister."Loan Interest Repayment" := ROUND((LoansRegister.Interest / 12 / 100) * LoansRegister."Approved Amount", 0.05, '>');
                    LoansRegister."Loan Principle Repayment" := ROUND(LoansRegister."Approved Amount" / LoansRegister.Installments, 0.05, '>');
                END
                ELSE IF LoanApp."Repayment Method" = LoanApp."Repayment Method"::Amortised THEN BEGIN
                    LoansRegister."Loan Interest Repayment" := ROUND((LoansRegister."Approved Amount" / 100 / 12) * LoansRegister.Interest, 0.05, '>');
                    LoansRegister."Loan Principle Repayment" := (ROUND((LoansRegister.Interest / 12 / 100) / (1 - POWER((1 + (LoansRegister.Interest / 12 / 100)), -LoansRegister.Installments)) * LoansRegister."Approved Amount", 1, '>')) - (LoansRegister."Loan Interest Repayment");
                END;
                LoansRegister."Loan Interest Repayment" := (Rec."Top Up Amount" * 4) / 100;
                LoansRegister."Loan Repayment" := LoansRegister."Loan Interest Repayment" + LoansRegister."Loan Principle Repayment";
                LoansRegister."Approval Status" := LoansRegister."Approval Status"::Approved;
                LoansRegister."Account No" := LoanApp."Account No";
                LoansRegister."Application Date" := TODAY;
                LoansRegister.Repayment := LoansRegister."Loan Interest Repayment" + LoansRegister."Loan Principle Repayment";
                LoansRegister."Loan Product Type" := LoanApp."Loan Product Type";
                LoansRegister."Loan Product Type Name" := LoanApp."Loan Product Type";
                LoansRegister.Installments := Rec."New TopUp Installments";
                LoansRegister."Loan Amount" := LoansRegister."Approved Amount";
                LoansRegister."Issued Date" := TODAY;
                LoansRegister."Outstanding Balance" := 0;
                LoansRegister.Posted := TRUE;
                // LoansRegister."Advice Type":=LoansRegister."Advice Type"::"Top Up";
                LoansRegister."Loan Status" := LoansRegister."Loan Status"::Issued;
                LoansRegister."Posting Date" := Today;
                LoansRegister."Repayment Frequency" := LoanApp."Repayment Frequency";
                LoansRegister."Recovery Mode" := LoanApp."Recovery Mode";
                LoansRegister."Mode of Disbursement" := LoanApp."Mode of Disbursement";
                LoansRegister.Modify(TRUE);
            end;
        end;
        Message('The top Up Loan Number is %1', LoansRegister."Loan  No.");
        exit(LoansRegister."Loan  No.");
    end;
}
