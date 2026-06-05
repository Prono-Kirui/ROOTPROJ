tableextension 51007 "FA Finance Ext" extends "Fixed Asset"
{
    fields
    {
        field(51000; Disposed; Boolean)
        {
            CalcFormula = exist("FA Depreciation Book" where("FA No." = field("No."),
                                                              "Disposal Date" = filter(<> 0D)));
            Caption = 'Disposed';
            Editable = false;
            FieldClass = FlowField;
        }
        field(51001; "Marked For Disposal"; Boolean)
        {
            Caption = 'Marked For Disposal';
            DataClassification = CustomerContent;
        }
        field(51002; "Asset Tagging"; Code[100])
        {
            Caption = 'Asset Tagging';
            DataClassification = CustomerContent;
            Description = 'Property';
        }
        field(51003; "G/L Budget Line"; Code[20])
        {
            Caption = 'Budget Line';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
        }
    }
}
