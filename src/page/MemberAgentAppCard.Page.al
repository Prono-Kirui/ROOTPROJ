#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50628 "Member Agent App Card"
{
    PageType = Card;
    SourceTable = "Member Agents App Details";

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
                field(Names; Rec.Names)
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = Basic;
                }
                field("Staff/Payroll"; Rec."Staff/Payroll")
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = Basic;
                }
                field("Allowed Balance Enquiry"; Rec."Allowed Balance Enquiry")
                {
                    ApplicationArea = Basic;
                }
                field("Allowed  Correspondence"; Rec."Allowed  Correspondence")
                {
                    ApplicationArea = Basic;
                }
                field("Allowed FOSA Withdrawals"; Rec."Allowed FOSA Withdrawals")
                {
                    ApplicationArea = Basic;
                }
                field("Allowed Loan Processing"; Rec."Allowed Loan Processing")
                {
                    ApplicationArea = Basic;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA No."; Rec."BOSA No.")
                {
                    ApplicationArea = Basic;
                }
                field("Email Address"; Rec."Email Address")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            // part(Control1000000005;"M_Agent Picture-Appl")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Agent Picture';
            //     SubPageLink = "Account No"=field("Account No");
            // }
            // part(Control1000000006;"M_Agent Signature-Appl")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Agent Signature';
            //     SubPageLink = "Account No"=field("Account No");
            // }
        }
    }

    actions
    {
    }
}

