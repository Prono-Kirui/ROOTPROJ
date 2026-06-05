report 51019 "Receipt Custom"
{
    ApplicationArea = All;
    Caption = 'Receipt';
    DefaultRenderingLayout = AACC_Report;

    dataset
    {
        dataitem(Payments; Payments)
        {
            RequestFilterFields = "No.";

            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(Post_Code; CompanyInfo."Post Code")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebsite; CompanyInfo."Home Page")
            {
            }
            column(Country; CompanyInfo."Country/Region Code")
            {
            }
            column(No; Payments."No.")
            {
            }
            column(Date; Payments.Date)
            {
            }
            column(Pay_Mode; Payments."Pay Mode")
            {
            }
            column(Cheque_No; Payments."Cheque No")
            {
            }
            column(Received_From; Payments."Received From")
            {
            }
            column(Currency; Payments.Currency)
            {
            }
            column(Amounts; Payments."Receipt Amount")
            {
            }
            column(PaymentNarration; "Payment Narration")
            {
            }
            column(PaymentReleaseDate_Payments; Payments."Payment Release Date")
            {
            }
            column(Amount_Words; NumberText[1])
            {
            }
            dataitem("Payment Lines"; "Payment Lines")
            {
                DataItemLink = No = field("No.");

                column(Description; "Payment Lines".Description)
                {
                }
                column(Amount; "Payment Lines".Amount)
                {
                }
                column(VAT_Amount; "Payment Lines"."VAT Amount")
                {
                }
                column(AccountName_PaymentLines; "Account Name")
                {
                }
                column(AmountLCY_PaymentLines; "Amount (LCY)")
                {
                }
                column(Currency_PaymentLines; Currency)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin

                Paymgt.InitTextVariable();
                Paymgt.FormatNoText(NumberText, "Receipt Amount", Currency);
            end;
        }
    }

    rendering
    {
        layout(Custom)
        {
            LayoutFile = './src/report_layout/ReceiptCustom.rdl';
            Type = RDLC;
        }
        layout(AACC_Report)
        {
            LayoutFile = './src/report_layout/ReceiptCustomAACC.rdl';
            Type = RDLC;
        }
    }

    var
        CompanyInfo: Record "Company Information";
        Paymgt: Codeunit "Payments Management";
        NumberText: array[2] of Text;

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;
}
