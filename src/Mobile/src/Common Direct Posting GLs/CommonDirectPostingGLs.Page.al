page 50454 "Common Direct Posting G/Ls"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Common Direct Posting GL";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Description; Rec.Description)
                {

                }
                field("G/L Account"; Rec."G/L Account")
                {

                }
                field("G/L Account Name"; Rec."G/L Account Name")
                {

                }
                field("Is Percentage"; Rec."Is Percentage")
                {

                }
                field(Amount; Rec.Amount)
                {

                }
                field("Is Active"; Rec."Is Active")
                {

                }
                field("Last Modified Date Time"; Rec."Last Modified Date Time")
                {

                }
                field("Last Modified By"; Rec."Last Modified By")
                {

                }

            }
        }
    }

    actions
    {
        area(Processing)
        {

        }
    }


}