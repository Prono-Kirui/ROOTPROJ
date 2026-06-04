#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50367 "Member Account Card"
{
    PageType = Card;
    Caption = 'Member Card';
    DeleteAllowed = false;
    Editable = false;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = customer;

    layout
    {
        area(content)
        {
            group("General Info")
            {
                Caption = 'General Info';
                Editable = true;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No.';
                    Editable = false;
                }

                field("Account Category"; Rec."Account Category")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Joint Account Name"; Rec."Joint Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }

                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Name';
                    Editable = false;
                }

                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Personal No"; Rec."Personal No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll No.';
                    Editable = false;
                }

                field("Account No."; Rec."FOSA Account No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Current Account';
                    Editable = false;

                    trigger OnValidate()
                    begin
                        FosaName := '';

                        if Rec."FOSA Account No." <> '' then begin
                            if Vend.Get(Rec."FOSA Account No.") then begin
                                FosaName := Vend.Name;
                            end;
                        end;
                    end;
                }

                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Code/City';
                    Editable = false;
                }

                field(City; Rec.City)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Pension No"; Rec."Pension No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Member Category"; Rec."Member Category")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Identification Document"; Rec."Identification Document")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID Number';
                    Editable = false;
                }

                field("Passport No."; Rec."Passport No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field(Pin; Rec.Pin)
                {
                    ApplicationArea = Basic;
                    Caption = 'KRA Pn';
                    Editable = false;
                    ShowMandatory = true;
                }

                field(txtMarital; Rec."Marital Status")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                    Editable = false;
                    Visible = txtMaritalVisible;
                }

                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field(Disabled; Rec.Disabled)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field(rejoined; Rec.rejoined)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reactivated';
                    Editable = false;
                }

                field("Rejoining Date"; Rec."Rejoining Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Reactivation Date';
                    Editable = false;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        StatusPermissions.Reset;
                        StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                        StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Overide Defaulters");
                        if StatusPermissions.Find('-') = false then
                            Error('You do not have permissions to change the account status.');
                    end;
                }

                // field(Picture; Rec.Picture)
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                // }

                field(Signature; Rec.Signature)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Last Payment Date"; Rec."Last Payment Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Action On Dividend Earned"; Rec."Action On Dividend Earned")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
                }

                field("Member House Group"; Rec."Member House Group")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Housel Group';
                    Editable = false;
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

                field("No of House Group Changes"; Rec."No of House Group Changes")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("House Group Status"; Rec."House Group Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Insider Status"; Rec."Insider Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }


            group("Employment Info")
            {
                Caption = 'Employment Info';
                field(Control1000000128; Rec."Employment Info")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin

                    end;
                }

                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowMandatory = true;
                }

                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Employer Address"; Rec."Employer Address")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic;
                    Caption = 'WorkStation / Depot';
                    Editable = false;
                }

                field("Terms Of Employment"; Rec."Terms Of Employment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowMandatory = true;
                }

                field("Date of Employment"; Rec."Date of Employment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Position Held"; Rec."Position Held")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Expected Monthly Income"; Rec."Expected Monthly Income")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Monthly TurnOver_Actual"; Rec."Monthly TurnOver_Actual")
                {
                    ApplicationArea = Basic;
                    Caption = 'Monthly TurnOver_Actual';
                }

                field("Nature Of Business"; Rec."Nature Of Business")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field(Industry; Rec.Industry)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Business Name"; Rec."Business Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Physical Business Location"; Rec."Physical Business Location")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Year of Commence"; Rec."Year of Commence")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field(Occupation; Rec.Occupation)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Others Details"; Rec."Others Details")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Referee Details")
            {
                field("Referee Member No"; Rec."Referee Member No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Referee Name"; Rec."Referee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Referee ID No"; Rec."Referee ID No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Referee Mobile Phone No"; Rec."Referee Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("MemberRiskRating1")
            {
                caption = 'Member Risk Rating';
                Editable = false;
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
                    Editable = false;
                    //Image = Person;
                    StyleExpr = CoveragePercentStyle;
                }

                field("Due Diligence Measure"; Rec."Due Diligence Measure")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    // Image = Person;
                    StyleExpr = CoveragePercentStyle;
                }
            }
            // part(Control39; "Member Due Diligence Measure")
            // {
            //     Caption = 'Due Diligence Measure';
            //     SubPageLink = "Member No" = field("No.");
            //     SubPageView = sorting("Due Diligence No");
            // }

            group(Joint2Details)
            {
                Caption = 'Joint2Details';
                Visible = Joint2DetailsVisible;
                field("Name 2"; Rec."Name 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                    Editable = false;
                }
                field(Address3; Rec.Address3)
                {
                    ApplicationArea = Basic;
                    Caption = 'Address';
                    Editable = false;
                }
                field("Postal Code 2"; Rec."Postal Code 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Postal Code';
                    Editable = false;
                }
                field("Town 2"; Rec."Town 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Town';
                    Editable = false;
                }
                field("Mobile No. Three"; Rec."Mobile No. Three")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Date of Birth2"; Rec."Date of Birth2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                    Editable = false;
                }
                field("ID No.2"; Rec."ID No.2")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No.';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Passport 2"; Rec."Passport 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Passport No.';
                    Editable = false;
                }
                field("Member Parish 2"; Rec."Member Parish 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Parish';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Member Parish Name 2"; Rec."Member Parish Name 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Parish Name';
                    Editable = false;
                }
                field(Gender2; Rec.Gender2)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                    Editable = false;
                }
                field("Marital Status2"; Rec."Marital Status2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                    Editable = false;
                }
                field("Home Postal Code2"; Rec."Home Postal Code2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Postal Code';
                    Editable = false;
                }
                field("Home Town2"; Rec."Home Town2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Town';
                    Editable = false;
                }
                field("Employer Code2"; Rec."Employer Code2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Code';
                    Editable = false;
                }
                field("Employer Name2"; Rec."Employer Name2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Name';
                    Editable = false;
                }
                field("E-Mail (Personal2)"; Rec."E-Mail (Personal2)")
                {
                    ApplicationArea = Basic;
                    Caption = 'E-Mail (Personal)';
                    Editable = false;
                }
                field("Picture 2"; Rec."Picture 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Picture';
                    Editable = false;
                }
                field("Signature  2"; Rec."Signature  2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signature';
                    Editable = false;
                }
            }
            group(Joint3Details)
            {
                Visible = Joint3DetailsVisible;
                field("Name 3"; Rec."Name 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                    Editable = false;
                }
                field(Address4; Rec.Address4)
                {
                    ApplicationArea = Basic;
                    Caption = 'Address';
                    Editable = false;
                }
                field("Postal Code 3"; Rec."Postal Code 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Postal Code';
                    Editable = false;
                }
                field("Town 3"; Rec."Town 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Town';
                    Editable = false;
                }
                field("Mobile No. 4"; Rec."Mobile No. 4")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Date of Birth3"; Rec."Date of Birth3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("ID No.3"; Rec."ID No.3")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No.';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Passport 3"; Rec."Passport 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Passport No.';
                    Editable = false;
                }
                field("Member Parish 3"; Rec."Member Parish 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Parish';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Member Parish Name 3"; Rec."Member Parish Name 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Parish Name';
                    Editable = false;
                }
                field(Gender3; Rec.Gender3)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                    Editable = false;
                }
                field("Marital Status3"; Rec."Marital Status3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                    Editable = false;
                }
                field("Home Postal Code3"; Rec."Home Postal Code3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Postal Code';
                    Editable = false;
                }
                field("Home Town3"; Rec."Home Town3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Town';
                    Editable = false;
                }
                field("Employer Code3"; Rec."Employer Code3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Code';
                    Editable = false;
                }
                field("Employer Name3"; Rec."Employer Name3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Name';
                    Editable = false;
                }
                field("E-Mail (Personal3)"; Rec."E-Mail (Personal3)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Picture 3"; Rec."Picture 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Picture';
                    Editable = false;
                }
                field("Signature  3"; Rec."Signature  3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signature';
                    Editable = false;
                }
            }
            group("Contact Info")
            {
                Caption = 'Contact Info';
                Editable = true;
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Email Indemnified"; Rec."Email Indemnified")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Send E-Statements"; Rec."Send E-Statements")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Home Page"; Rec."Home Page")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Home Address"; Rec."Home Address")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Home Postal Code"; Rec."Home Postal Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(District; Rec.District)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sub-Location"; Rec."Sub-Location")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Village/Residence"; Rec."Village/Residence")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Contact Person"; Rec."Contact Person")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Contact Person Phone"; Rec."Contact Person Phone")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("File Movement Tracker")
            {
                Caption = 'File Movement Tracker';
                field(Filelocc; Rec.Filelocc)
                {
                    ApplicationArea = Basic;
                    Caption = 'Current File Location';
                    Editable = false;
                }
                field("Loc Description"; Rec."Loc Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Move to"; Rec."Move to")
                {
                    ApplicationArea = Basic;
                    Caption = 'Dispatch to:';
                }
                field("Move to description"; Rec."Move to description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(User; Rec.User)
                {
                    ApplicationArea = Basic;
                }
                field("Folio Number"; Rec."Folio Number")
                {
                    ApplicationArea = Basic;
                }
                field("File Movement Remarks"; Rec."File Movement Remarks")
                {
                    ApplicationArea = Basic;
                }
                field("File MVT User ID"; Rec."File MVT User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("File MVT Date"; Rec."File MVT Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("File MVT Time"; Rec."File MVT Time")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("file Received"; Rec."file Received")
                {
                    ApplicationArea = Basic;
                    Caption = 'File Received';
                    Editable = false;
                }
                field("file received date"; Rec."file received date")
                {
                    ApplicationArea = Basic;
                    Caption = 'File received date';
                    Editable = false;
                }
                field("File received Time"; Rec."File received Time")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("File Received by"; Rec."File Received by")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("No Of Days"; Rec."No Of Days")
                {
                    ApplicationArea = Basic;
                    Caption = 'No of Days in Current Locaton';
                    Editable = false;
                }
                field("Reason for file overstay"; Rec."Reason for file overstay")
                {
                    ApplicationArea = Basic;
                }
                field("File Movement Remarks1"; Rec."File Movement Remarks1")
                {
                    ApplicationArea = Basic;
                    Caption = 'File MV General Remarks';
                }
            }
            group("Withdrawal Details")
            {
                Caption = 'Withdrawal Details';
                field("Withdrawal Application Date"; Rec."Withdrawal Application Date")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        if Confirm('Confirm this Application placement?', false) = true then begin
                            Rec."Exit Application Done By" := UserId;
                            Rec."Exit Application Done On" := Today;
                        end;
                    end;
                }
                field("Reason For Membership Withdraw"; Rec."Reason For Membership Withdraw")
                {
                    ApplicationArea = Basic;
                    Caption = 'Reason For Withdrawal';
                }
                field("Withdrawal Date"; Rec."Withdrawal Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Withdrawal Fee"; Rec."Withdrawal Fee")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Status - Withdrawal App."; Rec."Status - Withdrawal App.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Withdrawal Status';
                    Editable = false;
                }
                field("Exit Application Done By"; Rec."Exit Application Done By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Exit Application Done On"; Rec."Exit Application Done On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

            }


            // area(factboxes)
            // {
            //     part(Control1000000052; "Member Statistics FactBox")
            //     {
            //         Caption = 'Member Statistics FactBox';
            //         SubPageLink = "No." = field("No.");
            //     }
            //     part(Control1000000107; "Member Picture-Uploaded")
            //     {
            //         Caption = 'Picture';
            //         Editable = false;
            //         Enabled = false;
            //         ShowFilter = false;
            //         SubPageLink = "No." = field("No.");
            //     }
            //     part(Control1000000106; "Member Signature-Uploaded")
            //     {
            //         Caption = 'Signature';
            //         Editable = false;
            //         Enabled = false;
            //         SubPageLink = "No." = field("No.");
            //     }
            // }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Member")
            {
                Caption = '&Member';
                action("Member Ledger Entries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Ledger Entries';
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedOnly = true;
                    RunObject = Page "Customer Ledger Entries";
                    RunPageLink = "Customer No." = field("No.");
                    RunPageView = sorting("Customer No.");
                }
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "No." = field("No.");
                    Visible = false;
                }



            }
            group(ActionGroup1102755023)
            {
                action("Members Kin Details List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Members Kin Details List';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Members Nominee Details List";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Account Signatories")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signatories Details';
                    Image = CustomerContact;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Member Account Signatory list";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Account Agent Details")
                {
                    ApplicationArea = Basic;
                    Image = Group;
                    Promoted = true;
                    PromotedCategory = Process;
                    // RunObject = Page "Member Agent Account list";
                    // RunPageLink = "Account No" = field("No.");
                }
                action("Members Statistics")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Details';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Members Statistics";
                    RunPageLink = "No." = field("No.");
                }
                action("Member is  a Guarantor")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Guaranteed';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(50225, true, false, Cust);
                    end;
                }
                action("Member is  Guaranteed")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member is  Guaranteed';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(50225, true, false, Cust);
                        //50482
                    end;
                }


                action("Create Withdrawal Application")
                {
                    ApplicationArea = Basic;
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        // if Confirm('Are you sure you want to create a Withdrawal Application for this Member', false) = true then begin
                        //     MicropointFactory.FnCreateMembershipWithdrawalApplication("No.", "Withdrawal Application Date", "Reason For Membership Withdraw", "Withdrawal Date");
                        // end;
                    end;
                }
                action("Member Risk Rating1")
                {
                    ApplicationArea = Basic;
                    Image = Alerts;
                    Promoted = true;
                    PromotedCategory = Process;
                    // RunObject = Page "Individual Member Risk Rating";
                    // RunPageLink = "Membership Application No" = field("No.");

                    trigger OnAction()
                    begin

                        SFactory.FnGetMemberAMLRiskRating(Rec."No.");
                    end;
                }
                action("Account Statement Transactions ")
                {
                    ApplicationArea = Basic;
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Process;
                    // RunObject = Page "Loan Appraisal Statement Buffe";
                    // RunPageLink = "Loan No" = field("No.");
                }
                action("Member Deposit Saving History")
                {
                    ApplicationArea = Basic;
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Process;
                    // RunObject = Page "Member Deposit Saving History";
                    // RunPageLink = "Loan No" = field("No.");
                }
                action("Load Account Statement Details")
                {
                    ApplicationArea = Basic;
                    Image = InsertAccount;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ObjAccountLedger: Record "Detailed Vendor Ledg. Entry";
                        // ObjStatementB: Record "Loan Appraisal Statement Buffe";
                        StatementStartDate: Date;
                        StatementDateFilter: Date;
                        StatementEndDate: Date;
                        VerStatementAvCredits: Decimal;
                        VerStatementsAvDebits: Decimal;
                        VerMonth1Date: Integer;
                        VerMonth1Month: Integer;
                        VerMonth1Year: Integer;
                        VerMonth1StartDate: Date;
                        VerMonth1EndDate: Date;
                        VerMonth1DebitAmount: Decimal;
                        VerMonth1CreditAmount: Decimal;
                        VerMonth2Date: Integer;
                        VerMonth2Month: Integer;
                        VerMonth2Year: Integer;
                        VerMonth2StartDate: Date;
                        VerMonth2EndDate: Date;
                        VerMonth2DebitAmount: Decimal;
                        VerMonth2CreditAmount: Decimal;
                        VerMonth3Date: Integer;
                        VerMonth3Month: Integer;
                        VerMonth3Year: Integer;
                        VerMonth3StartDate: Date;
                        VerMonth3EndDate: Date;
                        VerMonth3DebitAmount: Decimal;
                        VerMonth3CreditAmount: Decimal;
                        VerMonth4Date: Integer;
                        VerMonth4Month: Integer;
                        VerMonth4Year: Integer;
                        VerMonth4StartDate: Date;
                        VerMonth4EndDate: Date;
                        VerMonth4DebitAmount: Decimal;
                        VerMonth4CreditAmount: Decimal;
                        VerMonth5Date: Integer;
                        VerMonth5Month: Integer;
                        VerMonth5Year: Integer;
                        VerMonth5StartDate: Date;
                        VerMonth5EndDate: Date;
                        VerMonth5DebitAmount: Decimal;
                        VerMonth5CreditAmount: Decimal;
                        VerMonth6Date: Integer;
                        VerMonth6Month: Integer;
                        VerMonth6Year: Integer;
                        VerMonth6StartDate: Date;
                        VerMonth6EndDate: Date;
                        VerMonth6DebitAmount: Decimal;
                        VerMonth6CreditAmount: Decimal;
                        VarMonth1Datefilter: Text;
                        VarMonth2Datefilter: Text;
                        VarMonth3Datefilter: Text;
                        VarMonth4Datefilter: Text;
                        VarMonth5Datefilter: Text;
                        VarMonth6Datefilter: Text;
                        ObjMemberCellG: Record "Member House Groups";
                        TrunchDetailsVisible: Boolean;
                        ObjTranch: Record "Tranch Disburesment Details";
                        GenSetUp: Record "Sacco General Set-Up";
                    begin
                        //Clear Buffer
                        // ObjStatementB.Reset;
                        // ObjStatementB.SetRange(ObjStatementB."Loan No", Rec."No.");
                        // if ObjStatementB.FindSet then begin
                        //     ObjStatementB.DeleteAll;
                        // end;



                        //Initialize Variables
                        VerMonth1CreditAmount := 0;
                        VerMonth1DebitAmount := 0;


                        VerMonth4CreditAmount := 0;
                        VerMonth4DebitAmount := 0;
                        VerMonth5CreditAmount := 0;
                        VerMonth5DebitAmount := 0;
                        VerMonth6CreditAmount := 0;
                        VerMonth6DebitAmount := 0;
                        GenSetUp.Get();

                        //Month 1
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth1Date := Date2dmy(StatementStartDate, 1);
                        VerMonth1Month := Date2dmy(StatementStartDate, 2);
                        VerMonth1Year := Date2dmy(StatementStartDate, 3);


                        VerMonth1StartDate := Dmy2date(1, VerMonth1Month, VerMonth1Year);
                        VerMonth1EndDate := CalcDate('CM', VerMonth1StartDate);

                        VarMonth1Datefilter := Format(VerMonth1StartDate) + '..' + Format(VerMonth1EndDate);
                        VerMonth1CreditAmount := 0;
                        VerMonth1DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", Rec."FOSA Account No.");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth1Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth1DebitAmount := VerMonth1DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth1CreditAmount := VerMonth1CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            // ObjStatementB.Init;
                            // ObjStatementB."Loan No" := Rec."No.";
                            // ObjStatementB."Transaction Date" := VerMonth1EndDate;
                            // ObjStatementB."Transaction Description" := 'Month 1 Transactions';
                            // ObjStatementB."Amount Out" := VerMonth1DebitAmount;
                            // ObjStatementB."Amount In" := VerMonth1CreditAmount * -1;
                            // ObjStatementB.Insert;

                        end;


                        //Month 2
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth2Date := Date2dmy(StatementStartDate, 1);
                        VerMonth2Month := (VerMonth1Month + 1);
                        VerMonth2Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth2Month > 12 then begin
                            VerMonth2Month := VerMonth2Month - 12;
                            VerMonth2Year := VerMonth2Year + 1;
                        end;

                        VerMonth2StartDate := Dmy2date(1, VerMonth2Month, VerMonth1Year);
                        VerMonth2EndDate := CalcDate('CM', VerMonth2StartDate);
                        VarMonth2Datefilter := Format(VerMonth2StartDate) + '..' + Format(VerMonth2EndDate);
                        VerMonth2CreditAmount := 0;
                        VerMonth2DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", Rec."FOSA Account No.");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth2Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth2DebitAmount := VerMonth2DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth2CreditAmount := VerMonth2CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            // ObjStatementB.Init;
                            // ObjStatementB."Loan No" := Rec."No.";
                            // ObjStatementB."Transaction Date" := VerMonth2EndDate;
                            // ObjStatementB."Transaction Description" := 'Month 2 Transactions';
                            // ObjStatementB."Amount Out" := VerMonth2DebitAmount;
                            // ObjStatementB."Amount In" := VerMonth2CreditAmount * -1;
                            // ObjStatementB.Insert;

                        end;

                        VerMonth3CreditAmount := 0;
                        VerMonth3DebitAmount := 0;
                        //Month 3
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth3Date := Date2dmy(StatementStartDate, 1);
                        VerMonth3Month := (VerMonth1Month + 2);
                        VerMonth3Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth3Month > 12 then begin
                            VerMonth3Month := VerMonth3Month - 12;
                            VerMonth3Year := VerMonth3Year + 1;
                        end;

                        VerMonth3StartDate := Dmy2date(1, VerMonth3Month, VerMonth3Year);
                        VerMonth3EndDate := CalcDate('CM', VerMonth3StartDate);
                        VarMonth3Datefilter := Format(VerMonth3StartDate) + '..' + Format(VerMonth3EndDate);
                        VerMonth3CreditAmount := 0;
                        VerMonth3DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", Rec."FOSA Account No.");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth3Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth3DebitAmount := VerMonth3DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth3CreditAmount := VerMonth3CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            // ObjStatementB.Init;
                            // ObjStatementB."Loan No" := Rec."No.";
                            // ObjStatementB."Transaction Date" := VerMonth3EndDate;
                            // ObjStatementB."Transaction Description" := 'Month 3 Transactions';
                            // ObjStatementB."Amount Out" := VerMonth3DebitAmount;
                            // ObjStatementB."Amount In" := VerMonth3CreditAmount * -1;
                            // ObjStatementB.Insert;
                        end;


                        //Month 4
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth4Date := Date2dmy(StatementStartDate, 1);
                        VerMonth4Month := (VerMonth1Month + 3);
                        VerMonth4Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth4Month > 12 then begin
                            VerMonth4Month := VerMonth4Month - 12;
                            VerMonth4Year := VerMonth4Year + 1;
                        end;

                        VerMonth4StartDate := Dmy2date(1, VerMonth4Month, VerMonth4Year);
                        VerMonth4EndDate := CalcDate('CM', VerMonth4StartDate);
                        VarMonth4Datefilter := Format(VerMonth4StartDate) + '..' + Format(VerMonth4EndDate);

                        VerMonth4CreditAmount := 0;
                        VerMonth4DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", Rec."FOSA Account No.");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth4Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth4DebitAmount := VerMonth4DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth4CreditAmount := VerMonth4CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            // ObjStatementB.Init;
                            // ObjStatementB."Loan No" := Rec."No.";
                            // ObjStatementB."Transaction Date" := VerMonth4EndDate;
                            // ObjStatementB."Transaction Description" := 'Month 4 Transactions';
                            // ObjStatementB."Amount Out" := VerMonth4DebitAmount;
                            // ObjStatementB."Amount In" := VerMonth4CreditAmount * -1;
                            // ObjStatementB.Insert;
                        end;


                        //Month 5
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth5Date := Date2dmy(StatementStartDate, 1);
                        VerMonth5Month := (VerMonth1Month + 4);
                        VerMonth5Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth5Month > 12 then begin
                            VerMonth5Month := VerMonth5Month - 12;
                            VerMonth5Year := VerMonth5Year + 1;
                        end;

                        VerMonth5StartDate := Dmy2date(1, VerMonth5Month, VerMonth5Year);
                        VerMonth5EndDate := CalcDate('CM', VerMonth5StartDate);
                        VarMonth5Datefilter := Format(VerMonth5StartDate) + '..' + Format(VerMonth5EndDate);

                        VerMonth5CreditAmount := 0;
                        VerMonth5DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", Rec."FOSA Account No.");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth5Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth5DebitAmount := VerMonth5DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth5CreditAmount := VerMonth5CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            // ObjStatementB.Init;
                            // ObjStatementB."Loan No" := Rec."No.";
                            // ObjStatementB."Transaction Date" := VerMonth5EndDate;
                            // ObjStatementB."Transaction Description" := 'Month 5 Transactions';
                            // ObjStatementB."Amount Out" := VerMonth5DebitAmount;
                            // ObjStatementB."Amount In" := VerMonth5CreditAmount * -1;
                            // ObjStatementB.Insert;
                        end;


                        //Month 6
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth6Date := Date2dmy(StatementStartDate, 1);
                        VerMonth6Month := (VerMonth1Month + 5);
                        VerMonth6Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth6Month > 12 then begin
                            VerMonth6Month := VerMonth6Month - 12;
                            VerMonth6Year := VerMonth6Year + 1;
                        end;

                        VerMonth6StartDate := Dmy2date(1, VerMonth6Month, VerMonth6Year);
                        VerMonth6EndDate := CalcDate('CM', VerMonth6StartDate);
                        VarMonth6Datefilter := Format(VerMonth6StartDate) + '..' + Format(VerMonth6EndDate);

                        VerMonth6CreditAmount := 0;
                        VerMonth6DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", Rec."FOSA Account No.");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth6Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat

                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth6DebitAmount := VerMonth6DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth6CreditAmount := VerMonth6CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            // ObjStatementB.Init;
                            // ObjStatementB."Loan No" := Rec."No.";
                            // ObjStatementB."Transaction Date" := VerMonth6EndDate;
                            // ObjStatementB."Transaction Description" := 'Month 6 Transactions';
                            // ObjStatementB."Amount Out" := VerMonth6DebitAmount;
                            // ObjStatementB."Amount In" := VerMonth6CreditAmount * -1;
                            // ObjStatementB.Insert;
                        end;


                        // //Get Statement Avarage Credits
                        // ObjStatementB.Reset;
                        // ObjStatementB.SetRange(ObjStatementB."Loan No", Rec."No.");
                        // //ObjStatementB.SETFILTER(ObjStatementB.Amount,'<%1',0);
                        // if ObjStatementB.FindSet then begin
                        //     repeat
                        //         VerStatementAvCredits := VerStatementAvCredits + ObjStatementB."Amount In";
                        //     //"Bank Statement Avarage Credits":=VerStatementAvCredits/6;
                        //     //MODIFY/
                        //     until ObjStatementB.Next = 0;
                        // end;

                        // //Get Statement Avarage Debits
                        // ObjStatementB.Reset;
                        // ObjStatementB.SetRange(ObjStatementB."Loan No", Rec."No.");
                        // //ObjStatementB.SETFILTER(ObjStatementB.Amount,'>%1',0);
                        // if ObjStatementB.FindSet then begin
                        //     repeat
                        //         VerStatementsAvDebits := VerStatementsAvDebits + ObjStatementB."Amount Out";
                        //     //"Bank Statement Avarage Debits":=VerStatementsAvDebits/6;
                        //     //MODIFY;
                        //     until ObjStatementB.Next = 0;
                        // end;

                        //"Bank Statement Net Income":="Bank Statement Avarage Credits"-"Bank Statement Avarage Debits";
                        //MODIFY;
                    end;
                }
                action("Member Case History")
                {
                    ApplicationArea = Basic;
                    Image = Reconcile;
                    Promoted = true;
                    PromotedCategory = Process;
                    // RunObject = Page "Member Case History";
                    // RunPageLink = "Member No." = field(Rec."No.");
                    Visible = false;
                }
                group(Reports)
                {
                    Caption = 'Reports';
                }
                action("Detailed Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Detailed Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        // if (Rec."Assigned System ID" <> '') then begin //AND ("Assigned System ID"<>USERID)
                        //     if UserSetup.Get(UserId) then begin
                        //         //if UserSetup."View Special Accounts" = false then Error('You do not have permission to view this account Details, Contact your system administrator! ')
                        //     end;
                        // end;

                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(50223, true, false, Cust);
                    end;
                }
                action("Loan Statement")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(50227, true, false, Cust);
                    end;
                }
                action("Member Deposit Statement")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(50224, true, false, Cust);
                    end;
                }
                action("Detailed Interest Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Detailed Interest Statement';
                    Image = "Report";
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*Cust.RESET;
                        Cust.SETRANGE(Cust."No.","No.");
                        IF Cust.FIND('-') THEN
                        REPORT.RUN(,TRUE,FALSE,Cust);
                        */

                    end;
                }
                action("Loan Statement FOSA")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Statement FOSA';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;
                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(50227, true, false, Cust);

                        /*
                        Cust.RESET;
                        Cust.SETRANGE(Cust."No.","No.");
                        IF Cust.FIND('-') THEN
                        REPORT.RUN(50474,TRUE,FALSE,Cust);
                        */

                    end;
                }
                action("FOSA Statement")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;
                    trigger OnAction()
                    begin
                        Vend.Reset;
                        Vend.SetRange(Vend."No.", Rec."FOSA Account No.");
                        if Vend.Find('-') then begin
                            Report.Run(50890, true, false, Vend);
                        end;


                        /*Cust.RESET;
                        Cust.SETRANGE(Cust."FOSA Account No.","FOSA Account No.");
                        IF Cust.FIND('-') THEN
                        REPORT.RUN(50890,TRUE,FALSE,Cust);
                        */

                    end;
                }
                action("Group Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'House Group Statement';
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;
                    trigger OnAction()
                    begin
                        ObjCellGroups.Reset;
                        ObjCellGroups.SetRange(ObjCellGroups."Cell Group Code", Rec."Member House Group");
                        if ObjCellGroups.Find('-') then
                            Report.Run(50920, true, false, ObjCellGroups);
                    end;
                }
                group("Issued Documents")
                {
                    Caption = 'Issued Documents';
                    Visible = false;
                }
                action("Account Closure Slip")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Closure Slip';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(50474, true, false, Cust);
                    end;
                }
            }
        }
    }


    trigger OnAfterGetRecord()
    begin
        // FosaName := '';

        // if Rec."FOSA Account No." <> '' then begin
        //     if Vend.Get(Rec."FOSA Account No.") then begin
        //         FosaName := Vend.Name;
        //     end;
        // end;

        lblIDVisible := true;
        lblDOBVisible := true;
        lblRegNoVisible := false;
        lblRegDateVisible := false;
        lblGenderVisible := true;
        txtGenderVisible := true;
        lblMaritalVisible := true;
        txtMaritalVisible := true;

        if Rec."Account Category" <> Rec."account category"::Single then begin
            lblIDVisible := false;
            lblDOBVisible := false;
            lblRegNoVisible := true;
            lblRegDateVisible := true;
            lblGenderVisible := false;
            txtGenderVisible := false;
            lblMaritalVisible := false;
            txtMaritalVisible := false;

        end;
        OnAfterGetCurrRecord;

        Statuschange.Reset;
        Statuschange.SetRange(Statuschange."User ID", UserId);
        Statuschange.SetRange(Statuschange."Function", Statuschange."function"::"Account Status");
        if not Statuschange.Find('-') then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;

        Joint2DetailsVisible := false;
        Joint3DetailsVisible := false;
        if Rec."Account Category" <> Rec."account category"::Joint then begin
            Joint2DetailsVisible := false;
        end else
            Joint2DetailsVisible := true;

        if Rec."Account Category" <> Rec."account category"::Joint then begin
            Joint3DetailsVisible := false;
        end else
            Joint3DetailsVisible := true;

        SetStyles();
    end;

    trigger OnFindRecord(Which: Text): Boolean
    var
        RecordFound: Boolean;
    begin

        //RecordFound := Find(Which);
        //CurrPage.Editable := RecordFound ;//or ((Rec."No.") = '');
        //exit(RecordFound);

        // RecordFound := Find(Which);


    end;

    trigger OnInit()
    begin
        txtMaritalVisible := true;
        lblMaritalVisible := true;
        txtGenderVisible := true;
        lblGenderVisible := true;
        lblRegDateVisible := true;
        lblRegNoVisible := true;
        lblDOBVisible := true;
        lblIDVisible := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Customer Type" := "customer type"::Member;
        // Rec. Status := Rec.Status::Active;
        Rec."Customer Posting Group" := 'BOSA';
        Rec."Registration Date" := Today;
        Rec.Advice := true;
        Rec."Advice Type" := Rec."advice type"::"New Member";
        if GeneralSetup.Get(0) then begin
            //Rec."Welfare Contribution" := GeneralSetup."Welfare Contribution";
            Rec."Registration Fee" := GeneralSetup."Registration Fee";

        end;
    end;

    trigger OnOpenPage()
    var
        MapMgt: Codeunit "Online Map Management";
    begin
        ActivateFields;
        /*
        IF NOT MapMgt.TestSetup THEN
          CurrForm.MapPoint.VISIBLE(FALSE);
        */

        Joint2DetailsVisible := false;
        Joint3DetailsVisible := false;

        if Rec."Account Category" <> Rec."account category"::Joint then begin
            Joint2DetailsVisible := false;
        end else
            Joint2DetailsVisible := true;

        if Rec."Account Category" <> Rec."account category"::Joint then begin
            Joint3DetailsVisible := false;
        end else
            Joint3DetailsVisible := true;


        if (Rec."Assigned System ID" <> '') and (Rec."Assigned System ID" <> UserId) then begin
            Error('You do not have permission to view account');
        end;

    end;

    var
        CustomizedCalEntry: Record "Customized Calendar Entry";
        Text001: label 'Do you want to allow payment tolerance for entries that are currently open?';
        CustomizedCalendar: Record "Customized Calendar Change";
        Text002: label 'Do you want to remove payment tolerance from entries that are currently open?';
        CalendarMgmt: Codeunit "Calendar Management";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        PictureExists: Boolean;
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        StatusPermissions: Record "Status Change Permision";
        Charges: Record Charges;
        Vend: Record Vendor;
        Cust: Record customer;
        LineNo: Integer;
        UsersID: Record User;
        GeneralSetup: Record "Sacco General Set-Up";
        Loans: Record "Loans Register";
        AvailableShares: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        Interest: Decimal;
        LineN: Integer;
        LRepayment: Decimal;
        TotalRecovered: Decimal;
        LoanAllocation: Decimal;
        LGurantors: Record "Loans Guarantee Details";
        LoansR: Record "Loans Register";
        DActivity: Code[20];
        DBranch: Code[20];
        Accounts: Record Vendor;
        FosaName: Text[50];
        [InDataSet]
        lblIDVisible: Boolean;
        [InDataSet]
        lblDOBVisible: Boolean;
        [InDataSet]
        lblRegNoVisible: Boolean;
        [InDataSet]
        lblRegDateVisible: Boolean;
        [InDataSet]
        lblGenderVisible: Boolean;
        [InDataSet]
        txtGenderVisible: Boolean;
        [InDataSet]
        lblMaritalVisible: Boolean;
        [InDataSet]
        txtMaritalVisible: Boolean;
        AccNo: Code[20];
        Vendor: Record Vendor;
        TotalAvailable: Decimal;
        TotalFOSALoan: Decimal;
        TotalOustanding: Decimal;
        TotalDefaulterR: Decimal;
        value2: Decimal;
        Value1: Decimal;
        RoundingDiff: Decimal;
        Statuschange: Record "Status Change Permision";
        "WITHDRAWAL FEE": Decimal;
        "AMOUNTTO BE RECOVERED": Decimal;
        "Remaining Amount": Decimal;
        TotalInsuarance: Decimal;
        PrincipInt: Decimal;
        TotalLoansOut: Decimal;
        FileMovementTracker: Record "File Movement Tracker";
        EntryNo: Integer;
        ApprovalsSetup: Record "Approvals Set Up";
        MovementTracker: Record "Movement Tracker";
        ApprovalUsers: Record "Approvals Users Set Up";
        "Change Log": Integer;
        openf: File;
        FMTRACK: Record "File Movement Tracker";
        CurrLocation: Code[30];
        "Number of days": Integer;
        Approvals: Record "Approvals Set Up";
        Description: Text[30];
        Section: Code[10];
        station: Code[10];
        MoveStatus: Record "File Movement Status";
        Joint2DetailsVisible: Boolean;
        Joint3DetailsVisible: Boolean;
        GuarantorAllocationAmount: Decimal;
        CummulativeGuaranteeAmount: Decimal;
        UserSetup: Record "User Setup";
        JointNameVisible: Boolean;
        MicropointFactory: Codeunit "Micropoint Factory";
        ReasonforWithdrawal: Option Relocation,"Financial Constraints","House/Group Challages","Join another Institution","Personal Reasons",Other;
        SFactory: Codeunit "Micropoint Factory";
        ObjMembershipApp: Record "Membership Applications";
        ObjCellGroups: Record "Member House Groups";
        CoveragePercentStyle: Text[50];


    procedure ActivateFields()
    begin
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        ActivateFields;
    end;

    local procedure SetStyles()
    begin
        CoveragePercentStyle := 'Strong';
        if Rec."Member Risk Level" <> Rec."member risk level"::"Low Risk" then
            CoveragePercentStyle := 'Unfavorable';
        if Rec."Member Risk Level" = Rec."member risk level"::"Low Risk" then
            CoveragePercentStyle := 'Favorable';
    end;
}



