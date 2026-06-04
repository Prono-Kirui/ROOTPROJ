tableextension 50001 "ApprovalEntryTableExt" extends "Approval Entry"
{
    fields
    {
        field(50000; "Approval Stage"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Approval Stage';
        }
        field(50001; "Description"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(50002; "Workflow User Group Code"; Code[20])
        {
            TableRelation = "Workflow User Group".Code;
            DataClassification = CustomerContent;
            Caption = 'Workflow User Group Code';
        }
        field(50003; "Delegated From"; Code[50])
        {
            TableRelation = "User Setup";
            DataClassification = CustomerContent;
            Caption = 'Delegated From';
        }
        field(50004; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Date';
        }
        field(50005; "Staff No."; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Staff No.';
        }
        field(50006; "Approver Staff No."; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Approver Staff No.';
        }
        field(50007; "Payroll period start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Payroll period start Date';
        }
    }
}





