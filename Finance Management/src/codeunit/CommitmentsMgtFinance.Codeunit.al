codeunit 51004 "Commitments Mgt Finance"
{
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        BudgetErrorMsg: Label 'You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4', Comment = '%1 = Account No, %2 = Budget Available, %3 = Exceeded Amount, %4 = Budget Available, %5 = Account Name, %6 = Fund';
        HasGotGLSetup: Boolean;
        GLSetupShortcutDimCode: array[8] of Code[20];
        UncommittmentDate: Date;

    trigger OnRun()
    begin
    end;

    procedure CancelPaymentsCommitments(Payments: Record Payments)
    var
        CommitmentEntries: Record "Commitment Entries";
    begin
        CommitmentEntries.Reset();
        CommitmentEntries.SetRange("Commitment No", Payments."No.");
        CommitmentEntries.SetRange("Commitment Type", CommitmentEntries."Commitment Type"::Commitment);
        CommitmentEntries.DeleteAll();
    end;

    procedure CheckImprestCommittment(Imprest: Record Payments)
    var
        CommitmentEntries: Record "Commitment Entries";
        Committments: Record "Commitment Entries";
        GLAccount: Record "G/L Account";
        GenLedSetup: Record "General Ledger Setup";
        ImpLines: Record "Payment Lines";
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
    begin
        ImpLines.Reset();
        ImpLines.SetRange(No, Imprest."No.");
        ImpLines.SetRange("Account Type", ImpLines."Account Type"::"G/L Account");
        if ImpLines.Find('-') then
            repeat
                if IsAccountVotebookEntry(ImpLines."Account No") then begin
                    //Confirm the Amount to be issued does not exceed the budget and amount Committed
                    //Get Budget for the G/L
                    GenLedSetup.Get();
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    GLAccount.SetRange(GLAccount."No.", ImpLines."Account No");
                    //Get budget amount avaliable
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", Imprest.Date);
                    if GenLedSetup."Use Dimensions For Budget" then
                        GLAccount.SetRange(GLAccount."Dimension Set ID Filter", ImpLines."Dimension Set ID");
                    if GLAccount.Find('-') then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
                        BudgetAvailable := GLAccount."Budgeted Amount" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount := 0;
                    CommitmentEntries.Reset();
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    CommitmentEntries.SetRange(CommitmentEntries.Account, ImpLines."Account No");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    if Imprest.Date = 0D then
                        Error('Please insert the payment voucher date');
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date",
                                               Imprest.Date);
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount := CommitmentEntries."Committed Amount";
                    if GLAccount.Get(ImpLines."Account No") then;
                    //IF GLAccount."Votebook Entry" THEN BEGIN
                    if CommittedAmount + ImpLines.Amount > BudgetAvailable then
                        Error('You have Exceeded Budget for G/L Account No %1 By %2 Budget Available %3'
                       , Committments.Account,
                        Abs(BudgetAvailable - (CommittedAmount + ImpLines.Amount)), BudgetAvailable - CommittedAmount);
                    //END;
                end;
            until ImpLines.Next() = 0;
    end;

    procedure CheckImprestSurrenderCommittment(Imprest: Record Payments)
    var
        CommitmentEntries: Record "Commitment Entries";
        Committments: Record "Commitment Entries";
        GLAccount: Record "G/L Account";
        GenLedSetup: Record "General Ledger Setup";
        ImpLines: Record "Payment Lines";
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
    begin
        ImpLines.Reset();
        ImpLines.SetRange(No, Imprest."No.");
        ImpLines.SetRange("Account Type", ImpLines."Account Type"::"G/L Account");
        if ImpLines.Find('-') then
            repeat
                //Confirm the Amount to be issued does not exceed the budget and amount Committed
                //Get Budget for the G/L
                if IsAccountVotebookEntry(ImpLines."Account No") then begin
                    GenLedSetup.Get();
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    GLAccount.SetRange(GLAccount."No.", ImpLines."Account No");
                    //Get budget amount avaliable
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", Imprest.Date);
                    if GenLedSetup."Use Dimensions For Budget" then
                        GLAccount.SetRange(GLAccount."Dimension Set ID Filter", ImpLines."Dimension Set ID");
                    if GLAccount.Find('-') then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
                        BudgetAvailable := GLAccount."Budgeted Amount" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount := 0;
                    CommitmentEntries.Reset();
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    CommitmentEntries.SetRange(CommitmentEntries.Account, ImpLines."Account No");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    if Imprest.Date = 0D then
                        Error('Please insert the payment voucher date');
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date",
                                               Imprest.Date);
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount := CommitmentEntries."Committed Amount";
                    if GLAccount.Get(ImpLines."Account No") then;
                    if GLAccount."Votebook Entry" then
                        if CommittedAmount + (ImpLines."Actual Spent" - ImpLines.Amount) > BudgetAvailable then
                            Error('You have Exceeded Budget for G/L Account No %1 By %2 Budget Available %3'
                           , Committments.Account,
                            Abs(BudgetAvailable - (CommittedAmount + (ImpLines."Actual Spent" - ImpLines.Amount))), BudgetAvailable - CommittedAmount);
                end;
            until ImpLines.Next() = 0;
    end;

    procedure CheckPettyCashCommittment(PC: Record Payments)
    var
        CommitmentEntries: Record "Commitment Entries";
        Committments: Record "Commitment Entries";
        GLAccount: Record "G/L Account";
        GenLedSetup: Record "General Ledger Setup";
        PCLines: Record "Payment Lines";
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
    begin
        PCLines.Reset();
        PCLines.SetRange(No, PC."No.");
        PCLines.SetRange("Account Type", PCLines."Account Type"::"G/L Account");
        if PCLines.Find('-') then
            repeat
                if IsAccountVotebookEntry(PCLines."Account No") then begin
                    //Confirm the Amount to be issued does not exceed the budget and amount Committed
                    //Get Budget for the G/L
                    GenLedSetup.Get();
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    GLAccount.SetRange(GLAccount."No.", PCLines."Account No");
                    //Get budget amount avaliable
                    // GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", PC.Date);
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", GenLedSetup."Current Budget End Date");
                    if GenLedSetup."Use Dimensions For Budget" then
                        GLAccount.SetRange(GLAccount."Dimension Set ID Filter", PCLines."Dimension Set ID");
                    if GLAccount.Find('-') then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
                        BudgetAvailable := GLAccount."Budgeted Amount" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount := 0;
                    CommitmentEntries.Reset();
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    CommitmentEntries.SetRange(CommitmentEntries.Account, PCLines."Account No");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    if PC.Date = 0D then
                        Error('Please insert the payment voucher date');
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date",
                                               GenLedSetup."Current Budget End Date");
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount := CommitmentEntries."Committed Amount";
                    if GLAccount.Get(PCLines."Account No") then;
                    if GLAccount."Votebook Entry" then
                        if CommittedAmount + PCLines.Amount > BudgetAvailable then
                            Error('You have Exceeded Budget for G/L Account No %1 By %2 Budget Available %3'
                           , Committments.Account,
                            Abs(BudgetAvailable - (CommittedAmount + PCLines.Amount)), BudgetAvailable - CommittedAmount);
                end;
            until PCLines.Next() = 0;
    end;

    procedure CheckPettyCashSurrenderCommittment(PCash: Record Payments)
    var
        CommitmentEntries: Record "Commitment Entries";
        Committments: Record "Commitment Entries";
        GLAccount: Record "G/L Account";
        GenLedSetup: Record "General Ledger Setup";
        PCashLines: Record "Payment Lines";
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
    begin
        PCashLines.Reset();
        PCashLines.SetRange(No, PCash."No.");
        PCashLines.SetRange("Account Type", PCashLines."Account Type"::"G/L Account");
        if PCashLines.Find('-') then
            repeat
                //Confirm the Amount to be issued does not exceed the budget and amount Committed
                //Get Budget for the G/L
                if IsAccountVotebookEntry(PCashLines."Account No") then begin
                    GenLedSetup.Get();
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    GLAccount.SetRange(GLAccount."No.", PCashLines."Account No");
                    //Get budget amount avaliable
                    //GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", PCash.Date);
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", GenLedSetup."Current Budget End Date");
                    if GenLedSetup."Use Dimensions For Budget" then
                        GLAccount.SetRange(GLAccount."Dimension Set ID Filter", PCashLines."Dimension Set ID");
                    if GLAccount.Find('-') then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
                        BudgetAvailable := GLAccount."Budgeted Amount" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount := 0;
                    CommitmentEntries.Reset();
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    CommitmentEntries.SetRange(CommitmentEntries.Account, PCashLines."Account No");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    if PCash.Date = 0D then
                        Error('Please insert the Petty Cash Surrender date');
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date",
                                               PCash.Date);
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount := CommitmentEntries."Committed Amount";
                    if GLAccount.Get(PCashLines."Account No") then;
                    if GLAccount."Votebook Entry" then
                        if CommittedAmount + (PCashLines."Actual Spent" - PCashLines.Amount) > BudgetAvailable then
                            Error('You have Exceeded Budget for G/L Account No %1 By %2 Budget Available %3'
                           , Committments.Account,
                            Abs(BudgetAvailable - (CommittedAmount + (PCashLines."Actual Spent" - PCashLines.Amount))), BudgetAvailable - CommittedAmount);
                end;
            until PCashLines.Next() = 0;
    end;

    procedure CheckPurchInvoiceCommittment(IR: Record "Purchase Header")
    var
        CommitmentEntries: Record "Commitment Entries";
        Committments: Record "Commitment Entries";
        GLAccount: Record "G/L Account";
        GenLedSetup: Record "General Ledger Setup";
        IRLine: Record "Purchase Line";
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        ErrorMsg: Label 'You have Exceeded Budget for G/L Account No %1 Fund %5 By %2 Budget Available %3 CommittedAmount %4', Comment = '%1 = Account No, %2 = Exceeded Amount, %3 = Budget Available, %4 = Committed Amount, %5 = Fund';
    begin
        IRLine.Reset();
        IRLine.SetRange("Document No.", IR."No.");
        IRLine.SetRange(Type, IRLine.Type::"G/L Account");
        if IRLine.Find('-') then
            repeat
                //Confirm the Amount to be issued does not exceed the budget and amount Committed
                //Get Budget for the G/L
                if IsAccountVotebookEntry(IRLine."No.") then begin
                    GenLedSetup.Get();
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    GLAccount.SetRange(GLAccount."No.", IRLine."No.");
                    //Get budget amount avaliable
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", IR."Posting Date");
                    if GLAccount.Find('-') then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
                        BudgetAvailable := GLAccount."Budgeted Amount" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount := 0;
                    CommitmentEntries.Reset();
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    CommitmentEntries.SetRange(CommitmentEntries.Account, IRLine."No.");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    if IR."Posting Date" = 0D then
                        Error('Please insert the posting date');
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date",
                                               IR."Posting Date");
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount := CommitmentEntries."Committed Amount";
                    if GLAccount.Get(IRLine."No.") then;
                    if GLAccount."Votebook Entry" then
                        if CommittedAmount + IRLine.Amount > BudgetAvailable then
                            Error(ErrorMsg
                           , Committments.Account,
                            Abs(BudgetAvailable - (CommittedAmount + IRLine.Amount)), BudgetAvailable, CommittedAmount, IRLine."Shortcut Dimension 1 Code");
                end;
            until IRLine.Next() = 0;
    end;

    procedure CheckPVCommittment(PV: Record Payments)
    var
        CommitmentEntries: Record "Commitment Entries";
        Committments: Record "Commitment Entries";
        GLAccount: Record "G/L Account";
        GenLedSetup: Record "General Ledger Setup";
        PVLines: Record "Payment Lines";
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
    begin
        PVLines.Reset();
        PVLines.SetRange(No, PV."No.");
        PVLines.SetRange("Account Type", PVLines."Account Type"::"G/L Account");
        if PVLines.Find('-') then
            repeat
                if IsAccountVotebookEntry(PVLines."Account No") then begin
                    //Confirm the Amount to be issued does not exceed the budget and amount Committed
                    //Get Budget for the G/L
                    GenLedSetup.Get();
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    GLAccount.SetRange(GLAccount."No.", PVLines."Account No");
                    //Get budget amount avaliable
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", PV.Date);
                    if GenLedSetup."Use Dimensions For Budget" then
                        GLAccount.SetRange(GLAccount."Dimension Set ID Filter", PVLines."Dimension Set ID");
                    if GLAccount.Find('-') then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
                        BudgetAvailable := GLAccount."Budgeted Amount" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount := 0;
                    CommitmentEntries.Reset();
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    CommitmentEntries.SetRange(CommitmentEntries.Account, PVLines."Account No");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    if PV.Date = 0D then
                        Error('Please insert the payment voucher date');
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date",
                                               PV.Date);
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount := CommitmentEntries."Committed Amount";
                    if GLAccount.Get(PVLines."Account No") then;
                    if GLAccount."Votebook Entry" then
                        if CommittedAmount + PVLines.Amount > BudgetAvailable then
                            Error('You have Exceeded Budget for G/L Account No %1 By %2 Budget Available %3 CommittedAmount %4'
                           , Committments.Account,
                            Abs(BudgetAvailable - (CommittedAmount + PVLines.Amount)), BudgetAvailable, CommittedAmount);
                end;
            until PVLines.Next() = 0;
    end;

    procedure CheckStaffClaimCommittment(Claim: Record Payments)
    var
        CommitmentEntries: Record "Commitment Entries";
        Committments: Record "Commitment Entries";
        GLAccount: Record "G/L Account";
        GenLedSetup: Record "General Ledger Setup";
        ClaimLines: Record "Payment Lines";
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
    begin
        ClaimLines.Reset();
        ClaimLines.SetRange(No, Claim."No.");
        ClaimLines.SetRange("Account Type", ClaimLines."Account Type"::"G/L Account");
        if ClaimLines.Find('-') then
            repeat
                //Confirm the Amount to be issued does not exceed the budget and amount Committed
                //Get Budget for the G/L
                if IsAccountVotebookEntry(ClaimLines."Account No") then begin
                    GenLedSetup.Get();
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    GLAccount.SetRange(GLAccount."No.", ClaimLines."Account No");
                    //Get budget amount avaliable
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", Claim.Date);
                    if GenLedSetup."Use Dimensions For Budget" then
                        GLAccount.SetRange(GLAccount."Dimension Set ID Filter", ClaimLines."Dimension Set ID");
                    if GLAccount.Find('-') then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
                        BudgetAvailable := GLAccount."Budgeted Amount" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount := 0;
                    CommitmentEntries.Reset();
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    CommitmentEntries.SetRange(CommitmentEntries.Account, ClaimLines."Account No");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    if Claim.Date = 0D then
                        Error('Please insert the date');
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date",
                                               Claim.Date);
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount := CommitmentEntries."Committed Amount";
                    if GLAccount.Get(ClaimLines."Account No") then;
                    if GLAccount."Votebook Entry" then
                        if CommittedAmount + ClaimLines.Amount > BudgetAvailable then
                            Error('You have Exceeded Budget for G/L Account No %1 By %2 Budget Available %3'
                           , Committments.Account,
                            Abs(BudgetAvailable - (CommittedAmount + ClaimLines.Amount)), BudgetAvailable - CommittedAmount);
                end;
            until ClaimLines.Next() = 0;
    end;

    procedure CreatePV(var ImprestHeader: Record Payments)
    var
        CSetup: Record "Cash Management Setups";
        ImprestLines: Record "Payment Lines";
        PettyCashLines: Record "Payment Lines";
        PVLines: Record "Payment Lines";
    begin
        //Check whether the petty cash Limt has been exceeded or not
        CSetup.Get();
        CSetup.TestField("Imprest Limit");
        ImprestHeader.CalcFields("Imprest Amount");
        if ImprestHeader."Imprest Amount" > CSetup."Imprest Limit" then begin
            //Create a PV
            ImprestLines.SetRange(ImprestLines.No, ImprestHeader."No.");
            if ImprestLines.FindSet() then
                repeat
                    PVLines.Init();
                    PVLines.No := ImprestHeader."No.";
                    PVLines."Line No" := ImprestLines."Line No";
                    PVLines.Date := ImprestHeader.Date;
                    PVLines."Account Type" := ImprestLines."Account Type";
                    PVLines."Account No" := ImprestLines."Account No";
                    PVLines."Account Name" := ImprestLines."Account Name";
                    PVLines.Description := ImprestLines.Description;
                    PVLines.Amount := ImprestLines.Amount;
                    PVLines.Validate(Amount);
                    PVLines."Dimension Set ID" := ImprestHeader."Dimension Set ID";
                    //PVLines."Global Dimension 1 Code":=ImprestLines."Global Dimension 1 Code";
                    //PVLines."Global Dimension 2 Code":=ImprestLines."Global Dimension 2 Code";
                    if not PVLines.Get(PVLines.No, PVLines."Line No") then
                        PVLines.Insert();
                until
                 ImprestLines.Next() = 0;
            ImprestHeader."Payment Type" := ImprestHeader."Payment Type"::"Payment Voucher";
            //ImprestHeader."Original Document":=ImprestHeader."Original Document"::Imprest;
            ImprestHeader.Status := ImprestHeader.Status::Released;
            //ImprestHeader."PV Creation DateTime":=CREATEDATETIME(TODAY,TIME);
            //ImprestHeader."User Id":=USERID;
            ImprestHeader.Modify(true);
            Message('Payment Voucher No %1 has been successfully created', ImprestHeader."No.");
        end else begin
            //Create a petty cash
            ImprestLines.SetRange(ImprestLines.No, ImprestHeader."No.");
            if ImprestLines.FindSet() then
                repeat
                    PettyCashLines.Init();
                    PettyCashLines.No := ImprestHeader."No.";
                    PettyCashLines."Line No" := ImprestLines."Line No";
                    PettyCashLines."Account Type" := ImprestLines."Account Type";
                    PettyCashLines."Account No" := ImprestLines."Account No";
                    PettyCashLines."Account Name" := ImprestLines."Account Name";
                    PettyCashLines.Description := ImprestLines.Description;
                    PettyCashLines.Amount := ImprestLines.Amount;
                    PettyCashLines."Dimension Set ID" := ImprestLines."Dimension Set ID";
                    //PettyCashLines."Global Dimension 1 Code":=ImprestLines."Global Dimension 1 Code";
                    //PettyCashLines."Global Dimension 2 Code":=ImprestLines."Global Dimension 2 Code";
                    if not PettyCashLines.Get(PettyCashLines.No, PettyCashLines."Line No") then
                        PettyCashLines.Insert();
                until
                 ImprestLines.Next() = 0;
            ImprestHeader."Payment Type" := ImprestHeader."Payment Type"::"Petty Cash";
            //ImprestHeader."Original Document":=ImprestHeader."Original Document"::Imprest;
            ImprestHeader.Status := ImprestHeader.Status::Open;
            //ImprestHeader."PV Creation DateTime":=CREATEDATETIME(TODAY,TIME);
            //ImprestHeader."PV Creator ID":=USERID;
            ImprestHeader.Modify(true);
            Message('Petty Cash No %1 has been successfully created', ImprestHeader."No.");
        end;
    end;

    procedure EncumberImprest(var ImprestHeader: Record Payments)
    var
        Committments: Record "Commitment Entries";
        Customer: Record Customer;
        ImprestLines: Record "Payment Lines";
        EntryNo: Integer;
    begin
        ImprestLines.SetRange(ImprestLines.No, ImprestHeader."No.");
        if ImprestLines.FindSet() then begin
            if Committments.FindLast() then
                EntryNo := Committments."Entry No";
            Committments.Reset();
            Committments.SetRange(Committments."Commitment No", ImprestHeader."No.");
            Committments.SetRange(Committments."Commitment Type", Committments."Commitment Type"::"Commitment Reversal");
            if Committments.Find('-') then
                UncommittmentDate := Committments."Commitment Date";
            repeat
                if LineCommitted(ImprestHeader."No.", ImprestLines."Account No", ImprestLines."Line No") then begin
                    Committments.Init();
                    Committments."Commitment No" := ImprestHeader."No.";
                    Committments."Commitment Type" := Committments."Commitment Type"::Encumberance;
                    Committments."Document Type" := Committments."Document Type"::Imprest;
                    Committments."Commitment Date" := Today;
                    Committments."Uncommittment Date" := ImprestHeader.Date;
                    Committments."Dimension Set ID" := ImprestHeader."Dimension Set ID";
                    Committments."Global Dimension 1 Code" := ImprestLines."Shortcut Dimension 1 Code";
                    Committments."Global Dimension 2 Code" := ImprestLines."Shortcut Dimension 2 Code";
                    Committments.Account := ImprestLines."Account No";
                    Committments."Committed Amount" := LastCommittment(ImprestHeader."No.", ImprestLines."Account No", ImprestLines."Line No");
                    Committments.User := CopyStr(UserId, 1, MaxStrLen(Committments.User));
                    Committments."Document No" := ImprestHeader."No.";
                    Committments.No := ImprestLines."Account No";
                    Committments."Line No." := ImprestLines."Line No";
                    Committments."Dimension Set ID" := ImprestLines."Dimension Set ID";
                    Committments."Account Type" := Committments."Account Type"::Customer;
                    Committments."Account No." := ImprestHeader."Account No.";
                    if Customer.Get(ImprestHeader."Account No.") then
                        Committments."Account Name" := Customer.Name;
                    Committments.Description := ImprestLines.Description;
                    Committments."Dimension Set ID" := ImprestLines."Dimension Set ID";
                    EntryNo := EntryNo + 1;
                    Committments."Entry No" := EntryNo;
                    GeneralLedgerSetup.Get();
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code" := CopyStr(GetCommittedBudget(ImprestHeader."No."), 1, MaxStrLen(Committments."Budget Code"));
                    Committments.Insert();
                end;
            until ImprestLines.Next() = 0;
        end;
    end;

    procedure EncumberPayments(Payments: Record Payments)
    var
        CommittmentEntries: Record "Commitment Entries";
    begin
        CommittmentEntries.Reset();
        CommittmentEntries.SetRange("Commitment No", Payments."No.");
        CommittmentEntries.SetRange("Commitment Type", CommittmentEntries."Commitment Type"::Commitment);
        //CommittmentEntries.SetRange("Payment Posted", false);
        if CommittmentEntries.Find('-') then
            repeat
                CommittmentEntries."Commitment Type" := CommittmentEntries."Commitment Type"::Encumberance;
                CommittmentEntries.Modify();
            until
             CommittmentEntries.Next() = 0;
    end;

    procedure EncumberPO(var PurchLine: Record "Purchase Line"; var PurchHeader: Record "Purchase Header")
    var
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
    begin
        if Committments.FindLast() then
            EntryNo := Committments."Entry No";
        EntryNo := EntryNo + 1;
        Committments.Init();
        Committments."Commitment No" := PurchLine."Document No.";
        Committments."Commitment Type" := Committments."Commitment Type"::Commitment;
        Committments."Document Type" := Committments."Document Type"::LPO;
        //Insert same Commitment Date
        Committments."Commitment Date" := UncommittmentDate;
        Committments."Uncommittment Date" := PurchHeader."Posting Date";
        Committments."Dimension Set ID" := PurchLine."Dimension Set ID";
        Committments."Global Dimension 1 Code" := PurchLine."Shortcut Dimension 1 Code";
        Committments."Global Dimension 2 Code" := PurchLine."Shortcut Dimension 2 Code";
        Committments.Account := PurchLine."No.";
        Committments."Account No." := PurchLine."No.";
        Committments."Committed Amount" := PurchLine.Amount;
        Committments.User := CopyStr(UserId, 1, MaxStrLen(Committments.User));
        Committments."Document No" := PurchHeader."No.";
        Committments.No := PurchLine."No.";
        Committments."Line No." := PurchLine."Line No.";
        Committments."Entry No" := EntryNo;
        GeneralLedgerSetup.Get();
        GeneralLedgerSetup.TestField("Current Budget");
        Committments."Budget Code" := GeneralLedgerSetup."Current Budget";
        Committments.Insert();
    end;

    procedure EncumberPOStaffReq(var PurchLine: Record "Purchase Line"; var PurchHeader: Record "Purchase Header")
    var
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
    begin
        if Committments.FindLast() then
            EntryNo := Committments."Entry No";
        EntryNo := EntryNo + 1;
        Committments.Init();
        Committments."Commitment No" := PurchLine."Document No.";
        Committments."Commitment Type" := Committments."Commitment Type"::Encumberance;
        //Insert same Commitment Date
        Committments."Commitment Date" := UncommittmentDate;
        Committments."Uncommittment Date" := PurchHeader."Posting Date";
        Committments."Dimension Set ID" := PurchHeader."Dimension Set ID";
        //Committments."Global Dimension 1 Code":=IRLine."Global Dimension 1 Code";
        //Committments."Global Dimension 2 Code":=IRLine."Global Dimension 2 Code";
        Committments.Account := PurchLine."No.";
        Committments."Committed Amount" := PurchLine.Amount;
        Committments.User := CopyStr(UserId, 1, MaxStrLen(Committments.User));
        Committments."Document No" := PurchHeader."No.";
        Committments.No := PurchLine."No.";
        Committments."Line No." := PurchLine."Line No.";
        Committments."Entry No" := EntryNo;
        GeneralLedgerSetup.Get();
        GeneralLedgerSetup.TestField("Current Budget");
        Committments."Budget Code" := CopyStr(GetCommittedBudget(PurchLine."Document No."), 1, MaxStrLen(Committments."Budget Code"));
        Committments.Insert();
    end;

    procedure FetchDimValue(DimSetID: Integer; var ShortcutDimCode: array[8] of Code[20]; var DimValueName: array[8] of Text)
    var
        DimSetEntry: Record "Dimension Set Entry";
        i: Integer;
    begin
        GetGLSetup();
        for i := 1 to 8 do begin
            ShortcutDimCode[i] := '';
            if GLSetupShortcutDimCode[i] <> '' then
                if DimSetEntry.Get(DimSetID, GLSetupShortcutDimCode[i]) then begin
                    DimSetEntry.CalcFields("Dimension Name", "Dimension Value Name");
                    ShortcutDimCode[i] := DimSetEntry."Dimension Value Code";
                    DimValueName[i] := DimSetEntry."Dimension Value Name";
                end;
        end;
    end;

    procedure GetCommittedBudget(CommittedNo: Code[50]): Code[20]
    var
        CommEntries: Record "Commitment Entries";
        GLSetup: Record "General Ledger Setup";
    begin
        CommEntries.Reset();
        CommEntries.SetRange("Commitment No", CommittedNo);
        CommEntries.SetRange("Commitment Type", CommEntries."Commitment Type"::Commitment);
        if CommEntries.FindFirst() then
            exit(CommEntries."Budget Code")
        else begin
            GLSetup.Get();
            exit(GLSetup."Current Budget");
        end;
    end;

    procedure ImprestCommittment(var ImprestHeader: Record Payments; var ErrorMsg: Text)
    var
        CommitmentEntries: Record "Commitment Entries";
        Committments: Record "Commitment Entries";
        Customer: Record Customer;
        GLAccount: Record "G/L Account";
        GenLedSetup: Record "General Ledger Setup";
        ImprestLines: Record "Payment Lines";
        DimMgt: Codeunit DimensionManagement;
        LineError: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        EntryNo: Integer;
        DimValueName: array[8] of Text;
    begin
        ErrorMsg := '';
        /*
        if ImprestHeader.Status<>ImprestHeader.Status::Released then
            Error('The imprest is not fully approved');*/
        ImprestLines.SetRange(ImprestLines.No, ImprestHeader."No.");
        if ImprestLines.FindFirst() then begin
            if Committments.FindLast() then
                EntryNo := Committments."Entry No";
            repeat
                if IsAccountVotebookEntry(ImprestLines."Account No") then
                    if CheckImprestCostOfSales(ImprestLines."Account No", ImprestLines."Expenditure Type") = false then begin
                        Committments.Init();
                        Committments."Commitment No" := ImprestHeader."No.";
                        Committments."Commitment Type" := Committments."Commitment Type"::Commitment;
                        Committments."Document Type" := Committments."Document Type"::Imprest;
                        ImprestHeader.TestField(Date);
                        Committments."Commitment Date" := ImprestHeader.Date;
                        Committments."Global Dimension 1 Code" := ImprestLines."Shortcut Dimension 1 Code";
                        Committments."Global Dimension 2 Code" := ImprestLines."Shortcut Dimension 2 Code";
                        Committments.Account := ImprestLines."Account No";
                        Committments."Committed Amount" := ImprestLines.Amount;
                        //Confirm the Amount to be issued does not exceed the budget and amount Committed
                        //Get Budget for the G/L
                        GenLedSetup.Get();
                        GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                        GLAccount.SetRange(GLAccount."No.", ImprestLines."Account No");
                        if GenLedSetup."Use Dimensions For Budget" then
                            GLAccount.SetRange(GLAccount."Dimension Set ID Filter", ImprestLines."Dimension Set ID");
                        //Get Dimensions
                        DimMgt.GetShortcutDimensions(ImprestLines."Dimension Set ID", ShortcutDimCode);
                        /*if ShortcutDimCode[1]<>'' then
                        GLAccount.SetRange("Global Dimension 1 Filter",ShortcutDimCode[1]);
                        if ShortcutDimCode[2]<>'' then
                        GLAccount.SetRange("Global Dimension 2 Filter",ShortcutDimCode[2]);
                        if ShortcutDimCode[3]<>'' then
                        GLAccount.SetRange("Shortcut Dimension 3 Filter",ShortcutDimCode[3]);
                        if ShortcutDimCode[4]<>'' then
                        GLAccount.SetRange("Shortcut Dimension 4 Filter",ShortcutDimCode[4]);
                        if ShortcutDimCode[5]<>'' then
                        GLAccount.SetRange("Shortcut Dimension 5 Filter",ShortcutDimCode[5]);
                        if ShortcutDimCode[6]<>'' then
                        GLAccount.SetRange("Shortcut Dimension 6 Filter",ShortcutDimCode[6]);*/
                        FetchDimValue(ImprestLines."Dimension Set ID", ShortcutDimCode, DimValueName);
                        //Get budget amount avaliable
                        GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", ImprestHeader.Date);
                        if GLAccount.Find('-') then begin
                            GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget");
                            BudgetAvailable := GLAccount."Approved Budget" - GLAccount."Net Change";
                        end;
                        //Get committed Amount
                        CommittedAmount := 0;
                        CommitmentEntries.Reset();
                        CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                        CommitmentEntries.SetRange(CommitmentEntries.Account, ImprestLines."Account No");
                        if GenLedSetup."Use Dimensions For Budget" then
                            CommitmentEntries.SetRange(CommitmentEntries."Dimension Set ID", ImprestLines."Dimension Set ID");
                        CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                        if ImprestHeader.Date = 0D then
                            Error('Please insert the imprest date');
                        CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date",
                                                   ImprestHeader.Date);
                        CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                        CommittedAmount := CommitmentEntries."Committed Amount";
                        LineError := false;
                        if LineCommitted(ImprestHeader."No.", ImprestLines."Account No", ImprestLines."Line No") then
                            Message('Line No %1 has been committed', ImprestLines."Line No")
                        else
                            if CommittedAmount + ImprestLines.Amount > BudgetAvailable then begin
                                if ErrorMsg = '' then
                                    ErrorMsg := StrSubstNo(BudgetErrorMsg
                                   , ImprestLines."Shortcut Dimension 1 Code", ImprestLines."Shortcut Dimension 2 Code",
                                    Abs(BudgetAvailable - (CommittedAmount + ImprestLines.Amount)), BudgetAvailable - CommittedAmount, ImprestLines.FieldCaption("Shortcut Dimension 1 Code"),
                                    ImprestLines.FieldCaption("Shortcut Dimension 2 Code"))
                                else
                                    ErrorMsg := ErrorMsg + '\' + StrSubstNo(BudgetErrorMsg
                                   , DimValueName[1], DimValueName[2],
                                    Abs(BudgetAvailable - (CommittedAmount + ImprestLines.Amount)), BudgetAvailable - CommittedAmount, ImprestLines.FieldCaption("Shortcut Dimension 1 Code"),
                                    ImprestLines.FieldCaption("Shortcut Dimension 2 Code"));
                                LineError := true;
                            end;
                        Committments.User := CopyStr(UserId, 1, MaxStrLen(Committments.User));
                        Committments."Document No" := ImprestHeader."No.";
                        Committments.No := ImprestLines."Account No";
                        Committments."Line No." := ImprestLines."Line No";
                        Committments."Account Type" := Committments."Account Type"::Customer;
                        Committments."Account No." := ImprestHeader."Account No.";
                        if Customer.Get(ImprestHeader."Account No.") then
                            Committments."Account Name" := Customer.Name;
                        Committments.Description := ImprestLines.Description;
                        Committments."Dimension Set ID" := ImprestLines."Dimension Set ID";
                        GeneralLedgerSetup.Get();
                        GeneralLedgerSetup.TestField("Current Budget");
                        Committments."Budget Code" := GeneralLedgerSetup."Current Budget";
                        //Check whether line is committed.
                        if not LineCommitted(ImprestHeader."No.", ImprestLines."Account No", ImprestLines."Line No") then begin
                            EntryNo := EntryNo + 1;
                            Committments."Entry No" := EntryNo;
                            Committments.Insert();
                            ImprestLines.Committed := true;
                            ImprestLines.Modify();
                            if LineError = false then
                                Message('Items Committed Successfully and the balance is %1',
                                Abs(BudgetAvailable - (CommittedAmount + ImprestLines.Amount)));
                        end;
                    end;
            until ImprestLines.Next() = 0;
        end;
        //CreatePV(ImprestHeader);
    end;

    procedure ImprestSurrenderCommittment(var ImprestHeader: Record Payments; var ErrorMsg: Text)
    var
        CommitmentEntries: Record "Commitment Entries";
        Committments: Record "Commitment Entries";
        Customer: Record Customer;
        GLAccount: Record "G/L Account";
        GenLedSetup: Record "General Ledger Setup";
        ImprestLines: Record "Payment Lines";
        DimMgt: Codeunit DimensionManagement;
        ExceedBudgetErr: Label 'You have Exceeded Budget for %5, %1 ,%6, %2, %7, %8 By %3 Budget Available %4', Comment = '%1 = DimValueName[1], %2 = DimValueName[2], %3 = Abs(BudgetAvailable - (CommittedAmount + (ImprestLines."Actual Spent" - ImprestLines.Amount))), %4 = BudgetAvailable - CommittedAmount, %5 = ImprestLines.FieldCaption("Shortcut Dimension 1 Code"), %6 = ImprestLines.FieldCaption("Shortcut Dimension 2 Code"), %7 = ImprestLines.FieldCaption("Shortcut Dimension 3 Code"), %8 = ImprestLines.FieldCaption("Shortcut Dimension 4 Code");';
        LineError: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        EntryNo: Integer;
        DimValueName: array[8] of Text;
    begin
        ErrorMsg := '';
        /*
        if ImprestHeader.Status<>ImprestHeader.Status::Released then
            Error('The imprest is not fully approved');
        */
        ImprestLines.SetRange(ImprestLines.No, ImprestHeader."No.");
        if ImprestLines.FindFirst() then begin
            if Committments.FindLast() then
                EntryNo := Committments."Entry No";
            repeat
                if IsAccountVotebookEntry(ImprestLines."Account No") then begin
                    Committments.Init();
                    Committments."Commitment No" := ImprestHeader."No.";
                    Committments."Commitment Type" := Committments."Commitment Type"::Commitment;
                    Committments."Document Type" := Committments."Document Type"::"Imprest Surrender";
                    ImprestHeader.TestField(Date);
                    Committments."Commitment Date" := ImprestHeader.Date;
                    Committments."Global Dimension 1 Code" := ImprestLines."Shortcut Dimension 1 Code";
                    Committments."Global Dimension 2 Code" := ImprestLines."Shortcut Dimension 2 Code";
                    Committments.Account := ImprestLines."Account No";
                    Committments."Committed Amount" := ImprestLines."Actual Spent" - ImprestLines.Amount;
                    //Confirm the Amount to be issued does not exceed the budget and amount Committed
                    //Get Budget for the G/L
                    GenLedSetup.Get();
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    GLAccount.SetRange(GLAccount."No.", ImprestLines."Account No");
                    if GenLedSetup."Use Dimensions For Budget" then
                        GLAccount.SetRange(GLAccount."Dimension Set ID Filter", ImprestLines."Dimension Set ID");
                    //Get Dimensions
                    DimMgt.GetShortcutDimensions(ImprestLines."Dimension Set ID", ShortcutDimCode);
                    /*if ShortcutDimCode[1]<>'' then
                    GLAccount.SetRange("Global Dimension 1 Filter",ShortcutDimCode[1]);
                    if ShortcutDimCode[2]<>'' then
                    GLAccount.SetRange("Global Dimension 2 Filter",ShortcutDimCode[2]);
                    if ShortcutDimCode[3]<>'' then
                    GLAccount.SetRange("Shortcut Dimension 3 Filter",ShortcutDimCode[3]);
                    if ShortcutDimCode[4]<>'' then
                    GLAccount.SetRange("Shortcut Dimension 4 Filter",ShortcutDimCode[4]);
                    if ShortcutDimCode[5]<>'' then
                    GLAccount.SetRange("Shortcut Dimension 5 Filter",ShortcutDimCode[5]);
                    if ShortcutDimCode[6]<>'' then
                    GLAccount.SetRange("Shortcut Dimension 6 Filter",ShortcutDimCode[6]);*/
                    FetchDimValue(ImprestLines."Dimension Set ID", ShortcutDimCode, DimValueName);
                    //Get budget amount avaliable
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", ImprestHeader.Date);
                    if GLAccount.Find('-') then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget");
                        BudgetAvailable := GLAccount."Approved Budget" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount := 0;
                    CommitmentEntries.Reset();
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    CommitmentEntries.SetRange(CommitmentEntries.Account, ImprestLines."Account No");
                    if GenLedSetup."Use Dimensions For Budget" then
                        CommitmentEntries.SetRange(CommitmentEntries."Dimension Set ID", ImprestLines."Dimension Set ID");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    if ImprestHeader.Date = 0D then
                        Error('Please insert the imprest date');
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date",
                                               ImprestHeader.Date);
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount := CommitmentEntries."Committed Amount";
                    LineError := false;
                    if LineCommitted(ImprestHeader."No.", ImprestLines."Account No", ImprestLines."Line No") then
                        Message('Line No %1 has been commited', ImprestLines."Line No")
                    else
                        if (CommittedAmount + (ImprestLines."Actual Spent" - ImprestLines.Amount)) > BudgetAvailable then begin
                            if ErrorMsg = '' then
