#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50790 "Credit/Field Officers"
{
    PageType = List;
    SourceTable = "Credit/Field Officers";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Credit Officer"; Rec."Credit Officer")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Field Officer"; Rec."Field Officer")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

