pageextension 50016 "Customer Card Ext" extends "Customer Card"
{
    layout
    {
        // modify("Registration Number")
        // {
        //     Importance = Standard;
        // }
        //moveafter(Name; "Registration Number")

        addafter(Name)
        {
            field("Customer Type"; Rec."Customer Type")
            {
                Editable = true;
                ApplicationArea = All;
                ToolTip = 'Specifies the different account types of customers';
            }

        }
    }
}






