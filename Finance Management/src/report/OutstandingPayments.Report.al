report 51017 "Outstanding Payments"
{
    ApplicationArea = All;
    Caption = 'Outstanding Payments';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/OutstandingPayments.rdlc';
    dataset
    {
        dataitem(Payments; Payments)
        {
            DataItemTableView = where(Posted = const(true), Surrendered = const(false));
            RequestFilterFields = "Payment Type";

            column(No_Payments; Payments."No.")
            {
            }
            column(Date_Payments; Payments.Date)
            {
            }
            column(PayMode_Payments; Payments."Pay Mode")
            {
            }
            column(ChequeNo_Payments; Payments."Cheque No")
            {
            }
            column(ChequeDate_Payments; Payments."Cheque Date")
            {
            }
            column(Payee_Payments; Payments.Payee)
            {
            }
            column(AccountNo_Payments; Payments."Account No.")
            {
            }
            column(AccountName_Payments; Payments."Account Name")
            {
            }
            column(ImprestAmount_Payments; Payments."Imprest Amount")
            {
            }
            column(StaffNo_Payments; Payments."Staff No.")
            {
            }
            column(DateofProject_Payments; Payments."Date of Project")
            {
            }
            column(DateofCompletion_Payments; Payments."Date of Completion")
            {
            }
            column(DueDate_Payments; Payments."Due Date")
            {
            }
            column(NoofDays_Payments; Payments."No of Days")
            {
            }
            column(Destination_Payments; Payments.Destination)
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyFax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebsite; CompanyInfo."Home Page")
            {
            }
            column(AsAt; AsAt)
            {
            }

            trigger OnPreDataItem()
            begin
                //Payments.SETFILTER("Due Date",'<=%1',AsAt);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                field(AsAt; AsAt)
                {
                    ApplicationArea = All;
                    Caption = 'Due As At';
                    ToolTip = 'Specifies the value of the Due As At field';
                }
            }
        }
    }
    labels
    {
    }

    var
        CompanyInfo: Record "Company Information";
        AsAt: Date;

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);

        if AsAt = 0D then
            AsAt := Today;
    end;
}
