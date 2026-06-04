#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50934 "Share Capital Sell"
{
    PageType = ListPart;
    SourceTable = "Share Capital Sell";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Buyer Member No"; Rec."Buyer Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Buyer Name"; Rec."Buyer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Buyer FOSA Account"; Rec."Buyer FOSA Account")
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