#pragma warning disable AA0131
                                ErrorMsg := StrSubstNo(ExceedBudgetErr
                               , DimValueName[1], DimValueName[2],
                                Abs(BudgetAvailable - (CommittedAmount + (ImprestLines."Actual Spent" - ImprestLines.Amount))), BudgetAvailable - CommittedAmount, ImprestLines.FieldCaption("Shortcut Dimension 1 Code"),
                                ImprestLines.FieldCaption("Shortcut Dimension 2 Code"))
                            else
                                ErrorMsg := ErrorMsg + '\' + StrSubstNo(ExceedBudgetErr
                               , DimValueName[1], DimValueName[2],
                                Abs(BudgetAvailable - (CommittedAmount + (ImprestLines."Actual Spent" - ImprestLines.Amount))), BudgetAvailable - CommittedAmount, ImprestLines.FieldCaption("Shortcut Dimension 1 Code"),
                                ImprestLines.FieldCaption("Shortcut Dimension 2 Code"));
                            LineError := true;
#pragma warning restore AA0131
                        end;
                    Committments.User := CopyStr(UserId, 1, MaxStrLen(Committments.User));
                    Committments."Document No" := ImprestHeader."No.";
                    Committments.No := ImprestLines."Account No";
                    Committments."Line No." := ImprestLines."Line No";
                    Committments."Account Type" := Committments."Account Type"::Customer;
                    Committments."Account No." := ImprestHeader."Account No.";
                    if Customer.Get(ImprestHeader."Account No.") then
                        Committments."Account Name" := Customer.Name;
                    Committments.Description := ImprestLines.Description;
                    Committments."Dimension Set ID" := ImprestLines."Dimension Set ID";
                    GeneralLedgerSetup.Get();
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code" := GeneralLedgerSetup."Current Budget";
                    //Check whether line is committed.
                    if not LineCommitted(ImprestHeader."No.", ImprestLines."Account No", ImprestLines."Line No") and
                     ((ImprestLines."Actual Spent" - ImprestLines.Amount) > 0) then begin
                        EntryNo := EntryNo + 1;
                        Committments."Entry No" := EntryNo;
                        Committments.Insert();
                        ImprestLines.Committed := true;
                        ImprestLines.Modify();
                        if not LineError and ((ImprestLines."Actual Spent" - ImprestLines.Amount) > 0) then
                            Message('Items Committed Successfully and the balance is %1',
                            Abs(BudgetAvailable - (CommittedAmount + ImprestLines."Actual Spent" - ImprestLines.Amount)));
                    end;
                end;
            until ImprestLines.Next() = 0;
        end;
        //CreatePV(ImprestHeader);
    end;

    procedure IsAccountVotebookEntry(GLAccount: Code[20]): Boolean
    var
        CashManagementSetups: Record "General Ledger Setup";
    begin
        /* GLAccountRec.Reset();
        GLAccountRec.SetRange("No.", GLAccount);
        if GLAccountRec.FindFirst() then
            if GLAccountRec."Votebook Entry" then
                exit(true)
            else
                exit(false); */
        CashManagementSetups.Get();
        exit(CashManagementSetups."Check For Commitments");
    end;

    procedure IsClaimOrImprestPayment(ExpType: Code[50]; PayType: Option " ",Receipt,Payment,Imprest,Claim,Advance,Expense,"Petty Cash"): Boolean
    var
        RecTypes: Record "Receipts and Payment Types";
    begin
        if RecTypes.Get(ExpType, PayType) then
            if ((RecTypes."Imprest Payment") or (RecTypes."Claim Payment")) then
                exit(true)
            else
                exit(false);
    end;

    procedure IsMedicalCeilingClaim(ClaimType: Code[50]): Boolean
    var
        ClaimTypes: Record "Receipts and Payment Types";
    begin
        ClaimTypes.Reset();
        ClaimTypes.SetRange(Code, ClaimType);
        ClaimTypes.SetRange(Type, ClaimTypes.Type::"Staff Claim");
        if ClaimTypes.FindFirst() then
            if ClaimTypes."Check Medical Ceiling" then
                exit(true)
            else
                exit(false);
    end;

    procedure LastCommittment(CommittmentNo: Code[20]; No: Code[20]; LineNo: Integer) CommittmentAmt: Decimal
    var
        Committed: Record "Commitment Entries";
    begin
        Committed.Reset();
        Committed.SetRange(Committed."Commitment No", CommittmentNo);
        Committed.SetRange(Committed.No, No);
        Committed.SetRange(Committed."Line No.", LineNo);
        if Committed.FindFirst() then
            exit(Committed."Committed Amount");
    end;

    procedure LineCommitted(CommittmentNo: Code[20]; No: Code[20]; LineNo: Integer) Exists: Boolean
    var
        Committed: Record "Commitment Entries";
    begin
        Exists := false;
        Committed.Reset();
        Committed.SetRange(Committed."Commitment No", CommittmentNo);
        Committed.SetRange(Committed.No, No);
        Committed.SetRange(Committed."Line No.", LineNo);
        if not Committed.IsEmpty() then
            Exists := true;

        // Exists:=FALSE;
        // Committed.RESET;
        // Committed.SETRANGE(Committed."Commitment No",CommittmentNo);
        // Committed.SETRANGE(Committed.No,No);
        // Committed.SETRANGE(Committed."Line No.",LineNo);
        // Committed.SETFILTER(Committed."Commitment Type",'%1|%2',Committed."Commitment Type"::Commitment,Committed."Commitment Type"::"Commitment Reversal");
        // IF Committed.FIND('-') THEN
        //  BEGIN
        //    Committed.CALCSUMS("Committed Amount");
        //    IF Committed."Committed Amount"=0 THEN
        //      Exists:=FALSE
        //    ELSE
        //      Exists:=TRUE;
        //  END;
    end;

    procedure PettyCashCommittment(PettyCash: Record Payments; var ErrorMsg: Text)
    var
        CommitmentEntries: Record "Commitment Entries";
        Committments: Record "Commitment Entries";
        GLAccount: Record "G/L Account";
        GenLedSetup: Record "General Ledger Setup";
        PettyCashLines: Record "Payment Lines";
        DimMgt: Codeunit DimensionManagement;
        LineError: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        EntryNo: Integer;
        DimValueName: array[8] of Text;
    begin
        ErrorMsg := '';
        /*
        if PettyCash.Status<>PettyCash.Status::Released then
            Error('The petty cash voucher is not fully approved');
        */
        PettyCashLines.Reset();
        PettyCashLines.SetRange(No, PettyCash."No.");
        PettyCashLines.SetRange("Account Type", PettyCashLines."Account Type"::"G/L Account");
        if PettyCashLines.FindFirst() then begin
            if Committments.FindLast() then
                EntryNo := Committments."Entry No";
            repeat
                if IsAccountVotebookEntry(PettyCashLines."Account No") then begin
                    Committments.Init();
                    Committments."Commitment No" := PettyCash."No.";
                    Committments."Commitment Type" := Committments."Commitment Type"::Commitment;
                    Committments."Document Type" := Committments."Document Type"::"Petty Cash";
                    PettyCash.TestField(Date);
                    Committments."Commitment Date" := PettyCash.Date;
                    Committments."Dimension Set ID" := PettyCashLines."Dimension Set ID";
                    Committments."Global Dimension 1 Code" := PettyCashLines."Shortcut Dimension 1 Code";
                    Committments."Global Dimension 2 Code" := PettyCashLines."Shortcut Dimension 2 Code";
                    Committments.Account := PettyCashLines."Account No";
                    Committments."Committed Amount" := PettyCashLines.Amount;
                    //Confirm the Amount to be issued does not exceed the budget and amount Committed
                    //Get Budget for the G/L
                    GenLedSetup.Get();
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    GLAccount.SetRange(GLAccount."No.", PettyCashLines."Account No");
                    if GenLedSetup."Use Dimensions For Budget" then
                        GLAccount.SetRange(GLAccount."Dimension Set ID Filter", PettyCashLines."Dimension Set ID");
                    //Get Dimensions
                    DimMgt.GetShortcutDimensions(PettyCashLines."Dimension Set ID", ShortcutDimCode);
                    /*
                    if ShortcutDimCode[1]<>'' then
                    GLAccount.SetRange("Global Dimension 1 Filter",ShortcutDimCode[1]);
                    if ShortcutDimCode[2]<>'' then
                    GLAccount.SetRange("Global Dimension 2 Filter",ShortcutDimCode[2]);
                    if ShortcutDimCode[3]<>'' then
                    GLAccount.SetRange("Shortcut Dimension 3 Filter",ShortcutDimCode[3]);
                    if ShortcutDimCode[4]<>'' then
                    GLAccount.SetRange("Shortcut Dimension 4 Filter",ShortcutDimCode[4]);
                    if ShortcutDimCode[5]<>'' then
                    GLAccount.SetRange("Shortcut Dimension 5 Filter",ShortcutDimCode[5]);
                    if ShortcutDimCode[6]<>'' then
                    GLAccount.SetRange("Shortcut Dimension 6 Filter",ShortcutDimCode[6]);
                    */
                    FetchDimValue(PettyCashLines."Dimension Set ID", ShortcutDimCode, DimValueName);
                    //Get budget amount avaliable
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", GenLedSetup."Current Budget End Date");
                    if GLAccount.Find('-') then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget");
                        BudgetAvailable := GLAccount."Approved Budget" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount := 0;
                    CommitmentEntries.Reset();
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    CommitmentEntries.SetRange(CommitmentEntries.Account, PettyCashLines."Account No");
                    if GenLedSetup."Use Dimensions For Budget" then
                        CommitmentEntries.SetRange(CommitmentEntries."Dimension Set ID", PettyCashLines."Dimension Set ID");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    if PettyCash.Date = 0D then
                        Error('Please insert the petty cash date');
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date",
                                              GenLedSetup."Current Budget End Date");
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount := CommitmentEntries."Committed Amount";
                    LineError := false;
                    if LineCommitted(PettyCash."No.", PettyCashLines."Account No", PettyCashLines."Line No") then
                        Message('Line No %1 has been commited', PettyCashLines."Line No")
                    else
                        if CommittedAmount + PettyCashLines.Amount > BudgetAvailable then begin
                            if ErrorMsg = '' then
                                ErrorMsg := StrSubstNo(BudgetErrorMsg
                               , DimValueName[1], DimValueName[2],
                                Abs(BudgetAvailable - (CommittedAmount + PettyCashLines.Amount)), BudgetAvailable - CommittedAmount, PettyCashLines.FieldCaption("Shortcut Dimension 1 Code"),
                                PettyCashLines.FieldCaption("Shortcut Dimension 2 Code"))
                            else
                                ErrorMsg := ErrorMsg + '\' + StrSubstNo(BudgetErrorMsg
                               , DimValueName[1], DimValueName[2],
                                Abs(BudgetAvailable - (CommittedAmount + PettyCashLines.Amount)), BudgetAvailable - CommittedAmount, PettyCashLines.FieldCaption("Shortcut Dimension 1 Code"),
                                PettyCashLines.FieldCaption("Shortcut Dimension 2 Code"));
                            LineError := true;
                        end;
                    Committments.User := CopyStr(UserId, 1, MaxStrLen(Committments.User));
                    Committments."Document No" := PettyCash."No.";
                    Committments.No := PettyCashLines."Account No";
                    Committments."Line No." := PettyCashLines."Line No";
                    Committments."Account Type" := Committments."Account Type"::Customer;
                    Committments."Account No." := PettyCash."Account No.";
                    if GLAccount.Get(PettyCash."Account No.") then
                        Committments."Account Name" := GLAccount.Name;
                    Committments.Description := PettyCashLines.Description;
                    Committments."Dimension Set ID" := PettyCashLines."Dimension Set ID";
                    GeneralLedgerSetup.Get();
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code" := GeneralLedgerSetup."Current Budget";
                    //Check whether line is committed.
                    if not LineCommitted(PettyCash."No.", PettyCashLines."Account No", PettyCashLines."Line No") then begin
                        EntryNo := EntryNo + 1;
                        Committments."Entry No" := EntryNo;
                        Committments.Insert();
                        PettyCashLines.Committed := true;
                        PettyCashLines.Modify();
                        if not LineError then
                            Message('Items Committed Successfully and the balance is %1',
                            Abs(BudgetAvailable - (CommittedAmount + PettyCashLines.Amount)));
                    end;
                end;
            until PettyCashLines.Next() = 0;
        end;
    end;

    procedure PettyCashSurrenderCommittment(var PCash: Record Payments; var ErrorMsg: Text)
    var
        CommitmentEntries: Record "Commitment Entries";
        Committments: Record "Commitment Entries";
        Customer: Record Customer;
        GLAccount: Record "G/L Account";
        GenLedSetup: Record "General Ledger Setup";
        PCashLines: Record "Payment Lines";
        DimMgt: Codeunit DimensionManagement;
        LineError: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        EntryNo: Integer;
        DimValueName: array[8] of Text;
    begin
        ErrorMsg := '';
        /*
        if ImprestHeader.Status<>ImprestHeader.Status::Released then
            Error('The imprest is not fully approved');
        */
        PCashLines.SetRange(PCashLines.No, PCash."No.");
        if PCashLines.FindFirst() then begin
            if Committments.FindLast() then
                EntryNo := Committments."Entry No";
            repeat
                if IsAccountVotebookEntry(PCashLines."Account No") then begin
                    Committments.Init();
                    Committments."Commitment No" := PCash."No.";
                    Committments."Commitment Type" := Committments."Commitment Type"::Commitment;
                    PCash.TestField(Date);
                    Committments."Commitment Date" := PCash.Date;
                    Committments."Global Dimension 1 Code" := PCashLines."Shortcut Dimension 1 Code";
                    Committments."Global Dimension 2 Code" := PCashLines."Shortcut Dimension 2 Code";
                    Committments.Account := PCashLines."Account No";
                    Committments."Committed Amount" := PCashLines."Actual Spent" - PCashLines.Amount;
                    //Confirm the Amount to be issued does not exceed the budget and amount Committed
                    //Get Budget for the G/L
                    GenLedSetup.Get();
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    GLAccount.SetRange(GLAccount."No.", PCashLines."Account No");
                    if GenLedSetup."Use Dimensions For Budget" then
                        GLAccount.SetRange(GLAccount."Dimension Set ID Filter", PCashLines."Dimension Set ID");
                    //Get Dimensions
                    DimMgt.GetShortcutDimensions(PCashLines."Dimension Set ID", ShortcutDimCode);
                    /*if ShortcutDimCode[1]<>'' then
                    GLAccount.SetRange("Global Dimension 1 Filter",ShortcutDimCode[1]);
                    if ShortcutDimCode[2]<>'' then
                    GLAccount.SetRange("Global Dimension 2 Filter",ShortcutDimCode[2]);
                    if ShortcutDimCode[3]<>'' then
                    GLAccount.SetRange("Shortcut Dimension 3 Filter",ShortcutDimCode[3]);
                    if ShortcutDimCode[4]<>'' then
                    GLAccount.SetRange("Shortcut Dimension 4 Filter",ShortcutDimCode[4]);
                    if ShortcutDimCode[5]<>'' then
                    GLAccount.SetRange("Shortcut Dimension 5 Filter",ShortcutDimCode[5]);
                    if ShortcutDimCode[6]<>'' then
                    GLAccount.SetRange("Shortcut Dimension 6 Filter",ShortcutDimCode[6]);*/
                    FetchDimValue(PCashLines."Dimension Set ID", ShortcutDimCode, DimValueName);
                    //Get budget amount avaliable
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", PCash.Date);
                    if GLAccount.Find('-') then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget");
                        BudgetAvailable := GLAccount."Approved Budget" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount := 0;
                    CommitmentEntries.Reset();
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    CommitmentEntries.SetRange(CommitmentEntries.Account, PCashLines."Account No");
                    if GenLedSetup."Use Dimensions For Budget" then
                        CommitmentEntries.SetRange(CommitmentEntries."Dimension Set ID", PCashLines."Dimension Set ID");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    if PCash.Date = 0D then
                        Error('Please insert the Petty Cash Surrender date');
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date",
                                               PCash.Date);
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount := CommitmentEntries."Committed Amount";
                    LineError := false;
                    if LineCommitted(PCash."No.", PCashLines."Account No", PCashLines."Line No") then
                        Message('Line No %1 has been commited', PCashLines."Line No")
                    else
                        if (CommittedAmount + (PCashLines."Actual Spent" - PCashLines.Amount)) > BudgetAvailable then begin
                            if ErrorMsg = '' then
                                ErrorMsg := StrSubstNo(BudgetErrorMsg
                                , DimValueName[1], DimValueName[2],
                                Abs(BudgetAvailable - (CommittedAmount + PCashLines.Amount)), BudgetAvailable - CommittedAmount, PCashLines.FieldCaption("Shortcut Dimension 1 Code"),
                                PCashLines.FieldCaption("Shortcut Dimension 2 Code"))
                            else
                                ErrorMsg := ErrorMsg + '\' + StrSubstNo(BudgetErrorMsg
                                , DimValueName[1], DimValueName[2],
                                 Abs(BudgetAvailable - (CommittedAmount + PCashLines.Amount)), BudgetAvailable - CommittedAmount, PCashLines.FieldCaption("Shortcut Dimension 1 Code"),
                                PCashLines.FieldCaption("Shortcut Dimension 2 Code"));
                            LineError := true;
                        end;
                    Committments.User := CopyStr(UserId, 1, MaxStrLen(Committments.User));
                    Committments."Document No" := PCash."No.";
                    Committments.No := PCashLines."Account No";
                    Committments."Line No." := PCashLines."Line No";
                    Committments."Account Type" := Committments."Account Type"::Customer;
                    Committments."Account No." := PCash."Account No.";
                    if Customer.Get(PCash."Account No.") then
                        Committments."Account Name" := Customer.Name;
                    CommitmentEntries.Description := PCashLines.Description;
                    CommitmentEntries."Dimension Set ID" := PCashLines."Dimension Set ID";
                    GeneralLedgerSetup.Get();
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code" := GeneralLedgerSetup."Current Budget";
                    //Check whether line is committed.
                    if not LineCommitted(PCash."No.", PCashLines."Account No", PCashLines."Line No") and
                     ((PCashLines."Actual Spent" - PCashLines.Amount) > 0) then begin
                        EntryNo := EntryNo + 1;
                        Committments."Entry No" := EntryNo;
                        Committments.Insert();
                        PCashLines.Committed := true;
                        PCashLines.Modify();
                        if not LineError and ((PCashLines."Actual Spent" - PCashLines.Amount) > 0) then
                            Message('Items Committed Successfully and the balance is %1',
                            Abs(BudgetAvailable - (CommittedAmount + PCashLines."Actual Spent" - PCashLines.Amount)));
                    end;
                end;
            until PCashLines.Next() = 0;
        end;
        //CreatePV(ImprestHeader);
    end;

    procedure PVCommittment(PV: Record Payments; var ErrorMsg: Text)
    var
        CommitmentEntries: Record "Commitment Entries";
        Committments: Record "Commitment Entries";
        GLAccount: Record "G/L Account";
        GenLedSetup: Record "General Ledger Setup";
        PVLines: Record "Payment Lines";
        DimMgt: Codeunit DimensionManagement;
        LineError: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        EntryNo: Integer;
        DimValueName: array[8] of Text;
    begin
        ErrorMsg := '';
        PVLines.Reset();
        PVLines.SetRange(No, PV."No.");
        PVLines.SetRange("Account Type", PVLines."Account Type"::"G/L Account");
        if PVLines.FindFirst() then begin
            if Committments.FindLast() then
                EntryNo := Committments."Entry No";

            repeat
                if not IsClaimOrImprestPayment(PVLines."Expenditure Type", 2) then
                    if IsAccountVotebookEntry(PVLines."Account No") then begin
                        Committments.Init();
                        Committments."Commitment No" := PV."No.";
                        Committments."Commitment Type" := Committments."Commitment Type"::Commitment;
                        PV.TestField(Date);
                        Committments."Commitment Date" := PV.Date;
                        Committments."Dimension Set ID" := PVLines."Dimension Set ID";
                        Committments."Global Dimension 1 Code" := PVLines."Shortcut Dimension 1 Code";
                        Committments."Global Dimension 2 Code" := PVLines."Shortcut Dimension 2 Code";
                        Committments.Account := PVLines."Account No";
                        Committments."Committed Amount" := PVLines.Amount;
                        //Confirm the Amount to be issued does not exceed the budget and amount Committed
                        //Get Budget for the G/L
                        GenLedSetup.Get();
                        GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                        GLAccount.SetRange(GLAccount."No.", PVLines."Account No");
                        if GenLedSetup."Use Dimensions For Budget" then
                            GLAccount.SetRange(GLAccount."Dimension Set ID Filter", PVLines."Dimension Set ID");
                        //Get Dimensions
                        DimMgt.GetShortcutDimensions(PVLines."Dimension Set ID", ShortcutDimCode);
                        /*
                        if ShortcutDimCode[1]<>'' then
                        GLAccount.SetRange("Global Dimension 1 Filter",ShortcutDimCode[1]);
                        if ShortcutDimCode[2]<>'' then
                        GLAccount.SetRange("Global Dimension 2 Filter",ShortcutDimCode[2]);
                        if ShortcutDimCode[3]<>'' then
                        GLAccount.SetRange("Shortcut Dimension 3 Filter",ShortcutDimCode[3]);
                        if ShortcutDimCode[4]<>'' then
                        GLAccount.SetRange("Shortcut Dimension 4 Filter",ShortcutDimCode[4]);
                        if ShortcutDimCode[5]<>'' then
                        GLAccount.SetRange("Shortcut Dimension 5 Filter",ShortcutDimCode[5]);
                        if ShortcutDimCode[6]<>'' then
                        GLAccount.SetRange("Shortcut Dimension 6 Filter",ShortcutDimCode[6]);
                        */
                        FetchDimValue(PVLines."Dimension Set ID", ShortcutDimCode, DimValueName);
                        //Get budget amount avaliable
                        GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", PV.Date);
                        if GLAccount.Find('-') then begin
                            GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget", Encumberance);
                            BudgetAvailable := GLAccount."Approved Budget" - (GLAccount."Net Change");//+GLAccount.Encumberance);
                        end;
                        //Get committed Amount
                        CommittedAmount := 0;
                        CommitmentEntries.Reset();
                        CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                        CommitmentEntries.SetRange(CommitmentEntries.Account, PVLines."Account No");
                        if GenLedSetup."Use Dimensions For Budget" then
                            CommitmentEntries.SetRange(CommitmentEntries."Dimension Set ID", PVLines."Dimension Set ID");
                        CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                        if PV.Date = 0D then
                            Error('Please insert the pv date');
                        CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date",
                                                   PV.Date);
                        CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                        CommittedAmount := CommitmentEntries."Committed Amount";
                        LineError := false;
                        if LineCommitted(PV."No.", PVLines."Account No", PVLines."Line No") then
                            Message('Line No %1 has been commited', PVLines."Line No")
                        else
                            if CommittedAmount + PVLines.Amount > BudgetAvailable then begin
                                if ErrorMsg = '' then
                                    ErrorMsg := StrSubstNo(BudgetErrorMsg
                                   , DimValueName[1], DimValueName[2],
                                    Abs(BudgetAvailable - (CommittedAmount + PVLines.Amount)), BudgetAvailable - CommittedAmount, PVLines.FieldCaption("Shortcut Dimension 1 Code"),
                                    PVLines.FieldCaption("Shortcut Dimension 2 Code"))
                                else
                                    ErrorMsg := ErrorMsg + '\' + StrSubstNo(BudgetErrorMsg
                                   , DimValueName[1], DimValueName[2],
                                    Abs(BudgetAvailable - (CommittedAmount + PVLines.Amount)), BudgetAvailable - CommittedAmount, PVLines.FieldCaption("Shortcut Dimension 1 Code"),
                                    PVLines.FieldCaption("Shortcut Dimension 2 Code"));
                                LineError := true;
                            end;
                        Committments.User := CopyStr(UserId, 1, MaxStrLen(Committments.User));
                        Committments."Document No" := PV."No.";
                        Committments.No := PVLines."Account No";
                        Committments."Line No." := PVLines."Line No";
                        Committments."Account Type" := Committments."Account Type"::Customer;
                        Committments."Account No." := PV."Account No.";
                        if GLAccount.Get(PV."Account No.") then
                            Committments."Account Name" := GLAccount.Name;
                        Committments.Description := PVLines.Description;
                        Committments."Dimension Set ID" := PVLines."Dimension Set ID";
                        Committments."Document Type" := Committments."Document Type"::"Payment Voucher";
                        GeneralLedgerSetup.Get();
                        GeneralLedgerSetup.TestField("Current Budget");
                        Committments."Budget Code" := GeneralLedgerSetup."Current Budget";
                        //Check whether line is committed.
                        if not LineCommitted(PV."No.", PVLines."Account No", PVLines."Line No") then begin
                            EntryNo := EntryNo + 1;
                            Committments."Entry No" := EntryNo;
                            Committments.Insert();
                            PVLines.Committed := true;
                            PVLines.Modify();
                            if not LineError then
                                Message('Items Committed Successfully and the balance is %1',
                                Abs(BudgetAvailable - (CommittedAmount + PVLines.Amount)));
                        end;
                    end;
            until PVLines.Next() = 0;
        end;
    end;

    procedure ReverseImprestCommittment(var ImprestHeader: Record Payments)
    var
        Committment: Record "Commitment Entries";
        ImprestLine: Record "Payment Lines";
        EntryNo: Integer;
    begin
        if Confirm('Are you sure you want to reverse the committed entries for Imprest no ' + ImprestHeader."No." + '?', false) = true then begin
            Committment.Reset();
            Committment.SetRange(Committment."Commitment No", ImprestHeader."No.");
            if Committment.Find('-') then
                Committment.DeleteAll();
            ImprestLine.Reset();
            ImprestLine.SetRange(ImprestLine.No, ImprestHeader."No.");
            if ImprestLine.FindFirst() then begin
                if Committment.FindLast() then
                    EntryNo := Committment."Entry No";
                repeat
                    //Insert reversal entries into the committment table
                    if LineCommitted(ImprestHeader."No.", ImprestLine."Account No", ImprestLine."Line No") then begin
                        Committment.Init();
                        Committment."Commitment No" := ImprestHeader."No.";
                        Committment."Commitment Type" := Committment."Commitment Type"::"Commitment Reversal";
                        Committment."Document Type" := Committment."Document Type"::Imprest;
                        Committment."Commitment Date" := ImprestHeader.Date;
                        Committment."Dimension Set ID" := ImprestHeader."Dimension Set ID";
                        Committment."Global Dimension 1 Code" := ImprestLine."Shortcut Dimension 1 Code";
                        Committment."Global Dimension 2 Code" := ImprestLine."Shortcut Dimension 2 Code";
                        Committment."Dimension Set ID" := ImprestLine."Dimension Set ID";
                        Committment.Account := ImprestLine."Account No";
                        Committment."Committed Amount" := -ImprestLine.Amount;
                        Committment.User := CopyStr(UserId, 1, MaxStrLen(Committment.User));
                        Committment."Document No" := ImprestHeader."No.";
                        Committment.No := ImprestLine."Account No";
                        Committment."Line No." := ImprestLine."Line No";
                        GeneralLedgerSetup.Get();
                        GeneralLedgerSetup.TestField("Current Budget");
                        Committment."Budget Code" := CopyStr(GetCommittedBudget(ImprestHeader."No."), 1, MaxStrLen(Committment."Budget Code"));
                        EntryNo := EntryNo + 1;
                        Committment."Entry No" := EntryNo;
                        Committment.Insert();
                        //Mark imprest lines entries as uncommited
                        ImprestLine.Committed := false;
                        ImprestLine.Modify();
                    end;
                until ImprestLine.Next() = 0;
            end;
            Message('Committed entries for Imprest No %1 Have been reversed Successfully', ImprestHeader."No.");
        end;
    end;

    procedure ReversePettyCashCommittment(var PettyCash: Record Payments)
    var
        Committment: Record "Commitment Entries";
        PettyCashLine: Record "Payment Lines";
        EntryNo: Integer;
    begin
        if Confirm('Are you sure you want to reverse the committed entries for Petty Cash no ' + PettyCash."No." + '?', false) = true then begin
            Committment.Reset();
            Committment.SetRange(Committment."Commitment No", PettyCash."No.");
            if Committment.Find('-') then
                Committment.DeleteAll();
            PettyCashLine.Reset();
            PettyCashLine.SetRange(No, PettyCash."No.");
            if PettyCashLine.FindFirst() then begin
                if Committment.FindLast() then
                    EntryNo := Committment."Entry No";
                repeat
                    //Insert reversal entries into the committment table
                    if LineCommitted(PettyCash."No.", PettyCashLine."Account No", PettyCashLine."Line No") then begin
                        Committment.Init();
                        Committment."Commitment No" := PettyCash."No.";
                        Committment."Commitment Type" := Committment."Commitment Type"::"Commitment Reversal";
                        Committment."Document Type" := Committment."Document Type"::"Petty Cash";
                        Committment."Commitment Date" := PettyCash.Date;
                        Committment."Dimension Set ID" := PettyCashLine."Dimension Set ID";
                        Committment."Global Dimension 1 Code" := PettyCashLine."Shortcut Dimension 1 Code";
                        Committment."Global Dimension 2 Code" := PettyCashLine."Shortcut Dimension 2 Code";
                        Committment.Account := PettyCashLine."Account No";
                        Committment."Committed Amount" := -PettyCashLine.Amount;
                        Committment.User := CopyStr(UserId, 1, MaxStrLen(Committment.User));
                        Committment."Document No" := PettyCash."No.";
                        Committment.No := PettyCashLine."Account No";
                        Committment."Line No." := PettyCashLine."Line No";
                        EntryNo := EntryNo + 1;
                        Committment."Entry No" := EntryNo;
                        GeneralLedgerSetup.Get();
                        GeneralLedgerSetup.TestField("Current Budget");
                        Committment."Budget Code" := CopyStr(GetCommittedBudget(PettyCash."No."), 1, MaxStrLen(Committment."Budget Code"));
                        Committment.Insert();
                        //Mark imprest lines entries as uncommited
                        PettyCashLine.Committed := false;
                        PettyCashLine.Modify();
                    end;
                until PettyCashLine.Next() = 0;
            end;
            Message('Committed entries for Petty Cash No %1 Have been reversed Successfully', PettyCash."No.");
        end;
    end;

    procedure ReversePVCommittment(var PV: Record Payments)
    var
        Committment: Record "Commitment Entries";
        PVLines: Record "Payment Lines";
        EntryNo: Integer;
    begin
        if Confirm('Are you sure you want to reverse the committed entries for PV no ' + PV."No." + '?', false) = true then begin
            Committment.Reset();
            Committment.SetRange(Committment."Commitment No", PV."No.");
            if Committment.Find('-') then
                Committment.DeleteAll();
            PVLines.Reset();
            PVLines.SetRange(No, PV."No.");
            if PVLines.FindFirst() then begin
                if Committment.FindLast() then
                    EntryNo := Committment."Entry No";
                repeat
                    //Insert reversal entries into the committment table
                    if LineCommitted(PV."No.", PVLines."Account No", PVLines."Line No") then begin
                        Committment.Init();
                        Committment."Commitment No" := PV."No.";
                        Committment."Commitment Type" := Committment."Commitment Type"::"Commitment Reversal";
                        Committment."Commitment Date" := PV.Date;
                        Committment."Dimension Set ID" := PVLines."Dimension Set ID";
                        Committment."Global Dimension 1 Code" := PVLines."Shortcut Dimension 1 Code";
                        Committment."Global Dimension 2 Code" := PVLines."Shortcut Dimension 2 Code";
                        Committment."Dimension Set ID" := PVLines."Dimension Set ID";
                        Committment.Account := PVLines."Account No";
                        Committment."Committed Amount" := -PVLines.Amount;
                        Committment.User := CopyStr(UserId, 1, MaxStrLen(Committment.User));
                        Committment."Document No" := PV."No.";
                        Committment.No := PVLines."Account No";
                        Committment."Line No." := PVLines."Line No";
                        EntryNo := EntryNo + 1;
                        Committment."Document Type" := Committment."Document Type"::"Payment Voucher";
                        Committment."Entry No" := EntryNo;
                        GeneralLedgerSetup.Get();
                        GeneralLedgerSetup.TestField("Current Budget");
                        Committment."Budget Code" := CopyStr(GetCommittedBudget(PV."No."), 1, MaxStrLen(Committment."Budget Code"));
                        Committment.Insert();
                        //Mark imprest lines entries as uncommited
                        PVLines.Committed := false;
                        PVLines.Modify();
                    end;
                until PVLines.Next() = 0;
            end;
            //MESSAGE('Committed entries for Petty Cash No %1 Have been reversed Successfully',PV."No.");
        end;
    end;

    procedure ReverseStaffClaimCommittment(Claim: Record Payments)
    var
        CommitmentEntries: Record "Commitment Entries";
        Committments: Record "Commitment Entries";
        GLAccount: Record "G/L Account";
        ClaimLines: Record "Payment Lines";
        EntryNo: Integer;
    begin
        ClaimLines.Reset();
        ClaimLines.SetRange(No, Claim."No.");
        ClaimLines.SetRange("Account Type", ClaimLines."Account Type"::"G/L Account");
        if ClaimLines.FindSet() then begin
            if Committments.FindLast() then
                EntryNo := Committments."Entry No";
            repeat
                if LineCommitted(Claim."No.", ClaimLines."Account No", ClaimLines."Line No") then begin
                    Committments.Init();
                    Committments."Commitment No" := Claim."No.";
                    Committments."Commitment Type" := Committments."Commitment Type"::"Commitment Reversal";
                    Committments."Document Type" := Committments."Document Type"::"Staff Claim";
                    Claim.TestField(Date);
                    Committments."Commitment Date" := Today;
                    Committments."Uncommittment Date" := Today;
                    Committments."Dimension Set ID" := ClaimLines."Dimension Set ID";
                    Committments."Global Dimension 1 Code" := ClaimLines."Shortcut Dimension 1 Code";
                    Committments."Global Dimension 2 Code" := ClaimLines."Shortcut Dimension 2 Code";
                    Committments.Account := ClaimLines."Account No";
                    Committments."Committed Amount" := -ClaimLines.Amount;
                    Committments.User := CopyStr(UserId, 1, MaxStrLen(Committments.User));
                    Committments."Document No" := Claim."No.";
                    Committments.No := ClaimLines."Account No";
                    Committments."Line No." := ClaimLines."Line No";
                    Committments."Account Type" := Committments."Account Type"::Customer;
                    Committments."Account No." := Claim."Account No.";
                    if GLAccount.Get(Claim."Account No.") then
                        Committments."Account Name" := GLAccount.Name;
                    CommitmentEntries.Description := ClaimLines.Description;
                    CommitmentEntries."Dimension Set ID" := ClaimLines."Dimension Set ID";
                    EntryNo := EntryNo + 1;
                    Committments."Entry No" := EntryNo;
                    GeneralLedgerSetup.Get();
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code" := CopyStr(GetCommittedBudget(Claim."No."), 1, MaxStrLen(Committments."Budget Code"));
                    Committments.Insert();
                end;
            until ClaimLines.Next() = 0;
        end;
    end;

    procedure StaffClaimCommittment(Claim: Record Payments; var ErrorMsg: Text)
    var
        CommitmentEntries: Record "Commitment Entries";
        Committments: Record "Commitment Entries";
        GLAccount: Record "G/L Account";
        GenLedSetup: Record "General Ledger Setup";
        ClaimLines: Record "Payment Lines";
        DimMgt: Codeunit DimensionManagement;
        LineError: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        EntryNo: Integer;
        DimValueName: array[8] of Text;
    begin
        ErrorMsg := '';
        /*
        if PettyCash.Status<>PettyCash.Status::Released then
            Error('The petty cash voucher is not fully approved');
        */
        ClaimLines.Reset();
        ClaimLines.SetRange(No, Claim."No.");
        ClaimLines.SetRange("Account Type", ClaimLines."Account Type"::"G/L Account");
        if ClaimLines.FindFirst() then begin
            if Committments.FindLast() then
                EntryNo := Committments."Entry No";
            repeat
                //Check if not Medical ceiling claim
                if not IsMedicalCeilingClaim(ClaimLines."Expenditure Type") then
                    if IsAccountVotebookEntry(ClaimLines."Account No") then
                        if CheckImprestCostOfSales(ClaimLines."Account No", ClaimLines."Expenditure Type") = false then begin
                            Committments.Init();
                            Committments."Commitment No" := Claim."No.";
                            Committments."Commitment Type" := Committments."Commitment Type"::Commitment;
                            Committments."Document Type" := Committments."Document Type"::"Staff Claim";
                            Claim.TestField(Date);
                            Committments."Commitment Date" := Claim.Date;
                            Committments."Dimension Set ID" := ClaimLines."Dimension Set ID";
                            Committments."Global Dimension 1 Code" := ClaimLines."Shortcut Dimension 1 Code";
                            Committments."Global Dimension 2 Code" := ClaimLines."Shortcut Dimension 2 Code";
                            Committments.Account := ClaimLines."Account No";
                            Committments."Committed Amount" := ClaimLines.Amount;
                            //Confirm the Amount to be issued does not exceed the budget and amount Committed
                            //Get Budget for the G/L
                            GenLedSetup.Get();
                            GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                            GLAccount.SetRange(GLAccount."No.", ClaimLines."Account No");
                            if GenLedSetup."Use Dimensions For Budget" then
                                GLAccount.SetRange(GLAccount."Dimension Set ID Filter", ClaimLines."Dimension Set ID");
                            //Get Dimensions
                            DimMgt.GetShortcutDimensions(ClaimLines."Dimension Set ID", ShortcutDimCode);
                            /*
                            if ShortcutDimCode[1]<>'' then
                            GLAccount.SetRange("Global Dimension 1 Filter",ShortcutDimCode[1]);
                            if ShortcutDimCode[2]<>'' then
                            GLAccount.SetRange("Global Dimension 2 Filter",ShortcutDimCode[2]);
                            if ShortcutDimCode[3]<>'' then
                            GLAccount.SetRange("Shortcut Dimension 3 Filter",ShortcutDimCode[3]);
                            if ShortcutDimCode[4]<>'' then
                            GLAccount.SetRange("Shortcut Dimension 4 Filter",ShortcutDimCode[4]);
                            if ShortcutDimCode[5]<>'' then
                            GLAccount.SetRange("Shortcut Dimension 5 Filter",ShortcutDimCode[5]);
                            if ShortcutDimCode[6]<>'' then
                            GLAccount.SetRange("Shortcut Dimension 6 Filter",ShortcutDimCode[6]);
                            */
                            FetchDimValue(ClaimLines."Dimension Set ID", ShortcutDimCode, DimValueName);
                            //Get budget amount avaliable
                            GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", Claim.Date);
                            if GLAccount.Find('-') then begin
                                GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget");
                                BudgetAvailable := GLAccount."Approved Budget" - GLAccount."Net Change";
                            end;
                            //Get committed Amount
                            CommittedAmount := 0;
                            CommitmentEntries.Reset();
                            CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                            CommitmentEntries.SetRange(CommitmentEntries.Account, ClaimLines."Account No");
                            if GenLedSetup."Use Dimensions For Budget" then
                                CommitmentEntries.SetRange(CommitmentEntries."Dimension Set ID", ClaimLines."Dimension Set ID");
                            CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                            if Claim.Date = 0D then
                                Error('Please insert the petty cash date');
                            CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date",
                                                       Claim.Date);
                            CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                            CommittedAmount := CommitmentEntries."Committed Amount";
                            LineError := false;
                            if LineCommitted(Claim."No.", ClaimLines."Account No", ClaimLines."Line No") then
                                Message('Line No %1 has been committed', ClaimLines."Line No")
                            else
                                if CommittedAmount + ClaimLines.Amount > BudgetAvailable then begin
                                    if ErrorMsg = '' then
                                        ErrorMsg := StrSubstNo(BudgetErrorMsg
                                       , DimValueName[1], DimValueName[2],
                                        Abs(BudgetAvailable - (CommittedAmount + ClaimLines.Amount)), BudgetAvailable - CommittedAmount, ClaimLines.FieldCaption("Shortcut Dimension 1 Code"),
                                        ClaimLines.FieldCaption("Shortcut Dimension 2 Code"))
                                    else
                                        ErrorMsg := ErrorMsg + '\' + StrSubstNo(BudgetErrorMsg
                                       , DimValueName[1], DimValueName[2],
                                        Abs(BudgetAvailable - (CommittedAmount + ClaimLines.Amount)), BudgetAvailable - CommittedAmount, ClaimLines.FieldCaption("Shortcut Dimension 1 Code"),
                                        ClaimLines.FieldCaption("Shortcut Dimension 2 Code"));
                                    LineError := true;
                                end;
                            Committments.User := CopyStr(UserId, 1, MaxStrLen(Committments.User));
                            Committments."Document No" := Claim."No.";
                            Committments.No := ClaimLines."Account No";
                            Committments."Line No." := ClaimLines."Line No";
                            Committments."Account Type" := Committments."Account Type"::Customer;
                            Committments."Account No." := Claim."Account No.";
                            if GLAccount.Get(Claim."Account No.") then
                                Committments."Account Name" := GLAccount.Name;
                            CommitmentEntries.Description := ClaimLines.Description;
                            CommitmentEntries."Dimension Set ID" := ClaimLines."Dimension Set ID";
                            GeneralLedgerSetup.Get();
                            GeneralLedgerSetup.TestField("Current Budget");
                            Committments."Budget Code" := GeneralLedgerSetup."Current Budget";
                            //Check whether line is committed.
                            if not LineCommitted(Claim."No.", ClaimLines."Account No", ClaimLines."Line No") then begin
                                EntryNo := EntryNo + 1;
                                Committments."Entry No" := EntryNo;
                                Committments.Insert();
                                ClaimLines.Committed := true;
                                ClaimLines.Modify();
                                if not LineError then
                                    Message('Items Committed Successfully and the balance is %1',
                                    Abs(BudgetAvailable - (CommittedAmount + ClaimLines.Amount)));
                            end;
                        end;
            until ClaimLines.Next() = 0;
        end;
    end;

    procedure UncommitImprest(var ImprestHeader: Record Payments)
    var
        Committments: Record "Commitment Entries";
        Customer: Record Customer;
        ImprestLines: Record "Payment Lines";
        EntryNo: Integer;
    begin
        ImprestLines.SetRange(ImprestLines.No, ImprestHeader."No.");
        if ImprestLines.FindSet() then begin
            if Committments.FindLast() then
                EntryNo := Committments."Entry No";
            Committments.Reset();
            Committments.SetRange(Committments."Commitment No", ImprestHeader."No.");
            Committments.SetRange(Committments."Commitment Type", Committments."Commitment Type"::Commitment);
            if Committments.Find('-') then
                UncommittmentDate := Committments."Commitment Date";
            repeat
                if LineCommitted(ImprestHeader."No.", ImprestLines."Account No", ImprestLines."Line No") then begin
                    Committments.Init();
                    Committments."Commitment No" := ImprestHeader."No.";
                    Committments."Commitment Type" := Committments."Commitment Type"::"Commitment Reversal";
                    Committments."Document Type" := Committments."Document Type"::Imprest;
                    //Insert same Commitment Date
                    Committments."Commitment Date" := UncommittmentDate;
                    Committments."Uncommittment Date" := ImprestHeader.Date;
                    Committments."Dimension Set ID" := ImprestHeader."Dimension Set ID";
                    Committments."Global Dimension 1 Code" := ImprestLines."Shortcut Dimension 1 Code";
                    Committments."Global Dimension 2 Code" := ImprestLines."Shortcut Dimension 2 Code";
                    Committments.Account := ImprestLines."Account No";
                    Committments."Committed Amount" := -LastCommittment(ImprestHeader."No.", ImprestLines."Account No", ImprestLines."Line No");
                    Committments.User := CopyStr(UserId, 1, MaxStrLen(Committments.User));
                    Committments."Document No" := ImprestHeader."No.";
                    Committments.No := ImprestLines."Account No";
                    Committments."Line No." := ImprestLines."Line No";
                    Committments."Dimension Set ID" := ImprestLines."Dimension Set ID";
                    Committments."Account Type" := Committments."Account Type"::Customer;
                    Committments."Account No." := ImprestHeader."Account No.";
                    if Customer.Get(ImprestHeader."Account No.") then
                        Committments."Account Name" := Customer.Name;
                    Committments.Description := ImprestLines.Description;
                    Committments."Dimension Set ID" := ImprestLines."Dimension Set ID";
                    EntryNo := EntryNo + 1;
                    Committments."Entry No" := EntryNo;
                    GeneralLedgerSetup.Get();
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code" := CopyStr(GetCommittedBudget(ImprestHeader."No."), 1, MaxStrLen(Committments."Budget Code"));
                    Committments.Insert();
                end;
            until ImprestLines.Next() = 0;
        end;
    end;

    procedure UncommitPettyCash(var PettyCash: Record Payments)
    var
        Committments: Record "Commitment Entries";
        PettyCashLines: Record "Payment Lines";
        EntryNo: Integer;
    begin
        PettyCashLines.SetRange(No, PettyCash."No.");
        if PettyCashLines.FindSet() then begin
            if Committments.FindLast() then
                EntryNo := Committments."Entry No";
            Committments.Reset();
            Committments.SetRange(Committments."Commitment No", PettyCash."No.");
            Committments.SetRange(Committments."Commitment Type", Committments."Commitment Type"::Commitment);
            if Committments.Find('-') then
                UncommittmentDate := Committments."Commitment Date";
            repeat
                if LineCommitted(PettyCash."No.", PettyCashLines."Account No", PettyCashLines."Line No") then begin
                    Committments.Init();
                    Committments."Commitment No" := PettyCash."No.";
                    Committments."Commitment Type" := Committments."Commitment Type"::"Commitment Reversal";
                    Committments."Document Type" := Committments."Document Type"::"Petty Cash";
                    //Insert same Commitment Date
                    Committments."Commitment Date" := UncommittmentDate;
                    Committments."Uncommittment Date" := PettyCash.Date;
                    Committments."Dimension Set ID" := PettyCash."Dimension Set ID";
                    Committments."Global Dimension 1 Code" := PettyCashLines."Shortcut Dimension 1 Code";
                    Committments."Global Dimension 2 Code" := PettyCashLines."Shortcut Dimension 2 Code";
                    Committments."Dimension Set ID" := PettyCash."Dimension Set ID";
                    Committments.Account := PettyCashLines."Account No";
                    Committments."Committed Amount" := -LastCommittment(PettyCash."No.", PettyCashLines."Account No", PettyCashLines."Line No");
                    Committments.User := CopyStr(UserId, 1, MaxStrLen(Committments.User));
                    Committments."Document No" := PettyCash."No.";
                    Committments.No := PettyCashLines."Account No";
                    Committments."Line No." := PettyCashLines."Line No";
                    EntryNo := EntryNo + 1;
                    Committments."Entry No" := EntryNo;
                    GeneralLedgerSetup.Get();
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code" := CopyStr(GetCommittedBudget(PettyCash."No."), 1, MaxStrLen(Committments."Budget Code"));
                    Committments.Insert();
                end;
            until PettyCashLines.Next() = 0;
        end;
    end;

    procedure UncommitPurchInvoice(var IR: Record "Purchase Header")
    var
        Committments: Record "Commitment Entries";
        IRLine: Record "Purchase Line";
        EntryNo: Integer;
    begin
        if Committments.FindLast() then
            EntryNo := Committments."Entry No";
        EntryNo := EntryNo + 1;
        IRLine.Reset();
        IRLine.SetRange("Document No.", IR."No.");
        IRLine.SetRange("Document Type", IR."Document Type");
        if IRLine.FindSet() then
            repeat
                Committments.Init();
                Committments."Commitment No" := IRLine."Document No.";
                Committments."Commitment Type" := Committments."Commitment Type"::"Commitment Reversal";
                //Insert same Commitment Date
                Committments."Commitment Date" := UncommittmentDate;
                Committments."Uncommittment Date" := IR."Posting Date";
                Committments."Dimension Set ID" := IR."Dimension Set ID";
                Committments."Global Dimension 1 Code" := IRLine."Shortcut Dimension 1 Code";
                Committments."Global Dimension 2 Code" := IRLine."Shortcut Dimension 2 Code";
                Committments."Dimension Set ID" := IR."Dimension Set ID";
                Committments.Account := IRLine."No.";
                Committments."Committed Amount" := -IRLine."Qty. to Receive" * IRLine."Direct Unit Cost";
                Committments.User := CopyStr(UserId, 1, MaxStrLen(Committments.User));
                Committments."Document No" := IR."No.";
                Committments.No := IRLine."No.";
                Committments."Line No." := IRLine."Line No.";
                Committments."Entry No" := EntryNo;
                GeneralLedgerSetup.Get();
                GeneralLedgerSetup.TestField("Current Budget");
                Committments."Budget Code" := CopyStr(GetCommittedBudget(IRLine."Document No."), 1, MaxStrLen(Committments."Budget Code"));
                Committments.Insert();
                EntryNo := EntryNo + 1;
            until IRLine.Next() = 0;
    end;

    procedure UncommitPV(var PV: Record Payments)
    var
        Committments: Record "Commitment Entries";
        PVLines: Record "Payment Lines";
        EntryNo: Integer;
    begin
        PVLines.SetRange(No, PV."No.");
        if PVLines.FindSet() then begin
            if Committments.FindLast() then
                EntryNo := Committments."Entry No";
            Committments.Reset();
            Committments.SetRange(Committments."Commitment No", PV."No.");
            Committments.SetRange(Committments."Commitment Type", Committments."Commitment Type"::Commitment);
            if Committments.Find('-') then
                UncommittmentDate := Committments."Commitment Date";
            repeat
                if LineCommitted(PV."No.", PVLines."Account No", PVLines."Line No") then begin
                    Committments.Init();
                    Committments."Commitment No" := PV."No.";
                    Committments."Commitment Type" := Committments."Commitment Type"::"Commitment Reversal";
                    Committments."Document Type" := Committments."Document Type"::"Payment Voucher";
                    //Insert same Commitment Date
                    Committments."Commitment Date" := UncommittmentDate;
                    Committments."Uncommittment Date" := PV.Date;
                    Committments."Dimension Set ID" := PV."Dimension Set ID";
                    Committments."Global Dimension 1 Code" := PVLines."Shortcut Dimension 1 Code";
                    Committments."Global Dimension 2 Code" := PVLines."Shortcut Dimension 2 Code";
                    Committments."Dimension Set ID" := PVLines."Dimension Set ID";
                    Committments.Account := PVLines."Account No";
                    Committments."Committed Amount" := -LastCommittment(PV."No.", PVLines."Account No", PVLines."Line No");
                    Committments.User := CopyStr(UserId, 1, MaxStrLen(Committments.User));
                    Committments."Document No" := PV."No.";
                    Committments.No := PVLines."Account No";
                    Committments."Line No." := PVLines."Line No";
                    EntryNo := EntryNo + 1;
                    Committments."Entry No" := EntryNo;
                    GeneralLedgerSetup.Get();
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code" := CopyStr(GetCommittedBudget(PV."No."), 1, MaxStrLen(Committments."Budget Code"));
                    Committments.Insert();
                end;
            until PVLines.Next() = 0;
        end;
    end;

    procedure UnencumberImprest(var ImprestHeader: Record Payments)
    var
        Committments: Record "Commitment Entries";
        ImprestLines: Record "Payment Lines";
        EntryNo: Integer;
    begin
        ImprestLines.SetRange(ImprestLines.No, ImprestHeader."No.");
        if ImprestLines.FindSet() then begin
            if Committments.FindLast() then
                EntryNo := Committments."Entry No";
            Committments.Reset();
            Committments.SetRange(Committments."Commitment No", ImprestHeader."Imprest Issue Doc. No");
            Committments.SetRange(Committments."Commitment Type", Committments."Commitment Type"::Encumberance);
            if Committments.Find('-') then
                UncommittmentDate := Committments."Commitment Date";
            repeat
                if LineCommitted(ImprestHeader."Imprest Issue Doc. No", ImprestLines."Account No", ImprestLines."Line No") then begin
                    Committments.Init();
                    Committments."Commitment No" := ImprestHeader."Imprest Issue Doc. No";
                    Committments."Commitment Type" := Committments."Commitment Type"::"Encumberance Reversal";
                    Committments."Document Type" := Committments."Document Type"::Imprest;
                    //Insert same Commitment Date
                    Committments."Commitment Date" := UncommittmentDate;
                    Committments."Uncommittment Date" := ImprestHeader.Date;
                    Committments."Dimension Set ID" := ImprestHeader."Dimension Set ID";
                    Committments."Global Dimension 1 Code" := ImprestLines."Shortcut Dimension 1 Code";
                    Committments."Global Dimension 2 Code" := ImprestLines."Shortcut Dimension 2 Code";
                    Committments."Dimension Set ID" := ImprestHeader."Dimension Set ID";
                    Committments.Account := ImprestLines."Account No";
                    Committments."Committed Amount" := -LastCommittment(ImprestHeader."Imprest Issue Doc. No", ImprestLines."Account No", ImprestLines."Line No");
                    Committments.User := CopyStr(UserId, 1, MaxStrLen(Committments.User));
                    Committments."Document No" := ImprestHeader."No.";
                    Committments.No := ImprestLines."Account No";
                    Committments."Line No." := ImprestLines."Line No";
                    EntryNo := EntryNo + 1;
                    Committments."Entry No" := EntryNo;
                    GeneralLedgerSetup.Get();
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code" := CopyStr(GetCommittedBudget(ImprestHeader."Imprest Issue Doc. No"), 1, MaxStrLen(Committments."Budget Code"));
                    Committments.Insert();
                end;
            until ImprestLines.Next() = 0;
        end;
    end;

    procedure UnencumberPettyCash(var PettyCash: Record Payments)
    var
        Committments: Record "Commitment Entries";
        PettyCashLines: Record "Payment Lines";
        EntryNo: Integer;
    begin
        PettyCashLines.SetRange(No, PettyCash."No.");
        if PettyCashLines.FindSet() then begin
            if Committments.FindLast() then
                EntryNo := Committments."Entry No";
            Committments.Reset();
            Committments.SetRange(Committments."Commitment No", PettyCash."Petty Cash Issue Doc.No");
            Committments.SetRange(Committments."Commitment Type", Committments."Commitment Type"::Encumberance);
            if Committments.Find('-') then
                UncommittmentDate := Committments."Commitment Date";
            repeat
                if LineCommitted(PettyCash."Petty Cash Issue Doc.No", PettyCashLines."Account No", PettyCashLines."Line No") then begin
                    Committments.Init();
                    Committments."Commitment No" := PettyCash."Petty Cash Issue Doc.No";
                    Committments."Commitment Type" := Committments."Commitment Type"::"Encumberance Reversal";
                    Committments."Document Type" := Committments."Document Type"::"Petty Cash";
                    //Insert same Commitment Date
                    Committments."Commitment Date" := UncommittmentDate;
                    Committments."Uncommittment Date" := PettyCash.Date;
                    Committments."Dimension Set ID" := PettyCash."Dimension Set ID";
                    Committments."Global Dimension 1 Code" := PettyCashLines."Shortcut Dimension 1 Code";
                    Committments."Global Dimension 2 Code" := PettyCashLines."Shortcut Dimension 2 Code";
                    Committments."Dimension Set ID" := PettyCash."Dimension Set ID";
                    Committments.Account := PettyCashLines."Account No";
                    Committments."Account No." := PettyCash."Account No.";
                    Committments."Account Name" := PettyCash."Account Name";
                    Committments.Description := PettyCash."Payment Narration";
                    Committments."Committed Amount" := -LastCommittment(PettyCash."Petty Cash Issue Doc.No", PettyCashLines."Account No", PettyCashLines."Line No");
                    Committments.User := CopyStr(UserId, 1, MaxStrLen(Committments.User));
                    Committments."Document No" := PettyCash."No.";
                    Committments.No := PettyCashLines."Account No";
                    Committments."Line No." := PettyCashLines."Line No";
                    EntryNo := EntryNo + 1;
                    Committments."Entry No" := EntryNo;
                    GeneralLedgerSetup.Get();
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code" := CopyStr(GetCommittedBudget(PettyCash."No."), 1, MaxStrLen(Committments."Budget Code"));
                    Committments.Insert();
                end;
            until PettyCashLines.Next() = 0;
        end;
    end;

    procedure UnencumberPO(PurchHeader: Record "Purchase Header"; PurchLine: Record "Purchase Line")
    var
        Committments: Record "Commitment Entries";
        EncumberedAmt: Decimal;
        EntryNo: Integer;
    begin
        if Committments.FindLast() then
            EntryNo := Committments."Entry No";
        Committments.Reset();
        Committments.SetRange("Commitment No", PurchHeader."No.");
        Committments.SetRange("Commitment Type", Committments."Commitment Type"::Encumberance);
        Committments.SetRange(No, PurchLine."No.");
        Committments.SetRange("Line No.", PurchLine."Line No.");
        if Committments.Find('-') then begin
            UncommittmentDate := Committments."Commitment Date";
            EncumberedAmt := Committments."Committed Amount";
        end;
        if LineCommitted(PurchHeader."No.", PurchLine."No.", PurchLine."Line No.") then begin
            Committments.Init();
            Committments."Commitment No" := PurchHeader."No.";
            Committments."Commitment Type" := Committments."Commitment Type"::"Encumberance Reversal";
            //Insert same Commitment Date
            Committments."Commitment Date" := UncommittmentDate;
            Committments."Uncommittment Date" := PurchHeader."Posting Date";
            Committments."Dimension Set ID" := PurchLine."Dimension Set ID";
            Committments."Global Dimension 1 Code" := PurchLine."Shortcut Dimension 1 Code";
            Committments."Global Dimension 2 Code" := PurchLine."Shortcut Dimension 2 Code";
            Committments.Account := PurchLine."No.";
            Committments."Account No." := PurchLine."No.";
            Committments."Committed Amount" := -EncumberedAmt;
            Committments.User := CopyStr(UserId, 1, MaxStrLen(Committments.User));
            Committments."Document No" := PurchHeader."No.";
            Committments.No := PurchLine."No.";
            Committments."Line No." := PurchLine."Line No.";
            EntryNo := EntryNo + 1;
            Committments."Entry No" := EntryNo;
            GeneralLedgerSetup.Get();
            GeneralLedgerSetup.TestField("Current Budget");
            Committments."Budget Code" := CopyStr(GetCommittedBudget(PurchHeader."No."), 1, MaxStrLen(Committments."Budget Code"));
            Committments.Insert();
        end;
    end;

    local procedure CheckImprestCostOfSales(AcNo: Code[50]; ExpCode: Code[150]): Boolean
    var
        RecTypes: Record "Receipts and Payment Types";
    begin
        RecTypes.Reset();
        RecTypes.SetFilter(Type, '%1|%2', RecTypes.Type::Imprest, RecTypes.Type::"Staff Claim");
        RecTypes.SetRange(Code, ExpCode);
        RecTypes.SetRange("Account No.", AcNo);
        if RecTypes.FindFirst() then
            if RecTypes."Cost of Sale" then
                exit(true)
            else
                exit(false);
    end;

    local procedure GetGLSetup()
    var
        GLSetup: Record "General Ledger Setup";
    begin
        if not HasGotGLSetup then begin
            GLSetup.Get();
            GLSetupShortcutDimCode[1] := GLSetup."Shortcut Dimension 1 Code";
            GLSetupShortcutDimCode[2] := GLSetup."Shortcut Dimension 2 Code";
            GLSetupShortcutDimCode[3] := GLSetup."Shortcut Dimension 3 Code";
            GLSetupShortcutDimCode[4] := GLSetup."Shortcut Dimension 4 Code";
            GLSetupShortcutDimCode[5] := GLSetup."Shortcut Dimension 5 Code";
            GLSetupShortcutDimCode[6] := GLSetup."Shortcut Dimension 6 Code";
            GLSetupShortcutDimCode[7] := GLSetup."Shortcut Dimension 7 Code";
            GLSetupShortcutDimCode[8] := GLSetup."Shortcut Dimension 8 Code";
            HasGotGLSetup := true;
        end;
    end;
}
