table 50803 "BO General Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Max Non Contribution Period"; code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Min Deposit Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Min Share Capital Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Monthly Insurance Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Benevolent Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Min Member Age"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Max Member Age"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Min Loan Share Ratio"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Days for Checkoff"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Default Customer Posting Group"; code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Posting Group".Code;
        }
        field(11; "Default Micro Credit Posting G"; code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Posting Group".Code;
        }
        field(12; "Registration Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Majority Members Employed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Default BO Activity Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(15; "Min Existence Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Maximum Profitability Margin"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Maximum Possible DBR"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "ABB EMI Ratio(%)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Institution Founding Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Recovery Since Founding Date"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Go Live Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Add Loan Charges"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Is Paid Via Mpesa"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Accept Negative Int Payments"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Defaulter Loan Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(31; "BO Application Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(32; "BO Receipt Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(33; "BO Loan Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(34; "BO Transfers Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(35; "BO exit Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(36; "BO CheckOff Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(37; "BO Loan Batch Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(38; "BO Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        //From Cloud
        field(39; "BO Checkoff Advice Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(40; "CFT Income Accrual Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(60; "FO Cashier Transactions Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(61; "FO Treasury Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(62; "FO Loans Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(63; "FO Standing Orders Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(64; "FO ATM Applications Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(65; "FO Salary processing Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(66; "FO Loan Batch Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(67; "Savings Application Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(68; "Savings Account Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(69; "FO Interest Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(90; "INV Investor Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(91; "INV Property Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(92; "INV Project Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(120; Admin; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(121; "BO Loan Disbursement Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(123; "CRM Client Log In Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(124; "CRM Potential Opportonity Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(125; "CRM Lead Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(126; "BO Member Receipt"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(127; "BO Bulk Receipt"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(128; "BO Interest Accrual Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(129; "Collateral Security Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(130; "Credit Life (Spouse) %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(131; "Credit Life (Non-Spouse)%"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(132; "Credit Life Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(133; "BO Loan Write Off Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(134; "BO Loan Number"; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(135; "Loan Provision Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" where("Income/Balance" = filter("Balance Sheet"));
        }
        field(136; "Loan Loss Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" where("Income/Balance" = filter("Income Statement"));
        }
        field(137; "RM Taget Nos"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(138; "BO Account Update"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(139; "Loan Perfection Charges AC"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" where("Income/Balance" = filter("Balance Sheet"));
        }
        field(140; "Credit Life  Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        //Added From Cloud Enterprise
        field(141; "USSD Vendor Account"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Vendor Posting Group";
        }
        field(142; "CFT Subscription Amount"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Vendor Posting Group";
        }
        field(143; "Checkoff Advice Template"; Option)
        {
            DataClassification = ToBeClassified;

            OptionMembers = "Partial Block","Distributed","Full Block","Partial Distributed","Hybrid Distributed";

            OptionCaption = 'Partial Block, Distributed, Full Block, Partial Distributed,Hybrid Distributed';

        }
        field(144; "Block Loans Recovery Mode"; Option)
        {
            DataClassification = ToBeClassified;

            OptionMembers = "Priority","Age","Priority & Age","Age & Priority";
            OptionCaption = 'Priority, Age, Priority & Age, Age & Priority';

        }
        field(145; "Late Notification%"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(146; "Withholding Tax Percentage"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(147; "Maintenance Fee%"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(148; "Registration Fee Account"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" where("Income/Balance" = filter("Income Statement"));

        }
        field(149; "Checks Activation Fees"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(150; "Activation Fee Account"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" where("Income/Balance" = filter("Income Statement"));

        }
        field(151; "Late Notification Fee Account"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" where("Income/Balance" = filter("Income Statement"));

        }
        field(152; "Excise Duty Account"; code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" where("Income/Balance" = filter("Income Statement"));

        }
        field(153; "Validate Member By ID"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(154; "Is Microfinance"; Boolean)
        {
            DataClassification = ToBeClassified;

        }

        //From Cloud Enterprises
        field(165; "Dividends Processing Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(166; "Dividends Payment Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(167; "Shares Dividends Rate%"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(168; "Deposits Interest Rate%"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(169; "Withholding Tax Account Income"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(170; "WHT Account Expense"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(171; "Processing Fee Income"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(172; "Processing Fee Expense"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(173; "Dividend Expenses"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(174; "Use Disbursement Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "No","Yes";
            OptionCaption = 'No, Yes';
        }

        //Cash Basis Accounts
        field(175; "Cash Basis Interest Receivable"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }

        field(176; "Cash Basis Interest Income"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(177; "Maximum Noncontribution Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(178; "FO Number Series"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(179; "FO Application Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }


        field(180; "Member Exit Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(181; "Change Request Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(182; "Micro Credit Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(183; "Micro Credit Officer Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(184; "Maximum open records"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(185; "Micro Group Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(186; "Micro FOSA Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(187; "MCI Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(188; "MCG Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(189; "Micro FOSA Group Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(191; "Withdrawal Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(192; "Withdrawal Fee Account"; code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(193; "Share Capital Transfer Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(194; "Share Capital Transfer Fee Acc"; code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(195; "Cheque Discounting Nos"; code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(196; "FOSA Account Closure"; Decimal)
        {

        }

        field(197; "FOSA CLOSURE GL"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(198; "Mobile Application Nos"; code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(199; "ATM Application Nos"; code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(200; "Entrance Fee Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(201; "Min Registration Fee"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(202; "Rejoining Fee"; Decimal)
        {

        }
        field(203; "Micro Entrance Fee Account"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(204; "Entrance Fees Account"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(205; "Member Activation Account"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(206; "ATM Expiry Duration"; DateFormula)
        {
            DataClassification = ToBeClassified;

        }

        field(207; "ATM Card Fee Co-op Bank"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";

        }
        field(218; "Extra Fee G/L"; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(216; "Risk Beneficiary (%)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(217; "Rejoining Fees Account"; Code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(219; "Salary Processing Nos"; Code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(220; "Max Withdrawal Limit"; Decimal)
        {
            DataClassification = ToBeClassified;

        }

        field(222; "Allowable Cheque Discounting %"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(223; "Cheque Discounting Comission"; Decimal)
        {
            DataClassification = ToBeClassified;

        }

        field(224; "Excise Duty(%)"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(225; "SMS Fee Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(226; "Transaction Charges GL"; code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" where("Income/Balance" = filter("Income Statement"));
        }
        field(227; "SMS Fee Account"; code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" where("Income/Balance" = filter("Income Statement"));
        }
        field(228; "Collateral Item Nos"; Code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(229; "Standing Orders Nos"; code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(230; "STO Max Tolerance Days"; DateFormula)
        {


        }
        field(231; "Dont Allow STO Partial Deduc."; Boolean)
        {

        }
        field(232; "Collateral Movement Nos"; Code[40])
        {
            TableRelation = "No. Series";
        }
        field(233; "Boosting Shares %"; Decimal)
        {

        }
        field(234; "Loan Cut off Day"; Integer)

        {

        }
        field(235; "Recover Arrears"; Boolean)
        {

        }
        field(236; "Send Guarantorship Email"; Boolean)
        {

        }
        field(237; "Cheque Clearing Nos"; Code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(238; "Treasury Transaction Nos"; Code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(239; "Register Nos"; Code[40])

        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }


        field(240; "EFT Transfer Nos"; Code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(241; "EFT Details Nos"; Code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(242; "FOSA Loans Nos"; code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(243; "Micro Loans"; code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";

        }
        field(244; "Member IT Transfer Nos"; Code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";

        }
        field(245; "Partial Deposit Refund Fee"; Decimal)
        {

        }
        field(246; "Min. Loan Application Period"; code[50])
        {


        }
        field(247; "Bank Statement Period"; DateFormula)
        {


        }
        field(248; "Member Agent/NOK Change"; Code[50])
        {
            TableRelation = "No. Series";
        }
        field(249; "Agent Serial Nos"; Code[50])
        {
            TableRelation = "No. Series";
        }
        field(250; "File Movement Nos"; Code[50])
        {
            TableRelation = "No. Series";
        }

        field(251; "File Register Nos"; Code[50])
        {
            TableRelation = "No. Series";
        }
        field(252; "Group Bosa Number"; code[50])
        {
            TableRelation = "No. Series";
        }
        field(253; "Safe Custody Package Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(254; "Demand Notice Nos"; Code[50])
        {
            TableRelation = "No. Series";
        }
        field(255; "BOSA IT Transfer Nos"; Code[40])
        {
            TableRelation = "No. Series";
        }
        field(256; "Employer Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(257; "Loan Trasfer Fee-Cheque"; Decimal)
        {

        }
        field(258; "Loan Trasfer Fee-EFT"; Decimal)
        {

        }
        field(259; "Loan Trasfer Fee-FOSA"; Decimal)
        {

        }
        field(260; "Max Cash Deposit Limit"; Decimal)
        {

        }
        field(262; "Treasury Threshold Amount"; Decimal)
        {

        }
        field(300; "Loan Recovery Nos"; Code[40])
        {
            TableRelation = "No. Series";
        }
        field(301; "Guarantor Substitution"; Code[40])
        {
            TableRelation = "No. Series";
        }
        field(302; "Defaulter LN"; Integer)
        {

        }
        field(303; "ATM Withdrawal Limit"; Decimal)
        {

        }
        field(304; "POS Withdrawal Limit"; Decimal)
        {

        }
        field(305; "MPESA Reconciliation acc"; code[20])
        {
            TableRelation = "Bank Account";
        }

        field(306; "PaybillAcc"; code[20])
        {
            TableRelation = "Bank Account";

        }
        field(307; "PayBill Settl Acc"; code[20])
        {
            TableRelation = "Bank Account";
        }

        field(308; "Fixed Deposit Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(309; "Guarantors Multiplier"; Decimal)
        {

        }
        field(311; "Employee Requisition Nos"; Code[50])
        {
            TableRelation = "No. Series";
        }
        field(312; "Job Application Nos"; Code[50])
        {
            TableRelation = "No. Series";
        }
        field(313; "Employee No"; Code[50])
        {
            TableRelation = "No. Series";
        }

        field(317; "Store Requisition Nos"; Code[50])
        {
            TableRelation = "No. Series";
        }

        field(318; "RuaiMobi Loan Nos"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(319; "Vendor Commission Account"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }




    }

    keys
    {

    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin


    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}