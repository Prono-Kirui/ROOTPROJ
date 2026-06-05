report 51041 "Update Payee"
{
    ApplicationArea = All;
    Caption = 'Update Payee';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    Permissions = tabledata "G/L Entry" = RM, tabledata "Bank Account Ledger Entry" = RM;

    dataset
    {
        dataitem(Payments; Payments)
        {
            DataItemTableView = where(Posted = const(true));
            trigger OnAfterGetRecord()
            begin
                GLEntry.Reset();
                GLEntry.SetRange("Document No.", Payments."No.");
                GLEntry.SetFilter(Payee, '=%1', '');
                if GLEntry.FindSet() then
                    repeat
                        case Payments."Payment Type" of
                            Payments."Payment Type"::Receipt:
                                GLEntry."Payee" := Payments."Received From";
                            else
                                GLEntry.Payee := Payments."Payee";
                        end;
                        GLEntry.Modify();
                    until GLEntry.Next() = 0;

                BankAccountLedgerEntry.Reset();
                BankAccountLedgerEntry.SetRange("Document No.", Payments."No.");
                BankAccountLedgerEntry.SetFilter(Payee, '=%1', '');
                if BankAccountLedgerEntry.FindSet() then
                    repeat
                        case Payments."Payment Type" of
                            Payments."Payment Type"::Receipt:
                                BankAccountLedgerEntry."Payee" := Payments."Received From";
                            else
                                BankAccountLedgerEntry.Payee := Payments."Payee";
                        end;
                        BankAccountLedgerEntry.Modify();
                    until BankAccountLedgerEntry.Next() = 0;
            end;
        }
    }
    trigger OnPostReport()
    begin
        Message('Payee updated successfully');
    end;

    var
        GLEntry: Record "G/L Entry";
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
}
