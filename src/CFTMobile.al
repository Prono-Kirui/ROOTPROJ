// codeunit 50453 "CFTMobile"
// {
//     procedure AccountBalance(Acc: Code[30]; DocNumber: Code[20]; IsChargeable: Boolean) Bal: Text[500]
//     begin
//         exit('');
//     end;

//     procedure AnyAccountBalance(phone: Code[70]; paybill_code: Code[50]) acc_amount: Text
//     begin
//         exit('');
//     end;

//     procedure MiniStatement(Phone: Text[70]; DocNumber: Text[20]; IsChargeable: Boolean; IsFromUSSD: Boolean) MiniStmt: Text[250]
//     var
//         bosa_no: Code[20];
//         minimunCount: Integer;
//         msg: Text;
//         MemberLedgerEntry: Record "Cust. Ledger Entry";
//     begin
//         bosa_no := BOSAAccount(Phone);
//         MiniStmt := '';
//         msg := '';
//         minimunCount := 1;

//         IF bosa_no = '' THEN
//             EXIT('');
//         MemberLedgerEntry.RESET;
//         MemberLedgerEntry.SETRANGE(MemberLedgerEntry."Customer No.", bosa_no);
//         MemberLedgerEntry.SETRANGE(Reversed, FALSE);
//         MemberLedgerEntry.ASCENDING(FALSE);
//         IF MemberLedgerEntry.FIND('-') THEN BEGIN
//             REPEAT
//                 amount := MemberLedgerEntry.Amount;
//                 IF amount < 1 THEN
//                     amount := amount * -1;
//                 MiniStmt := MiniStmt + FORMAT(MemberLedgerEntry."Posting Date") + '$' + COPYSTR(MemberLedgerEntry.Description, 1, 25) + '$' + DELCHR(FORMAT(ABS(MemberLedgerEntry."Amount Posted")), '=', ',') + ':::';
//                 msg := msg + FORMAT(MemberLedgerEntry."Posting Date") + ';' + COPYSTR(MemberLedgerEntry.Description, 1, 25) + ';' + DELCHR(FORMAT(MemberLedgerEntry."Amount Posted"), '=', ',') + '#';
//                 minimunCount := minimunCount + 1;
//                 IF minimunCount > 5 THEN BEGIN
//                     EXIT(MiniStmt);
//                 END;
//             UNTIL MemberLedgerEntry.NEXT = 0;
//             CFTFactory.fnsendmessage(bosa_no, Phone, 'MOBILETRAN', msg);
//         END;

//     end;

//     procedure LoanProducts() LoanTypes: Text[1000]
//     begin
//         // ObjLoanProducts.RESET;
//         // ObjLoanProducts.SETRANGE(Source, ObjLoanProducts.Source::BOSA);
//         // IF ObjLoanProducts.FIND('-') THEN BEGIN
//         //     REPEAT
//         //         LoanTypes := LoanTypes + ':::' + ObjLoanProducts."Product Description";
//         //     UNTIL ObjLoanProducts.NEXT = 0;
//         // END
//         exit('');
//     end;

//     procedure LoanProductDetails() LoanTypes: Text[1000]
//     BEGIN
//         // ObjLoanProducts.RESET;
//         // ObjLoanProducts.SETRANGE(Source, ObjLoanProducts.Source::" ");
//         // ObjLoanProducts.SETFILTER(Code, '<>%1', '');
//         // IF ObjLoanProducts.FIND('-') THEN BEGIN
//         //     REPEAT
//         //         LoanTypes := LoanTypes + ObjLoanProducts.Code + '$' + ObjLoanProducts."Product Description" + '$' + FORMAT(ObjLoanProducts."Instalment Period") + '$' +
//         //         FORMAT(ObjLoanProducts."Repayment Frequency") + '$' + DELCHR(FORMAT(ObjLoanProducts."Interest rate"), '=', ',') + '$'
//         //         + DELCHR(FORMAT(ObjLoanProducts."Max. Loan Amount"), '=', ',') + '$' + DELCHR(FORMAT(ObjLoanProducts."Min. Loan Amount"), '=', ',') + '$' + FORMAT(ObjLoanProducts."Interest Calculation Method") + '#';
//         //     UNTIL ObjLoanProducts.NEXT = 0;
//         // END
//         exit('');
//     END;

//     procedure LoanProductDetailsFOSA() LoanTypes: Text[1000]
//     BEGIN
//         ObjLoanProducts.RESET;
//         ObjLoanProducts.SETRANGE(Source, ObjLoanProducts.Source::BOSA);
//         IF ObjLoanProducts.FIND('-') THEN BEGIN
//             REPEAT
//                 LoanTypes := LoanTypes + ObjLoanProducts.Code + '$' + ObjLoanProducts."Product Description" + '$' + FORMAT(ObjLoanProducts."Instalment Period") + '$' +
//                 FORMAT(ObjLoanProducts."Repayment Frequency") + '$' + DELCHR(FORMAT(ObjLoanProducts."Interest rate"), '=', ',') + '$'
//                 + DELCHR(FORMAT(ObjLoanProducts."Max. Loan Amount"), '=', ',') + '$' + DELCHR(FORMAT(ObjLoanProducts."Min. Loan Amount"), '=', ',') + '$' + FORMAT(ObjLoanProducts."Repayment Method") + '#';
//             UNTIL ObjLoanProducts.NEXT = 0;
//         END
//     END;

//     procedure LoanProductDetailsMICRO() LoanTypes: Text[1000]
//     BEGIN
//         // ObjLoanProducts.RESET;
//         // ObjLoanProducts.SETRANGE(Source, ObjLoanProducts.Source::MICRO);
//         // ObjLoanProducts.SETFILTER(Code, '<>%1', 'SHAREBOOST');
//         // IF ObjLoanProducts.FIND('-') THEN BEGIN
//         //     REPEAT
//         //         LoanTypes := LoanTypes + ObjLoanProducts.Code + '$' + ObjLoanProducts."Product Description" + '$' + FORMAT(ObjLoanProducts."Instalment Period") + '$' +
//         //         FORMAT(ObjLoanProducts."Repayment Frequency") + '$' + DELCHR(FORMAT(ObjLoanProducts."Interest rate"), '=', ',') + '$'
//         //         + DELCHR(FORMAT(ObjLoanProducts."Max. Loan Amount"), '=', ',') + '$' + DELCHR(FORMAT(ObjLoanProducts."Min. Loan Amount"), '=', ',') + '$' + FORMAT(ObjLoanProducts."Interest Calculation Method") + '#';
//         //     UNTIL ObjLoanProducts.NEXT = 0;
//         // END
//         exit('');
//     END;

//     procedure RegisteredMemberAccount(Phone: Text[20]; IdNumber: Code[20]; MemberNo: Code[40]) reginfo: Text[1000]
//     begin
//         exit('');
//     end;

//     procedure RegisteredMemberDetails(Phone: Text[20]) reginfo: Text[1000]
//     begin
//         exit('');
//     end;

//     procedure DetailedStatement(Phone: Text[20]; lastEntry: Integer) detailedstatement: Text[1023]
//     var
//         dateExpression: text[20];
//         dashboardDataFilter: date;
//         code: code[20];

//     begin
//         exit('');
//     end;

//     procedure MemberAccountNames(phone: Text[20]) accounts: Text[250]
//     begin
//         exit('');
//     end;

//     procedure AccountDescription(code: Text[20]) description: Text[100]
//     BEGIN
//         exit('');
//     END;

//     procedure FnGetRegisteredAccount(Phone: Code[20]): Code[50]
//     var
//         RegAcc: code[20];
//     begin
//         CFTMobileApplication.RESET;
//         // CFTMobileApplication.SETRANGE(Telephone, '254' + Phone);
//         CFTMobileApplication.SETFILTER(Telephone, '%1|%2|%3|%4', '+254' + Phone, '254' + Phone, '0' + Phone, Phone);
//         CFTMobileApplication.SETRANGE(CFTMobileApplication."Mobile Status", CFTMobileApplication."Mobile Status"::Active);
//         IF CFTMobileApplication.FIND('-') THEN BEGIN
//             RegAcc := CFTMobileApplication."Member No.";
//         END
//         ELSE BEGIN
//             RegAcc := 'NOTFOUND';
//         END;
//         EXIT(RegAcc);
//     end;

//     LOCAL procedure GetLoanBalance(paybill_code: Code[20]; Phone: Code[20]) amount_: Text
//     begin
//         exit('');
//     end;


//     LOCAL procedure BackOfficeAccountsBal(paybill_code: Code[20]; Phone: Code[20]) balance: Text
//     begin
//         exit('');
//     end;

//     procedure MemberAccountNumbers(phone: Text[20]) accounts: Text[250]
//     begin
//         exit('');
//     end;



//     procedure BackOfficeAccounts(phone: Text[20]) backoffice_accounts: Text[1700]
//     var
//         accounts: Text[1700];
//         canDepositShares: Integer;
//     begin
//         objCustomer.RESET;
//         objCustomer.SETRANGE("No.", BOSAAccount(phone));
//         IF objCustomer.FINDFIRST THEN BEGIN
//             objCustomer.CALCFIELDS("Current Shares", "Insurance Fund", "Un-allocated Funds", "Dividend Amount", "Shares Retained");

