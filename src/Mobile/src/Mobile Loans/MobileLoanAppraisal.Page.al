page 50690 MobileLoanAppraisal
{
    ApplicationArea = All;
    Caption = 'Mobile Loan Appraisal';
    PageType = List;
    SourceTable = "Mobile Loan Appraisal Logs";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Member No"; Rec."Member No")
                {
                }
                field("Member Name"; Rec."Member Name")
                {
                }
                field("Qualified Amount"; Rec."Qualified Amount")
                {
                }
                field("Disqualification Reason"; Rec."Disqualification Reason")
                {
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(Appraise)
            {
                ApplicationArea = All;
                Caption = 'Appraise Mobile Loan';
                Image = Image;

                trigger OnAction()
                begin
                    ObjMember.RESET;
                    ObjMember.SETRANGE("No.", Rec."Member No");
                    IF ObjMember.FindFirst() THEN BEGIN
                        Message('Qualified Loan Amount=%1', CFTMobile.FnMobileLoanAppraisal(ObjMember."Phone No."));
                    END;
                end;
            }
        }

    }

    var
        ObjMember: Record Customer;
        CFTMobile: Codeunit CFTMobile;
}
