#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50389 "Loan Offset Detail List"
{
    PageType = List;
    SourceTable = "Loan Offset Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("FOSA Account"; Rec."FOSA Account")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specify the Member FOSA Account to Debit when reducing the Loan Balance,Only Specify When the Customer has not meet the Minimum Offset amount';
                }
                field("Loan Top Up"; Rec."Loan Top Up")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan to Offset';
                }
                field("Client Code"; Rec."Client Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
                field("BOSA No"; Rec."BOSA No")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Type"; Rec."Loan Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Principle Top Up"; Rec."Principle Top Up")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Interest Top Up"; Rec."Interest Top Up")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Monthly Repayment"; Rec."Monthly Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Commision; Rec.Commision)
                {
                    ApplicationArea = Basic;
                    Caption = 'Levy';
                    Editable = false;
                }
                field("Tax On Comission"; Rec."Tax On Comission")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Insurance: Current Year"; Rec."Loan Insurance: Current Year")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Due at Clearance"; Rec."Interest Due at Clearance")
                {
                    ApplicationArea = Basic;
                    Caption = ' Interest Due';
                    Visible = false;
                }
                field("Total Top Up"; Rec."Total Top Up")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Recovery(P+I+Leavy)';
                    Editable = false;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = true;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Loan Payoff")
            {
                ApplicationArea = Basic;
                Image = Document;
                Promoted = true;
                // RunObject = Page "Loan PayOff List";
            }
            action(ReduceLoanBalance)
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;

                trigger OnAction()
                begin

                    // ObjLoanOffset.Reset;
                    // ObjLoanOffset.SetRange(ObjLoanOffset."Loan Top Up", "Loan Top Up");
                    // ObjLoanOffset.SetRange(ObjLoanOffset."FOSA Account", "FOSA Account");
                    // if ObjLoanOffset.Find('-') then begin
                    //     if ObjLoanOffset."FOSA Account" = '' then begin
                    //         Error('Specify the FOSA Account to be Debited When reducing the Loan');
                    //     end;
                    //     Report.Run(50934, true, false, ObjLoanOffset);
                    // end;
                end;
            }
        }
    }

    var
        ObjLoanOffset: Record "Loan Offset Details";
}