//             backoffice_accounts :=
//                 'Share Capital$' + DELCHR(FORMAT(objCustomer."Shares Retained"), '=', ',') + '$sharcap$SHA$1$1#' +
//                 'Deposit Contribution$' + DELCHR(FORMAT(objCustomer."Current Shares"), '=', ',') + '$memb_dep$DEP$1$1#';
//         END;
//         EXIT(backoffice_accounts);
//     end;


//     procedure NextOfKins(phone: Text[20]) kins: Text
//     var
//         ObjKins: Record "Members Next of Kin";
//         bosa_no: Code[50];
//     begin
//         bosa_no := BOSAAccount(phone);
//         IF bosa_no = '' THEN EXIT('');
//         ObjKins.RESET();
//         ObjKins.SETRANGE("Account No", bosa_no);
//         IF ObjKins.FIND('-') THEN BEGIN
//             REPEAT
//                 kins := kins + ObjKins."Name" + '$' +
//                 FORMAT(ObjKins."Relationship") + '$' +
//                 DELCHR(FORMAT(ObjKins."%Allocation"), '=', ',') + '$' +
//                 FORMAT(ObjKins.Beneficiary) + '$' +
//                 '' + '$' +  //location
//                 FORMAT(ObjKins.Telephone) + '$' +
//                 FORMAT(ObjKins."Email") + '$' +
//                 FORMAT(ObjKins."ID No.") + '$' +
//                 FORMAT(ObjKins."Guardian") + '$' +
//                 '' + '$' + //guardian telephone
//                 '' + '$' +  //guardian address
//                 '' + '$' +  //guargian email
//                 '' + '$' +  //bo application nos
//                 '' + '$' +  //guardian_kra_pin
//                 '' + '$' +  //guardian_id
//                 '' + '$' +  //guardian_relationship
//                 '' + '$' +  //guardian_alt_no
//                 '#';
//             UNTIL ObjKins.NEXT() = 0;
//         END;
//     end;

//     procedure FOSAAccount(Phone: Text[20]) fosaAcc: Text[20]
//     begin
//         exit('');
//     end;

//     procedure AnyFOSAAccount(Phone: Text[20]; accountType: Code[50]) fosaAcc: Text[20]
//     begin
//         exit('');
//     end;


//     procedure BOSAAccount(Phone: Text[20]) bosaAcc: Text[20]
//     begin
//         ObjCustomer.RESET;
//         ObjCustomer.SETFILTER("Phone No.", '%1|%2|%3|%4', '+254' + Phone, '254' + Phone, '0' + Phone, Phone);
//         ObjCustomer.SETFILTER(Status, '%1', ObjCustomer.Status::Active);
//         IF ObjCustomer.FIND('-') THEN BEGIN
//             bosaAcc := ObjCustomer."No.";
//         END ELSE BEGIN
//             bosaAcc := 'NOT FOUND';
//         END;
//         exit(bosaAcc);
//     end;


//     procedure MemberFosaAccountNo(phone: Code[15]; acc_code: Code[20]) acc_no: Text
//     begin
//         exit('');
//     end;

//     procedure MemberFosaAccountName(FosaNo: Code[20]) BosaAccountName: Text
//     begin
//         BosaAccountName := '';
//         ObjCustomer.RESET;
//         ObjCustomer.SETRANGE("No.", FosaNo);
//         IF ObjCustomer.FIND('-') THEN
//             BosaAccountName := ObjCustomer.Name;
//     end;

//     procedure sharesRetained(phone: Text[20]) shares: Text[1000]
//     begin

//         exit('');
//     end;

//     procedure CurrentShares(phone: Text[20]) shares: Text[1000]
//     begin

//         exit('');
//     end;

//     procedure BenevolentFund(phone: Text[20]) shares: Text[1000]
//     begin
//         exit('');
//     end;

//     procedure GetMonthIncome(phone: Code[20]) incomes: Text
//     var
//         current_month: date;
//         count: integer;
//     begin

//         exit('');
//     end;

//     procedure FundsTransferFOSA(phone: Text[20]; accTo: Text[20]; DocNumber: Text[30]; amount: Decimal) result: Text[30]
//     var
//         accFrom: code[20];
//         bosa_no: code[20];
//     begin
//         exit('');
//     end;

//     procedure FundsTransferBOSA(phone: Text[20]; accTo: Text[20]; DocNumber: Text[30]; amount: Decimal; loanNo: Code[20]) result: Text[30]
//     var
//         accFrom: code[20];
//         bosa_no: code[20];
//     begin
//         exit('');
//     end;

//     procedure LoanBalances(phone: Text[20]) result: Text[50]
//     var
//         loanbal: text[250];
//     begin

//         exit('');
//     end;

//     procedure MemberAccounts(phone: Text[20]): Text[1700]
//     var
//         accounts: Text[1700];
//     begin
//         exit('');
//     end;


//     procedure MemberAccountsByIdNumber(idNumber: Text[20]) accounts: Text[700]
//     begin
//         // accounts := '';
//         // objCustomer.RESET;
//         // objCustomer.SETRANGE("ID Number", idNumber);
//         // objCustomer.setrange("Customer Posting Group", 'FO');

//         // objCustomer.SETRANGE("Status", objCustomer."Status"::Active);

//         // objCustomer.SETRANGE("status", objCustomer."status"::Active);
//         // objCustomer.SETRANGE(Blocked, objCustomer.Blocked::" ");
//         // objCustomer.SETFILTER("FOSA Account", 'ORDINARY');
//         // IF objCustomer.FINDFIRST THEN
//         //     accounts := objCustomer."No." + '$' + AccountDescription(objCustomer."FOSA Account") + '$' + AccountBalance(objcustomer."No.", '', FALSE) + '$' + GetSavingsPaybillCode(objCustomer."FOSA Account") + '$' + objCustomer.Name;
//         exit('');
//     end;

//     procedure CFTMOBILERegistration(No: Code[20]) memberdetails: Text[1000]
//     var
//         mSTATUS: code[10];
//     begin
//         // memberdetails := '';
//         // mSTATUS := '0';
//         // CFTMobileApplication.RESET;
//         // CFTMobileApplication.SETASCENDING("No.", TRUE);
//         // CFTMobileApplication.SETRANGE(CFTMobileApplication.SentToServer, FALSE);
//         // CFTMobileApplication.SETRANGE(CFTMobileApplication."Approval Status", CFTMobileApplication."Approval Status"::Approved);
//         // CFTMobileApplication.SETRANGE(CFTMobileApplication."No.", No);
//         // IF CFTMobileApplication.FINDFIRST() THEN BEGIN
//         //     IF CFTMobileApplication."Mobile Status" = CFTMobileApplication."Mobile Status"::Active THEN
//         //         mSTATUS := '1';
//         //     memberdetails := CFTMobileApplication."Current Account No" + '$' + CFTMobileApplication.Telephone + '$' + CFTMobileApplication."ID No" + '$' + mSTATUS + '$' + CFTMobileApplication."Member No.";
//         // END;
//         exit('');
//     end;

//     procedure UpdateCFTMOBILERegistration(phone: Text[30]) result: Text[100]
//     begin
//         CFTMobileApplication.RESET;
//         CFTMobileApplication.SETRANGE(CFTMobileApplication.SentToServer, FALSE);
//         CFTMobileApplication.SETRANGE(CFTMobileApplication.Telephone, '254' + phone);
//         IF CFTMobileApplication.FIND('-') THEN BEGIN
//             CFTMobileApplication.SentToServer := TRUE;
//             CFTMobileApplication."CFT Registered" := TRUE;
//             CFTMobileApplication."Approval Status" := CFTMobileApplication."Approval Status"::Active;
//             CFTMobileApplication.MODIFY;
//             result := 'Modified';
//         END
//         ELSE BEGIN
//             result := 'Failed';
//         END;
//         EXIT(result);
//     end;

//     procedure CFTGETNewApplicants() numbers: Text
//     var
//         new_apps: Text;
//     begin
//         // new_apps := '';
//         // CFTMobileApplication.RESET;
//         // CFTMobileApplication.SETASCENDING("No.", TRUE);
//         // CFTMobileApplication.SETRANGE(CFTMobileApplication.SentToServer, FALSE);
//         // CFTMobileApplication.SETRANGE(CFTMobileApplication."Approval Status", CFTMobileApplication."Approval Status"::Approved);
//         // CFTMobileApplication.SETFILTER("Date Applied", '>%1', 20230606D);
//         // IF CFTMobileApplication.FIND('-') THEN BEGIN
//         //     REPEAT
//         //         new_apps := new_apps + '$' + CFTMobileApplication."No.";
//         //     UNTIL CFTMobileApplication.NEXT = 0;
//         // END;
//         // EXIT(new_apps);
//         exit('');
//     end;

