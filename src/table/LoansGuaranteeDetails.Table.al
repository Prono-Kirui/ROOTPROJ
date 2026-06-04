#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50372 "Loans Guarantee Details"
{
    DrillDownPageID = "Loans Guarantee Details";
    LookupPageID = "Loans Guarantee Details";

    fields
    {
        field(1; "Loan No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Loans Register"."Loan  No.";
        }
        field(2; "Member No"; Code[20])
        {
            NotBlank = false;
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                /*{Cust.SETRANGE(Cust."No.","Member No");
                IF Cust.FINDSET THEN BEGIN
                  IF Cust.Status<>Cust.Status::Active THEN BEGIN
                    ERROR('Only Active Members can guarantee Loans');
                    END;
                END;}
                
                {ObjWithApp.RESET;
                ObjWithApp.SETRANGE(ObjWithApp."Member No.","Member No");
                IF ObjWithApp.FINDSET=TRUE THEN BEGIN
                  ERROR('The Member has a pending Withdrawal Application');
                  END;
                }
                MemberCust.RESET;
                MemberCust.SETRANGE(MemberCust."No.","Member No");
                IF MemberCust.FIND('-') THEN BEGIN
                IF  MemberCust.Status=MemberCust.Status::"13" THEN
                ERROR('THE MEMBER  IS  A  DEFAULTER');
                END;
                
                
                LnGuarantor.RESET;
                LnGuarantor.SETRANGE(LnGuarantor."Loan  No.","Loan No");
                IF LnGuarantor.FIND('-') THEN BEGIN
                IF LnGuarantor."Client Code"="Member No" THEN  BEGIN
                
                "Self Guarantee":=TRUE;
                //MODIFY;
                END;
                END;
                LoanGuarantors.SETRANGE(LoanGuarantors."Self Guarantee",TRUE);
                LoanGuarantors.SETRANGE(LoanGuarantors."Member No","Member No");
                SelfGuaranteedA:=0;
                Date:=TODAY;
                
                LoanApps.RESET;
                LoanApps.SETRANGE(LoanApps."Client Code","Member No");
                LoanApps.SETRANGE(LoanApps."Loan Product Type",'DEFAULTER');
                LoanApps.SETRANGE(LoanApps.Posted,TRUE);
                IF LoanApps.FIND('-') THEN BEGIN
                REPEAT
                LoanApps.CALCFIELDS(LoanApps."Outstanding Balance");
                UNTIL LoanApps.NEXT=0;
                END;
                
                
                MemberCust.RESET;
                MemberCust.SETRANGE(MemberCust."No.","Member No");
                IF MemberCust.FIND('-') THEN BEGIN
                
                MemberCust.CALCFIELDS(MemberCust.TLoansGuaranteed,MemberCust."Current Savings");
                "Shares *3":=(MemberCust."Current Savings"*3);
                "TotalLoan Guaranteed":=MemberCust.TLoansGuaranteed;
                END;
                */
                IF Cust.GET("Member No") THEN BEGIN
                    Cust.CALCFIELDS(Cust."Outstanding Balance", Cust."Current Shares", Cust."Total Amount Guaranteed");
                    Name := Cust.Name;
                    "Staff/Payroll No." := Cust."Personal No";
                    "Loan Balance" := Cust."Outstanding Balance";
                    Shares := Cust."Current Shares" * 1;
                    Message('Shares %1', Shares);
                    "Amont Guaranteed" := Shares;
                    "TotalLoan Guaranteed" := Cust."Total Amount Guaranteed";
                    "Free Shares" := Shares - "TotalLoan Guaranteed";
                END;
                //  IF "Shares *3" < 1 THEN
                //      ERROR('Member Must have Deposit Contribution');





            end;
        }
        field(3; Name; Text[200])
        {
            Editable = false;
        }
        field(4; "Loan Balance"; Decimal)
        {
            Editable = false;
        }
        field(5; Shares; Decimal)
        {
            Editable = false;
        }
        field(6; "No Of Loans Guaranteed"; Integer)
        {
            CalcFormula = count("Loans Guarantee Details" where("Member No" = field("Member No"),
                                                                 "Outstanding Balance" = filter(> 1)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; Substituted; Boolean)
        {

            trigger OnValidate()
            begin
                //TESTFIELD("Substituted Guarantor");
            end;
        }
        field(8; Date; Date)
        {
        }
        field(9; "Shares Recovery"; Boolean)
        {
        }
        field(10; "New Upload"; Boolean)
        {
        }
        field(11; "Amont Guaranteed"; Decimal)
        {

            trigger OnValidate()
            begin
                /*SharesVariance:=0;
                LoanGuarantors.RESET;
                LoanGuarantors.SETRANGE(LoanGuarantors."Member No","Member No");
                IF LoanGuarantors.FIND('-') THEN BEGIN
                
                REPEAT
                LoanGuarantors.CALCFIELDS(LoanGuarantors."Outstanding Balance");
                IF LoanGuarantors."Outstanding Balance" > 0 THEN BEGIN
                Totals:=Totals+LoanGuarantors."Amont Guaranteed";
                END;
                UNTIL LoanGuarantors.NEXT=0;
                END;
                "Free Shares":=(Shares*3)-"TotalLoan Guaranteed";
                */

            end;
        }
        field(12; "Staff/Payroll No."; Code[20])
        {

            trigger OnValidate()
            begin
                /*Cust.RESET;
                Cust.SETRANGE(Cust."Personal No","Staff/Payroll No.");
                IF Cust.FIND('-') THEN BEGIN
                "Member No":=Cust."No.";
                VALIDATE("Member No");
                END
                ELSE
                "Member No":='';//ERROR('Record not found.')
                */

            end;
        }
        field(13; "Account No."; Code[20])
        {
        }
        field(14; "Self Guarantee"; Boolean)
        {
        }
        field(15; "ID No."; Code[70])
        {
        }
        field(16; "Outstanding Balance"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Transaction Type" = filter(Loan | "Loan Repayment"),
                                                                  "Loan No" = field("Loan No")));
            FieldClass = FlowField;
        }
        field(17; "Total Loans Guaranteed"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Amont Guaranteed" where("Loan No" = field("Loan No"),
                                                                                  Substituted = const(false),
                                                                                  "Self Guarantee" = const(false)));
            FieldClass = FlowField;
        }
        field(18; "Loans Outstanding"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Transaction Type" = filter(Loan | "Loan Repayment"),
                                                                  "Loan No" = field("Loan No")));
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                /*"Total Loans Guaranteed":="Outstanding Balance";
                MODIFY;
                */

            end;
        }
        field(19; "Guarantor Outstanding"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("Member No"),
                                                                  "Transaction Type" = filter(Loan | "Loan Repayment")));
            FieldClass = FlowField;
        }
        field(20; "Employer Code"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(21; "Employer Name"; Text[100])
        {
        }
        field(22; "Substituted Guarantor"; Code[80])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                /*GenSetUp.GET();
                IF LoansG > GenSetUp."Maximum No of Guarantees" THEN BEGIN
                ERROR('Member has guaranteed more than maximum active loans and  can not Guarantee any other Loans');
                "Member No":='';
                "Staff/Payroll No.":='';
                Name:='';
                "Loan Balance":=0;
                Date:=0D;
                EXIT;
                END;
                
                
                Loans.RESET;
                Loans.SETRANGE(Loans."Client Code","Member No");
                IF Loans.FIND('-') THEN BEGIN
                IF LoanGuarantors."Self Guarantee"=TRUE THEN
                ERROR('This Member has Self Guaranteed and Can not Guarantee another Loan');
                END;
                */

            end;
        }
        field(23; "Loanees  No"; Code[30])
        {
            CalcFormula = lookup("Loans Register"."Client Code" where("Loan  No." = field("Loan No")));
            FieldClass = FlowField;
        }
        field(24; "Loanees  Name"; Text[80])
        {
            CalcFormula = lookup("Loans Register"."Client Name" where("Loan  No." = field("Loan No")));
            FieldClass = FlowField;
        }
        field(25; "Loan Product"; Code[20])
        {
            CalcFormula = lookup("Loans Register"."Loan Product Type" where("Loan  No." = field("Loan No")));
            FieldClass = FlowField;
        }
        field(26; "Entry No."; Integer)
        {
        }
        field(27; "Loan Application Date"; Date)
        {
            CalcFormula = lookup("Loans Register"."Application Date" where("Loan  No." = field("Loan No")));
            FieldClass = FlowField;
        }
        field(28; "Free Shares"; Decimal)
        {
        }
        field(29; "Line No"; Integer)
        {
        }
        field(30; "Member Cell"; Code[10])
        {
        }
        field(31; "Share capital"; Decimal)
        {
        }
        field(32; "TotalLoan Guaranteed"; Decimal)
        {
            Description = '`';
        }
        field(33; Totals; Decimal)
        {
        }
        field(34; "Shares *3"; Decimal)
        {
        }
        field(35; "Deposits variance"; Decimal)
        {
        }
        field(36; "Defaulter Loan Installments"; Code[10])
        {
        }
        field(37; "Defaulter Loan Repayment"; Decimal)
        {
        }
        field(38; "Exempt Defaulter Loan"; Boolean)
        {
        }
        field(39; "Additional Defaulter Amount"; Decimal)
        {
        }
        field(40; "Total Guaranteed"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Loan Balance" where("Loan No" = field("Loan No"),
                                                                              Substituted = filter(false)));
            Description = '//>Sum total guaranteed amount for each loan';
            FieldClass = FlowField;
        }
        field(69161; "Total Committed Shares"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Amont Guaranteed" where("Member No" = field("Member No")));
            FieldClass = FlowField;
        }
        field(69162; "Oustanding Interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("Member No"),
                                                                  "Transaction Type" = filter("Interest Paid"),
                                                                  "Loan No" = field("Loan No")));
            FieldClass = FlowField;
        }
        field(69163; "Loan Risk Amount"; Decimal)
        {
        }
        field(69164; "Total Loan Risk"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Loan Risk Amount" where("Loan No" = field("Loan No")));
            FieldClass = FlowField;
        }
        field(69165; "Total Amount Guaranteed"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Amont Guaranteed" where("Loan No" = field("Loan No")));
            FieldClass = FlowField;
        }
        field(69166; "Approval Token"; Code[50])
        {
        }
        field(69167; "Acceptance Status"; Option)
        {
            OptionCaption = 'Pending,Accepted,Declined';
            OptionMembers = Pending,Accepted,Declined;
        }
        field(69168; "Date Accepted"; DateTime)
        {
        }
        field(50025; "Member Guaranteed"; Code[50])
        {
            Enabled = false;
        }
    }

    keys
    {
        key(Key1; "Loan No", "Staff/Payroll No.", "Member No", "Entry No.")
        {
        }
        key(Key2; "Loan No", "Member No")
        {
            Clustered = true;
            SumIndexFields = Shares;
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record Customer;
        LoanGuarantors: Record "Loans Guarantee Details";
        Loans: Record "Loans Register";
        LoansR: Record "Loans Register";
        LoansG: Integer;
        GenSetUp: Record "Sacco General Set-Up";
        SelfGuaranteedA: Decimal;
        StatusPermissions: Record "Status Change Permision";
        Employer: Record "Sacco Employers";
        loanG: Record "Loans Guarantee Details";
        CustomerRecord: Record Customer;
        MemberSaccoAge: Date;
        ComittedShares: Decimal;
        LoanApp: Record "Loans Register";
        DefaultInfo: Text;
        ok: Boolean;
        SharesVariance: Decimal;
        MemberCust: Record Customer;
        LnGuarantor: Record "Loans Register";
        LoanApps: Record "Loans Register";
        Text0001: label 'This Member has an Outstanding Defaulter Loan which has never been serviced';
        freeshares: Decimal;
        loanrec: Record "Loans Guarantee Details";
        ObjWithApp: Record "Membership Exist";

    local procedure UPDATEG()
    begin
    end;

    local procedure FnRunGetLoanRisk() VarLoanRisk: Decimal
    var
        ObjLoanType: Record "Loan Products Setup";
        ObjLoanCollateral: Record "Loan Collateral Details";
        VarCollateralSecurity: Decimal;
        VarArreasAmount: Decimal;
        VarNoGroupMembers: Integer;
        VarGroupNetWorth: Decimal;
        ObjCust: Record Customer;
        VarLastMonth: Date;
        ObjRepaymentSch: Record "Loan Repayment Schedule";
        VarArrears: Decimal;
        VarDateFilter: Text;
        VarRepaymentPeriod: Date;
        VarScheduledLoanBal: Decimal;
        VarLBal: Decimal;
        VarLastMonthDate: Integer;
        VarLastMonthMonth: Integer;
        VarLastMonthYear: Integer;
        VarRepaymentDate: Date;
        VarRepayDate: Integer;
        VarTotalArrears: Decimal;
        VarExitDeposits: Decimal;
        VarExitLoans: Decimal;
        VarMemberGuarantorshipLiability: Decimal;
        "NoofMonthsArrears:Deposit": Decimal;
        "AmountArrears:Deposit": Decimal;
        VarLastDayofPreviousMonth: Date;
        VarTotalLoansIssued: Decimal;
        ObjLoans: Record "Loans Register";
    begin
        //-----------------------------------------------------Get Group Networth
        VarCollateralSecurity := 0;
        VarRepaymentPeriod := WorkDate;
        VarArrears := 0;
        VarTotalArrears := 0;

        ObjLoanCollateral.Reset;
        ObjLoanCollateral.SetRange(ObjLoanCollateral."Member No", "Member No");
        if ObjLoanCollateral.FindSet then begin
            repeat

                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans."Loan  No.", ObjLoanCollateral."Loan No");
                if ObjLoans.FindSet then begin
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                    if ObjLoans."Outstanding Balance" > 0 then begin
                        VarCollateralSecurity := VarCollateralSecurity + ObjLoanCollateral."Guarantee Value";
                    end;
                end;
            until ObjLoanCollateral.Next = 0;
        end;


        ObjCust.Reset;
        ObjCust.SetRange(ObjCust."No.", "Member No");
        if ObjCust.FindSet then begin
            ObjCust.CalcFields(ObjCust."Total Loans Outstanding");
            if ObjCust."Total Loans Outstanding" > VarCollateralSecurity then begin
                VarLoanRisk := ObjCust."Total Loans Outstanding" - VarCollateralSecurity
            end else
                VarLoanRisk := 0;
        end;
    end;

    local procedure FnGetHouseGroupNetWorth(VarGuarantorNo: Code[30]) VarLoanRisk: Decimal
    var
        VarCollateralSecurity: Decimal;
        ObjLoanCollateral: Record "Loan Collateral Details";
        ObjLoans: Record "Loans Register";
        ObjCust: Record Customer;
    begin
        //-----------------------------------------------------Get Group Networth
        VarCollateralSecurity := 0;


        ObjLoanCollateral.Reset;
        ObjLoanCollateral.SetRange(ObjLoanCollateral."Member No", VarGuarantorNo);
        if ObjLoanCollateral.FindSet then begin
            repeat

                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans."Loan  No.", ObjLoanCollateral."Loan No");
                if ObjLoans.FindSet then begin
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                    if ObjLoans."Outstanding Balance" > 0 then begin
                        VarCollateralSecurity := VarCollateralSecurity + ObjLoanCollateral."Guarantee Value";
                    end;
                end;
            until ObjLoanCollateral.Next = 0;
        end;


        ObjCust.Reset;
        ObjCust.SetRange(ObjCust."No.", VarGuarantorNo);
        if ObjCust.FindSet then begin
            ObjCust.CalcFields(ObjCust."Total Loans Outstanding");
            if ObjCust."Total Loans Outstanding" > VarCollateralSecurity then begin
                VarLoanRisk := ObjCust."Total Loans Outstanding" - VarCollateralSecurity
            end else
                VarLoanRisk := 0;

        end;
    end;
}

