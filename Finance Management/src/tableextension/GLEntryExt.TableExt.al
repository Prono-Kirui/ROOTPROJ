tableextension 51012 "GL_EntryExt" extends "G/L Entry"
{
    fields
    {
        field(51000; Apportioned; Boolean)
        {
            Caption = 'Apportioned';
            DataClassification = CustomerContent;
        }
        field(51001; Payee; Text[250])
        {
            Caption = 'Payee';
            DataClassification = CustomerContent;
        }
    }
}
