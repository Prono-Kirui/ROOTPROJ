page 50707 "BOSA&FOSA User Template"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "BOSA&FOSA User Template";

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
                field("Membership Template"; Rec."Membership Template")
                {
                    Caption = 'Membership Template';
                    ToolTip = 'Specifies the value of the Membership Template field';
                }
                field("Membership Batch"; Rec."Membership Batch")
                {
                    Caption = 'Membership Batch';
                    ToolTip = 'Specifies the value of the Membership Batch field';
                }
                field("loan Template Name"; Rec."loan Template Name")
                {
                    Caption = 'loan Template Name';
                    ToolTip = 'Specifies the value of the loan Template Name field';
                }
                field("loan Batch Name"; Rec."loan Batch Name")
                {
                    Caption = 'loan Batch Name';
                    ToolTip = 'Specifies the value of the loan Batch Name field';
                }
                field("Member receipt Template Name"; Rec."Member receipt Template Name")
                {
                    Caption = 'Member receipt Template Name';
                    ToolTip = 'Specifies the value of the Member receipt Template Name field';
                }
                field("Member receipt Batch Name"; Rec."Member receipt Batch Name")
                {
                    Caption = 'Member receipt Batch Name';
                    ToolTip = 'Specifies the value of the Member receipt Batch Name field';
                }
                field("Member Transfer Template"; Rec."Member Transfer Template Name")
                {
                    Caption = 'Member Transfer Template';
                    ToolTip = 'Specifies the value of the Member Transfer Template field';
                }
                field("Member Transfer Batch"; Rec."Member Transfer Batch Name")
                {
                    Caption = 'Member Transfer Batch';
                    ToolTip = 'Specifies the value of the Member Transfer Batch field';
                    trigger OnValidate()
                    begin

                    end;
                }
                field("Sharescapital Template"; Rec."Sharescapital Template")
                {
                    Caption = 'Sharescapital Template';
                    ToolTip = 'Specifies the value of the Sharescapital Template field';
                }
                field("Sharescapital Batch"; Rec."Sharescapital Batch")
                {
                    Caption = 'Sharescapital Batch';
                    ToolTip = 'Specifies the value of the Sharescapital Batch field';
                }
                field("MemberExist template"; Rec."MemberExist template")
                {
                    Caption = 'MemberExist template';
                    ToolTip = 'Specifies the value of the MemberExist template field';
                }
                field("MemberExist batch"; Rec."MemberExist batch")
                {
                    Caption = 'MemberExist batch';
                    ToolTip = 'Specifies the value of the MemberExist batch field';
                }
                field("Interest Template"; Rec."Interest Template")
                {
                    Caption = 'Interest Template';
                    ToolTip = 'Specifies the value of the Interest Template field';
                }
                field("Interest Batch"; Rec."Interest Batch")
                {
                    Caption = 'Interest Batch';
                    ToolTip = 'Specifies the value of the Interest Batch field';
                }
                field("Loan Recovery Template"; Rec."Loan Recovery Template")
                {
                    Caption = 'Loan Recovery Template';
                    ToolTip = 'Specifies the value of the Loan Recovery Template field';
                }
                field("Loan Recovery Batch"; Rec."Loan Recovery Batch")
                {
                    Caption = 'Loan Recovery Batch';
                    ToolTip = 'Specifies the value of the Loan Recovery Batch field';
                }
                field("Dividend Template"; Rec."Dividend Template")
                { }
                field("Dividend Batch"; Rec."Dividend Batch")
                { }



            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }
}