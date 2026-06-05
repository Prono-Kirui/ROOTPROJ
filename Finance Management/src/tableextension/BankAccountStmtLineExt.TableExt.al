tableextension 51016 "Bank Account Stmt Line Ext" extends "Bank Account Statement Line"
{
    fields
    {
        field(51000; Reconciled; Boolean)
        {
            Caption = 'Reconciled';
            trigger OnValidate()
            begin
                //check if the type of entry that the user has selected is difference
                if (Type = Type::Difference) or ("Document No." = '') then
                    Error('Differences cannot be reconciled');
            end;
        }
        field(51001; Imported; Boolean)
        {
            Caption = 'Imported';
        }
        field(51002; "Open Type"; Option)
        {
            Caption = 'Open Type';
            OptionCaption = ' ,Unpresented Cheques List,Uncredited Cheques Lit,Items not in cash book';
            OptionMembers = " ",Unpresented,Uncredited,Manual;
        }
        field(51003; "Debit Amount"; Decimal)
        {
            Caption = 'Debit Amount';
            DataClassification = ToBeClassified;
        }
        field(51004; "Credit Amount"; Decimal)
        {
            Caption = 'Credit Amount';
            DataClassification = ToBeClassified;
        }
        field(51005; "Cheque Number"; Code[20])
        {
            Caption = 'Cheque Number';
            DataClassification = ToBeClassified;
        }
    }
}
