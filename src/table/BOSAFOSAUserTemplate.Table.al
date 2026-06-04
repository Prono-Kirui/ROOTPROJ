table 50707 "BOSA&FOSA User Template"
{
    Caption = 'BOSA & FOSA User Template';
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
        field(6; "Membership Template"; Code[20])
        {
            Caption = 'Membership Template';
            Description = 'Stores the reference to the membership template in the database';
            TableRelation = "Gen. Journal Template".Name where(Type = const(General));
        }
        field(7; "Membership Batch"; Code[20])
        {
            Caption = 'Membership Batch';
            Description = 'Stores the reference of the membership batch in the database';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Membership Template"));

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another User*/
                UserTemp.Reset();
                UserTemp.SetRange(UserTemp."Membership Template", "Membership Template");
                UserTemp.SetRange(UserTemp."Membership Batch", "Membership Batch");
                if UserTemp.FindFirst() then
                    repeat
                        if UserTemp.UserID <> Rec.UserID then
                            Error('Please note that another user has been assigned the same batch.');
                    until UserTemp.Next() = 0;
            end;
        }
        field(8; "Member receipt Template Name"; Code[20])
        {
            Caption = 'Member receipt Template Name';
            Description = 'Stores the reference of the member receipt template in the database';
            TableRelation = "Gen. Journal Template".Name where(Type = const(General));
        }
        field(9; "Member receipt Batch Name"; Code[20])
        {
            Caption = 'Member receipt Batch Name';
            Description = 'Stores the reference to the member receipt batch in the database';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Member receipt Template Name"));

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another User*/

                UserTemp.Reset();
                UserTemp.SetRange(UserTemp."Member receipt Template Name", "Member receipt Template Name");
                UserTemp.SetRange(UserTemp."Member receipt Batch Name", "Member receipt Batch Name");
                if UserTemp.FindFirst() then
                    repeat
                        if UserTemp.UserID <> Rec.UserID then
                            Error('Please note that another user has been assigned the same batch.');
                    until UserTemp.Next() = 0;
            end;
        }
        field(10; "loan Template Name"; Code[20])
        {
            Caption = 'loan Template Name';
            Description = 'Stores the reference to the loan template in the database';
            TableRelation = "Gen. Journal Template".Name where(Type = const(General));
        }
        field(11; "loan Batch Name"; Code[20])
        {
            Caption = 'loan Batch Name';
            Description = 'Stores the reference to the loan batch in the database';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("loan Template Name"));

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another User*/

                UserTemp.Reset();
                UserTemp.SetRange(UserTemp."loan Template Name", "loan Template Name");
                UserTemp.SetRange(UserTemp."loan Batch Name", "loan Batch Name");
                if UserTemp.FindFirst() then
                    repeat
                        if UserTemp.UserID <> Rec.UserID then
                            Error('Please note that another user has been assigned the same batch.');
                    until UserTemp.Next() = 0;
            end;
        }

        field(12; "Member Transfer Template Name"; Code[20])
        {
            Caption = 'Member Transfer Template Name';
            Description = 'Stores the reference to the member transfer template in the database';
            TableRelation = "Gen. Journal Template".Name where(Type = const(General));

            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another User*/

            end;
        }
        field(13; "Member Transfer Batch Name"; Code[20])
        {
            Caption = 'Member Transfer Batch Name';
            Description = 'Stores the reference to the member transfer batch in the database';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Member Transfer Template Name"));
            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another User*/

                UserTemp.Reset();
                UserTemp.SetRange(UserTemp."Member Transfer Template Name", "Member Transfer Template Name");
                UserTemp.SetRange(UserTemp."Member Transfer Batch Name", "Member Transfer Batch Name");
                if UserTemp.FindFirst() then
                    repeat
                        if UserTemp.UserID <> Rec.UserID then
                            Error('Please note that another user has been assigned the same batch.');
                    until UserTemp.Next() = 0;
            end;


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

        field(27; "Sharescapital Template"; Code[20])
        {
            Caption = 'Sharescapital Template';
            TableRelation = "Gen. Journal Template".Name where(Type = const(General));
        }
        field(28; "Sharescapital Batch"; Code[20])
        {
            Caption = 'Sharescapital Batch';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Sharescapital Template"));
        }
        //MemberExist
        field(29; "MemberExist template"; Code[20])
        {
            Caption = 'MemberExist template';
            TableRelation = "Gen. Journal Template".Name where(Type = const(General));
        }
        field(30; "MemberExist Batch"; Code[20])
        {
            Caption = 'MemberExist Batch';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("MemberExist template"));
            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another User*/
                UserTemp.Reset();
                UserTemp.SetRange(UserTemp."MemberExist template", "MemberExist template");
                UserTemp.SetRange(UserTemp."MemberExist Batch", "MemberExist Batch");
                if UserTemp.FindFirst() then
                    repeat
                        if UserTemp.UserID <> Rec.UserID then
                            Error('Please note that another user has been assigned the same batch.');
                    until UserTemp.Next() = 0;

            end;
        }
        //interest template
        field(31; "Interest Template"; Code[20])
        {
            Caption = 'Interest Template';
            TableRelation = "Gen. Journal Template".Name where(Type = const(General));
        }
        field(32; "Interest Batch"; Code[20])
        {
            Caption = 'Interest Batch';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Interest Template"));
            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another User*/
                UserTemp.Reset();
                UserTemp.SetRange(UserTemp."Interest Template", "Interest Template");
                UserTemp.SetRange(UserTemp."Interest Batch", "Interest Batch");
                if UserTemp.FindFirst() then
                    repeat
                        if UserTemp.UserID <> Rec.UserID then
                            Error('Please note that another user has been assigned the same batch.');
                    until UserTemp.Next() = 0;
            end;
        }
        //Divivdend template
        field(33; "Dividend Template"; Code[20])
        {
            Caption = 'Dividend Template';
            TableRelation = "Gen. Journal Template".Name where(Type = const(General));
        }
        field(34; "Dividend Batch"; Code[20])
        {
            Caption = 'Dividend Batch';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Dividend Template"));
            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another User*/
                // UserTemp.Reset();
                // UserTemp.SetRange(UserTemp."Dividend Template", "Dividend Template");
                // UserTemp.SetRange(UserTemp."Dividend Batch", "Dividend Batch");
                // if UserTemp.FindFirst() then
                //     repeat
                //         if UserTemp.UserID <> Rec.UserID then
                //             Error('Please note that another user has been assigned the same batch.');
                //     until UserTemp.Next() = 0;
            end;
        }
        //Loan Recovery Template
        field(35; "Loan Recovery Template"; Code[20])
        {
            Caption = 'Loan Recovery Template';
            TableRelation = "Gen. Journal Template".Name where(Type = const(General));
        }
        field(36; "Loan Recovery Batch"; Code[20])
        {
            Caption = 'Loan Recovery Batch';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Loan Recovery Template"));
            trigger OnValidate()
            begin
                /*Check if the batch has been allocated to another User*/
                UserTemp.Reset();
                UserTemp.SetRange(UserTemp."Loan Recovery Template", "Loan Recovery Template");
                UserTemp.SetRange(UserTemp."Loan Recovery Batch", "Loan Recovery Batch");
                if UserTemp.FindFirst() then
                    repeat
                        if UserTemp.UserID <> Rec.UserID then
                            Error('Please note that another user has been assigned the same batch.');
                    until UserTemp.Next() = 0;
            end;
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
        UserTemp: Record "BOSA&FOSA User Template";
}