//********************************************

//     trigger OnAfterGetRecord()
//     begin


//         lblIDVisible := true;
//         lblDOBVisible := true;
//         lblRegNoVisible := false;
//         lblRegDateVisible := false;
//         lblGenderVisible := true;
//         txtGenderVisible := true;
//         lblMaritalVisible := true;
//         txtMaritalVisible := true;

//         if Rec."Account Category" <> Rec."account category"::Single then begin
//             lblIDVisible := false;
//             lblDOBVisible := false;
//             lblRegNoVisible := true;
//             lblRegDateVisible := true;
//             lblGenderVisible := false;
//             txtGenderVisible := false;
//             lblMaritalVisible := false;
//             txtMaritalVisible := false;

//         end;
//         OnAfterGetCurrRecord;

//         Statuschange.Reset;
//         Statuschange.SetRange(Statuschange."User ID", UserId);
//         Statuschange.SetRange(Statuschange."Function", Statuschange."function"::"Account Status");
//         if not Statuschange.Find('-') then
//             CurrPage.Editable := false
//         else
//             CurrPage.Editable := true;

//         Joint2DetailsVisible := false;
//         Joint3DetailsVisible := false;
//         if Rec."Account Category" <> Rec."account category"::Joint then begin
//             Joint2DetailsVisible := false;
//         end else
//             Joint2DetailsVisible := true;

