// Report 50208 "Member Loans Performance"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './Layouts/SASRA Loans Classification.rdlc';

//     dataset
//     {
//         dataitem("Loans Register"; "Loans Register")
//         {
//             DataItemTableView = sorting("Client Code") order(ascending) where(Posted = const(true));
//             RequestFilterFields = "Client Code", "Branch Code", "Loan Product Type", "Date filter", "Loan  No.", "Issued Date";

//             column(ReportForNavId_1120054000; 1120054000)
//             {
//             }
//             column(Recovery_Mode; "Recovery Mode")
//             {
//             }
//             column(PerformingDisplay; PerformingDisplay)
//             {
//             }
//             column(InterestArrears; InterestArrears)
//             {
//             }
//             column(Last_Pay_Date; "Last Pay Date")
//             {
//             }
//             column(Expected_Date_of_Completion; "Expected Date of Completion")
//             {
//             }
//             column(WatchDisplay; WatchDisplay)
//             {
//             }
//             column(StandardDisplay; StandardDisplay)
//             {
//             }
//             column(DoubtfulDisplay; DoubtfulDisplay)
//             {
//             }
//             column(LossDisplay; LossDisplay)
//             {
//             }
//             column(AmountInArrearsDisplay; AmountInArrearsDisplay)
//             {
//             }
//             column(LoanProductType_LoansRegister; "Loans Register"."Loan Product Type")
//             {
//             }
//             column(ClientCode_LoansRegister; "Loans Register"."Client Code")
//             {
//             }
//             column(RequestedAmount_LoansRegister; "Loans Register"."Requested Amount")
//             {
//             }
//             column(ApprovedAmount_LoansRegister; "Loans Register"."Schedule Repayment")
//             {
//             }
//             column(OutstandingBalance_LoansRegister; CurrentLoanBalance)
//             {
//             }
//             column(OustandingInterest_LoansRegister; InterestArrears)
//             {
//             }
//             column(LoanNo_LoansRegister; "Loans Register"."Loan  No.")
//             {
//             }
//             column(IssuedDate_LoansRegister; "Loans Register"."Issued Date")
//             {
//             }
//             column(ClientName_LoansRegister; "Loans Register"."Client Name")
//             {
//             }
//             column(NextCount; NextCount)
//             {
//             }
//             trigger OnAfterGetRecord()
//             begin
//                 LoansReg.Reset();
//                 LoansReg.SetRange(LoansReg."Loan  No.", "Loans Register"."Loan  No.");
//                 LoansReg.SetAutocalcFields(LoansReg."Scheduled Principle Payments", LoansReg."Schedule Loan Amount Issued", LoansReg."Schedule Installments", LoansReg."Outstanding Balance", LoansReg."Oustanding Interest", LoansReg."Scheduled Interest Payments", LoansReg."Interest Paid", LoansReg."Principal Paid");
//                 LoansReg.SetFilter(LoansReg."Date filter", '..' + Format(AsAt));
//                 LoansReg.SetFilter(LoansReg."Schedule Installments", '>%1', 0);
//                 if LoansReg.Find('-') then begin
//                     repeat
//                         if (LoansReg."Schedule Installments" > 0) then begin
//                             //..........Expected Loan Balance
//                             ExpectedLoanBal := 0;
//                             ExpectedLoanBal := LoansReg."Schedule Loan Amount Issued" - LoansReg."Scheduled Principle Payments";
//                             //...........Current Loan Balance
//                             CurrentLoanBalance := 0;
//                             CurrentLoanBalance := LoansReg."Outstanding Balance";
//                             //...........Calculate Principle Arrears
//                             LoanArrears := 0;
//                             LoanArrears := CurrentLoanBalance - ExpectedLoanBal;
//                             if LoanArrears < 0 then begin
//                                 LoanArrears := 0;
//                             end;
//                             if LoansReg.Source = LoansReg.Source::BOSA then begin
//                                 InterestArrears := 0;
//                                 InterestArrears := LoansReg."Oustanding Interest";
//                                 if InterestArrears < 0 then begin
//                                     InterestArrears := 0;
//                                 end;
//                             end
//                             else if LoansReg.Source = LoansReg.Source::FOSA then begin
//                                 InterestArrears := 0;
//                                 IF (LoansReg."Loan Product Type" = 'LPO') OR (LoansReg."Loan Product Type" = 'CHRISTMAS ADV') OR (LoansReg."Loan Product Type" = 'DIVIDEND') THEN begin
//                                     IF (LoansReg."Loan Product Type" = 'LPO') OR (LoansReg."Loan Product Type" = 'CHRISTMAS ADV') OR (LoansReg."Loan Product Type" = 'DIVIDEND') THEN begin
//                                         IF CalcDate('12M', LoansReg."Loan Disbursement Date") < AsAt then begin
//                                             InterestArrears := LoansReg."Oustanding Interest";
//                                         end
//                                         else IF CalcDate('12M', LoansReg."Loan Disbursement Date") >= AsAt then begin
//                                             InterestArrears := 0;
//                                         end;
//                                     end
//                                     else IF (LoansReg."Loan Product Type" = 'LPO') then begin
//                                         IF CalcDate('6M', LoansReg."Loan Disbursement Date") >= AsAt then begin
//                                             InterestArrears := 0;
//                                         end
//                                         else IF CalcDate('6M', LoansReg."Loan Disbursement Date") < AsAt then begin
//                                             InterestArrears := LoansReg."Oustanding Interest";
//                                         end;
//                                     end;
//                                 end
//                                 else begin
//                                     InterestArrears := LoansReg."Oustanding Interest";
//                                 end;
//                                 if InterestArrears < 0 then begin
//                                     InterestArrears := 0;
//                                 end;
//                             end
//                             else if LoansReg.Source = LoansReg.Source::MICRO then begin
//                                 InterestArrears := 0;
//                                 if loansreg."Issued Date" < 20230807D then begin
//                                     InterestArrears := LoansReg."Oustanding Interest";
//                                 end
//                                 else if loansreg."Issued Date" >= 20230807D then begin
//                                     InterestArrears := (LoansReg."Scheduled Interest Payments") - ((LoansReg."Interest Paid") * -1);
//                                 end;
//                                 if InterestArrears < 0 then begin
//                                     InterestArrears := 0;
//                                 end;
//                             end;
//                             IF (LoansReg."Loan Product Type" = 'OVERDRAFT') then begin
//                                 InterestArrears := 0;
//                                 InterestArrears := LoansReg."Scheduled Interest Payments" - (LoansReg."Interest Paid" * -1);
//                             end;
//                             //..........Get The Number of Months In Arrears
//                             if LoanArrears >= 1 then begin
//                                 NoOfMonthsInArrears := 0;
//                                 NoOfMonthsInArrears := ROUND(LoanArrears / (LoansReg."Schedule Loan Amount Issued" / LoansReg."Schedule Installments"), 1, '>');
//                             end
//                             else if LoanArrears < 1 then begin
//                                 NoOfMonthsInArrears := 0;
//                                 NoOfMonthsInArrears := 0;
//                             end;
//                             DaysInArrears := 0;
//                             DaysInArrears := ROUND((LoanArrears / (LoansReg."Schedule Loan Amount Issued" / LoansReg."Schedule Installments") * 30), 1, '>');
//                             // IF LoansReg."Loan  No." = 'LN007960' THEN begin
//                             //     Message('LOan Balance is %1 expected loan balance is %2 loan arrears is %3 hence days in arrears is %4', CurrentLoanBalance, ExpectedLoanBal, LoanArrears, DaysInArrears);
//                             // end;
//                             //...........Classify Paramenters
//                             PerformingDisplay := 0;
//                             WatchDisplay := 0;
//                             StandardDisplay := 0;
//                             DoubtfulDisplay := 0;
//                             LossDisplay := 0;
//                             AmountInArrearsDisplay := 0;
//                             IF LoansReg."Outstanding Balance" > 0 THEN begin
//                                 if (LoansReg."Expected Date of Completion" <> 0D) and (AsAt <= LoansReg."Expected Date of Completion") then begin
//                                     case NoOfMonthsInArrears of
//                                         0:
//                                             begin
//                                                 PerformingDisplay := LoansReg."Outstanding Balance";
//                                                 WatchDisplay := 0;
//                                                 StandardDisplay := 0;
//                                                 DoubtfulDisplay := 0;
//                                                 LossDisplay := 0;
//                                                 AmountInArrearsDisplay := LoanArrears;
//                                             end;
//                                         1:
//                                             begin
//                                                 PerformingDisplay := 0;
//                                                 WatchDisplay := LoansReg."Outstanding Balance";
//                                                 StandardDisplay := 0;
//                                                 DoubtfulDisplay := 0;
//                                                 LossDisplay := 0;
//                                                 AmountInArrearsDisplay := LoanArrears;
//                                             end;
//                                         2, 3, 4, 5, 6:
//                                             begin
//                                                 PerformingDisplay := 0;
//                                                 WatchDisplay := 0;
//                                                 StandardDisplay := LoansReg."Outstanding Balance";
//                                                 DoubtfulDisplay := 0;
//                                                 LossDisplay := 0;
//                                                 AmountInArrearsDisplay := LoanArrears;
//                                             end;
//                                         7, 8, 9, 10, 11, 12:
//                                             begin
//                                                 PerformingDisplay := 0;
//                                                 WatchDisplay := 0;
//                                                 StandardDisplay := 0;
//                                                 DoubtfulDisplay := LoansReg."Outstanding Balance";
//                                                 LossDisplay := 0;
//                                                 AmountInArrearsDisplay := LoanArrears;
//                                             end;
//                                         else begin
//                                             PerformingDisplay := 0;
//                                             WatchDisplay := 0;
//                                             StandardDisplay := 0;
//                                             DoubtfulDisplay := 0;
//                                             LossDisplay := LoansReg."Outstanding Balance";
//                                             AmountInArrearsDisplay := LoanArrears;
//                                         end;
//                                     end;
//                                 end
//                                 else if (LoansReg."Expected Date of Completion" <> 0D) and (AsAt > LoansReg."Expected Date of Completion") then begin
//                                     PerformingDisplay := 0;
//                                     WatchDisplay := 0;
//                                     StandardDisplay := 0;
//                                     DoubtfulDisplay := 0;
//                                     LossDisplay := LoansReg."Outstanding Balance";
//                                     AmountInArrearsDisplay := LoansReg."Outstanding Balance";
//                                 end;
//                             end
//                             ELSE IF LoansReg."Outstanding Balance" < 0 THEN begin
//                                 PerformingDisplay := 0;
//                                 WatchDisplay := 0;
//                                 StandardDisplay := 0;
//                                 DoubtfulDisplay := 0;
//                                 LossDisplay := 0;
//                                 AmountInArrearsDisplay := 0;
//                             end;
//                         end
//                         else begin
//                             PerformingDisplay := 0;
//                             WatchDisplay := 0;
//                             StandardDisplay := 0;
//                             DoubtfulDisplay := 0;
//                             LossDisplay := 0;
//                             AmountInArrearsDisplay := 0;
//                         end;
//                         if (PerformingDisplay = 0) and (WatchDisplay = 0) and (StandardDisplay = 0) and (DoubtfulDisplay = 0) and (LossDisplay = 0) then begin
//                             CurrReport.Skip;
//                         end;
//                         NextCount := NextCount + 1;
//                     until LoansReg.Next = 0;
//                 end;
//             end;

