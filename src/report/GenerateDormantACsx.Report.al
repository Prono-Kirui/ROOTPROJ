#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50739 "Generate Dormant A|Csx"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Generate Dormant ACsX.rdlc';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.") where("Customer Type" = const(Member), Status = filter(Active | Dormant));
            RequestFilterFields = "No.";
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
            column(S_No; SN)
            {
            }
            column(No; Customer."No.")
            {
            }
            column(Name; Customer.Name)
            {
            }
            column(Current_Shares; Customer."Current Shares")
            {
            }
            column(Status_Customer; Customer.Status)
            {
            }

            trigger OnAfterGetRecord()
            begin
                GenSetup.Get();
                Cust.Reset;
                Cust.SetRange(Cust."No.", "No.");
                if Cust.Find('-') then begin
                    //Cust.CALCFIELDS(Cust."Last Transaction Date");
                    Cust.CalcFields(Cust."Last Payment Date");
                    Message('Last Payment Date %1', Cust."Last Payment Date");
                    if Cust."Last Payment Date" <> 0D then begin
                        DormancyDate := CalcDate(GenSetup."Max. Non Contribution Periods", Cust."Last Payment Date");
                        if DormancyDate > AsAt then begin
                            Cust.Status := Status::Active;
                            Cust."Status Changed On" := Today;
                            Cust."Status Changed By" := UserId;
                            Cust.Modify;
                        end;
                        if (DormancyDate < AsAt) then begin
                            Cust.Status := Status::Dormant;
                            Cust."Status Changed On" := Today;
                            Cust."Status Changed By" := UserId;
                            //Blocked:=Blocked::All;
                            Cust.Modify;
                        end;
                    end;
                end;

                Cust.Reset;
                Cust.SetRange(Cust."No.", "No.");
                if Cust.Find('-') then begin
                    Cust.CalcFields(Cust."Last Payment Date");
                    if Cust."Last Payment Date" = 0D then begin
                        DormancyDate := CalcDate(GenSetup."Max. Non Contribution Periods", Cust."Registration Date");
                        if DormancyDate < AsAt then begin
                            Cust.Status := Status::Dormant;
                            Cust."Status Changed On" := Today;
                            Cust."Status Changed By" := UserId;
                            //Blocked:=Blocked::All;
                            Cust.Modify;
                        end;
                    end;
                end;

            end;

            trigger OnPreDataItem()
            begin
                if AsAt = 0D then
                    AsAt := Today;
                DateFilter := '..' + Format(AsAt);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(AsAt; AsAt)
                {
                    ApplicationArea = Basic;
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
        Company.Get;
        Company.CalcFields(Picture);
    end;

    var
        Loans_RegisterCaptionLbl: label 'Approved Loans Report';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Loan_TypeCaptionLbl: label 'Loan Type';
        Client_No_CaptionLbl: label 'Client No.';
        Outstanding_LoanCaptionLbl: label 'Outstanding Loan';
        PeriodCaptionLbl: label 'Period';
        Approved_DateCaptionLbl: label 'Approved Date';
        Loan_TypeCaption_Control1102760043Lbl: label 'Loan Type';
        Verified_By__________________________________________________CaptionLbl: label 'Verified By..................................................';
        Confirmed_By__________________________________________________CaptionLbl: label 'Confirmed By..................................................';
        Sign________________________CaptionLbl: label 'Sign........................';
        Sign________________________Caption_Control1102755003Lbl: label 'Sign........................';
        Date________________________CaptionLbl: label 'Date........................';
        Date________________________Caption_Control1102755005Lbl: label 'Date........................';
        NameCreditOff: label 'Name......................................';
        NameCreditDate: label 'Date........................................';
        NameCreditSign: label 'Signature..................................';
        NameCreditMNG: label 'Name......................................';
        NameCreditMNGDate: label 'Date.....................................';
        NameCreditMNGSign: label 'Signature..................................';
        NameCEO: label 'Name........................................';
        NameCEOSign: label 'Signature...................................';
        NameCEODate: label 'Date.....................................';
        CreditCom1: label 'Name........................................';
        CreditCom1Sign: label 'Signature...................................';
        CreditCom1Date: label 'Date.........................................';
        CreditCom2: label 'Name........................................';
        CreditCom2Sign: label 'Signature....................................';
        CreditCom2Date: label 'Date..........................................';
        CreditCom3: label 'Name.........................................';
        CreditComDate3: label 'Date..........................................';
        CreditComSign3: label 'Signature..................................';
        Comment: label '....................';
        SN: Integer;
        Company: Record "Company Information";
        GenSetup: Record "Sacco General Set-Up";
        Cust: Record Customer;
        AsAt: Date;
        DateFilter: Text[30];
        DormancyDate: Date;
}

