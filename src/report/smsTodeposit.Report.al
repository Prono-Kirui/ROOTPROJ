report 50033 "sms To deposit"
{
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = WHERE(Status = FILTER(Active));
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                if (Date2DMY(Today, 1) = 22) or (Date2DMY(Today, 1) = 25) then begin
                    if Customer."Phone No." = '' then
                        exit;

                    // Testing with hardcoded number
                    MicropointFactory.FnSendSMS('DEPOSIT REMINDER', Text002, Customer."No.", '0757260994');
                    SMSCount += 1;
                end;
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

    trigger OnPreReport()
    begin
        // Only run on the 10th or 25th day of the month
        if (Date2DMY(Today, 1) <> 22) and (Date2DMY(Today, 1) <> 25) then
            CurrReport.Break();

        SMSCount := 0;
    end;

    trigger OnPostReport()
    begin
        Message('%1 SMS message(s) sent successfully.', SMSCount);
    end;

    var
        MicropointFactory: Codeunit "Micropoint Factory";
        SMSCount: Integer;
        //Text001: Label ' ,Monthly contribution reminder. Pay via *670#, App,Co-op. Bank A/c 01120283044100 or Paybill 513802. Use your name/membership no.';
        // VarDate: Date;
        // Varmonthry: Text;
        Text002: Label 'Dear Member, this is a kind reminder to make your monthly savings deposit with Ruai Endelea Sacco. Stay consistent, grow your savings, and secure your future today!';
}

