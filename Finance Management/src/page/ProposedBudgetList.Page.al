page 51080 "Proposed Budget List"
{
    ApplicationArea = All;
    Caption = 'Proposed Budget List';
    CardPageId = "Proposed Budget Card";
    PageType = List;
    SourceTable = "Proposed Budget Header";
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field(Name; Rec.Name)
                {
                    Caption = 'Name';
                    ToolTip = 'Specifies the value of the Name field';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(Posted; Rec.Posted)
                {
                    Caption = 'Posted';
                    ToolTip = 'Specifies the value of the Posted field';
                }
                field("Posted By"; Rec."Posted By")
                {
                    Caption = 'Posted By';
                    ToolTip = 'Specifies the value of the Posted By field';
                }
                field("Date-Time Posted"; Rec."Date-Time Posted")
                {
                    Caption = 'Date-Time Posted';
                    ToolTip = 'Specifies the value of the Date-Time Posted field';
                }
            }
        }
    }
}
