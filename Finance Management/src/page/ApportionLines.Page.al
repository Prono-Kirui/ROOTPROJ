page 51089 "Apportion Lines"
{
    ApplicationArea = All;
    Caption = 'Apportion Lines';
    PageType = ListPart;
    SourceTable = "Apportion Lines";
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    Caption = 'G/L Account No.';
                    ToolTip = 'Specifies the value of the G/L Account No. field';
                }
                field("G/L Entry No."; Rec."G/L Entry No.")
                {
                    Caption = 'G/L Entry No.';
                    ToolTip = 'Specifies the value of the G/L Entry No. field';
                }
                field("Document No."; Rec."Document No.")
                {
                    Caption = 'Document No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Document No. field';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Amount field';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field';
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Dimension Set ID field';
                }
                field("Document Date"; Rec."Document Date")
                {
                    Caption = 'Document Date';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Document Date field';
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    Caption = 'Bal. Account Type';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Bal. Account Type field';
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    Caption = 'Bal. Account No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Bal. Account No. field';
                }
                field("Posted By"; Rec."User ID")
                {
                    Caption = 'User ID';
                    Editable = false;
                    ToolTip = 'Specifies the value of the User ID field';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Caption = 'External Document No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the External Document No. field';
                }
                field("Source Type"; Rec."Source Type")
                {
                    Caption = 'Source Type';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Source Type field';
                }
                field("Source No."; Rec."Source No.")
                {
                    Caption = 'Source No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Source No. field';
                }
                field(Posted; Rec.Posted)
                {
                    Caption = 'Posted';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Posted field';
                }
            }
        }
    }
}
