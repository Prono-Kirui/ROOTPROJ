page 51059 "Applied Cust Entries-Custom"
{
    ApplicationArea = All;
    Caption = 'Applied Customer Entries';
    DataCaptionExpression = Heading;
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    MultipleNewLines = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = "Cust. Ledger Entry";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                ShowCaption = false;

                field("Posting Date"; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                    ToolTip = 'Specifies the customer entry''s posting date.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    Caption = 'Document Type';
                    ToolTip = 'Specifies the document type that the customer entry belongs to.';
                }
                field("Document No."; Rec."Document No.")
                {
                    Caption = 'Document No.';
                    ToolTip = 'Specifies the entry''s document number.';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies a description of the customer entry.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Global Dimension 1 Code';
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                    Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Global Dimension 2 Code';
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                    Visible = false;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Salesperson Code';
                    ToolTip = 'Specifies the code for the salesperson whom the entry is linked to.';
                    Visible = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Currency Code';
                    ToolTip = 'Specifies the currency code for the amount on the line.';
                }
                field("Original Amount"; Rec."Original Amount")
                {
                    Caption = 'Original Amount';
                    ToolTip = 'Specifies the amount of the original entry.';
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                    ToolTip = 'Specifies the amount of the entry.';
                    Visible = AmountVisible;
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    Caption = 'Debit Amount';
                    ToolTip = 'Specifies the total of the ledger entries that represent debits.';
                    Visible = DebitCreditVisible;
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    Caption = 'Credit Amount';
                    ToolTip = 'Specifies the total of the ledger entries that represent credits.';
                    Visible = DebitCreditVisible;
                }
                field("Closed by Amount"; Rec."Closed by Amount")
                {
                    Caption = 'Closed by Amount';
                    ToolTip = 'Specifies the amount that the entry was finally applied to (closed) with.';
                }
                field("Closed by Currency Code"; Rec."Closed by Currency Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Closed by Currency Code';
                    ToolTip = 'Specifies the code of the currency of the entry that was applied to (and closed) this customer ledger entry.';
                    Visible = false;
                }
                field("Closed by Currency Amount"; Rec."Closed by Currency Amount")
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = Rec."Closed by Currency Code";
                    AutoFormatType = 1;
                    Caption = 'Closed by Currency Amount';
                    ToolTip = 'Specifies the amount that was finally applied to (and closed) this customer ledger entry.';
                    Visible = false;
                }
                field("User ID"; Rec."User ID")
                {
                    Caption = 'User ID';
                    ToolTip = 'Specifies the ID of the user who posted the entry, to be used, for example, in the change log.';
                    Visible = false;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Source Code';
                    ToolTip = 'Specifies the source code that specifies where the entry was created.';
                    Visible = false;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Reason Code';
                    ToolTip = 'Specifies the reason code, a supplementary source code that enables you to trace the entry.';
                    Visible = false;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                    ToolTip = 'Specifies the number of the entry, as assigned from the specified number series when the entry was created.';
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            group("Ent&ry")
            {
                Caption = 'Ent&ry';
                Image = Entry;

                action("Reminder/Fin. Charge Entries")
                {
                    ApplicationArea = Suite;
                    Caption = 'Reminder/Fin. Charge Entries';
                    Image = Reminder;
                    RunObject = page "Reminder/Fin. Charge Entries";
                    RunPageLink = "Customer Entry No." = field("Entry No.");
                    RunPageView = sorting("Customer Entry No.");
                    ToolTip = 'View entries that were created when reminders and finance charge memos were issued.';
                }
                action(Dimensions)
                {
                    AccessByPermission = tabledata Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortcutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions();
                    end;
                }
                action("Detailed &Ledger Entries")
                {
                    Caption = 'Detailed &Ledger Entries';
                    Image = View;
                    RunObject = page "Detailed Cust. Ledg. Entries";
                    RunPageLink = "Cust. Ledger Entry No." = field("Entry No."),
                                  "Customer No." = field("Customer No.");
                    RunPageView = sorting("Cust. Ledger Entry No.", "Posting Date");
                    ShortcutKey = 'Ctrl+F7';
                    ToolTip = 'View a summary of the all posted entries and adjustments related to a specific customer ledger entry.';
                }
            }
        }
        area(Processing)
        {
            action("&Navigate")
            {
                Caption = '&Navigate';
                Image = Navigate;
                ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.';

                trigger OnAction()
                begin
                    Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
                    Navigate.Run();
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Category_Process';
                actionref("&Navigate_Promoted"; "&Navigate")
                {
                }
            }
        }
    }

    var
        CreateCustLedgEntry: Record "Cust. Ledger Entry";
        Navigate: Page Navigate;
        AmountVisible: Boolean;
        DebitCreditVisible: Boolean;
        Heading: Text[50];

    trigger OnInit()
    begin
        AmountVisible := true;
    end;

    procedure SetTempCustLedgEntry(NewTempCustLedgEntryNo: Integer)
    begin
        if NewTempCustLedgEntryNo <> 0 then begin
            Rec.SetRange("Entry No.", NewTempCustLedgEntryNo);
            Rec.Find('-');
        end;
    end;

    local procedure FindApplnEntriesDtldtLedgEntry()
    var
        DtldCustLedgEntry1: Record "Detailed Cust. Ledg. Entry";
        DtldCustLedgEntry2: Record "Detailed Cust. Ledg. Entry";
    begin
        DtldCustLedgEntry1.SetCurrentKey("Cust. Ledger Entry No.");
        DtldCustLedgEntry1.SetRange("Cust. Ledger Entry No.", CreateCustLedgEntry."Entry No.");
        DtldCustLedgEntry1.SetRange(Unapplied, false);
        if DtldCustLedgEntry1.Find('-') then
            repeat
                if DtldCustLedgEntry1."Cust. Ledger Entry No." =
                   DtldCustLedgEntry1."Applied Cust. Ledger Entry No."
                then begin
                    DtldCustLedgEntry2.Init();
                    DtldCustLedgEntry2.SetCurrentKey("Applied Cust. Ledger Entry No.", "Entry Type");
                    DtldCustLedgEntry2.SetRange(
                      "Applied Cust. Ledger Entry No.", DtldCustLedgEntry1."Applied Cust. Ledger Entry No.");
                    DtldCustLedgEntry2.SetRange("Entry Type", DtldCustLedgEntry2."Entry Type"::Application);
                    DtldCustLedgEntry2.SetRange(Unapplied, false);
                    if DtldCustLedgEntry2.Find('-') then
                        repeat
                            if DtldCustLedgEntry2."Cust. Ledger Entry No." <>
                               DtldCustLedgEntry2."Applied Cust. Ledger Entry No."
                            then begin
                                Rec.SetCurrentKey("Entry No.");
                                Rec.SetRange("Entry No.", DtldCustLedgEntry2."Cust. Ledger Entry No.");
                                if Rec.Find('-') then
                                    Rec.Mark(true);
                            end;
                        until DtldCustLedgEntry2.Next() = 0;
                end else begin
                    Rec.SetCurrentKey("Entry No.");
                    Rec.SetRange("Entry No.", DtldCustLedgEntry1."Applied Cust. Ledger Entry No.");
                    if Rec.Find('-') then
                        Rec.Mark(true);
                end;
            until DtldCustLedgEntry1.Next() = 0;
    end;

    local procedure SetConrolVisibility()
    var
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.Get();
        AmountVisible := not (GLSetup."Show Amounts" = GLSetup."Show Amounts"::"Debit/Credit Only");
        DebitCreditVisible := not (GLSetup."Show Amounts" = GLSetup."Show Amounts"::"Amount Only");
    end;
}
