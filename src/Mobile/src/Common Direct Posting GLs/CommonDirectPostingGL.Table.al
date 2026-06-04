table 50804 "Common Direct Posting GL"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Description"; Option)
        {
            DataClassification = ToBeClassified;

            OptionMembers = "Withholding Tax","Exit Fee","ReEntrance Fee","Bridge Fee","Excise Duty","Top up Comission","New ATM Fee","Replaced ATM Fee","Renewed ATM Fee","Dividend Processing Fee","External Loan Charge","FO Registration Fee","BO Registration Fee","ATM Processing Fee","Cheque Discounting Fee","Salary Processing Fee","SMS Charge Fee","Loan Trasfer Fee-FOSA","Loan Trasfer Fee-Cheque","Loan Trasfer Fee-EFT","Loan Trasfer Fee-RTGS","Cheque Clearing Fee Account","Boosting Fees Account","Loan Interest GL","Micro Entrance Fee","Rejoining Fee","Partial Deposit Refund Fee A/C","Share Capital Transfer Fee","Charge on Loan Exit GL","Charge FOSA Registration Fee","BOSA Registration Fee Amount","Group Fee","Early withdrawal Charge","Extra Fee G/L","Benevolent Fund G/L","Charge on loan offset","Exit Loan charge","Recruiter Expense","Mobile Charges","CFT Commission","INHOUSE Cheque Clearing GL Account","LOCAL Cheque Clearing GL Account","INHOUSE Bounced Charges GL Account","LOCAL Bounced Charges GL Account","VAS Commisson GL","VAS Float GL","Safaricom Charges";

        }
        field(2; "G/L Account"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
            trigger OnValidate()
            var
                ObjGLAccount: Record "G/L Account";
            begin
                if ObjGLAccount.Get("G/L Account") then
                    "G/L Account Name" := ObjGLAccount.Name;
            end;

        }
        field(3; "G/L Account Name"; Code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(4; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                If "Is Percentage" = true then
                    If Rec.Amount > 100 then begin
                        Error('Percentage amount may not be greater than 100 %.');
                    end;
            end;
        }
        field(5; "Is Percentage"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Is Active"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Last Modified Date Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Last Modified By"; Code[100])
        {

        }

    }

    keys
    {


        key(Key1; "Description")

        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin
        "Last Modified By" := UserId;
        "Last Modified Date Time" := CurrentDateTime;
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;


}