table 51000 "Cash Management Setups"
{
    Caption = 'Cash Management Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Payment Voucher Template"; Code[20])
        {
            Caption = 'Payment Voucher Template';
            TableRelation = "Gen. Journal Template";
        }
        field(3; "Imprest Journal Template"; Code[20])
        {
            Caption = 'Imprest Journal Template';
            TableRelation = "Gen. Journal Template";
        }
        field(4; "Imprest Surrender Template"; Code[20])
        {
            Caption = 'Imprest Surrender Template';
            TableRelation = "Gen. Journal Template";
        }
        field(5; "Petty Cash Journal Template"; Code[20])
        {
            Caption = 'Petty Cash Journal Template';
            TableRelation = "Gen. Journal Template";
        }
        field(6; "Receipt Template"; Code[20])
        {
            Caption = 'Receipt Template';
            TableRelation = "Gen. Journal Template";
        }
        field(7; "Post VAT"; Boolean)
        {
            Caption = 'Post VAT';
        }
        field(8; "Rounding Type"; Option)
        {
            Caption = 'Rounding Type';
            OptionCaption = 'Up,Nearest,Down';
            OptionMembers = Up,Nearest,Down;
        }
        field(9; "Rounding Precision"; Decimal)
        {
            Caption = 'Rounding Precision';
        }
        field(10; "Imprest Limit"; Decimal)
        {
            Caption = 'Imprest Limit';
        }
        field(11; "Imprest Due Date"; DateFormula)
        {
            Caption = 'Imprest Due Date';
        }
        field(12; "PV Nos"; Code[20])
        {
            Caption = 'PV Nos';
            TableRelation = "No. Series";
        }
        field(13; "Petty Cash Nos"; Code[20])
        {
            Caption = 'Petty Cash Nos';
            TableRelation = "No. Series";
        }
        field(14; "Imprest Nos"; Code[10])
        {
            Caption = 'Imprest Nos';
            TableRelation = "No. Series";
        }
        field(15; "Current Budget"; Code[20])
        {
            Caption = 'Current Budget';
            TableRelation = "G/L Budget Name".Name;
        }
        field(16; "Current Budget Start Date"; Date)
        {
            Caption = 'Current Budget Start Date';
        }
        field(17; "Current Budget End Date"; Date)
        {
            Caption = 'Current Budget End Date';
        }
        field(18; "Imprest Posting Group"; Code[20])
        {
            Caption = 'Imprest Posting Group';
            TableRelation = "Customer Posting Group";
        }
        field(19; "General Bus. Posting Group"; Code[20])
        {
            Caption = 'General Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(20; "VAT Bus. Posting Group"; Code[20])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(21; "Check for Committment"; Boolean)
        {
            Caption = 'Check for Committment';
        }
        field(23; "Imprest Surrender Nos"; Code[10])
        {
            Caption = 'Imprest Surrender Nos';
            TableRelation = "No. Series";
        }
        field(24; "Bank Transfer Nos"; Code[10])
        {
            Caption = 'Bank Transfer Nos';
            TableRelation = "No. Series";
        }
        field(25; "Receipt Nos"; Code[20])
        {
            Caption = 'Receipt Nos';
            TableRelation = "No. Series";
        }
        field(26; "Petty Cash Surrender Template"; Code[20])
        {
            Caption = 'Petty Cash Surrender Template';
            TableRelation = "Gen. Journal Template";
        }
        field(27; "Petty Cash Surrender Nos"; Code[20])
        {
            Caption = 'Petty Cash Surrender Nos';
            TableRelation = "No. Series";
        }
        field(28; "Donor Workflows Nos"; Code[20])
        {
            Caption = 'Donor Workflows Nos';
            TableRelation = "No. Series";
        }
        field(29; "Attachment Nos"; Code[20])
        {
            Caption = 'Attachment Nos';
            TableRelation = "No. Series";
        }
        field(30; "Approvals Delegation Nos."; Code[20])
        {
            Caption = 'Approvals Delegation Nos.';
            TableRelation = "No. Series";
        }
        field(31; "Petty Cash Max"; Decimal)
        {
            Caption = 'Petty Cash Max';
        }
        field(32; "Staff Claim Nos"; Code[20])
        {
            Caption = 'Staff Claim Nos';
            TableRelation = "No. Series";
        }
        field(33; "Staff Claim Template"; Code[20])
        {
            Caption = 'Staff Claim Template';
            TableRelation = "Gen. Journal Template";
        }
        field(34; "Bank Transfer Template"; Code[20])
        {
            Caption = 'Bank Transfer Template';
            TableRelation = "Gen. Journal Template";
        }
        field(35; "Max Imprests Unsurrendered"; Integer)
        {
            Caption = 'Max Imprests Unsurrendered';
        }
        field(36; "Max Open Documents"; Integer)
        {
            Caption = 'Max Open Documents';
        }
        field(37; "EFT Path"; Text[50])
        {
            Caption = 'EFT Path';
        }
        field(38; "Loan Journal Template"; Code[50])
        {
            Caption = 'Loan Journal Template';
            TableRelation = "Gen. Journal Template";
        }
        field(39; "Loan Batch Template"; Code[50])
        {
            Caption = 'Loan Batch Template';
            TableRelation = "Gen. Journal Batch";
        }
        field(40; "Append Sign To Documents"; Boolean)
        {
            Caption = 'Append Sign To Documents';
        }
        field(41; "Laundry Nos"; Code[10])
        {
            Caption = 'Laundry Nos';
            TableRelation = "No. Series";
        }
        field(42; "Laundry Template"; Code[10])
        {
            Caption = 'Laundry Template';
            TableRelation = "Gen. Journal Template";
        }
        field(43; "Laundry Payable Account"; Code[10])
        {
            Caption = 'Laundry Payable Account';
            TableRelation = "G/L Account";
        }
        field(44; "Laundry Bank Account"; Code[10])
        {
            Caption = 'Laundry Bank Account';
            TableRelation = "Bank Account";
        }
        field(45; "Laundry Inspection Notes"; Blob)
        {
            Caption = 'Laundry Inspection Notes';
            Subtype = Memo;
        }
        field(46; "Laundry Payment Nos"; Code[10])
        {
            Caption = 'Laundry Payment Nos';
            TableRelation = "No. Series";
        }
        field(47; "Laundry Invoice Path"; Text[70])
        {
            Caption = 'Laundry Invoice Path';
        }
        field(48; "Profile Delegation Nos"; Code[10])
        {
            Caption = 'Profile Delegation Nos';
            TableRelation = "No. Series";
        }
        field(49; "Library Charge Template"; Code[20])
        {
            Caption = 'Library Charge Template';
            TableRelation = "Gen. Journal Template";
        }
        field(50; "Library Charge Batch"; Code[20])
        {
            Caption = 'Library Charge Batch';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Library Charge Template"));
        }
        field(51; "Library Charge Account"; Code[20])
        {
            Caption = 'Library Charge Account';
            TableRelation = "G/L Account";
        }
        field(52; "Proposed Budget Approval Nos"; Code[20])
        {
            Caption = 'Proposed Budget Approval Nos';
            TableRelation = "No. Series";
        }
        field(53; "Budget Approval Nos"; Code[20])
        {
            Caption = 'Budget Approval Nos';
            TableRelation = "No. Series";
        }
        field(54; "Bank Reconciliation Nos"; Code[20])
        {
            Caption = 'Bank Reconciliation Nos';
            TableRelation = "No. Series";
        }
        field(55; "Approtionment Account"; Code[20])
        {
            Caption = 'Approtionment Account';
            TableRelation = "G/L Account";
        }
        field(56; "Apportion Template"; Code[10])
        {
            Caption = 'Apportion Template';
            TableRelation = "Gen. Journal Template";
        }
        field(57; "Apportion Batch"; Code[10])
        {
            Caption = 'Apportion Batch';
            TableRelation = "Gen. Journal Batch".Name;
        }
        field(58; "Apportionment Nos"; Code[10])
        {
            Caption = 'Apportionment Nos';
            TableRelation = "No. Series";
        }
        field(59; "Input Tax Nos"; Code[10])
        {
            Caption = 'Input Tax Nos';
            TableRelation = "No. Series";
        }
        field(60; "Property Expense Nos"; Code[10])
        {
            Caption = 'Property Expense Nos';
            TableRelation = "No. Series";
        }
        field(61; "Property Expense Surrender Nos"; Code[10])
        {
            Caption = 'Property Expense Surrender Nos';
            TableRelation = "No. Series";
        }
        field(62; "Property Expense Claim Nos"; Code[10])
        {
            Caption = 'Property Expense Claim Nos';
            TableRelation = "No. Series";
        }
        field(63; "FA Disposal Nos"; Code[10])
        {
            Caption = 'FA Disposal Nos';
            TableRelation = "No. Series";
        }
        field(64; "Finance Email"; Text[100])
        {
            Caption = 'Finance Email';
        }
        field(65; "Cheque Reject Period"; DateFormula)
        {
            Caption = 'Cheque Reject Period';
        }
        field(66; "Use Bank Pmt Doc Nos"; Boolean)
        {
            Caption = 'Use Bank Payment Doc Nos';
            DataClassification = ToBeClassified;
        }
        field(67; "Payment Doc. Nos"; Code[10])
        {
            Caption = 'Payment Document Nos';
            DataClassification = SystemMetadata;
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
}
