tableextension 50000 ResponsibilityCentersExt extends "Responsibility Center"
{
    fields
    {
        field(50000; "Head User"; Code[150])
        {
            Caption = 'Head User';
            DataClassification = ToBeClassified;
            TableRelation="User Setup";
        }
    }
}






