page 50451 "CFT Mobile Paybill List"
{
    Caption = 'CFT Mobile Paybill Transactions';
    PageType = List;
    SourceTable = "CFT Mobile Paybill Trans";
    ApplicationArea = All;
    UsageCategory = Administration;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;


    layout
    {
        area(content)
        {
            repeater(Transactions)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = All;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = All;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = All;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Paybill Acc Balance"; Rec."Paybill Acc Balance")
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                }
                field("Date Posted"; Rec."Date Posted")
                {

                }
                field("Time Posted"; Rec."Time Posted")
                {

                }
                field("Needs Manual Posting"; Rec."Needs Manual Posting")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Changed By"; Rec."Changed By")
                {
                    ApplicationArea = All;
                }
                field("Date Changed"; Rec."Date Changed")
                {
                    ApplicationArea = All;
                }
                field("Time Changed"; Rec."Time Changed")
                {

                }
                field("Approved By"; Rec."Approved By")
                {

                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Post")
            {
                trigger OnAction()
                var
                    CFTMobile: Codeunit CFTMobile;
                begin
                    Message(CFTMobile.PaybillSwitch());
                end;

            }

        }
    }
}
