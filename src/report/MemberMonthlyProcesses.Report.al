#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50967 "Member Monthly Processes"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Members Register"; Customer)
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if WorkDate = CalcDate('CM', WorkDate) then //=======IF WORKDATE = LAST DAY OF THE MONTH
                  begin
                    SFactory.FnRunCreateDepositTransferJournalsMonthly("Deposits Account No", "No.");
                    SFactory.FnRunGetDepositArrearsPenalty("No.");
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

    var
        SFactory: Codeunit "Micropoint Factory";
}

