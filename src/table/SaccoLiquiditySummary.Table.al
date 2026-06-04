table 50026 "Sacco Liquidity Summary"
{
    Caption = 'Sacco Liquidity Summary';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Table Code"; Code[20])
        {
            Caption = 'Primary Key';
        }
        field(2; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(3; "Cash Deposits"; Decimal)
        {
            Caption = 'Cash Deposits';
            // CalcFormula = sum("Bank Account Ledger Entry".Amount where("Teller Transaction Type" = const("Cash Deposits"), "Posting Date" = field("Date Filter"), Reversed = const(false)));
            // FieldClass = FlowField;
        }
        field(4; "Cheque Deposits"; Decimal)
        {
            Caption = 'Cheque Deposits';
            // CalcFormula = sum("Bank Account Ledger Entry".Amount where("Teller Transaction Type" = const("Cheque Deposits"), "Posting Date" = field("Date Filter"), Reversed = const(false)));
            // FieldClass = FlowField;
        }
        field(5; "Cash Withdrawals"; Decimal)
        {
            // CalcFormula = sum("Bank Account Ledger Entry".Amount where("Teller Transaction Type" = const("Cash Withdrawals"), "Posting Date" = field("Date Filter"), Reversed = const(false)));
            // FieldClass = FlowField;
        }
        field(6; "Bankers Cheque"; Decimal)
        {
            // CalcFormula = sum("Bank Account Ledger Entry".Amount where("Teller Transaction Type" = const("Bankers Cheques"), "Posting Date" = field("Date Filter"), Reversed = const(false)));
            // FieldClass = FlowField;
        }
        field(8; "CEEP Loans Issued"; Decimal)
        {
            // CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Transaction Type" = const(Loan), "Posting Date" = field("Date Filter"), Reversed = const(false)));
            // FieldClass = FlowField;
        }
        field(9; "CEEP Principal Payment"; Decimal)
        {
            // CalcFormula = sum("Bank Account Ledger Entry".Amount where("Teller Transaction Type" = const("CEEP Principal Payment"), "Posting Date" = field("Date Filter"), Reversed = const(false)));
            // FieldClass = FlowField;
        }
        field(10; "CEEP Interest Payment"; Decimal)
        {
            // CalcFormula = sum("Bank Account Ledger Entry".Amount where("Teller Transaction Type" = const("CEEP Interest Payment"), "Posting Date" = field("Date Filter"), Reversed = const(false)));
            // FieldClass = FlowField;
        }
        field(11; "BOSA Loan Issued"; Decimal)
        {
            // CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where(
            //                                                       "Transaction Type" = filter(Loan),
            //                                                       "Posting Date" = field("Date filter"),
            //                                                        Reversed = const(false), Source = const(BOSA), Reversed = const(false)));
            // FieldClass = FlowField;
        }
        field(12; "BOSA Loan Repayments"; Decimal)
        {
            // CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where(
            //                                                       "Transaction Type" = filter(Repayment),
            //                                                       "Posting Date" = field("Date filter"),
            //                                                        Reversed = const(false), Source = const(BOSA), Reversed = const(false)));
            // FieldClass = FlowField;
        }
        field(13; "BOSA Interest Paid"; Decimal)
        {
            // CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where(
            //                                                       "Transaction Type" = filter("Interest Paid"),
            //                                                       "Posting Date" = field("Date filter"),
            //                                                        Reversed = const(false), Source = const(BOSA), Reversed = const(false)));
            // FieldClass = FlowField;
        }
        field(14; "Advance Loans Issued"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Transaction Type" = filter(Loan), "Posting Date" = field("Date filter"), Reversed = const(false), Source = const(FOSA), Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(15; "Advance Principal Paid"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Transaction Type" = filter("Loan Repayment"), "Posting Date" = field("Date filter"), Reversed = const(false), Source = const(FOSA), Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(16; "Advance Interest Paid"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Transaction Type" = filter("Interest Paid"), "Posting Date" = field("Date filter"), Reversed = const(false), Source = const(FOSA), Reversed = const(false)));
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "Table Code")
        {
            Clustered = true;
        }
    }
}
