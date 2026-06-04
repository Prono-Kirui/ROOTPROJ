page 50450 "BO General Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "BO General Setup";
    DeleteAllowed = false;
    Editable = true;

    layout
    {
        area(Content)
        {
            group("1. General Information")
            {

                field("Institution Founding Date"; Rec."Institution Founding Date")
                {
                    ApplicationArea = All;
                }
                field("Recovery Since Founding Date"; Rec."Recovery Since Founding Date")
                {
                    ApplicationArea = All;
                }

                field("Go Live Date"; Rec."Go Live Date")
                {
                    ApplicationArea = All;
                }

                field("Min. Loan Application Period"; Rec."Min. Loan Application Period")
                {
                    ApplicationArea = all;
                }

                field("Loan Cut off Day"; Rec."Loan Cut off Day")
                {
                    ApplicationArea = all;
                }

                field("Maximum Noncontribution Period"; Rec."Maximum Noncontribution Period")
                {

                }

                field("Min Deposit Contribution"; Rec."Min Deposit Contribution")
                {
                    ApplicationArea = All;
                }
                field("Min Share Capital Contribution"; Rec."Min Share Capital Contribution")
                {
                    ApplicationArea = All;
                }
                field("Monthly Insurance Contribution"; Rec."Monthly Insurance Contribution")
                {
                    ApplicationArea = All;
                }
                field("Benevolent Contribution"; Rec."Benevolent Contribution")
                {
                    ApplicationArea = All;
                }

                field("Min Member Age"; Rec."Min Member Age")
                {
                    ApplicationArea = All;
                }
                field("Bank Statement Period"; Rec."Bank Statement Period")
                {
                    ApplicationArea = all;
                }
                field("Max Member Age"; Rec."Max Member Age")
                {
                    ApplicationArea = All;
                }
                field("Max Cash Deposit Limit"; Rec."Max Cash Deposit Limit")
                {

                }

                field("Max Withdrawal Limit"; Rec."Max Withdrawal Limit")
                {
                    ApplicationArea = All;
                }
                field("Treasury Threshold Amount"; Rec."Treasury Threshold Amount")
                {
                    ToolTip = 'Treasury Allowed Threshold Amount';

                }
                field("MPESA Reconciliation acc"; Rec."MPESA Reconciliation acc")
                {

                }

                field("Paybill Acc"; Rec.PaybillAcc)
                {

                }
                field("Vendor Commission Account"; Rec."Vendor Commission Account") { }

                field("PayBill Settl Acc"; Rec."PayBill Settl Acc")
                {

                }

                field("Majority Members Employed"; Rec."Majority Members Employed")
                {
                    ApplicationArea = All;
                }
                field("Send Guarantorship Email"; Rec."Send Guarantorship Email")
                {

                }

                field("Maximum open records"; Rec."Maximum open records")
                {
                    ApplicationArea = All;
                }
            }
            group("2. Member Application Controls / No series")
            {

                // field("Register Nos"; Rec."Register Nos")
                // {

                // }
                field("Employee No"; Rec."Employee No")
                {

                }

                field("Job Application Nos"; Rec."Job Application Nos")

                {

                }
                field("Employee Requisition Nos"; Rec."Employee Requisition Nos")
                {

                }
                field("Loan Recovery Nos"; Rec."Loan Recovery Nos")
                {

                }
                field("Demand Notice Nos"; Rec."Demand Notice Nos")
                {

                }
                field("Group Bosa Number"; Rec."Group Bosa Number")
                {

                }

                field("BO Application Nos"; Rec."BO Application Nos")
                {
                    ApplicationArea = All;

                }
                field("FO Application Nos"; Rec."FO Application Nos")
                {
                    ApplicationArea = All;

                }
                field("Employer Nos"; Rec."Employer Nos")
                {
                    ApplicationArea = all;
                }
                field("Micro Credit Nos"; Rec."Micro Credit Nos")
                {
                    ApplicationArea = All;

                }
                field("Micro Group Nos"; Rec."Micro Group Nos")
                {
                    ApplicationArea = All;

                }
                field("Micro FOSA Nos"; Rec."Micro FOSA Nos")
                {
                    ApplicationArea = All;

                }
                field("Micro FOSA Group Nos"; Rec."Micro FOSA Group Nos")
                {
                    ApplicationArea = All;

                }
                field("Mobile Application Nos"; Rec."Mobile Application Nos")
                {
                    ApplicationArea = All;

                }
                field("Member Agent/NOK Change"; Rec."Member Agent/NOK Change")
                {

                }
                field("Agent Serial Nos"; Rec."Agent Serial Nos")
                {

                }
                field("File Movement Nos"; Rec."File Movement Nos")
                {

                }
                field("File Register Nos"; Rec."File Register Nos")
                {

                }

                field("Safe Custody Package Nos"; Rec."Safe Custody Package Nos")
                {

                }


                field("Micro Credit Officer Nos"; Rec."Micro Credit Officer Nos")
                {
                    ApplicationArea = All;

                }
                field("Change Request Nos"; Rec."Change Request Nos")
                {
                    ApplicationArea = All;

                }
                field("Entrance Fee Nos"; Rec."Entrance Fee Nos")
                {
                    ApplicationArea = All;
                }


                field("BO exit Nos"; Rec."BO exit Nos")
                {
                    ApplicationArea = All;

                }


                field("MCI Nos"; Rec."MCI Nos")
                {
                    ApplicationArea = All;

                }
                field("MCG Nos"; Rec."MCG Nos")
                {
                    ApplicationArea = All;

                }
                field("BO Nos"; Rec."BO Nos")
                {
                    ApplicationArea = All;

                }


                field("BO Member Receipt"; Rec."BO Member Receipt")
                {
                    ApplicationArea = All;

                }

            }

            group("3. Loan Application Controls / No Series")
            {
                field("RuaiMobi Loan Nos"; Rec."RuaiMobi Loan Nos")
                {
                    ApplicationArea = All;
                }
                field("Boosting Shares %"; Rec."Boosting Shares %")
                {

                }
                field("Accept Negative Interest Payments"; Rec."Accept Negative Int Payments")
                {
                    ApplicationArea = All;
                }
                field("Min Loan Share Ratio"; Rec."Min Loan Share Ratio")
                {
                    ApplicationArea = All;
                }

                field("BO Loan Disbursement Nos"; Rec."BO Loan Disbursement Nos")
                {
                    ApplicationArea = All;

                }
                field("FO Loans Nos"; Rec."FO Loans Nos")
                {
                    ApplicationArea = All;

                }
                field("Guarantor Substitution"; Rec."Guarantor Substitution")
                {

                }
                field("Guarantors Multiplier"; Rec."Guarantors Multiplier")
                {

                }
                field("Defaulter LN"; Rec."Defaulter LN")
                {

                }

                field("FO Loan Batch Nos"; Rec."FO Loan Batch Nos")
                {
                    ApplicationArea = All;

                }
                field("BO Loan Nos"; Rec."BO Loan Nos")
                {
                    ApplicationArea = All;

                }

                field("Defaulter Loan Nos"; Rec."Defaulter Loan Nos")
                {
                    ApplicationArea = All;



                }
                field("FOSA Loans Nos"; Rec."FOSA Loans Nos")
                {

                }
                field("Micro Loans Nos"; Rec."Micro Loans")
                {

                }
                field("BO Loan Batch Nos"; Rec."BO Loan Batch Nos")
                {
                    ApplicationArea = All;

                }
                field("Collateral Security Nos"; Rec."Collateral Security Nos")
                {
                    ApplicationArea = All;

                }
                field("Collateral Movement Nos"; Rec."Collateral Movement Nos")
                {
                    ApplicationArea = all;
                }
            }
            group("4. Banking Controls / No Series")
            {
                field("ATM Expiry Duration"; Rec."ATM Expiry Duration")
                {
                    ApplicationArea = All;

                }
                field("ATM Withdrawal Limit"; Rec."ATM Withdrawal Limit")
                {
                    ApplicationArea = All;
                }
                field("POS Withdrawal Limit"; Rec."POS Withdrawal Limit")
                {
                    ApplicationArea = All;

                }
                field("Allowable Cheque Discounting %"; Rec."Allowable Cheque Discounting %")
                {
                    ApplicationArea = all;
                }

                field("ATM Card Fee Co-op Bank"; Rec."ATM Card Fee Co-op Bank")
                {
                    ApplicationArea = All;
                }
                field("Cheque Discounting Nos"; Rec."Cheque Discounting Nos")
                {
                    ApplicationArea = All;
                }
                field("ATM Application Nos"; Rec."ATM Application Nos")
                {
                    ApplicationArea = All;

                }
                field("FO Cashier Transactions Nos"; Rec."FO Cashier Transactions Nos")
                {
                    ApplicationArea = All;

                }
                field("Cheque Clearing Nos"; Rec."Cheque Clearing Nos")
                {
                    ApplicationArea = All;
                }

                field("Treasury Transaction Nos"; Rec."Treasury Transaction Nos")
                {
                    ApplicationArea = All;
                }
                field("EFT Transfer Nos"; Rec."EFT Transfer Nos")
                {
                    ApplicationArea = All;
                }
                field("EFT Details Nos"; Rec."EFT Details Nos")
                {
                    ApplicationArea = All;
                }
                field("Member IT Transfer Nos"; Rec."Member IT Transfer Nos")
                {
                    ApplicationArea = All;
                }
                field("BOSA IT Transfer Nos"; Rec."BOSA IT Transfer Nos")
                {
                    ApplicationArea = All;
                }
                field("Fixed Deposit Nos"; Rec."Fixed Deposit Nos")
                {
                    ApplicationArea = All;
                }
                field("Withholding Tax Percentage"; Rec."Withholding Tax Percentage")
                {
                    ApplicationArea = All;
                }
            }

            group("5. Standing Order Controls / No Series")
            {
                field("Standing Orders Nos"; Rec."Standing Orders Nos")
                {
                    ApplicationArea = All;
                }

                field("STO Max Tolerance Days"; Rec."STO Max Tolerance Days")
                {

                    ApplicationArea = all;
                    ToolTip = 'Standing Order Maximum Tolerance Days DateFormula i.e 2D for 2 days 3Y for 3 years';

                }
                field("Dont Allow STO Partial Deduc."; Rec."Dont Allow STO Partial Deduc.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dont Allow Standing Order Partial Deduction';
                }
            }


            group("6. Periodic Activities Controls / No Series")
            {
                field("BO CheckOff Nos"; Rec."BO CheckOff Nos")
                {
                    ApplicationArea = All;

                }
                field("Days for Checkoff"; Rec."Days for Checkoff")
                {
                    ApplicationArea = All;
                }
                field("Checkoff Advice Template"; Rec."Checkoff Advice Template")
                {
                    ApplicationArea = All;
                }
                field("Block Loans Recovery Mode"; Rec."Block Loans Recovery Mode")
                {
                    ApplicationArea = All;
                }
                field("Salary Processing Nos"; Rec."Salary Processing Nos")
                {

                }

            }

            group("7. Dividend Processing Controls / No Series")
            {
                field("Dividends Processing Nos"; Rec."Dividends Processing Nos")
                {
                    ApplicationArea = All;

                }
                field("Dividends Payment Nos"; Rec."Dividends Payment Nos")
                {
                    ApplicationArea = All;

                }
                field("Shares Dividends Rate%"; Rec."Shares Dividends Rate%")
                {
                    ApplicationArea = All;

                }
                field("Deposits Interest Rate%"; Rec."Deposits Interest Rate%")
                {
                    ApplicationArea = All;

                }
                field("WHT Account Income"; Rec."Withholding Tax Account Income")
                {
                    ApplicationArea = All;

                }
                field("WHT Account Expense"; Rec."WHT Account Expense")
                {
                    ApplicationArea = All;

                }
                field("Processing Fee Income"; Rec."Processing Fee Income")
                {
                    ApplicationArea = All;

                }
                field("Processing Fee Expense"; Rec."Processing Fee Expense")
                {
                    ApplicationArea = All;

                }
                field("Dividends Expenses"; Rec."Dividend Expenses")
                {
                    ApplicationArea = All;

                }
                field("Use Disbursement Account Type"; Rec."Use Disbursement Account Type")
                {
                    ApplicationArea = All;
                }
            }
            group("8. Cash Basis Accounts")
            {
                field("Cash Basis Interest Receivable"; Rec."Cash Basis Interest Receivable")
                {
                    ApplicationArea = All;

                }
                field("Cash Basis Interest Income"; Rec."Cash Basis Interest Income")
                {
                    ApplicationArea = All;

                }

            }
            group("9. Customer Relation Management")
            {
                field("CRM Lead Nos"; Rec."CRM Lead Nos")
                {
                    ApplicationArea = All;

                }
                field("CRM Potential Opportonity Nos"; Rec."CRM Potential Opportonity Nos")
                {
                    ApplicationArea = All;

                }
                field("CRM Client Log In Nos"; Rec."CRM Client Log In Nos")
                {
                    ApplicationArea = All;

                }
                field("RM Taget Nos"; Rec."RM Taget Nos")
                {
                    ApplicationArea = All;

                }
                field("Credit Life  Nos"; Rec."Credit Life  Nos")
                {
                    ApplicationArea = All;

                }

            }


            group("10. Investment Numbers")
            {
                field("INV Investor Nos"; Rec."INV Investor Nos")
                {
                    ApplicationArea = All;

                }
                field("INV Property Nos"; Rec."INV Property Nos")
                {
                    ApplicationArea = All;

                }
                field("INV Project Nos"; Rec."INV Project Nos")
                {
                    ApplicationArea = All;

                }
            }
            group("11. Store Management Numbers")
            {
                field("Store Requisition Nos"; Rec."Store Requisition Nos")
                {
                    ApplicationArea = all;
                }
            }


        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}