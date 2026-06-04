report 50930 "Process Loan Repayment SMS"
{
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = WHERE(Posted = FILTER(true),
                                      "Outstanding Balance" = FILTER(> 0));
            RequestFilterFields = "Loan  No.";
            column(LoanNo_LoansRegister; "Loans Register"."Loan  No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                FnSendMemberRepaymentDateSMS();
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        if (Date2DMY(Today, 1) <> 10) and (Date2DMY(Today, 1) <> 25) then
            CurrReport.Break();
    end;

    var
        LoanApps: Record "Loans Register";
        CurrentDayofTheMonth: Date;
        ExpectedRepaymentDate: Date;
        days: Integer;
        Cust: Record Customer;
        SFactory: Codeunit "Micropoint Factory";
        DefaultedDays: Integer;
        AmountPayable: Decimal;

    local procedure FnSendMemberRepaymentDateSMS()
    var
        StartDate: Date;
        EndDate: Date;
    begin
        if (Date2DMY(Today, 1) <> 10) and (Date2DMY(Today, 1) <> 25) then
            exit;

        LoanApps.Reset();
        LoanApps.SetRange(LoanApps."Loan  No.", "Loans Register"."Loan  No.");

        if LoanApps.Find('-') then begin
            repeat
                LoanApps.CalcFields("Outstanding Interest");
                AmountPayable := ((LoanApps."Approved Amount") + (LoanApps."Outstanding Interest"));
                CurrentDayofTheMonth := Today;
                ExpectedRepaymentDate := "Loans Register"."Expected Date of Completion";

                // Calculate days between current date and expected repayment date
                StartDate := CurrentDayofTheMonth;
                EndDate := ExpectedRepaymentDate;
                days := EndDate - StartDate;

                DefaultedDays := Today - ExpectedRepaymentDate;

                if days = 7 then begin
                    Cust.Reset();
                    Cust.SetRange(Cust."No.", "Loans Register"."Client Code");
                    if Cust.Find('-') then begin
                        SFactory.FnSendSMS('LOAN REMIMDER', 'Dear ' + LoanApps."Client Name" + ' You are reminded that your mobile loan of Kshs ' + Format(AmountPayable)
                          + ' repayment is due on ' + Format("Loans Register"."Expected Date of Completion") +
                          ' .For any queries call 0717929424.', Cust."No.", '075720994');
                    end;
                end else
                    if ExpectedRepaymentDate = Today then begin
                        Cust.Reset();
                        Cust.SetRange(Cust."No.", "Loans Register"."Client Code");
                        if Cust.Find('-') then begin
                            SFactory.FnSendSMS('LOAN REMIMDER', 'Dear ' + LoanApps."Client Name" + ' You are reminded that your mobile loan of Kshs ' + Format(AmountPayable)
                               + ' repayment is due today. For any queries call 0717929424.', Cust."No.", '075720994');
                        end;
                    end else
                        if DefaultedDays > 0 then begin
                            SFactory.FnSendSMS('LOAN REMIMDER', 'Dear ' + LoanApps."Client Name" + ' You are reminded to pay your mobile loan of Kshs ' + Format(AmountPayable)
                              + ' which has since fallen overdue ', Cust."No.", '075720994');
                        end;
            until LoanApps.Next() = 0;
        end;
    end;
}

