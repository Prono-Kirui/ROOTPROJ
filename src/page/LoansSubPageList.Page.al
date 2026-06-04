#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50390 "Loans Sub-Page List"
{
    //CardPageID = "Loans Application Card(Posted)";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = "Loans Register";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Loan  No."; Rec."Loan  No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type Name"; Rec."Loan Product Type Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Client Code"; Rec."Client Code")
                {
                    ApplicationArea = Basic;
                }
                field("Client Name"; Rec."Client Name")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date"; Rec."Application Date")
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
                field("Loan Collateral Secured"; Rec."Loan Collateral Secured")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Issued Date"; Rec."Issued Date")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Start Date"; Rec."Repayment Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Principle Outstanding Balance';
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                field("Current Principle Due"; Rec."Current Principle Due")
                {
                    ApplicationArea = Basic;
                    Caption = ' Principle Due';
                }
                field("Interest Due"; Rec."Interest Due")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Interest Accrued';
                    Editable = false;
                    Importance = Additional;
                }
                field("Total Interest Paid"; Rec."Total Interest Paid")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                    Caption = 'Outstanding Interest';
                }
                field("Loan Insurance Charged"; Rec."Loan Insurance Charged")
                {
                    ApplicationArea = Basic;
                    Caption = 'Insurance Charged';
                    Editable = false;
                    Importance = Additional;
                }
                field("Total Insurance Paid"; Rec."Total Insurance Paid")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Insurance"; Rec."Outstanding Insurance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Penalty Charged"; Rec."Penalty Charged")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("Total Penalty Paid"; Rec."Total Penalty Paid")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Penalty"; Rec."Outstanding Penalty")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Current Payoff Amount"; Rec."Loan Current Payoff Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Amount Due"; Rec."Loan Amount Due")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Amount in Arrears"; Rec."Amount in Arrears")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Amount in Arrears';
                    Editable = false;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = FieldStyleArrears;
                }
                field("Days In Arrears"; Rec."Days In Arrears")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = FieldStyleArrears;
                }
                field(Repayment; Rec.Repayment)
                {
                    ApplicationArea = Basic;
                }
                field("Loan Status"; Rec."Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Loans Category-SASRA"; Rec."Loans Category-SASRA")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
    end;

    trigger OnAfterGetRecord()
    begin
        Rec."Loan Current Payoff Amount" := SFactory.FnRunGetLoanPayoffAmount(Rec."Loan  No.");
        Rec."Loan Amount Due" := SFactory.FnRunLoanAmountDue(Rec."Loan  No.");
    end;

    trigger OnOpenPage()
    begin
        Rec.SetFilter("Loan Status", '<>%1', Rec."Loan Status"::Closed);
    end;

    var
        LoanType: Record "Loan Products Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FieldStyle: Text;
        FieldStyleI: Text;
        OutstandingInterest: Decimal;
        InterestDue: Decimal;
        SFactory: Codeunit "Micropoint Factory";
        ObjLoans: Record "Loans Register";
        VarLoanPayoffAmount: Decimal;
        VarInsurancePayoff: Decimal;
        ObjProductCharge: Record "Loan Product Charges";
        VarEndYear: Date;
        VarInsuranceMonths: Integer;
        VarAmountinArrears: Decimal;
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        VarOutstandingInterestI: Decimal;
        FieldStyleArrears: Text;

    procedure GetVariables(var LoanNo: Code[20]; var LoanProductType: Code[20]; var MemberNo: Code[20])
    begin
        LoanNo := Rec."Loan  No.";
        LoanProductType := Rec."Loan Product Type";
        MemberNo := Rec."Client Code";
    end;

    local procedure SetFieldStyle()
    begin
        FieldStyle := '';
        Rec.CalcFields("Outstanding Balance", "Outstanding Interest");
        if (Rec."Outstanding Balance" < 0) then
            FieldStyle := 'Attention';

        if (Rec."Outstanding Interest" < 0) then
            FieldStyleI := 'Attention';

        FieldStyleArrears := 'Strong';
        if (Rec."Amount in Arrears" > 0) then
            FieldStyleArrears := 'Unfavorable';
        if (Rec."Amount in Arrears" = 0) then
            FieldStyleArrears := 'Favorable';
    end;
}
