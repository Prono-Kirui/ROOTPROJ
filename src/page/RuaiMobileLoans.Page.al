page 50026 "Ruai Mobile Loans"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Loans Register";
    UsageCategory = Administration;
    Editable = false;
    SourceTableView = where("Loan Product Type" = filter('RUAIMOBI'));
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Loan  No."; Rec."Loan  No.") { }
                field("Client Code"; Rec."Client Code") { }
                field("Client Name"; Rec."Client Name") { }
                field("Loan Product Type"; Rec."Loan Product Type") { }
                field("Approved Amount"; Rec."Approved Amount") { }
                field("Expected Date of Completion"; Rec."Expected Date of Completion") { }
                field("Loan Disbursement Date"; Rec."Loan Disbursement Date") { }
                field("Outstanding Balance"; Rec."Outstanding Balance") { }
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
