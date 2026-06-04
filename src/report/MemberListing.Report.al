#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings

Report 50600 "Member Listing"
{
    RDLCLayout = './Layouts/Member Listing.rdlc';
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Member Listing';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", Status, "Customer Type";
            column(ReportForNavId_1000000000; 1000000000) { }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address2; Company."Address 2")
            {
            }
            column(Company_PhoneNo; Company."Phone No.")
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(CurrReport_PAGENO; '')
            {
            }
            column(USERID; UserId)
            {
            }
            column(Member_No; Customer."No.")
            {
            }
            column(Member_Name; Customer.Name)
            {
            }
            column(Deposits; Deposits)
            {
            }
            column(Share_Capital; ShareCapital)
            {
            }
            column(Status; Customer.Status)
            {
            }
            column(Total_Deposits_Shares; TotalDepositsShares)
            {
            }
            column(Total_All_Deposits; TotalAllDeposits)
            {
            }
            column(Total_All_Share_Capital; TotalAllShareCapital)
            {
            }
            column(Grand_Total; GrandTotal)
            {
            }
            column(Report_Title; ReportTitle)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Customer.CalcFields("Current Savings", "Shares Retained");
                Deposits := Customer."Current Savings";
                ShareCapital := Customer."Shares Retained";
                TotalDepositsShares := Deposits + ShareCapital;

                // Accumulate totals
                TotalAllDeposits += Deposits;
                TotalAllShareCapital += ShareCapital;
                GrandTotal += TotalDepositsShares;
            end;

            trigger OnPreDataItem()
            begin
                Company.Get();
                Company.CalcFields(Company.Picture);

                // Initialize totals
                TotalAllDeposits := 0;
                TotalAllShareCapital := 0;
                GrandTotal := 0;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                }
            }
        }

        actions
        {
            area(Processing)
            {
            }
        }
    }

    labels
    {
    }

    var
        Company: Record "Company Information";
        Deposits: Decimal;
        ShareCapital: Decimal;
        TotalDepositsShares: Decimal;
        TotalAllDeposits: Decimal;
        TotalAllShareCapital: Decimal;
        GrandTotal: Decimal;
        ReportTitle: Label 'Member Listing Report';
}
