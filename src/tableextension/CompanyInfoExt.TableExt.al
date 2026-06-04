tableextension 50008 "CompanyInfoExt" extends "Company Information"
{
    fields
    {
        field(50000; "Company PIN No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Company PIN No.';
        }
        field(50001; "Bank Account Name"; Text[50])
        {
            Caption = 'Bank Name';
            DataClassification = CustomerContent;
        }
        field(50002; "Bank Name 2"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Bank Name 2';
        }
        field(50003; "Bank Branch No.2"; Text[20])
        {
            Caption = 'Bank Branch No.';
            DataClassification = CustomerContent;
        }
        field(50004; "Bank Account No.2"; Text[30])
        {
            Caption = 'Bank Account No.';
            DataClassification = CustomerContent;
        }
        field(50005; "SWIFT Code2"; Code[20])
        {
            Caption = 'SWIFT Code';
            DataClassification = CustomerContent;
        }
        field(50006; "Bank Account Name2"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Bank Account Name2';
        }
        field(50007; "MPESA Paybill"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'MPESA Paybill';
        }
        field(50008; "Bank Branch Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Bank Branch Name';
        }
        field(50009; "Bank Branch Name2"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Bank Branch Name2';
        }
        field(50010; "Document Path"; text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Document Path';
        }
        field(50011; "E-Mail Signature"; Blob)
        {
            DataClassification = CustomerContent;
            Subtype = Memo;
            Caption = 'E-Mail Signature';
        }
        field(50012; "Online Document Path"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Online Document Path';
        }
        field(50013; "Company Bank Details"; Blob)
        {
            DataClassification = CustomerContent;
            Subtype = Memo;
            Caption = 'Company Bank Details';
        }
    }
}





