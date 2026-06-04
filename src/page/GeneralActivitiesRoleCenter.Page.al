page 50025 "General Activities Role Center"
{
    Caption = 'General Activities Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control76; "Headline RC Accountant")
            {
                ApplicationArea = All;
                Caption = 'Headline RC Accountant';
            }
            part("General Management Cues"; "General Management Cues")
            {
                ApplicationArea = All;
                Caption = 'General Management Cues';
            }
        }
    }

    actions
    {
        area(Processing)
        {

        }
        area(sections)
        {
            group("Self Service")
            {
                Caption = 'Self Service';
                action("Change Password")
                {
                    Caption = 'Change My Password';
                    RunObject = report "Change Password";
                    ApplicationArea = All;
                    ToolTip = 'Change Password';
                }



            }


            group("System Administration")
            {
                group("User Profiles")
                {
                    action(userAccountsSetups)
                    {
                        Caption = 'User Account Setups';
                        Image = Setup;
                        RunObject = page "User Setup";
                    }
                    action("Approval User Setup")
                    {
                        Caption = 'User Approval Setup';
                        Image = Setup;
                        RunObject = page "Approval User Setup";
                    }


                    action("User Workflow Setup")
                    {
                        Caption = 'User Workflow Setup';
                        ApplicationArea = Basic, Suite;
                        Image = Check;
                        RunObject = page "Workflows";
                    }
                    action("Supervisor Approval Levels")
                    {
                        Caption = 'User Workflow Setup';
                        ApplicationArea = Basic, Suite;
                        Image = Check;
                        RunObject = page "Supervisor Approvals Levels";
                    }
                }

                //Status Change Permisions
                action("Status Change Permisions")
                {
                    RunObject = page "Status Change Permisions";
                }
                action("Postal codes")
                {
                    RunObject = page "Post Codes";
                }


                action("Next of Kin Relations Types")
                {
                    RunObject = page "Relationship list";
                }

                action("Sacco General Setup")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Sacco General Set-Up";
                }
                action("Sacco No. Series")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Sacco No. Series";
                }
                action("BOSA&FOSA User List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'User Template';
                    RunObject = page "BOSA&FOSA User Template";
                }

                //loanproduct
                action("Loan Products")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Loan Products Setup List";
                }

                action("Posting groups")
                {
                    Caption = 'Customer Posting Groups';
                    Image = CashFlow;
                    RunObject = page "Customer Posting Groups";
                }
                action("Transaction type  Mapping")
                {
                    Caption = 'Transaction Type  Mapping';
                    Image = CashFlow;
                    RunObject = page "Transaction Types Mapping";
                }

                action(smsline)
                {
                    Caption = 'SMS Line';
                    RunObject = page "SMS Messages";
                    ApplicationArea = all;
                }

            }

            group(Membershipsetup)
            {
                Caption = 'Membership Setup';
                action(AccountTypesSavingsList)
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Account Types Savings List";
                }
                //Member Accounts No. Series
                action("Member Accounts No. Series")
                {
                    RunObject = page "Member Accounts No. Series";
                    ApplicationArea = Basic, Suite;

                }
                action("Member Categories")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Member Product';
                    RunObject = page "Membership App Products";
                    ToolTip = 'View or set up detailed information about your member categories.';
                }
                // action("Customer Risk Rating")
                // {
                //     Caption = 'Customer Risk Rating';
                //     Image = Setup;
                //     RunObject = page "Customer Risk Rating";
                // }
                // action("member due diligence")
                // {
                //     Caption = 'Member Due Diligence';
                //     Image = Setup;
                //     RunObject = page "Member Due Diligence Measure";
                // }
                // action("Product Risk Rating")
                // {
                //     Caption = 'Product Risk Rating';
                //     Image = Setup;
                //     RunObject = page "Product Risk Rating";
                // }

            }


            // group("SystemAutomations")
            // {
            //     action("System Automations")
            //     {
            //         RunObject = page "Automated Schedules SetUp";
            //     }
            // }
            group("Address setup")
            {
                action("Postal codess")
                {
                    RunObject = page "Post Codes";
                }
                action("Sacco Employers")
                {
                    RunObject = page "Employer list";
                }
                action("Next of Kin Relations Typess")
                {
                    RunObject = page "Relationship list";
                }
            }


            group("Sacco Workflow Mgmt1")
            {
                Caption = 'Workflow Management';

                action("Workflow Categoriess")
                {
                    Caption = 'Workflow Categories';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Workflow Categories";
                }
                action("Workflows Setups")
                {
                    Caption = 'Workflows Setup';
                    ApplicationArea = Basic, Suite;
                    RunObject = page Workflows;
                }
                action("Workflow User Groupss")
                {
                    Caption = 'Workflow User Groups';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Workflow User Groups";
                }

            }
            group("FOSA Setups")
            {

                action("Transaction Types Setup")
                {
                    Caption = 'Transaction Types Setup';
                    Image = Receipt;
                    RunObject = page "Transaction Type - List";
                }
                // action("Charges Setup")
                // {
                //     Caption = 'Transaction Charges Setup';
                //     Image = Receipt;
                //     RunObject = page "Charges - FOSA";
                // }
                // action("Cheque Types")
                // {
                //     Caption = 'Cheque Types Setup';
                //     Image = Receipt;
                //     RunObject = page "Cheque Types";
                // }
                // action("Cheque Truncation Charges")
                // {
                //     Caption = 'Cheque Truncation Charges Setup';
                //     Image = Receipt;
                //     RunObject = page "Cheque Truncation Charges";
                // }


                action("FDR Types")
                {
                    Caption = 'Fixed Deposit Types';
                    Image = Receipt;
                    RunObject = page "Fixed deposit Types list";
                }
            }


            group(loanssetup)
            {
                Caption = 'Setup';
                Image = settings;

                action(LoansproductSetup)
                {
                    Caption = 'Loans Product Setup';
                    Image = Setup;
                    RunObject = page "Loan Products Setup List";
                }
                // action("Update Loans Category")
                // {
                //     ApplicationArea = Basic, Suite;
                //     RunObject = report "Loans Defaulters Aging -(Auto)";
                // }
                // action("Update Loans Category2")
                // {
                //     ApplicationArea = Basic, Suite;
                //     RunObject = report "Consolidated loan report-sasra";
                // }
                // action("Fosa loans admin")
                // {
                //     RunObject = page AdminLoansList;
                // }
            }





            group("Audit Trails")
            {
                action("Session Tracker")
                {
                    ApplicationArea = Basic, Suite;
                    //  RunObject = report "Session Tracker";
                }
                action("Transaction Log")
                {
                    ApplicationArea = Basic, Suite;
                    //  RunObject = report "System Transaction Log";
                }
                action("Read Log")
                {
                    ApplicationArea = Basic, Suite;
                    //  RunObject = report "System Change Entry Log";
                    Caption = 'System Change Entry Log';
                }
            }



        }
        area(reporting)
        {

        }
    }
}






