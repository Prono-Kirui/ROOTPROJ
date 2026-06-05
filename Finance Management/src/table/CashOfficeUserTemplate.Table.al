table 51007 "Cash Office User Template"
{
    Caption = 'Cash Office User Template';
    DataClassification = CustomerContent;
    fields
    {
        field(1; UserID; Code[50])
        {
            Caption = 'UserID';
            Description = 'Stores the reference of the user in the database';
            NotBlank = true;
            TableRelation = "User Setup"."User ID";
        }
        field(2; "Receipt Journal Template"; Code[20])
        {
            Caption = 'Receipt Journal Template';
            Description = 'Stores the reference of the receipt journal template in the database';
            TableRelation = "Gen. Journal Template".Name where(Type = const("Cash Receipts"));
        }
        field(3; "Receipt Journal Batch"; Code[20])
        {
            Caption = 'Receipt Journal Batch';
            Description = 'Stores the reference of the receipt journal batch in the database';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Receipt Journal Template"));

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another User*/

                UserTemp.Reset();
                UserTemp.SetRange(UserTemp."Receipt Journal Template", "Receipt Journal Template");
                UserTemp.SetRange(UserTemp."Receipt Journal Batch", "Receipt Journal Batch");
                if UserTemp.FindFirst() then
                    repeat
                        if UserTemp.UserID <> Rec.UserID then
                            Error('Please note that another user has been assigned the same batch.');
                    until UserTemp.Next() = 0;
            end;
        }
        field(4; "Payment Journal Template"; Code[20])
        {
            Caption = 'Payment Journal Template';
            Description = 'Stores the reference of the payment journal template in the database';
            TableRelation = "Gen. Journal Template".Name where(Type = const(Payments));
        }
        field(5; "Payment Journal Batch"; Code[20])
        {
            Caption = 'Payment Journal Batch';
            Description = 'Stores the reference of the payment journal batch in the database';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Payment Journal Template"));

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another User*/
                UserTemp.Reset();
                UserTemp.SetRange(UserTemp."Payment Journal Template", "Payment Journal Template");
                UserTemp.SetRange(UserTemp."Payment Journal Batch", "Payment Journal Batch");
                if UserTemp.FindFirst() then
                    repeat
                        if UserTemp.UserID <> Rec.UserID then
                            Error('Please note that another user has been assigned the same batch.');
                    until UserTemp.Next() = 0;
            end;
        }
        field(6; "Petty Cash Template"; Code[20])
        {
            Caption = 'Petty Cash Template';
            Description = 'Stores the reference to the petty cash payment voucher in the database';
            TableRelation = "Gen. Journal Template".Name where(Type = const(Payments));
        }
        field(7; "Petty Cash Batch"; Code[20])
        {
            Caption = 'Petty Cash Batch';
            Description = 'Stores the reference of the petty cash payment batch in the database';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Petty Cash Template"));

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another User*/
                UserTemp.Reset();
                UserTemp.SetRange(UserTemp."Petty Cash Template", "Petty Cash Template");
                UserTemp.SetRange(UserTemp."Petty Cash Batch", "Petty Cash Batch");
                if UserTemp.FindFirst() then
                    repeat
                        if UserTemp.UserID <> Rec.UserID then
                            Error('Please note that another user has been assigned the same batch.');
                    until UserTemp.Next() = 0;
            end;
        }
        field(8; "Inter Bank Template Name"; Code[20])
        {
            Caption = 'Inter Bank Template Name';
            Description = 'Stores the reference of the petty cash payment batch in the database';
            TableRelation = "Gen. Journal Template".Name where(Type = const(Payments));
        }
        field(9; "Inter Bank Batch Name"; Code[20])
        {
            Caption = 'Inter Bank Batch Name';
            Description = 'Stores the reference to the inter bank transfer batch in the database';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Inter Bank Template Name"));

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another User*/

                UserTemp.Reset();
                UserTemp.SetRange(UserTemp."Inter Bank Template Name", "Inter Bank Template Name");
                UserTemp.SetRange(UserTemp."Inter Bank Batch Name", "Inter Bank Batch Name");
                if UserTemp.FindFirst() then
                    repeat
                        if UserTemp.UserID <> Rec.UserID then
                            Error('Please note that another user has been assigned the same batch.');
                    until UserTemp.Next() = 0;
            end;
        }
        field(10; "Default Receipts Bank"; Code[20])
        {
            Caption = 'Default Receipts Bank';
            Description = 'Stores the reference to the default receipts bank deposit account';
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another User*/
                UserTemp.Reset();
                UserTemp.SetRange(UserTemp."Default Receipts Bank", "Default Receipts Bank");
                if UserTemp.FindFirst() then
                    repeat
                        if UserTemp.UserID <> Rec.UserID then
                            Error('Please note that another user has been assigned the same bank.');
                    until UserTemp.Next() = 0;
            end;
        }
        field(11; "Default Payment Bank"; Code[20])
        {
            Caption = 'Default Payment Bank';
            Description = 'Stores the reference to the default payments bank deposit account';
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another User*/
                UserTemp.Reset();
                UserTemp.SetRange(UserTemp."Default Payment Bank", "Default Payment Bank");
                if UserTemp.FindFirst() then
                    repeat
                        if UserTemp.UserID <> Rec.UserID then
                            Error('Please note that another user has been assigned the same bank.');
                    until UserTemp.Next() = 0;
            end;
        }
        field(12; "Default Petty Cash Bank"; Code[20])
        {
            Caption = 'Default Petty Cash Bank';
            Description = 'Stores the reference to the default petty cash account in the database';
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another User*/
                UserTemp.Reset();
                UserTemp.SetRange(UserTemp."Default Petty Cash Bank", "Default Petty Cash Bank");
                if UserTemp.FindFirst() then
                    repeat
                        if UserTemp.UserID <> Rec.UserID then
                            Error('Please note that another user has been assigned the same bank.');
                    until UserTemp.Next() = 0;
            end;
        }
        field(13; "Max. Cash Collection"; Decimal)
        {
            Caption = 'Max. Cash Collection';
        }
        field(14; "Max. Cheque Collection"; Decimal)
        {
            Caption = 'Max. Cheque Collection';
        }
        field(15; "Max. Deposit Slip Collection"; Decimal)
        {
            Caption = 'Max. Deposit Slip Collection';
        }
        field(16; "Supervisor ID"; Code[20])
        {
            Caption = 'Supervisor ID';
            Description = 'Stores the reference for the supervisor for the specific teller';

            trigger OnValidate()
            begin
                //LoginMgt.ValidateUserID("Supervisor ID");
            end;

            trigger OnLookup()
            begin
                //LoginMgt.LookupUserID("Supervisor ID");
            end;
        }
        field(17; "Bank Pay In Journal Template"; Code[20])
        {
            Caption = 'Bank Pay In Journal Template';
            TableRelation = "Gen. Journal Template".Name where(Type = const(General));
        }
        field(18; "Bank Pay In Journal Batch"; Code[20])
        {
            Caption = 'Bank Pay In Journal Batch';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Bank Pay In Journal Template"));

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another User*/
                UserTemp.Reset();
                UserTemp.SetRange(UserTemp."Bank Pay In Journal Template", "Bank Pay In Journal Template");
                UserTemp.SetRange(UserTemp."Bank Pay In Journal Batch", "Bank Pay In Journal Batch");
                if UserTemp.FindFirst() then
                    repeat
                        if UserTemp.UserID <> Rec.UserID then
                            Error('Please note that another user has been assigned the same batch.');
                    until UserTemp.Next() = 0;
            end;
        }
        field(19; "Imprest Template"; Code[20])
        {
            Caption = 'Imprest Template';
            TableRelation = "Gen. Journal Template";
        }
        field(20; "Imprest  Batch"; Code[20])
        {
            Caption = 'Imprest  Batch';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Imprest Template"));
        }
        field(21; "Claim Template"; Code[20])
        {
            Caption = 'Claim Template';
            TableRelation = "Gen. Journal Template";
        }
        field(22; "Claim  Batch"; Code[20])
        {
            Caption = 'Claim  Batch';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Claim Template"));
        }
        field(23; "Advance Template"; Code[20])
        {
            Caption = 'Other Advance Template';
            TableRelation = "Gen. Journal Template";
        }
        field(24; "Advance  Batch"; Code[20])
        {
            Caption = 'Other Advance  Batch';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Advance Template"));
        }
        field(25; "Advance Surr Template"; Code[20])
        {
            Caption = 'Other Advance Surr Template';
            TableRelation = "Gen. Journal Template";
        }
        field(26; "Advance Surr Batch"; Code[20])
        {
            Caption = 'Other Advance Surr Batch';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Advance Surr Template"));
        }
        field(27; "Imprest Sur Template"; Code[20])
        {
            Caption = 'Imprest Sur Template';
            TableRelation = "Gen. Journal Template".Name where(Type = const(Payments));
        }
        field(28; "Imprest Sur Batch"; Code[20])
        {
            Caption = 'Imprest Sur Batch';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Payment Journal Template"));
        }
    }

    keys
    {
        key(Key1; UserID)
        {
            Clustered = true;
        }
    }

    var
        UserTemp: Record "Cash Office User Template";
}
