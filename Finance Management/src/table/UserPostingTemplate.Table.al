table 51006 "User Posting Template"
{
    Caption = 'User Posting Template';
    DataClassification = CustomerContent;
    fields
    {
        field(1; UserID; Code[50])
        {
            Caption = 'UserID';
            TableRelation = "User Setup";
        }
        field(2; "Receipt Journal Template"; Code[10])
        {
            Caption = 'Receipt Journal Template';
            TableRelation = "Gen. Journal Template".Name where(Type = const("Cash Receipts"));
        }
        field(3; "Receipt Journal Batch"; Code[10])
        {
            Caption = 'Receipt Journal Batch';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Receipt Journal Template"));
        }
        field(4; "Payment Journal Template"; Code[10])
        {
            Caption = 'Payment Journal Template';
            TableRelation = "Gen. Journal Template".Name where(Type = const(Payments));
        }
        field(5; "Payment Journal Batch"; Code[10])
        {
            Caption = 'Payment Journal Batch';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Payment Journal Template"));
        }
        field(6; "Petty Cash Journal Template"; Code[10])
        {
            Caption = 'Petty Cash Journal Template';
            TableRelation = "Gen. Journal Template".Name where(Type = const(Payments));
        }
        field(7; "Petty Cash Journal Batch"; Code[10])
        {
            Caption = 'Petty Cash Journal Batch';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Petty Cash Journal Template"));
        }
        field(8; "Bank Trans. Journal Template"; Code[10])
        {
            Caption = 'Bank Trans. Journal Template';
            TableRelation = "Gen. Journal Template".Name where(Type = const(General));
        }
        field(9; "Bank Trans. Journal Batch"; Code[10])
        {
            Caption = 'Bank Trans. Journal Batch';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Bank Trans. Journal Template"));
        }
        field(10; "Item Journal Template"; Code[10])
        {
            Caption = 'Item Journal Template';
            TableRelation = "Item Journal Template";
        }
        field(11; "Item Journal Batch"; Code[10])
        {
            Caption = 'Item Journal Batch';
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Item Journal Template"));
        }
        field(12; "Payroll Journal Template"; Code[10])
        {
            Caption = 'Payroll Journal Template';
            TableRelation = "Gen. Journal Template".Name where(Type = const(General));
        }
        field(13; "Payroll Journal Batch"; Code[10])
        {
            Caption = 'Payroll Journal Batch';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Payroll Journal Template"));
        }
        field(14; "Job Journal Template"; Code[10])
        {
            Caption = 'Job Journal Template';
            TableRelation = "Job Journal Template".Name;
        }
        field(15; "Job Journal Batch"; Code[10])
        {
            Caption = 'Job Journal Batch';
            TableRelation = "Job Journal Batch".Name where("Journal Template Name" = field("Job Journal Template"));
        }
    }

    keys
    {
        key(Key1; UserID)
        {
            Clustered = true;
        }
    }
}
