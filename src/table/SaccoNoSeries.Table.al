#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50399 "Sacco No. Series"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; "FOSA Loans Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(3; "Members Nos"; Code[10])
        {
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                /*CustMemb.RESET;
                CustMemb.SETRANGE(CustMemb."No. Series","Members Nos");
                IF CustMemb.FIND('-') = FALSE THEN BEGIN
                 ERROR('You cannot Delete/Modify since Series has been used in one or more entries');
                END;
                  */

            end;
        }
        field(4; "BOSA Loans Nos"; Code[10])
        {
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                /*LoanApps.RESET;
                LoanApps.SETRANGE(LoanApps."No. Series","BOSA Loans Nos");
                IF LoanApps.FIND('-') = FALSE THEN BEGIN
                 ERROR('You cannot Delete/Modify since Series has been used in one or more transactions');
                END;
                    */

            end;
        }
        field(5; "Loans Batch Nos"; Code[10])
        {
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                /*LoanApps.RESET;
                LoanApps.SETRANGE(LoanApps."Batch No.","Loans Batch Nos");
                IF LoanApps.FIND('-') = FALSE THEN BEGIN
                 ERROR('You cannot Delete/Modify since Series has been used in one or more transactions');
                END;
                         */

            end;
        }
        field(6; "Investors Nos"; Code[10])
        {
        }
        field(7; "Property Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(8; "BOSA Receipts Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(9; "Investment Project Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(10; "BOSA Transfer Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(11; "SMS Request Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(12; "Withholding Tax %"; Decimal)
        {
        }
        field(13; "Withholding Tax Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(14; "VAT %"; Decimal)
        {
        }
        field(15; "VAT Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(16; "PV No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(17; "Receipts Nos"; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(18; "Petty Cash  No."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(19; "Member Application Nos"; Code[10])
        {
            TableRelation = "No. Series".Code;

            trigger OnValidate()
            begin
                /*
             CustMembApp.RESET;
             CustMembApp.SETRANGE(CustMembApp."No. Series","Member Application Nos");
             IF CustMembApp.FIND('-') = FALSE THEN BEGIN
              ERROR('You cannot Delete/Modify since Series has been used in one or more entries');
             END;
                   */

            end;
        }
        field(20; "Closure  Nos"; Code[10])
        {
            TableRelation = "No. Series".Code;

            trigger OnValidate()
            begin
                /*AccClosure.RESET;
                AccClosure.SETRANGE(AccClosure."No. Series","Closure  Nos");
                IF AccClosure.FIND('-') = TRUE THEN BEGIN
                 ERROR('You cannot Delete/Modify since Series has been used in one or more entries');
                END;
                    */

            end;
        }
        field(21; "Bosa Transaction Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(22; "Transaction Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(23; "Treasury Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(24; "Standing Orders Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(25; "FOSA Current Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(26; "BOSA Current Account"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(27; "Teller Transactions No"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(28; "Treasury Transactions No"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(29; "Applicants Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(30; "STO Register No"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(31; "EFT Header Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(32; "EFT Details Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(33; "Salaries Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(34; "Requisition No"; Code[10])
        {
            Caption = 'Requisition No';
            TableRelation = "No. Series";
        }
        field(35; "Internal Requisition No."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(36; "Internal Purchase No."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(37; "Quatation Request No"; Code[10])
        {
            Caption = 'Quatation Request No';
            TableRelation = "No. Series";
        }
        field(38; "ATM Applications"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(39; "Stores Requisition No"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(40; "Requisition Default Vendor"; Code[10])
        {
        }
        field(41; "Use Procurement limits"; Boolean)
        {
        }
        field(42; "Request for Quotation Nos"; Code[20])
        {
        }
        field(43; "Teller Bulk Trans Nos."; Code[10])
        {
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                /*RcptBuffer.RESET;
                RcptBuffer.SETRANGE(RcptBuffer."No. Series","Receipt Buffer Nos.");
                IF RcptBuffer.FIND('-') = FALSE THEN BEGIN
                 ERROR('You cannot Delete/Modify since Series has been used in one or more transactions');
                END;
                 */

            end;
        }
        field(44; "Micro Loans"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(45; "Micro Transactions"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(46; "Micro Finance Transactions"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(47; "Micro Group Nos."; Code[10])
        {
        }
        field(48; "MPESA Change Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(49; "MPESA Application Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(50; "Change MPESA PIN Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(51; "Change MPESA Application Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(52; "Last Memb No."; Code[30])
        {
        }
        field(53; BosaNumber; Code[30])
        {
        }
        field(54; "Investor Application Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(55; "Investor Nos"; Code[30])
        {
        }
        field(56; "Paybill Processing"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(57; "Checkoff-Proc Distributed Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(58; "Salary Processing Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(59; "Cheque Clearing Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(60; "Checkoff Proc Block Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(61; "Cheque Application Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(62; "Cheque Receipts Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(63; "Customer Care Log Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(64; "Trunch Disbursment Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50000; "S_Mobile Registration Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50001; "Loan PayOff Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50002; "E-Loan Nos"; Code[20])
        {
        }
        field(50003; "Funeral Expense Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50004; "Change Request No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50005; "Microfinance Last No Used"; Code[20])
        {
        }
        field(50006; "MicroFinance Account Prefix"; Code[20])
        {
        }
        field(50007; "Collateral Register No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50008; "Agent Serial Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50009; "Cloudpesa Reg No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50010; "Paybill No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50011; "Deposits Account No(HQ)"; Code[20])
        {
        }
        field(50012; "Share Capital Account No(HQ)"; Code[20])
        {
        }
        field(50013; "BenFund Account No(HQ)"; Code[20])
        {
        }
        field(50014; "Deposits Account No(NAIV)"; Code[20])
        {
        }
        field(50015; "Share Capital Account No(NAIV)"; Code[20])
        {
        }
        field(50016; "BenFund Account No(NAIV)"; Code[20])
        {
        }
        field(50017; "Deposits Account No(ELD)"; Code[20])
        {
        }
        field(50018; "Share Capital Account No(ELD)"; Code[20])
        {
        }
        field(50019; "BenFund Account No(ELD)"; Code[20])
        {
        }
        field(50020; "Deposits Account No(MSA)"; Code[20])
        {
        }
        field(50021; "Share Capital Account No(MSA)"; Code[20])
        {
        }
        field(50022; "BenFund Account No(MSA)"; Code[20])
        {
        }
        field(50023; "Deposits Account No(NKR)"; Code[20])
        {
        }
        field(50024; "Share Capital Account No(NKR)"; Code[20])
        {
        }
        field(50025; "BenFund Account No(NKR)"; Code[20])
        {
        }
        field(50026; "Corporate Deposits Acc No(HQ)"; Code[20])
        {
        }
        field(50027; "Corporate Deposit Acc No(NAIV)"; Code[20])
        {
        }
        field(50028; "Corporate Deposit Acc No(ELD)"; Code[20])
        {
        }
        field(50029; "Corporate Deposit Acc No(MSA)"; Code[20])
        {
        }
        field(50030; "Corporate Deposit Acc No(NKR)"; Code[20])
        {
        }
        field(50031; "FOSA Shares Account No(HQ)"; Code[20])
        {
        }
        field(50032; "FOSA Shares Account No(NAIV)"; Code[20])
        {
        }
        field(50033; "FOSA Shares Account No(ELD)"; Code[20])
        {
        }
        field(50034; "FOSA Shares Account No(MSA)"; Code[20])
        {
        }
        field(50035; "FOSA Shares Account No(NKR)"; Code[20])
        {
        }
        field(50036; "Additional Shares Acc No(HQ)"; Code[20])
        {
        }
        field(50037; "Additional Shares Acc No(NAIV)"; Code[20])
        {
        }
        field(50038; "Additional Shares Acc No(ELD)"; Code[20])
        {
        }
        field(50039; "Additional Shares Acc No(MSA)"; Code[20])
        {
        }
        field(50040; "Additional Shares Acc No(NKR)"; Code[20])
        {
        }
        field(50041; "Membership Acc No(HQ)"; Code[20])
        {
        }
        field(50042; "Membership Acc No(NAIV)"; Code[20])
        {
        }
        field(50043; "Membership Acc No(ELD)"; Code[20])
        {
        }
        field(50044; "Membership Acc No(MSA)"; Code[20])
        {
        }
        field(50045; "Membership Acc No(NKR)"; Code[20])
        {
        }
        field(50046; "Safe Custody Package Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50047; "Safe Custody Agent Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50048; "Safe Custody Item Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50049; "Package Retrieval Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50050; "ATM Card Batch Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50051; "Member Cell Group Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50052; "Demand Notice Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50053; "House Change Request No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50054; "BD Training Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50055; "Member Agent/NOK Change"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50056; "House Group Application"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50057; "House Group Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50058; "Fixed Deposit Placement"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50059; "CRB Charge"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50060; "Online Transfers"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50061; "Over Draft Application No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50062; "Loan Restructure"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50063; "Collateral Movement No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50064; "County Nos"; Code[20])
        {
        }
        field(50065; "Feedback nos"; Code[20])
        {
        }
        field(50066; "Sweeping Instructions"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50067; "Cheque Book Batch Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50068; "Cheque Book Account Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        // "Shares Transfers Nos"
        field(50069; "Shares Transfers Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50070; "Shares Transfer Batch Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50071; "Shares Transfer List Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50072; "Shares Transfer Header Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }

        field(50073; "Guarantor Sub No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        //"Partial Loan Disbursement Nos"
        field(50074; "Partial Loan Disbursement Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        //"Top Up Loan Nos"
        field(50075; "Top Up Loan Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        //Loan Recovery Nos
        field(50076; "Loan Recovery Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }

    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        LoanApps: Record "Loans Register";
        CustMemb: Record Customer;
        CustMembApp: Record "Membership Applications";
        AccClosure: Record "Membership Exist";


    procedure TestNoEntriesExist(CurrentFieldName: Text[100])
    var
        LoanApps: Record "Loans Register";
    begin
        /*
        //To prevent change of field
         LoanApps.SETCURRENTKEY(LoanApps."No. Series");
         LoanApps.SETRANGE(LoanApps."No. Series","No.");
        IF LoanApps.FIND('-') THEN
          ERROR(
          Text000,
           CurrentFieldName);
        */

    end;
}

