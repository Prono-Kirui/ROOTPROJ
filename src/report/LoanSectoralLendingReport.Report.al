#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50992 "Loan Sectoral Lending Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Loan Sectoral Lending Report.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            RequestFilterFields = "Issued Date";
            column(ReportForNavId_1120054000; 1120054000)
            {
            }
            column(ClientCode_LoansRegister; "Loans Register"."Client Code")
            {
            }
            column(ClientName_LoansRegister; "Loans Register"."Client Name")
            {
            }
            column(LoanNo_LoansRegister; "Loans Register"."Loan  No.")
            {
            }
            column(LoanProductTypeName_LoansRegister; "Loans Register"."Loan Product Type Name")
            {
            }
            column(IssuedDate_LoansRegister; "Loans Register"."Issued Date")
            {
            }
            column(ApprovedAmount_LoansRegister; "Loans Register"."Approved Amount")
            {
            }
            column(Installments_LoansRegister; "Loans Register".Installments)
            {
            }
            column(RepaymentStartDate_LoansRegister; "Loans Register"."Repayment Start Date")
            {
            }
            column(RepaymentMethod_LoansRegister; "Loans Register"."Repayment Method")
            {
            }
            column(Interest_LoansRegister; "Loans Register".Interest)
            {
            }
            column(RepaymentFrequency_LoansRegister; "Loans Register"."Repayment Frequency")
            {
            }
            column(ModeofDisbursement_LoansRegister; "Loans Register"."Mode of Disbursement")
            {
            }
            column(EmployerName_LoansRegister; "Loans Register"."Employer Name")
            {
            }
            column(ExpectedDateofCompletion_LoansRegister; "Loans Register"."Expected Date of Completion")
            {
            }
            column(MainSector_LoansRegister; "Loans Register"."Main Sector")
            {
            }
            column(SpecificSector_LoansRegister; "Loans Register"."Specific Sector")
            {
            }
            column(MemberPos; MemberPos)
            {
            }
            column(DoB; DoB)
            {
            }
            column(Branch; Branch)
            {
            }
            column(Gender; Gender)
            {
            }
            column(EmployerName; EmployerName)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address_2; Company."Address 2")
            {
            }
            column(Company_Phone_No; Company."Phone No.")
            {
            }
            column(Company_Fax_No; Company."Fax No.")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(BranchCode_LoansRegister; "Loans Register"."Branch Code")
            {
            }
            column(MemberPosition_LoansRegister; "Loans Register"."Staff No")
            {
            }
            column(DateofBirth_LoansRegister; "Loans Register"."Issued Date")
            {
            }
            column(Gender_LoansRegister; "Loans Register".Gender)
            {
            }
            column(EmployerCode_LoansRegister; "Loans Register"."Employer Code")
            {
            }
            dataitem("Members Register"; customer)
            {
                DataItemLink = "No." = field("Client Code"), "Employer Code" = field("Employer Code"), Gender = field(Gender);
                column(ReportForNavId_1120054023; 1120054023)
                {
                }
                column(Gender_MembersRegister; "Members Register".Gender)
                {
                }
                column(EmployerCode_MembersRegister; "Members Register"."Employer Code")
                {
                }
                column(No_MembersRegister; "Members Register"."No.")
                {
                }
                column(MemberPosition_MembersRegister; "Members Register".staff)
                {
                }
                column(RegistrationDate_MembersRegister; "Members Register"."Registration Date")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin


                if not Posted then
                    CurrReport.Skip;
                /* repeat
                 "Loans Register".CALCFIELDS("Outstanding Balance","Oustanding Interest");
                   UNTIL "Loans Register".NEXT=0;
                 END;
                 */

                Vend.Reset;
                Vend.SetRange(Vend."BOSA Account No", LoansR."Client Code");
                if Vend.FindFirst then begin
                    Gender := Vend.Gender;
                    DoB := Vend."Date of Birth";
                end;




            end;

            trigger OnPreDataItem()
            begin
                /*DFilter:=GETFILTER("Loans Register"."Date Filter");
                "Loans Register".SETFILTER("Loans Register"."Date filter",DFilter);
                */

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
        Company.Get();
        Company.CalcFields(Company.Picture);
    end;

    trigger OnPreReport()
    begin
        if "COMPY INFOR".Get then begin
            "COMPY INFOR".CalcFields("COMPY INFOR".Picture);
            Name := "COMPY INFOR".Name;
        end;
    end;

    var
        MemberPos: Option;
        DoB: Date;
        Branch: Text;
        Gender: Option;
        EmployerName: Code[50];
        Cust: Record Customer;
        LoansR: Record "Loans Register";
        Company: Record "Company Information";
        CompanyAddress: Code[20];
        CompanyEmail: Text[30];
        CompanyTel: Code[20];
        "COMPY INFOR": Record "Company Information";
        Name: Text;
        PICTURE: Text;
        Vend: Record Vendor;
        DFilter: Text[50];
}

