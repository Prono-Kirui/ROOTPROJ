#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50944 "SCustody Package Register List"
{
    CardPageID = "SCustody Package Card";
    Editable = false;
    PageType = List;
    SourceTable = "Safe Custody Package Register";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Package ID"; Rec."Package ID")
                {
                    ApplicationArea = Basic;
                }
                field("Package Type"; Rec."Package Type")
                {
                    ApplicationArea = Basic;
                }
                field("Package Description"; Rec."Package Description")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Custody Period"; Rec."Custody Period")
                {
                    ApplicationArea = Basic;
                }
                field("Charge Account"; Rec."Charge Account")
                {
                    ApplicationArea = Basic;
                }
                field("Maturity Instruction"; Rec."Maturity Instruction")
                {
                    ApplicationArea = Basic;
                }
                field("File Serial No"; Rec."File Serial No")
                {
                    ApplicationArea = Basic;
                }
                field("Date Received"; Rec."Date Received")
                {
                    ApplicationArea = Basic;
                }
                field("Time Received"; Rec."Time Received")
                {
                    ApplicationArea = Basic;
                }
                field("Received By"; Rec."Received By")
                {
                    ApplicationArea = Basic;
                }
                field("Lodged By(Custodian 1)"; Rec."Lodged By(Custodian 1)")
                {
                    ApplicationArea = Basic;
                }
                field("Lodged By(Custodian 2)"; Rec."Lodged By(Custodian 2)")
                {
                    ApplicationArea = Basic;
                }
                field("Date Lodged"; Rec."Date Lodged")
                {
                    ApplicationArea = Basic;
                }
                field("Time Lodged"; Rec."Time Lodged")
                {
                    ApplicationArea = Basic;
                }
                field("Released By(Custodian 1)"; Rec."Released By(Custodian 1)")
                {
                    ApplicationArea = Basic;
                }
                field("Released By(Custodian 2)"; Rec."Released By(Custodian 2)")
                {
                    ApplicationArea = Basic;
                }
                field("Date Released"; Rec."Date Released")
                {
                    ApplicationArea = Basic;
                }
                field("Time Released"; Rec."Time Released")
                {
                    ApplicationArea = Basic;
                }
                field("Collected By"; Rec."Collected By")
                {
                    ApplicationArea = Basic;
                }
                field("Collected On"; Rec."Collected On")
                {
                    ApplicationArea = Basic;
                }
                field("Collected At"; Rec."Collected At")
                {
                    ApplicationArea = Basic;
                }
                field("Maturity Date"; Rec."Maturity Date")
                {
                    ApplicationArea = Basic;
                }
                field("Retrieved By(Custodian 1)"; Rec."Retrieved By(Custodian 1)")
                {
                    ApplicationArea = Basic;
                }
                field("Retrieved By (Custodian 2)"; Rec."Retrieved By (Custodian 2)")
                {
                    ApplicationArea = Basic;
                }
                field("Retrieved On"; Rec."Retrieved On")
                {
                    ApplicationArea = Basic;
                }
                field("Retrieved At"; Rec."Retrieved At")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Charge Account Name"; Rec."Charge Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Safe Custody Fee Charged"; Rec."Safe Custody Fee Charged")
                {
                    ApplicationArea = Basic;
                }
                field("Package Re_Booked On"; Rec."Package Re_Booked On")
                {
                    ApplicationArea = Basic;
                }
                field("Package Rebooked By"; Rec."Package Rebooked By")
                {
                    ApplicationArea = Basic;
                }
                field("Package Re_Lodge Fee Charged"; Rec."Package Re_Lodge Fee Charged")
                {
                    ApplicationArea = Basic;
                }
                field("Package Status"; Rec."Package Status")
                {
                    ApplicationArea = Basic;
                }
                field("Package Rebooked On"; Rec."Package Rebooked On")
                {
                    ApplicationArea = Basic;
                }
                field("Package Rebooking Status"; Rec."Package Rebooking Status")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Retrieve Package")
            {
                ApplicationArea = Basic;
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;
                // RunObject = Page "Package Retrieval Request List";
            }
        }
    }
}