//     procedure CFTPINResetRequests() numbers: Text
//     begin
//         // CFTMobileApplication.RESET;
//         // CFTMobileApplication.SETASCENDING("No.", TRUE);
//         // CFTMobileApplication.SETRANGE(CFTMobileApplication.SentToServer, FALSE);
//         // CFTMobileApplication.SETRANGE(CFTMobileApplication."Transaction Type", CFTMobileApplication."Transaction Type"::"PIN Reset");
//         // CFTMobileApplication.SETFILTER("Last PIN Reset", '>%1', 20230606D);
//         // IF CFTMobileApplication.FINDFIRST THEN BEGIN
//         //     numbers := CFTMobileApplication.Telephone;
//         // END;
//         // EXIT(numbers);
//         exit('');
//     end;

//     procedure GetSavingsPaybillCode(AccountType: Code[20]) ProductCode: Code[50]
//     begin
//         // ObjAccType.RESET;
//         // ObjAccType.SETRANGE(Code, AccountType);
//         // IF ObjAccType.FIND('-') THEN BEGIN
//         //     ProductCode := ObjAccType."Account No Prefix";
//         // END
//         exit('');
//     end;

//     procedure FnRecordExists(DocNumber: Code[30]) RecExists: Boolean
//     begin
//         // CFTMobileTransactions.RESET;
//         // CFTMobileTransactions.SETRANGE("Document No", DocNumber);
//         // IF CFTMobileTransactions.FIND('-') THEN BEGIN
//         //     RecExists := TRUE;
//         // END;
//         exit(false);
//     end;



//     LOCAL procedure GetBackOfficeProductCode(paybill_code: Code[100]) bo_account: Text
//     begin
//         // CASE paybill_code OF
//         //     'GPD', 'DEP', 'MDP':
//         //         bo_account := 'Deposit Contributions';
//         //     'RSK':
//         //         bo_account := 'Benevolent Fund';
//         //     'SHA':
//         //         bo_account := 'Share Capital';
//         // END;
//         exit('');
//     end;



//     procedure GetSavingsProductCode(ProductPaybillCode: Code[20]) ProductCode: Code[50]
//     begin
//         // ObjAccType.RESET;
//         // ObjAccType.SETRANGE("Code", ProductPaybillCode);
//         // IF ObjAccType.FIND('-') THEN BEGIN
//         //     ProductCode := ObjAccType."Code";
//         // END
//         exit('');
//     end;

//     procedure FnSufficientBalanceTest(AccountNo: Code[100]; TestBalance: Decimal) BalanceAvailable: Boolean
//     begin
//         // BalanceAvailable := FALSE;
//         // current_balance := CFTFactory.getAvailableBal(AccountNo);
//         // IF current_balance > TestBalance THEN
//         //     BalanceAvailable := TRUE;
//         exit(false);
//     end;

//     procedure FnLogMobileTransactions(DocumentNo: Code[20]; Description: Text; accFrom: Code[20]; accTo: Code[20]; bosa_no: Code[20]; phone: Code[20]; msg_sent: Text; transaction_type: Option; Posted: Boolean; Status: Option; Comments: Text; trans_amount: Decimal; LoanNo: code[20]; CFTRef: code[20])
//     BEGIN

//     END;

//     procedure FnPostMobileCharges() result: Text
//     begin
//         exit('');
//     end;

//     procedure WSSAccount(phone: Text[20]) accounts: Text[250]
//     begin
//         exit('');
//     END;

//     procedure OutstandingLoans(phone: Text[20]; IsChargeable: Boolean; DocNumber: Code[20]) loans: Text
//     var
//         acc_no: Code[20];
//         Acc: Code[20];
//     begin
//         acc_no := BOSAAccount(phone);
//         Acc := FnGetRegisteredAccount(phone);
//         IF acc_no = '' THEN EXIT('Account not found');
//         IF Acc = '' THEN EXIT('Not found');

//         ObjLoans.RESET;
//         ObjLoans.SETRANGE(ObjLoans."Client Code", acc_no);
//         ObjLoans.CALCFIELDS(ObjLoans."Outstanding Balance");
//         ObjLoans.SETFILTER(ObjLoans."Outstanding Balance", '>%1', 0);
//         loans := '';
//         IF ObjLoans.FIND('-') THEN BEGIN
//             REPEAT
//                 ObjLoans.CALCFIELDS(ObjLoans."Outstanding Balance", ObjLoans."Outstanding Interest", ObjLoans."Current Interest Paid");
//                 IF (ObjLoans."Outstanding Balance" > 0) THEN
//                     loans := loans + ObjLoans."Loan  No." +
//                     '$' + DELCHR(FORMAT(ObjLoans."Loan Product Type"), '=', ',') +
//                     '$' + DELCHR(FORMAT(ObjLoans."Approved Amount"), '=', ',') +
//                     '$' + DELCHR(FORMAT(ObjLoans."Outstanding Balance" + ObjLoans."Outstanding Interest"), '=', ',') +
//                     '$' + GetLoanPaybillCode(ObjLoans."Loan Product Type") +
//                     '$' + DELCHR(FORMAT(ObjLoans."Loan Principle Repayment"), '=', ',') +
//                     '$' + FORMAT(ObjLoans."Application Date") +
//                     '$' + DELCHR(FORMAT(ObjLoans."Outstanding Interest"), '=', ',') +
//                     '$' + DELCHR(FORMAT(ObjLoans."Interest"), '=', ',') +
//                     '$' + DELCHR(FORMAT(ObjLoans."Amount in Arrears"), '=', ',') +
//                     '$' + FORMAT(CALCDATE(FORMAT(ObjLoans."Installments") + 'M', ObjLoans."Application Date")) +
//                     '$' + FORMAT(ObjLoans."Installments") + '#';
//             UNTIL ObjLoans.NEXT = 0;
//         END;

//         // IF IsChargeable THEN BEGIN
//         //     FnLogMobileTransactions(DocNumber, 'Loan Balance Enquiry', Acc, '', '', phone, '', CFTMobileTransactions."Transaction Type"::"Loan balance", FALSE, CFTMobileTransactions.Status::Pending, 'Loan Balance Enquiry', 0, '', '');
//         // END;

//         exit(loans);
//     end;


//     procedure GetLoanPaybillCode(ProductCode: Code[100]) ProductPaybillCode: Code[50]
//     begin
//         ObjLoanProducts.RESET;
//         ObjLoanProducts.SETRANGE(Code, ProductCode);
//         IF ObjLoanProducts.FIND('-') THEN BEGIN
//             ProductPaybillCode := ObjLoanProducts.Paybill_Code;
//         END;
//     end;

//     procedure LoanRepayment(accFrom: Text[20]; loanNo: Text[20]; DocNumber: Text[30]; amount: Decimal)
//     amount_paid: Decimal;
//     begin

//     end;

//     procedure LoanGuarantors(loanNo: Text[20]) guarantors: Text[1000]
//     begin

//         exit('');
//     end;

//     procedure LoansGuaranteed(phone: Text[20]) guarantors: Text
//     var
//         bosaNo: text[20];
//         rec_count: integer;

//         GuarantorLiability: Decimal;
//     begin
//         bosaNo := BOSAAccount(phone);
//         IF bosaNo = 'NOTFOUND' THEN EXIT('');
//         rec_count := 0;

//         LoanGuaranteeDetails.RESET;
//         LoanGuaranteeDetails.SETRANGE(LoanGuaranteeDetails."Member No", bosaNo);
//         LoanGuaranteeDetails.SETRANGE("Substituted", FALSE);
//         IF LoanGuaranteeDetails.FIND('-') THEN BEGIN
//             REPEAT
//                 ObjLoans.RESET;
//                 ObjLoans.SETRANGE(ObjLoans."Loan  No.", LoanGuaranteeDetails."Loan No");
//                 ObjLoans.SetFilter("Approved Amount", '>%1', 0);
//                 IF ObjLoans.FIND('-') THEN BEGIN
//                     LoanGuaranteeDetails.CALCFIELDS("Outstanding Balance", "Total Guaranteed");
//                     GuarantorLiability := (LoanGuaranteeDetails."Amont Guaranteed" / ObjLoans."Approved Amount") * LoanGuaranteeDetails."Outstanding Balance";

//                     IF ((LoanGuaranteeDetails."Outstanding Balance" > 2)) THEN BEGIN
//                         Objloans.GET(LoanGuaranteeDetails."Loan No");
//                         guarantors := guarantors + FORMAT(ObjLoans."Client Name") + '$' +
//                         DELCHR(FORMAT(LoanGuaranteeDetails."Amont Guaranteed"), '=', ',') + '$' +
//                         DELCHR(FORMAT(LoanGuaranteeDetails."Outstanding Balance"), '=', ',') + '$' +
//                         DELCHR(FORMAT(ROUND(GuarantorLiability, 0.01, '>')), '=', ',') + '$' +
//                         FORMAT(LoanGuaranteeDetails."Loan No") + '$' +
//                         ObjLoans."Loan Product Type" + '#';
//                         rec_count := rec_count + 1;
//                     END;
//                 END;
//             UNTIL LoanGuaranteeDetails.NEXT = 0;
//         END;
//     end;