//         if Rec."Account Category" <> Rec."account category"::Joint then begin
//             Joint3DetailsVisible := false;
//         end else
//             Joint3DetailsVisible := true;

//         SetStyles();
//     end;

//     trigger OnFindRecord(Which: Text): Boolean
//     var
//         RecordFound: Boolean;
//     begin

//     end;

//     trigger OnInit()
//     begin
//         // txtMaritalVisible := true;
//         // lblMaritalVisible := true;
//         // txtGenderVisible := true;
//         // lblGenderVisible := true;
//         // lblRegDateVisible := true;
//         // lblRegNoVisible := true;
//         // lblDOBVisible := true;
//         // lblIDVisible := true;
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin

//     end;

//     trigger OnOpenPage()
//     var
//         MapMgt: Codeunit "Online Map Management";
//     begin

//     end;

//     var
//         CustomizedCalEntry: Record "Customized Calendar Entry";
//         Text001: label 'Do you want to allow payment tolerance for entries that are currently open?';
//         CustomizedCalendar: Record "Customized Calendar Change";
//         Text002: label 'Do you want to remove payment tolerance from entries that are currently open?';
//         CalendarMgmt: Codeunit "Calendar Management";
//         PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
//         PictureExists: Boolean;
//         GenJournalLine: Record "Gen. Journal Line";
//         GLPosting: Codeunit "Gen. Jnl.-Post Line";
//         StatusPermissions: Record "Status Change Permision";
//         Charges: Record Charges;
//         Vend: Record Vendor;
//         Cust: Record customer;
//         LineNo: Integer;
//         UsersID: Record User;
//         GeneralSetup: Record "Sacco General Set-Up";
//         Loans: Record "Loans Register";
//         AvailableShares: Decimal;
//         Gnljnline: Record "Gen. Journal Line";
//         Interest: Decimal;
//         LineN: Integer;
//         LRepayment: Decimal;
//         TotalRecovered: Decimal;
//         LoanAllocation: Decimal;
//         LGurantors: Record "Loans Guarantee Details";
//         LoansR: Record "Loans Register";
//         DActivity: Code[20];
//         DBranch: Code[20];
//         Accounts: Record Vendor;
//         FosaName: Text[50];
//         [InDataSet]
//         lblIDVisible: Boolean;
//         [InDataSet]
//         lblDOBVisible: Boolean;
//         [InDataSet]
//         lblRegNoVisible: Boolean;
//         [InDataSet]
//         lblRegDateVisible: Boolean;
//         [InDataSet]
//         lblGenderVisible: Boolean;
//         [InDataSet]
//         txtGenderVisible: Boolean;
//         [InDataSet]
//         lblMaritalVisible: Boolean;
//         [InDataSet]
//         txtMaritalVisible: Boolean;
//         AccNo: Code[20];
//         Vendor: Record Vendor;
//         TotalAvailable: Decimal;
//         TotalFOSALoan: Decimal;
//         TotalOustanding: Decimal;
//         TotalDefaulterR: Decimal;
//         value2: Decimal;
//         Value1: Decimal;
//         RoundingDiff: Decimal;
//         Statuschange: Record "Status Change Permision";
//         "WITHDRAWAL FEE": Decimal;
//         "AMOUNTTO BE RECOVERED": Decimal;
//         "Remaining Amount": Decimal;
//         TotalInsuarance: Decimal;
//         PrincipInt: Decimal;
//         TotalLoansOut: Decimal;
//         FileMovementTracker: Record "File Movement Tracker";
//         EntryNo: Integer;
//         ApprovalsSetup: Record "Approvals Set Up";
//         MovementTracker: Record "Movement Tracker";
//         ApprovalUsers: Record "Approvals Users Set Up";
//         "Change Log": Integer;
//         openf: File;
//         FMTRACK: Record "File Movement Tracker";
//         CurrLocation: Code[30];
//         "Number of days": Integer;
//         Approvals: Record "Approvals Set Up";
//         Description: Text[30];
//         Section: Code[10];
//         station: Code[10];
//         MoveStatus: Record "File Movement Status";
//         Joint2DetailsVisible: Boolean;
//         Joint3DetailsVisible: Boolean;
//         GuarantorAllocationAmount: Decimal;
//         CummulativeGuaranteeAmount: Decimal;
//         UserSetup: Record "User Setup";
//         JointNameVisible: Boolean;
//         MicropointFactory: Codeunit "Micropoint Factory";
//         ReasonforWithdrawal: Option Relocation,"Financial Constraints","House/Group Challages","Join another Institution","Personal Reasons",Other;
//         SFactory: Codeunit "Micropoint Factory";
//         ObjMembershipApp: Record "Membership Applications";
//         ObjCellGroups: Record "Member House Groups";
//         CoveragePercentStyle: Text[50];


//     procedure ActivateFields()
//     begin
//     end;

//     local procedure OnAfterGetCurrRecord()
//     begin
//         xRec := Rec;
//         ActivateFields;
//     end;

//     local procedure SetStyles()
//     begin
//         CoveragePercentStyle := 'Strong';

//     end;
// }


