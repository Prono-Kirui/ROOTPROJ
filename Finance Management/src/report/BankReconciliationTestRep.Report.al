report 51999 "Bank Reconciliation Test Rep"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/BankReconciliationTestRep1.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Bank Acc. Reconciliation"; "Bank Acc. Reconciliation")
        {
            column(BankAccountNo; "Bank Acc. Reconciliation"."Bank Account No.")
            {
            }
            column(BankName; BankName)
            {
            }
            column(StatementNo; "Bank Acc. Reconciliation"."Statement No.")
            {
            }
            column(StatementEndingBalance; "Bank Acc. Reconciliation"."Statement Ending Balance")
            {
            }
            column(StatementDate; "Bank Acc. Reconciliation"."Statement Date")
            {
            }
            column(BalanceLastStatement; "Bank Acc. Reconciliation"."Balance Last Statement")
            {
            }
            column(CashbookBalance; CashbookBalance)
            {
            }
            column(PeriodEnding; STRSUBSTNO('PERIOD ENDING %1', FORMAT("Statement Date", 0, '<Day,2> <Month Text> <Year4>')))
            {
            }
            column(Comp_Logo; CompInfo.Picture)
            {
            }
            column(CompInfo_Name; CompInfo.Name)
            {
            }
            column(PreparedBy; GetUserName(Approver[1]))
            {
            }
            column(DatePrepared; ApproverDate[1])
            {
            }
            column(PreparedBy_Signature; UserSetup.Signature)
            {
            }
            column(ExaminedBy; GetUserName(Approver[2]))
            {
            }
            column(DateApproved; ApproverDate[2])
            {
            }
            column(ExaminedBy_Signature; UserSetup1.Signature)
            {
            }
            column(VBC; GetUserName(Approver[3]))
            {
            }
            column(VBCDate; ApproverDate[3])
            {
            }
            column(VBC_Signature; UserSetup2.Signature)
            {
            }

            dataitem("Bank Acc. Reconciliation Line"; "Bank Acc. Reconciliation Line")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No."), "Statement No." = FIELD("Statement No.");
                DataItemTableView = WHERE("Statement Amount" = FILTER(<> 0));
                column(DocumentNo_BankAccountStatementLine; "Bank Acc. Reconciliation Line"."Document No.")
                {
                }
                column(TransactionDate_BankAccountStatementLine; "Bank Acc. Reconciliation Line"."Transaction Date")
                {
                }
                column(Description_BankAccountStatementLine; "Bank Acc. Reconciliation Line".Description)
                {
                }
                column(StatementAmount_BankAccountStatementLine; "Bank Acc. Reconciliation Line"."Statement Amount")
                {
                }
                column(Difference_BankAccountStatementLine; "Bank Acc. Reconciliation Line".Difference)
                {
                }
                column(AppliedAmount_BankAccountStatementLine; "Bank Acc. Reconciliation Line"."Applied Amount")
                {
                }
                // column(Type_BankAccountStatementLine;"Bank Acc. Reconciliation Line".Type)
                // {
                // }
                column(AppliedEntries_BankAccountStatementLine; "Bank Acc. Reconciliation Line"."Applied Entries")
                {
                }
                column(ValueDate_BankAccountStatementLine; "Bank Acc. Reconciliation Line"."Value Date")
                {
                }
                column(CheckNo_BankAccountStatementLine; "Bank Acc. Reconciliation Line"."Check No.")
                {
                }
            }
            dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No.");
                DataItemTableView = WHERE("Statement Status" = CONST(Open), Reversed = filter(false) /*"Entry No."=FILTER(<>12774)*/);
                column(BankAccountNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Bank Account No.")
                {
                }
                column(PostingDate_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Posting Date")
                {
                }
                column(DocumentNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Document No.")
                {
                }
                column(Description_BankAccountLedgerEntry; "Bank Account Ledger Entry".Description)
                {
                }
                column(Amount_BankAccountLedgerEntry; "Bank Account Ledger Entry".Amount)
                {
                }
                column(RemainingAmount_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Remaining Amount")
                {
                }
                column(AmountLCY_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Amount (LCY)")
                {
                }
                column(Open_BankAccountLedgerEntry; "Bank Account Ledger Entry".Open)
                {
                }
                column(ClosedbyEntryNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Closed by Entry No.")
                {
                }
                column(ClosedatDate_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Closed at Date")
                {
                }
                column(StatementStatus_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Statement Status")
                {
                }
                column(StatementNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Statement No.")
                {
                }
                column(StatementLineNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Statement Line No.")
                {
                }

                trigger OnPreDataItem()
                begin
                    "Bank Account Ledger Entry".SETRANGE("Posting Date", 0D, StatementEndDate);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompInfo.GET();
                CompInfo.CALCFIELDS(Picture);
                IF Bank.GET("Bank Acc. Reconciliation"."Bank Account No.") THEN BEGIN
                    BankName := Bank.Name;
                    StatementEndDate := "Bank Acc. Reconciliation"."Statement Date";
                    Bank.SETRANGE("Date Filter", 0D, "Bank Acc. Reconciliation"."Statement Date");
                    Bank.CALCFIELDS("Net Change");
                    CashbookBalance := Bank."Net Change";
                    //   MESSAGE('cb balance is %1',CashbookBalance);
                    Approver[1] := BankAccRecon.SystemCreatedBy;
                    // ApproverDate[1] := CreateDateTime(BankAccRecon.SystemCreatedAt, BankAccRecon.SystemCreatedAt);
                    ApproverDate[1] := BankAccRecon.SystemCreatedAt;
                    if UserSetup.Get(Approver[1]) then
                        UserSetup.CalcFields(Signature);

                    /* ApprovalEntries.Reset();
                     ApprovalEntries.SetCurrentKey("Sequence No.");
                     ApprovalEntries.SetRange("Table ID", Database::"Bank Acc. Reconciliation");
                     ApprovalEntries.SetRange("Document No.", "Bank Acc. Reconciliation"."Bank Account No.");
                     ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Approved);
                     if ApprovalEntries.Find('-') then
                         repeat
                             if ApprovalEntries."Sequence No." = 1 then begin
                                 Approver[2] := ApprovalEntries."Last Modified By User ID";
                                 ApproverDate[2] := ApprovalEntries."Last Date-Time Modified";
                                 if UserSetup1.Get(Approver[2]) then
                                     UserSetup1.CalcFields(Signature);
                             end;
                             if ApprovalEntries."Sequence No." = 2 then begin
                                 Approver[3] := ApprovalEntries."Last Modified By User ID";
                                 ApproverDate[3] := ApprovalEntries."Last Date-Time Modified";
                                 if UserSetup2.Get(Approver[3]) then
                                     UserSetup2.CalcFields(Signature);
                             end;
                         if ApprovalEntries."Sequence No." = 3 then begin
                             Approver[4] := ApprovalEntries."Last Modified By User ID";
                             ApproverDate[4] := ApprovalEntries."Last Date-Time Modified";
                             if UserSetup3.Get(Approver[4]) then
                                 UserSetup3.CalcFields(Signature);
                         end;
                         until ApprovalEntries.Next() = 0;

                     if Posted then begin
                         Approver[4] := "Posted By";
                         ApproverDate[4] := CreateDateTime("Posted Date", "Time Posted");
                         if UserSetup3.Get(Approver[4]) then
                             UserSetup3.CalcFields(Signature);
                     end;*/
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
    local procedure GetUserName(UserCode: Code[50]): Text
    begin
        // Users.RESET;
        // Users.SETRANGE("User Name",UserCode);
        // IF Users.FINDFIRST THEN
        //  EXIT(Users."Full Name");
        exit(UserCode);
    end;

    var
        Bank: Record "Bank Account";
        BankAccRecon: Record "Bank Acc. Reconciliation";
        CompInfo: Record "Company Information";
        UserSetup: Record "User Setup";
        UserSetup1: Record "User Setup";
        UserSetup2: Record "User Setup";
        ApprovalEntries: Record "Approval Entry";
        BankName: Text;
        StatementEndDate: Date;
        StatementNo: Integer;
        BankAccNo: Code[20];
        CashbookBalance: Decimal;

        StatementCashDifference: Decimal;
        Approver: array[10] of Code[50];
        ApproverDate: array[10] of DateTime;
}

