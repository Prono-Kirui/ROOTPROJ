page 51060 "Cash Management Role Center"
{
    ApplicationArea = All;
    Caption = 'Cash Management Role Center';
    PageType = RoleCenter;

    /* actions
    {
        area(sections)
        {
            group(Setups)
            {
                action(CashSetup)
                {
                    Caption = 'Cash Management Setup';
                    Image = Setup;
                    RunObject = page "Cash Management Setups";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Cash Management Setup action';
                }
                action("Imprest Types")
                {
                    RunObject = page "Imprest Types";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Imprest Types action';
                }
                action("Payment Types")
                {
                    Caption = 'Payments & Petty Cash Types';
                    RunObject = page "Payment Types";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Payments & Petty Cash Types action';
                }
                action("Receipt Types")
                {
                    RunObject = page "Receipt Types";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Receipt Types action';
                }
                action("Advance Types")
                {
                    RunObject = page "Advance Types";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Advance Types action';
                }
                action("Claim Types")
                {
                    RunObject = page "Claim Types";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Claim Types action';
                }
                action("Expense Codes")
                {
                    RunObject = page "Expense Codes";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Expense Codes action';
                }
                action("Destination Codes")
                {
                    RunObject = page "Destination Code";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Destination Codes action';
                }
                action("User Posting Template")
                {
                    RunObject = page "User Posting Template";
                    ApplicationArea = All;
                    ToolTip = 'Executes the User Posting Template action';
                }
                action("Banker Cheque Register")
                {
                    RunObject = page "Banks Cheque Register";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Banker Cheque Register action';
                }
                action("Cash Office User Template")
                {
                    RunObject = page "Cash Office User Template";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Cash Office User Template action';
                }
            }
            group("Self Service")
            {
                Caption = 'Self Service';
                action("Change Passoword")
                {
                    Caption = 'Change My Password';
                    RunObject = report "Change Password";
                    ApplicationArea = All;
                    ToolTip = 'Change Password';
                }
                group("Finance")
                {
                    Caption = 'Finance Management';
                    action(Imprests)
                    {
                        RunObject = page "Imprests-General";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Imprests action';
                        Caption = 'Imprest';
                    }
                    action("Imprest Surrenders ")
                    {
                        RunObject = page "Imprest Surrenders-General";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Imprest Surrenders  action';
                        Caption = 'Imprest Surrender';
                    }
                    action("Staff Claim List ")
                    {
                        RunObject = page "Staff Claim List-General";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Staff Claim List  action';
                        Caption = 'Staff Claim';
                    }
                    action("Petty Cash")
                    {
                        RunObject = page "Petty Cash List-General";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Petty Cash action';
                        Caption = 'Petty Cash';
                    }
                    action("Petty Cash Surrenders")
                    {
                        RunObject = page "Petty Cash Surrenders-Gen";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Petty Cash Surrenders action';
                        Caption = 'Petty Cash Surrender';
                    }
                    action("Budget Approval Listss")
                    {
                        RunObject = page "Budget Approval List";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Budget Approval List action';
                        Caption = 'Budget Approval';
                    }
                }
                group(Procurement)
                {
                    Caption = 'Procurement Management';
                    action("Purchase Request List ")
                    {
                        Caption = 'Procurement Requisition Form';
                        RunObject = page "Purchase Request List-General";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Purchase Request List  action';
                    }
                    action("Store Request List ")
                    {
                        RunObject = page "Store Request List-General";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Store Request List  action';
                        Caption = 'Store Requisition';
                    }
                    action("Annual Procurement Plan Request")
                    {
                        RunObject = page "Procurement Plan Approval List";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Petty Cash Surrenders action';
                        Caption = 'Annual Procurement Plan Request';
                    }

                    group("Tenders ")
                    {
                        Caption = 'Tender Management';
                        group("OpeningSelf")
                        {
                            Caption = 'Tender Opening';

                            action(TenderOpeningSelf)
                            {
                                Caption = 'Tender Opening';
                                RunObject = page "Tender Opening List";
                                RunPageLink = "Tender Opened" = const(false), "Document Type" = const(Tender);
                                ApplicationArea = All;
                            }
                            action(TenderOpeningArchiveSelf)
                            {
                                Caption = 'Tenders Opened';
                                RunObject = page "Tender Opening List";
                                RunPageLink = "Tender Opened" = const(true), "Document Type" = const(Tender);
                                ApplicationArea = All;
                            }
                        }
                        group("PreliminarySelf")
                        {
                            Caption = 'Preliminary Evaluation';

                            action("Supplier Evaluation-PreliminarySelf")
                            {
                                Image = List;
                                RunObject = page "Supplier Evaluation List";
                                RunPageLink = "Evaluation Stage" = const("Preliminary Evaluation");
                                ApplicationArea = All;
                                ToolTip = 'Executes the Supplier Evaluation action';
                                Caption = 'Supplier Evaluation-Preliminary';
                            }
                            action("Supplier Evaluation-Failed PreliminarySelf")
                            {
                                Image = List;
                                RunObject = page "Supplier Evaluation List";
                                RunPageLink = "Evaluation Stage" = const("Failed Preliminary");
                                ApplicationArea = All;
                                ToolTip = 'Executes the Supplier Evaluation action';
                                Caption = 'Failed Preliminary Evaluation';
                            }
                        }
                        group("Technical EvaluationSelf")
                        {
                            Caption = 'Technical Evaluation';
                            action("Supplier Evaluation-TechnicalSelf")
                            {
                                Image = List;
                                RunObject = page "Supplier Evaluation List";
                                RunPageLink = "Evaluation Stage" = const("Technical Evaluation");
                                ApplicationArea = All;
                                ToolTip = 'Executes the Supplier Evaluation action';
                                Caption = 'Supplier Evaluation-Technical';
                            }
                            action("Supplier Evaluation-Failed TechnicalSelf")
                            {
                                Image = List;
                                RunObject = page "Supplier Evaluation List";
                                RunPageLink = "Evaluation Stage" = const("Failed Technical");
                                ApplicationArea = All;
                                ToolTip = 'Executes the Supplier Evaluation action';
                                Caption = 'Failed Technical Evaluation';
                            }
                        }
                        group(FinanicalEvaluation)
                        {
                            Caption = 'Financial Evaluation';

                            action("Tender evaluation listSelf")
                            {
                                Image = List;
                                RunObject = page "Tender Evaluation List";
                                RunPageLink = Status = const(New);
                                ApplicationArea = All;
                                ToolTip = 'Executes the Financial evaluation list action';
                                Caption = 'Financial Evaluation List';
                            }
                        }
                        group("PrequalificationOpeningSelf")
                        {
                            Caption = 'Prequalification Tender Opening';

                            action(PrequalificationTenderOpeningSelf)
                            {
                                Caption = 'Tender Opening';
                                RunObject = page "Tender Opening List";
                                RunPageLink = "Tender Opened" = const(false), "Document Type" = const("Supplier Prequalification");
                                ApplicationArea = All;
                            }
                            action(PrequalificationTenderOpeningArchiveSelf)
                            {
                                Caption = 'Tenders Opened';
                                RunObject = page "Tender Opening List";
                                RunPageLink = "Tender Opened" = const(true), "Document Type" = const("Supplier Prequalification");
                                ApplicationArea = All;
                            }
                        }
                    }
                }
                group("Human Resource")
                {
                    Caption = 'Human Resource Management';
                    action("Leave Applications List")
                    {
                        RunObject = page "Leave Application List-General";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Leave Applications List action';
                        Caption = 'Leave Application';
                    }
                    action("Transport Request")
                    {
                        RunObject = page "Transport requests -General";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Transport Request action';
                        Caption = 'Transport Request';
                    }
                    action("Training Requests List ")
                    {
                        RunObject = page "Training Request List-General";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Training Requests List  action';
                        Caption = 'Training Request';
                    }
                    action("Appraisal Lists")
                    {
                        RunObject = page "Appraisal List";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Appraisal List - Objectives action';
                        Caption = 'Performance Appraisal';
                    }
                    action("My Leave Statement")
                    {
                        RunObject = report "My Leave Statement";
                        ApplicationArea = All;
                        Caption = 'My Leave Statement';
                        ToolTip = 'Shows a detailed Leave Statement per Leave Type';
                    }
                }
                group("Payroll Mgt")
                {
                    Caption = 'Payroll Management';
                    action("Payroll Requests ")
                    {
                        Image = Reuse;
                        RunObject = page "Payroll Requests-Self Service";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Payroll Requests action';
                        Caption = 'Payroll Request';
                    }
                    action(Payslip)
                    {
                        Caption = 'My Payslip';
                        RunObject = report "New Payslipx-Self Service";
                        ApplicationArea = All;
                        ToolTip = 'Executes the My Payslip action';
                    }
                    action(P9)
                    {
                        Caption = 'My P9';
                        RunObject = report "P9A Report-Self Service";
                        ApplicationArea = All;
                        ToolTip = 'Executes the My P9 action';
                    }
                }
                group(ICT)
                {
                    Caption = 'ICT Management';
                    action(Incidentss)
                    {
                        Caption = 'Service Desk';
                        RunObject = page "Incident Reports";
                        ApplicationArea = All;
                    }
                    action(MyIncidentss)
                    {
                        Caption = 'Solve A Request';
                        RunObject = page "Incident Reports - Pending";
                        ApplicationArea = All;
                    }
                }
                action(CustomerStatement)
                {
                    Caption = 'My Customer Statement';
                    RunObject = report "Customer Statement";
                    ApplicationArea = All;
                    ToolTip = 'Executes the My Customer Statement action';
                    Visible = false;
                }
            }
            group(Lists)
            {
                action("Bank Accounts")
                {
                    RunObject = page "Bank Account List";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Bank Accounts action';
                }
                action("Payment Reconciliation Journals")
                {
                    RunObject = page "Pmt. Reconciliation Journals";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Payment Reconciliation Journals action';
                }
                action("Bank Acc. Reconciliation List")
                {
                    RunObject = page "Bank Acc. Reconciliation List";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Bank Acc. Reconciliation List action';
                }
                action("Posted Payment Reconciliations")
                {
                    RunObject = page "Posted Payment Reconciliations";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Posted Payment Reconciliations action';
                }
            }
            group(Archive)
            {
                action("Bank Account Ledger Entries")
                {
                    RunObject = page "Bank Account Ledger Entries";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Bank Account Ledger Entries action';
                }
                action("Check Ledger Entries")
                {
                    RunObject = page "Check Ledger Entries";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Check Ledger Entries action';
                }
            }
            group("Inter Bank Transfers")
            {
                action("InterBank Transfer List")
                {
                    RunObject = page "InterBank Transfer List";
                    ApplicationArea = All;
                    ToolTip = 'Executes the InterBank Transfer List action';
                }
                action("Approved InterBank Transfer")
                {
                    RunObject = page "Approved InterBank Transfer";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Approved InterBank Transfer action';
                }
            }
            group("Inter Bank Transfers Archive")
            {
                action("Posted InterBank Transfers")
                {
                    RunObject = page "Posted InterBank Transfer";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Posted InterBank Transfers action';
                }
            }
        }
        area(reporting)
        {
        }
    } */
}
