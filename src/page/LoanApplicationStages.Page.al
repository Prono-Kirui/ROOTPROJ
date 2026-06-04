#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50788 "Loan Application Stages"
{
    PageType = ListPart;
    SourceTable = "Loan Application Stages";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan Stage"; Rec."Loan Stage")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Stage Description"; Rec."Loan Stage Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Stage Status"; Rec."Stage Status")
                {
                    ApplicationArea = Basic;
                }
                field("Date Updated"; Rec."Date Upated")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Updated By"; Rec."Updated By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

