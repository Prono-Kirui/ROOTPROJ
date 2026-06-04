#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50370 "Members Nominee Details List"
{
    PageType = ListPart;
    ApplicationArea = Basic;
    Caption = 'Members Nominee Details List';
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTable = "Members Next of Kin";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                }
                field(Relationship; Rec.Relationship)
                {
                    ApplicationArea = Basic;
                }

                field("Next Of Kin Type"; Rec."Next Of Kin Type")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                }

                field(Email; Rec.Email)
                {
                    ApplicationArea = Basic;
                }
                field("%Allocation"; Rec."%Allocation")
                {
                    ApplicationArea = Basic;
                }
                field("Total Allocation"; Rec."Total Allocation")
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

