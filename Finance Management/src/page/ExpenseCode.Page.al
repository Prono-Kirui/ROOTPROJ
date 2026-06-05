page 51109 "Expense Code"
{
    ApplicationArea = All;
    Caption = 'Expense Code';
    PageType = List;
    SourceTable = "Expense Code";
    layout
    {
        area(Content)
        {
            repeater(Control1102756000)
            {
                ShowCaption = false;

                field("Code"; Rec.Code)
                {
                    Caption = 'Code';
                    ToolTip = 'Specifies the value of the Code field';
                }
                field(Name; Rec.Name)
                {
                    Caption = 'Name';
                    ToolTip = 'Specifies the value of the Name field';
                }
                field(Type; Rec.Type)
                {
                    Caption = 'Type';
                    ToolTip = 'Specifies the value of the Type field';
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    Caption = 'G/L Account';
                    ToolTip = 'Specifies the value of the G/L Account field';
                }
                field("Expense Type"; Rec."Expense Type")
                {
                    Caption = 'Expense Type';
                    ToolTip = 'Specifies the value of the Expense Type field';
                }
                field("Per Diem"; Rec."Per Diem")
                {
                    Caption = 'Per Diem';
                    ToolTip = 'Specifies the value of the Per Diem field';
                }
            }
        }
    }
}
