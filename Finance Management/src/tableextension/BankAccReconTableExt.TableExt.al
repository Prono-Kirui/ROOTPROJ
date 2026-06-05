tableextension 51006 BankAccReconTableExt extends "Bank Acc. Reconciliation"
{
    fields
    {
        field(51000; "Approval Status"; Option)
        {
            Caption = 'Approval Status';
            DataClassification = CustomerContent;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(51001; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(51002; "Reconciliation Option"; Option)
        {
            Caption = 'Reconciliation Option';
            DataClassification = ToBeClassified;
            OptionMembers = Automated,Manual;
            trigger OnValidate()
            begin
                TestField("Approval Status", "Approval Status"::Open);
                if "Reconciliation Option" <> xRec."Reconciliation Option" then
                    if ReconLinesExist() then
                        if Confirm('Existing reconciliation lines will be deleted,\ Do you wish to continue?', false) = true then begin
                            BankAccReconLine.Reset();
                            BankAccReconLine.SetRange("Bank Account No.", "Bank Account No.");
                            BankAccReconLine.SetRange("Statement No.", "Statement No.");
                            BankAccReconLine.DeleteAll(true);
                        end else
                            Error('You selected No');
            end;
        }
    }

    var
        BankAccReconLine: Record "Bank Acc. Reconciliation Line";
        ReportSelection: Record "Report Selections";

    procedure ReconLinesExist(): Boolean
    begin
        BankAccReconLine.Reset();
        BankAccReconLine.SetRange("Bank Account No.", "Bank Account No.");
        BankAccReconLine.SetRange("Statement No.", "Statement No.");
        exit(BankAccReconLine.FindFirst());
    end;

    procedure PrintBankAccRecon(NewBankAccRecon: Record "Bank Acc. Reconciliation")
    var
        BankAccRecon: Record "Bank Acc. Reconciliation";
    begin
        BankAccRecon := NewBankAccRecon;
        BankAccRecon.SetRecFilter();
        ReportSelection.PrintWithCheckForCust(ReportSelection.Usage::"B.Recon.Test", BankAccRecon, 0);
    end;
}