//     procedure ClientCodes(loanNo: Text[20]) codes: Text[20]
//     BEGIN
//         // ObjLoans.RESET;
//         // ObjLoans.SETRANGE("Loan  No.", loanNo);
//         // IF ObjLoans.FIND('-') THEN BEGIN
//         //     codes := ObjLoans."Client Code";
//         // END;
//         exit('');
//     END;

//     procedure ClientNames(ccode: Text[20]) names: Text[150]
//     BEGIN
//         exit('');
//     END;

//     LOCAL procedure GetCharge(amount: Decimal; code: Text[20]) charge: Decimal
//     begin

//     end;

//     procedure PostMPESATransDirect(phone: Text[70]; DocNumber: Text[20]; amount: Decimal) result: Text[30]
//     begin
//         exit('');
//     end;


//     procedure PostMPESATrans(phone: Text[70]; DocNumber: Text[20]; amount: Decimal; withdrawal_ref: Text; mpesa_ref: Code[50]) result: Text[30]
//     begin
//         exit('');
//     end;

//     procedure InsertTransaction("Document No": Code[30]; Keyword: Code[30]; "Account No": Code[30]; "Account Name": Text[150]; Telephone: Code[150]; Amount: Decimal; "Sacco Bal": Decimal) Result: Code[20]
//     begin
//         objCustomer.RESET;
//         objCustomer.SETRANGE("No.", "Account No");
//         IF objCustomer.FindFirst THEN begin
//             PaybillTrans.RESET;
//             PaybillTrans.SETRANGE(PaybillTrans."Document No", "Document No");
//             IF PaybillTrans.FIND('-') THEN BEGIN
//                 Result := 'DUPLICATE';
//                 EXIT(Result);
//             END;

//             IF CFTFactory.FnCheckExists(Keyword) THEN BEGIN
//                 PaybillTrans.INIT;
//                 PaybillTrans."Document No" := "Document No";
//                 PaybillTrans."Key Word" := Keyword;
//                 PaybillTrans."Account No" := "Account No";
//                 PaybillTrans."Account Name" := "Account Name";
//                 PaybillTrans."Transaction Date" := TODAY;
//                 PaybillTrans."Transaction Time" := TIME;
//                 PaybillTrans.Description := 'PayBill Deposit';
//                 PaybillTrans.Telephone := ObjCustomer."Mobile Phone No";
//                 PaybillTrans."Transaction Type" := 'Paybill Trans';
//                 PaybillTrans.Amount := Amount;
//                 PaybillTrans."Paybill Acc Balance" := "Sacco Bal";
//                 PaybillTrans.Posted := FALSE;
//                 PaybillTrans.INSERT;

//                 PaybillTrans.RESET;
//                 PaybillTrans.SETRANGE(PaybillTrans."Document No", "Document No");
//                 IF PaybillTrans.FIND('-') THEN BEGIN
//                     Result := 'TRUE';
//                     EXIT(Result);
//                 END
//                 ELSE BEGIN
//                     Result := 'FALSE';
//                     EXIT(Result);
//                 END;
//             end
//             ELSE begin
//                 Result := 'KEYWORDNOTFOUND';
//                 EXIT(Result);
//             end;
//         end
//         else begin
//             Result := 'NOTFOUND';
//             EXIT(Result);
//         end;
//     end;

//     procedure PaybillSwitch() Result: Text
//     var
//         AccNo: Code[30];
//     begin
//         Result := '';
//         batch := 'PAYBILL';
//         AccNo := '';

//         PaybillTrans.RESET;
//         PaybillTrans.SETRANGE(PaybillTrans.Posted, FALSE);
//         PaybillTrans.SETRANGE(PaybillTrans."Needs Manual Posting", FALSE);
//         IF PaybillTrans.FIND('-') THEN BEGIN
//             BankLedgeracc.RESET;
//             BankLedgeracc.SETRANGE("Document No.", PaybillTrans."Document No");
//             BankLedgeracc.SETRANGE(Reversed, FALSE);
//             IF BankLedgeracc.FIND('-') THEN BEGIN
//                 PaybillTrans.Posted := TRUE;
//                 PaybillTrans."Date Posted" := BankLedgeracc."Posting Date";
//                 PaybillTrans.Description := 'Posted';
//                 PaybillTrans.MODIFY;
//                 Result := 'EXISTS IN LEDGER for ' + PaybillTrans."Document No" + ' Transaction Type ' + FORMAT(PaybillTrans."Transaction Type");
//                 EXIT(Result);
//             END
//             ELSE BEGIN
//                 GlobalTransactionAmount := 0;
//                 InitAmount := PaybillTrans.Amount;
//                 AccNo := PaybillTrans."Account No";
//                 GlobalTransactionAmount := PaybillTrans.Amount;
//                 CFTFactory.FnHandleBatch('GENERAL', batch, 'Paybill Deposit', GenJournalLine, 'CREATE');

//                 IF CFTFactory.FnCheckExists(PaybillTrans."Key Word") THEN BEGIN
//                     CASE PaybillTrans."Key Word" OF
//                         'EDU', 'FIX', 'HOL', 'JUN':
//                             Result := PayBillToAcc(PaybillTrans);
//                         'DEP', 'SHA':
//                             Result := PayBillToBOSA(PaybillTrans);
//                         ELSE
//                             Result := PayBillToLoan(PaybillTrans, GetLoanProductCode(PaybillTrans."Key Word"));
//                     END;


//                     IF ((Result = 'TRUE') AND (GlobalTransactionAmount = 0)) THEN BEGIN
//                         CFTFactory.FnHandleBatch('GENERAL', batch, 'Paybill Deposit', GenJournalLine, 'POST');
//                         PaybillTrans.Amount := InitAmount;
//                         PaybillTrans.Posted := TRUE;
//                         PaybillTrans."Date Posted" := PaybillTrans."Transaction Date";
//                         PaybillTrans.Description := 'Posted';
//                         PaybillTrans.MODIFY;
//                         Result := 'TRUE';

//                         //BOSA SMS
//                         CASE PaybillTrans."Key Word" OF
//                             'EDU', 'FIX', 'HOL', 'JUN':
//                                 begin
//                                     objCustomer.GET(PaybillTrans."Account No");
//                                     msg := 'Dear ' + MemberFosaAccountName(AccNo) + ' your acc ' + AccNo + ' has been credited with Ksh. ' + FORMAT(InitAmount) + ' Thank you for using Our Mobile Banking Service.';
//                                     CFTFACTORY.fnsendmessage('PAYBILLTRANS', objCustomer."Mobile Phone No", 'CFT Mobile', msg);
//                                 end;
//                             'SHA', 'DEP':
//                                 begin
//                                     objCustomer.GET(PaybillTrans."Account No");
//                                     msg := 'Dear ' + MemberFosaAccountName(AccNo) + ' your acc ' + AccNo + ' has been credited with Ksh. ' + FORMAT(InitAmount) + ' Thank you for using Our Mobile Banking Service.';
//                                     CFTFACTORY.fnsendmessage('PAYBILLTRANS', objCustomer."Mobile Phone No", 'CFT Mobile', msg);
//                                 end;
//                             ELSE begin
//                                 if (GetLoanProductCode(PaybillTrans."Key Word") <> '') then begin
//                                     msg := 'Dear ' + MemberFosaAccountName(AccNo) + ', your ' + GetLoanProductCode(PaybillTrans."Key Word") + ' Loan has been credited with Ksh. ' + FORMAT(InitAmount) + '. Thank you for using Our Mobile Banking Service.';
//                                     CFTFACTORY.fnsendmessage('PAYBILLTRANS', objCustomer."Mobile Phone No", 'CFT Mobile', msg);
//                                 end;

//                             end;

//                         END;
//                         EXIT(Result);
//                     END;

//                 END;

//                 IF ((Result = '') OR (GlobalTransactionAmount <> 0)) THEN BEGIN
//                     PaybillTrans.Amount := InitAmount;
//                     PaybillTrans."Date Posted" := TODAY;
//                     PaybillTrans."Needs Manual Posting" := TRUE;
//                     PaybillTrans.Description := 'Failed';
//                     PaybillTrans.MODIFY();
//                     msg := 'Dear ' + PaybillTrans."Account Name" + ' Deposit of Ksh.' + FORMAT(InitAmount) + ' will be credited to account ' + PaybillTrans."Key Word" + '' + PaybillTrans."Account No" +
//                     ' Note that Short Codes have been updated,please contact us for more information.Thank you.';

//                     objCustomer.Reset();
//                     objCustomer.SetRange("No.", PaybillTrans."Account No");
//                     If ObjCustomer.Find('-') then begin
//                         CFTFactory.fnsendmessage('PAYBILLTRANS', objCustomer."Mobile Phone No", 'MOBILETRAN', msg);
//                     end;
//                 END;
//                 Result := Result + ' for ' + PaybillTrans."Document No";
//                 EXIT(Result + PaybillTrans."Document No");
//             END;
//         END;
//         EXIT('NO ACTION');

