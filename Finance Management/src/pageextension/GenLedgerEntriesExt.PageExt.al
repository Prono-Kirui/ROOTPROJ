pageextension 51011 "Gen Ledger Entries Ext" extends "General Ledger Entries"
{
    layout
    {
        modify("G/L Account Name")
        {
            Visible = true;
        }
        modify(Reversed)
        {
            Visible = true;
        }
        modify("User ID")
        {
            Visible = true;
        }
        modify("Additional-Currency Amount")
        {
            Visible = true;
        }

        addlast(Control1)
        {
            field("Add.-Currency Debit Amount"; Rec."Add.-Currency Debit Amount")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Add.-Currency Debit Amount field.', Comment = '%';
            }
            field("Add.-Currency Credit Amount"; Rec."Add.-Currency Credit Amount")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Add.-Currency Credit Amount field.', Comment = '%';
            }
            field(Payee; Rec.Payee)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Payee field.', Comment = '%';
            }
        }
    }
}
