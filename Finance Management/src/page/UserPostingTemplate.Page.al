page 51007 "User Posting Template"
{
    ApplicationArea = All;
    Caption = 'User Posting Template';
    PageType = List;
    SourceTable = "User Posting Template";
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field(UserID; Rec.UserID)
                {
                    Caption = 'UserID';
                    ToolTip = 'Specifies the value of the UserID field';
                }
                field("Receipt Journal Template"; Rec."Receipt Journal Template")
                {
                    Caption = 'Receipt Journal Template';
                    ToolTip = 'Specifies the value of the Receipt Journal Template field';
                }
                field("Receipt Journal Batch"; Rec."Receipt Journal Batch")
                {
                    Caption = 'Receipt Journal Batch';
                    ToolTip = 'Specifies the value of the Receipt Journal Batch field';
                }
                field("Payment Journal Template"; Rec."Payment Journal Template")
                {
                    Caption = 'Payment Journal Template';
                    ToolTip = 'Specifies the value of the Payment Journal Template field';
                }
                field("Payment Journal Batch"; Rec."Payment Journal Batch")
                {
                    Caption = 'Payment Journal Batch';
                    ToolTip = 'Specifies the value of the Payment Journal Batch field';
                }
                field("Petty Cash Journal Template"; Rec."Petty Cash Journal Template")
                {
                    Caption = 'Petty Cash Journal Template';
                    ToolTip = 'Specifies the value of the Petty Cash Journal Template field';
                }
                field("Petty Cash Journal Batch"; Rec."Petty Cash Journal Batch")
                {
                    Caption = 'Petty Cash Journal Batch';
                    ToolTip = 'Specifies the value of the Petty Cash Journal Batch field';
                }
                field("Bank Trans. Journal Template"; Rec."Bank Trans. Journal Template")
                {
                    Caption = 'Bank Trans. Journal Template';
                    ToolTip = 'Specifies the value of the Bank Trans. Journal Template field';
                }
                field("Bank Trans. Journal Batch"; Rec."Bank Trans. Journal Batch")
                {
                    Caption = 'Bank Trans. Journal Batch';
                    ToolTip = 'Specifies the value of the Bank Trans. Journal Batch field';
                }
                field("Item Journal Template"; Rec."Item Journal Template")
                {
                    Caption = 'Item Journal Template';
                    ToolTip = 'Specifies the value of the Item Journal Template field';
                }
                field("Item Journal Batch"; Rec."Item Journal Batch")
                {
                    Caption = 'Item Journal Batch';
                    ToolTip = 'Specifies the value of the Item Journal Batch field';
                }
                field("Payroll Journal Template"; Rec."Payroll Journal Template")
                {
                    Caption = 'Payroll Journal Template';
                    ToolTip = 'Specifies the value of the Payroll Journal Template field';
                }
                field("Payroll Journal Batch"; Rec."Payroll Journal Batch")
                {
                    Caption = 'Payroll Journal Batch';
                    ToolTip = 'Specifies the value of the Payroll Journal Batch field';
                }
                field("Job Journal Template"; Rec."Job Journal Template")
                {
                    Caption = 'Job Journal Template';
                    ToolTip = 'Specifies the value of the Job Journal Template field';
                }
                field("Job Journal Batch"; Rec."Job Journal Batch")
                {
                    Caption = 'Job Journal Batch';
                    ToolTip = 'Specifies the value of the Job Journal Batch field';
                }
            }
        }
    }
}
