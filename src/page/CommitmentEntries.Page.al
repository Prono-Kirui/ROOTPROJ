page 50006 "Commitment Entries"
{
    Editable = true;
    PageType = List;
    SourceTable = "Commitment Entries";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Commitment No"; Rec."Commitment No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Commitment No field';
                }
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No field';
                }
                field("Commitment Date"; Rec."Commitment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Commitment Date field';
                }
                field("Commitment Type"; Rec."Commitment Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Commitment Type field';
                }
                field(Account; Rec.Account)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account field';
                }
                field("Committed Amount"; Rec."Committed Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Committed Amount field';
                }
                field(User; Rec.User)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User field';
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No field';
                }
                field("Global Dimension 1"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 1 field';
                }
                field("Global Dimension 2"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 2 field';
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account No. field';
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account Name field';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dimension Set ID field';
                }
                field("Last Modified By"; Rec."Last Modified By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Modified By field';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Type field';
                }
                field("Budget Code"; Rec."Budget Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Budget Code field';
                }
            }
        }
    }

    actions
    {
    }
}





