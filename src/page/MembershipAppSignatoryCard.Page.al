#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50365 "Membership App Signatory Card"
{
    PageType = Card;
    SourceTable = "Member App Signatories";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA No."; Rec."BOSA No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No.';
                }
                field(Names; Rec.Names)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Mobile No."; Rec."Mobile No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = Basic;
                    Caption = 'Designation';
                    ShowMandatory = true;
                }
                field(Signatory; Rec.Signatory)
                {
                    ApplicationArea = Basic;
                }
                field("Must Sign"; Rec."Must Sign")
                {
                    ApplicationArea = Basic;
                }
                field("Must be Present"; Rec."Must be Present")
                {
                    ApplicationArea = Basic;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = Basic;
                }
                field("Email Address"; Rec."Email Address")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Withdrawal"; Rec."Maximum Withdrawal")
                {
                    ApplicationArea = Basic;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = Basic;
                }
                field(Signature; Rec.Signature)
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

