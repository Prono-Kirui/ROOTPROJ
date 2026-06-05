page 51048 "Cash Office User Template"
{
    ApplicationArea = All;
    Caption = 'Cash Office User Template';
    PageType = List;
    SourceTable = "Cash Office User Template";
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
                field("Petty Cash Template"; Rec."Petty Cash Template")
                {
                    Caption = 'Petty Cash Template';
                    ToolTip = 'Specifies the value of the Petty Cash Template field';
                }
                field("Petty Cash Batch"; Rec."Petty Cash Batch")
                {
                    Caption = 'Petty Cash Batch';
                    ToolTip = 'Specifies the value of the Petty Cash Batch field';
                }
                field("Inter Bank Template Name"; Rec."Inter Bank Template Name")
                {
                    Caption = 'Inter Bank Template Name';
                    ToolTip = 'Specifies the value of the Inter Bank Template Name field';
                }
                field("Inter Bank Batch Name"; Rec."Inter Bank Batch Name")
                {
                    Caption = 'Inter Bank Batch Name';
                    ToolTip = 'Specifies the value of the Inter Bank Batch Name field';
                }
                field("Default Receipts Bank"; Rec."Default Receipts Bank")
                {
                    Caption = 'Default Receipts Bank';
                    ToolTip = 'Specifies the value of the Default Receipts Bank field';
                }
                field("Default Payment Bank"; Rec."Default Payment Bank")
                {
                    Caption = 'Default Payment Bank';
                    ToolTip = 'Specifies the value of the Default Payment Bank field';
                }
                field("Default Petty Cash Bank"; Rec."Default Petty Cash Bank")
                {
                    Caption = 'Default Petty Cash Bank';
                    ToolTip = 'Specifies the value of the Default Petty Cash Bank field';
                }
                field("Max. Cash Collection"; Rec."Max. Cash Collection")
                {
                    Caption = 'Max. Cash Collection';
                    ToolTip = 'Specifies the value of the Max. Cash Collection field';
                }
                field("Max. Cheque Collection"; Rec."Max. Cheque Collection")
                {
                    Caption = 'Max. Cheque Collection';
                    ToolTip = 'Specifies the value of the Max. Cheque Collection field';
                }
                field("Max. Deposit Slip Collection"; Rec."Max. Deposit Slip Collection")
                {
                    Caption = 'Max. Deposit Slip Collection';
                    ToolTip = 'Specifies the value of the Max. Deposit Slip Collection field';
                }
                field("Supervisor ID"; Rec."Supervisor ID")
                {
                    Caption = 'Supervisor ID';
                    ToolTip = 'Specifies the value of the Supervisor ID field';
                }
                field("Bank Pay In Journal Template"; Rec."Bank Pay In Journal Template")
                {
                    Caption = 'Bank Pay In Journal Template';
                    ToolTip = 'Specifies the value of the Bank Pay In Journal Template field';
                }
                field("Bank Pay In Journal Batch"; Rec."Bank Pay In Journal Batch")
                {
                    Caption = 'Bank Pay In Journal Batch';
                    ToolTip = 'Specifies the value of the Bank Pay In Journal Batch field';
                }
                field("Imprest Template"; Rec."Imprest Template")
                {
                    Caption = 'Imprest Template';
                    ToolTip = 'Specifies the value of the Imprest Template field';
                }
                field("Imprest  Batch"; Rec."Imprest  Batch")
                {
                    Caption = 'Imprest  Batch';
                    ToolTip = 'Specifies the value of the Imprest  Batch field';
                }
                field("Claim Template"; Rec."Claim Template")
                {
                    Caption = 'Claim Template';
                    ToolTip = 'Specifies the value of the Claim Template field';
                }
                field("Claim  Batch"; Rec."Claim  Batch")
                {
                    Caption = 'Claim  Batch';
                    ToolTip = 'Specifies the value of the Claim  Batch field';
                }
                field("Advance Template"; Rec."Advance Template")
                {
                    Caption = 'Other Advance Template';
                    ToolTip = 'Specifies the value of the Other Advance Template field';
                }
                field("Advance  Batch"; Rec."Advance  Batch")
                {
                    Caption = 'Other Advance  Batch';
                    ToolTip = 'Specifies the value of the Other Advance  Batch field';
                }
                field("Advance Surr Template"; Rec."Advance Surr Template")
                {
                    Caption = 'Other Advance Surr Template';
                    ToolTip = 'Specifies the value of the Other Advance Surr Template field';
                }
                field("Advance Surr Batch"; Rec."Advance Surr Batch")
                {
                    Caption = 'Other Advance Surr Batch';
                    ToolTip = 'Specifies the value of the Other Advance Surr Batch field';
                }
                field("Imprest Sur Template"; Rec."Imprest Sur Template")
                {
                    Caption = 'Imprest Surrender Template';
                    ToolTip = 'Specifies the value of the Imprest Surrender Template field';
                }
                field("Imprest Sur Batch"; Rec."Imprest Sur Batch")
                {
                    Caption = 'Imprest Surrender Batch';
                    ToolTip = 'Specifies the value of the Imprest Surrender Batch field';
                }
            }
        }
    }
}
