Page 50487 "Profile Main Role Center"
{
    Caption = ' Main SACCO LTD';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control75; "Headline RC Accountant")
            {
                ApplicationArea = All;
                Visible = false;
            }
            part("Membership"; "Bosa Cue")
            {
                ApplicationArea = Basic, Suite;

            }
            part("Bosa Loans Management"; "Loans Cue")
            {
                ApplicationArea = Suite;
                Visible = true;
            }
            part("General Cue"; "General Cue")
            {
                ApplicationArea = Suite;
                Visible = true;
            }

            part("Emails"; "Email Activities")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control123; "Team Member Activities")
            {
                ApplicationArea = Suite;
                Visible = false;
            }
            part(Control1907692008; "My Accounts")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control103; "Trailing Sales Orders Chart")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control106; "My Job Queue")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control9; "Help And Chart Wrapper")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control100; "Cash Flow Forecast Chart")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control108; "Report Inbox Part")
            {
                AccessByPermission = TableData "Report Inbox" = IMD;
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control122; "Power BI Report Spinner Part")
            {
                ApplicationArea = Basic, Suite;
                // Visible = false;
            }

        }
    }
    actions
    {
        area(reporting)
        {
        }
        area(embedding)
        {
            action("Chart of Account")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Chart of Accounts';
                RunObject = Page "Chart of Accounts";
                ToolTip = 'Open the chart of accounts.';
                Visible = false;

            }
            action("Bank Accounts List")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bank Accounts';
                Image = BankAccount;
                visible = false;
                RunObject = Page "Bank Account List";
                ToolTip = 'View or set up detailed information about your bank account, such as which currency to use, the format of bank files that you import and export as electronic payments, and the numbering of checks.';
            }
            action(Members)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Members';
                Image = Customer;

                RunObject = Page "Member List";
                ToolTip = 'View or edit detailed information for the Members.';
            }
            //loan
            action(Loans)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Loans';
                Image = CreditCard;
                RunObject = Page "Loans Applied  List";
                ToolTip = 'View or edit detailed information for the Loans.';
            }




        }
        area(sections)
        {

            group("Membership Management")
            {
                Caption = 'Membership Management';
                //...
                group("Account Opening")
                {
                    Caption = 'Membership Registration';

                    action(NewAccountOpening)
                    {
                        ApplicationArea = All;
                        Caption = 'Individual/Joint Application List';
                        RunObject = page "Membership Application List";
                        // RunPageView = WHERE(status = CONST(open|Pending Approval|Approved));
                        RunPageMode = Edit;
                    }
                    action(NewAccountOpeni)
                    {
                        ApplicationArea = All;
                        Caption = 'Group/Corporate Applications List';
                        RunObject = page "Membership Application List";
                        RunPageView = WHERE(status = CONST(open));
                        RunPageMode = Edit;
                    }


                }
                action(MembersList)
                {
                    ApplicationArea = all;
                    Caption = 'Member Accounts';
                    RunObject = Page "Member List";
                    ToolTip = 'View Member Accounts';
                }
                group("Member receipts")
                {
                    //wednesday01122024
                    action("Members AReceipts")
                    {
                        ApplicationArea = basic, suite;
                        Caption = 'Receipts List';
                        Image = Customer;
                        RunObject = page "Bosa Receipts List";
                        ToolTip = 'Make member receiptings for payments done by member';
                    }
                    action("Members Receipts Posted")
                    {
                        ApplicationArea = basic, suite;
                        Caption = 'Receipts List-Posted';
                        Image = Customer;
                        RunObject = page "Bosa Receipts List-Posted";
                        ToolTip = 'Make member receiptings for payments done by member';
                    }
                }

                group(ChangeRequest)
                {
                    Caption = 'Change Request';

                    action("Change Request")
                    {
                        ApplicationArea = All;
                        Caption = 'Change Request List';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Change Request List";
                        ToolTip = 'Change Member Details';
                    }

                    action(updatedchangereqslist)
                    {
                        ApplicationArea = All;
                        Caption = 'Updated Change requests';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = page "Updated Change Request List";
                    }
                }
                group("Membership Exit")
                {
                    Caption = 'Membership Exit Management';
                    action("MemberWithdrawalList")
                    {
                        ApplicationArea = all;
                        Caption = 'Membership Exit List';
                        RunObject = page "Membership Exit List";
                        ToolTip = 'Membership Exit List';
                        RunPageView = where(Posted = const(false));
                    }

                    action("Posted Membership Exit")
                    {
                        ApplicationArea = all;
                        Caption = 'Posted Membership Exit';
                        RunObject = page "Membership Exit List";
                        ToolTip = 'Posted Membership Exit';
                        RunPageView = where(Posted = const(true));
                    }
                }
                action("MemberHouse Groups List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member House Groups List';
                    RunObject = page "Member House Groups List";
                }


                group("Member Reports")
                {
                    Caption = 'Membership Reports';

                    action("Member Listing")
                    {
                        ApplicationArea = all;
                        RunObject = report "Member Listing";
                        ToolTip = 'Member Listing Report';
                    }
                    action("Sacco Membership Reports")
                    {
                        ApplicationArea = all;
                        RunObject = report "Members Applications List";
                        ToolTip = 'Membership Applications Report';
                    }
                    action("Member Register Balances")
                    {
                        ApplicationArea = all;
                        RunObject = report "Member List Report";
                        ToolTip = 'Member List Report';
                    }
                    action("Share Capital Listing Report")
                    {
                        ApplicationArea = all;
                        promoted = true;
                        PromotedCategory = Process;
                        RunObject = report "Share Capital Balances Report.";
                        ToolTip = 'Share Capital Balances Report';
                    }
                    action("Membership  Deposit Listing Report")
                    {
                        ApplicationArea = all;
                        RunObject = report "Member Deposit Balances Report";
                        ToolTip = 'Member Deposit Listing Report';
                        Caption = 'Member Deposit Listing Report';
                    }
                    //FOSA Shares Report.
                    // action("FOSA Shares Report")
                    // {
                    //     ApplicationArea = all;
                    //     RunObject = report "FOSA Shares Report.";
                    //     ToolTip = 'FOSA Shares Report';
                    // }
                    //Additional Shares Report.
                    action("Additional Shares Report")
                    {
                        ApplicationArea = all;
                        RunObject = report "Additional Shares Report.";
                        ToolTip = 'Additional Shares Report';
                    }
                    //Benevolent Fund Report.
                    // action("Benevolent Fund Report")
                    // {
                    //     ApplicationArea = all;
                    //     RunObject = report "Benevolent Fund Report.";
                    //     ToolTip = 'Benevolent Fund Report';
                    // }
                    //Membership Appli. Need House
                    action("Membership Applications Report")
                    {
                        ApplicationArea = all;
                        RunObject = report "Member List Report";
                        ToolTip = 'Membership Applications Report';
                    }
                    //Member Status Change Report
                    action("Member Status Change Report")
                    {
                        ApplicationArea = all;
                        RunObject = report "Member Status Change Report";
                        ToolTip = 'Member Status Change Report';
                    }
                    //Member Summary By Age
                    action("Member Summary By Age")
                    {
                        ApplicationArea = all;
                        RunObject = report "Member Summary By Age";
                        ToolTip = 'Member Summary By Age';
                    }
                    //Member Summary By Gender
                    action("Member Summary By Gender")
                    {
                        ApplicationArea = all;
                        RunObject = report "Member Summary By Gender";
                        ToolTip = 'Member Summary By Gender';
                    }
                    //Member Summary By Status
                    action("Member Summary By Status")
                    {
                        ApplicationArea = all;
                        RunObject = report "Member Summary By Status";
                        ToolTip = 'Member Summary By Status';
                    }
                    //Member Summary By Branch
                    action("Member Summary By Branch")
                    {
                        ApplicationArea = all;
                        RunObject = report "Member Summary By Branch";
                        ToolTip = 'Member Summary By Branch';
                    }
                    //Member Bio/Economic Data
                    action("Member Bio/Economic Data")
                    {
                        ApplicationArea = all;
                        RunObject = report "Member Bio/Economic Data";
                        ToolTip = 'Member Bio/Economic Data';
                    }
                    //House Groups Report
                    action("House Groups Report")
                    {
                        ApplicationArea = all;
                        RunObject = report "House Groups Report";
                        ToolTip = 'House Groups Report';
                    }

                }

            }


            group(SaccoLoansManagement)
            {
                Caption = 'Loans Management';
                ToolTip = 'Manage Module';

                group("Loans Management")
                {
                    Caption = 'New Loans Applications';

                    ToolTip = 'Loans'' Management Module';

                    action("Loan Application")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Application List';

                        RunObject = Page "Loans Applied  List";
                        ToolTip = 'Open Loan Applications List';

                    }
                    action("Pending Loan Application")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loans Pending Approval';
                        Image = CreditCard;
                        RunObject = Page "Loans Applied  List";

                        ToolTip = 'Open the list of Loans Pending Approval';
                    }
                    action("Approved Loans")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loans Application List(Approv).';
                        RunObject = Page "Loans Application List(Approv)";
                        ToolTip = 'Open the list of Approved Loans Pending Disbursement.';
                    }
                    action("Disbursed Loans")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Schedule List';
                        Image = CreditCard;
                        RunObject = Page "Loan Schedule List";
                        ToolTip = 'Open the list of the Loans Disbursed.';
                        Visible = false;
                    }

                }
                group("Partial Loan Disbursements")
                {
                    // Visible = false;
                    action("Partial Loan Disbursement List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Partial Loan Disbursement List";
                    }
                    action("Posted Partial Loan Disbursements")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Closed Partial Loan Disburse";
                    }
                }
                group("Loans Top Up List")
                {
                    Visible = false;
                    action("LoansTop Up List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Loan Top-Up List";
                        Caption = 'Loans Top-Up List';
                    }
                    action("LoansTopUp Posted")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Loan Top-Up List-Posted";
                        Caption = 'Loans Top-Up Posted';
                    }
                }
                group("Loans' Reports")
                {
                    action("Loans Balances Report")
                    {
                        ApplicationArea = all;
                        RunObject = Report "Loans Balances Report";
                        Caption = 'Loans Book Report';
                        ToolTip = 'A report Showing all the loan reports issued by the sacco';
                        Visible = true;
                    }
                    //Loan Monthly Expectation
                    action("Loan Monthly Expectation")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Loan Monthly Expectation";
                        Caption = 'Loan Monthly Expectation';
                        ToolTip = 'A report Showing the loan Monthly Expectation';

                    }
                    //Loans Guarantors Details
                    action("Loans Guarantors Details")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Loans Guarantors Details";
                        Caption = 'Loans Guarantors Details';
                        ToolTip = 'A report Showing the loan Guarantors Details';

                    }
                    //Loans Register  CIC
                    action("Loans Register  CIC")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Loans Register  CIC";
                        Caption = 'Loans Register  CIC';
                        ToolTip = 'A report Showing the loan Register  CIC';

                    }
                    //Guaranters List
                    action("Guaranters List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Guaranters List";
                        Caption = 'Guaranters List';
                        ToolTip = 'A report Showing the Guaranters List';

                    }
                    //Loan Disbursement List
                    action("Loan Disbursement List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Loan Disbursement List";
                        Caption = 'Loan Disbursement List';
                        ToolTip = 'A report Showing the Loan Disbursement List';

                    }
                    //Loan Movement Report
                    action("Loan Movement Report")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Loan Movement Report";
                        Caption = 'Loan Movement Report';
                        ToolTip = 'A report Showing the Loan Movement Report';
                    }

                    //Loan Arrears Report
                    action("Loan Arrears Report")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Loan Arrears Report";
                        Caption = 'Loan Arrears Report';
                        ToolTip = 'A report Showing the Loan Arrears Report';
                    }
                    //Loans Under Debt Coll. Report
                    action("Loans Under Debt Coll. Report")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Loans Under Debt Coll. Report";
                        Caption = 'Loans Under Debt Coll. Report';
                        ToolTip = 'A report Showing the Loans Under Debt Collection Report';
                    }
                    //Loans Under CRB Notice
                    action("Loans Under CRB Notice")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Loans Under CRB Notice";
                        Caption = 'Loans Under CRB Notice';
                        ToolTip = 'A report Showing the Loans Under CRB Notice';
                    }
                    //Loans Recovery Logs
                    action("Loans Recovery Logs")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Loans Recovery Logs";
                        Caption = 'Loans Recovery Logs';
                        ToolTip = 'A report Showing the Loans Recovery Logs';
                    }
                    //Loans Listed With CRB
                    action("Loans Listed With CRB")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Loans Listed With CRB";
                        Caption = 'Loans Listed With CRB';
                        ToolTip = 'A report Showing the Loans Listed With CRB';
                    }
                    //Loan Provision Summary - SASRA
                    action("Loan Provision Summary - SASRA")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Loan Provision Summary - SASRA";
                        Caption = 'Loan Provision Summary - SASRA';
                        ToolTip = 'A report Showing the Loan Provision Summary - SASRA';
                    }
                    //Loans Eligible For Offset
                    action("Loans Eligible For Offset")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Loans Eligible For Offset";
                        Caption = 'Loans Eligible For Offset';
                        ToolTip = 'A report Showing the Loans Eligible For Offset';
                    }
                    //Collateral  Report
                    action("Collateral  Report")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Collateral  Report";
                        Caption = 'Collateral  Report';
                        ToolTip = 'A report Showing the Collateral  Report';
                    }
                    //Loan Disburesment Summary
                    action("Loan Disburesment Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Loan Disburesment Summary";
                        Caption = 'Loan Disburesment Summary';
                        ToolTip = 'A report Showing the Loan Disburesment Summary';
                    }
                    //Insider Lending & Saving List
                    action("Insider Lending & Saving List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Insider Lending & Saving List";
                        Caption = 'Insider Lending & Saving List';
                        ToolTip = 'A report Showing the Insider Lending & Saving List';
                    }
                    //Products Performance Summary
                    action("Products Performance Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Products Performance Summary";
                        Caption = 'Products Performance Summary';
                        ToolTip = 'A report Showing the Products Performance Summary';
                    }
                    //Loan Repayment Summary
                    action("Loan Repayment Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Loan Repayment Summary";
                        Caption = 'Loan Repayment Summary';
                        ToolTip = 'A report Showing the Loan Repayment Summary';
                    }
                    action("Loans Portfolio Aging - SASRA")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Loans Portfolio Aging - SASRA";
                        Caption = 'Loans Portfolio Aging - SASRA';
                        ToolTip = 'A report Showing the loan aging by various parameters';

                    }
                    action("Loan Portifolio Concentration")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = report "Loan Portifolio Concentration1";
                        Caption = 'Loan Portifolio Concentration';
                        ToolTip = 'A report Showing the loan concentration by various parameters';

                    }

                }

                group("Sasra Report")
                {


                    action("Loans Defaulter Aging-SASRA")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loans Defaulter Aging- SASRA';

                        // "Loans Defaulter Aging - SASRA"
                        RunObject = report "Loans Defaulter Aging - SASRA";
                        //  Visible = false;
                    }
                    action("Loans Provisioning Summary-SASRA")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = ' Portfolio Ageing Report';
                        RunObject = report "Loans Provisioning Summary New";
                    }
                    action("Loan Sectorial Lendng-SASRA")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Sectorial Lending';
                        RunObject = REPORT "Loan Sectoral Lending Report";
                    }



                    //Loans Portfolio Aging - SASRA


                }




                action("PostedLoans")
                {
                    ApplicationArea = Basic, Suite;

                    Caption = 'Loans Posted List';
                    Image = CreditCard;
                    RunObject = Page "Loans Posted List";

                    ToolTip = 'Open the list of the Loans Posted.';
                }

                action("LoansRescheduleList")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Loan Restructure List";
                    Caption = 'Loans Reschedule List';
                }

                action("Loan Calculator")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Loans Calculator List";
                }

            }


            //............................Mobile Banking Management......................................
            group(MobileBankingManagement)
            {
                Caption = 'Mobile Banking';
                ToolTip = 'Mobile Banking';

                group("Mobile Application")
                {
                    Caption = 'Mobile Applications';

                    ToolTip = 'Mobile Applications';

                    action("Open Mobile Application")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Open Mobile Application';

                        RunObject = Page "Open Applications List";
                        ToolTip = 'Open Mobile Application';

                    }
                    action("Approved Mobile Application")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Approved Mobile Application';

                        RunObject = Page "AppMobile Applications List";
                        ToolTip = 'Approved Mobile Application';

                    }
                }
                group("Mobile Transactions")
                {
                    action("CFT Paybill Transactions")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "CFT Mobile Paybill List";
                        Caption = 'CFT Mobile Paybill List';
                    }
                    action("Mobile Loan Appraisal")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "MobileLoanAppraisal";
                        Caption = 'Mobile Loan Appraisal';
                    }

                    action(smsline)
                    {
                        Caption = 'SMS Line';
                        RunObject = page "SMS Messages";
                        ApplicationArea = all;
                    }
                    action("Mobile Loans")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Ruai Mobile Loans";

                    }
                    action("Recovered Mobile Loans")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Recovered Mobile Loans";
                        Caption = 'Recovered Mobile Loans';
                    }
                }
            }

            //.............................Collateral Management..........................................
            group("Collateral Management")
            {
                Image = member;

                action(Collateralreg)
                {
                    Caption = 'Loan Collateral Register';
                    Image = Register;
                    RunObject = page "Loan Collateral Register List";
                    //RunObject = page "Collateral Action List";
                }
                //"Loan Collateral Security"
                action(Collateralsecurity)
                {
                    Caption = 'Loan Collateral Security';
                    RunObject = page "Loan Collateral Security";
                }
                action(Collateralmvmt)
                {
                    Caption = 'Loan Collateral Movement';
                    RunObject = page "Collateral Movement List";
                }
                group(CollateralReports)
                {
                    Caption = 'Collateral Movement';

                    action(ColateralsReport)
                    {
                        Caption = 'Collateral Report';
                        RunObject = report "Collateral  Report";
                    }
                }
                group(ArchiveCollateral)
                {
                    Caption = 'Archive';

                    action(Effectedcollatmvmt)
                    {
                        Caption = 'Effective Collateral Movement';
                        RunObject = page "Effected Collateral Movement";
                    }
                }
            }
            //.........................End of Collateral Management......................................
            //...................................Guarantor Management........................................
            group("Guarantor Management")
            {
                Caption = 'Guarantor Management';
                Image = member;

                action("Guarantor Substitution List")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Guarantorship Sub List";
                }
                action("Effected Guarantor Substitution")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Loans Guarantee Details";
                }
                action("Member Loans Guaranteed")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Loans Guarantee Details";
                }
                action("Members Loan  Guarantors")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Loans Guarantee Details";
                }
            }
            //..................................End of Guarantor Management......................................

            group("Members Transfers")
            {
                Caption = 'Members Transfers';


                action(TransfersList)
                {
                    ApplicationArea = basic, suite;
                    Caption = 'Transfers List';
                    Image = Customer;
                    RunObject = page "Bosa Transfer List";
                    ToolTip = 'Make member receiptings for payments done by member';
                }

                action(PostedTransfers)
                {
                    ApplicationArea = basic, suite;
                    Caption = 'Posted Transfer List';
                    Image = Customer;
                    RunObject = page "Bosa Transfer Posted";
                    ToolTip = 'Transfer Posted';
                    RunPageView = where(Posted = const(true));
                }
            }

            group("SharesCapital Trading")
            {
                Caption = 'SharesCapital Trading';
                Image = member;

                action(OpenSharesCapitalTrading)
                {
                    Caption = 'Open SharesCapital Trading';
                    RunObject = page "Shares Transfer List";
                    RunPageView = WHERE(Status = filter(open));
                }
                action(PendingSharesCapitalTrading)
                {
                    Caption = 'Pending SharesCapital Trading';
                    RunObject = page "Share Transfer List";
                    RunPageView = WHERE(Status = CONST(pending));
                }
                action(ApprovedSharesTrasnfer)
                {
                    Caption = 'Approved SharesCapital Trading';
                    RunObject = page "Share Transfer List";
                    RunPageView = WHERE(Status = CONST(approved));
                }
                action(PostedSharesTrasnfer)
                {
                    Caption = 'Posted SharesCapital Trading';
                    RunObject = page "Share Transfer List";
                    RunPageView = WHERE(Status = CONST(closed));
                }
            }
            //......................................Start of Defaulter Management............................
            group("Defaulter's Management")
            {
                Caption = 'Defaulter Management';
                Image = member;



                group(demandnotices)
                {
                    caption = 'Demand Notices';

                    action(LoanDemandnoticeslist)
                    {
                        caption = 'Loan Demand Notices List';
                        RunObject = page "Loan Demand Notices List";
                        //Loan Demand Notices List
                    }
                    action(CreateDemand)
                    {
                        Caption = 'Create Demand Notices';
                        RunObject = report "Create Demand Notices";
                        Image = Report2;
                    }

                    group(DemandReports)
                    {
                        action(Ldemandnotice1)
                        {
                            Caption = 'Loan Demand Notice';
                            RunObject = report "Loan Demand Notice";
                            Image = Report;
                        }
                        action(Ldemandnotice2)
                        {
                            Caption = 'Loan CRB Notice';
                            RunObject = report "Loan CRB Notice";
                            Image = Report;
                        }

                    }
                }



                group(loanRecovery)
                {
                    Caption = 'Loan Recovery';

                    action(LoanRecovList)
                    {
                        Caption = 'Open Loan Recovery List';
                        RunObject = page "Loan Recovery List";
                        RunPageView = WHERE(Posted = CONST(false));
                        ApplicationArea = Basic, Suite;
                    }

                    action(PostedLoanRecovList)
                    {
                        Caption = 'Posted Loan Recovery List';
                        RunObject = page "Loan Recovery List";
                        RunPageView = WHERE(Posted = CONST(true));
                        ApplicationArea = Basic, Suite;
                    }
                }



            }
            //.......................................End of Defaulter Management .................................
            //...............................................Start of Reports.........................

            group(BOSAPeriodicActivities)
            {
                Caption = 'Periodic Activities';
                Image = person;


                action(GeneralDormat)
                {
                    Caption = 'Generate Dormant';
                    RunObject = report "Generate Dormant A|Cs";
                    Image = GeneralLedger;
                }
                group(CheckOffDistributed)
                {
                    Caption = 'Checkoff Processing-Distributed';

                    action("Checkoff Processing List")
                    {
                        Caption = 'Checkoff Processing List';
                        Image = Setup;
                        RunObject = page "Checkoff Processing Header-D";
                    }
                    action(CheckoffProcessingDistributed)
                    {
                        Caption = 'Checkoff Processing-Distributed';
                        Image = Setup;
                        RunObject = page "Checkoff Processing Header-D";
                    }
                }
                group(CheckOffBlocked)
                {
                    Caption = 'Checkoff Processing-Blocked';

                    action("Checkoff Processing List Blocked")
                    {
                        Caption = 'Employer Checkoff Remittance';
                        Image = Setup;
                        RunObject = page "Bosa Receipts H List-Checkoff";
                    }
                    action("Posted Employer Checkoff Remittance")
                    {
                        Caption = 'Posted Employer Checkoff Remittance';
                        Image = Setup;
                        RunObject = page "Bosa Receipts H List-Checkoff";
                        RunPageView = where(Posted = const(true));
                    }
                    action("Import Sacco Jnl")
                    {
                        Caption = 'Import Sacco Jnl';
                        Image = Setup;
                        Visible = false;
                        //  RunObject = xmlport "Import Sacco Jnl";
                    }
                }
                group(CheckOffAdvice)
                {
                    Caption = 'Check-Off Advice';

                    action("Data Sheet Main")
                    {
                        Caption = 'Data Sheet Main';
                        Image = Setup;
                        RunObject = page "Data Sheet Main";
                    }

                    action("DataSheetMainReport")
                    {
                        Caption = 'Data Sheet Main Report';
                        Image = Report;
                        RunObject = report "Data Sheet Main";
                    }


                }
                group(MonthlyInterestProcessing)
                {
                    Caption = 'Monthly Interest Processing';

                    action("Post Monthly Interest")
                    {
                        Caption = 'Post Monthly Interest';
                        Image = Setup;
                        RunObject = report "Post Monthly Interest";
                    }
                }
                group(Dividends)
                {
                    Caption = 'Dividends';

                    group("Flat Rate")
                    {
                        Caption = 'Flat Rate';

                        action("Dividends Processing-Flat Rate")
                        {
                            Caption = 'Dividends Processing-Flat Rate';
                            Image = Setup;
                            RunObject = report "Generate Dividend FlatRate";
                        }

                    }
                    group(Prorated)
                    {
                        Caption = 'Prorated';

                        action("Dividends Processing-Prorated")
                        {
                            Caption = 'Dividends Processing(Prorated)';
                            Image = Setup;
                            RunObject = report "Dividends Progressionslip";
                        }
                        action("Transfer To Journal")
                        {
                            Caption = 'Transfer To Journal(Prorated)';
                            Image = Setup;
                            RunObject = report "Generate Dividend Prorated";
                        }
                        action("Dividends Register")
                        {
                            Caption = 'Dividends Payout Summary';
                            Image = Setup;
                            RunObject = report "Process Dividends";
                        }
                    }
                }
                group(CRB)
                {
                    Caption = 'CRB Management';

                    group("Credit Reference Bureau")
                    {
                        action("Credit Reference Bureaus")
                        {
                            Caption = 'Credit Reference Bureau List';
                            Image = Setup;
                            // RunObject = page "Credit Reference Bureau";
                        }
                    }
                    group(Generate_CRBReport)
                    {
                        Caption = 'Generate CRB Report';

                        action(GenerateCRBReport)
                        {
                            Caption = 'Generate CRB List';
                            Image = Setup;
                            /// RunObject = report "Generate CRB Main";
                        }
                    }
                }




            }


            //House Group Management

            group("House Group Management")
            {
                group("House Group Listing")
                {
                    Caption = 'House Groups';
                    action("House Group List")
                    {
                        Image = Group;
                        RunObject = page "House Groups Registration List";
                        Caption = 'House Groups Registration';
                        //House Groups Registration List
                    }
                    //Member House Groups List
                    action("House Group Members List")
                    {
                        Image = Group;
                        RunObject = page "Member House Groups List";
                        Caption = 'House Group Members List';
                    }
                }

                //House Change Request
                action("House Change Request")
                {

                    Caption = 'House Change Request';
                    Image = Group;
                    RunObject = page "House Change Request";
                }

            }

            group("MC Management")
            {
                Visible = false;
                group("MC Member Management")
                {
                    action("MC Members List")
                    {
                        Image = Group;
                        //RunObject = page "MC Individual Sub-List";
                    }
                    group("MC membership application")
                    {
                        action("MC New Member Application")
                        {
                            Image = Group;
                            //RunPageView = WHERE(Status=CONST(Open));
                            //RunObject = page "MC Individual Application List";
                        }
                        action("MC Member Application-Pending Approval")
                        {
                            Image = Group;
                            //RunPageView = WHERE(Status=CONST(Pending));
                            //RunObject = page "MC Individual Application List";
                        }
                        action("MC Member Application-Pending Registration")
                        {
                            Image = Group;
                            // RunPageView = WHERE(Status=CONST(Approved));
                            //RunObject = page "MC Individual Application List";
                        }
                    }
                }
                group("MC Group Management")
                {
                    action("MC Group List")
                    {
                        Image = Group;
                        // RunObject = page "MC Group List";
                    }
                    group("MC Group Applications")
                    {
                        action("MC Group List Application")
                        {
                            Image = Group;
                            //RunPageView = WHERE(Status = CONST(Open));
                            // RunObject = page "Group Application List";
                        }
                        action("Group Application-Pending Approval")
                        {
                            Image = Group;
                            //RunPageView = WHERE(Status = CONST(Pending));
                            // RunObject = page "Group Application List";
                        }
                        action("Group Application-Pending Registration")
                        {
                            Image = Group;
                            //RunPageView = WHERE(Status = CONST(Approved));
                            //RunObject = page "MC Individual Application List";
                            //RunObject = page "Group Application List";
                        }
                    }
                }
                group("MC Loans Management")
                {
                    group("MC Loans Processing")
                    {
                        Image = Group;

                        action("Loans Applications-New")
                        {
                            Image = Group;
                            // RunObject = page "Loans List-MICRO";
                            // RunPageView = WHERE("Loan Status" = CONST(Application), source = filter('MICRO'));
                        }
                        action("Loans Applications-Pending Approval")
                        {
                            Image = Group;
                            // RunObject = page "Loans List-MICRO";
                            // RunPageView = WHERE("Loan Status" = CONST(Appraisal), source = filter('MICRO'));
                            RunPageMode = view;
                        }
                        action("Loans Applications-Pending Disbursement")
                        {
                            Image = Group;
                            // RunObject = page "Loans List-MICRO";
                            //RunPageView = WHERE("Loan Status" = CONST(approved), source = filter('MICRO'));
                        }
                        action("MC Batch Disbursement")
                        {
                            Image = Group;
                            // RunObject = page "Loans Disb Batch List(MICRO)";
                        }
                    }
                    group("MC Posted Loans")
                    {
                        action("MC Loans Posted")
                        {
                            Image = Group;
                            //RunObject = page "Loans Posted-MICRO";
                        }
                        action("MC Batches Posted")
                        {
                            Image = Group;
                            // RunObject = page "Posted Loan Batch-List(MICRO)";
                        }
                    }
                }

                group("MC Reports")
                {

                    action("MC Collection Report ")
                    {
                        ApplicationArea = Basic, Suite;
                        //RunObject = report "CEEP Collections Report";
                        Caption = 'Actual Loan Collections';
                    }
                    action("CEEP Target & Variance Report")
                    {
                        ApplicationArea = Basic, Suite;
                        // RunObject = report "CEEP Targets & Variance Report";
                        Caption = 'Collection Variance Report';
                    }

                    action("CEEP Loan Status Report(2)")
                    {
                        ApplicationArea = Basic, Suite;
                        // RunObject = report "Group Performance Status";
                    }

                }
                group("CEEP Setups")
                {
                    Caption = 'CEEP Change Request';

                    action("MC Change Details")
                    {
                        Image = Group;
                        Caption = 'New MC Change Request';
                        // RunObject = page "CEEP Change Request List";
                        // RunPageView = WHERE(status=CONST(open));
                    }
                    action("CEEP Change Details-p")
                    {
                        Image = Group;
                        Caption = 'Pending Approval MC Change Request';
                        // RunObject = page "CEEP Change Request List";
                        // RunPageView = WHERE(status=CONST(PENDING));
                    }
                    action("CEEP Change Details-A")
                    {
                        Image = Group;
                        Caption = 'Pending Change MC Request';
                        // RunObject = page "CEEP Change Request List";
                        // RunPageView = WHERE(status=CONST(approved));
                    }
                    action("CEEP Change Details-c")
                    {
                        Image = Group;
                        Caption = 'Closed CEEP Change Requests';
                        // RunObject = page "CEEP Change Request List";
                        // RunPageView = WHERE(status=CONST(closed));
                    }
                }

            }
            //.......................... END OF CEEP MANAGEMENT MAIN MENU ........................................

            group(SaccoCRM)
            {
                Caption = 'CRM';
                Visible = true;

                action("CRM Member List")
                {
                    Caption = 'CRM Member List';

                    // RunObject = page "CRM Member List";
                }
                group("Case Management")
                {
                    action("Case Registration")
                    {
                        Caption = 'Lead Management';
                        ApplicationArea = basic, suite;
                        Image = Capacity;
                        // RunObject = page "Lead list";
                        //RunPageView = WHERE(status = CONST(New));
                        ToolTip = 'Create a New Case enquiry';
                    }
                    action("Assigned Cases")
                    {
                        Caption = 'Assigned Cases';
                        ApplicationArea = basic, suite;
                        Image = Open;
                        // RunObject = page "Lead list Escalated";
                        // RunPageView = WHERE(status = CONST(Escalted));
                        ToolTip = 'Open List Of Cases open & Assigned To Me';
                    }
                    action("Resolved Case Enquiries")
                    {
                        Caption = 'Resolved Cases Enquiries';

                        Image = Capacity;
                        // RunObject = page "Lead list Closed";
                        // RunPageView = WHERE(status = CONST(Resolved));
                        ToolTip = 'Resolved Cases Enquiries';
                    }

                    group("CRM Reports")
                    {
                        action("Resolved Cases")
                        {
                            Caption = 'Resolved Cases';
                            ApplicationArea = basic, suite;
                            Image = Report;
                            //RunObject = report "CRM Resolved Cases Report";
                            ToolTip = 'Resolved Cases';
                        }
                        action("UnResolved Cases")
                        {
                            Caption = 'UnResolved Cases';
                            ApplicationArea = basic, suite;
                            Image = Report;
                            // RunObject = report "CRM UnResolved Cases Report";
                            ToolTip = 'UnResolved Cases';
                        }
                    }
                }
                group("CRM Gen Setup")
                {
                    action("CRM General setup")
                    {
                        Caption = 'CRM General Setup';
                        ApplicationArea = basic, suite;
                        Image = Capacity;
                        // RunObject = page "CRM General SetUp";
                        ToolTip = 'CRM Setup';
                    }
                    action("CRM CaseS types")
                    {
                        Caption = 'CRM Case types';
                        ApplicationArea = basic, suite;
                        Image = Capacity;
                        //RunObject = page "CRM Case Types";
                        ToolTip = 'CRM Case Types';
                        Visible = false;
                    }
                }
            }

            //........................... End of CRM MAIN MENU ...............................................


        }


    }
}
