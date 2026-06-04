page 50011 "Banks"
{
    PageType = List;
    SourceTable = Banks;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Branches)
            {
                Image = Warehouse;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Bank Branches";
                RunPageLink = "Bank Code" = field(Code);
                ApplicationArea = All;
                ToolTip = 'Executes the Branches action';
            }
        }
    }
}





