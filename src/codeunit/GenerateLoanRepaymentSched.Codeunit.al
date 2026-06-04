#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50195 "Generate Loan Repayment Sched"
{

    trigger OnRun()
    begin
        // FnGenerateLoanRepaymentSchedule('FLN_08399');
        // MESSAGE('done');
        //kyccomplete:=FnIsMemberKYCMissing('0101-001-69059');
        //ERROR('%1',kyccomplete);
        //NICALL

        // loans.RESET;
        // loans.SETRANGE(loans.Posted,TRUE);
        // loans.SETFILTER(loans."Loan Product Type",'LOANADVANCE');
        // IF loans.FIND('-') THEN BEGIN
        //  REPEAT
        //  FnGenerateLoanRepaymentSchedule(loans."Loan  No.");
        //    UNTIL loans.NEXT=0;
        //  END;
        FnUpdateLoanInsuranceCharges();
        Message('Schedules updated successfully');
    end;

    var
        ObjLoans: Record "Loans Register";
        ObjRepaymentschedule: Record "Loan Repayment Schedule";
        ObjLoansII: Record "Loans Register";
        VarPeriodDueDate: Date;
        VarRunningDate: Date;
        VarGracePeiodEndDate: Date;
        VarInstalmentEnddate: Date;
        VarGracePerodDays: Integer;
        VarInstalmentDays: Integer;
        VarNoOfGracePeriod: Integer;
        VarLoanAmount: Decimal;
        VarInterestRate: Decimal;
        VarRepayPeriod: Integer;
        VarLBalance: Decimal;
        VarRunDate: Date;
        VarInstalNo: Decimal;
        VarRepayInterval: DateFormula;
        VarTotalMRepay: Decimal;
        VarLInterest: Decimal;
        VarLPrincipal: Decimal;
        VarLInsurance: Decimal;
        VarRepayCode: Code[30];
        VarGrPrinciple: Integer;
        VarGrInterest: Integer;
        VarQPrinciple: Decimal;
        VarQCounter: Integer;
        VarInPeriod: DateFormula;
        VarInitialInstal: Integer;
        VarInitialGraceInt: Integer;
        VarScheduleBal: Decimal;
        VarLNBalance: Decimal;
        ObjProductCharge: Record "Loan Product Charges";
        VarWhichDay: Integer;
        VarRepaymentStartDate: Date;
        VarMonthIncreament: Text;
        ScheduleEntryNo: Integer;
        ScheduleEntryNoTemp: Integer;
        LoanProductsSetup: Record "Loan Products Setup";
        VarApplicationFee: Decimal;
        saccogen: Record "Sacco General Set-Up";
        kyccomplete: Boolean;
        loans: Record "Loans Register";
        LoanRestructure: Record "Loan Restructure";


    procedure FnGenerateLoanRepaymentReSchedule(LoanNo: Code[20])
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", LoanNo);
        if ObjLoans.FindSet then begin
            if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Daily then
                Evaluate(VarInPeriod, '1D')
            else
                if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Weekly then
                    Evaluate(VarInPeriod, '1W')
                else
                    if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Monthly then
                        Evaluate(VarInPeriod, '1M')
                    else
                        if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Quaterly then
                            Evaluate(VarInPeriod, '1Q');

            VarRunDate := 0D;
            VarQCounter := 0;
            VarQCounter := 3;
            VarScheduleBal := 0;

            VarGrPrinciple := ObjLoans."Grace Period - Principle (M)";
            VarGrInterest := ObjLoans."Grace Period - Interest (M)";
            VarInitialGraceInt := ObjLoans."Grace Period - Interest (M)";


            ObjLoansII.Reset;
            ObjLoansII.SetRange(ObjLoansII."Loan  No.", LoanNo);
            if ObjLoansII.Find('-') then begin
                ObjLoansII.CalcFields(ObjLoansII."Outstanding Balance");

                ObjLoans.TestField(ObjLoans."Loan Disbursement Date");
                ObjLoans.TestField(ObjLoans."Repayment Start Date");

                //=================================================================Delete From Tables
                ObjRepaymentschedule.Reset;
                ObjRepaymentschedule.SetRange(ObjRepaymentschedule."Loan No.", LoanNo);
                if ObjRepaymentschedule.Find('-') then begin
                    ObjRepaymentschedule.DeleteAll;
                end;
                LoanRestructure.Reset();
                LoanRestructure.SetRange(LoanRestructure."Loan to Restructure", LoanNo);
                if LoanRestructure.Find('-') then begin
                    LoanRestructure.CalcFields("Outstanding Loan");
                    VarLBalance := LoanRestructure."Outstanding Loan";
                    VarLoanAmount := LoanRestructure."Outstanding Loan";
                    VarLNBalance := LoanRestructure."Outstanding Loan";
                    Message('Outstanding Loan %1', VarLNBalance);
                    VarRepayPeriod := LoanRestructure."New Loan Period";

                end;


                VarInterestRate := ObjLoansII.Interest;
                VarInitialInstal := VarRepayPeriod + ObjLoansII."Grace Period - Principle (M)";


                VarRunDate := ObjLoansII."Repayment Start Date";
                VarRepaymentStartDate := ObjLoansII."Repayment Start Date";

                VarInstalNo := 0;
                Evaluate(VarRepayInterval, '1W');

                repeat
                    VarInstalNo := VarInstalNo + 1;
                    VarScheduleBal := VarLBalance;
                    ScheduleEntryNo := ScheduleEntryNo + 1;
                    ScheduleEntryNoTemp := ScheduleEntryNoTemp + 1;

                    //=======================================================================================Amortised
                    if ObjLoans."Repayment Method" = ObjLoans."repayment method"::Amortised
                       then begin
                        ObjLoans.TestField(ObjLoans.Installments);
                        ObjLoans.TestField(ObjLoans.Interest);
                        ObjLoans.TestField(ObjLoans.Installments);
                        VarTotalMRepay := ROUND((VarInterestRate / 12 / 100) / (1 - Power((1 + (VarInterestRate / 12 / 100)), -VarRepayPeriod)) * VarLoanAmount, 1, '>');
                        VarTotalMRepay := (VarInterestRate / 12 / 100) / (1 - Power((1 + (VarInterestRate / 12 / 100)), -VarRepayPeriod)) * VarLoanAmount;
                        VarLInterest := ROUND(VarLBalance / 100 / 12 * VarInterestRate);

                        VarLPrincipal := VarTotalMRepay - VarLInterest;
                    end;

                    //=======================================================================================Strainght Line
                    if ObjLoans."Repayment Method" = ObjLoans."repayment method"::"Straight Line" then begin
                        ObjLoans.TestField(ObjLoans.Installments);
                        VarLPrincipal := ROUND(VarLoanAmount / VarRepayPeriod, 1, '>');
                        VarLInterest := ROUND((VarInterestRate / 1200) * VarLoanAmount, 1, '>');
                        if VarInstalNo - ObjLoans."Grace Period - Interest (M)" = 1 then
                            VarLInterest := VarLInterest * VarInstalNo;

                        ObjLoans.Repayment := VarLPrincipal + VarLInterest;
                        ObjLoans."Loan Principle Repayment" := VarLPrincipal;
                        ObjLoans."Loan Interest Repayment" := VarLInterest;
                        ObjLoans.Modify;
                    end;

                    //=======================================================================================Reducing Balance
                    if ObjLoans."Repayment Method" = ObjLoans."repayment method"::"Reducing Balance" then begin
                        ObjLoans.TestField(ObjLoans.Interest);
                        ObjLoans.TestField(ObjLoans.Installments);//2828
                        VarLPrincipal := ROUND(VarLoanAmount / VarRepayPeriod, 1, '>');
                        VarLInterest := ROUND((VarInterestRate / 12 / 100) * VarLBalance, 1, '>');

                    end;

                    //=======================================================================================Constant
                    if ObjLoans."Repayment Method" = ObjLoans."repayment method"::Constants then begin
                        ObjLoans.Repayment := ObjLoans."Approved Amount" / ObjLoans.Installments;
                        ObjLoans.Modify(true);
                        ObjLoans.TestField(ObjLoans.Repayment);
                        if VarLBalance < ObjLoans.Repayment then
                            VarLPrincipal := VarLBalance
                        else
                            VarLPrincipal := ObjLoans.Repayment;

                        VarLInterest := ObjLoans.Interest;

                    end;

                    VarLPrincipal := ROUND(VarLPrincipal, 1, '>');
                    Evaluate(VarRepayCode, Format(VarInstalNo));
                    //======================================================================================Grace Period
                    if VarLBalance < VarLPrincipal then
                        VarLPrincipal := VarLBalance
                    else
                        VarLPrincipal := VarLPrincipal;
                    if VarGrPrinciple > 0 then begin
                        VarLPrincipal := 0;
                        VarLInsurance := 0
                    end else begin
                        VarLBalance := VarLBalance - VarLPrincipal;
                        VarScheduleBal := VarScheduleBal - VarLPrincipal;
                    end;

                    if VarGrInterest > 0 then
                        VarLInterest := 0;

                    VarGrPrinciple := VarGrPrinciple - 1;
                    VarGrInterest := VarGrInterest - 1;


                    //======================================================================================Insert Repayment Schedule Table
                    if VarInstalNo <> 1 then begin
                        VarLInsurance := 0;
                        VarApplicationFee := 0;
                    end;

                    ObjRepaymentschedule.Init;
                    //ObjRepaymentschedule."Entry No" := ScheduleEntryNo;
                    ObjRepaymentschedule."Repayment Code" := VarRepayCode;
                    ObjRepaymentschedule."Loan No." := ObjLoans."Loan  No.";
                    ObjRepaymentschedule."Loan Amount" := VarLoanAmount;
                    ObjRepaymentschedule."Interest Rate" := ObjLoans.Interest;
                    ObjRepaymentschedule."Instalment No" := VarInstalNo;
                    ObjRepaymentschedule."Repayment Date" := VarRunDate;//CALCDATE('CM',RunDate);
                    ObjRepaymentschedule."Member No." := ObjLoans."Client Code";
                    ObjRepaymentschedule."Loan Category" := ObjLoans."Loan Product Type";
                    ObjRepaymentschedule."Monthly Repayment" := VarLInterest + VarLPrincipal;
                    ObjRepaymentschedule."Monthly Interest" := VarLInterest;
                    ObjRepaymentschedule."Principal Repayment" := VarLPrincipal;
                    //ERROR(FORMAT(VarLPrincipal));
                    //ObjRepaymentschedule."Monthly Insurance" := VarLInsurance;
                    ObjRepaymentschedule."Loan Balance" := VarLBalance;
                    ObjRepaymentschedule.Insert;
                    VarWhichDay := Date2dwy(ObjRepaymentschedule."Repayment Date", 1);
                    //=======================================================================Get Next Repayment Date
                    VarMonthIncreament := Format(VarInstalNo) + 'M';
                    if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Daily then
                        VarRunDate := CalcDate('1D', VarRunDate)
                    else
                        if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Weekly then
                            VarRunDate := CalcDate('1W', VarRunDate)
                        else
                            if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Monthly then
                                VarRunDate := CalcDate(VarMonthIncreament, VarRepaymentStartDate)
                            else
                                if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Quaterly then
                                    VarRunDate := CalcDate('1Q', VarRunDate);

                until VarLBalance < 1
            end;
            Commit();
        end;
    end;



    procedure FnGenerateLoanRepaymentSchedule(LoanNo: Code[20])
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", LoanNo);
        if ObjLoans.FindSet then begin
            if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Daily then
                Evaluate(VarInPeriod, '1D')
            else
                if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Weekly then
                    Evaluate(VarInPeriod, '1W')
                else
                    if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Monthly then
                        Evaluate(VarInPeriod, '1M')
                    else
                        if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Quaterly then
                            Evaluate(VarInPeriod, '1Q');

            VarRunDate := 0D;
            VarQCounter := 0;
            VarQCounter := 3;
            VarScheduleBal := 0;

            VarGrPrinciple := ObjLoans."Grace Period - Principle (M)";
            VarGrInterest := ObjLoans."Grace Period - Interest (M)";
            VarInitialGraceInt := ObjLoans."Grace Period - Interest (M)";


            ObjLoansII.Reset;
            ObjLoansII.SetRange(ObjLoansII."Loan  No.", LoanNo);
            if ObjLoansII.Find('-') then begin
                ObjLoansII.CalcFields(ObjLoansII."Outstanding Balance");

                ObjLoans.TestField(ObjLoans."Loan Disbursement Date");
                ObjLoans.TestField(ObjLoans."Repayment Start Date");

                //=================================================================Delete From Tables
                ObjRepaymentschedule.Reset;
                ObjRepaymentschedule.SetRange(ObjRepaymentschedule."Loan No.", LoanNo);
                if ObjRepaymentschedule.Find('-') then begin
                    ObjRepaymentschedule.DeleteAll;
                end;

                VarLoanAmount := ObjLoansII."Approved Amount";
                VarInterestRate := ObjLoansII.Interest;
                VarRepayPeriod := ObjLoansII.Installments;
                VarInitialInstal := ObjLoansII.Installments + ObjLoansII."Grace Period - Principle (M)";
                VarLBalance := VarLoanAmount;
                VarLNBalance := ObjLoansII."Outstanding Balance";
                VarRunDate := ObjLoansII."Repayment Start Date";
                VarRepaymentStartDate := ObjLoansII."Repayment Start Date";

                VarInstalNo := 0;
                Evaluate(VarRepayInterval, '1W');

                repeat
                    VarInstalNo := VarInstalNo + 1;
                    VarScheduleBal := VarLBalance;
                    ScheduleEntryNo := ScheduleEntryNo + 1;
                    ScheduleEntryNoTemp := ScheduleEntryNoTemp + 1;

                    //=======================================================================================Amortised
                    if ObjLoans."Repayment Method" = ObjLoans."repayment method"::Amortised
                       then begin
                        ObjLoans.TestField(ObjLoans.Installments);
                        ObjLoans.TestField(ObjLoans.Interest);
                        ObjLoans.TestField(ObjLoans.Installments);
                        VarTotalMRepay := ROUND((VarInterestRate / 12 / 100) / (1 - Power((1 + (VarInterestRate / 12 / 100)), -VarRepayPeriod)) * VarLoanAmount, 1, '>');
                        VarTotalMRepay := (VarInterestRate / 12 / 100) / (1 - Power((1 + (VarInterestRate / 12 / 100)), -VarRepayPeriod)) * VarLoanAmount;
                        VarLInterest := ROUND(VarLBalance / 100 / 12 * VarInterestRate);

                        VarLPrincipal := VarTotalMRepay - VarLInterest;
                    end;

                    //=======================================================================================Strainght Line
                    if ObjLoans."Repayment Method" = ObjLoans."repayment method"::"Straight Line" then begin
                        ObjLoans.TestField(ObjLoans.Installments);
                        VarLPrincipal := ROUND(VarLoanAmount / VarRepayPeriod, 1, '>');
                        VarLInterest := ROUND((VarInterestRate / 1200) * VarLoanAmount, 1, '>');
                        if VarInstalNo - ObjLoans."Grace Period - Interest (M)" = 1 then
                            VarLInterest := VarLInterest * VarInstalNo;

                        ObjLoans.Repayment := VarLPrincipal + VarLInterest;
                        ObjLoans."Loan Principle Repayment" := VarLPrincipal;
                        ObjLoans."Loan Interest Repayment" := VarLInterest;
                        ObjLoans.Modify;
                    end;

                    //=======================================================================================Reducing Balance
                    if ObjLoans."Repayment Method" = ObjLoans."repayment method"::"Reducing Balance" then begin
                        ObjLoans.TestField(ObjLoans.Interest);
                        ObjLoans.TestField(ObjLoans.Installments);//2828
                        VarLPrincipal := ROUND(VarLoanAmount / VarRepayPeriod, 1, '>');
                        VarLInterest := ROUND((VarInterestRate / 12 / 100) * VarLBalance, 1, '>');

                    end;

                    //=======================================================================================Constant
                    if ObjLoans."Repayment Method" = ObjLoans."repayment method"::Constants then begin
                        ObjLoans.Repayment := ObjLoans."Approved Amount" / ObjLoans.Installments;
                        ObjLoans.Modify(true);
                        ObjLoans.TestField(ObjLoans.Repayment);
                        if VarLBalance < ObjLoans.Repayment then
                            VarLPrincipal := VarLBalance
                        else
                            VarLPrincipal := ObjLoans.Repayment;

                        VarLInterest := ObjLoans.Interest;

                    end;

                    VarLPrincipal := ROUND(VarLPrincipal, 1, '>');
                    Evaluate(VarRepayCode, Format(VarInstalNo));
                    //======================================================================================Grace Period
                    if VarLBalance < VarLPrincipal then
                        VarLPrincipal := VarLBalance
                    else
                        VarLPrincipal := VarLPrincipal;
                    if VarGrPrinciple > 0 then begin
                        VarLPrincipal := 0;
                        VarLInsurance := 0
                    end else begin
                        VarLBalance := VarLBalance - VarLPrincipal;
                        VarScheduleBal := VarScheduleBal - VarLPrincipal;
                    end;

                    if VarGrInterest > 0 then
                        VarLInterest := 0;

                    VarGrPrinciple := VarGrPrinciple - 1;
                    VarGrInterest := VarGrInterest - 1;


                    //======================================================================================Insert Repayment Schedule Table
                    if VarInstalNo <> 1 then begin
                        VarLInsurance := 0;
                        VarApplicationFee := 0;
                    end;

                    ObjRepaymentschedule.Init;
                    //ObjRepaymentschedule."Entry No" := ScheduleEntryNo;
                    ObjRepaymentschedule."Repayment Code" := VarRepayCode;
                    ObjRepaymentschedule."Loan No." := ObjLoans."Loan  No.";
                    ObjRepaymentschedule."Loan Amount" := VarLoanAmount;
                    ObjRepaymentschedule."Interest Rate" := ObjLoans.Interest;
                    ObjRepaymentschedule."Instalment No" := VarInstalNo;
                    ObjRepaymentschedule."Repayment Date" := VarRunDate;//CALCDATE('CM',RunDate);
                    ObjRepaymentschedule."Member No." := ObjLoans."Client Code";
                    ObjRepaymentschedule."Loan Category" := ObjLoans."Loan Product Type";
                    ObjRepaymentschedule."Monthly Repayment" := VarLInterest + VarLPrincipal;
                    ObjRepaymentschedule."Monthly Interest" := VarLInterest;
                    ObjRepaymentschedule."Principal Repayment" := VarLPrincipal;
                    //ERROR(FORMAT(VarLPrincipal));
                    //ObjRepaymentschedule."Monthly Insurance" := VarLInsurance;
                    ObjRepaymentschedule."Loan Balance" := VarLBalance;
                    ObjRepaymentschedule.Insert;
                    VarWhichDay := Date2dwy(ObjRepaymentschedule."Repayment Date", 1);
                    //=======================================================================Get Next Repayment Date
                    VarMonthIncreament := Format(VarInstalNo) + 'M';
                    if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Daily then
                        VarRunDate := CalcDate('1D', VarRunDate)
                    else
                        if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Weekly then
                            VarRunDate := CalcDate('1W', VarRunDate)
                        else
                            if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Monthly then
                                VarRunDate := CalcDate(VarMonthIncreament, VarRepaymentStartDate)
                            else
                                if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Quaterly then
                                    VarRunDate := CalcDate('1Q', VarRunDate);

                until VarLBalance < 1
            end;
            Commit();
        end;
    end;




    local procedure FnAreDeductionsCapitalized(LoansNo: Code[30]): Boolean
    begin
        // ObjLoans.Reset;
        // ObjLoans.SetRange(ObjLoans."Loan  No.", LoansNo);
        // if ObjLoans.Find('-') then begin
        //     LoanProductsSetup.Reset;
        //     LoanProductsSetup.SetRange(LoanProductsSetup.Code, ObjLoans."Loan Product Type");
        //     if LoanProductsSetup.Find('-') then begin
        //         if LoanProductsSetup.de = true then begin
        //             exit(false);
        //         end else
        //             if LoanProductsSetup."deduct fees from loan" = false then begin
        //                 exit(true);
        //             end;
        //     end;
        // end;
    end;

    local procedure FnCapitalizedCharges(LoansNo: Code[30]): Decimal
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", LoansNo);
        if ObjLoans.Find('-') then begin
            saccogen.Get();
            exit(ObjLoans."Capitalized Charges" + ((saccogen."Excise Duty(%)" / 100) * ObjLoans."Capitalized Charges"));
        end;
    end;


    procedure FnIsMemberKYCMissing(Clientcode: Code[50]): Boolean
    var
        MemberReg: Record Customer;
    begin
        MemberReg.Reset;
        MemberReg.SetRange(MemberReg."No.", Clientcode);
        if MemberReg.Find('-') then begin
            if (MemberReg."Account Category" = MemberReg."account category"::Single) then begin
                MemberReg.TestField(MemberReg.Name);
                MemberReg.TestField(MemberReg."Date of Birth");
                MemberReg.TestField(MemberReg."ID No.");
                MemberReg.TestField(MemberReg."Mobile Phone No");
                MemberReg.TestField(MemberReg."Employer Code");
                MemberReg.TestField(MemberReg."Personal No");
                MemberReg.TestField(MemberReg."Registration Date");
                MemberReg.TestField(MemberReg."Customer Posting Group");
                MemberReg.TestField(MemberReg."Global Dimension 1 Code");
                MemberReg.TestField(MemberReg."Global Dimension 2 Code");
                MemberReg.TestField(MemberReg.Pin);
                exit(true);
            end
            else
                if (MemberReg."Account Category" = MemberReg."account category"::Group) or (MemberReg."Account Category" = MemberReg."account category"::Corporate) then begin
                    MemberReg.TestField(MemberReg.Name);
                    MemberReg.TestField(MemberReg."Customer Posting Group");
                    MemberReg.TestField(MemberReg."Global Dimension 1 Code");
                    MemberReg.TestField(MemberReg."Global Dimension 2 Code");
                    MemberReg.TestField(MemberReg."Contact Person");
                end;
        end;
        exit(true);
    end;


    procedure FnUpdateLoanInsuranceCharges()
    var
        LoansRegister: Record "Loans Register";
        InsuranceCharges: Decimal;
    begin
        LoansRegister.Reset;
        InsuranceCharges := 0;
        LoansRegister.SetRange(LoansRegister.Posted, true);
        //LoansRegister.SetAutocalcFields(LoansRegister."Loan Doc No");
        if LoansRegister.Find('-') then begin
            repeat
                InsuranceCharges := 0;
                // InsuranceCharges := FnGetInsuranceUsingVendorLedger(LoansRegister."Loan Doc No", LoansRegister."Client Code");
                // if InsuranceCharges = 0 then begin
                //     //Use Customer Ledger Entry
                //     InsuranceCharges := FnGetInsuranceUsingCustLedger(LoansRegister."Loan Doc No", LoansRegister."Loan  No.");
                // end;
                LoansRegister."Loan Insurance" := InsuranceCharges;
                LoansRegister.Modify;
            until LoansRegister.Next = 0;
        end;
    end;

    local procedure FnGetInsuranceUsingVendorLedger(DocNo: Code[50]; ClientCode: Code[50]): Decimal
    var
        VendorTable: Record Vendor;
        VendorLedger: Record "Vendor Ledger Entry";
        VendorTable2: Record Vendor;
        VendorNo: Code[50];
    begin
        // .......Get vednor No
        VendorNo := '';
        VendorTable.Reset;
        VendorTable.SetRange(VendorTable."No.", ClientCode);
        if VendorTable.Find('-') = true then begin
            VendorNo := VendorTable."No.";
        end else
            if VendorTable.Find('-') = false then begin
                VendorTable2.Reset;
                VendorTable2.SetRange(VendorTable2."BOSA Account No", ClientCode);
                if VendorTable2.Find('-') then begin
                    VendorNo := VendorTable2."No.";
                end;
            end;
        // ....................
        VendorLedger.Reset;
        VendorLedger.SetRange(VendorLedger."Document No.", DocNo);
        VendorLedger.SetRange(VendorLedger."Vendor No.", VendorNo);
        VendorLedger.SetFilter(VendorLedger.Description, '%1', '*nsurance*');
        VendorLedger.SetAutocalcFields(VendorLedger.Amount);
        if VendorLedger.Find('-') then begin
            exit(VendorLedger.Amount);
        end;
    end;

    local procedure FnGetInsuranceUsingCustLedger(DocNo: Code[50]; ClientCode: Code[50]): Decimal
    var
        VendorTable: Record Vendor;
        VendorLedger: Record "Vendor Ledger Entry";
        VendorTable2: Record Vendor;
        VendorNo: Code[50];
        MemberTable: Record Customer;
        MemberLedger: Record "Cust. Ledger Entry";
        MemberTable2: Record Customer;
    begin
        MemberLedger.Reset;
        MemberLedger.SetRange(MemberLedger."Document No.", DocNo);
        MemberLedger.SetRange(MemberLedger."Loan No", ClientCode);
        MemberLedger.SetFilter(MemberLedger.Description, '%1', '*nsurance*');
        if MemberLedger.Find('-') then begin
            exit(MemberLedger.Amount);
        end;
    end;


    procedure FnUpdateLoanInsuranceChargesEach(LoanNo: Code[50]): Decimal
    var
        LoansRegister: Record "Loans Register";
        InsuranceCharges: Decimal;
    begin
        LoansRegister.Reset;
        InsuranceCharges := 0;
        LoansRegister.SetRange(LoansRegister.Posted, true);
        LoansRegister.SetRange(LoansRegister."Loan  No.", LoanNo);
        //LoansRegister.SetAutocalcFields(LoansRegister."Loan Doc No");
        if LoansRegister.Find('-') then begin
            InsuranceCharges := 0;
            // InsuranceCharges := FnGetInsuranceUsingVendorLedger(LoansRegister."Loan Doc No", LoansRegister."Client Code");
            // if InsuranceCharges = 0 then begin
            //     //Use Customer Ledger Entry
            //     InsuranceCharges := FnGetInsuranceUsingCustLedger(LoansRegister."Loan Doc No", LoansRegister."Loan  No.");
            // end;
        end;
        //MESSAGE('.....%1',InsuranceCharges);
        exit(InsuranceCharges);
    end;
}

