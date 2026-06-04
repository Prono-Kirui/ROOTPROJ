table 50001 "User Changes"
{
    Caption = 'User Changes';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "User Name"; Code[50])
        {
            Caption = 'User Name';
            TableRelation = "User Setup"."User ID";

            trigger OnValidate()
            var
                User: Record User;
            begin
                User.SetRange("User Name", "User Name");
                if User.FindFirst() then
                    "User Security ID" := User."User Security ID";
            end;
        }
        field(3; "Created By"; Code[50])
        {
            Caption = 'Created By';
        }
        field(4; Reason; Text[100])
        {
            Caption = 'Reason';
        }
        field(5; Status; Enum ApprovalStatus)
        {
            Caption = 'Status';
        }
        field(6; Posted; Boolean)
        {
            Caption = 'Posted';
        }
        field(7; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(8; "Change Type"; Enum "User Change Type")
        {
            Caption = 'Change Type';
        }
        field(9; "User Security ID"; Guid)
        {
            Caption = 'User Security ID';
        }
        field(10; "Approved Date"; Date)
        {
            Caption = 'Approved Date';
        }
        field(11; "Approved By"; Code[50])
        {
            Caption = 'Approved By';
        }
    }
    keys
    {
        key(PK; "Document No.")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    begin
        if "Document No." = '' then begin
            ICTSetup.Get();
            ICTSetup.TestField("Password Reset Nos");

            //  NoSeriesManagement.InitSeries(ICTSetup."Password Reset Nos", xRec."No. Series", 0D, "Document No.", "No. Series");
        end;

        "Created By" := UserId();
    end;

    var
        // NoSeriesManagement: Codeunit NoSeriesManagement;
        ICTSetup: Record "ICT Setup";
}






