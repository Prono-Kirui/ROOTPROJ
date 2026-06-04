#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings


Report 50464 "Post Monthly Interest"
{
    RDLCLayout = './Layouts/Process Monthly Interest.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = where(Posted = const(true), "Loan Product Type" = filter(<> 'RUAIMOBI'));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Client Code", "Loan  No.", "Transacting Branch", "Loan Product Type", "Issued Date", "Loan Status";
            column(ReportForNavId_4645; 4645)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
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
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(Loan_No; "Loan  No.")
            {
            }
            column(Client_Code; "Client Code")
            {
            }
            column(Outstanding_Balance; "Outstanding Balance")
            {
                AutoFormatType = 1;
            }
            column(Interest_Rate; Interest)
            {
                AutoFormatType = 1;
            }
            column(Client_Name; "Client Name")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //EXCLUDE RUAIMOBI LOANS
                if "Loans Register"."Loan Product Type" = 'RUAIMOBI' then
                    exit;
                InterestAmount := 0;
                /// if "Loans Register"."Interest Due Proccess" = false then 
                "Loans Register".CalcFields("Loans Register"."Outstanding Balance");
                LoanType.Get("Loans Register"."Loan Product Type");
                PDate := '01/01/10..' + FORMAT(PostDate);

                LoanApp.Reset();
                LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                LoanApp.SetFilter(LoanApp."Date filter", PDate);
                LoanApp.SetAutoCalcFields(LoanApp."Outstanding Balance");
                if LoanApp.FindSet then begin
                    Bal := LoanApp."Outstanding Balance";

                    if LoanApp."Outstanding Balance" > 0 then begin
                        InterestAmount := ROUND(Bal * (LoanApp.Interest / 1200), 1, '=');
                        // Message('out121 is %1#.......interest is %2', Bal, LoanApp.Interest);
                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := Jtemplate;
                        GenJournalLine."Journal Batch Name" := Jbatch;
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                        GenJournalLine."Account No." := LoanApp."Client Code";
                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Due";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := DocNo;
                        GenJournalLine."Posting Date" := PostDate;
                        GenJournalLine.Description := 'Interest Due';
                        GenJournalLine.Amount := InterestAmount;
                        //GenJournalLine.Amount := ROUND(Bal * (12 / 1200), 1, '=');

                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                        if LoanType.Get("Loans Register"."Loan Product Type") then
                            GenJournalLine."Bal. Account No." := LoanType."Loan Interest Account";
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        GenJournalLine."Loan No" := LoanApp."Loan  No.";
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                        //Message('out is %1#', GenJournalLine.Amount);


                    end;
                end;
            end;

            trigger OnPostDataItem()
            begin
                //Post New
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                GenJournalLine.SetRange("Journal Batch Name", Jbatch);
                if GenJournalLine.Find('-') then begin
                    //  Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                end;
                //Post New
                Message('SUCCESSFULLY TRANSFER TO JOURNAL');
            end;

            trigger OnPreDataItem()
            begin
                if FundsUSer.Get(UserId) then begin
                    Jtemplate := FundsUSer."Interest Template";
                    Jbatch := FundsUSer."Interest Batch";
                end;

                //delete journal line
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                GenJournalLine.SetRange("Journal Batch Name", Jbatch);
                GenJournalLine.DeleteAll;
                //end of deletion

                GenBatches.Reset;
                GenBatches.SetRange(GenBatches."Journal Template Name", Jtemplate);
                GenBatches.SetRange(GenBatches.Name, Jbatch);
                if GenBatches.Find('-') = false then begin
                    GenBatches.Init;
                    GenBatches."Journal Template Name" := Jtemplate;
                    GenBatches.Name := Jbatch;
                    GenBatches.Description := 'Interest Due';
                    GenBatches.Validate(GenBatches."Journal Template Name");
                    GenBatches.Validate(GenBatches.Name);
                    GenBatches.Insert;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {

            area(content)
            {
                field(Document_No; DocNo)
                {
                    ApplicationArea = Basic;
                    Caption = 'Document_No';
                }
                field(Posting_Date; PostDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting_Date';
                }
            }
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
        Company.Get();
        Company.CalcFields(Company.Picture);
    end;

    var
        Bal: Decimal;
        Company: Record "Company Information";
        GenBatches: Record "Gen. Journal Batch";
        PDate: Text;
        LoanType: Record "Loan Products Setup";
        PostDate: Date;
        Cust: Record Customer;
        LineNo: Integer;
        DocNo: Code[20];
        GenJournalLine: Record "Gen. Journal Line";
        LoanApp: Record "Loans Register";
        FundsUSer: Record "BOSA&FOSA User Template";
        Jtemplate: Code[10];
        Jbatch: Code[10];
        InterestAmount: Decimal;
}