//     end;


//     Local procedure FnGetVendorAccount(MembNo: Code[50]; Keyw: Code[50]) accNo: Code[50]
//     begin
//         exit('');


//     end;

//     procedure GetLoanProductCode(ProductPaybillCode: Code[20]) ProductCode: Code[50]
//     begin
//         ObjLoanProducts.RESET;
//         ObjLoanProducts.SETRANGE(Paybill_Code, ProductPaybillCode);
//         IF ObjLoanProducts.FIND('-') THEN BEGIN
//             ProductCode := ObjLoanProducts."Code";
//         END
//     end;

//     LOCAL procedure PayBillToLoan(RecPaybill: Record "CFT Mobile Paybill Trans"; ProductCode: Code[20]) res: Code[10]
//     var
//         principle_paid: Decimal;
//     begin
//         amount_paid := 0;
//         DocNumber := RecPaybill."Document No";
//         accNo := RecPaybill."Account No";
//         Amount := RecPaybill.Amount;
//         batch := 'PAYBILL';
//         res := '';

//         objCustomer.Reset();
//         objCustomer.SETRANGE("No.", RecPaybill."Account No");
//         if objCustomer.find('-') then
//             bosa_no := objCustomer."No.";

//         IF bosa_no = '' THEN BEGIN
//             res := '';
//             EXIT(res);
//         END;
//         objGeneralSetup.reset();
//         objGeneralSetup.get;

//         PaybillRecon := objGeneralSetup.PaybillAcc;

//         ObjLoans.Reset();
//         ObjLoans.SETRANGE("Loan Product Type", ProductCode);
//         ObjLoans.SETRANGE("Client Code", RecPaybill."Account No");
//         //ObjLoans.SETRANGE("Loan Status", ObjLoans."Loan Status"::"Being Repaid");
//         ObjLoans.CALCFIELDS("Outstanding Balance", "Outstanding Interest");
//         ObjLoans.SETFILTER(ObjLoans."Outstanding Balance", '>%1', 0);

//         IF ObjLoans.FIND('-') THEN BEGIN
//             ObjLoans.CALCFIELDS("Outstanding Balance", "Outstanding Interest");
//             IF ObjLoans."Outstanding Balance" > 0 THEN BEGIN
//                 LineNo := 1000;
//                 CFTFactory.FnGenerateGeneralJournalLine('GENERAL', batch, LineNo, '', RecPaybill."Transaction Date", DocNumber, RecPaybill."Document No", GenJournalLine."Account Type"::"Bank Account", PaybillRecon, Amount,
//                     'Paybill Loan Repayment' + RecPaybill."Account Name", GenJournalLine."Transaction Type"::" ", '', 'BOSA', '', '', '', '');

//                 if ObjLoans."Outstanding Interest" > 0 then begin
//                     LineNo := LineNo + 1000;
//                     amount_paid := 0;
//                     if Amount > ObjLoans."Outstanding Interest" then
//                         amount_paid := ObjLoans."Outstanding Interest"
//                     else
//                         amount_paid := Amount;

//                     CFTFactory.FnGenerateGeneralJournalLine('GENERAL', batch, LineNo, '', RecPaybill."Transaction Date", DocNumber, RecPaybill."Document No", GenJournalLine."Account Type"::Customer, ObjLoans."Client Code", amount_paid * -1,
//                 'Loan Interest Payment', GenJournalLine."Transaction Type"::"Interest Paid", ObjLoans."Loan  No.", 'BOSA', '', '', '', '');
//                     GlobalTransactionAmount := GlobalTransactionAmount - amount_paid;
//                     Amount := Amount - amount_paid;
//                 end;

//                 if Amount > 0 then begin
//                     LineNo := LineNo + 1000;
//                     principle_paid := 0;
//                     if Amount > ObjLoans."Outstanding Balance" then
//                         principle_paid := ObjLoans."Outstanding Balance"
//                     else
//                         principle_paid := Amount;
//                     CFTFactory.FnGenerateGeneralJournalLine('GENERAL', batch, LineNo, '', RecPaybill."Transaction Date", DocNumber, RecPaybill."Document No", GenJournalLine."Account Type"::Customer, ObjLoans."Client Code", principle_paid * -1,
//                 'Loan Principal Repayment', GenJournalLine."Transaction Type"::"Loan Repayment", ObjLoans."Loan  No.", 'BOSA', '', '', '', '');
//                     GlobalTransactionAmount := GlobalTransactionAmount - principle_paid;
//                     Amount := Amount - principle_paid;
//                 end;

//                 if Amount > 0 then begin
//                     LineNo := LineNo + 1000;

//                     CFTFactory.FnGenerateGeneralJournalLine('GENERAL', batch, LineNo, '', RecPaybill."Transaction Date", DocNumber, DocNumber, GenJournalLine."Account Type"::Customer, RecPaybill."Account No", Amount * -1,
//                 'Paybill -' + RecPaybill."Document No", GenJournalLine."Transaction Type"::"Deposit Contribution", '', 'BOSA', '', '', '', '');
//                     GlobalTransactionAmount := GlobalTransactionAmount - Amount;
//                 end;
//             end;
//             res := 'TRUE';
//         end;

//     end;

//     LOCAL procedure PayBillToAllDeductions(RecPaybill: Record "CFT Mobile Paybill Trans") res: Code[10]
//     var
//         DepositAmount: Decimal;
//     begin
//         exit('');
//     end;

//     Local procedure FnMinimunDepositContribution(MemberNo: Code[20]): Decimal
//     var
//         MonthyContribution: Decimal;
//         Monthycontributionbal: Decimal;
//         DepostBanding: Decimal;

//     begin
//         EXIT(Monthycontributionbal);
//     end;

//     LOCAL procedure PayBillToAcc(RecPaybill: Record "CFT Mobile Paybill Trans") result: Code[20]
//     var
//         AccountType: Code[50];
//     begin
//         exit('');
//     end;

//     procedure PayBillToBOSA(RecPaybill: Record "CFT Mobile Paybill Trans") res: Code[10]
//     var
//         DocNumber: code[20];
//         bosa_no: code[20];

//     begin
//         res := '';
//         DocNumber := RecPaybill."Document No";
//         accNo := RecPaybill."Account No";
//         Amount := RecPaybill.Amount;
//         batch := 'PAYBILL';
//         res := '';
//         objGeneralSetup.Reset();
//         objGeneralSetup.get();


//         PaybillRecon := objGeneralSetup.PaybillAcc;

//         objCustomer.reset();
//         objCustomer.SETRANGE("No.", RecPaybill."Account No");
//         if objCustomer.Find('-') then
//             bosa_no := objCustomer."No.";

//         IF bosa_no = '' THEN BEGIN
//             res := '';
//             EXIT(res);
//         END;

//         //1. DEBIT MPESA PAYBILL BANK with the paid Amount
//         LineNo := 5000;
//         CFTFactory.FnGenerateGeneralJournalLine('GENERAL', batch, LineNo, '', RecPaybill."Transaction Date", DocNumber, DocNumber, GenJournalLine."Account Type"::"Bank Account", PaybillRecon, Amount,
//             'Paybill -' + RecPaybill."Account Name", GenJournalLine."Transaction Type"::" ", '', 'BOSA', '', '', '', '');

//         //2. CREDIT MEMBER WITH paid amount
//         LineNo := LineNo + 1000;
//         CASE RecPaybill."Key Word" OF
//             'DEP':
//                 GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Deposit Contribution";
//             'SHA':
//                 GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Share Capital";
//         END;

//         CFTFactory.FnGenerateGeneralJournalLine('GENERAL', batch, LineNo, '', RecPaybill."Transaction Date", DocNumber, DocNumber, GenJournalLine."Account Type"::Customer, RecPaybill."Account No", Amount * -1,
//             'Paybill -' + RecPaybill."Account Name", GenJournalLine."Transaction Type", '', 'BOSA', '', '', '', '');
//         GlobalTransactionAmount := GlobalTransactionAmount - Amount;
//         res := 'TRUE';

//     end;

//     procedure PayBillToAccBOSA(RecPaybill: Record "CFT Mobile Paybill Trans") result: Code[10]

//     begin
//         // result := '';
//         // DocNumber := RecPaybill."Document No";
//         // accNo := RecPaybill."Account No";
//         // memberNo := RecPaybill."Account No";
//         // Amount := RecPaybill.Amount;
//         // batch := 'PAYBILL';
//         // bosa_no := '';

//         // CFTMobileTransactions.RESET;
//         // CFTMobileTransactions.SETRANGE(CFTMobileTransactions."Document No", DocNumber);
//         // IF CFTMobileTransactions.FIND('-') THEN BEGIN
//         //     result := 'TRANS EXIST';
//         //     EXIT(result);
//         // END;

//         // objCustomer.reset();
//         // objCustomer.SetRange("No.", memberNo);
//         // IF objCustomer.FIND('-') THEN
//         //     bosa_no := objCustomer."No.";

