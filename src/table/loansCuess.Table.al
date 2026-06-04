Table 50344 "loans Cuess"
{
    fields
    {
        field(1; "Primary Key"; Code[20])
        {
        }
        field(2; "Applied Loans"; Integer)
        {
            CalcFormula = COUNT("Loans Register" WHERE(Posted = filter(false),
                                                    "Approved Amount" = filter(> 0),
                                                    "Approval Status" = filter(Open),
                                                      Source = filter(BOSA)));
            FieldClass = FlowField;
        }
        field(3; "Active Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Outstanding Balance" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(4; "Pending Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Pending), "Approved Amount" = filter(> 0), "Outstanding Balance" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(5; "Applied FOSA Loans"; Integer)
        {
            CalcFormula = COUNT("Loans Register" WHERE("Approval Status" = CONST(Open), "Approved Amount" = filter(> 0), "Loan Status" = const(Application), Source = const(FOSA)));
            FieldClass = FlowField;
        }
        field(6; "Active FOSA Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Outstanding Balance" = filter(> 0), "Loan Status" = const(Disbursed), Source = const(FOSA)));
            FieldClass = FlowField;
        }
        field(7; "Pending FOSA Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Pending), "Approved Amount" = filter(> 0), "Outstanding Balance" = filter(> 0), Source = const(FOSA)));
            FieldClass = FlowField;
        }
        field(8; "Applied MICRO Loans"; Integer)
        {
            CalcFormula = COUNT("Loans Register" WHERE("Approval Status" = CONST(Open), "Approved Amount" = filter(> 0), "Loan Status" = const(Application), Source = const(MICRO)));
            FieldClass = FlowField;
        }
        field(9; "Active MICRO Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Outstanding Balance" = filter(> 0), "Loan Status" = const(Disbursed), Source = const(MICRO)));
            FieldClass = FlowField;
        }
        field(10; "Pending MICRO Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Pending), "Approved Amount" = filter(> 0), "Outstanding Balance" = filter(> 0), Source = const(MICRO)));
            FieldClass = FlowField;
        }
        //MEDICAL LOAN
        field(11; "Normal Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Outstanding Balance" = filter(> 0), "Loan Product Type" = const('MEDICAL')));
            FieldClass = FlowField;
        }
        //SCHOOOL LOAN
        field(12; "School Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Outstanding Balance" = filter(> 0), "Loan Product Type" = const('SCH LOAN')));
            FieldClass = FlowField;
        }
        //DEVELOPMENT LOAN
        field(13; "Development Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Outstanding Balance" = filter(> 0), "Loan Product Type" = const('DEV')));
            FieldClass = FlowField;
        }
        //EMERGENCY LOAN
        field(14; "Emergency Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Outstanding Balance" = filter(> 0), "Loan Product Type" = const('EMERGENCY')));
            FieldClass = FlowField;
        }
        //DEFAULTER LOAN
        field(15; "Defaulter Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Approval Status" = const(Approved), "Outstanding Balance" = filter(> 0), "Loan Product Type" = const('DEFAULTER')));
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
