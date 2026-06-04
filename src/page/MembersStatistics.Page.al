#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50368 "Members Statistics"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Monthly Contribution"; Rec."Monthly Contribution")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Width = 50;
                }

                field("Registration Fee Paid"; Rec."Registration Fee Paid")
                {
                    ApplicationArea = Basic;
                }
                field("Shares Retained"; Rec."Shares Retained")
                {
                    ApplicationArea = Basic;
                    Caption = 'Share Capital';
                }
                field("Current Shares"; Rec."Current Shares")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Deposits';
                    Image = Star;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Benevolent Fund"; Rec."Benevolent Fund")
                {
                    ApplicationArea = Basic;
                }


                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Outstanding Balance';

                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Outstanding Interest';
                }
                field("Un-allocated Funds"; Rec."Un-allocated Funds")
                {
                    ApplicationArea = Basic;

                }

                field("Dividend Amount"; Rec."Dividend Amount")
                {
                    ApplicationArea = Basic;
                }
            }
            part("Member Accounts"; "Member Accounts")
            {
                SubPageLink = "BOSA Account No" = field("No.");
            }
            part(Control1102755002; "Loans Sub-Page List")
            {
                SubPageLink = "Client Code" = field("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Loan Recovery Logs")
            {
                ApplicationArea = Basic;
                Image = Form;
                Promoted = true;
                //RunObject = Page "Loan Recovery Logs List";
                // RunPageLink = "Member No" = field("No."),
                //             "Member Name" = field(Name);
            }
            action("Guarantor Recovery Report")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                var
                    ObjCust: Record Customer;
                begin
                    ObjCust.Reset;
                    ObjCust.SetRange(ObjCust."No.", Rec."No.");
                    if ObjCust.Find('-') then
                        Report.Run(50951, true, false, ObjCust);
                end;
            }
            action("Loan Recovery Log Report")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedOnly = true;

                trigger OnAction()
                begin
                    ObjCust.Reset;
                    ObjCust.SetRange(ObjCust."No.", Rec."No.");
                    if ObjCust.Find('-') then
                        Report.Run(50963, true, false, ObjCust);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange("Client Code", Rec."No.");
        if ObjLoans.Find('-') then
            OutstandingInterest := SFactory.FnGetInterestDueTodate(ObjLoans) - ObjLoans."Interest Paid";
    end;

    trigger OnAfterGetRecord()
    begin
        /*IF ("Assigned System ID"<>'') AND ("Assigned System ID"<>USERID) THEN BEGIN
          ERROR('You do not have permission to view this account Details');
          END;*/

        if (Rec."Assigned System ID" <> '') then begin //AND ("Assigned System ID"<>USERID)
            if UserSetup.Get(UserId) then begin
                // if UserSetup."View Special Accounts" = false then Error('You do not have permission to view this account Details, Contact your system administrator! ')
            end;

        end;

        SetFieldStyle;

    end;

    var
        UserSetup: Record "User Setup";
        FieldStyle: Text;
        OutstandingInterest: Decimal;
        InterestDue: Decimal;
        SFactory: Codeunit "Micropoint Factory";
        ObjLoans: Record "Loans Register";
        ObjCust: Record Customer;

    local procedure SetFieldStyle()
    begin
        FieldStyle := '';
        // CalcFields("Un-allocated Funds");
        // if "Un-allocated Funds" <> 0 then
        FieldStyle := 'Attention';
    end;
}