//         // IF bosa_no = '' THEN BEGIN
//         //     result := 'NO BOSA';
//         //     EXIT(result);
//         // END;

//         // objGeneralSetup.Reset();
//         // objGeneralSetup.get();

//         // PaybillRecon := objGeneralSetup.PaybillAcc;

//         // IF accNo = '' THEN BEGIN
//         //     result := 'NO ACCNO';
//         //     EXIT(result);
//         // END;

//         // //1. CREDIT FOSA ACCOUNT with the paid Amount
//         // LineNo := 1000;
//         // CFTFactory.FnGenerateGeneralJournalLine('GENERAL', batch, LineNo, '', RecPaybill."Transaction Date", DocNumber, DocNumber, GenJournalLine."Account Type"::Customer, accNo, Amount * -1,
//         //     'Paybill -' + RecPaybill."Account Name", GenJournalLine."Transaction Type"::" ", DocNumber, 'BOSA', '', '', '', GetSavingsProductCode(RecPaybill."Key Word"));
//         // GlobalTransactionAmount := GlobalTransactionAmount - Amount;

//         // //2. DEBIT MPESA PAYBILL BANK with the paid Amount
//         // LineNo := LineNo + 1000;
//         // CFTFactory.FnGenerateGeneralJournalLine('GENERAL', batch, LineNo, '', RecPaybill."Transaction Date", DocNumber, DocNumber, GenJournalLine."Account Type"::"Bank Account", PaybillRecon, Amount,
//         //     'Paybill -' + RecPaybill."Account Name", GenJournalLine."Transaction Type"::" ", DocNumber, 'BOSA', '', '', '', '');
//         // result := 'TRUE';

//         exit('');
//     end;

//     procedure Loancalculator(Loansetup: Text[1024]) calcdetails: Code[1024]
//     begin
//         exit('');
//     end;

//     procedure CommisionEarned() AccBal: Text[1024]
//     begin
//         exit('');
//     end;

//     procedure OutstandingLoansUSSD(phone: Code[20]) loanbalances: Text[1024]
//     begin
//         exit('');
//     end;

//     procedure getMembernames(memberno: Code[30]) name: Text[1024]
//     begin
//         exit('');
//     end;

//     procedure PollPendingSMS() MessageDetails: Text[500]
//     begin
//         exit('');
//     end;

//     procedure ConfirmSent(TelephoneNo: Text[20]; Status: Integer) result: Text[1024]
//     begin
//         exit('');
//     end;

//     procedure FnNotifications(phone: Code[20]) notifications: Text[9000]
//     begin
//         SMSMessages.reset();
//         SMSMessages.SetFilter("Telephone No", '%1|%2|%3', phone, '254' + phone, '+254' + phone);
//         SMSMessages.SETCURRENTKEY("Entry No");
//         SMSMessages.ASCENDING(FALSE);
//         count := 0;
//         notifications := '';

//         if SMSMessages.find('-') then begin
//             repeat
//                 notifications := notifications + FORMAT(SMSMessages."Date Entered") + '$' +
//                                                 FORMAT(SMSMessages."Time Entered") + '$' +
//                                                 SMSMessages."SMS Message" + '#';
//                 count := count + 1;

//                 if count > 10 then
//                     exit(notifications);
//             until SMSMessages.next() = 0;
//         end;
//         EXIT(notifications);
//     end;

//     Local procedure FnIsMicro(MembNo: Code[50]): Boolean
//     begin
//         exit(false);
//     end;

//     procedure FnMobileLoanAppraisal(Phone: Code[13]): Decimal
//     var
//         QualifiedAmount: Decimal;
//         bosa_no: Code[100];
//     begin
//         QualifiedAmount := 0;
//         bosa_no := BOSAAccount(Phone);

//         objCustomer.RESET;
//         objCustomer.SETRANGE("No.", bosa_no);
//         IF objCustomer.FINDLAST THEN BEGIN
//             QualifiedAmount := CFTFactory.FnMobileLoanAppraisal(bosa_no);
//         END;
//         EXIT(QualifiedAmount);
//     end;

//     procedure FnUpdateFailedWithdrawals(cft_ref: Code[20]) txt: Text
//     begin
//         exit('');
//     end;

//     procedure FnMemberReg(title: Text; surname: Text; firstName: Text; lastName: Text; sex: Option; email: Text; primaryPhone: Text; secondaryPhone: Text; IDNo: Code[10]; kraPin: Text; memberClass: Option; DOB: Date; employer: Text; payrollNumber: Code[10]; department: Text; employmentTerm: option; monthlyContribution: Decimal; postalBox: code[10]; postalCode: code[10]; postalTown: Text; residenceCounty: Text; residenceTown: Text; residenceEstate: Text; houseNumber: Text; nearestInstitution: Text; declarationDate: date; recruiterMemberNo: code[10]; recruiterName: Text; recruitedDate: date) memberNo: code[30]
//     begin
//         exit('');
//     end;

//     procedure FnRegisterKin(AccountNo: Code[10]; surname: Text; relationship: Option; sex: Option; email: Text; primaryPhone: Code[10]; secondaryPhone: Code[10]; IDNo: Code[10]; location: Text; nameOfChief: Text; subLocation: Text; nameOfAssistantChief: Text; firstName: Text; lastName: Text; allocation: decimal; kinType: Integer) saved: Boolean
//     begin
//         saved := FALSE;
//         EXIT(saved);
//     end;

//     procedure FnGetCheckoffline(PhoneNo: Code[10]) Return: Text
//     begin
//         Counter := 1;
//     end;

//     procedure FnVASFloatBalance() result: Text[30]
//     begin
//         exit('');
//     end;

//     procedure FnLogMobileLoan(Phone: Code[13]; LoanAmount: Decimal; cft_reference: Code[20]; repayment_period: Integer) Res: Code[150]
//     var
//         AppraisedAmount: Decimal;
//         msg: Text;
//         bosa_no: Code[100];
//     begin
//         if LoanAmount < 1000 THEN EXIT('FALSE');

//         ObjLoans.Reset();
//         ObjLoans.setrange("CFT Reference No", cft_reference);
//         if ObjLoans.Find('-') THEN EXIT('FALSE');

//         AppraisedAmount := FnMobileLoanAppraisal(Phone);
//         if AppraisedAmount < 1 THEN EXIT('FALSE');

//         IF LoanAmount >= AppraisedAmount then
//             LoanAmount := AppraisedAmount;

//         Res := 'FALSE';

//         bosa_no := BOSAAccount(Phone);
//         IF bosa_no = '' THEN EXIT(Res);

//         Res := CFTFactory.FnLogMobileLoan(bosa_no, LoanAmount, cft_reference, repayment_period);
//         EXIT(Res);
//     end;

//     procedure ProcessMobileLoan() Processed: Text
//     var
//         ObjLastLoan: Record "Loans Register";
//         ObjLoanWithBalance: Record "Loans Register";
//     begin
//         Processed := 'NO ACTION';
//         ObjLastLoan.RESET;
//         ObjLastLoan.SETRANGE("Loan Product Type", 'RUAIMOBI');
//         ObjLastLoan.SETRANGE(Posted, FALSE);
//         ObjLastLoan.SETRANGE("Failed Mobile Loan Request", FALSE);
//         ObjLastLoan.SETFILTER("Application Date", '>%1', 20250911D);
//         IF ObjLastLoan.FINDLAST THEN BEGIN
//             ObjLoanWithBalance.RESET;
//             ObjLoanWithBalance.SETRANGE("Client Code", ObjLastLoan."Client Code");
//             ObjLoanWithBalance.SETRANGE("Loan Product Type", 'RUAIMOBI');
//             IF ObjLoanWithBalance.FIND('-') THEN BEGIN
//                 REPEAT
//                     ObjLoanWithBalance.CALCFIELDS("Outstanding Balance", "Outstanding Interest");
//                     IF ((ObjLoanWithBalance."Outstanding Balance" > 0) OR (ObjLoanWithBalance."Outstanding Interest" > 0))
//                     THEN BEGIN
//                         ERROR('ERROR while Posting Mobile Loan for ' + ObjLoanWithBalance."Client Code" + ' because ' + ObjLastLoan."Client Name"
//                         + ' has another uncleared Mobile Loan. ' + ObjLoanWithBalance."Loan  No.");
//                     END;
//                 UNTIL ObjLoanWithBalance.NEXT = 0;
//                 Processed := CFTFactory.FnProcessMobileLoan(ObjLastLoan) + ':' + ObjLastLoan."Loan  No." + ':' + ObjLastLoan."CFT Reference No" + ':for ' + ObjLastLoan."Client Name";
//             END;
//             EXIT(Processed);
//         END;

//     end;

//     // Additional functions
//     procedure ConfirmBOSAAccount(memberNo: Code[30]) result: Code[20];

//     begin
//         result := ':::';
//         EXIT(result);
//     end;

//     procedure FnGetKinRelationships() result: Code[20];
//     begin
//         result := '#';
//         EXIT(result);
//     end;

//     procedure FnMemberDeatils(phoneNo: Code[30]) result: Code[20];
//     begin
//         result := ':::';
//         EXIT(result);
//     end;

