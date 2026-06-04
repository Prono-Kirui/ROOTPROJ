page 50097 "Account Types Product Card"
{
    ApplicationArea = All;
    Caption = 'Account Types Product Card';
    PageType = Card;
    SourceTable = "Account Types-Saving Products";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Account No Prefix"; Rec."Account No Prefix")
                {
                    ToolTip = 'Specifies the value of the Account No Prefix field.';
                }
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Activity Code"; Rec."Activity Code")
                {

                }

                field("Product Code"; Rec."Product Code")
                { }
                field("Product Type"; Rec."Product Type")
                {
                    ToolTip = 'Specifies the value of the Product Type';
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ToolTip = 'Specifies the value of the Date Entered field.';
                    Editable = false;
                }
                field("Default Account"; Rec."Default Account")
                {
                    ToolTip = 'Specifies the value of the Default Account field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Dormancy Period (M)"; Rec."Dormancy Period (M)")
                {
                    ToolTip = 'Specifies the value of the Dormancy Period (M) field.';
                }
                field("Time Entered"; Rec."Time Entered")
                {
                    ToolTip = 'Specifies the value of the Time Entered field.';
                    Editable = false;
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    ToolTip = 'Specifies the value of the Time Entered field.';
                    Editable = false;
                }
            }
            group("Interest Computation")
            {
            }
            group("Charges")
            {
                field("Account Openning Fee"; Rec."Account Openning Fee")
                {
                    ToolTip = 'Specifies the value of the Time Entered field.';
                }
                field("Account Openning Fee Account"; Rec."Account Openning Fee Account")
                {
                    ToolTip = 'Specifies the value of the Time Entered field.';
                }
                field("Re-activation Fee"; Rec."Re-activation Fee")
                {
                    ToolTip = 'Specifies the value of the Time Entered field.';
                }
                field("Re-activation Fee Account"; Rec."Re-activation Fee Account")
                {
                    ToolTip = 'Specifies the value of the Time Entered field.';
                }
            }
        }
    }
}
