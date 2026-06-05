page 51100 "Processed IC Apportions"
{
    ApplicationArea = All;
    Caption = 'Processed IC Apportions';
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Apportionment Entry";
    SourceTableView = where(Processed = const(true));
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Document No."; Rec."Document No.")
                {
                    Caption = 'Document No.';
                    ToolTip = 'Specifies the value of the Document No. field';
                }
                field(Company; Rec.Company)
                {
                    Caption = 'Company';
                    ToolTip = 'Specifies the value of the Company field';
                }
                field(Allocation; Rec.Allocation)
                {
                    Caption = 'Allocation (%)';
                    ToolTip = 'Specifies the value of the Allocation (%) field';
                }
                field("Posted Doc No."; Rec."Posted Doc No.")
                {
                    Caption = 'Posted Doc No.';
                    ToolTip = 'Specifies the value of the Posted Doc No. field';
                }
                field(Processed; Rec.Processed)
                {
                    Caption = 'Processed';
                    ToolTip = 'Specifies the value of the Processed field';
                }
                field("Expense Account"; Rec."Expense Account")
                {
                    Caption = 'Expense Account';
                    ToolTip = 'Specifies the value of the Expense Account field';
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                    ToolTip = 'Specifies the value of the Amount field';
                }
                field("Apportioned Amount"; Rec."Apportioned Amount")
                {
                    Caption = 'Apportioned Amount';
                    ToolTip = 'Specifies the value of the Apportioned Amount field';
                }
                field("Line No"; Rec."Line No")
                {
                    Caption = 'Line No';
                    ToolTip = 'Specifies the value of the Line No field';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                    ToolTip = 'Specifies the value of the Posting Date field';
                }
                field("G/L Entry No"; Rec."G/L Entry No")
                {
                    Caption = 'G/L Entry No';
                    ToolTip = 'Specifies the value of the G/L Entry No field';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code';
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field';
                }
                field("Document Date"; Rec."Document Date")
                {
                    Caption = 'Document Date';
                    ToolTip = 'Specifies the value of the Document Date field';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Caption = 'External Document No.';
                    ToolTip = 'Specifies the value of the External Document No. field';
                }
                field("Amount To Post"; Rec."Amount To Post")
                {
                    Caption = 'Amount To Post';
                    ToolTip = 'Specifies the value of the Amount To Post field';
                }
                field("Apportion Doc No."; Rec."Apportion Doc No.")
                {
                    Caption = 'Apportion Doc No.';
                    ToolTip = 'Specifies the value of the Apportion Doc No. field';
                }
                field("Processed Date-Time"; Rec."Processed Date-Time")
                {
                    Caption = 'Processed Date-Time';
                    ToolTip = 'Specifies the value of the Processed Date-Time field';
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID';
                    ToolTip = 'Specifies the value of the Dimension Set ID field';
                }
                field("Prepared Date-Time"; Rec."Prepared Date-Time")
                {
                    Caption = 'Prepared Date-Time';
                    ToolTip = 'Specifies the value of the Prepared Date-Time field';
                }
            }
        }
    }
}