//     procedure FnSpeciLoantrans(loanNo: Code[30]; phoneNo: Code[30]) result: Code[20];
//     begin
//         result := ':::';
//         EXIT(result);
//     end;

//     procedure FnGetLoandefaulters() result: Code[20];
//     begin
//         result := ':::';
//         EXIT(result);
//     end;

//     procedure FnProductMiniStat(phoneNo: Text[70]; cftReference: Text[20]; IsChargeable: Boolean; product: Code[50]; dateFilter: Code[30]): Text
//     var
//         MiniStmt: Text;
//         msg: Text;
//         minimumCount: Integer;
//         bosa_no: Text[20];
//         fosa_no: Text[20];
//         amount: Decimal;
//         stmtDescription: Text;
//         DetailedVendorLedgerEntry: Record "Detailed Vendor Ledg. Entry";
//         VendorLedgerEntry: Record "Vendor Ledger Entry";
//     begin
//         EXIT('');
//     end;

//     procedure FnCheckingGuaranor(phoneNo: Code[30]; loanNo: Integer) result: Boolean;
//     begin
//         result := false;
//         EXIT(result);
//     end;

//     procedure FnGetSubmittedLoans(phoneNo: Code[30]; loanNo: Integer) result: Boolean;
//     begin
//         result := false;
//         EXIT(result);
//     end;

//     procedure FnCheckMemberExixtance(phoneNo: Code[30]) result: Code[20];
//     begin
//         result := 'FALSE';
//         EXIT(result);
//     end;

//     procedure FnSelfActivate(phoneNo: Code[30]; IDNumber: Code[30]) result: Code[20];
//     begin
//         result := 'FALSE';
//         EXIT(result);
//     end;

//     procedure Fnmyloanrequests(phoneNo: Code[30]) result: Code[20];
//     begin
//         result := '#';
//         EXIT(result);
//     end;

//     procedure LoansGuaranteedRequest(phoneNo: Code[30]) result: Code[20];
//     begin
//         result := '#';
//         EXIT(result);
//     end;

//     procedure LoanGuarantorsTwo(loanNo: Code[30]) result: Code[20];
//     begin
//         result := ':::';
//         EXIT(result);
//     end;

//     procedure FundsTransferBOSAWithType(phoneNo: Code[30]; accTo: Code[30]; cftReference: Code[30]; amount: Decimal; loanNo: Code[30]; FOSAAccountType: Code[50]) result: Code[20];
//     begin
//         result := '';
//         EXIT(result);
//     end;

//     procedure ConfirmGuarantorshipRequest(loanNo: Code[30]; guarantorNo: Code[30]; phoneNo: Code[30]; guarantorStatus: Integer; cftReference: Code[30]) result: Code[20];
//     begin
//         result := 'FALSE';
//         EXIT(result);
//     end;

//     procedure FnGuarantorshipqualification(phoneNo: Code[30]) result: Code[20];
//     begin
//         result := '0';
//         EXIT(result);
//     end;

//     procedure FnUpdateKinInformation(entryNo: Integer; member_No: Code[30]; fullName: Code[30]; relationship: Code[30]; emailAddress: Code[30]; phoneNo: Code[30]; iDNumber: Code[30]; address: Code[30]; kinType: Integer; guardianName: Code[30]; guardianPhoneNo: Code[30]; allocation: Decimal; status: Integer; guardianEmail: Code[30]; guardianAddress: Code[30]; guardianRelationship: Code[30]; guardianID: Code[30]; guardianKRAPin: Code[30]; guardianAltPhoneNo: Code[30]; kinphone: Code[30]) result: Code[20];
//     begin
//         result := 'FALSE';
//         EXIT(result);
//     end;

//     procedure FnCheckPendingapp(phoneNo: Code[30]) result: Code[20];
//     begin
//         result := 'FALSE';
//         EXIT(result);
//     end;

//     procedure FncheckloanGuarantorship(phoneNo: Code[30]; loanNo: Integer) result: Code[20];
//     begin
//         result := 'FALSE';
//         EXIT(result);
//     end;

//     procedure PortalOnlineLoanApplication(phoneNo: Code[30]; loanType: Code[30]; appliedAmount: Decimal; RepaymentPeriod: Decimal; basicPay: Decimal; allowance: Decimal; deductions: Decimal; loanPurpose: Code[100]; grossPay: Decimal; disbursementMode: Code[50]; sector: Code[50]) result: Code[20];
//     begin
//         result := 'FALSE';
//         EXIT(result);
//     end;

//     procedure FnEditappliedloans(LoanapplicationNo: Integer; loanType: Code[30]; appliedamount: Decimal; RepaymentPeriod: Decimal; basicPay: Decimal; allowance: Decimal; deductions: Decimal; loanpurpose: Code[30]; grosspay: Decimal) result: Code[20];
//     begin
//         result := 'FALSE';
//         EXIT(result);
//     end;

//     procedure FnDeleteGuarantor(loanNo: Integer; phoneNo: Code[30]) result: Code[20];
//     begin
//         result := 'FALSE';
//         EXIT(result);
//     end;

//     procedure FnDeleteLoan(loanNo: Integer) result: Code[20];
//     begin
//         result := 'FALSE';
//         EXIT(result);
//     end;

//     procedure PortalRequestGuarantorship(phoneNo: Code[30]; loanNo: Integer; Amount: Decimal) result: Code[20];
//     begin
//         result := 'FALSE';
//         EXIT(result);
//     end;

//     procedure ApproveLoan(phoneNo: Code[30]; loanNo: Integer) result: Code[20];
//     begin
//         result := 'FALSE';
//         EXIT(result);
//     end;

//     procedure RejectGuaranteeLoan(loanNo: Integer; phoneNo: Code[30]) result: Code[20];
//     begin
//         result := 'FALSE';
//         EXIT(result);
//     end;

//     procedure PortListAppliedLoans(phoneNo: Code[30]) result: Code[20];
//     begin
//         result := ':::';
//         EXIT(result);
//     end;

//     procedure PortListAppliedLoansothers(phoneNo: Code[30]) result: Code[20];
//     begin
//         result := ':::';
//         EXIT(result);
//     end;

//     procedure PortalgetAppliedloandetails(loanNo: Integer) result: Code[20];
//     begin
//         result := ':::';
//         EXIT(result);
//     end;

//     procedure AppliedLoanGuarantorsList(loanNo: Integer) result: Code[20];
//     begin
//         result := ':::';
//         EXIT(result);
//     end;

//     procedure PortalGuarantorshipRequest(phoneNo: Code[30]) result: Code[20];
//     begin
//         result := ':::';
//         EXIT(result);
//     end;

//     procedure PortalSubmitLoan(phoneNo: Code[30]; loanNo: Integer) result: Code[20];
//     begin
//         result := 'FALSE';
//         EXIT(result);
//     end;

//     procedure FnOnlineLoanTopUp(loanNo: Integer; apploanNo: Code[30]; loanAmount: Decimal; phoneNo: Code[30]) result: Code[20];
//     begin
//         result := 'FALSE';
//         EXIT(result);
//     end;

//     procedure FnOnlineLoanTopUpList(phoneNo: Code[30]) result: Code[20];
//     begin
//         result := ':::';
//         EXIT(result);
//     end;

//     procedure FnLoanPurpose() result: Code[20];
//     begin
//         result := ':::';
//         EXIT(result);
//     end;

//     procedure FnSubsector(fnCode: Code[30]) result: Code[20];
//     begin
//         result := ':::';
//         EXIT(result);
//     end;

//     procedure FnSpecificSector(fnCode: Code[30]) result: Code[20];
//     begin
//         result := ':::';
//         EXIT(result);
//     end;

//     procedure PortalgetmemberDetails(phoneNo: Code[30]) result: Text;
//     var
//         bosa_no: Code[50];
//     begin
//         bosa_no := BOSAAccount(phoneNo);
//         objCustomer.RESET;
//         objCustomer.SETRANGE(objCustomer."No.", bosa_no);
//         IF objCustomer.FIND('-') THEN BEGIN
//             result := objCustomer.Name + ':::' + objCustomer."Mobile Phone No" + ':::' + objCustomer."No." + ':::' + objCustomer."E-Mail" + ':::' + objCustomer."E-Mail" + ':::' + objCustomer."ID No." +
//             ':::' + objCustomer."Bank Code" + ':::' + objCustomer."Bank Branch" + ':::' + objCustomer."Bank Account No." + ':::' + objCustomer.Pin;
//         END;
//         EXIT(result);
//     end;

//     procedure FnCRMMembers(phoneNo: Code[30]; description: Code[100]; reasonForCalling: Integer) result: Code[20];
//     begin
//         result := ':::';
//         EXIT(result);
//     end;

//     procedure FnListCRMember(phoneNo: Code[30]) result: Code[20];
//     begin
//         result := ':::';
//         EXIT(result);
//     end;

//     procedure FnGetCheckoffIndividual(memberNo: Code[30]; checkoffNo: Code[30]) result: Code[20];
//     begin
//         result := ':::';
//         EXIT(result);
//     end;

