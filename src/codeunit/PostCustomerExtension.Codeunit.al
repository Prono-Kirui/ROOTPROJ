codeunit 50915 "PostCustomerExtension"
{
    var
        LoanApp: Record "Loans Register";
        LoanTypes: Record "Loan Products Setup";
        MemberReg: Record customer;
        productcharges: Record "Loan Product Charges";

    trigger OnRun()
    begin
    end;
    //1)-----------------------------------------------------------------------------------------------------
    [EventSubscriber(ObjectType::codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInsertDtldCustLedgEntry', '', false, false)]
    procedure InsertCustomfieldstodetailedcustledgerentry(GenJournalLine: Record "Gen. Journal Line"; var DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry")
    var
        Afactory: Codeunit "Micropoint Factory";
    begin
        //Fields to autopopopulate data b4 the posting process is started;
        DtldCustLedgEntry.LockTable();
        DtldCustLedgEntry."Transaction Type" := GenJournalLine."Transaction Type";
        DtldCustLedgEntry."Loan No" := GenJournalLine."Loan No";
        DtldCustLedgEntry."Loan Type" := GenJournalLine."Loan Product Type";
        DtldCustLedgEntry."Amount Posted" := GenJournalLine.Amount;
        DtldCustLedgEntry."Document No." := GenJournalLine."Document No.";
        DtldCustLedgEntry."Transaction Date" := Today;
        DtldCustLedgEntry."Created On" := CurrentDateTime;
        DtldCustLedgEntry."Time Created" := Time;
        DtldCustLedgEntry."Posting Date" := GenJournalLine."Posting Date";
        DtldCustLedgEntry."Prepayment Date" := GenJournalLine."Prepayment date";
        DtldCustLedgEntry."Group Code" := GenJournalLine."Group Code";
        // DtldCustLedgEntry."BLoan Officer No.":= Afactory.FnGetLoanOfficerFromMemberNo(GenJournalLine."Account No.");
    end;
    //2)-----------------------------------------------------------------------------------------------------
    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforePostGenJnlLine', '', false, false)]
    procedure ModifyReceivablesAccount(var GenJournalLine: Record "Gen. Journal Line")
    var
        Cust: Record Customer;
        TransactionTypestable: record "Transaction Types Table";
        LoanApp: Record "Loans Register";
        LoanTypes: record "Loan Products Setup";
        CustPostingGroup: record "Customer Posting Group";
    begin
        //1)Cater to make sure that the posting groups that we did setup are now catered for in g/ls
        //They exclude the repayment,interest paid, penalties of loans etc
        GenJournalLine."Posting Group" := '';
        TransactionTypestable.reset;
        TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
        if TransactionTypestable.Find('-') then begin
            GenJournalLine."Posting Group" := '';
            GenJournalLine."Posting Group" := TransactionTypestable."Posting Group Code";
            if (TransactionTypestable."Transaction Type" = TransactionTypestable."Transaction Type"::"Deposit Contribution") then begin
                if (FnMemberIsCEEP(GenJournalLine."Account No.") = true) or (CopyStr(GenJournalLine."Account No.", 1, 3) = 'L12') then begin
                    GenJournalLine."Posting Group" := 'CEEPDEPOSITS';
                end
                else begin
                    GenJournalLine."Posting Group" := 'DEPOSIT CONTRIBUTION';
                end;
            end;
            GenJournalLine.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforePostGenJnlLine', '', false, false)]
    local procedure PostGenJournalLine(var GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean)
    begin
        with GenJournalLine do case "Account Type" of
                                   "Account Type"::Customer:
                                       begin
                                           PostMemb(GenJournalLine, Balancing);
                                       end;
                                   "Account Type"::Vendor:
                                       begin
                                           CheckDimensions(GenJournalLine, Balancing); //Check Branch Is Inserted
                                       end;
            end;
    end;

    local procedure PostMemb(var GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean)
    var
        CreatedPostingGroup: Code[50];
        MicropointFactory: Codeunit "Micropoint Factory";
        LoanProductSetUpList: record "Loan Products Setup";
    begin
        with GenJournalLine do begin
            if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::Loan) then begin
                if GenJournalLine."Loan No" = '' then begin
                    Error('Loan No Field is empty! Loan No must be specified for %1', GenJournalLine."Account No.");
                end;
                LoanApp.Reset;
                LoanApp.SetCurrentkey(LoanApp."Loan  No.");
                LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
                if LoanApp.Find('-') then begin
                    if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                        LoanTypes.TestField(LoanTypes."Loan Account");
                        //GenJournalLine."Posting Group" := LoanTypes."Loan Account";
                        //FnCheckIfPostingGroupIsSetUp,If != Then SetUp
                        GenJournalLine."Posting Group" := FnHandlePostingGroup(LoanTypes."Loan Account", FORMAT(COPYSTR(LoanApp."Loan Product Type", 1, 19)));
                        ;
                        Found := true;
                        GenJournalLine.Modify();
                    end;
                end;
            end;
            if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Loan Repayment") then begin
                if GenJournalLine."Loan No" = '' then begin
                    Error('Loan No Field is empty! Loan No must be specified for %1', GenJournalLine."Account No.");
                end;
                LoanApp.Reset;
                LoanApp.SetCurrentkey(LoanApp."Loan  No.");
                LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
                if LoanApp.Find('-') then begin
                    repeat
                        if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                            LoanTypes.TestField(LoanTypes."Loan Account");
                            //GenJournalLine."Posting Group" := LoanTypes."Loan Account";
                            // GenJournalLine."Posting Group" := LoanApp."Loan Product Type";
                            //FnCheckIfPostingGroupIsSetUp,If != Then SetUp
                            GenJournalLine."Posting Group" := FnHandlePostingGroup(LoanTypes."Loan Account", FORMAT(COPYSTR(LoanApp."Loan Product Type", 1, 19)));
                            ;
                            GenJournalLine.Modify();
                        end;
                    until LoanApp.next = 0;
                end;
            end;
            if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Interest Paid") then begin
                if GenJournalLine."Loan No" = '' then begin
                    Error('Loan No Field is empty! Loan No must be specified for %1', GenJournalLine."Account No.");
                end;
                LoanApp.Reset;
                LoanApp.SetCurrentkey(LoanApp."Loan  No.");
                LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
                if LoanApp.Find('-') then begin
                    if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                        LoanTypes.TestField(LoanTypes."Receivable Interest Account");
                        //FnCheckIfPostingGroupIsSetUp,If != Then SetUp
                        GenJournalLine."Posting Group" := FnHandlePostingGroup(LoanTypes."Receivable Interest Account", 'INTPAID-' + FORMAT(COPYSTR(LoanTypes.Code, 1, 50)));
                        ;
                        Found := true;
                        GenJournalLine.Modify();
                    end;
                end;
            end;
            if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Interest Due") then begin
                if GenJournalLine."Loan No" = '' then begin
                    Error('Loan No Field is empty! Loan No must be specified for %1', GenJournalLine."Account No.");
                end;
                LoanApp.Reset;
                LoanApp.SetCurrentkey(LoanApp."Loan  No.");
                LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
                if LoanApp.Find('-') then begin
                    if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                        LoanTypes.TestField(LoanTypes."Receivable Interest Account");
                        //FnCheckIfPostingGroupIsSetUp,If != Then SetUp
                        GenJournalLine."Posting Group" := FnHandlePostingGroup(LoanTypes."Receivable Interest Account", 'INTDUE-' + FORMAT(COPYSTR(LoanTypes.Code, 1, 50)));
                        ;
                        Found := true;
                        GenJournalLine.Modify();
                    end;
                end;
            end;
            if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Partial Disbursed") then begin
                if GenJournalLine."Loan No" = '' then begin
                    Error('Loan No Field is empty! Loan No must be specified for %1', GenJournalLine."Account No.");
                end;
                LoanApp.Reset;
                LoanApp.SetCurrentkey(LoanApp."Loan  No.");
                LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
                if LoanApp.Find('-') then begin
                    if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                        // LoanTypes.TestField(LoanTypes."Receivable Interest Account");
                        // GenJournalLine."Posting Group" := LoanTypes."Receivable Interest Account";
                        // GenJournalLine.Modify();
                        Found := true;
                    end;
                end;
            end;
            if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Interest Due") then begin
                if GenJournalLine."Loan No" = '' then begin
                    Error('Loan No Field is empty! Loan No must be specified for %1', GenJournalLine."Account No.");
                end;
                LoanApp.Reset;
                LoanApp.SetCurrentkey(LoanApp."Loan  No.");
                LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
                if LoanApp.Find('-') then begin
                    if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                        // LoanTypes.TestField(LoanTypes."Receivable Interest Account");
                        // GenJournalLine."Posting Group" := LoanTypes."Receivable Interest Account";
                        // GenJournalLine.Modify();
                        Found := true;
                    end;
                end;
            end;
            if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Loan Penalty Charged") then begin
                if GenJournalLine."Loan No" = '' then begin
                    Error('Loan No Field is empty! Loan No must be specified for %1', GenJournalLine."Account No.");
                end;
                LoanApp.Reset;
                LoanApp.SetCurrentkey(LoanApp."Loan  No.");
                LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
                if LoanApp.Find('-') then begin
                    if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                        LoanTypes.TestField(LoanTypes."Penalty Charged Account");
                        //FnCheckIfPostingGroupIsSetUp,If != Then SetUp
                        GenJournalLine."Posting Group" := FnHandlePostingGroup(LoanTypes."Penalty Charged Account", 'PENALTYCHRG-' + FORMAT(COPYSTR(LoanTypes.Code, 1, 7)));
                        ;
                        Found := true;
                        Found := true;
                        GenJournalLine.Modify();
                    end;
                end;
            end;
            if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Loan Penalty Paid") then begin
                if GenJournalLine."Loan No" = '' then begin
                    Error('Loan No Field is empty! Loan No must be specified for %1', GenJournalLine."Account No.");
                end;
                LoanApp.Reset;
                LoanApp.SetCurrentkey(LoanApp."Loan  No.");
                LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
                if LoanApp.Find('-') then begin
                    if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                        LoanTypes.TestField(LoanTypes."Penalty Paid Account");
                        //FnCheckIfPostingGroupIsSetUp,If != Then SetUp
                        GenJournalLine."Posting Group" := FnHandlePostingGroup(LoanTypes."Penalty Paid Account", 'PENALTYPAID-' + FORMAT(COPYSTR(LoanTypes.Code, 1, 6)));
                        ;
                        Found := true;
                        GenJournalLine.Modify();
                    end;
                end;
            end;
            if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Application Fee") then begin
                if GenJournalLine."Loan No" = '' then begin
                    Error('Loan No Field is empty! Loan No must be specified for %1', GenJournalLine."Account No.");
                end;
                LoanApp.Reset;
                LoanApp.SetCurrentkey(LoanApp."Loan  No.");
                LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
                if LoanApp.Find('-') then begin
                    if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                        productcharges.Reset();
                        productcharges.SetRange(productcharges."Product Code", LoanTypes.Code);
                        productcharges.SetRange(productcharges.Code, 'APP');
                        if productcharges.Find('-') then begin
                            productcharges.TestField(productcharges."G/L Account");
                            //FnCheckIfPostingGroupIsSetUp,If != Then SetUp
                            GenJournalLine."Posting Group" := FnHandlePostingGroup(productcharges."G/L Account", 'APP-' + FORMAT(COPYSTR(LoanTypes.Code, 1, 50)));
                            ;
                            Found := true;
                            GenJournalLine.Modify();
                        end
                        else begin
                            Error('Product Charges Account Not Found. Please Contact System Administrator');
                        end;
                    end;
                end;
            end;
            if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Appraisal Fee") then begin
                if GenJournalLine."Loan No" = '' then begin
                    Error('Loan No Field is empty! Loan No must be specified for %1', GenJournalLine."Account No.");
                end;
                LoanApp.Reset;
                LoanApp.SetCurrentkey(LoanApp."Loan  No.");
                LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
                if LoanApp.Find('-') then begin
                    if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                        productcharges.Reset();
                        productcharges.SetRange(productcharges."Product Code", LoanTypes.Code);
                        productcharges.SetRange(productcharges.Code, 'APPR');
                        if productcharges.Find('-') then begin
                            productcharges.TestField(productcharges."G/L Account");
                            GenJournalLine."Posting Group" := FnHandlePostingGroup(productcharges."G/L Account", 'APPR-' + FORMAT(COPYSTR(LoanTypes.Code, 1, 50)));
                            ;
                            Found := true;
                            GenJournalLine.Modify();
                        end
                        else begin
                            Error('Product Charges Account Not Found. Please Contact System Administrator');
                        end;
                    end;
                end;
            end;
            //................................Ensure that global dimension 2(Branch) is not empty!...critical
            if GenJournalLine."Shortcut Dimension 2 Code" = '' then begin
                GenJournalLine."Shortcut Dimension 2 Code" := '';
                GenJournalLine."Shortcut Dimension 2 Code" := MicropointFactory.FnGetMemberBranch((GenJournalLine."Account No."));
                GenJournalLine.Modify();
            end;
            //................................Ensure that activity code used is accurate
            if GenJournalLine."Loan No" <> '' then begin
                GenJournalLine."Shortcut Dimension 1 Code" := '';
                GenJournalLine."Shortcut Dimension 1 Code" := FnGetActivity(GenJournalLine."Loan No");
                GenJournalLine.Modify();
            end
            else if (GenJournalLine."Loan No" = '') and (GenJournalLine."Transaction Type" <> GenJournalLine."Transaction Type"::" ") then begin
                GenJournalLine."Shortcut Dimension 1 Code" := '';
                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                GenJournalLine.Modify();
            end;
        end;
    end;

    local procedure FnHandlePostingGroup(ReceivableInterestAccount: Code[20]; PostingCode: Text): Code[100]
    var
        CustomerPostingGroup: Record "Customer Posting Group";
        CustomerPostingGroupCreate: Record "Customer Posting Group";
    begin
        CustomerPostingGroup.Reset();
        CustomerPostingGroup.SetRange(CustomerPostingGroup.Code, CopyStr(PostingCode, 1, 20));
        if CustomerPostingGroup.find('-') = true then begin
            exit(CustomerPostingGroup.Code);
        end
        else if CustomerPostingGroup.find('-') = false then begin
            //......Create Customer Posting Group
            CustomerPostingGroupCreate.Init();
            CustomerPostingGroupCreate.Code := CopyStr(PostingCode, 1, 20);
            CustomerPostingGroupCreate."Account Type" := 'MEMBER';
            CustomerPostingGroupCreate.Description := PostingCode + ' Posting Group';
            CustomerPostingGroupCreate."Receivables Account" := ReceivableInterestAccount;
            CustomerPostingGroupCreate.Insert();
            exit(CustomerPostingGroupCreate.Code);
        end;
    end;

    local procedure FnGetLoanProductType(LoanNo: Code[20]): Code[20]
    var
        LoansRegisterRecord: Record "Loans Register";
    begin
        LoansRegisterRecord.Reset();
        LoansRegisterRecord.SetRange(LoansRegisterRecord."Loan  No.", LoanNo);
        if LoansRegisterRecord.Find('-') then begin
            exit(LoansRegisterRecord."Loan Product Type");
        end;
    end;

    local procedure CheckDimensions(var GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean)
    var
        MicropointFactory: Codeunit "Micropoint Factory";
    begin
        with GenJournalLine do begin
            if GenJournalLine."Shortcut Dimension 2 Code" = '' then begin
                GenJournalLine."Shortcut Dimension 2 Code" := '';
                // GenJournalLine."Shortcut Dimension 2 Code":=MicropointFactory.FnGetMemberBranchUsingFosaAccount(GenJournalLine."Account No.");
                GenJournalLine.Modify();
            end;
        end;
    end;

    local procedure FnGetActivity(LoanNo: Code[20]): Code[20]
    var
        LoansRegister: record "Loans Register";
    begin
        LoansRegister.Reset();
        LoansRegister.SetRange(LoansRegister."Loan  No.", LoanNo);
        if LoansRegister.Find('-') then begin
            exit(Format(LoansRegister.Source));
        end;
    end;

    local procedure FnMemberIsCEEP(AccountNo: Code[20]): Boolean
    var
        CEEPTable: Record Customer;
    begin
        CEEPTable.Reset();
        CEEPTable.SetRange(CEEPTable."No.", AccountNo);
        CEEPTable.SetRange(CEEPTable."Global Dimension 1 Code", 'MICRO');
        IF CEEPTable.FIND('-') THEN begin
            exit(true);
        end;
        exit(false);
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitCustLedgEntry', '', false, false)]
    procedure InsertCustomTransactionFields(GenJournalLine: Record "Gen. Journal Line"; var CustLedgerEntry: Record "Cust. Ledger Entry")
    var
        cust: Record Customer;
        Afactory: Codeunit "Micropoint Factory";
    begin
        CustLedgerEntry.LockTable();
        CustLedgerEntry."Transaction Type" := GenJournalLine."Transaction Type";
        CustLedgerEntry."Loan No" := GenJournalLine."Loan No";
        CustLedgerEntry."Loan product Type" := FnGetLoanProductType(GenJournalLine."Loan No");
        CustLedgerEntry."Amount Posted" := GenJournalLine.Amount;
        CustLedgerEntry."Document No." := GenJournalLine."Document No.";
        CustLedgerEntry."Transaction Date" := Today;
        CustLedgerEntry."Last Date Modified" := Today;
        CustLedgerEntry."Created On" := CurrentDateTime;
        CustLedgerEntry."Time Created" := Time;
        CustLedgerEntry."Posting Date" := GenJournalLine."Posting Date";
        CustLedgerEntry."Prepayment Date" := GenJournalLine."Prepayment date";
        CustLedgerEntry."Group Code" := GenJournalLine."Group Code";
        CustLedgerEntry."Document No." := GenJournalLine."Document No.";
        // CustLedgerEntry."BLoan Officer No.":= Afactory.FnGetLoanOfficerFromMemberNo(GenJournalLine."Account No.");
    end;
}
