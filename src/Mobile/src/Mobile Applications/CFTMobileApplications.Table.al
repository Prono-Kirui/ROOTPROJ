table 50800 "CFTMobile Applications"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {

            DataClassification = ToBeClassified;
        }
        field(2; "Current Account No"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." WHERE(Status = filter(Active));

            trigger OnValidate()
            var
                CustomerRec: Record Customer;
                ExistingApplication: Record "CFTMobile Applications";
            begin

                Clear("Account Name");
                Clear(Telephone);
                Clear("ID No");
                Clear("Date Applied");
                Clear("Time Applied");
                Clear("Created By");

                CustomerRec.Reset();
                CustomerRec.SetRange("No.", "Current Account No");
                CustomerRec.SetFilter("Status", '%1', CustomerRec.Status::Active);
                if CustomerRec.FindFirst() then begin
                    if CustomerRec."Phone No." = '' then begin
                        Error('The selected customer does not have a mobile number. Go please add');
                    end;
                    Rec."Member No." := CustomerRec."No.";
                    Rec."Account Name" := CustomerRec.Name;
                    Rec."Telephone" := CustomerRec."Phone No.";
                    Rec."Time Applied" := Time;
                    Rec."Date Applied" := Today;
                    Rec."Created By" := UserId;
                    Rec."ID No" := CustomerRec."ID No.";
                    Rec."Current Account Status" := Format(CustomerRec."Status");

                end;

                // Check for duplicate Account No in the CFTMobile Applications table
                // Filter by Account No and exclude the current record if it's an update
                ExistingApplication.SetRange("Current Account No", Rec."Current Account No");
                if Rec."No." <> '' then
                    ExistingApplication.SetRange("No.", Rec."No."); // Exclude the current record if it's an update

                if ExistingApplication.FindFirst() then begin
                    Error('An application already exists for Current Account No: %1. A user can only have one mobile application.', Rec."Current Account No");
                end;
            end;

        }


        field(3; "Account Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Telephone"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "ID No"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(6; "Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Open","Pending Approval","Approved","Active";

        }
        field(7; "Date Applied"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Time Applied"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if Rec."No. Series" = '' then
                    Rec."No. Series" := 'CPO';
            end;
        }
        field(12; "SentToServer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Mobile Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Active","Inactive";
        }
        field(14; "Last PIN Reset"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Reset By"; Text[100])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "Reset By" <> '' then begin
                    "Reset By" := UserId;
                    "Last PIN Reset" := Today;
                    "Last PIN Reset Time" := CurrentDateTime();
                end;
            end;
        }
        field(16; "Activated By"; Text[100])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "Activated By" <> '' then begin
                    "Activated By" := UserId;
                    "Last Activation" := CurrentDateTime();
                end;
            end;
        }
        field(17; "Last Activation"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Member No."; Code[22])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "CFT Registered"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "UpdateNos"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Transaction Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "PIN Reset";
        }
        field(22; "Response Message"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Last PIN Reset Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Till Registered"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Current Account Status"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    var
        recBoGeneralSetup: Record "BO General Setup";
        NoSeriesMngt: Codeunit NoSeriesManagement;

    trigger OnInsert()

    begin

        recBoGeneralSetup.Get();
        recBoGeneralSetup.TestField(recBoGeneralSetup."Mobile Application Nos");
        NoSeriesMngt.InitSeries(recBoGeneralSetup."Mobile Application Nos", recBoGeneralSetup."Mobile Application Nos", 0D, "No.", recBoGeneralSetup."Mobile Application Nos");

        if Rec."No. Series" = '' then
            Rec."No. Series" := 'CPO';

    end;


    trigger OnDelete()
    begin

        IF Rec."Approval Status" <> Rec."Approval Status"::Open then
            Error('You can not delete any mobile application document. Please contact your system administrator.');

    end;






}
