pageextension 51013 "Chart of Accounts Ext" extends "Chart of Accounts"
{
    Editable = false;
    layout
    {
        addafter("No.")
        {
            field("Old Account No"; Rec."Old Account No")
            {
                ApplicationArea = All;
                Caption = 'Old Account No';
                ToolTip = 'Specifies the value of the Old Account No.';
            }
        }
        addlast(Control1)
        {
            field(Commitment; Rec.Commitment)
            {
                ApplicationArea = All;
                Caption = 'Commitment';
                ToolTip = 'Specifies the value of the Commitment field.';
            }
            field(Encumberance; Rec.Encumberance)
            {
                ApplicationArea = All;
                Caption = 'Encumberance';
                ToolTip = 'Specifies the value of the Encumberance field.';
            }
            field("Budgeted Amount"; Rec."Budgeted Amount")
            {
                ApplicationArea = All;
                Caption = 'Budgeted Amount';
                ToolTip = 'Specifies either the G/L account''s total budget or, if you have specified a name in the Budget Name field, a specific budget.';
            }
            field("Approved Budget"; Rec."Approved Budget")
            {
                ApplicationArea = All;
                Caption = 'Approved Budget';
                ToolTip = 'Specifies the value of the Approved Budget field.';
            }
        }
    }
}
