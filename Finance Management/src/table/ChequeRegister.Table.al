table 51002 "Cheque Register"
{
    Caption = 'Cheque Register';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Cheque No."; Code[10])
        {
            Caption = 'Cheque No.';
        }
        field(2; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            TableRelation = "Bank Account";
        }
        field(3; "Date Generated"; Date)
        {
            Caption = 'Date Generated';
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(5; "Cheque Date"; Date)
        {
            Caption = 'Cheque Date';
        }
        field(6; "Bank Payment Type"; Option)
        {
            Caption = 'Bank Payment Type';
            OptionCaption = ' ,Computer Check,Manual Check,Electronic Payment';
            OptionMembers = " ","Computer Check","Manual Check","Electronic Payment";
        }
        field(7; "Entry Status"; Option)
        {
            Caption = 'Entry Status';
            OptionCaption = ',Printed,Voided,Posted,Financially Voided,Test Print,Exported,Transmitted,Issued,Cancelled';
            OptionMembers = ,Printed,Voided,Posted,"Financially Voided","Test Print",Exported,Transmitted,Issued,Cancelled;
        }
        field(8; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = User."User Name";

            //This property is currently not supported
            //TestTableRelation = false;
            trigger OnLookup()
            begin
                //UserMgt.LookupUserID("User ID");
            end;
        }
        field(9; "Issued By"; Code[50])
        {
            Caption = 'Issued By';
        }
        field(10; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
        }
        field(11; "Issued Doc No."; Code[50])
        {
            Caption = 'Issued Doc No.';
        }
        field(12; Issued; Boolean)
        {
            Caption = 'Issued';
        }
        field(13; Voided; Boolean)
        {
            Caption = 'Voided';
        }
        field(14; "Voided By"; Code[50])
        {
            Caption = 'Voided By';
        }
        field(15; "Void Date-Time"; DateTime)
        {
            Caption = 'Void Date-Time';
        }
        field(16; Cancelled; Boolean)
        {
            Caption = 'Cancelled';
        }
        field(17; "Cancelled By"; Code[50])
        {
            Caption = 'Cancelled By';
        }
        field(18; "Cancelled Date-Time"; DateTime)
        {
            Caption = 'Cancelled Date-Time';
        }
    }

    keys
    {
        key(Key1; "Cheque No.", "Bank Account No.")
        {
            Clustered = true;
        }
    }
}
