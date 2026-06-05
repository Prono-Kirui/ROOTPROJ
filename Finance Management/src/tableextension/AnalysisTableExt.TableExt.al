tableextension 51002 AnalysisTableExt extends "Analysis View Budget Entry"
{
    fields
    {
        field(51000; Encumberance; Decimal)
        {
            CalcFormula = sum("Commitment Entries"."Committed Amount" where(Account = field("G/L Account No."),
                             "Commitment Date" = field("Date Filter"), "Global Dimension 1 Code" = field("Dimension 1 Value Code"),
                             "Global Dimension 2 Code" = field("Dimension 2 Value Code"), "Commitment Type" = filter(Encumberance | "Encumberance Reversal"),
                             "Dimension Set ID" = field("Dimension Set ID")));
            Caption = 'Encumberance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(51001; Commitments; Decimal)
        {
            CalcFormula = sum("Commitment Entries"."Committed Amount" where(Account = field("G/L Account No."),
                             "Commitment Date" = field("Date Filter"), "Global Dimension 1 Code" = field("Dimension 1 Value Code"),
                             "Global Dimension 2 Code" = field("Dimension 2 Value Code"), "Commitment Type" = filter(Commitment | "Commitment Reversal"),
                             "Dimension Set ID" = field("Dimension Set ID")));
            Caption = 'Commitments';
            Editable = false;
            FieldClass = FlowField;
        }
        field(51002; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(51003; Actuals; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("G/L Account No."),
                              "Global Dimension 1 Code" = field("Dimension 1 Value Code"),
                              "Global Dimension 2 Code" = field("Dimension 2 Value Code"),
                              "Posting Date" = field("Date Filter"), "Dimension Set ID" = field("Dimension Set ID")));
            Caption = 'Actuals';
            Editable = false;
            FieldClass = FlowField;
        }
        field(51004; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Set Entry";
        }
    }
}
