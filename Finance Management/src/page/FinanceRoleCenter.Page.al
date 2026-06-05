page 51061 "Finance Role Center"
{
    ApplicationArea = All;
    Caption = 'Finance Role Center';
    Extensible = true;
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control76; "Headline RC Accountant")
            {
                Caption = 'Headline RC Accountant';
                Visible = false;
            }
            part("Finance Management Cues"; "Finance Management Cues")
            {
                Caption = 'Finance Management';
            }
            part(ApprovalActivities; "Approvals Activities")
            {
                Caption = 'Approval Activities';
            }
            part("User Tasks Activities"; "User Tasks Activities")
            {
                ApplicationArea = Suite;
                Caption = 'User Tasks Activities';
                Visible = false;
            }
            part(Control16; "O365 Activities")
            {
                AccessByPermission = tabledata "Activities Cue" = I;
                Caption = 'O365 Activities';
                Visible = false;
            }
        }
    }

    actions
    {
        area(embedding)
        {
            action("Approval Request Entries")
            {
                Caption = 'Approval Request Entries';
                RunObject = page "Approval Request Entries";
                ToolTip = 'Executes the Approval Request Entries action';
            }
        }
        area(sections)
        {
            group("Group")
            {
                Caption = 'General Ledger';

                action("Chart of Accounts12")
                {
                    Caption = 'Chart of Accounts';
                    RunObject = page "Chart of Accounts";
                    ToolTip = 'Executes the Chart of Accounts action';
                }
                action(Budgets)
                {
                    ApplicationArea = Suite;
                    Caption = 'G/L Budgets';
                    RunObject = page "G/L Budget Names";
                    ToolTip = 'Executes the G/L Budgets action';
                }
                action("Account Schedules1")
                {
                    Caption = 'Account Schedules new';
                    RunObject = page "Financial Reports";
                    ToolTip = 'Executes the Account Schedules action';
                }
                action("Account Schedules")
                {
                    Caption = 'Account Schedules';
                    RunObject = page "Account Schedule Names";
                    ToolTip = 'Executes the Account Schedules action';
                }
                action("Analyses by Dimensions")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Analysis by Dimensions';
                    RunObject = page "Analysis View List";
                    ToolTip = 'Executes the Analysis by Dimensions action';
                }
                group(Group1)
                {
                    Caption = 'VAT';

                    action("VAT Statements")
                    {
                        Caption = 'VAT Statements';
                        RunObject = page "VAT Statement";
                        ToolTip = 'Executes the VAT Statements action';
                    }
                    action("VAT Returns")
                    {
                        Caption = 'VAT Returns';
                        RunObject = page "VAT Report List";
                        ToolTip = 'Executes the VAT Returns action';
                    }
                    group(Group2)
                    {
                        Caption = 'Reports';

                        action("VAT Exceptions")
                        {
                            Caption = 'VAT Exceptions';
                            RunObject = report "VAT Exceptions";
                            ToolTip = 'Executes the VAT Exceptions action';
                        }
                        action("VAT Register")
                        {
                            Caption = 'VAT Register';
                            RunObject = report "VAT Register";
                            ToolTip = 'Executes the VAT Register action';
                        }
                        action("VAT Registration No. Check")
                        {
                            Caption = 'Batch VAT Registration No. Check';
                            RunObject = report "VAT Registration No. Check";
                            ToolTip = 'Executes the Batch VAT Registration No. Check action';
                        }
                        action("VAT Statement")
                        {
                            Caption = 'VAT Statement';
                            RunObject = report "VAT Statement";
                            ToolTip = 'Executes the VAT Statement action';
                        }
                        action("VAT- VIES Declaration Tax Auth")
                        {
                            Caption = 'VAT- VIES Declaration Tax Auth';
                            RunObject = report "VAT- VIES Declaration Tax Auth";
                            ToolTip = 'Executes the VAT- VIES Declaration Tax Auth action';
                        }
                        action("VAT- VIES Declaration Disk")
                        {
                            Caption = 'VAT- VIES Declaration Disk...';
                            RunObject = report "VAT- VIES Declaration Disk";
                            ToolTip = 'Executes the VAT- VIES Declaration Disk... action';
                        }
                        action("Day Book VAT Entry")
                        {
                            Caption = 'Day Book VAT Entry';
                            RunObject = report "Day Book VAT Entry";
                            ToolTip = 'Executes the Day Book VAT Entry action';
                        }
                        action("Day Book Cust. Ledger Entry")
                        {
                            Caption = 'Day Book Cust. Ledger Entry';
                            RunObject = report "Day Book Cust. Ledger Entry";
                            ToolTip = 'Executes the Day Book Cust. Ledger Entry action';
                        }
                        action("Day Book Vendor Ledger Entry")
                        {
                            Caption = 'Day Book Vendor Ledger Entry';
                            RunObject = report "Day Book Vendor Ledger Entry";
                            ToolTip = 'Executes the Day Book Vendor Ledger Entry action';
                        }
                        action("Petty Cash Summary")
                        {
                            Caption = 'Petty Cash Summary Report';
                            RunObject = report "Petty Cash Summary";
                            ToolTip = 'Executes the Petty Cash Summary Report';
                        }
                        action("VAT Purchases")
                        {
                            Caption = 'VAT Purchases';
                            RunObject = report "VAT Purchases";
                            ToolTip = 'Executes the VAT Purchases action';
                        }
                    }
                }
                group(Group3)
                {
                    Caption = 'Intercompany';

                    action("General Journals")
                    {
                        ApplicationArea = Intercompany;
                        Caption = 'Intercompany General Journal';
                        RunObject = page "IC General Journal";
                        ToolTip = 'Executes the Intercompany General Journal action';
                    }
                    action("Inbox Transactions")
                    {
                        ApplicationArea = Intercompany;
                        Caption = 'Intercompany Inbox Transactions';
                        RunObject = page "IC Inbox Transactions";
                        ToolTip = 'Executes the Intercompany Inbox Transactions action';
                    }
                    action("Outbox Transactions")
                    {
                        ApplicationArea = Intercompany;
                        Caption = 'Intercompany Outbox Transactions';
                        RunObject = page "IC Outbox Transactions";
                        ToolTip = 'Executes the Intercompany Outbox Transactions action';
                    }
                    action("Handled Inbox Transactions")
                    {
                        ApplicationArea = Intercompany;
                        Caption = 'Handled Intercompany Inbox Transactions';
                        RunObject = page "Handled IC Inbox Transactions";
                        ToolTip = 'Executes the Handled Intercompany Inbox Transactions action';
                    }
                    action("Handled Outbox Transactions")
                    {
                        ApplicationArea = Intercompany;
                        Caption = 'Handled Intercompany Outbox Transactions';
                        RunObject = page "Handled IC Outbox Transactions";
                        ToolTip = 'Executes the Handled Intercompany Outbox Transactions action';
                    }
                    action("Intercompany Transactions")
                    {
                        ApplicationArea = Intercompany;
                        Caption = 'IC Transaction';
                        RunObject = report "IC Transactions";
                        ToolTip = 'Executes the IC Transaction action';
                    }
                }
                group(Group4)
                {
                    Caption = 'Consolidation';

                    action("Business Units")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Business Units';
                        RunObject = page "Business Unit List";
                        ToolTip = 'Executes the Business Units action';
                    }
                    action("Export Consolidation")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Export Consolidation...';
                        RunObject = report "Export Consolidation";
                        ToolTip = 'Executes the Export Consolidation... action';
                    }
                    action("G/L Consolidation Eliminations")
                    {
                        ApplicationArea = Suite;
                        Caption = 'G/L Consolidation Eliminations';
                        RunObject = report "G/L Consolidation Eliminations";
                        ToolTip = 'Executes the G/L Consolidation Eliminations action';
                    }
                }
                group(Group5)
                {
                    Caption = 'Journals';

                    action("General Journals1")
                    {
                        Caption = 'General Journals';
                        RunObject = page "General Journal";
                        ToolTip = 'Executes the General Journals action';
                    }
                    action("Recurring Journals")
                    {
                        ApplicationArea = Suite, FixedAssets;
                        Caption = 'Recurring General Journals';
                        RunObject = page "Recurring General Journal";
                        ToolTip = 'Executes the Recurring General Journals action';
                    }
                    action("General Journals2")
                    {
                        ApplicationArea = Intercompany;
                        Caption = 'Intercompany General Journal';
                        RunObject = page "IC General Journal";
                        ToolTip = 'Executes the Intercompany General Journal action';
                    }
                    action("GL Register/User Reviews")
                    {
                        Caption = 'GL Register/User Reviews';
                        RunObject = report "GL History vs Approvals";
                        ToolTip = 'Executes the GL Register/User Reviews action';
                    }
                }
                group(Group6)
                {
                    Caption = 'Register/Entries';

                    action("G/L Registers12")
                    {
                        Caption = 'G/L Registers';
                        RunObject = page "G/L Registers";
                        ToolTip = 'Executes the G/L Registers action';
                    }
                    action(Navigate)
                    {
                        ApplicationArea = Basic, Suite, FixedAssets, CostAccounting;
                        Caption = 'Navigate';
                        RunObject = page Navigate;
                        ToolTip = 'Executes the Navigate action';
                    }
                    action("General Ledger Entries12")
                    {
                        Caption = 'General Ledger Entries';
                        RunObject = page "General Ledger Entries";
                        ToolTip = 'Executes the General Ledger Entries action';
                    }
                    action("G/L Budget Entries12")
                    {
                        ApplicationArea = Suite;
                        Caption = 'G/L Budget Entries';
                        RunObject = page "G/L Budget Entries";
                        ToolTip = 'Executes the G/L Budget Entries action';
                    }
                    action("VAT Entries12")
                    {
                        Caption = 'VAT Entries';
                        RunObject = page "VAT Entries";
                        ToolTip = 'Executes the VAT Entries action';
                    }
                    action("Analysis View Entries12")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Analysis View Entries';
                        RunObject = page "Analysis View Entries";
                        ToolTip = 'Executes the Analysis View Entries action';
                    }
                    action("Analysis View Budget Entries12")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Analysis View Budget Entries';
                        RunObject = page "Analysis View Budget Entries";
                        ToolTip = 'Executes the Analysis View Budget Entries action';
                    }
                    action("Item Budget Entries12")
                    {
                        ApplicationArea = ItemBudget;
                        Caption = 'Item Budget Entries';
                        RunObject = page "Item Budget Entries";
                        ToolTip = 'Executes the Item Budget Entries action';
                    }
                    action("User Reviews")
                    {
                        Caption = 'GL Register/User Reviews';
                        RunObject = report "GL History vs Approvals";
                        ToolTip = 'Executes the GL Register/User Reviews action';
                    }
                }
                group(Group7)
                {
                    Caption = 'Reports';

                    group(Group8)
                    {
                        Caption = 'Entries';

                        action("G/L Register")
                        {
                            Caption = 'G/L Register';
                            RunObject = report "G/L Register";
                            ToolTip = 'Executes the G/L Register action';
                        }
                        action("Detail Trial Balance")
                        {
                            Caption = 'Detail Trial Balance';
                            RunObject = report "Detail Trial Balance";
                            ToolTip = 'Executes the Detail Trial Balance action';
                        }
                        action("Detail Trial Balance-Budget")
                        {
                            Caption = 'Detail Trial Balance by Budget';
                            RunObject = report "Det. Trial Balance-Budget";
                            Tooltip = 'Prints the Detail Trial Balance by Budget';
                        }
                        action("Detail Trial Balance-SubBudget")
                        {
                            Caption = 'Detail Trial Balance by Sub Budget';
                            RunObject = report "Det. Trial Balance-Sub Budget";
                            ToolTip = 'Prints the Detail Trial Balance by Sub Budget';
                        }
                        action("Detail Trial Balance-Add")
                        {
                            Caption = 'Detail Trial Balance by Sub Budget (Additional Currency)';
                            RunObject = report "Det. Trial Bal-Sub Budget Add.";
                            ToolTip = 'Prints the Detail Trial Balance by Sub Budget (Additional Currency)';
                        }
                        action("Dimensions - Detail")
                        {
                            ApplicationArea = Dimensions;
                            Caption = 'Dimensions - Detail';
                            RunObject = report "Dimensions - Detail";
                            ToolTip = 'Executes the Dimensions - Detail action';
                        }
                        action("Dimensions - Total")
                        {
                            ApplicationArea = Dimensions;
                            Caption = 'Dimensions - Total';
                            RunObject = report "Dimensions - Total";
                            ToolTip = 'Executes the Dimensions - Total action';
                        }
                        action("Check Value Posting")
                        {
                            Caption = 'Dimension Check Value Posting';
                            RunObject = report "Check Value Posting";
                            ToolTip = 'Executes the Dimension Check Value Posting action';
                        }
                    }
                    group(Group9)
                    {
                        Caption = 'Financial Statement';

                        action("Account Schedule")
                        {
                            Caption = 'Account Schedule';
                            RunObject = report "Account Schedule";
                            ToolTip = 'Executes the Account Schedule action';
                        }
                        action("Trial Balance")
                        {
                            Caption = 'Trial Balance';
                            RunObject = report "Trial Balance";
                            ToolTip = 'Executes the Trial Balance action';
                        }
                        action("Trial Balance/Budget")
                        {
                            Caption = 'Trial Balance/Budget';
                            RunObject = report "Trial Balance/Budget";
                            ToolTip = 'Executes the Trial Balance/Budget action';
                        }
                        action("Trial Balance/Previous Year")
                        {
                            Caption = 'Trial Balance/Previous Year';
                            RunObject = report "Trial Balance/Previous Year";
                            ToolTip = 'Executes the Trial Balance/Previous Year action';
                        }
                        action("Closing Trial Balance")
                        {
                            Caption = 'Closing Trial Balance';
                            RunObject = report "Closing Trial Balance";
                            ToolTip = 'Executes the Closing Trial Balance action';
                        }
                        action("Consolidated Trial Balance")
                        {
                            ApplicationArea = Suite;
                            Caption = 'Consolidated Trial Balance';
                            RunObject = report "Consolidated Trial Balance";
                            ToolTip = 'Executes the Consolidated Trial Balance action';
                        }
                        action("Consolidated Trial Balance (4)")
                        {
                            ApplicationArea = Suite;
                            Caption = 'Consolidated Trial Balance (4)';
                            RunObject = report "Consolidated Trial Balance (4)";
                            ToolTip = 'Executes the Consolidated Trial Balance (4) action';
                        }
                        action(Budget)
                        {
                            ApplicationArea = Suite;
                            Caption = 'Budget';
                            RunObject = report Budget;
                            ToolTip = 'Executes the Budget action';
                        }
                        action("Trial Balance by Period")
                        {
                            Caption = 'Trial Balance by Period';
                            RunObject = report "Trial Balance by Period";
                            ToolTip = 'Executes the Trial Balance by Period action';
                        }
                        action("Fiscal Year Balance")
                        {
                            Caption = 'Fiscal Year Balance';
                            RunObject = report "Fiscal Year Balance";
                            ToolTip = 'Executes the Fiscal Year Balance action';
                        }
                        action("Balance Comp. - Prev. Year")
                        {
                            Caption = 'Balance Comp. - Prev. Year';
                            RunObject = report "Balance Comp. - Prev. Year";
                            ToolTip = 'Executes the Balance Comp. - Prev. Year action';
                        }
                        action("Balance Sheet")
                        {
                            AccessByPermission = tabledata "G/L Account" = R;
                            Caption = 'Balance Sheet';
                            RunObject = codeunit "Run Acc. Sched. Balance Sheet";
                            ToolTip = 'Executes the Balance Sheet action';
                        }
                        action("Income Statement")
                        {
                            AccessByPermission = tabledata "G/L Account" = R;
                            Caption = 'Income Statement';
                            RunObject = codeunit "Run Acc. Sched. Income Stmt.";
                            ToolTip = 'Executes the Income Statement action';
                        }
                        action("Statement of Cashflows")
                        {
                            AccessByPermission = tabledata "G/L Account" = R;
                            Caption = 'Cash Flow Statement';
                            RunObject = codeunit "Run Acc. Sched. CashFlow Stmt.";
                            ToolTip = 'Executes the Cash Flow Statement action';
                        }
                        action("Statement of Retained Earnings")
                        {
                            AccessByPermission = tabledata "G/L Account" = R;
                            Caption = 'Retained Earnings Statement';
                            RunObject = codeunit "Run Acc. Sched. Retained Earn.";
                            ToolTip = 'Executes the Retained Earnings Statement action';
                        }
                    }
                    group(Group10)
                    {
                        Caption = 'Miscellaneous';

                        action("Foreign Currency Balance")
                        {
                            Caption = 'Foreign Currency Balance';
                            RunObject = report "Foreign Currency Balance";
                            ToolTip = 'Executes the Foreign Currency Balance action';
                        }
                        action("Reconcile Cust. and Vend. Accs")
                        {
                            Caption = 'Reconcile Cust. and Vend. Accs';
                            RunObject = report "Reconcile Cust. and Vend. Accs";
                            ToolTip = 'Executes the Reconcile Cust. and Vend. Accs action';
                        }
                        action("G/L Deferral Summary")
                        {
                            Caption = 'G/L Deferral Summary';
                            RunObject = report "Deferral Summary - G/L";
                            ToolTip = 'Executes the G/L Deferral Summary action';
                        }
                    }
                    group(Group11)
                    {
                        Caption = 'Setup List';

                        action("Chart of Accounts1")
                        {
                            Caption = 'Chart of Accounts';
                            RunObject = report "Chart of Accounts";
                            ToolTip = 'Executes the Chart of Accounts action';
                        }
                        action("Change Log Setup List")
                        {
                            Caption = 'Change Log Setup List';
                            RunObject = report "Change Log Setup List";
                            ToolTip = 'Executes the Change Log Setup List action';
                        }
                    }
                }
                group(Group12)
                {
                    Caption = 'Setups';

                    action("General Ledger Setup")
                    {
                        Caption = 'General Ledger Setup';
                        RunObject = page "General Ledger Setup";
                        ToolTip = 'Executes the General Ledger Setup action';
                    }
                    action("Deferral Template List")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Deferral Templates';
                        RunObject = page "Deferral Template List";
                        ToolTip = 'Executes the Deferral Templates action';
                    }
                    action("Journal Templates")
                    {
                        Caption = 'General Journal Templates';
                        RunObject = page "General Journal Templates";
                        ToolTip = 'Executes the General Journal Templates action';
                    }
                    action("G/L Account Categories")
                    {
                        AccessByPermission = tabledata "G/L Account Category" = R;
                        Caption = 'G/L Account Categories';
                        RunObject = page "G/L Account Categories";
                        ToolTip = 'Executes the G/L Account Categories action';
                    }
                    action("VAT Report Setup")
                    {
                        Caption = 'VAT Report Setup';
                        RunObject = page "VAT Report Setup";
                        ToolTip = 'Executes the VAT Report Setup action';
                    }
                }
            }
            group(Group13)
            {
                Caption = 'Cash Management';

                action("Bank Accounts12")
                {
                    Caption = 'Bank Accounts';
                    RunObject = page "Bank Account List";
                    ToolTip = 'Executes the Bank Accounts action';
                }
                action("Receivables-Payables")
                {
                    ApplicationArea = Suite;
                    Caption = 'Receivables-Payables';
                    RunObject = page "Receivables-Payables";
                    ToolTip = 'Executes the Receivables-Payables action';
                }
                action("Payment Registration")
                {
                    Caption = 'Payment Registration';
                    RunObject = page "Payment Registration";
                    ToolTip = 'Executes the Payment Registration action';
                }
                group(Group14)
                {
                    Caption = 'Cash Flow';

                    action("Cash Flow Forecasts")
                    {
                        Caption = 'Cash Flow Forecasts';
                        RunObject = page "Cash Flow Forecast List";
                        ToolTip = 'Executes the Cash Flow Forecasts action';
                    }
                    action("Chart of Cash Flow Accounts")
                    {
                        Caption = 'Chart of Cash Flow Accounts';
                        RunObject = page "Chart of Cash Flow Accounts";
                        ToolTip = 'Executes the Chart of Cash Flow Accounts action';
                    }
                    action("Cash Flow Manual Revenues")
                    {
                        Caption = 'Cash Flow Manual Revenues';
                        RunObject = page "Cash Flow Manual Revenues";
                        ToolTip = 'Executes the Cash Flow Manual Revenues action';
                    }
                    action("Cash Flow Ledger Entries")
                    {
                        Caption = 'Cash Flow Manual Expenses';
                        RunObject = page "Cash Flow Manual Expenses";
                        ToolTip = 'Executes the Cash Flow Manual Expenses action';
                    }
                    action("Cash Flow Worksheet")
                    {
                        Caption = 'Cash Flow Worksheet';
                        RunObject = page "Cash Flow Worksheet";
                        ToolTip = 'Executes the Cash Flow Worksheet action';
                    }
                }
                group(Group15)
                {
                    Caption = 'Reconciliation';

                    action("Bank Account Reconciliations")
                    {
                        Caption = 'Bank Account Reconciliations';
                        RunObject = page "Bank Acc. Reconciliation List";
                        ToolTip = 'Executes the Bank Account Reconciliations action';
                    }
                    action("Posted Payment Reconciliations12")
                    {
                        Caption = 'Posted Payment Reconciliations';
                        RunObject = page "Posted Payment Reconciliations";
                        ToolTip = 'Executes the Posted Payment Reconciliations action';
                    }
                    action("Payment Reconciliation Journals12")
                    {
                        Caption = 'Payment Reconciliation Journals';
                        RunObject = page "Pmt. Reconciliation Journals";
                        ToolTip = 'Executes the Payment Reconciliation Journals action';
                    }
                }
                group(Group16)
                {
                    Caption = 'Journals';

                    action("Cash Receipt Journal")
                    {
                        Caption = 'Cash Receipt Journals';
                        RunObject = page "Cash Receipt Journal";
                        ToolTip = 'Executes the Cash Receipt Journals action';
                    }
                    action("Payment Journals")
                    {
                        Caption = 'Payment Journals';
                        RunObject = page "Payment Journal";
                        ToolTip = 'Executes the Payment Journals action';
                    }
                    action("Payment Reconciliation Journals1")
                    {
                        Caption = 'Payment Reconciliation Journals';
                        RunObject = page "Pmt. Reconciliation Journals";
                        ToolTip = 'Executes the Payment Reconciliation Journals action';
                    }
                }
                group(Group17)
                {
                    Caption = 'Ledger Entries';

                    action("Bank Account Ledger Entries12")
                    {
                        Caption = 'Bank Account Ledger Entries';
                        RunObject = page "Bank Account Ledger Entries";
                        ToolTip = 'Executes the Bank Account Ledger Entries action';
                    }
                    action("Check Ledger Entries12")
                    {
                        Caption = 'Check Ledger Entries';
                        RunObject = page "Check Ledger Entries";
                        ToolTip = 'Executes the Check Ledger Entries action';
                    }
                    action("Cash Flow Ledger Entries1")
                    {
                        Caption = 'Cash Flow Ledger Entries';
                        RunObject = page "Cash Flow Forecast Entries";
                        ToolTip = 'Executes the Cash Flow Ledger Entries action';
                    }
                }
                group(Group18)
                {
                    Caption = 'Reports';

                    action(Register)
                    {
                        Caption = 'Bank Account Register';
                        RunObject = report "Bank Account Register";
                        ToolTip = 'Executes the Bank Account Register action';
                    }
                    action("Check Details")
                    {
                        Caption = 'Bank Account - Check Details';
                        RunObject = report "Bank Account - Check Details";
                        ToolTip = 'Executes the Bank Account - Check Details action';
                    }
                    action("Labels")
                    {
                        Caption = 'Bank Account - Labels';
                        RunObject = report "Bank Account - Labels";
                        ToolTip = 'Executes the Bank Account - Labels action';
                    }
                    action("List")
                    {
                        Caption = 'Bank Account - List';
                        RunObject = report "Bank Account - List";
                        ToolTip = 'Executes the Bank Account - List action';
                    }
                    action("Detail Trial Bal.")
                    {
                        Caption = 'Bank Acc. - Detail Trial Bal.';
                        RunObject = report "Bank Acc. - Detail Trial Bal.";
                        ToolTip = 'Executes the Bank Acc. - Detail Trial Bal. action';
                    }
                    action("Receivables-Payables1")
                    {
                        Caption = 'Receivables-Payables';
                        RunObject = report "Receivables-Payables";
                        ToolTip = 'Executes the Receivables-Payables action';
                    }
                    action("Cash Flow Date List")
                    {
                        Caption = 'Cash Flow Date List';
                        RunObject = report "Cash Flow Date List";
                        ToolTip = 'Executes the Cash Flow Date List action';
                    }
                    action("Dimensions - Detail1")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Cash Flow Dimensions - Detail';
                        RunObject = report "Cash Flow Dimensions - Detail";
                        ToolTip = 'Executes the Cash Flow Dimensions - Detail action';
                    }
                    action("Petty Cash Summary Report")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Petty Cash Summary Report';
                        RunObject = report "Petty Cash Summary";
                        ToolTip = 'Executes the Petty Cash Summary Report';
                    }
                }
                group(Group19)
                {
                    Caption = 'Setup';

                    action("Payment Application Rules")
                    {
                        Caption = 'Payment Application Rules';
                        RunObject = page "Payment Application Rules";
                        ToolTip = 'Executes the Payment Application Rules action';
                    }
                    action("Cash Flow Setup")
                    {
                        Caption = 'Cash Flow Setup';
                        RunObject = page "Cash Flow Setup";
                        ToolTip = 'Executes the Cash Flow Setup action';
                    }
                    action("Report Selection - Cash Flow")
                    {
                        Caption = 'Cash Flow Report Selections';
                        RunObject = page "Report Selection - Cash Flow";
                        ToolTip = 'Executes the Cash Flow Report Selections action';
                    }
                    action("Report Selection - Bank Acc.")
                    {
                        Caption = 'Report Selections Bank Account';
                        RunObject = page "Report Selection - Bank Acc.";
                        ToolTip = 'Executes the Report Selections Bank Account action';
                    }
                    action("Payment Terms")
                    {
                        Caption = 'Payment Terms';
                        RunObject = page "Payment Terms";
                        ToolTip = 'Executes the Payment Terms action';
                    }
                    action("Payment Methods")
                    {
                        Caption = 'Payment Methods';
                        RunObject = page "Payment Methods";
                        ToolTip = 'Executes the Payment Methods action';
                    }
                    action(Currencies)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Currencies';
                        RunObject = page Currencies;
                        ToolTip = 'Executes the Currencies action';
                    }
                }
            }
            group(Group28)
            {
                Caption = 'Receivables';

                action(Customers)
                {
                    Caption = 'Customers';
                    RunObject = page "Customer List";
                    ToolTip = 'Executes the Customers action';
                }
                action(Invoices)
                {
                    Caption = 'Sales Invoices';
                    RunObject = page "Sales Invoice List";
                    ToolTip = 'Executes the Sales Invoices action';
                }
                action("Credit Memos")
                {
                    Caption = 'Sales Credit Memos';
                    RunObject = page "Sales Credit Memos";
                    ToolTip = 'Executes the Sales Credit Memos action';
                }
                action("Direct Debit Collections")
                {
                    ApplicationArea = Suite;
                    Caption = 'Direct Debit Collections';
                    RunObject = page "Direct Debit Collections";
                    ToolTip = 'Executes the Direct Debit Collections action';
                }
                action("Create Recurring Sales Invoice")
                {
                    Caption = 'Create Recurring Sales Invoices';
                    RunObject = report "Create Recurring Sales Inv.";
                    ToolTip = 'Executes the Create Recurring Sales Invoices action';
                }
                action("Register Customer Payments")
                {
                    Caption = 'Register Customer Payments';
                    RunObject = page "Payment Registration";
                    ToolTip = 'Executes the Register Customer Payments action';
                }
                group(Group29)
                {
                    Caption = 'Combine';

                    action("Combined Shipments")
                    {
                        Caption = 'Combine Shipments...';
                        RunObject = report "Combine Shipments";
                        ToolTip = 'Executes the Combine Shipments... action';
                    }
                    action("Combined Return Receipts")
                    {
                        ApplicationArea = SalesReturnOrder, PurchReturnOrder;
                        Caption = 'Combine Return Receipts...';
                        RunObject = report "Combine Return Receipts";
                        ToolTip = 'Executes the Combine Return Receipts... action';
                    }
                }
                group(Group30)
                {
                    Caption = 'Collection';

                    action(Reminders)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Reminders';
                        RunObject = page "Reminder List";
                        ToolTip = 'Executes the Reminders action';
                    }
                    action("Issued Reminders")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Issued Reminders';
                        RunObject = page "Issued Reminder List";
                        ToolTip = 'Executes the Issued Reminders action';
                    }
                    action("Finance Charge Memos")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Finance Charge Memos';
                        RunObject = page "Finance Charge Memo List";
                        ToolTip = 'Executes the Finance Charge Memos action';
                    }
                    action("Issued Finance Charge Memos")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Issued Finance Charge Memos';
                        RunObject = page "Issued Fin. Charge Memo List";
                        ToolTip = 'Executes the Issued Finance Charge Memos action';
                    }
                }
                group(Group31)
                {
                    Caption = 'Journals';

                    action(Journals)
                    {
                        Caption = 'Sales Journals';
                        RunObject = page "Sales Journal";
                        ToolTip = 'Executes the Sales Journals action';
                    }
                    action("Cash Receipt Journal1")
                    {
                        Caption = 'Cash Receipt Journals';
                        RunObject = page "Cash Receipt Journal";
                        ToolTip = 'Executes the Cash Receipt Journals action';
                    }
                }
                group(Group33)
                {
                    Caption = 'Registers/Entries';

                    action("G/L Registers1")
                    {
                        Caption = 'G/L Registers';
                        RunObject = page "G/L Registers";
                        ToolTip = 'Executes the G/L Registers action';
                    }
                    action("Customer Ledger Entries")
                    {
                        Caption = 'Customer Ledger Entries';
                        RunObject = page "Customer Ledger Entries";
                        ToolTip = 'Executes the Customer Ledger Entries action';
                    }
                    action("Reminder/Fin. Charge Entries")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Reminder/Fin. Charge Entries';
                        RunObject = page "Reminder/Fin. Charge Entries";
                        ToolTip = 'Executes the Reminder/Fin. Charge Entries action';
                    }
                    action("Detailed Cust. Ledg. Entries")
                    {
                        Caption = 'Detailed Customer Ledger Entries';
                        RunObject = page "Detailed Cust. Ledg. Entries";
                        ToolTip = 'Executes the Detailed Customer Ledger Entries action';
                    }
                }
                group(Group34)
                {
                    Caption = 'Reports';

                    action("Customer Detailed Aging")
                    {
                        Caption = 'Customer Detailed Aging';
                        RunObject = report "Customer Detailed Aging";
                        ToolTip = 'Executes the Customer Detailed Aging action';
                    }
                    action("Customer Statement")
                    {
                        Caption = 'Customer Statement';
                        RunObject = codeunit "Customer Layout - Statement";
                        ToolTip = 'Executes the Customer Statement action';
                    }
                    action("Customer Register")
                    {
                        Caption = 'Customer Register';
                        RunObject = report "Customer Register";
                        ToolTip = 'Executes the Customer Register action';
                    }
                    action("Customer - Balance to Date")
                    {
                        Caption = 'Customer - Balance to Date';
                        RunObject = report "Customer - Balance to Date";
                        ToolTip = 'Executes the Customer - Balance to Date action';
                    }
                    action("Customer - Detail Trial Bal.")
                    {
                        Caption = 'Customer - Detail Trial Bal.';
                        RunObject = report "Customer - Detail Trial Bal.";
                        ToolTip = 'Executes the Customer - Detail Trial Bal. action';
                    }
                    action("Customer - List")
                    {
                        Caption = 'Customer - List';
                        RunObject = report "Customer - List";
                        ToolTip = 'Executes the Customer - List action';
                    }
                    action("Customer - Summary Aging")
                    {
                        Caption = 'Customer - Summary Aging';
                        RunObject = report "Customer - Summary Aging";
                        ToolTip = 'Executes the Customer - Summary Aging action';
                    }
                    action("Customer - Summary Aging Simp.")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Customer - Summary Aging Simp.';
                        RunObject = report "Customer - Summary Aging Simp.";
                        ToolTip = 'Executes the Customer - Summary Aging Simp. action';
                    }
                    action("Customer - Order Summary")
                    {
                        Caption = 'Customer - Order Summary';
                        RunObject = report "Customer - Order Summary";
                        ToolTip = 'Executes the Customer - Order Summary action';
                    }
                    action("Customer - Order Detail")
                    {
                        Caption = 'Customer - Order Detail';
                        RunObject = report "Customer - Order Detail";
                        ToolTip = 'Executes the Customer - Order Detail action';
                    }
                    action("Customer - Labels")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Customer Labels';
                        RunObject = report "Customer - Labels";
                        ToolTip = 'Executes the Customer Labels action';
                    }
                    action("Customer - Top 10 List")
                    {
                        Caption = 'Customer Top 10 List';
                        RunObject = report "Customer - Top 10 List";
                        ToolTip = 'Executes the Customer Top 10 List action';
                    }
                    action("Sales Statistics")
                    {
                        Caption = 'Sales Statistics';
                        RunObject = report "Sales Statistics";
                        ToolTip = 'Executes the Sales Statistics action';
                    }
                    action("Customer/Item Sales")
                    {
                        Caption = 'Customer/Item Sales';
                        RunObject = report "Customer/Item Sales";
                        ToolTip = 'Executes the Customer/Item Sales action';
                    }
                    action("Salesperson - Sales Statistics")
                    {
                        Caption = 'Salesperson Sales Statistics';
                        RunObject = report "Salesperson - Sales Statistics";
                        ToolTip = 'Executes the Salesperson Sales Statistics action';
                    }
                    action("Salesperson - Commission")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Salesperson Commission';
                        RunObject = report "Salesperson - Commission";
                        ToolTip = 'Executes the Salesperson Commission action';
                    }
                    action("Customer - Sales List")
                    {
                        Caption = 'Customer - Sales List';
                        RunObject = report "Customer - Sales List";
                        ToolTip = 'Executes the Customer - Sales List action';
                    }
                    action("Aged Accounts Receivable")
                    {
                        Caption = 'Aged Accounts Receivable';
                        RunObject = report "Aged Accounts Receivable";
                        ToolTip = 'Executes the Aged Accounts Receivable action';
                    }
                    action("Customer - Trial Balance")
                    {
                        Caption = 'Customer Trial Balance';
                        RunObject = report "Customer - Trial Balance";
                        ToolTip = 'Executes the Customer Trial Balance action';
                    }
                    action("EC Sales List")
                    {
                        Caption = 'EC Sales List';
                        RunObject = report "EC Sales List";
                        ToolTip = 'Executes the EC Sales List action';
                    }
                }
                group(Group35)
                {
                    Caption = 'Setup';

                    action("Sales & Receivables Setup")
                    {
                        Caption = 'Sales & Receivables Setup';
                        RunObject = page "Sales & Receivables Setup";
                        ToolTip = 'Executes the Sales & Receivables Setup action';
                    }
                    action("Payment Registration Setup")
                    {
                        Caption = 'Payment Registration Setup';
                        RunObject = page "Payment Registration Setup";
                        ToolTip = 'Executes the Payment Registration Setup action';
                    }
                    action("Report Selection Reminder and")
                    {
                        Caption = 'Report Selections Reminder/Fin. Charge';
                        RunObject = page "Report Selection - Reminder";
                        ToolTip = 'Executes the Report Selections Reminder/Fin. Charge action';
                    }
                    action("Reminder Terms")
                    {
                        Caption = 'Reminder Terms';
                        RunObject = page "Reminder Terms";
                        ToolTip = 'Executes the Reminder Terms action';
                    }
                    action("Finance Charge Terms")
                    {
                        Caption = 'Finance Charge Terms';
                        RunObject = page "Finance Charge Terms";
                        ToolTip = 'Executes the Finance Charge Terms action';
                    }
                }
            }
            group(Group36)
            {
                Caption = 'Payables';

                action(Vendors12)
                {
                    Caption = 'Vendors';
                    RunObject = page "Vendor List";
                    ToolTip = 'Executes the Vendors action';
                }
                action(Invoices1)
                {
                    Caption = 'Purchase Invoices';
                    RunObject = page "Purchase Invoices";
                    ToolTip = 'Executes the Purchase Invoices action';
                }
                action("Credit Memos1")
                {
                    Caption = 'Purchase Credit Memos';
                    RunObject = page "Purchase Credit Memos";
                    ToolTip = 'Executes the Purchase Credit Memos action';
                }
                action("Incoming Documents")
                {
                    Caption = 'Incoming Documents';
                    RunObject = page "Incoming Documents";
                    ToolTip = 'Executes the Incoming Documents action';
                }
                group(Group37)
                {
                    Caption = 'Journals';

                    action("Purchase Journals")
                    {
                        Caption = 'Purchase Journals';
                        RunObject = page "Purchase Journal";
                        ToolTip = 'Executes the Purchase Journals action';
                    }
                    action("Payment Journals1")
                    {
                        Caption = 'Payment Journals';
                        RunObject = page "Payment Journal";
                        ToolTip = 'Executes the Payment Journals action';
                    }
                }
                group(Group39)
                {
                    Caption = 'Registers/Entries';

                    action("G/L Registers2")
                    {
                        Caption = 'G/L Registers';
                        RunObject = page "G/L Registers";
                        ToolTip = 'Executes the G/L Registers action';
                    }
                    action("Vendor Ledger Entries")
                    {
                        Caption = 'Vendor Ledger Entries';
                        RunObject = page "Vendor Ledger Entries";
                        ToolTip = 'Executes the Vendor Ledger Entries action';
                    }
                    action("Detailed Cust. Ledg. Entries1")
                    {
                        Caption = 'Detailed Vendor Ledger Entries';
                        RunObject = page "Detailed Vendor Ledg. Entries";
                        ToolTip = 'Executes the Detailed Vendor Ledger Entries action';
                    }
                    action("Credit Transfer Registers")
                    {
                        Caption = 'Credit Transfer Registers';
                        RunObject = page "Credit Transfer Registers";
                        ToolTip = 'Executes the Credit Transfer Registers action';
                    }
                    action("Employee Ledger Entries")
                    {
                        ApplicationArea = BasicHR;
                        Caption = 'Employee Ledger Entries';
                        RunObject = page "Employee Ledger Entries";
                        ToolTip = 'Executes the Employee Ledger Entries action';
                    }
                }
                group(Group40)
                {
                    Caption = 'Reports';

                    action("Aged Accounts Payable")
                    {
                        Caption = 'Aged Accounts Payable';
                        RunObject = report "Aged Accounts Payable";
                        ToolTip = 'Executes the Aged Accounts Payable action';
                    }
                    action("Payments on Hold")
                    {
                        Caption = 'Payments on Hold';
                        RunObject = report "Payments on Hold";
                        ToolTip = 'Executes the Payments on Hold action';
                    }
                    action("Purchase Statistics")
                    {
                        Caption = 'Purchase Statistics';
                        RunObject = report "Purchase Statistics";
                        ToolTip = 'Executes the Purchase Statistics action';
                    }
                    action("Vendor Item Catalog")
                    {
                        Caption = 'Vendor Item Catalog';
                        RunObject = report "Vendor Item Catalog";
                        ToolTip = 'Executes the Vendor Item Catalog action';
                    }
                    action("Vendor Register")
                    {
                        Caption = 'Vendor Register';
                        RunObject = report "Vendor Register";
                        ToolTip = 'Executes the Vendor Register action';
                    }
                    action("Vendor - Balance to Date")
                    {
                        Caption = 'Vendor - Balance to Date';
                        RunObject = report "Vendor - Balance to Date";
                        ToolTip = 'Executes the Vendor - Balance to Date action';
                    }
                    action("Vendor - Detail Trial Balance")
                    {
                        Caption = 'Vendor - Detail Trial Balance';
                        RunObject = report "Vendor - Detail Trial Balance";
                        ToolTip = 'Executes the Vendor - Detail Trial Balance action';
                    }
                    action("Vendor - Labels")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Vendor - Labels';
                        RunObject = report "Vendor - Labels";
                        ToolTip = 'Executes the Vendor - Labels action';
                    }
                    action("Vendor - List")
                    {
                        Caption = 'Vendor - List';
                        RunObject = report "Vendor - List";
                        ToolTip = 'Executes the Vendor - List action';
                    }
                    action("Vendor - Order Detail")
                    {
                        Caption = 'Vendor - Order Detail';
                        RunObject = report "Vendor - Order Detail";
                        ToolTip = 'Executes the Vendor - Order Detail action';
                    }
                    action("Vendor - Order Summary")
                    {
                        Caption = 'Vendor - Order Summary';
                        RunObject = report "Vendor - Order Summary";
                        ToolTip = 'Executes the Vendor - Order Summary action';
                    }
                    action("Vendor - Purchase List")
                    {
                        Caption = 'Vendor - Purchase List';
                        RunObject = report "Vendor - Purchase List";
                        ToolTip = 'Executes the Vendor - Purchase List action';
                    }
                    action("Vendor - Summary Aging")
                    {
                        Caption = 'Vendor - Summary Aging';
                        RunObject = report "Vendor - Summary Aging";
                        ToolTip = 'Executes the Vendor - Summary Aging action';
                    }
                    action("Vendor - Top 10 List")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Vendor - Top 10 List';
                        RunObject = report "Vendor - Top 10 List";
                        ToolTip = 'Executes the Vendor - Top 10 List action';
                    }
                    action("Vendor - Trial Balance")
                    {
                        Caption = 'Vendor - Trial Balance';
                        RunObject = report "Vendor - Trial Balance";
                        ToolTip = 'Executes the Vendor - Trial Balance action';
                    }
                    action("Vendor/Item Purchases")
                    {
                        Caption = 'Vendor/Item Purchases';
                        RunObject = report "Vendor/Item Purchases";
                        ToolTip = 'Executes the Vendor/Item Purchases action';
                    }
                }
                group(Group41)
                {
                    Caption = 'Setup';

                    action("Purchases & Payables Setup")
                    {
                        Caption = 'Purchases & Payables Setup';
                        RunObject = page "Purchases & Payables Setup";
                        ToolTip = 'Executes the Purchases & Payables Setup action';
                    }
                }
            }
            group(Group42)
            {
                Caption = 'Fixed Assets';

                action("Fixed Assets12")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets';
                    RunObject = page "Fixed Asset List";
                    ToolTip = 'Executes the Fixed Assets action';
                }
                action(Insurance12)
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Insurance';
                    RunObject = page "Insurance List";
                    ToolTip = 'Executes the Insurance action';
                }
                action("Calculate Depreciation...")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Calculate Depreciation...';
                    RunObject = report "Calculate Depreciation";
                    ToolTip = 'Executes the Calculate Depreciation... action';
                }
                action("Fixed Assets...")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Index Fixed Assets...';
                    RunObject = report "Index Fixed Assets";
                    ToolTip = 'Executes the Index Fixed Assets... action';
                }
                action("Insurance...")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Index Insurance...';
                    RunObject = report "Index Insurance";
                    ToolTip = 'Executes the Index Insurance... action';
                }
                group(Group43)
                {
                    Caption = 'Journals';

                    action("G/L Journals")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA G/L Journals';
                        RunObject = page "Fixed Asset G/L Journal";
                        ToolTip = 'Executes the FA G/L Journals action';
                    }
                    action("FA Journals")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Journals';
                        RunObject = page "Fixed Asset Journal";
                        ToolTip = 'Executes the FA Journals action';
                    }
                    action("FA Reclass. Journal")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Reclassification Journals';
                        RunObject = page "FA Reclass. Journal";
                        ToolTip = 'Executes the FA Reclassification Journals action';
                    }
                    action("Insurance Journals")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Insurance Journals';
                        RunObject = page "Insurance Journal";
                        ToolTip = 'Executes the Insurance Journals action';
                    }
                    action("Recurring Journals1")
                    {
                        ApplicationArea = Suite, FixedAssets;
                        Caption = 'Recurring General Journals';
                        RunObject = page "Recurring General Journal";
                        ToolTip = 'Executes the Recurring General Journals action';
                    }
                    action("Recurring Fixed Asset Journals")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Recurring Fixed Asset Journals';
                        RunObject = page "Recurring Fixed Asset Journal";
                        ToolTip = 'Executes the Recurring Fixed Asset Journals action';
                    }
                }
                group(Group44)
                {
                    Caption = 'Reports';

                    group(Group45)
                    {
                        Caption = 'Fixed Assets';

                        action("Posting Group - Net Change")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Posting Group - Net Change';
                            RunObject = report "FA Posting Group - Net Change";
                            ToolTip = 'Executes the FA Posting Group - Net Change action';
                        }
                        action(Register1)
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Register';
                            RunObject = report "Fixed Asset Register";
                            ToolTip = 'Executes the FA Register action';
                        }
                        action("Acquisition List")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Acquisition List';
                            RunObject = report "Fixed Asset - Acquisition List";
                            ToolTip = 'Executes the FA Acquisition List action';
                        }
                        action(Analysis1)
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Analysis';
                            RunObject = report "Fixed Asset - Analysis";
                            ToolTip = 'Executes the FA Analysis action';
                        }
                        action("Book Value 01")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Book Value 01';
                            RunObject = report "Fixed Asset - Book Value 01";
                            ToolTip = 'Executes the FA Book Value 01 action';
                        }
                        action("Book Value 02")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Book Value 02';
                            RunObject = report "Fixed Asset - Book Value 02";
                            ToolTip = 'Executes the FA Book Value 02 action';
                        }
                        action(Details)
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Details';
                            RunObject = report "Fixed Asset - Details";
                            ToolTip = 'Executes the FA Details action';
                        }
                        action("G/L Analysis")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA G/L Analysis';
                            RunObject = report "Fixed Asset - G/L Analysis";
                            ToolTip = 'Executes the FA G/L Analysis action';
                        }
                        action(List1)
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA List';
                            RunObject = report "Fixed Asset - List";
                            ToolTip = 'Executes the FA List action';
                        }
                        action("Projected Value")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Projected Value';
                            RunObject = report "Fixed Asset - Projected Value";
                            ToolTip = 'Executes the FA Projected Value action';
                        }
                    }
                    group(Group46)
                    {
                        Caption = 'Insurance';

                        action("Uninsured FAs")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Uninsured FAs';
                            RunObject = report "Insurance - Uninsured FAs";
                            ToolTip = 'Executes the Uninsured FAs action';
                        }
                        action(Register2)
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Insurance Register';
                            RunObject = report "Insurance Register";
                            ToolTip = 'Executes the Insurance Register action';
                        }
                        action(Analysis2)
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Insurance Analysis';
                            RunObject = report "Insurance - Analysis";
                            ToolTip = 'Executes the Insurance Analysis action';
                        }
                        action("Coverage Details")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Insurance Coverage Details';
                            RunObject = report "Insurance - Coverage Details";
                            ToolTip = 'Executes the Insurance Coverage Details action';
                        }
                        action(List2)
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Insurance List';
                            RunObject = report "Insurance - List";
                            ToolTip = 'Executes the Insurance List action';
                        }
                        action("Tot. Value Insured")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Total Value Insured';
                            RunObject = report "Insurance - Tot. Value Insured";
                            ToolTip = 'Executes the FA Total Value Insured action';
                        }
                    }
                    group(Group47)
                    {
                        Caption = 'Maintenance';

                        action(Register3)
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Maintenance Register';
                            RunObject = report "Maintenance Register";
                            ToolTip = 'Executes the Maintenance Register action';
                        }
                        action(Analysis3)
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Maintenance Analysis';
                            RunObject = report "Maintenance - Analysis";
                            ToolTip = 'Executes the Maintenance Analysis action';
                        }
                        action(Details1)
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Maintenance Details';
                            RunObject = report "Maintenance - Details";
                            ToolTip = 'Executes the Maintenance Details action';
                        }
                        action("Next Service")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Maintenance Next Service';
                            RunObject = report "Maintenance - Next Service";
                            ToolTip = 'Executes the Maintenance Next Service action';
                        }
                    }
                }
                group(Group48)
                {
                    Caption = 'Registers/Entries';

                    action("FA Registers12")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Registers';
                        RunObject = page "FA Registers";
                        ToolTip = 'Executes the FA Registers action';
                    }
                    action("Insurance Registers12")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Insurance Registers';
                        RunObject = page "Insurance Registers";
                        ToolTip = 'Executes the Insurance Registers action';
                    }
                    action("FA Ledger Entries12")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Ledger Entries';
                        RunObject = page "FA Ledger Entries";
                        ToolTip = 'Executes the FA Ledger Entries action';
                    }
                    action("Maintenance Ledger Entries12")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Maintenance Ledger Entries';
                        RunObject = page "Maintenance Ledger Entries";
                        ToolTip = 'Executes the Maintenance Ledger Entries action';
                    }
                    action("Ins. Coverage Ledger Entries12")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Insurance Coverage Ledger Entries';
                        RunObject = page "Ins. Coverage Ledger Entries";
                        ToolTip = 'Executes the Insurance Coverage Ledger Entries action';
                    }
                }
                group(Group49)
                {
                    Caption = 'Setup';

                    action("FA Setup")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Setup';
                        RunObject = page "Fixed Asset Setup";
                        ToolTip = 'Executes the FA Setup action';
                    }
                    action("FA Classes")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Classes';
                        RunObject = page "FA Classes";
                        ToolTip = 'Executes the FA Classes action';
                    }
                    action("FA Subclasses")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Subclasses';
                        RunObject = page "FA Subclasses";
                        ToolTip = 'Executes the FA Subclasses action';
                    }
                    action("FA Locations")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Locations';
                        RunObject = page "FA Locations";
                        ToolTip = 'Executes the FA Locations action';
                    }
                    action("Insurance Types")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Insurance Types';
                        RunObject = page "Insurance Types";
                        ToolTip = 'Executes the Insurance Types action';
                    }
                    action(Maintenance)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Maintenance';
                        RunObject = page Maintenance;
                        ToolTip = 'Executes the Maintenance action';
                    }
                    action("Depreciation Books")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Depreciation Books';
                        RunObject = page "Depreciation Book List";
                        ToolTip = 'Executes the Depreciation Books action';
                    }
                    action("Depreciation Tables")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Depreciation Tables';
                        RunObject = page "Depreciation Table List";
                        ToolTip = 'Executes the Depreciation Tables action';
                    }
                    action("FA Journal Templates")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Journal Templates';
                        RunObject = page "FA Journal Templates";
                        ToolTip = 'Executes the FA Journal Templates action';
                    }
                    action("FA Reclass. Journal Templates")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Reclassification Journal Template';
                        RunObject = page "FA Reclass. Journal Templates";
                        ToolTip = 'Executes the FA Reclassification Journal Template action';
                    }
                    action("Insurance Journal Templates")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Insurance Journal Templates';
                        RunObject = page "Insurance Journal Templates";
                        ToolTip = 'Executes the Insurance Journal Templates action';
                    }
                }
            }
            group(Group50)
            {
                Caption = 'Inventory';

                action("Inventory Periods12")
                {
                    Caption = 'Inventory Periods';
                    RunObject = page "Inventory Periods";
                    ToolTip = 'Executes the Inventory Periods action';
                }
                action("Phys. Invt. Counting Periods")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Physical Invtory Counting Periods';
                    RunObject = page "Phys. Invt. Counting Periods";
                    ToolTip = 'Executes the Physical Invtory Counting Periods action';
                }
                action("Application Worksheet")
                {
                    Caption = 'Application Worksheet';
                    RunObject = page "Application Worksheet";
                    ToolTip = 'Executes the Application Worksheet action';
                }
                group(Group51)
                {
                    Caption = 'Costing';

                    action("Adjust Item Costs/Prices")
                    {
                        Caption = 'Adjust Item Costs/Prices';
                        RunObject = report "Adjust Item Costs/Prices";
                        ToolTip = 'Executes the Adjust Item Costs/Prices action';
                    }
                    action("Adjust Cost - Item Entries")
                    {
                        Caption = 'Adjust Cost - Item Entries...';
                        RunObject = report "Adjust Cost - Item Entries";
                        ToolTip = 'Executes the Adjust Cost - Item Entries... action';
                    }
                    action("Update Unit Cost...")
                    {
                        ApplicationArea = Manufacturing;
                        Caption = 'Update Unit Costs...';
                        RunObject = report "Update Unit Cost";
                        ToolTip = 'Executes the Update Unit Costs... action';
                    }
                    action("Post Inventory Cost to G/L")
                    {
                        Caption = 'Post Inventory Cost to G/L';
                        RunObject = report "Post Inventory Cost to G/L";
                        ToolTip = 'Executes the Post Inventory Cost to G/L action';
                    }
                }
                group(Group52)
                {
                    Caption = 'Journals';

                    action("Item Journal")
                    {
                        Caption = 'Item Journals';
                        RunObject = page "Item Journal";
                        ToolTip = 'Executes the Item Journals action';
                    }
                    action("Item Reclass. Journals")
                    {
                        Caption = 'Item Reclassification Journals';
                        RunObject = page "Item Reclass. Journal";
                        ToolTip = 'Executes the Item Reclassification Journals action';
                    }
                    action("Phys. Inventory Journals")
                    {
                        Caption = 'Physical Inventory Journals';
                        RunObject = page "Phys. Inventory Journal";
                        ToolTip = 'Executes the Physical Inventory Journals action';
                    }
                    action("Revaluation Journals")
                    {
                        Caption = 'Revaluation Journals';
                        RunObject = page "Revaluation Journal";
                        ToolTip = 'Executes the Revaluation Journals action';
                    }
                }
                group(Group53)
                {
                    Caption = 'Reports';

                    action("Inventory Valuation")
                    {
                        Caption = 'Inventory Valuation';
                        RunObject = report "Inventory Valuation";
                        ToolTip = 'Executes the Inventory Valuation action';
                    }
                    action("Inventory Valuation - WIP")
                    {
                        ApplicationArea = Manufacturing;
                        Caption = 'Production Order - WIP';
                        RunObject = report "Inventory Valuation - WIP";
                        ToolTip = 'Executes the Production Order - WIP action';
                    }
                    action("Inventory - List")
                    {
                        Caption = 'Inventory - List';
                        RunObject = report "Inventory - List";
                        ToolTip = 'Executes the Inventory - List action';
                    }
                    action("Invt. Valuation - Cost Spec.")
                    {
                        Caption = 'Invt. Valuation - Cost Spec.';
                        RunObject = report "Invt. Valuation - Cost Spec.";
                        ToolTip = 'Executes the Invt. Valuation - Cost Spec. action';
                    }
                    action("Item Age Composition - Value")
                    {
                        Caption = 'Item Age Composition - Value';
                        RunObject = report "Item Age Composition - Value";
                        ToolTip = 'Executes the Item Age Composition - Value action';
                    }
                    action("Item Register - Value")
                    {
                        Caption = 'Item Register - Value';
                        RunObject = report "Item Register - Value";
                        ToolTip = 'Executes the Item Register - Value action';
                    }
                    action("Physical Inventory List")
                    {
                        ApplicationArea = Warehouse;
                        Caption = 'Physical Inventory List';
                        RunObject = report "Phys. Inventory List";
                        ToolTip = 'Executes the Physical Inventory List action';
                    }
                    action(Status)
                    {
                        Caption = 'Status';
                        RunObject = report Status;
                        ToolTip = 'Executes the Status action';
                    }
                    action("Cost Shares Breakdown")
                    {
                        ApplicationArea = Manufacturing;
                        Caption = 'Cost Shares Breakdown';
                        RunObject = report "Cost Shares Breakdown";
                        ToolTip = 'Executes the Cost Shares Breakdown action';
                    }
                    action("Item Register - Quantity")
                    {
                        Caption = 'Item Register - Quantity';
                        RunObject = report "Item Register - Quantity";
                        ToolTip = 'Executes the Item Register - Quantity action';
                    }
                    action("Item Dimensions - Detail")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Item Dimensions - Detail';
                        RunObject = report "Item Dimensions - Detail";
                        ToolTip = 'Executes the Item Dimensions - Detail action';
                    }
                    action("Item Dimensions - Total")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Item Dimensions - Total';
                        RunObject = report "Item Dimensions - Total";
                        ToolTip = 'Executes the Item Dimensions - Total action';
                    }
                    action("Inventory - G/L Reconciliation")
                    {
                        Caption = 'Inventory - G/L Reconciliation';
                        RunObject = page "Inventory - G/L Reconciliation";
                        ToolTip = 'Executes the Inventory - G/L Reconciliation action';
                    }
                }
                group(Group54)
                {
                    Caption = 'Setup';

                    action("Inventory Posting Setup")
                    {
                        Caption = 'Inventory Posting Setup';
                        RunObject = page "Inventory Posting Setup";
                        ToolTip = 'Executes the Inventory Posting Setup action';
                    }
                    action("Inventory Setup")
                    {
                        Caption = 'Inventory Setup';
                        RunObject = page "Inventory Setup";
                        ToolTip = 'Executes the Inventory Setup action';
                    }
                    action("Item Charges")
                    {
                        ApplicationArea = ItemCharges;
                        Caption = 'Item Charges';
                        RunObject = page "Item Charges";
                        ToolTip = 'Executes the Item Charges action';
                    }
                    action("Item Categories")
                    {
                        Caption = 'Item Categories';
                        RunObject = page "Item Categories";
                        ToolTip = 'Executes the Item Categories action';
                    }
                    action("Rounding Methods")
                    {
                        AccessByPermission = tabledata Resource = R;
                        Caption = 'Rounding Methods';
                        RunObject = page "Rounding Methods";
                        ToolTip = 'Executes the Rounding Methods action';
                    }
                    action("Analysis Types")
                    {
                        ApplicationArea = SalesAnalysis, PurchaseAnalysis, InventoryAnalysis;
                        Caption = 'Analysis Types';
                        RunObject = page "Analysis Types";
                        ToolTip = 'Executes the Analysis Types action';
                    }
                    action("Inventory Analysis Report")
                    {
                        ApplicationArea = InventoryAnalysis;
                        Caption = 'Inventory Analysis Reports';
                        RunObject = page "Analysis Report Inventory";
                        ToolTip = 'Executes the Inventory Analysis Reports action';
                    }
                    action("Analysis View Card")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Inventory Analysis by Dimensions';
                        RunObject = page "Analysis View List Inventory";
                        ToolTip = 'Executes the Inventory Analysis by Dimensions action';
                    }
                    action("Analysis Column Templates")
                    {
                        ApplicationArea = InventoryAnalysis;
                        Caption = 'Invt. Analysis Column Templates';
                        RunObject = report "Run Invt. Analysis Col. Temp.";
                        ToolTip = 'Executes the Invt. Analysis Column Templates action';
                    }
                    action("Analysis Line Templates")
                    {
                        ApplicationArea = InventoryAnalysis;
                        Caption = 'Invt. Analysis Line Templates';
                        RunObject = report "Run Invt. Analysis Line Temp.";
                        ToolTip = 'Executes the Invt. Analysis Line Templates action';
                    }
                }
            }
            group("Fin Activities")
            {
                Caption = 'Payments Management';

                group("Finance Activities")
                {
                    Caption = 'General Activities';

                    action("Chart of Accounts")
                    {
                        Caption = 'Chart of Accounts';
                        RunObject = page "Chart of Accounts";
                        ToolTip = 'Executes the Chart of Accounts action';
                    }
                    action("G/L Budgets")
                    {
                        Caption = 'G/L Budgets';
                        RunObject = page "G/L Budget Names";
                        ToolTip = 'Executes the G/L Budgets action';
                    }
                    action("Proposed Budget List")
                    {
                        Caption = 'Proposed Budget List';
                        RunObject = page "Proposed G/L Budget Names";
                        ToolTip = 'Executes the Proposed Budget List action';
                    }
                    action("Budget Approval List")
                    {
                        Caption = 'Budget Approval List';
                        RunObject = page "Budget Approval List";
                        ToolTip = 'Executes the Budget Approval List action';
                    }
                    action("Budget vs Commitments")
                    {
                        Caption = 'Budget vs Commitments';
                        RunObject = report "Votebook Summary";
                        ToolTip = 'Executes the Budget vs Commitments action';
                    }
                    action("Budget Report")
                    {
                        Caption = 'Budget Report';
                        RunObject = report Budget;
                        ToolTip = 'Executes the Budget Report action';
                    }
                    action("Budget Utilization")
                    {
                        Caption = 'Budget Utilization';
                        RunObject = report "Budget Utilization";
                        ToolTip = 'Executes the Budget Utilization action';
                    }
                }
                group("Finance Transaction List")
                {
                    Caption = 'Finance Transaction List';
                    action("Payment Voucher")
                    {
                        Caption = 'Payment Voucher';
                        RunObject = page "Payment Vouchers";
                        RunPageView = where(Status = const(Open));
                        ToolTip = 'Executes the Payment Voucher action';
                    }
                    action(Receipts)
                    {
                        Caption = 'Receipts';
                        RunObject = page Receipts;
                        ToolTip = 'Executes the Receipts action';
                    }
                    action(Imprests1)
                    {
                        Caption = 'Imprests';
                        RunObject = page Imprests;
                        ToolTip = 'Executes the Imprests action';
                    }
                    action(ImprestSurr)
                    {
                        Caption = 'Imprest Surrenders';
                        RunObject = page "Imprest Surrenders";
                        ToolTip = 'Executes the Imprests Surrenders action';
                    }
                    action("Petty Cash List")
                    {
                        Caption = 'Petty Cash List';
                        RunObject = page "Petty Cash List";
                        ToolTip = 'Executes the Petty Cash List action';
                    }
                    action("Petty Cash Surrender")
                    {
                        Caption = 'Petty Cash Surrender';
                        RunObject = page "Petty Cash Surrenders";
                        ToolTip = 'Executes the Petty Cash Surrender action';
                    }
                    action("Staff Claim")
                    {
                        Caption = 'Staff Claim';
                        RunObject = page "Staff Claim List";
                        ToolTip = 'Executes the Staff Claim action';
                    }
                    action("Interbank Transfers")
                    {
                        Caption = 'Interbank Transfers';
                        RunObject = page "InterBank Transfer List";
                        ToolTip = 'Executes the Interbank Transfers action';
                    }
                }
                group("Documents Pending Approval")
                {
                    Caption = 'Documents Pending Approval';
                    action("Pending Payment Vouchers")
                    {
                        Caption = 'Pending Payment Vouchers';
                        RunObject = page "Pending Payment Vouchers1";
                        ToolTip = 'Executes the Pending Payment Vouchers action';
                    }
                    action("Pending Imprests")
                    {
                        Caption = 'Pending Imprests';
                        RunObject = page "Pending Imprests";
                        ToolTip = 'Executes the Pending Imprests action';
                    }
                    action("Pending Imprest Surrenders")
                    {
                        Caption = 'Pending Imprest Surrenders';
                        RunObject = page "Pending Imprest Surrenders";
                        ToolTip = 'Executes the Pending Imprest Surrenders action';
                    }
                    action("Pending Staff Claim")
                    {
                        Caption = 'Pending Staff Claim';
                        RunObject = page "Pending Staff Claim List";
                        ToolTip = 'Executes the Pending Staff Claim action';
                    }
                    action("Pending Petty Cash")
                    {
                        Caption = 'Pending Petty Cash';
                        RunObject = page "Pending Petty Cash List";
                        ToolTip = 'Executes the Pending Petty Cash action';
                    }
                    action("Pending Petty Cash Surrenders ")
                    {
                        Caption = 'Pending Petty Cash Surrenders ';
                        RunObject = page "Pending Petty Cash Surrenders";
                        ToolTip = 'Executes the Pending Petty Cash Surrenders  action';
                    }
                    action("Pending InterBank Transfers")
                    {
                        Caption = 'Pending InterBank Transfers';
                        RunObject = page "Pending InterBank Transfer";
                        ToolTip = 'Executes the Pending InterBank Transfers action';
                    }
                }
                group("Documents Approved List")
                {
                    Caption = 'Documents Approved List';
                    action("Approved Payment Vouchers")
                    {
                        Caption = 'Approved Payment Vouchers';
                        RunObject = page "Approved Payment Vouchers1";
                        ToolTip = 'Executes the Approved Payment Vouchers action';
                    }
                    action("Approved Petty Cash List")
                    {
                        Caption = 'Approved Petty Cash List';
                        RunObject = page "Approved Petty Cash";
                        ToolTip = 'Executes the Approved Petty Cash List action';
                    }
                    action("Approved Petty Cash Surrender")
                    {
                        Caption = 'Approved Petty Cash Surrender';
                        RunObject = page "Approved Petty Cash Surrenders";
                        ToolTip = 'Executes the Approved Petty Cash Surrender action';
                    }
                    action("Budget Approved List")
                    {
                        Caption = 'Budget Approved List';
                        RunObject = page "Budget Approved List";
                        ToolTip = 'Executes the Budget Approved List action';
                    }
                    action("Approved Imprests ")
                    {
                        Caption = 'Approved Imprests ';
                        RunObject = page "Approved Imprests";
                        ToolTip = 'Executes the Approved Imprests  action';
                    }
                    action("Approved Imprest Surrenders ")
                    {
                        Caption = 'Approved Imprest Surrenders ';
                        RunObject = page "Approved Imprest Surrenders";
                        ToolTip = 'Executes the Approved Imprest Surrenders  action';
                    }
                    action("Approved Staff Claim ")
                    {
                        Caption = 'Approved Staff Claim ';
                        RunObject = page "Approved Staff Claim";
                        ToolTip = 'Executes the Approved Staff Claim  action';
                    }
                    action("Approved InterBank Transfers")
                    {
                        Caption = 'Approved InterBank Transfers';
                        RunObject = page "Approved InterBank Transfer";
                        ToolTip = 'Executes the Approved InterBank Transfers action';
                    }
                }
                group("Posted Documents List")
                {
                    Caption = 'Posted Documents List';
                    action("Posted PVs")
                    {
                        Caption = 'Posted PVs';
                        RunObject = page "Posted Payment Vouchers1";
                        ToolTip = 'Executes the Posted PVs action';
                    }
                    action("Posted Receipts")
                    {
                        Caption = 'Posted Receipts';
                        RunObject = page "Posted Receipts";
                        ToolTip = 'Executes the Posted Receipts action';
                    }
                    action("Posted Petty Cash")
                    {
                        Caption = 'Posted Petty Cash';
                        RunObject = page "Posted Petty cash";
                        ToolTip = 'Executes the Posted Petty Cash action';
                    }
                    action("Posted Petty Cash Surrenders")
                    {
                        Caption = 'Posted Petty Cash Surrenders';
                        RunObject = page "Posted Petty Cash Surrenders";
                        ToolTip = 'Executes the Posted Petty Cash Surrenders action';
                    }
                    action("Posted Credit Memos1")
                    {
                        Caption = 'Posted Purchase Credit Memos';
                        RunObject = page "Posted Purchase Credit Memos";
                        ToolTip = 'Executes the Posted Purchase Credit Memos action';
                    }
                    action("Posted Purchase Invoices12")
                    {
                        Caption = 'Posted Purchase Invoices';
                        RunObject = page "Posted Purchase Invoices";
                        ToolTip = 'Executes the Posted Purchase Invoices action';
                    }
                    action("Posted Purchase Receipts")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Posted Purchase Receipts';
                        RunObject = page "Posted Purchase Receipts";
                        ToolTip = 'Executes the Posted Purchase Receipts action';
                    }
                    action("Posted Return Shipments")
                    {
                        ApplicationArea = PurchReturnOrder;
                        Caption = 'Posted Purchase Return Shipments';
                        RunObject = page "Posted Return Shipments";
                        ToolTip = 'Executes the Posted Purchase Return Shipments action';
                    }
                    action("Posted Invoices")
                    {
                        Caption = 'Posted Sales Invoices';
                        RunObject = page "Posted Sales Invoices";
                        ToolTip = 'Executes the Posted Sales Invoices action';
                    }
                    action("Posted Sales Shipments")
                    {
                        Caption = 'Posted Sales Shipments';
                        RunObject = page "Posted Sales Shipments";
                        ToolTip = 'Executes the Posted Sales Shipments action';
                    }
                    action("Posted Credit Memos")
                    {
                        Caption = 'Posted Sales Credit Memos';
                        RunObject = page "Posted Sales Credit Memos";
                        ToolTip = 'Executes the Posted Sales Credit Memos action';
                    }
                    action("Posted Return Receipts")
                    {
                        ApplicationArea = SalesReturnOrder;
                        Caption = 'Posted Return Receipts';
                        RunObject = page "Posted Return Receipts";
                        ToolTip = 'Executes the Posted Return Receipts action';
                    }
                    action("Posted Imprest Surrenders")
                    {
                        ApplicationArea = SalesReturnOrder;
                        Caption = 'Posted Imprest Surrenders';
                        RunObject = page "Posted Imprest Surrenders";
                        ToolTip = 'Executes the Posted Imprest Surrenders action';
                    }
                    action("Posted Imprests")
                    {
                        ApplicationArea = SalesReturnOrder;
                        Caption = 'Posted Imprests';
                        RunObject = page "Posted Imprests";
                        ToolTip = 'Executes the Posted Imprests action';
                    }
                    action("Posted interbank transfers")
                    {
                        ApplicationArea = SalesReturnOrder;
                        Caption = 'Posted interbank transfers';
                        RunObject = page "Posted InterBank Transfer";
                        ToolTip = 'Executes the Posted interbank transfers action';
                    }
                }
                group(PropertyExpenseMgt)
                {
                    Caption = 'Property Expense Management';
                    group(PropertyExpenses)
                    {
                        Caption = 'Property Expense Requests';
                        action(PropertyExpenseRequest)
                        {
                            Caption = 'Property Expense Requests';
                            RunObject = page "Property Expense Requests";
                            RunPageLink = Posted = const(false);
                            ToolTip = 'Executes the Property Expense Requests action.';
                        }
                        action(PropertyExpenseRequestApproved)
                        {
                            Caption = 'Property Expense Requests Approved';
                            RunObject = page "Approved Property Expenses";
                            ToolTip = 'Executes the Property Expense Requests Approved action.';
                        }
                        action(PropertyExpenseRequestPosted)
                        {
                            Caption = 'Posted Property Expense Requests';
                            RunObject = page "Posted Property Expenses";
                            ToolTip = 'Executes the Posted Property Expense Requests action.';
                        }
                    }
                    group(PropertyExpenseSurrenders)
                    {
                        Caption = 'Property Expense Surrenders';
                        action(PropertyExpenseSurrender)
                        {
                            Caption = 'Property Expense Surrender';
                            RunObject = page "Property Expense Surrenders";
                            RunPageLink = Posted = const(false);
                            ToolTip = 'Executes the Property Expense Surrender action.';
                        }
                        action(PropertyExpenseSurrenderApproved)
                        {
                            Caption = 'Property Expense Surrender Approved';
                            RunObject = page "Approved Property Exp Surr";
                            RunPageLink = Posted = const(false);
                            ToolTip = 'Executes the Property Expense Surrender Approved action.';
                        }
                        action(PropertyExpenseSurrenderPosted)
                        {
                            Caption = 'Posted Property Expense Surrender';
                            RunObject = page "Posted Property Surrenders";
                            RunPageLink = Posted = const(true);
                            ToolTip = 'Executes the Posted Property Expense Surrender action.';
                        }
                    }
                    action(PropertyExpenseTypes)
                    {
                        Caption = 'Property Expense Types';
                        RunObject = page "Property Expense Types";
                        ToolTip = 'Executes the Property Expense Types action.';
                    }
                }
                group(Setups)
                {
                    Caption = 'Setups';
                    action(CashSetup)
                    {
                        Caption = 'Cash Management Setup';
                        Image = Setup;
                        RunObject = page "Cash Management Setups";
                        ToolTip = 'Executes the Cash Management Setup action';
                    }
                    action("Imprest Types")
                    {
                        Caption = 'Imprest Types';
                        RunObject = page "Imprest Types";
                        ToolTip = 'Executes the Imprest Types action';
                    }
                    action("Payment Types")
                    {
                        Caption = 'Payments Voucher Types';
                        RunObject = page "Payment Types";
                        ToolTip = 'Executes the Payments Voucher Types action';
                    }
                    action("Petty Cash Types")
                    {
                        Caption = 'Petty Cash Types';
                        RunObject = page "Petty Cash Types";
                        ToolTip = 'Executes the Expense Codes action';
                    }
                    action("Receipt Types")
                    {
                        Caption = 'Receipt Types';
                        RunObject = page "Receipt Types";
                        ToolTip = 'Executes the Receipt Types action';
                    }
                    action("Claim Types")
                    {
                        Caption = 'Claim Types';
                        RunObject = page "Claim Types";
                        ToolTip = 'Executes the Claim Types action';
                    }
                    action("Property Expense Types")
                    {
                        Caption = 'Property Expense Types';
                        RunObject = page "Property Expense Types";
                        ToolTip = 'Executes the Property Expense Types action';
                    }
                    action("Destination Codes")
                    {
                        Caption = 'Destination Codes';
                        RunObject = page "Destination Code";
                        ToolTip = 'Executes the Destination Codes action';
                    }
                    action("Banker Cheque Register")
                    {
                        Caption = 'Banker Cheque Register';
                        RunObject = page "Banks Cheque Register";
                        ToolTip = 'Executes the Banker Cheque Register action';
                    }
                    action("Cash Office User Template")
                    {
                        Caption = 'Cash Office User Template';
                        RunObject = page "Cash Office User Template";
                        ToolTip = 'Executes the Cash Office User Template action';
                    }
                }
            }
            group(Group55)
            {
                Caption = 'Setup';

                action("General Posting Setup")
                {
                    Caption = 'General Posting Setup';
                    RunObject = page "General Posting Setup";
                    ToolTip = 'Executes the General Posting Setup action';
                }
                action("Incoming Documents Setup")
                {
                    Caption = 'Incoming Documents Setup';
                    RunObject = page "Incoming Documents Setup";
                    ToolTip = 'Executes the Incoming Documents Setup action';
                }
                action("Accounting Periods")
                {
                    Caption = 'Accounting Periods';
                    RunObject = page "Accounting Periods";
                    ToolTip = 'Executes the Accounting Periods action';
                }
                action("Standard Text Codes")
                {
                    Caption = 'Standard Text Codes';
                    RunObject = page "Standard Text Codes";
                    ToolTip = 'Executes the Standard Text Codes action';
                }
                action("No. Series")
                {
                    Caption = 'No. Series';
                    // RunObject = page "No. Series";
                    ToolTip = 'Executes the No. Series action';
                }
                group(Group56)
                {
                    Caption = 'VAT';

                    action("Posting Setup")
                    {
                        Caption = 'VAT Posting Setup';
                        RunObject = page "VAT Posting Setup";
                        ToolTip = 'Executes the VAT Posting Setup action';
                    }
                    action("VAT Clauses")
                    {
                        Caption = 'VAT Clauses';
                        RunObject = page "VAT Clauses";
                        ToolTip = 'Executes the VAT Clauses action';
                    }
                    action("VAT Change Setup")
                    {
                        Caption = 'VAT Rate Change Setup';
                        RunObject = page "VAT Rate Change Setup";
                        ToolTip = 'Executes the VAT Rate Change Setup action';
                    }
                    action("VAT Statement Templates")
                    {
                        Caption = 'VAT Statement Templates';
                        RunObject = page "VAT Statement Templates";
                        ToolTip = 'Executes the VAT Statement Templates action';
                    }
                    action("VAT Reports Configuration")
                    {
                        Caption = 'VAT Reports Configuration';
                        RunObject = page "VAT Reports Configuration";
                        ToolTip = 'Executes the VAT Reports Configuration action';
                    }
                }
                group(Group57)
                {
                    Caption = 'Intrastat';

                    action("Tariff Numbers")
                    {
                        Caption = 'Tariff Numbers';
                        RunObject = page "Tariff Numbers";
                        ToolTip = 'Executes the Tariff Numbers action';
                    }
                    action("Transaction Types")
                    {
                        Caption = 'Transaction Types';
                        RunObject = page "Transaction Types";
                        ToolTip = 'Executes the Transaction Types action';
                    }
                    action("Transaction Specifications")
                    {
                        Caption = 'Transaction Specifications';
                        RunObject = page "Transaction Specifications";
                        ToolTip = 'Executes the Transaction Specifications action';
                    }
                    action("Transport Methods")
                    {
                        Caption = 'Transport Methods';
                        RunObject = page "Transport Methods";
                        ToolTip = 'Executes the Transport Methods action';
                    }
                    action("Entry/Exit Points")
                    {
                        Caption = 'Entry/Exit Points';
                        RunObject = page "Entry/Exit Points";
                        ToolTip = 'Executes the Entry/Exit Points action';
                    }
                    action(Areas)
                    {
                        Caption = 'Areas';
                        RunObject = page Areas;
                        ToolTip = 'Executes the Areas action';
                    }
                }
                group(Group58)
                {
                    Caption = 'Intercompany';

                    action("Intercompany Setup")
                    {
                        ApplicationArea = Intercompany;
                        Caption = 'Intercompany Setup';
                        RunObject = page "Intercompany Setup";
                        ToolTip = 'Executes the Intercompany Setup action';
                    }
                    action("Partner Code")
                    {
                        ApplicationArea = Intercompany;
                        Caption = 'Intercompany Partners';
                        RunObject = page "IC Partner List";
                        ToolTip = 'Executes the Intercompany Partners action';
                    }
                    action("Chart of Accounts2")
                    {
                        ApplicationArea = Intercompany;
                        Caption = 'Intercompany Chart of Accounts';
                        RunObject = page "IC Chart of Accounts";
                        ToolTip = 'Executes the Intercompany Chart of Accounts action';
                    }
                    action(Dimensions)
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Intercompany Dimensions';
                        RunObject = page "IC Dimensions";
                        ToolTip = 'Executes the Intercompany Dimensions action';
                    }
                }
                group(Group59)
                {
                    Caption = 'Dimensions';

                    action(Dimensions1)
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Dimensions';
                        RunObject = page Dimensions;
                        ToolTip = 'Executes the Dimensions action';
                    }
                    action("Analyses by Dimensions1")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Analysis by Dimensions';
                        RunObject = page "Analysis View List";
                        ToolTip = 'Executes the Analysis by Dimensions action';
                    }
                    action("Dimension Combinations")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Dimension Combinations';
                        RunObject = page "Dimension Combinations";
                        ToolTip = 'Executes the Dimension Combinations action';
                    }
                    action("Default Dimension Priorities")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Default Dimension Priorities';
                        RunObject = page "Default Dimension Priorities";
                        ToolTip = 'Executes the Default Dimension Priorities action';
                    }
                }
                group(Group60)
                {
                    Caption = 'Trail Codes';

                    action("Source Codes")
                    {
                        Caption = 'Source Codes';
                        RunObject = page "Source Codes";
                        ToolTip = 'Executes the Source Codes action';
                    }
                    action("Reason Codes")
                    {
                        Caption = 'Reason Codes';
                        RunObject = page "Reason Codes";
                        ToolTip = 'Executes the Reason Codes action';
                    }
                    action("Source Code Setup")
                    {
                        Caption = 'Source Code Setup';
                        RunObject = page "Source Code Setup";
                        ToolTip = 'Executes the Source Code Setup action';
                    }
                }
                group(Group61)
                {
                    Caption = 'Posting Groups';

                    action("General Business")
                    {
                        Caption = 'Gen. Business Posting Groups';
                        RunObject = page "Gen. Business Posting Groups";
                        ToolTip = 'Executes the Gen. Business Posting Groups action';
                    }
                    action("Gen. Product Posting Groups")
                    {
                        Caption = 'General Product Posting Groups';
                        RunObject = page "Gen. Product Posting Groups";
                        ToolTip = 'Executes the General Product Posting Groups action';
                    }
                    action("Customer Posting Groups")
                    {
                        Caption = 'Customer Posting Groups';
                        RunObject = page "Customer Posting Groups";
                        ToolTip = 'Executes the Customer Posting Groups action';
                    }
                    action("Vendor Posting Groups")
                    {
                        Caption = 'Vendor Posting Groups';
                        RunObject = page "Vendor Posting Groups";
                        ToolTip = 'Executes the Vendor Posting Groups action';
                    }
                    action("Bank Account")
                    {
                        Caption = 'Bank Account Posting Groups';
                        RunObject = page "Bank Account Posting Groups";
                        ToolTip = 'Executes the Bank Account Posting Groups action';
                    }
                    action("Inventory Posting Groups")
                    {
                        Caption = 'Inventory Posting Groups';
                        RunObject = page "Inventory Posting Groups";
                        ToolTip = 'Executes the Inventory Posting Groups action';
                    }
                    action("FA Posting Groups")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Posting Groups';
                        RunObject = page "FA Posting Groups";
                        ToolTip = 'Executes the FA Posting Groups action';
                    }
                    action("Business Posting Groups")
                    {
                        Caption = 'VAT Business Posting Groups';
                        RunObject = page "VAT Business Posting Groups";
                        ToolTip = 'Executes the VAT Business Posting Groups action';
                    }
                    action("Product Posting Groups")
                    {
                        Caption = 'VAT Product Posting Groups';
                        RunObject = page "VAT Product Posting Groups";
                        ToolTip = 'Executes the VAT Product Posting Groups action';
                    }
                }
                group("General Ledger History")
                {
                    Caption = 'General Ledger History';
                    action("G/L Registers")
                    {
                        Caption = 'G/L Registers';
                        RunObject = page "G/L Registers";
                        ToolTip = 'Executes the G/L Registers action';
                    }
                    action("General Ledger Entries")
                    {
                        Caption = 'General Ledger Entries';
                        RunObject = page "General Ledger Entries";
                        ToolTip = 'Executes the General Ledger Entries action';
                    }
                    action("G/L Budget Entries")
                    {
                        Caption = 'G/L Budget Entries';
                        RunObject = page "G/L Budget Entries";
                        ToolTip = 'Executes the G/L Budget Entries action';
                    }
                    action("VAT Entries")
                    {
                        Caption = 'VAT Entries';
                        RunObject = page "VAT Entries";
                        ToolTip = 'Executes the VAT Entries action';
                    }
                    action("Analysis View Entries")
                    {
                        Caption = 'Analysis View Entries';
                        RunObject = page "Analysis View Entries";
                        ToolTip = 'Executes the Analysis View Entries action';
                    }
                    action("Analysis View Budget Entries")
                    {
                        Caption = 'Analysis View Budget Entries';
                        RunObject = page "Analysis View Budget Entries";
                        ToolTip = 'Executes the Analysis View Budget Entries action';
                    }
                    action("Item Budget Entries")
                    {
                        Caption = 'Item Budget Entries';
                        RunObject = page "Item Budget Entries";
                        ToolTip = 'Executes the Item Budget Entries action';
                    }
                }
                group("Cash Management Lists")
                {
                    Caption = 'Cash Management Lists';
                    action("Bank Accounts")
                    {
                        Caption = 'Bank Accounts';
                        RunObject = page "Bank Account List";
                        ToolTip = 'Executes the Bank Accounts action';
                    }
                    action("Payment Reconciliation Journals")
                    {
                        Caption = 'Payment Reconciliation Journals';
                        RunObject = page "Pmt. Reconciliation Journals";
                        ToolTip = 'Executes the Payment Reconciliation Journals action';
                    }
                    action("Bank Acc. Reconciliation List")
                    {
                        Caption = 'Bank Acc. Reconciliation List';
                        RunObject = page "Bank Acc. Reconciliation List";
                        ToolTip = 'Executes the Bank Acc. Reconciliation List action';
                    }
                    action("Posted Payment Reconciliations")
                    {
                        Caption = 'Posted Payment Reconciliations';
                        RunObject = page "Posted Payment Reconciliations";
                        ToolTip = 'Executes the Posted Payment Reconciliations action';
                    }
                    group("Document Archive List")
                    {
                        Caption = 'Document Archive List';
                        action("Bank Account Ledger Entries")
                        {
                            Caption = 'Bank Account Ledger Entries';
                            RunObject = page "Bank Account Ledger Entries";
                            ToolTip = 'Executes the Bank Account Ledger Entries action';
                        }
                        action("Check Ledger Entries")
                        {
                            Caption = 'Check Ledger Entries';
                            RunObject = page "Check Ledger Entries";
                            ToolTip = 'Executes the Check Ledger Entries action';
                        }
                        action("FA Registers")
                        {
                            Caption = 'FA Registers';
                            RunObject = page "FA Registers";
                            ToolTip = 'Executes the FA Registers action';
                        }
                        action("Insurance Registers")
                        {
                            Caption = 'Insurance Registers';
                            RunObject = page "Insurance Registers";
                            ToolTip = 'Executes the Insurance Registers action';
                        }
                        action("FA Ledger Entries")
                        {
                            Caption = 'FA Ledger Entries';
                            RunObject = page "FA Ledger Entries";
                            ToolTip = 'Executes the FA Ledger Entries action';
                        }
                        action("Maintenance Ledger Entries")
                        {
                            Caption = 'Maintenance Ledger Entries';
                            RunObject = page "Maintenance Ledger Entries";
                            ToolTip = 'Executes the Maintenance Ledger Entries action';
                        }
                        action("Ins. Coverage Ledger Entries")
                        {
                            Caption = 'Ins. Coverage Ledger Entries';
                            RunObject = page "Ins. Coverage Ledger Entries";
                            ToolTip = 'Executes the Ins. Coverage Ledger Entries action';
                        }
                    }
                    group("Acc. Payable")
                    {
                        Caption = 'Acc. Payable';
                        action(Vendors)
                        {
                            Caption = 'Vendors';
                            Image = Vendor;
                            RunObject = page "Vendor List";
                            RunPageLink = "Vendor Type" = filter(<> "Share holder");
                            ToolTip = 'Executes the Vendors action';
                        }
                        action(GeneralJournals)
                        {
                            ApplicationArea = Advanced;
                            Caption = 'General Journals';
                            Image = Journal;
                            RunObject = page "General Journal Batches";
                            RunPageView = where("Template Type" = const(General),
                                        Recurring = const(false));
                            ToolTip = 'Post financial transactions directly to general ledger accounts and other accounts, such as bank, customer, vendor, and employee accounts. Posting with a general journal always creates entries on general ledger accounts. This is true even when, for example, you post a journal line to a customer account, because an entry is posted to a general ledger receivables account through a posting group.';
                        }
                        action("Purchase Invoices")
                        {
                            Caption = 'Purchase Invoices';
                            RunObject = page "Purchase Invoices";
                            ToolTip = 'Executes the Purchase Invoices action';
                        }
                        action("Purchase Credit Memos")
                        {
                            Caption = 'Purchase Credit Memos';
                            RunObject = page "Purchase Credit Memos";
                            ToolTip = 'Executes the Purchase Credit Memos action';
                        }
                    }
                    group("Acc. Payables Archive")
                    {
                        Caption = 'Acc. Payables Archive';
                        action("Posted Purchase Invoices")
                        {
                            Caption = 'Posted Purchase Invoices';
                            RunObject = page "Posted Purchase Invoices";
                            ToolTip = 'Executes the Posted Purchase Invoices action';
                        }
                        action("Posted Purchase Credit Memos")
                        {
                            Caption = 'Posted Purchase Credit Memos';
                            RunObject = page "Posted Purchase Credit Memos";
                            ToolTip = 'Executes the Posted Purchase Credit Memos action';
                        }
                    }
                    group("Acc. Receivables List")
                    {
                        Caption = 'Approvals';

                        action("Sales Invoices")
                        {
                            Caption = 'Sales Invoices';
                            RunObject = page "Sales Invoice List";
                            ToolTip = 'Executes the Sales Invoices action';
                        }
                        action("Payment Vouchers ")
                        {
                            Caption = 'Payment Vouchers ';
                            RunObject = page "Payment Vouchers";
                            RunPageView = where(Status = const(Open));
                            ToolTip = 'Executes the Payment Vouchers  action';
                        }
                        action("Pending Payment Vouchers.")
                        {
                            Caption = 'Pending Payment Vouchers.';
                            RunObject = page "Pending Payment Vouchers1";
                            ToolTip = 'Executes the Pending Payment Vouchers. action';
                        }
                        action("Approved Payment Vouchers ")
                        {
                            Caption = 'Approved Payment Vouchers ';
                            RunObject = page "Approved Payment Vouchers1";
                            ToolTip = 'Executes the Approved Payment Vouchers  action';
                        }
                        action("Posted Payment Vouchers ")
                        {
                            Caption = 'Posted Payment Vouchers ';
                            RunObject = page "Posted Payment Vouchers1";
                            ToolTip = 'Executes the Posted Payment Vouchers  action';
                        }
                        action("Bank Accounts.")
                        {
                            Caption = 'Bank Accounts.';
                            RunObject = page "Bank Account List";
                            ToolTip = 'Executes the Bank Accounts. action';
                        }
                        action("Payment reconciliation Journals.")
                        {
                            Caption = 'Payment reconciliation Journals.';
                            RunObject = page "Pmt. Reconciliation Journals";
                            ToolTip = 'Executes the Payment reconciliation Journals. action';
                        }
                        action("Bank Acc. Reconciliation List.")
                        {
                            Caption = 'Bank Acc. Reconciliation List.';
                            RunObject = page "Bank Acc. Reconciliation List";
                            ToolTip = 'Executes the Bank Acc. Reconciliation List. action';
                        }
                    }
                    group("Fixed Assets List")
                    {
                        Caption = 'Fixed Assets List';
                        action("Fixed Assets")
                        {
                            Caption = 'Fixed Assets';
                            RunObject = page "Fixed Asset List";
                            ToolTip = 'Executes the Fixed Assets action';
                        }
                        action(Insurance)
                        {
                            Caption = 'Insurance';
                            RunObject = page "Insurance List";
                            ToolTip = 'Executes the Insurance action';
                        }
                    }
                    group(Inventory)
                    {
                        Caption = 'Inventory';
                        action(Items)
                        {
                            Caption = 'Items';
                            RunObject = page "Item List";
                            ToolTip = 'Executes the Items action.';
                        }
                        action("Inventory Periods")
                        {
                            Caption = 'Inventory Periods';
                            RunObject = page "Inventory Periods";
                            ToolTip = 'Executes the Inventory Periods action';
                        }
                        action("Chart of Accounts.")
                        {
                            Caption = 'Chart of Accounts.';
                            RunObject = page "Chart of Accounts";
                            ToolTip = 'Executes the Chart of Accounts. action';
                        }
                        action("Phys. Invent. Counting Periods")
                        {
                            Caption = 'Phys. Invent. Counting Periods';
                            RunObject = page "Phys. Invt. Counting Periods";
                            ToolTip = 'Executes the Phys. Invent. Counting Periods action';
                        }
                    }
                }
            }
        }
    }
}
