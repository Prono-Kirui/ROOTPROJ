tableextension 51014 "Gen_JournalExt" extends "Gen. Journal Line"
{
    fields
    {
        field(51000; "EFT Reference"; Code[50])
        {
            Caption = 'EFT Reference';
            DataClassification = CustomerContent;
        }
        field(51001; Apportioned; Boolean)
        {
            Caption = 'Apportioned';
            DataClassification = CustomerContent;
        }
        // field(51002; "User ID"; Code[50])
        // {
        //     Caption = 'User ID';
        //     DataClassification = CustomerContent;
        // }
        field(51003; Payee; Text[250])
        {
            Caption = 'Payee';
            DataClassification = CustomerContent;
        }
    }

    trigger OnAfterInsert()
    begin
        "User ID" := CopyStr(UserId(), 1, MaxStrLen("User ID"));
    end;
}
