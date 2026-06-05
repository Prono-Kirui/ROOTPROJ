pageextension 51002 GeneralJournalPageExt extends "General Journal"
{
    layout
    {
        modify("Deferral Code")
        {
            Visible = false;
        }
        modify("EU 3-Party Trade")
        {
            Visible = false;
        }
        modify("External Document No.")
        {
            Visible = true;
        }
        modify(Applied)
        {
            Visible = true;
        }
        modify("Applies-to Doc. No.")
        {
            Visible = true;
        }
        modify("Applies-to ID")
        {
            Visible = true;
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = true;
        }
        modify("Gen. Posting Type")
        {
            Visible = true;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = true;
        }

        addafter(Control30)
        {
            group(JournalNarration)
            {
                ShowCaption = false;
                field(Narration; Narration)
                {
                    ApplicationArea = All;
                    Caption = 'Narration';
                    ToolTip = 'Specifies the value of the Narration field.';
                    trigger OnValidate()
                    begin
                        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);

                        GenJnlBatch.UpdateNarration(Rec."Journal Template Name", Rec."Journal Batch Name", Narration, Rec."Document No.");
                    end;
                }
            }
        }
    }

    actions
    {
        addafter(SaveAsStandardJournal)
        {
            action(JournalReport)
            {
                ApplicationArea = All;
                Caption = 'Journal Report';
                Image = Report;
                ToolTip = 'Executes the Journal Report action.';
                trigger OnAction()
                begin
                    GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                    GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    JournalReport.SetTableView(GenJnlLine);
                    JournalReport.Run();
                end;
            }
        }
        addlast(Category_Report)
        {
            actionref(JournalReport_Promoted; JournalReport)
            {
            }
        }
        modify(Category_Report)
        {
            Caption = 'Journal Reports';
        }
    }

    var
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlLine: Record "Gen. Journal Line";
        JournalReport: Report "Journal Report";
        GenJnlManagement: Codeunit GenJnlManagement;
        AccName, BalAccName : Text[100];
        Narration: Text[100];

    trigger OnAfterGetRecord()
    begin
        Narration := GenJnlBatch.GetNarration(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Document No.");
    end;
}
