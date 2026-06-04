tableextension 50002 "WorkflowUserGrpExt" extends "Workflow User Group"
{
    fields
    {
        field(50000; "Approval Stages"; Code[20])
        {
            TableRelation = "Approval Stages"."Approval Stage";
            DataClassification = CustomerContent;
            Caption = 'Approval Stages';
        }
    }
}





