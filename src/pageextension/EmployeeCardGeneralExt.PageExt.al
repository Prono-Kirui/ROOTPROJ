pageextension 50001 "Employee Card General Ext" extends "Employee Card"
{
    layout
    {
        addafter("Privacy Blocked")
        {
            field("User ID"; Rec."User ID")
            {
                ShowMandatory = true;
                ToolTip = 'Specifies the value of the User ID field';
                ApplicationArea = All;
            }
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Responsibility Center field.';
            }
        }
    }
}



