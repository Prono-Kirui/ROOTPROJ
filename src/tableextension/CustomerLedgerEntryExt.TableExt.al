tableextension 50080 "CustomerLedgerEntryExt" extends "Cust. Ledger Entry"
{
    fields
    {
        field(68000; "Transaction Type"; Enum TransactionTypesEnum)
        {
        }
        field(68001; "Loan No"; Code[20])
        {
        }
        field(68002; "Group Code"; Code[50])
        {
        }
        field(68003; Type; Option)
        {
            OptionCaption = ' ,Registration,PassBook,Loan Insurance,Loan Application Fee,Down Payment';
            OptionMembers = " ",Registration,PassBook,"Loan Insurance","Loan Application Fee","Down Payment";
        }
        field(68004; "Member Name"; Text[30])
        {
        }
        field(68005; "Loan Type"; Code[20])
        {
            //CalcFormula = lookup("Loans Register"."Loan Product Type" where("Loan  No."=field("Loan No")));
            //FieldClass = FlowField;
        }
        field(68006; "Prepayment Date"; Date)
        {
        }
        field(68009; "BLoan Officer No."; Code[20])
        {
        }
        field(68010; "Loan Product Description"; Text[100])
        {
        }
        field(68011; Source; Option)
        {
            OptionCaption = 'BOSA,FOSA,Investment,MICRO';
            OptionMembers = BOSA,FOSA,Investment,MICRO;
        }
        field(68012; "Staff/Payroll No."; Code[20])
        {
        }
        field(68013; "Last Date Modified"; Date)
        {
        }
        field(68014; "Loan product Type"; Code[20])
        {
        }
        field(68015; "Employer Code"; Code[50])
        {
        }
        field(68016; "Transaction Source"; Option)
        {
            OptionCaption = ',Salary Processing,Checkoff Processing,Cashier Receipt,BackOffice Receipt,Autorecovery,Funds Transfer';
            OptionMembers = ,"Salary Processing","Checkoff Processing","Cashier Receipt","BackOffice Receipt",Autorecovery,"Funds Transfer";
        }
        field(50060; "Amount Posted"; Decimal)
        {
        }
        field(50061; "Reversal Date"; Date)
        {
        }
        field(50062; "Transaction Date"; Date)
        {
            Description = 'Actual Transaction Date(Workdate)';
            Editable = false;
        }
        field(50064; "Created On"; DateTime)
        {
        }
        field(50065; "Computer Name"; Text[30])
        {
        }
        field(50066; "Time Created"; Time)
        {
        }
        field(68017; "Recovery Transaction Type"; Option)
        {
            OptionCaption = 'Normal,Guarantor Recoverd,Guarantor Paid';
            OptionMembers = Normal,"Guarantor Recoverd","Guarantor Paid";
        }
        field(68020; "Recoverd Loan"; Code[20])
        {
        }
        field(68019; "Share Boosting Fee Charged"; Boolean)
        {
        }
        field(68018; Unapplied; Boolean)
        {
            Caption = 'Unapplied';
        }
        field(68919; "No Boosting"; Boolean) { }

    }
    keys
    {
        key(Key36; "Transaction Type")
        {
        }
    }
    trigger OnInsert()
    begin
        CalcFields(Amount);
        if (amount <> 0) then begin
            "Amount Posted" := Amount;
        end;
    end;
}
