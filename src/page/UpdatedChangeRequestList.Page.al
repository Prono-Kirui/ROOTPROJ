#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50844 "Updated Change Request List"
{
    CardPageID = "Updated Change Request Card";
    Editable = false;
    PageType = List;
    SourceTable = "Change Request";
    SourceTableView = where(Changed = const(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; rec.No)
                {
                    ApplicationArea = Basic;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile No"; rec."Mobile No")
                {
                    ApplicationArea = Basic;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("No. Series"; rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
                field(Address; rec.Address)
                {
                    ApplicationArea = Basic;
                }
                field(Branch; rec.Branch)
                {
                    ApplicationArea = Basic;
                }
                field(Picture; rec.Picture)
                {
                    ApplicationArea = Basic;
                }
                field(Signature; rec.Signature)
                {
                    ApplicationArea = Basic;
                }
                field(City; rec.City)
                {
                    ApplicationArea = Basic;
                }
                field("E-mail"; rec."E-mail")
                {
                    ApplicationArea = Basic;
                }
                field("Personal No"; rec."Personal No")
                {
                    ApplicationArea = Basic;
                }
                field("ID No"; rec."ID No")
                {
                    ApplicationArea = Basic;
                }
                field("Marital Status"; rec."Marital Status")
                {
                    ApplicationArea = Basic;
                }
                field("Passport No."; rec."Passport No.")
                {
                    ApplicationArea = Basic;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account Category"; rec."Account Category")
                {
                    ApplicationArea = Basic;
                }
                field(Email; rec.Email)
                {
                    ApplicationArea = Basic;
                }
                field(Section; rec.Section)
                {
                    ApplicationArea = Basic;
                }
                field("Card No"; rec."Card No")
                {
                    ApplicationArea = Basic;
                }
                field("Home Address"; rec."Home Address")
                {
                    ApplicationArea = Basic;
                }
                field(Loaction; rec.Loaction)
                {
                    ApplicationArea = Basic;
                }
                field("Sub-Location"; rec."Sub-Location")
                {
                    ApplicationArea = Basic;
                }
                field(District; rec.District)
                {
                    ApplicationArea = Basic;
                }
                field("Reason for change"; rec."Reason for change")
                {
                    ApplicationArea = Basic;
                }
                field("Signing Instructions"; rec."Signing Instructions")
                {
                    ApplicationArea = Basic;
                }
                field("S-Mobile No"; rec."S-Mobile No")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Approve"; rec."ATM Approve")
                {
                    ApplicationArea = Basic;
                }
                field("Card Expiry Date"; rec."Card Expiry Date")
                {
                    ApplicationArea = Basic;
                }
                field("Card Valid From"; rec."Card Valid From")
                {
                    ApplicationArea = Basic;
                }
                field("Card Valid To"; rec."Card Valid To")
                {
                    ApplicationArea = Basic;
                }
                field("Date ATM Linked"; rec."Date ATM Linked")
                {
                    ApplicationArea = Basic;
                }
                field("ATM No."; rec."ATM No.")
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