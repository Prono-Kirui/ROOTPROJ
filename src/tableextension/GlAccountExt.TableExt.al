tableextension 50044 "GlAccountExt" extends "G/L Account"
{
    fields
    {
        field(1000; "Budget Controlled"; Boolean)
        {
            Caption = 'Budget Controlled';
            DataClassification = ToBeClassified;
        }
        field(1002; "Expense Code"; Code[100])
        {
            Caption = 'Expense Code';
            DataClassification = ToBeClassified;
        }
        field(1003; "GL Account Balance"; Decimal)
        {
            // CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FIELD("No."),
            //                                             "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
            //                                             "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter")));
            // Caption = 'Balance';
            // Editable = false;
            // FieldClass = FlowField;
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FIELD("No."), "G/L Account No." = FIELD(FILTER(totaling)), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter")));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50008; "Votebook Entry"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Votebook Entry';
        }
        field(50009; "Old Account No"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Old Account No';
        }
        field(50000; "Disbursed Budget"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("G/L Budget Entry".Amount where("G/L Account No." = field("No."),
                                                              "G/L Account No." = field(filter(Totaling)),
                                                              "Business Unit Code" = field("Business Unit Filter"),
                                                              "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                              "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                              Date = field("Date Filter"),
                                                              "Budget Name" = field("Budget Filter"),
                                                              "Dimension Set ID" = field("Dimension Set ID Filter")));
            Caption = 'Disbursed Budget';
        }
        field(50001; "Approved Budget"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("G/L Budget Entry".Amount where("G/L Account No." = field("No."),
                                                              "G/L Account No." = field(filter(Totaling)),
                                                              "Business Unit Code" = field("Business Unit Filter"),
                                                              "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                              "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                              Date = field(upperlimit("Date Filter")),
                                                              "Budget Name" = field("Budget Filter"),
                                                              "Dimension Set ID" = field("Dimension Set ID Filter")));
            Caption = 'Approved Budget';
        }
        field(50006; Commitment; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Commitment Entries"."Committed Amount" where(Account = field("No."), "Commitment Date" = field("Date Filter"),
                        "Global Dimension 1 Code" = field("Global Dimension 1 Filter"), "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                        Account = field(filter(Totaling)), "Commitment Type" = filter(Commitment | "Commitment Reversal"), "Dimension Set ID" = field("Dimension Set ID Filter"),
                        "Budget Code" = field("Budget Filter")));
            Caption = 'Commitment';
        }
        field(50007; Encumberance; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Commitment Entries"."Committed Amount" where(Account = field("No."), "Commitment Date" = field("Date Filter"),
                        "Global Dimension 1 Code" = field("Global Dimension 1 Filter"), "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                        Account = field(filter(Totaling)), "Commitment Type" = filter(Encumberance | "Encumberance Reversal"), "Dimension Set ID" = field("Dimension Set ID Filter"),
                        "Budget Code" = field("Budget Filter")));
            Caption = 'Encumberance';
        }
    }
}
