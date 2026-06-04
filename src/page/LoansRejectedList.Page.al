page 50391 "Loans Rejected List"
{
    CardPageID = "Loans Rejected Card";
    Editable = false;
    PageType = List;
    SourceTable = "Loans Register";
    SourceTableView = where("Approval Status" = const(Rejected));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan  No."; Rec."Loan  No.")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date"; Rec."Application Date")
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
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Interest; Rec.Interest)
                {
                    ApplicationArea = Basic;
                }
                field(Insurance; Rec.Insurance)
                {
                    ApplicationArea = Basic;
                }
                field("Source of Funds"; Rec."Source of Funds")
                {
                    ApplicationArea = Basic;
                }
                field("Client Cycle"; Rec."Client Cycle")
                {
                    ApplicationArea = Basic;
                }
                field("Client Name"; Rec."Client Name")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Status"; Rec."Loan Status")
                {
                    ApplicationArea = Basic;
                }
                field("Issued Date"; Rec."Issued Date")
                {
                    ApplicationArea = Basic;
                }
                field(Installments; Rec.Installments)
                {
                    ApplicationArea = Basic;
                }
                field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                }
                field("Mode of Disbursement"; Rec."Mode of Disbursement")
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
