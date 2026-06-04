page 50027 "Loan Charges"
{
    ApplicationArea = All;
    Caption = 'Loan Charges';
    PageType = List;
    SourceTable = "Loan Charges";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
                field("Use Perc"; Rec."Use Perc")
                {
                    ToolTip = 'Specifies the value of the Use Perc field.', Comment = '%';
                }
                field(Percentage; Rec.Percentage)
                {
                    ToolTip = 'Specifies the value of the Percentage field.', Comment = '%';
                }
                field("Charge Type"; Rec."Charge Type")
                {
                    ToolTip = 'Specifies the value of the Charge Type field.', Comment = '%';
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ToolTip = 'Specifies the value of the G/L Account field.', Comment = '%';
                }
                field("Charge Excise"; Rec."Charge Excise")
                {
                    ToolTip = 'Specifies the value of the Charge Excise field.', Comment = '%';
                }

            }
        }
    }
}
