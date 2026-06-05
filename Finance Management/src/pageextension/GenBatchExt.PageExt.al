pageextension 51010 GenBatchExt extends "General Journal Batches"
{
    layout
    {
        addlast(Control1)
        {
            field("Payroll period"; Rec."Payroll period")
            {
                ApplicationArea = All;
                Caption = 'Payroll period';
                ToolTip = 'Specifies the value of the Payroll period field';
            }
            field("Payroll start date"; Rec."Payroll start date")
            {
                ApplicationArea = All;
                Caption = 'Payroll start date';
                ToolTip = 'Specifies the value of the Payroll start date field';
            }
        }
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }
}
