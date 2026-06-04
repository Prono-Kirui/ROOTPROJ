#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50384 "Loans Applied  List"
{
    CardPageID = "Loan Application Card";
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "Loans Register";
    SourceTableView = where(Posted = filter(false),
                            "Approval Status" = filter(Open | Pending),
                            Source = filter(MICRO));

    layout
    {
        area(content)
        {
            repeater(Control1000000010)
            {
                field("Loan  No."; Rec."Loan  No.")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Client Code"; Rec."Client Code")
                {
                    ApplicationArea = Basic;
                }
                field("Client Name"; Rec."Client Name")
                {
                    ApplicationArea = Basic;
                }
                field("ID NO"; Rec."ID NO")
                {
                    ApplicationArea = Basic;
                }
                field("Staff No"; Rec."Staff No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll No';
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic;
                }
                field("Loan Status"; Rec."Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000001; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("Client Code");
            }
            // part(WorkflowStatus; "Workflow Status FactBox")
            // {
            //     Editable = false;
            //     Enabled = false;
            //     ShowFilter = false;
            // }
        }
    }

    actions
    {
        area(creation)
        {
            action("Go to FOSA Accounts")
            {
                ApplicationArea = Basic;
                Image = List;
                Promoted = true;
                PromotedCategory = Process;
                // RunObject = Page "Product Details Master";
                // RunPageLink = "BOSA Account No" = field("Client Code");
            }
        }
    }

    trigger OnOpenPage()
    begin

    end;

    var
        UserSet: Record User;
        ObjUserSetup: Record "User Setup";
        ShowWorkflowStatus: Boolean;
}

