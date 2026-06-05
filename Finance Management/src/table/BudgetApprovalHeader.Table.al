table 51009 "Budget Approval Header"
{
    Caption = 'Budget Approval Header';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Document No."; Code[50])
        {
            Caption = 'Document No.';

            trigger OnValidate()
            begin
                if "Document No." <> xRec."Document No." then begin
                    GeneralLedgerSetup.Get();
                    NoSeriesManagement.TestManual(GeneralLedgerSetup."Budget Approval Nos");
                    "No Series" := '';
                end;
            end;
        }
        field(2; "Date Created"; Date)
        {
            Caption = 'Date Created';
        }
        field(3; "Time Created"; Time)
        {
            Caption = 'Time Created';
        }
        field(4; "Budget Name"; Code[10])
        {
            Caption = 'Budget Name';
            /* TableRelation = if ("Budget Option" = const(Budgeting)) "G/L Budget Name".Name where("Budget Status" = filter(Open))
            else
            if ("Budget Option" = const(ReAllocation)) "G/L Budget Name".Name where("Budget Status" = filter(Approved))
            else
            if ("Budget Option" = const("Procurement Plan")) "Procurement Plan".Name
            else
            if ("Budget Option" = const("Procurement Plan Review")) "Procurement Plan".Name where(Status = const(Approved))
            else
            if ("Budget Option" = const(" ")) "G/L Budget Name"; */

            trigger OnValidate()
            begin
                /* if "Budget Option" = "Budget Option"::"Procurement Plan Review" then begin
                    ProcPlanApprovalLines.SetRange("Document No.", "Document No.");
                    ProcPlanApprovalLines.DeleteAll();

                    ProcurementPlanItems.Reset();
                    ProcurementPlanItems.SetRange("Plan Year", "Budget Name");
                    if ProcurementPlanItems.FindSet() then
                        repeat
                            EntryNo := EntryNo + 10000;
                            ProcPlanApprovalLines.Init();
                            ProcPlanApprovalLines.TransferFields(ProcurementPlanItems);
                            ProcPlanApprovalLines."Document No." := "Document No.";
                            ProcPlanApprovalLines."Entry No." := EntryNo;
                            ProcPlanApprovalLines.Insert();
                        until ProcurementPlanItems.Next() = 0;
                end; */
            end;
        }
        field(5; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(6; "User ID"; Code[70])
        {
            Caption = 'User ID';
        }
        field(7; "No Series"; Code[20])
        {
            Caption = 'No Series';
        }
        field(8; "Budget Option"; Option)
        {
            Caption = 'Budget Opt';
            OptionCaption = ' ,Budgeting,ReAllocation,Procurement Plan,Procurement Plan Review';
            OptionMembers = " ",Budgeting,ReAllocation,"Procurement Plan","Procurement Plan Review";
        }
        field(9; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));
        }
        field(10; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = const(false));
        }
        field(11; Approvals; Integer)
        {
            CalcFormula = count("Approval Entry" where("Document No." = field("Document No.")));
            Caption = 'Approvals';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Budget Type"; Option)
        {
            Caption = 'Budget Type';
            OptionCaption = ' ,Budget,Procurement Plan';
            OptionMembers = " ",Budget,"Procurement Plan";
        }
        field(13; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(14; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
    }

    keys
    {
        key(Key1; "Document No.")
        {
            Clustered = true;
        }
    }

    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        if "Document No." = '' then begin
            GeneralLedgerSetup.Get();
            GeneralLedgerSetup.TestField("Budget Approval Nos");
            NoSeriesManagement.InitSeries(GeneralLedgerSetup."Budget Approval Nos", xRec."No Series", 0D, "Document No.", "No Series");
        end;

        "Date Created" := Today;
        "Time Created" := Time;
        "User ID" := UserId;

        case "Budget Type" of
            "Budget Type"::Budget:
                begin
                    GeneralLedgerSetup.Get();
                    GeneralLedgerSetup.TestField("Current Budget");
                    Validate("Budget Name", GeneralLedgerSetup."Current Budget");
                end;

        /* "Budget Type"::"Procurement Plan":
            begin
                if "Budget Option" = "Budget Option"::"Procurement Plan" then begin
                    PurchSetup.Get();
                    PurchSetup.TestField("Effective Procurement Plan");
                    Validate("Budget Name", PurchSetup."Effective Procurement Plan");

                    PlanName.Get("Budget Name");
                    if PlanName."Plan Submission Cut-off" = 0D then
                        Error(CutOffDateErr, "Budget Name");

                    if Today > PlanName."Plan Submission Cut-off" then
                        Error(SubmissionDateElapsedErr, "Budget Name");
                end;
            end; */
        end;

        UserSetup.Get("User ID");
        UserSetup.TestField("Global Dimension 1 Code");
        UserSetup.TestField("Global Dimension 2 Code");
        UserSetup.TestField("Responsibility Centre");
        "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
        "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
        "Responsibility Center" := UserSetup."Responsibility Centre";
    end;
    /* PlanName: Record "Procurement Plan";
    ProcPlanApprovalLines: Record "Procurement Plan Approval Line";
    ProcurementPlanItems: Record "Procurement Plan Item"; */
}
