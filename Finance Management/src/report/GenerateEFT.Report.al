report 51009 "Generate EFT"
{
    ApplicationArea = All;
    Caption = 'Generate EFT';
    ProcessingOnly = true;
    dataset
    {
        dataitem(Payments; Payments)
        {
            dataitem("Payment Lines"; "Payment Lines")
            {
                DataItemLink = No = field("No.");

                trigger OnAfterGetRecord()
                begin
                    if PrintToExcel then
                        MakeExcelDataBody();
                end;
            }

            trigger OnPreDataItem()
            begin
                MakeExcelDataHeader();
            end;

            trigger OnAfterGetRecord()
            begin
                Payments."EFT File Generated" := true;
                Payments.Modify();
            end;

            trigger OnPostDataItem()
            begin
                if PrintToExcel then
                    CreateExcelBook();
            end;
        }
    }
    labels
    {
    }

    var
        CompanyInformation: Record "Company Information";
        ExcelBuffer: Record "Excel Buffer";
        PrintToExcel: Boolean;
        ServerFileName: Text;

    trigger OnInitReport()
    begin
        PrintToExcel := true;
    end;

    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        ExcelBuffer.DeleteAll();
    end;

    procedure CreateExcelBook()
    begin
        //ExcelBuffer.CreateBook(PaymentsManagement.GetEFTName, Format(Payments."No."));
        ExcelBuffer.WriteSheet(Format(Payments."No."),
          CompanyName,
          UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.OpenExcel();
        //ExcelBuffer.GiveUserControl;
        Error('');
    end;

    procedure MakeExcelDataBody()
    begin
        ExcelBuffer.NewRow();
        // ExcelBuffer.AddColumn("Payment Lines".No,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn("Payment Lines"."Account Type",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn("Payment Lines"."Account No",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn("Payment Lines"."Account Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Payment Lines"."Sort Code", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Payment Lines"."Our Account No.", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Payment Lines".Amount, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(Payments."EFT Reference", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
    end;

    procedure MakeExcelDataHeader()
    begin
        // ExcelBuffer.AddColumn("Payment Lines".FIELDCAPTION(No),FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn("Payment Lines".FIELDCAPTION("Account Type"),FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn("Payment Lines".FIELDCAPTION("Account No"),FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn(UpperCase('Beneficiary Name'), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(UpperCase("Payment Lines".FieldCaption("Sort Code")), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(UpperCase('Account No.'), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(UpperCase("Payment Lines".FieldCaption(Amount)), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(UpperCase('Reference'), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
    end;

    procedure SetFileNameSilent(NewFileName: Text)
    begin
        ServerFileName := NewFileName;
    end;
}