//     procedure FnGetCheckoffAdvice(phoneNo: Code[30]) result: Code[20];
//     begin
//         result := ':::';
//         EXIT(result);
//     end;

//     procedure FnGetCheckadvicedetails(memberNo: Code[30]; checkoffNo: Code[30]) result: Code[20];
//     begin
//         result := ':::';
//         EXIT(result);
//     end;

//     procedure FnnMemberReportsStream(phone: Code[30]; bigText: Code[30]; dateFilter: Code[30]; reportCode: Code[30]; accountCode: Code[30]; loanNo: Code[30]) result: Code[20];
//     begin
//         result := ':::';
//         EXIT(result);
//     end;

//     procedure FnMemberReportsStream(phone: Code[50]; bigText: Code[30]; dateFilter: Code[30]; reportCode: Code[30]; accountCode: Code[30]; loanNo: Code[30]): Text
//     var
//         TempBlob: Codeunit "Temp Blob";
//         OutStream: OutStream;
//         InStream: InStream;
//         Base64Convert: Codeunit "Base64 Convert";
//         RecRef: RecordRef;
//         Base64String: Text;
//         CustomerCard: Record "Customer";
//         Guarantors: Record "Loans Guarantee Details";
//         ObjLoans: Record "Loans Register";
//         LoanProduct: Code[20];
//         Params: Text;
//         FromDate, ToDate : Date;
//         FOAccNo: code[50];

//     begin
//         Base64String := '';
//         MemberNo := BOSAAccount(phone);

//         CASE ReportCode OF
//             'MEMBSTMNT':
//                 BEGIN
//                     CustomerCard.Reset();
//                     CustomerCard.SetRange(CustomerCard."No.", MemberNo);

//                     if CustomerCard.Find('-') then begin
//                         TempBlob.CreateOutStream(OutStream);
//                         RecRef.GETTABLE(CustomerCard);

//                         Report.SaveAs(Report::"Member Account Statement-New", '', ReportFormat::Pdf, OutStream, RecRef);
//                         TempBlob.CreateInStream(InStream);
//                         Base64String := Base64Convert.ToBase64(InStream);
//                     end;
//                 END;

//             // 'GUALNS':
//             //     BEGIN
//             //         CustomerCard.Reset();
//             //         CustomerCard.SetRange(CustomerCard."No.", MemberNo);

//             //         if CustomerCard.Find('-') then begin
//             //             TempBlob.CreateOutStream(OutStream);
//             //             RecRef.GETTABLE(CustomerCard);

//             //             Report.SaveAs(Report::"Members_guaranteed", '', ReportFormat::Pdf, OutStream, RecRef);
//             //             TempBlob.CreateInStream(InStream);
//             //             Base64String := Base64Convert.ToBase64(InStream);
//             //         end;
//             //     END;

//             // 'GUAREP':
//             //     BEGIN
//             //         Guarantors.Reset();
//             //         Guarantors.SetRange(Guarantors."Guarantor Number", MemberNo);

//             //         if Guarantors.Find('-') then begin
//             //             TempBlob.CreateOutStream(OutStream);
//             //             RecRef.GETTABLE(Guarantors);

//             //             Report.SaveAs(Report::"Loans Guarantors Report", '', ReportFormat::Pdf, OutStream, RecRef);
//             //             TempBlob.CreateInStream(InStream);
//             //             Base64String := Base64Convert.ToBase64(InStream);
//             //         end;
//             //     END;

//             'DEPSTMNT':
//                 BEGIN
//                     CustomerCard.Reset();
//                     CustomerCard.SetRange("No.", MemberNo);
//                     CustomerCard.SetFilter("Date Filter", dateFilter);

//                     IF CustomerCard.Find('-') THEN BEGIN
//                         TempBlob.CreateOutStream(OutStream);
//                         RecRef.GETTABLE(CustomerCard);

//                         Report.SaveAs(Report::"Members Deposits Statement", '', ReportFormat::Pdf, OutStream, RecRef);
//                         TempBlob.CreateInStream(InStream);
//                         Base64String := Base64Convert.ToBase64(InStream);
//                     END;
//                 END;


//             'LOANSTMNT':
//                 BEGIN
//                     ObjLoans.Reset();
//                     ObjLoans.SetRange(ObjLoans."Loan  No.", loanNo);

//                     if ObjLoans.FIND('-') then begin
//                         LoanProduct := ObjLoans."Loan Product Type";
//                     end;


//                     CustomerCard.Reset();
//                     CustomerCard.SetRange(CustomerCard."No.", MemberNo);
//                     CustomerCard.SetFilter(CustomerCard."Loan Product Filter", LoanProduct);

//                     if CustomerCard.Find('-') then begin
//                         TempBlob.CreateOutStream(OutStream);
//                         RecRef.GETTABLE(CustomerCard);

//                         Report.SaveAs(Report::"Loan Statement", '', ReportFormat::Pdf, OutStream, RecRef);
//                         TempBlob.CreateInStream(InStream);
//                         Base64String := Base64Convert.ToBase64(InStream);
//                     end;
//                 END;

//             ELSE
//                 ERROR('Unsupported Report Code: %1', ReportCode);
//         END;

//         EXIT(Base64String);
//     end;


//     // End of Additional functions

//     TRIGGER OnRun()
//     begin
//         BackOfficeAccounts('706083697');
//     end;




//     var
//         BATCH_TEMPLATE: code[100];
//         BATCH_NAME: code[100];
//         DOCUMENT_NO: code[100];
//         DocNumber: code[20];
//         VASFloatGL: code[20];
//         num: code[10];
//         PaybillRecon: code[30];
//         memberNo: code[20];
//         ExciseGLAcc: code[20];

//         SafaricomGLAcc: code[20];
//         BankAccount: code[20];
//         GLAccount: code[20];
//         AccNo: code[50];
//         AccountNo: code[100];
//         batch: code[20];
//         acc: code[20];
//         DR: code[10];
//         InitKey: code[10];
//         varTranschannel: code[50];
//         MobileChargesAcc: code[50];
//         CFTCommAcc: code[50];
//         bosa_no: code[20];
//         VASCommissionGL: code[20];
//         Counter: integer;
//         iEntryNo: integer;
//         LineNo: Integer;
//         count: Integer;

//         minimunCount: Integer;
//         FreeShares: Decimal;
//         glamount: Decimal;
//         InitAmount: Decimal;
//         amount_paid: Decimal;
//         GlobalTransactionAmount: Decimal;
//         MPESACharge: Decimal;
//         amount: Decimal;
//         TempBalance: Decimal;
//         MobileCharges: Decimal;
//         CFTComm: Decimal;
//         ExiceSacco: Decimal;
//         ExiceBank: Decimal;
//         ATMCharges: Decimal;
//         BankCharges: Decimal;
//         ExciseFee: Decimal;
//         ExcDuty: Decimal;
//         BookBalance: Decimal;
//         accBalance: Decimal;
//         miniBalance: Decimal;
//         msg: Text[1024];
//         AvailableBalance: Decimal;
//         current_balance: Decimal;
//         TestBalance: Decimal;
//         TotalCharges: Decimal;
//         IsChargeable: Boolean;
//         BalanceAvailable: Boolean;
//         Bal: text[500];
//         varLoan: text[1024];
//         ATMMessages: text[250];
//         normalshares: text[1024];
//         sharecapital: text[1024];
//         MiniStmt: text[1000];
//         MPESARecon: text[20];
//         time_processed: Time;

//         GLEntries: Record "G/L Entry";
//         ObjAccounts: Record "G/L Account";
//         CFTMobileApplication: Record "CFTMobile Applications";
//         // LoanGuaranteeDetails: Record "Guarantors Table";
//         LoanGuaranteeDetails: Record "Loans Guarantee Details";
//         GenBatches: Record "Gen. Journal Batch";
//         ObjLoans: Record "Loans Register";
//         GenLedgerSetup: Record "General Ledger Setup";

//         Acct: Record Customer;
//         SMSMessages: Record "SMS Messages";

//         PaybillTrans: Record "CFT Mobile Paybill Trans";
//         objCustomer: Record Customer;

//         BankLedgeracc: Record "Bank Account Ledger Entry";
//         objCustLedgEntry: Record "Detailed Cust. Ledg. Entry";

//         ObjCustomerLedgerEntry: Record "Detailed Vendor Ledg. Entry";

//         objCustLedgEntry2: Record "Cust. Ledger Entry";
//         GenJournalLine: Record "Gen. Journal Line";
//         objDirectGLs: Record "Common Direct Posting GL";
//         ObjLoanProducts: Record "Loan Products Setup";
//         objGeneralSetup: Record "BO General Setup";
//         CFTFactory: Codeunit "CFT Factory";
//         GLPosting: Codeunit "Gen. Jnl.-Post Line";
//         WorkFlowManagement:
//             Codeunit "Workflow Management";
//         BOSendForCancelRequestDes:
//                 Label 'BO Applications Request for Approval is Cancelled';

// }
