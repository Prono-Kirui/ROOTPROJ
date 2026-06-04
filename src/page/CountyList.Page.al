page 50023 "County List"
{
    PageType = List;
    SourceTable = County;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the County Code field';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field';
                }
            }
        }
    }

    actions
    {
    }
}





