report 51010 "Generate Cheque Nos"
{
    ApplicationArea = All;
    Caption = 'Generate Cheque Nos';
    ProcessingOnly = true;
    dataset
    {
        dataitem("Bank Account"; "Bank Account")
        {
            trigger OnAfterGetRecord()
            begin
                BankAccount.Reset();
                BankAccount.SetRange("No.", "Bank Account"."No.");
                if BankAccount.FindFirst() then begin
                    i := 0;
                    repeat
                        i := i + 1;
                        "Cheque Register".Init();
                        "Cheque Register"."Cheque No." := StartingNo;
                        "Cheque Register"."Bank Account No." := BankAccount."No.";
                        "Cheque Register"."Date Generated" := Today;
                        "Cheque Register"."Entry Status" := "Cheque Register"."Entry Status"::Printed;
                        "Cheque Register"."User ID" := UserId;
                        "Cheque Register".Insert();

                        StartingNo := IncStr(StartingNo);
                    until i = NoOfCheques;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('Done');
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                field(StartingNo; StartingNo)
                {
                    ApplicationArea = All;
                    Caption = 'Starting Cheque No.';
                    ToolTip = 'Specifies the value of the Starting Cheque No. field';
                }
                field(NoOfCheques; NoOfCheques)
                {
                    ApplicationArea = All;
                    Caption = 'No of Leaves';
                    ToolTip = 'Specifies the value of the No of Leaves field';
                }
            }
        }
    }
    labels
    {
    }

    var
        BankAccount: Record "Bank Account";
        "Cheque Register": Record "Cheque Register";
        StartingNo: Code[10];
        i: Integer;
        NoOfCheques: Integer;

    trigger OnPreReport()
    begin
        if StartingNo = '' then
            Error('Starting cheque nos must have a value');

        if NoOfCheques = 0 then
            Error('No. of leaves must have a value');
    end;
}
