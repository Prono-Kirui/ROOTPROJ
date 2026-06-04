#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50828 "Member Statistics FactBox"
{
    Caption = 'Member FactBox';
    Editable = false;
    PageType = CardPart;
    SaveValues = true;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            field("No."; Rec."No.")
            {
                ApplicationArea = Basic;
                Caption = 'Member No.';
            }
            field(Name; Rec.Name)
            {
                ApplicationArea = Basic;
            }
            field("Personal No"; Rec."Personal No")
            {
                ApplicationArea = Basic;
            }
            field("ID No."; Rec."ID No.")
            {
                ApplicationArea = Basic;
            }
            field("Passport No."; Rec."Passport No.")
            {
                ApplicationArea = Basic;
            }
            field("Mobile Phone No"; Rec."Mobile Phone No")
            {
                ApplicationArea = Basic;
            }


            group("Member Details FactBox")
            {
                Caption = 'Member Details FactBox';
                field("Registration Fee Paid"; Rec."Registration Fee Paid")
                {
                    ApplicationArea = Basic;
                    Image = Money;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("PassBook Fee Paid"; Rec."PassBook Fee Paid")
                {
                    ApplicationArea = Basic;
                    Caption = 'Passbook Fee Paid';
                    Image = Money;
                    Style = Attention;
                    StyleExpr = true;
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
                field("Free Shares"; FreeSharesAmount)
                {
                    ApplicationArea = Basic;
                    Caption = 'Free Shares';
                }


            }
            group("File Movement FactBox")
            {
                Caption = 'File Movement FactBox';
                field("Currect File Location"; Rec."Currect File Location")
                {
                    ApplicationArea = Basic;
                }
                field("Loc Description"; Rec."Loc Description")
                {
                    ApplicationArea = Basic;
                }
                field(User; Rec.User)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
    trigger OnAfterGetRecord()
    var
        StatusChangePermissions: record "Status Change Permision";
        LoansGuaranteeDetails: Record "Loans Guarantee Details";
        TotalGuaranteed: Decimal;
    begin
        ViewDetail := true;
        if Rec."Treat as Special Account ?" = true then begin
            ViewDetail := false;
            StatusChangePermissions.Reset();
            StatusChangePermissions.SetRange(StatusChangePermissions.Function, StatusChangePermissions.Function::"Account Opening");
            StatusChangePermissions.SetRange(StatusChangePermissions."User Id", UserId);
            if StatusChangePermissions.Find('-') then begin
                ViewDetail := true;
            end;
        end;

        // Calculate Free Shares by considering actual loan outstanding balances
        FreeSharesAmount := 0;
        Rec.CalcFields(Rec."Current Shares");

        // Calculate actual guaranteed amount based on current loan balances
        TotalGuaranteed := CalculateEffectiveGuarantees(Rec."No.");

        // Free Shares = Current Shares - Effective Guaranteed Amount
        FreeSharesAmount := Rec."Current Shares" - TotalGuaranteed;
    end;

    trigger OnOpenPage()
    begin
    end;

    var
        LatestCustLedgerEntry: Record "Cust. Ledger Entry";
        CustLedgerEntry: array[4] of Record "Cust. Ledger Entry";
        AgingTitle: array[4] of Text[30];
        AgingPeriod: DateFormula;
        I: Integer;
        PeriodStart: Date;
        PeriodEnd: Date;
        ViewDetail: Boolean;
        FreeSharesAmount: Decimal;
        ValueForHidden: label 'Restricted View';
        Text002: label 'Not Yet Due';
        Text003: label 'Over %1 Days';
        Text004: label '%1-%2 Days';

    procedure CalculateAgingForPeriod(PeriodBeginDate: Date; PeriodEndDate: Date; Index: Integer)
    var
        CustLedgerEntry2: Record "Cust. Ledger Entry";
        NumDaysToBegin: Integer;
        NumDaysToEnd: Integer;
    begin
        // Calculate the Aged Balance for a particular Date Range
        if PeriodEndDate = 0D then
            CustLedgerEntry[Index].SetFilter("Due Date", '%1..', PeriodBeginDate)
        else
            CustLedgerEntry[Index].SetRange("Due Date", PeriodBeginDate, PeriodEndDate);
        CustLedgerEntry2.Copy(CustLedgerEntry[Index]);
        CustLedgerEntry[Index]."Remaining Amt. (LCY)" := 0;
        if CustLedgerEntry2.Find('-') then
            repeat
                CustLedgerEntry2.CalcFields("Remaining Amt. (LCY)");
                CustLedgerEntry[Index]."Remaining Amt. (LCY)" := CustLedgerEntry[Index]."Remaining Amt. (LCY)" + CustLedgerEntry2."Remaining Amt. (LCY)";
            until CustLedgerEntry2.Next = 0;
        if PeriodBeginDate <> 0D then NumDaysToBegin := WorkDate - PeriodBeginDate;
        if PeriodEndDate <> 0D then NumDaysToEnd := WorkDate - PeriodEndDate;
        if PeriodEndDate = 0D then
            AgingTitle[Index] := Text002
        else if PeriodBeginDate = 0D then
            AgingTitle[Index] := StrSubstNo(Text003, NumDaysToEnd - 1)
        else
            AgingTitle[Index] := StrSubstNo(Text004, NumDaysToEnd, NumDaysToBegin);
    end;

    procedure CalculateAging()
    begin
        // Calculate the Entire Aging (four Periods)
        for I := 1 to ArrayLen(CustLedgerEntry) do begin
            case I of
                1:
                    begin
                        PeriodEnd := 0D;
                        PeriodStart := WorkDate;
                    end;
                ArrayLen(CustLedgerEntry):
                    begin
                        PeriodEnd := PeriodStart - 1;
                        PeriodStart := 0D;
                    end;
                else begin
                    PeriodEnd := PeriodStart - 1;
                    PeriodStart := CalcDate('-' + Format(AgingPeriod), PeriodStart);
                end;
            end;
            CalculateAgingForPeriod(PeriodStart, PeriodEnd, I);
        end;
    end;

    procedure GetLatestPayment()
    begin
        // Find the Latest Payment
        if LatestCustLedgerEntry.FindLast then
            LatestCustLedgerEntry.CalcFields("Amount (LCY)")
        else
            LatestCustLedgerEntry.Init;
    end;

    procedure ChangeCustomer()
    begin
        // Change the Customer Filters
        LatestCustLedgerEntry.SetRange("Customer No.", Rec."No.");
        for I := 1 to ArrayLen(CustLedgerEntry) do CustLedgerEntry[I].SetRange("Customer No.", Rec."No.");
    end;

    procedure DrillDown(Index: Integer)
    begin
        if Index = 0 then
            Page.RunModal(Page::"Customer Ledger Entries", LatestCustLedgerEntry)
        else
            Page.RunModal(Page::"Customer Ledger Entries", CustLedgerEntry[Index]);
    end;

    local procedure FnGetLoanArrears(No: Code[20]): Decimal
    var
        LoansReg: Record "Loans Register";
        Amount: Decimal;
    begin
        Amount := 0;
        LoansReg.reset;
        LoansReg.SetRange(LoansReg."Client Code", no);
        LoansReg.SetAutoCalcFields(LoansReg."Outstanding Balance");
        LoansReg.SetFilter(LoansReg."Outstanding Balance", '>%1', 0);
        LoansReg.SetRange(LoansReg.Posted, true);
        if LoansReg.Find('-') then begin
            repeat
                Amount += LoansReg."Amount in Arrears";
            until LoansReg.Next = 0;
            exit(Amount);
        end;
    end;

    local procedure CalculateEffectiveGuarantees(MemberNo: Code[20]): Decimal
    var
        LoansGuaranteeDetails: Record "Loans Guarantee Details";
        LoansRegister: Record "Loans Register";
        EffectiveGuarantee: Decimal;
        TotalEffective: Decimal;
    begin
        // Calculate total effective guarantees considering actual loan balances
        TotalEffective := 0;

        LoansGuaranteeDetails.Reset();
        LoansGuaranteeDetails.SetRange("Member No", MemberNo);
        LoansGuaranteeDetails.SetFilter("Outstanding Balance", '>%1', 0);
        LoansGuaranteeDetails.SetRange(Substituted, false);

        if LoansGuaranteeDetails.FindSet() then
            repeat
                // Get the loan's current outstanding balance
                if LoansRegister.Get(LoansGuaranteeDetails."Loan No") then begin
                    LoansRegister.CalcFields("Outstanding Balance");

                    // Use the lesser of: original guarantee or current loan balance
                    if LoansRegister."Outstanding Balance" < LoansGuaranteeDetails."Amont Guaranteed" then
                        EffectiveGuarantee := LoansRegister."Outstanding Balance"
                    else
                        EffectiveGuarantee := LoansGuaranteeDetails."Amont Guaranteed";

                    TotalEffective += EffectiveGuarantee;
                end;
            until LoansGuaranteeDetails.Next() = 0;

        exit(TotalEffective);
    end;
}