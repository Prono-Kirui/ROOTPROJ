tableextension 51011 "General Batch Approval" extends "Gen. Journal Batch"
{
    fields
    {
        field(51000; "Payroll period"; Code[20])
        {
            Caption = 'Payroll period';
            DataClassification = CustomerContent;
        }
        field(51001; "Payroll start date"; Date)
        {
            Caption = 'Payroll start date';
            DataClassification = CustomerContent;
        }
        field(51002; Narration; Text[100])
        {
            Caption = 'Narration';
            DataClassification = CustomerContent;
        }
        field(51003; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
    }

    var
        GenJnlBatch: Record "Gen. Journal Batch";

    procedure UpdateNarration(JournalTemplateName: Code[20]; BatchName: Code[20]; INarration: Text[100]; DocNo: Code[100])
    begin
        if GenJnlBatch.Get(JournalTemplateName, BatchName) then begin
            GenJnlBatch.Narration := INarration;
            GenJnlBatch."Document No." := DocNo;
            GenJnlBatch.Modify();
        end;
    end;

    procedure GetNarration(JournalTemplateName: Code[20]; BatchName: Code[20]; DocNo: Code[100]) Narration: Text[100]
    begin
        if GenJnlBatch.Get(JournalTemplateName, BatchName) then begin
            GenJnlBatch.Narration := GenJnlBatch.Narration;
            exit(GenJnlBatch.Narration);
        end;
    end;

    procedure ClearNarration(JournalTemplateName: Code[50]; BatchName: Code[50]; DocNo: Code[50]) Narration: Text[100]
    begin
        GenJnlBatch.Reset();
        GenJnlBatch.SetRange("Journal Template Name", JournalTemplateName);
        GenJnlBatch.SetRange(Name, BatchName);
        if GenJnlBatch.FindFirst() then
            GenJnlBatch.Narration := '';
        GenJnlBatch."Document No." := '';
        exit(GenJnlBatch.Narration);
    end;
}
