#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50361 "Membership Application Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Membership Applications";

    layout
    {
        area(content)
        {
            group("General Info")
            {
                Caption = 'General Info';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'No.';
                    Editable = false;
                }
                field("Assigned No."; Rec."Assigned No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    Visible = false;
                }
                field("Account Category"; Rec."Account Category")
                {
                    ApplicationArea = Basic;
                    Editable = AccountCategoryEditable;
                    OptionCaption = 'Individual/Joint,Business, Limited Company';

                    trigger OnValidate()
                    begin
                        Joint2DetailsVisible := false;
                        Joint3DetailsVisible := false;

                        if Rec."Account Category" = Rec."account category"::Joint then begin
                            Joint2DetailsVisible := true;
                            Joint3DetailsVisible := true;
                        end;
                        if Rec."Account Category" = Rec."account category"::Single then begin
                            Joint2DetailsVisible := false;
                            Joint3DetailsVisible := false;
                        end;
                    end;
                }
                field("Joint Account Name"; Rec."Joint Account Name")
                {
                    ApplicationArea = Basic;
                    Visible = Joint2DetailsVisible;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = Basic;
                    Editable = FirstNameEditable;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec.Name := Rec."First Name";
                    end;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = Basic;
                    Editable = MiddleNameEditable;

                    trigger OnValidate()
                    begin
                        Rec.Name := Rec."First Name" + ' ' + Rec."Middle Name";
                    end;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = Basic;
                    Editable = LastNameEditable;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec.Name := Rec."First Name" + ' ' + Rec."Middle Name" + ' ' + Rec."Last Name";
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Personal No"; Rec."Personal No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll No.';
                    Editable = PayrollNoEditable;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                    Editable = AddressEditable;
                    ShowMandatory = true;
                }
                field("Postal Code"; Rec."Postal Code")
                {
                    ApplicationArea = Basic;
                    Editable = PostCodeEditable;
                    ShowMandatory = true;
                }
                field(Town; Rec.Town)
                {
                    ApplicationArea = Basic;
                    Editable = TownEditable;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Physical Address';
                    Editable = PhysicalAddressEditable;
                    ShowMandatory = true;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = Basic;
                    Editable = CountryEditable;
                }
                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = MobileEditable;
                    ShowMandatory = true;
                }
                field("Secondary Mobile No"; Rec."Secondary Mobile No")
                {
                    ApplicationArea = Basic;
                    Editable = SecondaryMobileEditable;
                }
                field("E-Mail (Personal)"; Rec."E-Mail (Personal)")
                {
                    ApplicationArea = Basic;
                    Editable = EmailEdiatble;
                    ShowMandatory = true;
                }
                // field("E-mail Indemnified"; Rec."E-mail Indemnified")
                // {
                //     ApplicationArea = Basic;
                //     Editable = EmailIndemnifiedEditable;
                // }
                field("IPRS Error Description"; Rec."IPRS Error Description")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleText;
                }
                field("IPRS Details"; Rec."IPRS Details")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Send E-Statements"; Rec."Send E-Statements")
                {
                    ApplicationArea = Basic;
                    Editable = SendEStatementsEditable;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                    Editable = DOBEditable;
                    ShowMandatory = true;
                }
                field(Age; Rec.Age)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Identification Document"; Rec."Identification Document")
                {
                    ApplicationArea = Basic;
                    Editable = IdentificationDocTypeEditable;

                    trigger OnValidate()
                    begin
                        if Rec."Identification Document" = Rec."identification document"::"Nation ID Card" then begin
                            PassportEditable := false;
                            IDNoEditable := true
                        end else
                            if Rec."Identification Document" = Rec."identification document"::"Passport Card" then begin
                                PassportEditable := true;
                                IDNoEditable := false
                            end else
                                if Rec."Identification Document" = Rec."identification document"::"Aliens Card" then begin
                                    PassportEditable := true;
                                    IDNoEditable := true;
                                end;
                    end;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    Editable = IDNoEditable;
                    ShowMandatory = true;
                }

                field("Document Has Expiry"; Rec."Document Has Expiry")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Caption = 'Document Expires';

                    //Toggle = true;

                }

                field("Date of Issuance"; Rec."Date of Issuance")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Caption = 'Date of Issuance';
                }

                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Caption = 'Expiry Date';
                    //Visible = Rec."Document Has Expiry";
                }
                field("Passport No."; Rec."Passport No.")
                {
                    ApplicationArea = Basic;
                    Editable = PassportEditable;
                }
                field("KRA PIN"; Rec."KRA PIN")
                {
                    ApplicationArea = Basic;
                    Editable = KRAPinEditable;
                    ShowMandatory = true;
                }
                field("Member House Group"; Rec."Member House Group")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member House Group';
                }
                field("Member House Group Name"; Rec."Member House Group Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member House Group Name';
                    Editable = false;
                }
                field("Member Needs House Group"; Rec."Member Needs House Group")
                {
                    ApplicationArea = Basic;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                    Editable = GenderEditable;
                    ShowMandatory = true;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = Basic;
                    Editable = MaritalstatusEditable;
                    ShowMandatory = true;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Application Category"; Rec."Application Category")
                {
                    ApplicationArea = Basic;
                    Editable = AppCategoryEditable;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(Signature; Rec.Signature)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Monthly Contribution"; Rec."Monthly Contribution")
                {
                    ApplicationArea = Basic;
                    Editable = MonthlyContributionEdit;
                    ShowMandatory = true;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Member's Residence"; Rec."Member's Residence")
                {
                    ApplicationArea = Basic;
                    Editable = MemberResidenceEditable;
                    ShowMandatory = true;
                }
            }
            group("Employment Info")
            {
                Caption = 'Employment Info';
                field(Control1000000004; Rec."Employment Info")
                {
                    ApplicationArea = Basic;
                    Editable = EmploymentInfoEditable;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        if Rec."Employment Info" = Rec."employment info"::Employed then begin
                            EmployerCodeEditable := true;
                            DepartmentEditable := true;
                            TermsofEmploymentEditable := true;
                            ContractingEditable := false;
                            EmployedEditable := false;
                            OccupationEditable := false;
                            PositionHeldEditable := true;
                            EmploymentDateEditable := true;
                            EmployerAddressEditable := true;
                            NatureofBussEditable := false;
                            IndustryEditable := false;
                            BusinessNameEditable := false;
                            PhysicalBussLocationEditable := false;
                            YearOfCommenceEditable := false;



                        end else
                            if Rec."Employment Info" = Rec."employment info"::Contracting then begin
                                ContractingEditable := true;
                                EmployerCodeEditable := false;
                                DepartmentEditable := false;
                                TermsofEmploymentEditable := false;
                                OccupationEditable := false;
                                PositionHeldEditable := false;
                                EmploymentDateEditable := false;
                                EmployerAddressEditable := false;
                                NatureofBussEditable := false;
                                IndustryEditable := false;
                                BusinessNameEditable := false;
                                PhysicalBussLocationEditable := false;
                                YearOfCommenceEditable := false;
                            end else
                                if Rec."Employment Info" = Rec."employment info"::Others then begin
                                    OthersEditable := true;
                                    ContractingEditable := false;
                                    EmployerCodeEditable := false;
                                    DepartmentEditable := false;
                                    TermsofEmploymentEditable := false;
                                    OccupationEditable := false;
                                    PositionHeldEditable := false;
                                    EmploymentDateEditable := false;
                                    EmployerAddressEditable := false
                                end else
                                    if Rec."Employment Info" = Rec."employment info"::"Self-Employed" then begin
                                        OccupationEditable := true;
                                        EmployerCodeEditable := false;
                                        DepartmentEditable := false;
                                        TermsofEmploymentEditable := false;
                                        ContractingEditable := false;
                                        EmployedEditable := false;
                                        NatureofBussEditable := true;
                                        IndustryEditable := true;
                                        BusinessNameEditable := true;
                                        PhysicalBussLocationEditable := true;
                                        YearOfCommenceEditable := true;
                                        PositionHeldEditable := false;
                                        EmploymentDateEditable := false;
                                        EmployerAddressEditable := false

                                    end;




                        if Rec."Identification Document" = Rec."identification document"::"Nation ID Card" then begin
                            PassportEditable := false;
                            IDNoEditable := true
                        end else
                            if Rec."Identification Document" = Rec."identification document"::"Passport Card" then begin
                                PassportEditable := true;
                                IDNoEditable := false
                            end else
                                if Rec."Identification Document" = Rec."identification document"::"Aliens Card" then begin
                                    PassportEditable := true;
                                    IDNoEditable := true;
                                end;
                    end;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = EmployerCodeEditable;
                    ShowMandatory = true;
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = Basic;
                    Editable = EmployedEditable;
                }
                field("Employer Address"; Rec."Employer Address")
                {
                    ApplicationArea = Basic;
                    Editable = EmployerAddressEditable;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic;
                    Caption = 'WorkStation / Depot';
                    Editable = DepartmentEditable;
                }
                field("Terms of Employment"; Rec."Terms of Employment")
                {
                    ApplicationArea = Basic;
                    Editable = TermsofEmploymentEditable;
                    ShowMandatory = true;
                }
                field("Date of Employment"; Rec."Date of Employment")
                {
                    ApplicationArea = Basic;
                    Editable = EmploymentDateEditable;
                }
                field("Position Held"; Rec."Position Held")
                {
                    ApplicationArea = Basic;
                    Editable = PositionHeldEditable;
                }
                field("Expected Monthly Income"; Rec."Expected Monthly Income")
                {
                    ApplicationArea = Basic;
                    Editable = MonthlyIncomeEditable;
                }
                field("Nature Of Business"; Rec."Nature Of Business")
                {
                    ApplicationArea = Basic;
                    Editable = NatureofBussEditable;
                }
                field(Industry; Rec.Industry)
                {
                    ApplicationArea = Basic;
                    Editable = IndustryEditable;
                }
                field("Business Name"; Rec."Business Name")
                {
                    ApplicationArea = Basic;
                    Editable = BusinessNameEditable;
                }
                field("Physical Business Location"; Rec."Physical Business Location")
                {
                    ApplicationArea = Basic;
                    Editable = PhysicalBussLocationEditable;
                }
                field("Year of Commence"; Rec."Year of Commence")
                {
                    ApplicationArea = Basic;
                    Editable = YearOfCommenceEditable;
                }
                field(Occupation; Rec.Occupation)
                {
                    ApplicationArea = Basic;
                    Editable = OccupationEditable;
                }
                field("Others Details"; Rec."Others Details")
                {
                    ApplicationArea = Basic;
                    Editable = OthersEditable;
                }
            }
            group("Referee Details")
            {
                field("Referee Member No"; Rec."Referee Member No")
                {
                    ApplicationArea = Basic;
                    Editable = RefereeEditable;
                }
                field("Referee Name"; Rec."Referee Name")
                {
                    ApplicationArea = Basic;
                }
                field("Referee ID No"; Rec."Referee ID No")
                {
                    ApplicationArea = Basic;
                }
                field("Referee Mobile Phone No"; Rec."Referee Mobile Phone No")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Member Risk Rating")
            {
                group("Member Risk Rate")
                {
                    field("Individual Category"; Rec."Individual Category")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Member Residency Status"; Rec."Member Residency Status")
                    {
                        ApplicationArea = Basic;
                    }
                    field(Entities; Rec.Entities)
                    {
                        ApplicationArea = Basic;
                    }
                    field("Industry Type"; Rec."Industry Type")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Length Of Relationship"; Rec."Length Of Relationship")
                    {
                        ApplicationArea = Basic;
                    }
                    field("International Trade"; Rec."International Trade")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group("Product Risk Rating")
                {
                    field("Electronic Payment"; Rec."Electronic Payment")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Accounts Type Taken"; Rec."Accounts Type Taken")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Cards Type Taken"; Rec."Cards Type Taken")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Others(Channels)"; Rec."Others(Channels)")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Member Risk Level"; Rec."Member Risk Level")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Risk Level';
                        Editable = true;
                        Image = Person;
                        StyleExpr = CoveragePercentStyle;
                    }
                    field("Due Diligence Measure"; Rec."Due Diligence Measure")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                        Image = Person;
                        StyleExpr = CoveragePercentStyle;
                    }
                }
                // part(Control27; "Member Due Diligence Measure")
                // {
                //     Caption = 'Due Diligence Measure';
                //     // SubPageLink = "Member No" = field("No.");
                //     // SubPageView = sorting("Due Diligence No");
                // }
            }
            group(Joint2Details)
            {
                Caption = 'Joint2Details';
                Visible = Joint2DetailsVisible;
                field("First Name2"; Rec."First Name2")
                {
                    ApplicationArea = Basic;
                    Caption = 'First Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec."Name 2" := Rec."First Name2";
                    end;
                }
                field("Middle Name2"; Rec."Middle Name2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Middle Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec."Name 2" := Rec."First Name2" + ' ' + Rec."Middle Name2";
                    end;
                }
                field("Last Name2"; Rec."Last Name2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Last Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec."Name 2" := Rec."First Name2" + ' ' + Rec."Middle Name2" + ' ' + Rec."Last Name2";
                    end;
                }
                field("Name 2"; Rec."Name 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                    Editable = false;
                }
                field("Payroll/Staff No2"; Rec."Payroll/Staff No2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll No';
                }
                field(Address3; Rec.Address3)
                {
                    ApplicationArea = Basic;
                    Caption = 'Address';
                }
                field("Postal Code 2"; Rec."Postal Code 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Postal Code';
                }
                field("Town 2"; Rec."Town 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Town';
                }
                field("Mobile No. 3"; Rec."Mobile No. 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';
                    ShowMandatory = true;
                }
                field("Date of Birth2"; Rec."Date of Birth2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                }
                field("ID No.2"; Rec."ID No.2")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No.';
                    ShowMandatory = true;
                }
                field("Passport 2"; Rec."Passport 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Passport No.';
                }
                field(Gender2; Rec.Gender2)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                    ShowMandatory = true;
                }
                field("Marital Status2"; Rec."Marital Status2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                }
                field("Home Postal Code2"; Rec."Home Postal Code2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Postal Code';
                }
                field("Home Town2"; Rec."Home Town2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Town';
                }
                field("Employer Code2"; Rec."Employer Code2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Code';
                }
                field("Employer Name2"; Rec."Employer Name2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Name';
                }
                field("E-Mail (Personal2)"; Rec."E-Mail (Personal2)")
                {
                    ApplicationArea = Basic;
                    Caption = 'E-Mail (Personal)';
                }
                field("Picture 2"; Rec."Picture 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Picture';
                }
                field("Signature  2"; Rec."Signature  2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signature';
                }
            }
            group(Joint3Details)
            {
                Visible = Joint3DetailsVisible;
                field("First Name3"; Rec."First Name3")
                {
                    ApplicationArea = Basic;
                    Caption = 'First Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec."Name 3" := Rec."First Name3";
                    end;
                }
                field("Middle Name 3"; Rec."Middle Name 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Middle Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec."Name 3" := Rec."First Name3" + ' ' + Rec."Middle Name 3";
                    end;
                }
                field("Last Name3"; Rec."Last Name3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Last Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec."Name 3" := Rec."First Name3" + ' ' + Rec."Middle Name 3" + ' ' + Rec."Last Name3";
                    end;
                }
                field("Name 3"; Rec."Name 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                    Editable = false;
                }
                field("Payroll/Staff No3"; Rec."Payroll/Staff No3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll/Staff No';
                    ShowMandatory = true;
                }
                field(Address4; Rec.Address4)
                {
                    ApplicationArea = Basic;
                    Caption = 'Address';
                }
                field("Postal Code 3"; Rec."Postal Code 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Postal Code';
                }
                field("Town 3"; Rec."Town 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Town';
                }
                field("Mobile No. 4"; Rec."Mobile No. 4")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';
                    ShowMandatory = true;
                }
                field("Date of Birth3"; Rec."Date of Birth3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                    ShowMandatory = true;
                }
                field("ID No.3"; Rec."ID No.3")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No.';
                    ShowMandatory = true;
                }
                field("Passport 3"; Rec."Passport 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Passport No.';
                }
                field(Gender3; Rec.Gender3)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                    ShowMandatory = true;
                }
                field("Marital Status3"; Rec."Marital Status3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                }
                field("Home Postal Code3"; Rec."Home Postal Code3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Postal Code';
                }
                field("Home Town3"; Rec."Home Town3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Town';
                }
                field("Employer Code3"; Rec."Employer Code3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Code';
                }
                field("Employer Name3"; Rec."Employer Name3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Name';
                }
                field("E-Mail (Personal3)"; Rec."E-Mail (Personal3)")
                {
                    ApplicationArea = Basic;
                }
                field("Picture 3"; Rec."Picture 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Picture';
                    ShowMandatory = true;
                }
                field("Signature  3"; Rec."Signature  3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signature';
                    ShowMandatory = true;
                }
            }
        }
        area(factboxes)
        {
            part(Control149; "Member Picture")
            {
                ApplicationArea = all;
                SubPageLink = "No." = FIELD("No.");


            }
            part(Control1000000028; "Member Signature-App")
            {
                ApplicationArea = All;
                Caption = 'Signature';
                Editable = MobileEditable;
                Enabled = MobileEditable;
                SubPageLink = "No." = field("No.");

            }
        }
    }


    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                action("Select Products")
                {
                    ApplicationArea = Basic;
                    Image = Accounts;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Membership App Products";
                    RunPageLink = "Membership Applicaton No" = field("No.");

                    trigger OnAction()
                    begin


                    end;
                }
                action("Next of Kin Details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Next of Kin Details';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Membership App Nominee Detail";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Account Signatories ")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signatories';
                    Image = Group;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Membership App Signatories";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Member Agent Details")
                {
                    ApplicationArea = Basic;
                    Image = Group;
                    Promoted = true;
                    PromotedCategory = Process;
                    // RunObject = Page "Member Agent App  List";
                    // RunPageLink = "Account No" = field("No.");
                }
                action("Member Sanction Information")
                {
                    ApplicationArea = Basic;
                    Image = ErrorLog;
                    Promoted = true;
                    PromotedCategory = Process;
                    // RunObject = Page "Membership Application Saction";
                    // RunPageLink = "Document No" = field("No.");
                }

                separator(Action6)
                {
                    Caption = '-';
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Enabled = (not OpenApprovalEntriesExist) AND EnabledApprovalWorkflowsExist AND (not RecordApproved);
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    trigger OnAction()
                    var
                        Text001: label 'This request is already pending approval';
                        AppliedProducts: Record "Membership Reg. Products Appli";
                        Cust: Record "Customer";
                        NOkApp: Record "Member App Nominee";
                    begin

                        if not Rec.Picture.HasValue then
                            Error('Member Picture is mandatory. Please upload a picture in the Member Picture factbox before submitting.');
                        if not Rec.Signature.HasValue then
                            Error('Member Signature is mandatory. Please upload a signature in the Member Signature factbox before submitting.');

                        if Rec."ID No." <> '' then begin

                            Cust.Reset;
                            Cust.SetRange(Cust."ID No.", Rec."ID No.");
                            Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                            if Cust.Find('-') then begin
                                if (Cust."No." <> Rec."No.") and (Cust."Account Category" = Cust."account category"::SINGLE) then Error('Member has already been created. Kindly Confirm the ID Number to proceed.');
                            end;
                        end;
                        //*******************Check ID no.******************************
                        if (Rec."Account Category" = Rec."account category"::Single) then begin
                            Rec.TestField(Name);
                            Rec.TestField("ID No.");
                            Rec.TestField("Mobile Phone No");

                            Rec.TestField(Gender);
                            Rec.TestField("Registration Date");

                        end
                        else if (Rec."Account Category" = Rec."account category"::Group) or (Rec."Account Category" = Rec."account category"::Corporate) then begin
                            rec.TestField(Name);



                        end;
                        if (Rec."Account Category" = Rec."account category"::Single) or (Rec."Account Category" = Rec."account category"::Joint) then begin
                            NOkApp.Reset;
                            NOkApp.SetRange(NOkApp."Account No", Rec."No.");
                            if NOkApp.Find('-') = false then begin
                                Error('Please Insert Next 0f kin Information');
                            end;
                        end;

                        if Rec.Status <> Rec.Status::Open then Error(Text001);
                        //.................................
                        if Confirm('Send Approval Request for Membership Applicant %1 ', false, Rec.Name) = false then begin
                            Message('Cancelled');
                            exit;
                        end
                        else begin
                            ApprovalsCodeUnit.SendMembershipApplicationsRequestForApproval(rec."No.", Rec);


                            //=====================================================================================================Send SMS
                            IF ObjGenSetUp."Send Membership Reg SMS" = TRUE THEN BEGIN
                                SFactory.FnSendSMS('MEMBERAPP', 'You member Registration has been Send to Approval.', VarBOSAACC, Rec."Mobile Phone No");
                            END;
                            Message('Approval Request Sent Successfully');

                        end;
                        CurrPage.Close();
                        //.................................
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Enabled = CanCancelApprovalForRecord;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                    begin
                        if Confirm('Cancel Approval?', false) = true then begin
                            ApprovalsCodeUnit.CancelMembershipApplicationsRequestForApproval(rec."No.", Rec);
                        end;
                    end;
                }

                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::MembershipApplication;
                        ApprovalEntries.Setfilters(Database::"Membership Applications", DocumentType, Rec."No.");
                        ApprovalEntries.Run;
                    end;
                }
                separator(Action2)
                {
                    Caption = '       -';
                }
                action("Create Account ")
                {
                    ApplicationArea = Basic;
                    Enabled = EnableCreateMember;
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        IF Rec.Status <> Rec.Status::Approved THEN
                            ERROR('This application has not been approved');
                        Rec.TESTFIELD("Monthly Contribution");

                        IF CONFIRM('Are you sure you want to create account application?', FALSE) = TRUE THEN BEGIN


                            ObjProductsApp.RESET;
                            ObjProductsApp.SETRANGE(ObjProductsApp."Membership Applicaton No", Rec."No.");
                            ObjProductsApp.SETRANGE(ObjProductsApp."Product Source", ObjProductsApp."Product Source"::BOSA);
                            IF ObjProductsApp.FINDSET THEN BEGIN
                                REPEAT

                                    //================================================================================================Back office Account
                                    IF Rec."ID No." <> '' THEN BEGIN
                                        ObjCust.RESET;
                                        ObjCust.SETRANGE(ObjCust."ID No.", Rec."ID No.");
                                        ObjCust.SETRANGE(ObjCust."Customer Type", ObjCust."Customer Type"::Member);
                                        IF ObjCust.FIND('-') THEN BEGIN
                                            ERROR('Member has already been created');
                                        END;
                                    END;

                                    ObjSaccosetup.GET();

                                    ObjMemberNoseries.RESET;
                                    ObjMemberNoseries.SETRANGE(ObjMemberNoseries."Account Type", ObjProductsApp.Product);
                                    IF ObjMemberNoseries.FINDSET THEN BEGIN
                                        VarNewMembNo := ObjMemberNoseries."Account No";
                                    END;
                                    Message('Creating BOSA Account %1 for %2', VarNewMembNo, Rec.Name);



                                    //Create BOSA account
                                    ObjCust."No." := FORMAT(VarNewMembNo);
                                    ObjCust.Name := Rec.Name;
                                    ObjCust.Address := Rec.Address;
                                    ObjCust."Post Code" := Rec."Postal Code";
                                    ObjCust.County := Rec.City;
                                    ObjCust."Phone No." := Rec."Mobile Phone No";
                                    ObjCust."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                                    ObjCust."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                                    ObjCust."Customer Posting Group" := Rec."Customer Posting Group";
                                    ObjCust."Registration Date" := TODAY;
                                    ObjCust."Mobile Phone No" := Rec."Mobile Phone No";
                                    ObjCust.Status := ObjCust.Status::Active;
                                    ObjCust."Employer Code" := Rec."Employer Code";
                                    ObjCust."Date of Birth" := Rec."Date of Birth";
                                    ObjCust.Image := Rec.Picture;
                                    ObjCust.Signature := Rec.Signature;
                                    ObjCust."Station/Department" := Rec."Station/Department";
                                    ObjCust."E-Mail" := Rec."E-Mail (Personal)";
                                    ObjCust.Location := Rec.Location;
                                    ObjCust.Title := Rec.Title;
                                    ObjCust."Home Address" := Rec."Home Address";
                                    ObjCust."Home Postal Code" := Rec."Home Postal Code";
                                    ObjCust."Home Town" := Rec."Home Town";
                                    ObjCust."Recruited By" := Rec."Recruited By";
                                    ObjCust."Contact Person" := Rec."Contact Person";
                                    ObjCust."ContactPerson Relation" := Rec."ContactPerson Relation";
                                    ObjCust."ContactPerson Occupation" := Rec."ContactPerson Occupation";
                                    ObjCust."Member Share Class" := Rec."Member Share Class";
                                    ObjCust."Member's Residence" := Rec."Member's Residence";
                                    ObjCust."Employer Address" := Rec."Employer Address";
                                    ObjCust."Member House Group" := Rec."Member House Group";
                                    ObjCust."Member House Group Name" := Rec."Member House Group Name";
                                    ObjCust."Nature Of Business" := Rec."Nature Of Business";
                                    ObjCust."Date of Employment" := Rec."Date of Employment";
                                    ObjCust."Position Held" := Rec."Position Held";
                                    ObjCust.Industry := Rec.Industry;
                                    ObjCust."Business Name" := Rec."Business Name";
                                    ObjCust."Physical Business Location" := Rec."Physical Business Location";
                                    ObjCust."Year of Commence" := Rec."Year of Commence";
                                    ObjCust."Identification Document" := Rec."Identification Document";
                                    ObjCust."Referee Member No" := Rec."Referee Member No";
                                    ObjCust."Referee Name" := Rec."Referee Name";
                                    ObjCust."Referee ID No" := Rec."Referee ID No";
                                    ObjCust."Referee Mobile Phone No" := Rec."Referee Mobile Phone No";
                                    ObjCust."Email Indemnified" := Rec."E-mail Indemnified";
                                    ObjCust."Created By" := USERID;
                                    ObjCust."Member Needs House Group" := Rec."Member Needs House Group";


                                    //*****************************to Sort Joint
                                    ObjCust."Name 2" := Rec."Name 2";
                                    ObjCust."Address3-Joint" := Rec.Address3;
                                    ObjCust."Postal Code 2" := Rec."Postal Code 2";
                                    ObjCust."Home Postal Code2" := Rec."Home Postal Code2";
                                    ObjCust."Home Town2" := Rec."Home Town2";
                                    ObjCust."ID No.2" := Rec."ID No.2";
                                    ObjCust."Passport 2" := Rec."Passport 2";
                                    ObjCust.Gender2 := Rec.Gender2;
                                    ObjCust."Marital Status2" := Rec."Marital Status2";
                                    ObjCust."E-Mail (Personal3)" := Rec."E-Mail (Personal2)";
                                    ObjCust."Employer Code2" := Rec."Employer Code2";
                                    ObjCust."Employer Name2" := Rec."Employer Name2";
                                    ObjCust."Picture 2" := Rec."Picture 2";
                                    ObjCust."Signature  2" := Rec."Signature  2";


                                    ObjCust."Name 3" := Rec."Name 3";
                                    ObjCust."Address3-Joint" := Rec.Address4;
                                    ObjCust."Postal Code 3" := Rec."Postal Code 3";
                                    ObjCust."Home Postal Code3" := Rec."Home Postal Code3";
                                    ObjCust."Mobile No. 4" := Rec."Mobile No. 4";
                                    ObjCust."Home Town3" := Rec."Home Town3";
                                    ObjCust."ID No.3" := Rec."ID No.3";
                                    ObjCust."Passport 3" := Rec."Passport 3";
                                    ObjCust.Gender3 := Rec.Gender3;
                                    ObjCust."Marital Status3" := Rec."Marital Status3";
                                    ObjCust."E-Mail (Personal3)" := Rec."E-Mail (Personal3)";
                                    ObjCust."Employer Code3" := Rec."Employer Code3";
                                    ObjCust."Employer Name3" := Rec."Employer Name3";
                                    ObjCust."Picture 3" := Rec."Picture 3";
                                    ObjCust."Signature  3" := Rec."Signature  3";
                                    ObjCust."Member Parish Name 3" := Rec."Member Parish Name 3";
                                    ObjCust."Member Parish Name 3" := Rec."Member Parish Name 3";
                                    IF ObjCust."Account Category" = ObjCust."Account Category"::Joint THEN
                                        ObjCust."Joint Account Name" := Rec."First Name" + '& ' + Rec."First Name2" + '& ' + Rec."First Name3" + 'JA';
                                    ObjCust."Account Category" := Rec."Account Category";

                                    //===================================================================================End Joint Account Details

                                    //**
                                    ObjCust."Office Branch" := Rec."Office Branch";
                                    ObjCust.Department := Rec.Department;
                                    ObjCust.Occupation := Rec.Occupation;
                                    ObjCust.Designation := Rec.Designation;
                                    ObjCust."Bank Code" := Rec."Bank Code";
                                    ObjCust."Bank Name" := Rec."Bank Name";
                                    ObjCust."Bank Account No." := Rec."Bank Account No";
                                    //**
                                    ObjCust."Sub-Location" := Rec."Sub-Location";
                                    ObjCust.District := Rec.District;
                                    ObjCust."Personal No" := Rec."Personal No";
                                    ObjCust."ID No." := Rec."ID No.";
                                    ObjCust."Mobile Phone No" := Rec."Mobile Phone No";
                                    ObjCust."Marital Status" := Rec."Marital Status";
                                    ObjCust."Customer Type" := ObjCust."Customer Type"::Member;
                                    ObjCust.Gender := Rec.Gender;

                                    ObjCust.image := Rec.Picture;
                                    ObjCust.Signature := Rec.Signature;

                                    ObjCust."Monthly Contribution" := Rec."Monthly Contribution";
                                    ObjCust."Contact Person" := Rec."Contact Person";
                                    ObjCust."Contact Person Phone" := Rec."Contact Person Phone";
                                    ObjCust."ContactPerson Relation" := Rec."ContactPerson Relation";
                                    ObjCust."Recruited By" := Rec."Recruited By";
                                    ObjCust."ContactPerson Occupation" := Rec."ContactPerson Occupation";
                                    ObjCust."Village/Residence" := Rec."Village/Residence";
                                    ObjCust.Pin := Rec."KRA PIN";

                                    //========================================================================Member Risk Rating
                                    ObjCust."Individual Category" := Rec."Individual Category";
                                    ObjCust.Entities := Rec.Entities;
                                    ObjCust."Member Residency Status" := Rec."Member Residency Status";
                                    ObjCust."Industry Type" := Rec."Industry Type";
                                    ObjCust."Length Of Relationship" := Rec."Length Of Relationship";
                                    ObjCust."International Trade" := Rec."International Trade";
                                    ObjCust."Electronic Payment" := Rec."Electronic Payment";
                                    ObjCust."Accounts Type Taken" := Rec."Accounts Type Taken";
                                    ObjCust."Cards Type Taken" := Rec."Cards Type Taken";
                                    ObjCust.INSERT(TRUE);
                                    //========================================================================End Member Risk Rating

                                    ObjNextOfKinApp.RESET;
                                    ObjNextOfKinApp.SETRANGE(ObjNextOfKinApp."Account No", Rec."No.");
                                    IF ObjNextOfKinApp.FIND('-') THEN BEGIN
                                        REPEAT
                                            ObjNextOfKin.INIT;
                                            ObjNextOfKin."Account No" := ObjCust."No.";
                                            ObjNextOfKin.Name := ObjNextOfKinApp.Name;
                                            ObjNextOfKin.Relationship := ObjNextOfKinApp.Relationship;
                                            ObjNextOfKin.Beneficiary := ObjNextOfKinApp.Beneficiary;
                                            ObjNextOfKin."Date of Birth" := ObjNextOfKinApp."Date of Birth";
                                            ObjNextOfKin.Address := ObjNextOfKinApp.Address;
                                            ObjNextOfKin.Telephone := ObjNextOfKinApp.Telephone;
                                            ObjNextOfKin.Email := ObjNextOfKinApp.Email;
                                            ObjNextOfKin."ID No." := ObjNextOfKinApp."ID No.";
                                            ObjNextOfKin."%Allocation" := ObjNextOfKinApp."%Allocation";
                                            ObjNextOfKin.Description := ObjNextOfKinApp.Description;
                                            ObjNextOfKin."Next Of Kin Type" := ObjNextOfKinApp."Next Of Kin Type";
                                            ObjNextOfKin.INSERT;
                                        UNTIL ObjNextOfKinApp.NEXT = 0;
                                    END;

                                    ObjAccountSignApp.RESET;
                                    ObjAccountSignApp.SETRANGE(ObjAccountSignApp."Account No", Rec."No.");
                                    IF ObjAccountSignApp.FIND('-') THEN BEGIN
                                        REPEAT
                                            ObjAccountSign.INIT;
                                            ObjAccountSign."Account No" := VarAcctNo;
                                            ObjAccountSign.Names := ObjAccountSignApp.Names;
                                            ObjAccountSign."Date Of Birth" := ObjAccountSignApp."Date Of Birth";
                                            ObjAccountSign."Staff/Payroll" := ObjAccountSignApp."Staff/Payroll";
                                            ObjAccountSign."ID No." := ObjAccountSignApp."ID No.";
                                            ObjAccountSign.Signatory := ObjAccountSignApp.Signatory;
                                            ObjAccountSign."Must Sign" := ObjAccountSignApp."Must Sign";
                                            ObjAccountSign."Must be Present" := ObjAccountSignApp."Must be Present";
                                            ObjAccountSign.Picture := ObjAccountSignApp.Picture;
                                            ObjAccountSign.Signature := ObjAccountSignApp.Signature;
                                            ObjAccountSign."Expiry Date" := ObjAccountSignApp."Expiry Date";
                                            //ObjAccountSign."Mobile No.":=ObjAccountSignApp."Mobile No.";
                                            ObjAccountSign.INSERT;
                                        UNTIL ObjAccountSignApp.NEXT = 0;
                                    END;

                                    //==================================================================================Insert Member Agents
                                    ObjMemberAppAgent.RESET;
                                    ObjMemberAppAgent.SETRANGE(ObjMemberAppAgent."Account No", Rec."No.");
                                    IF ObjMemberAppAgent.FIND('-') THEN BEGIN
                                        REPEAT
                                            ObjMemberAgent.INIT;
                                            ObjMemberAgent."Account No" := ObjCust."No.";
                                            ;
                                            ObjMemberAgent.Names := ObjMemberAppAgent.Names;
                                            ObjMemberAgent."Date Of Birth" := ObjMemberAppAgent."Date Of Birth";
                                            ObjMemberAgent."Staff/Payroll" := ObjMemberAppAgent."Staff/Payroll";
                                            ObjMemberAgent."ID No." := ObjMemberAppAgent."ID No.";
                                            ObjMemberAgent."Allowed  Correspondence" := ObjMemberAppAgent."Allowed  Correspondence";
                                            ObjMemberAgent."Allowed Balance Enquiry" := ObjMemberAppAgent."Allowed Balance Enquiry";
                                            ObjMemberAgent."Allowed FOSA Withdrawals" := ObjMemberAppAgent."Allowed FOSA Withdrawals";
                                            ObjMemberAgent."Allowed Loan Processing" := ObjMemberAppAgent."Allowed Loan Processing";
                                            ObjMemberAgent."Must Sign" := ObjMemberAppAgent."Must Sign";
                                            ObjMemberAgent."Must be Present" := ObjMemberAppAgent."Must be Present";
                                            ObjMemberAgent.Picture := ObjMemberAppAgent.Picture;
                                            ObjMemberAgent.Signature := ObjMemberAppAgent.Signature;
                                            ObjMemberAgent."Expiry Date" := ObjMemberAppAgent."Expiry Date";
                                            ObjMemberAgent.INSERT;
                                        UNTIL ObjMemberAppAgent.NEXT = 0;
                                    END;
                                    //==================================================================================End Insert Member Agents

                                    ObjMemberNoseries.RESET;
                                    ObjMemberNoseries.SETRANGE(ObjMemberNoseries."Account Type", ObjProductsApp.Product);
                                    IF ObjMemberNoseries.FINDSET THEN BEGIN
                                        ObjMemberNoseries."Account No" := INCSTR(ObjMemberNoseries."Account No");
                                        ObjMemberNoseries.MODIFY;
                                    END;
                                    // Message('next no is %1', ObjMemberNoseries."Account No");
                                    VarBOSAACC := ObjCust."No.";
                                UNTIL ObjProductsApp.NEXT = 0;
                            END;
                        END;
                        //==================================================================================================End Back Office Account

                        //==================================================================================================Front Office Accounts
                        ObjProductsApp.RESET;
                        ObjProductsApp.SETRANGE(ObjProductsApp."Membership Applicaton No", Rec."No.");
                        ObjProductsApp.SETFILTER(ObjProductsApp.Product, '<>%1', 'BOSA');
                        IF ObjProductsApp.FINDSET THEN BEGIN
                            REPEAT
                                //message('Creating Account..%1 ', ObjProductsApp.Product);

                                ObjMemberNoseries.RESET;
                                ObjMemberNoseries.SETRANGE(ObjMemberNoseries."Account Type", ObjProductsApp.Product);
                                //ObjMemberNoseries.SETRANGE(ObjMemberNoseries."Branch Code", Rec."Global Dimension 2 Code");
                                IF ObjMemberNoseries.FINDSET THEN BEGIN
                                    //message('Found Member No Series for %1 - %2', ObjProductsApp.Product, ObjMemberNoseries."Account No");
                                    VarAcctNo := ObjMemberNoseries."Account No" + '-' + VarBOSAACC;

                                END;
                                ObjAccounts.RESET;
                                ObjAccounts.SETRANGE(ObjAccounts."ID No.", Rec."ID No.");
                                ObjAccounts.SETRANGE(ObjAccounts."Account Type", ObjProductsApp.Product);
                                IF ObjAccounts.FINDSET THEN BEGIN
                                    ERROR('The Member has an existing %1', ObjAccounts."Account Type");
                                END;

                                //===================================================================Create FOSA account
                                ObjAccounts.INIT;
                                ObjAccounts."No." := VarAcctNo;
                                Message('New Account No is %1', ObjAccounts."No.");
                                ObjAccounts."Date of Birth" := Rec."Date of Birth";
                                ObjAccounts.Name := Rec.Name;
                                ObjAccounts."Creditor Type" := ObjAccounts."Creditor Type"::"FOSA Account";
                                ObjAccounts."Personal No." := Rec."Personal No";
                                ObjAccounts."ID No." := Rec."ID No.";
                                ObjAccounts."Mobile Phone No" := Rec."Mobile Phone No";
                                ObjAccounts."Phone No." := Rec."Mobile Phone No";
                                ObjAccounts."Registration Date" := Rec."Registration Date";
                                ObjAccounts."Post Code" := Rec."Postal Code";
                                ObjAccounts.County := Rec.City;
                                ObjAccounts."BOSA Account No" := ObjCust."No.";
                                ObjAccounts.Image := Rec.Picture;
                                ObjAccounts.Signature := Rec.Signature;
                                ObjAccounts."Passport No." := Rec."Passport No.";
                                ObjAccounts."Employer Code" := Rec."Employer Code";
                                ObjAccounts.Status := ObjAccounts.Status::Active;
                                ObjAccounts."Account Type" := ObjProductsApp.Product;
                                ObjAccounts."Date of Birth" := Rec."Date of Birth";
                                ObjAccounts."Global Dimension 1 Code" := FORMAT(ObjProductsApp."Product Source");
                                ObjAccounts."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                                ObjAccounts.Address := Rec.Address;
                                IF Rec."Account Category" = Rec."Account Category"::Corporate THEN BEGIN
                                    ObjAccounts."Account Category" := ObjAccounts."Account Category"::Corporate
                                END ELSE
                                    ObjAccounts."Account Category" := Rec."Account Category";
                                ObjAccounts."Address 2" := Rec."Address 2";
                                ObjAccounts."Phone No." := Rec."Mobile Phone No";
                                ObjAccounts."Registration Date" := TODAY;
                                ObjAccounts.Status := ObjAccounts.Status::Active;
                                ObjAccounts.Section := Rec.Section;
                                ObjAccounts."Home Address" := Rec."Home Address";
                                ObjAccounts.District := Rec.District;
                                ObjAccounts.Location := Rec.Location;
                                ObjAccounts."Sub-Location" := Rec."Sub-Location";
                                ObjAccounts."Registration Date" := TODAY;
                                ObjAccounts."Monthly Contribution" := Rec."Monthly Contribution";
                                ObjAccounts."E-Mail" := Rec."E-Mail (Personal)";
                                ObjAccounts."Group/Corporate Trade" := Rec."Group/Corporate Trade";
                                ObjAccounts."Name of the Group/Corporate" := Rec."Name of the Group/Corporate";
                                ObjAccounts."Certificate No" := Rec."Certificate No";
                                ObjAccounts."Registration Date" := Rec."Registration Date";
                                ObjAccounts."Created By" := USERID;

                                //=============================================================Joint Account Details
                                ObjAccounts."Name 2" := Rec."Name 2";

                                ObjAccounts."Postal Code 2" := Rec."Postal Code 2";
                                ObjAccounts."Home Postal Code2" := Rec."Home Postal Code2";
                                ObjAccounts."Home Town2" := Rec."Home Town2";
                                ObjAccounts."ID No.2" := Rec."ID No.2";
                                ObjAccounts."Passport 2" := Rec."Passport 2";

                                ObjAccounts.Gender2 := Rec.Gender2;
                                ObjAccounts."Marital Status2" := Rec."Marital Status2";
                                ObjAccounts."E-Mail (Personal2)" := Rec."E-Mail (Personal2)";
                                ObjAccounts."Employer Code2" := Rec."Employer Code2";
                                ObjAccounts."Employer Name2" := Rec."Employer Name2";
                                ObjAccounts."Picture 2" := Rec."Picture 2";
                                ObjAccounts."Signature  2" := Rec."Signature  2";
                                ObjAccounts."Member's Residence" := Rec."Member's Residence";
                                IF ObjCust."Account Category" = ObjCust."Account Category"::Joint THEN
                                    ObjAccounts."Joint Account Name" := Rec."First Name" + ' ' + Rec."First Name2";


                                ObjAccounts.name3 := Rec."Name 3";

                                ObjAccounts."Postal Code 3" := Rec."Postal Code 3";
                                ObjAccounts."Home Postal Code3" := Rec."Home Postal Code3";
                                ObjAccounts."Home Town3" := Rec."Home Town3";
                                ObjAccounts."ID No.3" := Rec."ID No.3";
                                ObjAccounts."Passport 3" := Rec."Passport 3";
                                ObjAccounts.Gender3 := Rec.Gender3;
                                ObjAccounts."Marital Status3" := Rec."Marital Status3";
                                ObjAccounts."E-Mail (Personal3)" := Rec."E-Mail (Personal3)";
                                ObjAccounts."Employer Code3" := Rec."Employer Code3";
                                ObjAccounts."Employer Name3" := Rec."Employer Name3";
                                ObjAccounts."Picture 3" := Rec."Picture 3";
                                ObjAccounts."Signature  3" := Rec."Signature  3";
                                ObjAccounts."Member Parish Name 3" := Rec."Member Parish Name 3";
                                ObjAccounts."Member Parish Name 3" := Rec."Member Parish Name 3";
                                IF ObjCust."Account Category" = ObjCust."Account Category"::Joint THEN
                                    ObjAccounts."Joint Account Name" := Rec."First Name" + ' &' + Rec."First Name2" + ' &' + Rec."First Name3" + 'JA';

                                //=============================================================End Joint Account Details
                                ObjAccounts.INSERT;


                                ObjAccounts.RESET;
                                IF ObjAccounts.GET(VarAcctNo) THEN BEGIN
                                    ObjAccounts.VALIDATE(ObjAccounts.Name);
                                    ObjAccounts.VALIDATE(ObjAccounts."Account Type");
                                    ObjAccounts.MODIFY;


                                    ObjMemberNoseries.RESET;
                                    ObjMemberNoseries.SETRANGE(ObjMemberNoseries."Account Type", ObjProductsApp.Product);
                                    ObjMemberNoseries.SETRANGE(ObjMemberNoseries."Branch Code", Rec."Global Dimension 2 Code");
                                    IF ObjMemberNoseries.FINDSET THEN BEGIN
                                        ObjMemberNoseries."Account No" := INCSTR(ObjMemberNoseries."Account No");
                                        ObjMemberNoseries.MODIFY;
                                    END;



                                    //Update BOSA with FOSA Account
                                    IF ObjCust.GET(VarBOSAACC) THEN BEGIN
                                        ObjCust."FOSA Account No." := VarAcctNo;
                                        ObjCust.MODIFY;
                                    END;
                                END;


                                ObjNextOfKinApp.RESET;
                                ObjNextOfKinApp.SETRANGE(ObjNextOfKinApp."Account No", Rec."No.");
                                IF ObjNextOfKinApp.FIND('-') THEN BEGIN
                                    REPEAT
                                        ObjNextofKinFOSA.INIT;
                                        ObjNextofKinFOSA."Account No" := VarAcctNo;
                                        ObjNextofKinFOSA.Name := ObjNextOfKinApp.Name;
                                        ObjNextofKinFOSA.Relationship := ObjNextOfKinApp.Relationship;
                                        ObjNextofKinFOSA.Beneficiary := ObjNextOfKinApp.Beneficiary;
                                        ObjNextofKinFOSA."Date of Birth" := ObjNextOfKinApp."Date of Birth";
                                        ObjNextofKinFOSA.Address := ObjNextOfKinApp.Address;
                                        ObjNextofKinFOSA.Telephone := ObjNextOfKinApp.Telephone;
                                        ObjNextofKinFOSA.Email := ObjNextOfKinApp.Email;
                                        ObjNextofKinFOSA."ID No." := ObjNextOfKinApp."ID No.";
                                        ObjNextofKinFOSA."%Allocation" := ObjNextOfKinApp."%Allocation";
                                        ObjNextofKinFOSA."Next Of Kin Type" := ObjNextOfKinApp."Next Of Kin Type";
                                        ObjNextofKinFOSA.INSERT;
                                    UNTIL ObjNextOfKinApp.NEXT = 0;
                                END;

                                //==================================================================================================Insert Account Agents
                                ObjMemberAppAgent.RESET;
                                ObjMemberAppAgent.SETRANGE(ObjMemberAppAgent."Account No", Rec."No.");
                                IF ObjMemberAppAgent.FIND('-') THEN BEGIN
                                    REPEAT
                                        ObjAccountAgents.INIT;
                                        ObjAccountAgents."Account No" := VarAcctNo;
                                        ObjAccountAgents.Names := ObjMemberAppAgent.Names;
                                        ObjAccountAgents."Date Of Birth" := ObjMemberAppAgent."Date Of Birth";
                                        ObjAccountAgents."Staff/Payroll" := ObjMemberAppAgent."Staff/Payroll";
                                        ObjAccountAgents."ID No." := ObjMemberAppAgent."ID No.";
                                        ObjAccountAgents."Allowed  Correspondence" := ObjMemberAppAgent."Allowed  Correspondence";
                                        ObjAccountAgents."Allowed Balance Enquiry" := ObjMemberAppAgent."Allowed Balance Enquiry";
                                        ObjAccountAgents."Allowed FOSA Withdrawals" := ObjMemberAppAgent."Allowed FOSA Withdrawals";
                                        ObjAccountAgents."Allowed Loan Processing" := ObjMemberAppAgent."Allowed Loan Processing";
                                        ObjAccountAgents."Must Sign" := ObjMemberAppAgent."Must Sign";
                                        ObjAccountAgents."Must be Present" := ObjMemberAppAgent."Must be Present";
                                        ObjAccountAgents."Expiry Date" := ObjMemberAppAgent."Expiry Date";
                                        ObjAccountAgents.INSERT;

                                    UNTIL ObjMemberAppAgent.NEXT = 0;
                                END;
                                //==================================================================================================End Insert Account Agents


                                ObjAccountSignApp.RESET;
                                ObjAccountSignApp.SETRANGE(ObjAccountSignApp."Account No", Rec."No.");
                                IF ObjAccountSignApp.FIND('-') THEN BEGIN
                                    REPEAT
                                        ObjAccountSign.INIT;
                                        ObjAccountSign."Account No" := VarAcctNo;
                                        ObjAccountSign.Names := ObjAccountSignApp.Names;
                                        ObjAccountSign."Date Of Birth" := ObjAccountSignApp."Date Of Birth";
                                        ObjAccountSign."Staff/Payroll" := ObjAccountSignApp."Staff/Payroll";
                                        ObjAccountSign."ID No." := ObjAccountSignApp."ID No.";
                                        ObjAccountSign.Signatory := ObjAccountSignApp.Signatory;
                                        ObjAccountSign."Must Sign" := ObjAccountSignApp."Must Sign";
                                        ObjAccountSign."Must be Present" := ObjAccountSignApp."Must be Present";
                                        ObjAccountSign.Picture := ObjAccountSignApp.Picture;
                                        ObjAccountSign.Signature := ObjAccountSignApp.Signature;
                                        ObjAccountSign."Expiry Date" := ObjAccountSignApp."Expiry Date";
                                        ObjAccountSign.INSERT;
                                    UNTIL ObjAccountSignApp.NEXT = 0;
                                END;
                                //END;
                                GenJournalLine.RESET;
                                GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
                                GenJournalLine.SETRANGE("Journal Batch Name", 'REGFee');
                                GenJournalLine.DELETEALL;

                                ObjGenSetUp.GET();

                                //Charge Registration Fee
                                IF ObjGenSetUp."Charge FOSA Registration Fee" = TRUE THEN BEGIN

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.INIT;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'REGFee';
                                    GenJournalLine."Document No." := Rec."No.";
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."Account Type"::Vendor;
                                    GenJournalLine."Account No." := VarAcctNo;
                                    GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := TODAY;
                                    GenJournalLine."External Document No." := 'REGFEE/' + FORMAT(Rec."Personal No");
                                    GenJournalLine.Description := 'Registration Fee';
                                    GenJournalLine.Amount := ObjGenSetUp."BOSA Registration Fee Amount";
                                    GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                                    GenJournalLine."Bal. Account No." := ObjGenSetUp."FOSA Registration Fee Account";
                                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                    IF GenJournalLine.Amount <> 0 THEN
                                        //GenJournalLine.INSERT;



                                        GenJournalLine.RESET;
                                    GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
                                    GenJournalLine.SETRANGE("Journal Batch Name", 'REGFee');
                                    IF GenJournalLine.FIND('-') THEN BEGIN
                                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Sacco21", GenJournalLine);
                                    END;
                                END;
                                MESSAGE('You have successfully created a %1 Product, A/C No=%2', ObjProductsApp.Product, VarAcctNo);

                            //End Charge Registration Fee
                            UNTIL ObjProductsApp.NEXT = 0;
                        END;
                        MESSAGE('You have successfully Registered a New Sacco Member. Membership No=%1.The Member will be notifed via an SMS', ObjCust."No.");
                        //==========================================================================================================End Front Office Accounts






                        ObjGenSetUp.GET();

                        //=====================================================================================================Send SMS
                        IF ObjGenSetUp."Send Membership Reg SMS" = TRUE THEN BEGIN
                            SFactory.FnSendSMS('MEMBERAPP', 'You member Registration has been completed.', VarBOSAACC, Rec."Mobile Phone No");
                        END;

                        //======================================================================================================Send Email
                        IF ObjGenSetUp."Send Membership Reg Email" = TRUE THEN BEGIN
                            //FnSendRegistrationEmail("No.", "E-Mail (Personal)", "ID No.");
                        END;

                        Rec.CALCFIELDS("Assigned No.");
                        FnRuninsertBOSAAccountNos(Rec."Assigned No.");
                        Rec.Created := true;
                        Rec.MODIFY;
                        CurrPage.close();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        UpdateControls();
        EnableCreateMember := false;
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        // CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Rec.Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
        if ((Rec.Status = Rec.status::Approved) and (Rec."Assigned No." = '')) then
            EnableCreateMember := true;
    end;

    trigger OnAfterGetRecord()
    begin
        /*Joint2DetailsVisible:=FALSE;
        Joint3DetailsVisible:=FALSE;
        
        //"Self Recruited":=TRUE;
        IF "Account Category"<>"Account Category"::Joint THEN BEGIN
        Joint2DetailsVisible:=FALSE;
        Joint3DetailsVisible:=FALSE;
        END ELSE
        Joint2DetailsVisible:=TRUE;
        Joint3DetailsVisible:=TRUE;*/
        StyleText := 'UnFavorable';
        ObjGenSetUp.Get;
        Rec."Monthly Contribution" := ObjGenSetUp."Min. Contribution";

        if Rec."Employment Info" = Rec."employment info"::Employed then begin
            EmployerCodeEditable := true;
            DepartmentEditable := true;
            TermsofEmploymentEditable := true;
            ContractingEditable := false;
            EmployedEditable := false;
            OccupationEditable := false;
            PositionHeldEditable := true;
            EmploymentDateEditable := true;
            EmployerAddressEditable := true


        end else
            if Rec."Employment Info" = Rec."employment info"::Contracting then begin
                ContractingEditable := true;
                EmployerCodeEditable := false;
                DepartmentEditable := false;
                TermsofEmploymentEditable := false;
                OccupationEditable := false;
                PositionHeldEditable := false;
                EmploymentDateEditable := false;
                EmployerAddressEditable := false
            end else
                if Rec."Employment Info" = Rec."employment info"::Others then begin
                    OthersEditable := true;
                    ContractingEditable := false;
                    EmployerCodeEditable := false;
                    DepartmentEditable := false;
                    TermsofEmploymentEditable := false;
                    OccupationEditable := false;
                    PositionHeldEditable := false;
                    EmploymentDateEditable := false;
                    EmployerAddressEditable := false
                end else
                    if Rec."Employment Info" = Rec."employment info"::"Self-Employed" then begin
                        OccupationEditable := true;
                        EmployerCodeEditable := false;
                        DepartmentEditable := false;
                        TermsofEmploymentEditable := false;
                        ContractingEditable := false;
                        EmployedEditable := false;
                        NatureofBussEditable := true;
                        IndustryEditable := true;
                        BusinessNameEditable := true;
                        PhysicalBussLocationEditable := true;
                        YearOfCommenceEditable := true;
                        PositionHeldEditable := false;
                        EmploymentDateEditable := false;
                        EmployerAddressEditable := false

                    end;




        if Rec."Identification Document" = Rec."identification document"::"Nation ID Card" then begin
            PassportEditable := false;
            IDNoEditable := true
        end else
            if Rec."Identification Document" = Rec."identification document"::"Passport Card" then begin
                PassportEditable := true;
                IDNoEditable := false
            end else
                if Rec."Identification Document" = Rec."identification document"::"Aliens Card" then begin
                    PassportEditable := true;
                    IDNoEditable := true;
                end;

        SetStyles();

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Responsibility Centre" := ObjUserMgt.GetSalesFilter;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        UserMgt: Codeunit "User Management";
    begin
        ObjGenSetUp.Get();
        Rec."Monthly Contribution" := ObjGenSetUp."Monthly Share Contributions";
        Rec."Customer Posting Group" := ObjGenSetUp."Default Customer Posting Group";
        Rec."Global Dimension 1 Code" := 'BOSA';

        //"Self Recruited":=TRUE;





        /*IF "Account Category"<>"Account Category"::Joint THEN BEGIN
        Joint2DetailsVisible:=FALSE;
        Joint3DetailsVisible:=FALSE;
        END ELSE
        Joint2DetailsVisible:=TRUE;
        Joint3DetailsVisible:=TRUE;*/

    end;

    trigger OnOpenPage()
    begin

        if ObjUserMgt.GetSalesFilter <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Responsibility Centre", ObjUserMgt.GetSalesFilter);
            Rec.FilterGroup(0);
        end;

        Joint2DetailsVisible := false;
        Joint3DetailsVisible := false;

        if Rec."Account Category" = Rec."account category"::Joint then begin
            Joint2DetailsVisible := true;
            Joint3DetailsVisible := true;
        end;
        if Rec."Account Category" = Rec."account category"::Single then begin
            Joint2DetailsVisible := false;
            Joint3DetailsVisible := false;
        end;


        if Rec."Employment Info" = Rec."employment info"::Employed then begin
            EmployerCodeEditable := true;
            DepartmentEditable := true;
            TermsofEmploymentEditable := true;
            ContractingEditable := false;
            EmployedEditable := false;
            OccupationEditable := false;
            PositionHeldEditable := true;
            EmploymentDateEditable := true;
            EmployerAddressEditable := true;
            NatureofBussEditable := false;
            IndustryEditable := false;
            BusinessNameEditable := false;
            PhysicalBussLocationEditable := false;
            YearOfCommenceEditable := false;



        end else
            if Rec."Employment Info" = Rec."employment info"::Contracting then begin
                ContractingEditable := true;
                EmployerCodeEditable := false;
                DepartmentEditable := false;
                TermsofEmploymentEditable := false;
                OccupationEditable := false;
                PositionHeldEditable := false;
                EmploymentDateEditable := false;
                EmployerAddressEditable := false;
                NatureofBussEditable := false;
                IndustryEditable := false;
                BusinessNameEditable := false;
                PhysicalBussLocationEditable := false;
                YearOfCommenceEditable := false;
            end else
                if Rec."Employment Info" = Rec."employment info"::Others then begin
                    OthersEditable := true;
                    ContractingEditable := false;
                    EmployerCodeEditable := false;
                    DepartmentEditable := false;
                    TermsofEmploymentEditable := false;
                    OccupationEditable := false;
                    PositionHeldEditable := false;
                    EmploymentDateEditable := false;
                    EmployerAddressEditable := false
                end else
                    if Rec."Employment Info" = Rec."employment info"::"Self-Employed" then begin
                        OccupationEditable := true;
                        EmployerCodeEditable := false;
                        DepartmentEditable := false;
                        TermsofEmploymentEditable := false;
                        ContractingEditable := false;
                        EmployedEditable := false;
                        NatureofBussEditable := true;
                        IndustryEditable := true;
                        BusinessNameEditable := true;
                        PhysicalBussLocationEditable := true;
                        YearOfCommenceEditable := true;
                        PositionHeldEditable := false;
                        EmploymentDateEditable := false;
                        EmployerAddressEditable := false

                    end;




        if Rec."Identification Document" = Rec."identification document"::"Nation ID Card" then begin
            PassportEditable := false;
            IDNoEditable := true
        end else
            if Rec."Identification Document" = Rec."identification document"::"Passport Card" then begin
                PassportEditable := true;
                IDNoEditable := false
            end else
                if Rec."Identification Document" = Rec."identification document"::"Aliens Card" then begin
                    PassportEditable := true;
                    IDNoEditable := true;
                end;
    end;

    var

        ApprovalsCodeUnit: Codeunit "Micropoint ApprovalsCodeUnit";

        RecordApproved: Boolean;

        CreateAccount: Boolean;
        StatusPermissions: Record "Status Change Permision";
        ObjCust: Record customer;
        ObjAccounts: Record Vendor;
        VarAcctNo: Code[20];
        ObjNextOfKinApp: Record "Member App Nominee";
        ObjAccountSign: Record "FOSA Account Sign. Details";
        ObjAccountSignApp: Record "Member Account Signatories";
        ObjAcc: Record Vendor;
        UsersID: Record User;
        ObjNok: Record "Member App Nominee";
        ObjNOKBOSA: Record "Members Next of Kin";
        VarBOSAACC: Code[20];
        ObjNextOfKin: Record "Members Next of Kin";
        VarPictureExists: Boolean;
        text001: label 'Status must be open';
        ObjUserMgt: Codeunit "User Setup Management";
        ObjNotificationE: Codeunit Mail;
        VarMailBody: Text[250];
        VarccEmail: Text[1000];
        VartoEmail: Text[1000];
        ObjGenSetUp: Record "Sacco General Set-Up";
        VarClearingAcctNo: Code[20];
        VarAdvrAcctNo: Code[20];
        ObjAccountTypes: Record "Account Types-Saving Products";
        VarDivAcctNo: Code[20];
        NameEditable: Boolean;
        AddressEditable: Boolean;
        NoEditable: Boolean;
        DioceseEditable: Boolean;
        HomeAdressEditable: Boolean;
        GlobalDim1Editable: Boolean;
        GlobalDim2Editable: Boolean;
        CustPostingGroupEdit: Boolean;
        PhoneEditable: Boolean;
        MaritalstatusEditable: Boolean;
        IDNoEditable: Boolean;
        RegistrationDateEdit: Boolean;
        OfficeBranchEditable: Boolean;
        DeptEditable: Boolean;
        SectionEditable: Boolean;
        OccupationEditable: Boolean;
        DesignationEdiatble: Boolean;
        EmployerCodeEditable: Boolean;
        EmployerNameEditable: Boolean;
        DepartmentEditable: Boolean;
        TermsofEmploymentEditable: Boolean;
        DOBEditable: Boolean;
        EmailEdiatble: Boolean;
        StaffNoEditable: Boolean;
        GenderEditable: Boolean;
        MonthlyContributionEdit: Boolean;
        PostCodeEditable: Boolean;
        CityEditable: Boolean;
        WitnessEditable: Boolean;
        StatusEditable: Boolean;
        BankCodeEditable: Boolean;
        BranchCodeEditable: Boolean;
        BankAccountNoEditable: Boolean;
        ProductEditable: Boolean;
        SecondaryMobileEditable: Boolean;
        AccountCategoryEditable: Boolean;
        OfficeTelephoneEditable: Boolean;
        OfficeExtensionEditable: Boolean;
        MemberParishEditable: Boolean;
        KnowDimkesEditable: Boolean;
        CountyEditable: Boolean;
        DistrictEditable: Boolean;
        LocationEditable: Boolean;
        SubLocationEditable: Boolean;
        EmploymentInfoEditable: Boolean;
        VillageResidence: Boolean;
        SignatureExists: Boolean;
        VarNewMembNo: Code[30];
        ObjSaccosetup: Record "Sacco No. Series";
        ObjNOkApp: Record "Member App Nominee";
        TitleEditable: Boolean;
        PostalCodeEditable: Boolean;
        HomeAddressPostalCodeEditable: Boolean;
        HomeTownEditable: Boolean;
        RecruitedEditable: Boolean;
        ContactPEditable: Boolean;
        ContactPRelationEditable: Boolean;
        ContactPOccupationEditable: Boolean;
        CopyOFIDEditable: Boolean;
        CopyofPassportEditable: Boolean;
        SpecimenEditable: Boolean;
        ContactPPhoneEditable: Boolean;
        PictureEditable: Boolean;
        SignatureEditable: Boolean;
        PayslipEditable: Boolean;
        RegistrationFeeEditable: Boolean;
        CopyofKRAPinEditable: Boolean;
        membertypeEditable: Boolean;
        FistnameEditable: Boolean;
        dateofbirth2: Boolean;
        registrationeditable: Boolean;
        EstablishdateEditable: Boolean;
        RegistrationofficeEditable: Boolean;
        Signature2Editable: Boolean;
        Picture2Editable: Boolean;
        MembApp: Record "Membership Applications";
        title2Editable: Boolean;
        mobile3editable: Boolean;
        emailaddresEditable: Boolean;
        gender2editable: Boolean;
        postal2Editable: Boolean;
        town2Editable: Boolean;
        passpoetEditable: Boolean;
        maritalstatus2Editable: Boolean;
        payrollno2editable: Boolean;
        Employercode2Editable: Boolean;
        address3Editable: Boolean;
        DateOfAppointmentEDitable: Boolean;
        TermsofServiceEditable: Boolean;
        HomePostalCode2Editable: Boolean;
        Employername2Editable: Boolean;
        ageEditable: Boolean;
        CopyofconstitutionEditable: Boolean;
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Account Opening";
        RecruitedByEditable: Boolean;
        RecruiterNameEditable: Boolean;
        RecruiterRelationShipEditable: Boolean;
        AccoutTypes: Record "Account Types-Saving Products";
        NomineeEditable: Boolean;
        TownEditable: Boolean;
        CountryEditable: Boolean;
        MobileEditable: Boolean;
        PassportEditable: Boolean;
        RejoiningDateEditable: Boolean;
        PrevousRegDateEditable: Boolean;
        AppCategoryEditable: Boolean;
        RegistrationDateEditable: Boolean;
        ObjDataSheet: Record "Data Sheet Main";
        ObjSMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        Cuat: Integer;
        EmployedEditable: Boolean;
        ContractingEditable: Boolean;
        OthersEditable: Boolean;
        Joint2DetailsVisible: Boolean;
        ObjProductsApp: Record "Membership Reg. Products Appli";
        ObjNextofKinFOSA: Record "FOSA Account NOK Details";
        ObjUsersRec: Record User;
        Joint3DetailsVisible: Boolean;
        CompInfo: Record "Company Information";
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        FirstNameEditable: Boolean;
        MiddleNameEditable: Boolean;
        LastNameEditable: Boolean;
        PayrollNoEditable: Boolean;
        MemberResidenceEditable: Boolean;
        ShareClassEditable: Boolean;
        KRAPinEditable: Boolean;
        //ObjViewLog: Record "View Log Entry";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery;
        WelcomeMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to RUAI ENDELEA Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your membership Application has been received and Undergoing Approval</p><p style="font-family:Verdana,Arial;font-size:9pt"> </b></p><br>Regards<p>%3</p><p><b>RUAI ENDELEA SACCO LTD</b></p>';
        RegistrationMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to RUAI ENDELEA Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your membership registration has been successfully processed</p><p style="font-family:Verdana,Arial;font-size:9pt">Your membership number is <b>%2</b></p><br>Regards<p>%3</p><p><b>RUAI ENDELEA SACCO LTD</b></p>';
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        EnableCreateMember: Boolean;
        SFactory: Codeunit "Micropoint Factory";
        NatureofBussEditable: Boolean;
        IndustryEditable: Boolean;
        BusinessNameEditable: Boolean;
        PhysicalBussLocationEditable: Boolean;
        YearOfCommenceEditable: Boolean;
        PositionHeldEditable: Boolean;
        EmploymentDateEditable: Boolean;
        EmployerAddressEditable: Boolean;
        EmailIndemnifiedEditable: Boolean;
        SendEStatementsEditable: Boolean;
        ObjAccountAppAgent: Record "Account Agents App Details";
        ObjAccountAgent: Record "Account Agent Details";
        ObjMemberAppAgent: Record "Member Agents App Details";
        ObjMemberAgent: Record "Member Agent Details";
        IdentificationDocTypeEditable: Boolean;
        PhysicalAddressEditable: Boolean;
        RefereeEditable: Boolean;
        MonthlyIncomeEditable: Boolean;
        ObjAccountAgents: Record "Account Agent Details";
        ObjMembers: Record customer;
        ObjBOSAAccount: Record "BOSA Accounts No Buffer";
        StyleText: Text[20];
        CoveragePercentStyle: Text;
        ObjMemberNoseries: Record "Member Accounts No Series";
        VarAccountTypes: Text[1000];
        VarAccountDescription: Text[1000];
        ObjAccountType: Record "Account Types-Saving Products";
        VarMemberName: Text[100];
        MicropointFactory: Codeunit "Micropoint Factory";
        VarEmailSubject: Text;
        VarEmailBody: Text;
        VarTextExtension: Text;
        VarTextExtensionII: Text;



    procedure UpdateControls()
    begin

        if Rec.Status = Rec.Status::Approved then begin
            NameEditable := false;
            NoEditable := false;
            AddressEditable := false;
            GlobalDim1Editable := false;
            GlobalDim2Editable := false;
            CustPostingGroupEdit := false;
            PhoneEditable := false;
            MaritalstatusEditable := false;
            IDNoEditable := false;
            PhoneEditable := false;
            RegistrationDateEdit := false;
            OfficeBranchEditable := false;
            DeptEditable := false;
            SectionEditable := false;
            OccupationEditable := false;
            DesignationEdiatble := false;
            EmployerCodeEditable := false;
            DOBEditable := false;
            EmailEdiatble := false;
            StaffNoEditable := false;
            GenderEditable := false;
            MonthlyContributionEdit := false;
            PostCodeEditable := false;
            CityEditable := false;
            WitnessEditable := false;
            BankCodeEditable := false;
            BranchCodeEditable := false;
            BankAccountNoEditable := false;
            VillageResidence := false;
            TitleEditable := false;
            PostalCodeEditable := false;
            HomeAddressPostalCodeEditable := false;
            HomeTownEditable := false;
            RecruitedEditable := false;
            ContactPEditable := false;
            ContactPRelationEditable := false;
            ContactPOccupationEditable := false;
            CopyOFIDEditable := false;
            CopyofPassportEditable := false;
            SpecimenEditable := false;
            ContactPPhoneEditable := false;
            HomeAdressEditable := false;
            PictureEditable := false;
            SignatureEditable := false;
            PayslipEditable := false;
            RegistrationFeeEditable := false;
            title2Editable := false;
            emailaddresEditable := false;
            gender2editable := false;
            HomePostalCode2Editable := false;
            town2Editable := false;
            passpoetEditable := false;
            maritalstatus2Editable := false;
            payrollno2editable := false;
            Employercode2Editable := false;
            address3Editable := false;
            Employername2Editable := false;
            ageEditable := false;
            CopyofconstitutionEditable := false;
            NomineeEditable := false;
            TownEditable := false;
            CountryEditable := false;
            MobileEditable := false;
            PassportEditable := false;
            RejoiningDateEditable := false;
            PrevousRegDateEditable := false;
            AppCategoryEditable := false;
            RegistrationDateEditable := false;
            TermsofServiceEditable := false;
            ProductEditable := false;
            SecondaryMobileEditable := false;
            AccountCategoryEditable := false;
            OfficeTelephoneEditable := false;
            OfficeExtensionEditable := false;
            CountyEditable := false;
            DistrictEditable := false;
            LocationEditable := false;
            SubLocationEditable := false;
            EmploymentInfoEditable := false;
            MemberParishEditable := false;
            KnowDimkesEditable := false;
            EmployerCodeEditable := false;
            DepartmentEditable := false;
            TermsofEmploymentEditable := false;
            FirstNameEditable := false;
            MiddleNameEditable := false;
            LastNameEditable := false;
            PayrollNoEditable := false;
            MemberResidenceEditable := false;
            ShareClassEditable := false;
            KRAPinEditable := false;
            RecruitedByEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;
            NatureofBussEditable := false;
            IndustryEditable := false;
            BusinessNameEditable := false;
            PhysicalBussLocationEditable := false;
            YearOfCommenceEditable := false;
            PositionHeldEditable := false;
            EmploymentDateEditable := false;
            EmployerAddressEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;
            IdentificationDocTypeEditable := false;
            PhysicalAddressEditable := false;
            RefereeEditable := false;
            MonthlyIncomeEditable := false;
        end;

        if Rec.Status = Rec.Status::"Pending Approval" then begin
            NameEditable := false;
            NoEditable := false;
            AddressEditable := false;
            GlobalDim1Editable := false;
            GlobalDim2Editable := false;
            CustPostingGroupEdit := false;
            PhoneEditable := false;
            MaritalstatusEditable := false;
            IDNoEditable := false;
            PhoneEditable := false;
            RegistrationDateEdit := false;
            OfficeBranchEditable := false;
            DeptEditable := false;
            SectionEditable := false;
            OccupationEditable := false;
            DesignationEdiatble := false;
            EmployerCodeEditable := false;
            DOBEditable := false;
            EmailEdiatble := false;
            StaffNoEditable := false;
            GenderEditable := false;
            MonthlyContributionEdit := false;
            PostCodeEditable := false;
            CityEditable := false;
            WitnessEditable := false;
            BankCodeEditable := false;
            BranchCodeEditable := false;
            BankAccountNoEditable := false;
            VillageResidence := false;
            TitleEditable := false;
            PostalCodeEditable := false;
            HomeAddressPostalCodeEditable := false;
            HomeTownEditable := false;
            RecruitedEditable := false;
            ContactPEditable := false;
            ContactPRelationEditable := false;
            ContactPOccupationEditable := false;
            CopyOFIDEditable := false;
            CopyofPassportEditable := false;
            SpecimenEditable := false;
            ContactPPhoneEditable := false;
            HomeAdressEditable := false;
            PictureEditable := false;
            SignatureEditable := false;
            PayslipEditable := false;
            RegistrationFeeEditable := false;
            title2Editable := false;
            emailaddresEditable := false;
            gender2editable := false;
            HomePostalCode2Editable := false;
            town2Editable := false;
            passpoetEditable := false;
            maritalstatus2Editable := false;
            payrollno2editable := false;
            Employercode2Editable := false;
            address3Editable := false;
            Employername2Editable := false;
            ageEditable := false;
            CopyofconstitutionEditable := false;
            NomineeEditable := false;
            TownEditable := false;
            CountryEditable := false;
            MobileEditable := false;
            PassportEditable := false;
            RejoiningDateEditable := false;
            PrevousRegDateEditable := false;
            AppCategoryEditable := false;
            RegistrationDateEditable := false;
            TermsofServiceEditable := false;
            ProductEditable := false;
            SecondaryMobileEditable := false;
            AccountCategoryEditable := false;
            OfficeTelephoneEditable := false;
            OfficeExtensionEditable := false;
            CountyEditable := false;
            DistrictEditable := false;
            LocationEditable := false;
            SubLocationEditable := false;
            EmploymentInfoEditable := false;
            MemberParishEditable := false;
            KnowDimkesEditable := false;
            EmployerCodeEditable := false;
            DepartmentEditable := false;
            TermsofEmploymentEditable := false;
            FirstNameEditable := false;
            MiddleNameEditable := false;
            LastNameEditable := false;
            PayrollNoEditable := false;
            MemberResidenceEditable := false;
            ShareClassEditable := false;
            KRAPinEditable := false;
            RecruitedByEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;
            NatureofBussEditable := false;
            IndustryEditable := false;
            BusinessNameEditable := false;
            PhysicalBussLocationEditable := false;
            YearOfCommenceEditable := false;
            PositionHeldEditable := false;
            EmploymentDateEditable := false;
            EmployerAddressEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;
            IdentificationDocTypeEditable := false;
            PhysicalAddressEditable := false;
            RefereeEditable := false;
            MonthlyIncomeEditable := false;
        end;


        if Rec.Status = Rec.Status::Open then begin
            NameEditable := true;
            AddressEditable := true;
            GlobalDim1Editable := true;
            GlobalDim2Editable := true;
            CustPostingGroupEdit := true;
            PhoneEditable := true;
            MaritalstatusEditable := true;
            IDNoEditable := true;
            PhoneEditable := true;
            RegistrationDateEdit := true;
            OfficeBranchEditable := true;
            DeptEditable := true;
            SectionEditable := true;
            OccupationEditable := true;
            DesignationEdiatble := true;
            EmployerCodeEditable := true;
            DOBEditable := true;
            EmailEdiatble := true;
            StaffNoEditable := true;
            GenderEditable := true;
            MonthlyContributionEdit := true;
            PostCodeEditable := true;
            CityEditable := true;
            WitnessEditable := true;
            BankCodeEditable := true;
            BranchCodeEditable := true;
            BankAccountNoEditable := true;
            VillageResidence := true;
            TitleEditable := true;
            PostalCodeEditable := true;
            HomeAddressPostalCodeEditable := true;
            HomeTownEditable := true;
            RecruitedEditable := true;
            ContactPEditable := true;
            ContactPRelationEditable := true;
            ContactPOccupationEditable := true;
            CopyOFIDEditable := true;
            CopyofPassportEditable := true;
            SpecimenEditable := true;
            ContactPPhoneEditable := true;
            HomeAdressEditable := true;
            PictureEditable := true;
            SignatureEditable := true;
            PayslipEditable := true;
            RegistrationFeeEditable := true;
            title2Editable := true;
            emailaddresEditable := true;
            gender2editable := true;
            HomePostalCode2Editable := true;
            town2Editable := true;
            passpoetEditable := true;
            maritalstatus2Editable := true;
            payrollno2editable := true;
            Employercode2Editable := true;
            address3Editable := true;
            Employername2Editable := true;
            ageEditable := true;
            mobile3editable := true;
            CopyofconstitutionEditable := true;
            NomineeEditable := true;
            TownEditable := true;
            CountryEditable := true;
            MobileEditable := true;
            PassportEditable := true;
            RejoiningDateEditable := true;
            PrevousRegDateEditable := true;
            AppCategoryEditable := true;
            RegistrationDateEditable := true;
            TermsofServiceEditable := true;
            ProductEditable := true;
            SecondaryMobileEditable := true;
            AccountCategoryEditable := true;
            OfficeTelephoneEditable := true;
            OfficeExtensionEditable := true;
            CountyEditable := true;
            DistrictEditable := true;
            LocationEditable := true;
            SubLocationEditable := true;
            EmploymentInfoEditable := true;
            MemberParishEditable := true;
            KnowDimkesEditable := true;
            EmployerCodeEditable := true;
            DepartmentEditable := true;
            TermsofEmploymentEditable := true;
            FirstNameEditable := true;
            MiddleNameEditable := true;
            LastNameEditable := true;
            PayrollNoEditable := true;
            MemberResidenceEditable := true;
            ShareClassEditable := true;
            KRAPinEditable := true;
            RecruitedByEditable := true;
            EmailIndemnifiedEditable := true;
            SendEStatementsEditable := true;
            NatureofBussEditable := true;
            IndustryEditable := true;
            BusinessNameEditable := true;
            PhysicalBussLocationEditable := true;
            YearOfCommenceEditable := true;
            PositionHeldEditable := true;
            EmploymentDateEditable := true;
            EmployerAddressEditable := true;
            EmailIndemnifiedEditable := true;
            SendEStatementsEditable := true;
            IdentificationDocTypeEditable := true;
            PhysicalAddressEditable := true;
            RefereeEditable := true;
            MonthlyIncomeEditable := true;
        end
    end;

    local procedure SelfRecruitedControl()
    begin
        /*
            IF "Self Recruited"=TRUE THEN BEGIN
             RecruitedByEditable:=FALSE;
             RecruiterNameEditable:=FALSE;
             RecruiterRelationShipEditable:=FALSE;
             END ELSE
            IF "Self Recruited"<>TRUE THEN BEGIN
             RecruitedByEditable:=TRUE;
             RecruiterNameEditable:=TRUE;
             RecruiterRelationShipEditable:=TRUE;
             END;
             */

    end;


    procedure FnSendReceivedApplicationSMS()
    begin

        ObjGenSetUp.Get;
        CompInfo.Get;



        //SMS MESSAGE
        ObjSMSMessage.Reset;
        if ObjSMSMessage.Find('+') then begin
            iEntryNo := ObjSMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        ObjSMSMessage.Init;
        ObjSMSMessage."Entry No" := iEntryNo;
        ObjSMSMessage."Batch No" := Rec."No.";
        ObjSMSMessage."Document No" := '';
        ObjSMSMessage."Account No" := VarBOSAACC;
        ObjSMSMessage."Date Entered" := Today;
        ObjSMSMessage."Time Entered" := Time;
        ObjSMSMessage.Source := 'MEMBAPP';
        ObjSMSMessage."Entered By" := UserId;
        ObjSMSMessage."Sent To Server" := ObjSMSMessage."sent to server"::No;
        ObjSMSMessage."SMS Message" := 'Dear Member your application has been received and going through approval,'
        + ' ' + CompInfo.Name + ' ' + ObjGenSetUp."Customer Care No";
        ObjSMSMessage."Telephone No" := Rec."Mobile Phone No";
        if Rec."Mobile Phone No" <> '' then
            ObjSMSMessage.Insert;
    end;


    procedure FnSendRegistrationSMS()
    begin

        ObjGenSetUp.Get;
        CompInfo.Get;



        //SMS MESSAGE
        ObjSMSMessage.Reset;
        if ObjSMSMessage.Find('+') then begin
            iEntryNo := ObjSMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        ObjSMSMessage.Init;
        ObjSMSMessage."Entry No" := iEntryNo;
        ObjSMSMessage."Batch No" := Rec."No.";
        ObjSMSMessage."Document No" := '';
        ObjSMSMessage."Account No" := VarBOSAACC;
        ObjSMSMessage."Date Entered" := Today;
        ObjSMSMessage."Time Entered" := Time;
        ObjSMSMessage.Source := 'MEMBREG';
        ObjSMSMessage."Entered By" := UserId;
        ObjSMSMessage."Sent To Server" := ObjSMSMessage."sent to server"::No;
        ObjSMSMessage."SMS Message" := 'Dear Member you have been registered successfully, your Membership No is '
        + VarBOSAACC + ' Name ' + Rec.Name + ' ' + CompInfo.Name + ' ' + ObjGenSetUp."Customer Care No";
        ObjSMSMessage."Telephone No" := Rec."Mobile Phone No";
        if Rec."Mobile Phone No" <> '' then
            ObjSMSMessage.Insert;
    end;

    // local procedure UpdateViewLogEntries()
    // begin
    //     ObjViewLog.Init;
    //     ObjViewLog."Entry No." := ObjViewLog."Entry No." + 1;
    //     ObjViewLog."User ID" := UserId;
    //     ObjViewLog."Table No." := 50364;
    //     ObjViewLog."Table Caption" := 'Members Register';
    //     ObjViewLog.Date := Today;
    //     ObjViewLog.Time := Time;
    // end;

    local procedure FnCheckfieldrestriction()
    begin
        if (Rec."Account Category" = Rec."account category"::Single) then begin
            //CALCFIELDS(Picture,Signature);
            Rec.TestField(Name);
            Rec.TestField("ID No.");
            Rec.TestField("Mobile Phone No");
            //TESTFIELD("Employer Code");
            //TESTFIELD("Personal No");
            Rec.TestField("Monthly Contribution");
            Rec.TestField("Member's Residence");
            Rec.TestField(Gender);
            Rec.TestField("Employment Info");
            Rec.TestField("Address 2");

            //TESTFIELD("Copy of Current Payslip");
            //TESTFIELD("Member Registration Fee Receiv");
            Rec.TestField("Customer Posting Group");
            Rec.TestField("Global Dimension 1 Code");
            //TESTFIELD("Global Dimension 2 Code");
            //TESTFIELD("Contact Person");
            //TESTFIELD("Contact Person Phone");
            //IF Picture=0 OR Signature=0 THEN
            //ERROR(Insert )
        end else

            if (Rec."Account Category" = Rec."account category"::Group) or (Rec."Account Category" = Rec."account category"::Corporate) then begin
                Rec.TestField(Name);
                Rec.TestField("Registration No");
                Rec.TestField("Copy of KRA Pin");
                Rec.TestField("Member Registration Fee Receiv");
                ///TESTFIELD("Account Category");
                Rec.TestField("Customer Posting Group");
                Rec.TestField("Global Dimension 1 Code");
                Rec.TestField("Global Dimension 2 Code");
                //TESTFIELD("Copy of constitution");
                Rec.TestField("Contact Person");
                Rec.TestField("Contact Person Phone");

            end;
    end;

    // local procedure FnSendReceivedApplicationEmail(ApplicationNo: Code[20]; Email: Text[50]; IDNo: Code[20])
    // var
    //     Memb: Record "Membership Applications";
    //     SMTPMail: Codeunit UnknownCodeunit400;
    //     SMTPSetup: Record "SMTP Mail Setup";
    //     FileName: Text[100];
    //     Attachment: Text[250];
    //     CompanyInfo: Record "Company Information";
    // begin
    //     SMTPSetup.Get();

    //     Memb.Reset;
    //     Memb.SetRange(Memb."No.", ApplicationNo);
    //     Memb.SetFilter(Memb."E-Mail (Personal)", '<>%1', '');
    //     if Memb.Find('-') then begin
    //         if Email = '' then begin
    //             Error('Email Address Missing for Member Application number' + '-' + Memb."No.");
    //         end;
    //         if Memb."E-Mail (Personal)" <> '' then
    //             SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address", Email, 'Membership Application', '', true);
    //         SMTPMail.AppendBody(StrSubstNo(WelcomeMessage, Memb.Name, IDNo, UserId));
    //         SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
    //         SMTPMail.AppendBody('<br><br>');
    //         SMTPMail.AddAttachment(FileName, Attachment);
    //         SMTPMail.Send;
    //     end;




    // end;

    // local procedure FnSendRegistrationEmail(ApplicationNo: Code[20]; Email: Text[50]; IDNo: Code[20])
    // var
    //     Memb: Record "Membership Applications";
    //     SMTPMail: Codeunit UnknownCodeunit400;
    //     SMTPSetup: Record "SMTP Mail Setup";
    //     FileName: Text[100];
    //     Attachment: Text[250];
    //     CompanyInfo: Record "Company Information";
    // begin
    //     SMTPSetup.Get();

    //     VarAccountDescription := '';
    //     VarAccountTypes := '';

    //     ObjAccounts.Reset;
    //     ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarBOSAACC);
    //     if ObjAccounts.FindSet then begin
    //         repeat

    //             if ObjAccountType.Get(ObjAccounts."Account Type") then begin
    //                 VarAccountDescription := ObjAccountType.Description;
    //             end;

    //             VarAccountTypes := VarAccountTypes + '<br> - ' + Format(ObjAccounts."No.") + ' - ' + Format(VarAccountDescription);
    //         until ObjAccounts.Next = 0;
    //     end;


    //     VarMemberName := MicropointFactory.FnConvertTexttoBeginingWordstostartWithCapital(Name);
    //     VarTextExtension := '<p>At RUAI ENDELEA Sacco, we provide you with a variety of efficient and convenient services that enable you to:</p>' +
    //            '<p>1. Make Automated Deposit to your account through any Equity Bank Branch to our Account No. 1550262333007 and any Family Bank Branch via Utility Payment. You will provide your RUAI ENDELEA Sacco 12-digit Account Number.</p>' +
    //            '<p>2. Make Automated Deposits through MPESA or Equitel/Equity Bank Agents using our Paybill No. 521000 and through Family Bank Agents using Bill Payment Code 020, then provide your Account Number and Amount.</p>' +
    //            '<p>3. Transact through our Mobile Banking Channels to Apply for Loans, MPESA Withdrawal, Account Transfers, Account Enquiries, Statement Requests etc. You can download RUAI ENDELEA Sacco Mobile App on Google Play Store</p>';

    //     VarTextExtensionII := '<p>5. Access funds via Cardless ATM Withdrawal Service with Family Bank accessible to all our registered Mobile Banking Users. For guidelines send the word CARDLESS to 0705270662 or use our Mobile App.</p>' +
    //            '<p>6. Apply for a Cheque Book and initiate cheque payments from your account at RUAI ENDELEA Sacco.</p>' +
    //            '<p>7. Process your salary to your RUAI ENDELEA Sacco Account and benefit from very affordable salary loans.</p>' +
    //            '<p>8. Operate an Ufalme Account and save in order to acquire Land/Housing in our upcoming projects.</p>' +
    //            '<p>Visit our website <a href="http://www.RUAI ENDELEAsacco.com">www.RUAI ENDELEAsacco.com</a> for more information on our service offering.</p>' +
    //            '<p>Thank you for choosing RUAI ENDELEA Sacco. Our objective is to empower you economically and socially by promoting a Savings and Investments culture and providing affordable credit.</p>';


    //     VarEmailSubject := 'WELCOME TO RUAI ENDELEA SACCO';
    //     VarEmailBody := 'Welcome and Thank you for Joining RUAI ENDELEA Sacco. Your Membership Number is ' + VarBOSAACC + '. Your Account Numbers are: ' + VarAccountTypes + VarTextExtension + VarTextExtensionII;

    //     MicropointFactory.FnSendStatementViaMail(VarMemberName, VarEmailSubject, VarEmailBody, "E-Mail (Personal)", '', '');
    // end;

    local procedure FnUpdateMemberSubAccounts()
    begin


    end;

    local procedure SetStyles()
    begin
        CoveragePercentStyle := 'Strong';
        if Rec."Member Risk Level" <> Rec."member risk level"::"Low Risk" then
            CoveragePercentStyle := 'Unfavorable';
        if Rec."Member Risk Level" = Rec."member risk level"::"Low Risk" then
            CoveragePercentStyle := 'Favorable';
    end;

    local procedure FnRuninsertBOSAAccountNos(VarMemberNo: Code[30])
    begin

        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarMemberNo);
        ObjAccounts.SetRange(ObjAccounts."Account Type", '601');
        ObjAccounts.SetRange(ObjAccounts.Status, ObjAccounts.Status::Active);
        if ObjAccounts.FindSet then begin
            if ObjCust.Get(VarMemberNo) then begin
                ObjCust."Share Capital No" := ObjAccounts."No.";
                ObjCust.Modify;
            end;
        end;

        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarMemberNo);
        ObjAccounts.SetFilter(ObjAccounts."Account Type", '=%1|%2', '602', '603');
        ObjAccounts.SetRange(ObjAccounts.Status, ObjAccounts.Status::Active);
        if ObjAccounts.FindSet then begin
            if ObjCust.Get(VarMemberNo) then begin
                ObjCust."Deposits Account No" := ObjAccounts."No.";
                ObjCust.Modify;
            end;
        end;

        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarMemberNo);
        ObjAccounts.SetFilter(ObjAccounts."Account Type", '=%1', '606');
        ObjAccounts.SetRange(ObjAccounts.Status, ObjAccounts.Status::Active);
        if ObjAccounts.FindSet then begin
            if ObjCust.Get(VarMemberNo) then begin
                ObjCust."Benevolent Fund No" := ObjAccounts."No.";
                ObjCust.Modify;
            end;
        end;


        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarMemberNo);
        ObjAccounts.SetFilter(ObjAccounts."Account Type", '=%1', '605');
        ObjAccounts.SetRange(ObjAccounts.Status, ObjAccounts.Status::Active);
        if ObjAccounts.FindSet then begin
            if ObjCust.Get(VarMemberNo) then begin
                ObjCust."FOSA Shares Account No" := ObjAccounts."No.";
                ObjCust.Modify;
            end;
        end;
    end;

    local procedure FnGetFosaAccountTypeNumber(ProductCode: Code[40]; Dimension2: Code[10]; BOSAAC: code[40]): Code[20]
    var
        SavingsAccountTypes: Record "Account Types-Saving Products";
    begin
        SavingsAccountTypes.Reset();
        SavingsAccountTypes.SetRange(SavingsAccountTypes.Code, ProductCode);
        if SavingsAccountTypes.find('-') then begin
            exit(format(SavingsAccountTypes."Account No Prefix" + Rec."Global Dimension 2 Code" + BOSAAC));
        end;
    end;
}

