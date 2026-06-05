page 51114 "Property Expense Types"
{
    ApplicationArea = All;
    Caption = 'Property Expense Types';
    PageType = List;
    SourceTable = "Receipts and Payment Types";
    SourceTableView = where(Type = filter("Property Expense"));
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Code"; Rec.Code)
                {
                    Caption = 'Code';
                    ToolTip = 'Specifies the value of the Code field';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Account Type"; Rec."Account Type")
                {
                    Caption = 'Account Type';
                    ToolTip = 'Specifies the value of the Account Type field';
                }
                field("Account No."; Rec."Account No.")
                {
                    Caption = 'Account No.';
                    ToolTip = 'Specifies the value of the Account No. field';
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::"Property Expense";
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::"Property Expense";
    end;
}
