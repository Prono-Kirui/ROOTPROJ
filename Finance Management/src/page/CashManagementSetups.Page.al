page 51000 "Cash Management Setups"
{
    ApplicationArea = All;
    Caption = 'Cash Management Setups';
    PageType = Card;
    SourceTable = "Cash Management Setups";
    UsageCategory = Lists;
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Payment Voucher Template"; Rec."Payment Voucher Template")
                {
                    Caption = 'Payment Voucher Template';
                    ToolTip = 'Specifies the value of the Payment Voucher Template field';
                }
                field("Imprest Journal Template"; Rec."Imprest Journal Template")
                {
                    Caption = 'Imprest Journal Template';
                    ToolTip = 'Specifies the value of the Imprest Journal Template field';
                }
                field("Imprest Surrender Template"; Rec."Imprest Surrender Template")
                {
                    Caption = 'Imprest Surrender Template';
                    ToolTip = 'Specifies the value of the Imprest Surrender Template field';
                }
                field("Petty Cash Journal Template"; Rec."Petty Cash Journal Template")
                {
                    Caption = 'Petty Cash Journal Template';
                    ToolTip = 'Specifies the value of the Petty Cash Journal Template field';
                }
                field("Petty Cash Surrender Template"; Rec."Petty Cash Surrender Template")
                {
                    Caption = 'Petty Cash Surrender Template';
                    ToolTip = 'Specifies the value of the Petty Cash Surrender Template field';
                }
                field("Receipt Template"; Rec."Receipt Template")
                {
                    Caption = 'Receipt Template';
                    ToolTip = 'Specifies the value of the Receipt Template field';
                }
                field("Staff Claim Template"; Rec."Staff Claim Template")
                {
                    Caption = 'Staff Claim Template';
                    ToolTip = 'Specifies the value of the Staff Claim Template field';
                }
                field("Bank Transfer Template"; Rec."Bank Transfer Template")
                {
                    Caption = 'Bank Transfer Template';
                    ToolTip = 'Specifies the value of the Bank Transfer Template field';
                }
                field("Post VAT"; Rec."Post VAT")
                {
                    Caption = 'Post VAT';
                    ToolTip = 'Specifies the value of the Post VAT field';
                }
                field("Rounding Type"; Rec."Rounding Type")
                {
                    Caption = 'Rounding Type';
                    ToolTip = 'Specifies the value of the Rounding Type field';
                }
                field("Rounding Precision"; Rec."Rounding Precision")
                {
                    Caption = 'Rounding Precision';
                    ToolTip = 'Specifies the value of the Rounding Precision field';
                }
                field("Imprest Limit"; Rec."Imprest Limit")
                {
                    Caption = 'Imprest Limit';
                    ToolTip = 'Specifies the value of the Imprest Limit field';
                }
                field("Imprest Due Date"; Rec."Imprest Due Date")
                {
                    Caption = 'Imprest Due Date';
                    ToolTip = 'Specifies the value of the Imprest Due Date field';
                }
                field("Current Budget"; Rec."Current Budget")
                {
                    Caption = 'Current Budget';
                    ToolTip = 'Specifies the value of the Current Budget field';
                }
                field("Current Budget Start Date"; Rec."Current Budget Start Date")
                {
                    Caption = 'Current Budget Start Date';
                    ToolTip = 'Specifies the value of the Current Budget Start Date field';
                }
                field("Current Budget End Date"; Rec."Current Budget End Date")
                {
                    Caption = 'Current Budget End Date';
                    ToolTip = 'Specifies the value of the Current Budget End Date field';
                }
                field("Imprest Posting Group"; Rec."Imprest Posting Group")
                {
                    Caption = 'Imprest Posting Group';
                    ToolTip = 'Specifies the value of the Imprest Posting Group field';
                }
                field("General Bus. Posting Group"; Rec."General Bus. Posting Group")
                {
                    Caption = 'General Bus. Posting Group';
                    ToolTip = 'Specifies the value of the General Bus. Posting Group field';
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    Caption = 'VAT Bus. Posting Group';
                    ToolTip = 'Specifies the value of the VAT Bus. Posting Group field';
                }
                field("Check for Committment"; Rec."Check for Committment")
                {
                    Caption = 'Check for Committment';
                    ToolTip = 'Specifies the value of the Check for Committment field';
                }
                field("Petty Cash Max"; Rec."Petty Cash Max")
                {
                    Caption = 'Petty Cash Max';
                    ToolTip = 'Specifies the value of the Petty Cash Max field';
                }
                field("Max Imprests Unsurrendered"; Rec."Max Imprests Unsurrendered")
                {
                    Caption = 'Max Imprests Unsurrendered';
                    ToolTip = 'Specifies the value of the Max Imprests Unsurrendered field';
                }
                field("Max Open Documents"; Rec."Max Open Documents")
                {
                    Caption = 'Max Open Documents';
                    ToolTip = 'Specifies the value of the Max Open Documents field';
                }
                field("EFT Path"; Rec."EFT Path")
                {
                    Caption = 'EFT Path';
                    ToolTip = 'Specifies the value of the EFT Path field';
                }
                field("Append Sign To Documents"; Rec."Append Sign To Documents")
                {
                    Caption = 'Append Signatures on Documents';
                    ToolTip = 'Specifies the value of the Append Signatures on Documents field';
                }
                field("Loan Journal Template"; Rec."Loan Journal Template")
                {
                    Caption = 'Loan Journal Template';
                    ToolTip = 'Specifies the value of the Loan Journal Template field';
                }
                field("Loan Batch Template"; Rec."Loan Batch Template")
                {
                    Caption = 'Loan Batch Template';
                    ToolTip = 'Specifies the value of the Loan Batch Template field';
                }
                field("Use Bank Pmt Doc Nos"; Rec."Use Bank Pmt Doc Nos")
                {
                    Caption = 'Use Bank Payment Doc Nos';
                    ToolTip = 'Specifies the value of the Use Bank Payment Doc Nos field.';
                }
                field("Cheque Reject Period"; Rec."Cheque Reject Period")
                {
                    Caption = 'Cheque Reject Period';
                    ToolTip = 'Specifies the value of allowed cheque period';
                }
            }
            group(Numbering)
            {
                Caption = 'Numbering';
                field("PV Nos"; Rec."PV Nos")
                {
                    Caption = 'PV Nos';
                    ToolTip = 'Specifies the value of the PV Nos field';
                }
                field("Petty Cash Nos"; Rec."Petty Cash Nos")
                {
                    Caption = 'Petty Cash Nos';
                    ToolTip = 'Specifies the value of the Petty Cash Nos field';
                }
                field("Petty Cash Surrender Nos"; Rec."Petty Cash Surrender Nos")
                {
                    Caption = 'Petty Cash Surrender Nos';
                    ToolTip = 'Specifies the value of the Petty Cash Surrender Nos field';
                }
                field("Imprest Nos"; Rec."Imprest Nos")
                {
                    Caption = 'Imprest Nos';
                    ToolTip = 'Specifies the value of the Imprest Nos field';
                }
                field("Imprest Surrender Nos"; Rec."Imprest Surrender Nos")
                {
                    Caption = 'Imprest Surrender Nos';
                    ToolTip = 'Specifies the value of the Imprest Surrender Nos field';
                }
                field("Receipt Nos"; Rec."Receipt Nos")
                {
                    Caption = 'Receipt Nos';
                    ToolTip = 'Specifies the value of the Receipt Nos field';
                }
                field("Donor Workflows Nos"; Rec."Donor Workflows Nos")
                {
                    Caption = 'Donor Workflows Nos';
                    ToolTip = 'Specifies the value of the Donor Workflows Nos field';
                }
                field("Approvals Delegation Nos."; Rec."Approvals Delegation Nos.")
                {
                    Caption = 'Approvals Delegation Nos.';
                    ToolTip = 'Specifies the value of the Approvals Delegation Nos. field';
                }
                field("Staff Claim Nos"; Rec."Staff Claim Nos")
                {
                    Caption = 'Staff Claim Nos';
                    ToolTip = 'Specifies the value of the Staff Claim Nos field';
                }
                field("Bank Transfer Nos"; Rec."Bank Transfer Nos")
                {
                    Caption = 'Bank Transfer Nos';
                    ToolTip = 'Specifies the value of the Bank Transfer Nos field';
                }
                field("Profile Delegation Nos"; Rec."Profile Delegation Nos")
                {
                    Caption = 'Profile Delegation Nos';
                    ToolTip = 'Specifies the value of the Profile Delegation Nos field';
                }
                field("Apportionment Nos"; Rec."Apportionment Nos")
                {
                    Caption = 'Apportionment Nos';
                    ToolTip = 'Specifies the value of the Apportionment Nos field';
                }
                field("Input Tax Nos"; Rec."Input Tax Nos")
                {
                    Caption = 'Input Tax Nos';
                    ToolTip = 'Specifies the value of the Input Tax Nos field';
                }
                field("Property Expense Nos"; Rec."Property Expense Nos")
                {
                    Caption = 'Property Expense Nos';
                    ToolTip = 'Specifies the value of the Property Expense Nos field';
                }
                field("Property Expense Surrender Nos"; Rec."Property Expense Surrender Nos")
                {
                    Caption = 'Property Expense Surrender Nos';
                    ToolTip = 'Specifies the value of the Property Expense Surrender Nos field';
                }
                field("Property Expense Claim Nos"; Rec."Property Expense Claim Nos")
                {
                    Caption = 'Property Expense Claim Nos';
                    ToolTip = 'Specifies the value of the Property Expense Claim Nos field';
                }
                field("Budget Approval Nos"; Rec."Budget Approval Nos")
                {
                    Caption = 'Budget Approval Nos';
                    ToolTip = 'Specifies the value of the Budget Approval Nos field';
                }
                field("Proposed Budget Approval Nos"; Rec."Proposed Budget Approval Nos")
                {
                    Caption = 'Proposed Budget Approval Nos';
                    ToolTip = 'Specifies the value of the Proposed Budget Approval Nos field';
                }
                field("FA Disposal Nos"; Rec."FA Disposal Nos")
                {
                    Caption = 'FA Disposal Nos';
                    ToolTip = 'Specifies the value of the FA Disposal Nos field';
                }
                field("Payment Doc. Nos"; Rec."Payment Doc. Nos")
                {
                    Caption = 'Payment Document Nos';
                    ToolTip = 'Specifies the value of the Payment Document Nos field.';
                }
            }
            group(Accounts)
            {
                Caption = 'Accounts';

                field("Approtionment Account"; Rec."Approtionment Account")
                {
                    Caption = 'Approtionment Account';
                    ToolTip = 'Specifies the value of the Approtionment Account field';
                }
                field("Apportion Template"; Rec."Apportion Template")
                {
                    Caption = 'Apportion Template';
                    ToolTip = 'Specifies the value of the Apportion Template field';
                }
                field("Apportion Batch"; Rec."Apportion Batch")
                {
                    Caption = 'Apportion Batch';
                    ToolTip = 'Specifies the value of the Apportion Batch field';
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Finance Email"; Rec."Finance Email")
                {
                    Caption = 'Finance Email';
                    ToolTip = 'Specifies the value of the Finance Email field';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