//             trigger OnPreDataItem()
//             var
//                 LoansClassificationUser: Codeunit "Loan Classification User";
//             begin
//                 ExpectedLoanBal := 0;
//                 NoOfMonthsInArrears := 0;
//                 LoanArrears := 0;
//                 CurrentLoanBalance := 0;
//                 DaysInArrears := 0;
//                 NextCount := 0;
//                 InterestArrears := 0;
//                 PerformingDisplay := 0;
//                 WatchDisplay := 0;
//                 StandardDisplay := 0;
//                 DoubtfulDisplay := 0;
//                 LossDisplay := 0;
//                 AmountInArrearsDisplay := 0;
//             end;
//         }
//     }
//     requestpage
//     {
//         layout
//         {
//             area(content)
//             {
//                 field(AsAt; AsAt)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'As At';
//                     ShowMandatory = true;
//                 }
//             }
//         }
//         actions
//         {
//         }
//     }
//     labels
//     {
//     }
//     trigger OnInitReport()
//     begin
//         AsAt := Today;
//     end;

//     trigger OnPreReport()
//     var
//         LoansClassificationUser: Codeunit "Loan Classification User";
//     begin
//         if AsAt = 0D then begin
//             AsAt := Today;
//         end;
//         //.....................
//         DateFilter := '..' + Format(AsAt);
//     end;

//     var
//         LoansReg: Record "Loans Register";
//         DateFilter: Text;
//         ExpectedLoanBal: Decimal;
//         CurrentLoanBalance: Decimal;
//         LoanArrears: Decimal;
//         NoOfMonthsInArrears: Decimal;
//         DaysInArrears: Decimal;
//         LoanBalanceDisplay: Decimal;
//         InterestArrears: Decimal;
//         DaysInArrearsDisplay: Integer;
//         AmountInArrearsDisplay: Decimal;
//         InterestInArrearsDisplay: Decimal;
//         LoanCategoryDisplay: Text;
//         DateBD: Date;
//         PerformingDisplay: Decimal;
//         WatchDisplay: Decimal;
//         StandardDisplay: Decimal;
//         DoubtfulDisplay: Decimal;
//         LossDisplay: Decimal;
//         NextCount: Integer;
//         AsAt: Date;
//         Day: Integer;
//         Month: Integer;
//         Year: Integer;
// }
