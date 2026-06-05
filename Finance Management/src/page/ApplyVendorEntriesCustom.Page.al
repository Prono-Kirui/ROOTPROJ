page 51055 "Apply Vendor Entries Custom"
{
    ApplicationArea = All;
    Caption = 'Apply Vendor Entries';
    DataCaptionFields = "Vendor No.";
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = Worksheet;
    SourceTable = "Vendor Ledger Entry";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("ApplyingVendLedgEntry.""Posting Date"""; ApplyingVendLedgEntry."Posting Date")
                {
                    Caption = 'Posting Date';
                    Editable = false;
                    ToolTip = 'Specifies the posting date of the entry to be applied.';
                }
                field("ApplyingVendLedgEntry.""Document Type"""; ApplyingVendLedgEntry."Document Type")
                {
                    Caption = 'Document Type';
                    Editable = false;
                    ToolTip = 'Specifies the document type of the entry to be applied.';
                }
                field("ApplyingVendLedgEntry.""Document No."""; ApplyingVendLedgEntry."Document No.")
                {
                    Caption = 'Document No.';
                    Editable = false;
                    ToolTip = 'Specifies the document number of the entry to be applied.';
                }
                field(ApplyingVendorNo; ApplyingVendLedgEntry."Vendor No.")
                {
                    Caption = 'Vendor No.';
                    Editable = false;
                    ToolTip = 'Specifies the vendor number of the entry to be applied.';
                    Visible = false;
                }
                field(ApplyingVendorName; ApplyingVendLedgEntry."Vendor Name")
                {
                    Caption = 'Vendor Name';
                    Editable = false;
                    ToolTip = 'Specifies the vendor name of the entry to be applied.';
                    Visible = VendNameVisible;
                }
                field(ApplyingDescription; ApplyingVendLedgEntry.Description)
                {
                    Caption = 'Description';
                    Editable = false;
                    ToolTip = 'Specifies the description of the entry to be applied.';
                    Visible = false;
                }
                field("ApplyingVendLedgEntry.""Currency Code"""; ApplyingVendLedgEntry."Currency Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Currency Code';
                    Editable = false;
                    ToolTip = 'Specifies the code for the currency that amounts are shown in.';
                }
                field("ApplyingVendLedgEntry.Amount"; ApplyingVendLedgEntry.Amount)
                {
                    Caption = 'Amount';
                    Editable = false;
                    ToolTip = 'Specifies the amount on the entry to be applied.';
                }
                field("ApplyingVendLedgEntry.""Remaining Amount"""; ApplyingVendLedgEntry."Remaining Amount")
                {
                    Caption = 'Remaining Amount';
                    Editable = false;
                    ToolTip = 'Specifies the amount on the entry to be applied.';
                }
            }
            repeater(Control1)
            {
                ShowCaption = false;
                field(AppliesToID; Rec."Applies-to ID")
                {
                    Caption = 'Applies-to ID';
                    ToolTip = 'Specifies the ID of entries that will be applied to when you choose the Apply Entries action.';
                    Visible = AppliesToIDVisible;
                    trigger OnValidate()
                    begin
                        if (CalcType = CalcType::GenJnlLine) and (ApplnType = ApplnType::"Applies-to Doc. No.") then
                            Error(CannotSetAppliesToIDErr);

                        SetVendApplId(true);

                        CurrPage.Update(false);
                    end;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                    Editable = false;
                    ToolTip = 'Specifies the vendor entry''s posting date.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    Caption = 'Document Type';
                    Editable = false;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the document type that the vendor entry belongs to.';
                }
                field("Document No."; Rec."Document No.")
                {
                    Caption = 'Document No.';
                    Editable = false;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the vendor entry''s document number.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Caption = 'External Document No.';
                    ToolTip = 'Specifies a document number that refers to the customer''s or vendor''s numbering system.';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    Caption = 'Vendor No.';
                    Editable = false;
                    ToolTip = 'Specifies the number of the vendor account that the entry is linked to.';
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    Caption = 'Vendor Name';
                    Editable = false;
                    ToolTip = 'Specifies the name of the vendor account that the entry is linked to.';
                    Visible = VendNameVisible;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    Editable = false;
                    ToolTip = 'Specifies a description of the vendor entry.';
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
                    Editable = false;
                    ToolTip = 'Specifies the amount of the original entry.';
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                    Editable = false;
                    ToolTip = 'Specifies the amount of the entry.';
                    Visible = false;
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    Caption = 'Debit Amount';
                    ToolTip = 'Specifies the total of the ledger entries that represent debits.';
                    Visible = false;
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    Caption = 'Credit Amount';
                    ToolTip = 'Specifies the total of the ledger entries that represent credits.';
                    Visible = false;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    Caption = 'Remaining Amount';
                    Editable = false;
                    ToolTip = 'Specifies the amount that remains to be applied to before the entry is totally applied to.';
                }
                field("CalcApplnRemainingAmount(""Remaining Amount"")"; CalcApplnRemainingAmount(Rec."Remaining Amount"))
                {
                    AutoFormatExpression = ApplnCurrencyCode;
                    AutoFormatType = 1;
                    Caption = 'Appln. Remaining Amount';
                    ToolTip = 'Specifies the amount that remains to be applied to before the entry is totally applied to.';
                }
                field("Amount to Apply"; Rec."Amount to Apply")
                {
                    Caption = 'Amount to Apply';
                    ToolTip = 'Specifies the amount to apply.';
                    trigger OnValidate()
                    begin
                        Codeunit.Run(Codeunit::"Vend. Entry-Edit", Rec);

                        if (xRec."Amount to Apply" = 0) or (Rec."Amount to Apply" = 0) and
                           ((ApplnType = ApplnType::"Applies-to ID") or (CalcType = CalcType::Direct))
                        then
                            SetVendApplId(false);
                        Rec.Get(Rec."Entry No.");
                        AmountToApplyOnAfterValidate();
                    end;
                }
                field(ApplnAmountToApply; CalcApplnAmountToApply(Rec."Amount to Apply"))
                {
                    AutoFormatExpression = ApplnCurrencyCode;
                    AutoFormatType = 1;
                    Caption = 'Appln. Amount to Apply';
                    ToolTip = 'Specifies the amount to apply.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    Caption = 'Due Date';
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the due date on the entry.';
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    Caption = 'Pmt. Discount Date';
                    ToolTip = 'Specifies the date on which the amount in the entry must be paid for a payment discount to be granted.';
                    trigger OnValidate()
                    begin
                        RecalcApplnAmount();
                    end;
                }
                field("Pmt. Disc. Tolerance Date"; Rec."Pmt. Disc. Tolerance Date")
                {
                    Caption = 'Pmt. Disc. Tolerance Date';
                    ToolTip = 'Specifies the latest date the amount in the entry must be paid in order for payment discount tolerance to be granted.';
                }
                field("Payment Reference"; Rec."Payment Reference")
                {
                    Caption = 'Payment Reference';
                    ToolTip = 'Specifies the payment of the purchase invoice.';
                }
                field("Original Pmt. Disc. Possible"; Rec."Original Pmt. Disc. Possible")
                {
                    Caption = 'Original Pmt. Disc. Possible';
                    ToolTip = 'Specifies the discount that you can obtain if the entry is applied to before the payment discount date.';
                    Visible = false;
                }
                field("Remaining Pmt. Disc. Possible"; Rec."Remaining Pmt. Disc. Possible")
                {
                    Caption = 'Remaining Pmt. Disc. Possible';
                    ToolTip = 'Specifies the remaining payment discount which can be received if the payment is made before the payment discount date.';
                    trigger OnValidate()
                    begin
                        RecalcApplnAmount();
                    end;
                }
                field("CalcApplnRemainingAmount(""Remaining Pmt. Disc. Possible"")"; CalcApplnRemainingAmount(Rec."Remaining Pmt. Disc. Possible"))
                {
                    AutoFormatExpression = ApplnCurrencyCode;
                    AutoFormatType = 1;
                    Caption = 'Appln. Pmt. Disc. Possible';
                    ToolTip = 'Specifies the discount that you can obtain if the entry is applied to before the payment discount date.';
                }
                field("Max. Payment Tolerance"; Rec."Max. Payment Tolerance")
                {
                    Caption = 'Max. Payment Tolerance';
                    ToolTip = 'Specifies the maximum tolerated amount the entry can differ from the amount on the invoice or credit memo.';
                }
                field(Open; Rec.Open)
                {
                    Caption = 'Open';
                    Editable = false;
                    ToolTip = 'Specifies whether the amount on the entry has been fully paid or there is still a remaining amount that must be applied to.';
                }
                field(Positive; Rec.Positive)
                {
                    Caption = 'Positive';
                    Editable = false;
                    ToolTip = 'Specifies if the entry to be applied is positive.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Global Dimension 1 Code';
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Global Dimension 2 Code';
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                }
            }
            group(Control41)
            {
                ShowCaption = false;
                fixed(Control1903222401)
                {
                    ShowCaption = false;
                    group("Appln. Currency")
                    {
                        Caption = 'Appln. Currency';
                        field(ApplnCurrencyCode; ApplnCurrencyCode)
                        {
                            ApplicationArea = Suite;
                            Editable = false;
                            ShowCaption = false;
                            TableRelation = Currency;
                            ToolTip = 'Specifies the currency code that the amount will be applied in, in case of different currencies.';
                        }
                    }
                    group(Control1900545201)
                    {
                        Caption = 'Amount to Apply';
                        field(AmountToApply; AppliedAmount)
                        {
                            AutoFormatExpression = ApplnCurrencyCode;
                            AutoFormatType = 1;
                            Caption = 'Amount to Apply';
                            Editable = false;
                            ToolTip = 'Specifies the sum of the amounts on all the selected vendor ledger entries that will be applied by the entry shown in the Available Amount field. The amount is in the currency represented by the code in the Currency Code field.';
                        }
                    }
                    group("Pmt. Disc. Amount")
                    {
                        Caption = 'Pmt. Disc. Amount';
                        field(PmtDiscountAmount; -PmtDiscAmount)
                        {
                            AutoFormatExpression = ApplnCurrencyCode;
                            AutoFormatType = 1;
                            Caption = 'Pmt. Disc. Amount';
                            Editable = false;
                            ToolTip = 'Specifies the sum of the payment discount amounts granted on all the selected vendor ledger entries that will be applied by the entry shown in the Available Amount field. The amount is in the currency represented by the code in the Currency Code field.';
                        }
                    }
                    group(Rounding)
                    {
                        Caption = 'Rounding';
                        field(ApplnRounding; ApplnRounding)
                        {
                            AutoFormatExpression = ApplnCurrencyCode;
                            AutoFormatType = 1;
                            Caption = 'Rounding';
                            Editable = false;
                            ToolTip = 'Specifies the rounding difference when you apply entries in different currencies to one another. The amount is in the currency represented by the code in the Currency Code field.';
                        }
                    }
                    group("Applied Amount")
                    {
                        Caption = 'Applied Amount';
                        field(AppliedAmount; AppliedAmount + (-PmtDiscAmount) + ApplnRounding)
                        {
                            AutoFormatExpression = ApplnCurrencyCode;
                            AutoFormatType = 1;
                            Caption = 'Applied Amount';
                            Editable = false;
                            ToolTip = 'Specifies the sum of the amounts in the Amount to Apply field, Pmt. Disc. Amount field, and the Rounding. The amount is in the currency represented by the code in the Currency Code field.';
                        }
                    }
                    group("Available Amount")
                    {
                        Caption = 'Available Amount';
                        field(ApplyingAmount; ApplyingAmount)
                        {
                            AutoFormatExpression = ApplnCurrencyCode;
                            AutoFormatType = 1;
                            Caption = 'Available Amount';
                            Editable = false;
                            ToolTip = 'Specifies the amount of the journal entry, purchase credit memo, or current vendor ledger entry that you have selected as the applying entry.';
                        }
                    }
                    group(Balance)
                    {
                        Caption = 'Balance';
                        field(ControlBalance; AppliedAmount + (-PmtDiscAmount) + ApplyingAmount + ApplnRounding)
                        {
                            AutoFormatExpression = ApplnCurrencyCode;
                            AutoFormatType = 1;
                            Caption = 'Balance';
                            Editable = false;
                            ToolTip = 'Specifies any extra amount that will remain after the application.';
                        }
                    }
                }
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
                action("Applied E&ntries")
                {
                    Caption = 'Applied E&ntries';
                    Image = Approve;
                    RunObject = page "Applied Vendor Entries";
                    RunPageOnRec = true;
                    ToolTip = 'View the ledger entries that have been applied to this record.';
                }
                action(Dimensions)
                {
                    AccessByPermission = tabledata Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortcutKey = 'Alt+D';
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
                    RunObject = page "Detailed Vendor Ledg. Entries";
                    RunPageLink = "Vendor Ledger Entry No." = field("Entry No.");
                    RunPageView = sorting("Vendor Ledger Entry No.", "Posting Date");
                    ShortcutKey = 'Ctrl+F7';
                    ToolTip = 'View a summary of the all posted entries and adjustments related to a specific vendor ledger entry.';
                }
                action(Navigate)
                {
                    Caption = 'Find entries...';
                    Image = Navigate;
                    ShortcutKey = 'Shift+Ctrl+I';
                    ToolTip = 'Find entries and documents that exist for the document number and posting date on the selected document. (Formerly this action was named Navigate.)';
                    Visible = not IsOfficeAddin;

                    trigger OnAction()
                    begin
                        Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
                        Navigate.Run();
                    end;
                }
            }
        }
        area(Processing)
        {
            group("&Application")
            {
                Caption = '&Application';
                Image = Apply;
                action(ActionSetAppliesToID)
                {
                    Caption = 'Set Applies-to ID';
                    Image = SelectLineToApply;
                    ShortcutKey = 'Shift+F11';
                    ToolTip = 'Set the Applies-to ID field on the posted entry to automatically be filled in with the document number of the entry in the journal.';

                    trigger OnAction()
                    begin
                        if (CalcType = CalcType::GenJnlLine) and (ApplnType = ApplnType::"Applies-to Doc. No.") then
                            Error(CannotSetAppliesToIDErr);

                        SetVendApplId(false);
                    end;
                }
                action(ActionPostApplication)
                {
                    Caption = 'Post Application';
                    Ellipsis = true;
                    Image = PostApplication;
                    ShortcutKey = 'F9';
                    ToolTip = 'Define the document number of the ledger entry to use to perform the application. In addition, you specify the Posting Date for the application.';

                    trigger OnAction()
                    begin
                        PostDirectApplication(false);
                    end;
                }
                action(Preview)
                {
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;
                    ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                    trigger OnAction()
                    begin
                        PostDirectApplication(true);
                    end;
                }
                separator("-")
                {
                    Caption = '-';
                }
                action("Show Only Selected Entries to Be Applied")
                {
                    Caption = 'Show Only Selected Entries to Be Applied';
                    Image = ShowSelected;
                    ToolTip = 'View the selected ledger entries that will be applied to the specified record.';

                    trigger OnAction()
                    begin
                        ShowAppliedEntries := not ShowAppliedEntries;
                        if ShowAppliedEntries then
                            if CalcType = CalcType::GenJnlLine then
                                Rec.SetRange("Applies-to ID", GenJnlLine."Applies-to ID")
                            else begin
                                VendEntryApplID := UserId;
                                if VendEntryApplID = '' then
                                    VendEntryApplID := '***';
                                Rec.SetRange("Applies-to ID", VendEntryApplID);
                            end
                        else
                            Rec.SetRange("Applies-to ID");
                    end;
                }
            }
            action(ShowPostedDocument)
            {
                Caption = 'Show Posted Document';
                Image = Document;
                ToolTip = 'Show details for the posted payment, invoice, or credit memo.';

                trigger OnAction()
                begin
                    Rec.ShowDoc()
                end;
            }
            action(ShowDocumentAttachment)
            {
                Caption = 'Show Document Attachment';
                Enabled = HasDocumentAttachment;
                Image = Attach;
                ToolTip = 'View documents or images that are attached to the posted invoice or credit memo.';

                trigger OnAction()
                begin
                    Rec.ShowPostedDocAttachment();
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';

                actionref(ActionSetAppliesToID_Promoted; ActionSetAppliesToID)
                {
                }
                actionref(ActionPostApplication_Promoted; ActionPostApplication)
                {
                }
                actionref(Preview_Promoted; Preview)
                {
                }
                actionref("Show Only Selected Entries to Be Applied_Promoted"; "Show Only Selected Entries to Be Applied")
                {
                }
            }

            group(Category_Category4)
            {
                Caption = 'Line', Comment = 'Generated from the PromotedActionCategories property index 3.';

                actionref(ShowPostedDocument_Promoted; ShowPostedDocument)
                {
                }
                actionref(ShowDocumentAttachment_Promoted; ShowDocumentAttachment)
                {
                }
            }
            group(Category_Category5)
            {
                Caption = 'Entry', Comment = 'Generated from the PromotedActionCategories property index 4.';

                actionref("Applied E&ntries_Promoted"; "Applied E&ntries")
                {
                }
                actionref(Dimensions_Promoted; Dimensions)
                {
                }
                actionref("Detailed &Ledger Entries_Promoted"; "Detailed &Ledger Entries")
                {
                }
                actionref(Navigate_Promoted; Navigate)
                {
                }
            }
        }
    }

    var
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        GenJnlLine: Record "Gen. Journal Line";
        GLSetup: Record "General Ledger Setup";
        PaymentLine, PaymentLine2 : Record "Payment Lines";
        PaymentRec: Record Payments;
        PurchHeader: Record "Purchase Header";
        TotalPurchLine: Record "Purchase Line";
        TotalPurchLineLCY: Record "Purchase Line";
        PurchSetup: Record "Purchases & Payables Setup";
        Vend: Record Vendor;
        ApplyingVendLedgEntry: Record "Vendor Ledger Entry" temporary;
        GenJnlApply: Codeunit "Gen. Jnl.-Apply";
        PaymentToleranceMgtExt: Codeunit PaymentToleranceCUExtension;
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        PurchPost: Codeunit "Purch.-Post";
        VendEntrySetApplID: Codeunit "Vend. Entry-SetAppl.ID";
        Navigate: Page Navigate;
        ActionPerformed: Boolean;
        AppliesToIDVisible: Boolean;
        GenJnlLineApply: Boolean;
        HasDocumentAttachment: Boolean;
        IsOfficeAddin: Boolean;
        OK: Boolean;
        PaymentLineApply: Boolean;
        PostingDone: Boolean;
        ShowAppliedEntries: Boolean;
        ValidExchRate: Boolean;
        VendNameVisible: Boolean;
        AppliesToID: Code[50];
        VendEntryApplID: Code[50];
        ApplnDate: Date;
        AmountRoundingPrecision: Decimal;
        ApplnRounding: Decimal;
        ApplnRoundingPrecision: Decimal;
        VATAmount: Decimal;
        CannotSetAppliesToIDErr: Label 'You cannot set Applies-to ID while selecting Applies-to Doc. No.';
        EarlierPostingDateErr: Label 'You cannot apply and post an entry to an entry with an earlier posting date.\\Instead, post the document of type %1 with the number %2 and then apply it to the document of type %3 with the number %4.';
        Text002: Label 'You must select an applying entry before you can post the application.';
        Text003: Label 'You must post the application from the window where you entered the applying entry.';
        Text012: Label 'The application was successfully posted.';
        ApplnType: Option " ","Applies-to Doc. No.","Applies-to ID";
        CalcType: Option Direct,GenJnlLine,PurchHeader,Payments;
        StyleTxt: Text;
        VATAmountText: Text[30];

    protected var
        GenJnlLine2: Record "Gen. Journal Line";
        AppliedVendLedgEntry: Record "Vendor Ledger Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";
        DifferentCurrenciesInAppln: Boolean;
        ApplnCurrencyCode: Code[10];
        AppliedAmount: Decimal;
        ApplyingAmount: Decimal;
        PmtDiscAmount: Decimal;

    trigger OnInit()
    begin
        AppliesToIDVisible := true;
    end;

    trigger OnOpenPage()
    var
        OfficeMgt: Codeunit "Office Management";
    begin
        if CalcType = CalcType::Direct then begin
            Vend.Get(Rec."Vendor No.");
            ApplnCurrencyCode := Vend."Currency Code";
            FindApplyingEntry();
        end;

        PurchSetup.Get();
        VendNameVisible := PurchSetup."Copy Vendor Name to Entries";

        AppliesToIDVisible := ApplnType <> ApplnType::"Applies-to Doc. No.";

        GLSetup.Get();

        if CalcType = CalcType::GenJnlLine then
            CalcApplnAmount();
        PostingDone := false;
        IsOfficeAddin := OfficeMgt.IsAvailable();
    end;

    trigger OnAfterGetRecord()
    begin
        StyleTxt := Rec.SetStyle();
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Codeunit.Run(Codeunit::"Vend. Entry-Edit", Rec);
        if Rec."Applies-to ID" <> xRec."Applies-to ID" then
            CalcApplnAmount();
        exit(false);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        RaiseError: Boolean;
    begin
        if CloseAction = Action::LookupOK then
            LookupOKOnPush();
        if ApplnType = ApplnType::"Applies-to Doc. No." then begin
            if OK then begin
                RaiseError := ApplyingVendLedgEntry."Posting Date" < Rec."Posting Date";
                OnBeforeEarlierPostingDateError(ApplyingVendLedgEntry, Rec, RaiseError, CalcType, PmtDiscAmount);
                if RaiseError then begin
                    OK := false;
                    Error(
                      EarlierPostingDateErr, ApplyingVendLedgEntry."Document Type", ApplyingVendLedgEntry."Document No.",
                      Rec."Document Type", Rec."Document No.");
                end;
            end;
            if OK then begin
                if Rec."Amount to Apply" = 0 then
                    Rec."Amount to Apply" := Rec."Remaining Amount";
                Codeunit.Run(Codeunit::"Vend. Entry-Edit", Rec);
            end;
        end;

        if CheckActionPerformed() then begin
            Rec := ApplyingVendLedgEntry;
            Rec."Applying Entry" := false;
            if AppliesToID = '' then begin
                Rec."Applies-to ID" := '';
                Rec."Amount to Apply" := 0;
            end;
            Codeunit.Run(Codeunit::"Vend. Entry-Edit", Rec);
        end;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if ApplnType = ApplnType::"Applies-to Doc. No." then
            CalcApplnAmount();
        HasDocumentAttachment := Rec.HasPostedDocAttachment();
    end;

    procedure CalcApplnAmount()
    begin
        OnBeforeCalcApplnAmount(Rec, GenJnlLine);

        AppliedAmount := 0;
        PmtDiscAmount := 0;
        DifferentCurrenciesInAppln := false;

        case CalcType of
            CalcType::Direct:
                begin
                    FindAmountRounding();
                    VendEntryApplID := UserId;
                    if VendEntryApplID = '' then
                        VendEntryApplID := '***';

                    VendLedgEntry := ApplyingVendLedgEntry;

                    AppliedVendLedgEntry.SetCurrentKey("Vendor No.", Open, Positive);
                    AppliedVendLedgEntry.SetRange("Vendor No.", Rec."Vendor No.");
                    AppliedVendLedgEntry.SetRange(Open, true);
                    if AppliesToID = '' then
                        AppliedVendLedgEntry.SetRange("Applies-to ID", VendEntryApplID)
                    else
                        AppliedVendLedgEntry.SetRange("Applies-to ID", AppliesToID);

                    if ApplyingVendLedgEntry."Entry No." <> 0 then begin
                        VendLedgEntry.CalcFields("Remaining Amount");
                        AppliedVendLedgEntry.SetFilter("Entry No.", '<>%1', VendLedgEntry."Entry No.");
                    end;

                    HandleChosenEntries(0, VendLedgEntry."Remaining Amount", VendLedgEntry."Currency Code", VendLedgEntry."Posting Date");
                end;
            CalcType::GenJnlLine:
                begin
                    FindAmountRounding();
                    if GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Vendor then
                        Codeunit.Run(Codeunit::"Exchange Acc. G/L Journal Line", GenJnlLine);

                    case ApplnType of
                        ApplnType::"Applies-to Doc. No.":
                            begin
                                AppliedVendLedgEntry := Rec;
                                AppliedVendLedgEntry.CalcFields("Remaining Amount");
                                if AppliedVendLedgEntry."Currency Code" <> ApplnCurrencyCode then begin
                                    AppliedVendLedgEntry."Remaining Amount" :=
                                      CurrExchRate.ExchangeAmtFCYToFCY(
                                        ApplnDate, AppliedVendLedgEntry."Currency Code", ApplnCurrencyCode, AppliedVendLedgEntry."Remaining Amount");
                                    AppliedVendLedgEntry."Remaining Pmt. Disc. Possible" :=
                                      CurrExchRate.ExchangeAmtFCYToFCY(
                                        ApplnDate, AppliedVendLedgEntry."Currency Code", ApplnCurrencyCode, AppliedVendLedgEntry."Remaining Pmt. Disc. Possible");
                                    AppliedVendLedgEntry."Amount to Apply" :=
                                      CurrExchRate.ExchangeAmtFCYToFCY(
                                        ApplnDate, AppliedVendLedgEntry."Currency Code", ApplnCurrencyCode, AppliedVendLedgEntry."Amount to Apply");
                                end;

                                if AppliedVendLedgEntry."Amount to Apply" <> 0 then
                                    AppliedAmount := Round(AppliedVendLedgEntry."Amount to Apply", AmountRoundingPrecision)
                                else
                                    AppliedAmount := Round(AppliedVendLedgEntry."Remaining Amount", AmountRoundingPrecision);

                                if PaymentToleranceMgt.CheckCalcPmtDiscGenJnlVend(
                                     GenJnlLine, AppliedVendLedgEntry, 0, false) and
                                   ((Abs(GenJnlLine.Amount) + ApplnRoundingPrecision >=
                                     Abs(AppliedAmount - AppliedVendLedgEntry."Remaining Pmt. Disc. Possible")) or
                                    (GenJnlLine.Amount = 0))
                                then
                                    PmtDiscAmount := AppliedVendLedgEntry."Remaining Pmt. Disc. Possible";

                                if not DifferentCurrenciesInAppln then
                                    DifferentCurrenciesInAppln := ApplnCurrencyCode <> AppliedVendLedgEntry."Currency Code";
                                CheckRounding();
                            end;
                        ApplnType::"Applies-to ID":
                            begin
                                GenJnlLine2 := GenJnlLine;
                                AppliedVendLedgEntry.SetCurrentKey("Vendor No.", Open, Positive);
                                AppliedVendLedgEntry.SetRange("Vendor No.", GenJnlLine."Account No.");
                                AppliedVendLedgEntry.SetRange(Open, true);
                                AppliedVendLedgEntry.SetRange("Applies-to ID", GenJnlLine."Applies-to ID");

                                HandleChosenEntries(1, GenJnlLine2.Amount, GenJnlLine2."Currency Code", GenJnlLine2."Posting Date");
                            end;
                    end;
                end;
            CalcType::PurchHeader:
                begin
                    FindAmountRounding();

                    case ApplnType of
                        ApplnType::"Applies-to Doc. No.":
                            begin
                                AppliedVendLedgEntry := Rec;
                                AppliedVendLedgEntry.CalcFields("Remaining Amount");

                                if AppliedVendLedgEntry."Currency Code" <> ApplnCurrencyCode then
                                    AppliedVendLedgEntry."Remaining Amount" :=
                                      CurrExchRate.ExchangeAmtFCYToFCY(
                                        ApplnDate, AppliedVendLedgEntry."Currency Code", ApplnCurrencyCode, AppliedVendLedgEntry."Remaining Amount");

                                AppliedAmount := AppliedAmount + Round(AppliedVendLedgEntry."Remaining Amount", AmountRoundingPrecision);

                                if not DifferentCurrenciesInAppln then
                                    DifferentCurrenciesInAppln := ApplnCurrencyCode <> AppliedVendLedgEntry."Currency Code";
                                CheckRounding();
                            end;
                        ApplnType::"Applies-to ID":
                            begin
                                AppliedVendLedgEntry.SetCurrentKey("Vendor No.", Open, Positive);
                                AppliedVendLedgEntry.SetRange("Vendor No.", PurchHeader."Pay-to Vendor No.");
                                AppliedVendLedgEntry.SetRange(Open, true);
                                AppliedVendLedgEntry.SetRange("Applies-to ID", PurchHeader."Applies-to ID");

                                HandleChosenEntries(2, ApplyingAmount, ApplnCurrencyCode, ApplnDate);
                            end;
                    end;
                end;
            CalcType::Payments:
                begin
                    FindAmountRounding();
                    case ApplnType of
                        ApplnType::"Applies-to Doc. No.":
                            begin
                                AppliedVendLedgEntry := Rec;
                                AppliedVendLedgEntry.CalcFields("Remaining Amount");
                                if AppliedVendLedgEntry."Currency Code" <> ApplnCurrencyCode then begin
                                    AppliedVendLedgEntry."Remaining Amount" :=
                                      CurrExchRate.ExchangeAmtFCYToFCY(
                                        ApplnDate, AppliedVendLedgEntry."Currency Code", ApplnCurrencyCode, AppliedVendLedgEntry."Remaining Amount");
                                    AppliedVendLedgEntry."Remaining Pmt. Disc. Possible" :=
                                      CurrExchRate.ExchangeAmtFCYToFCY(
                                        ApplnDate, AppliedVendLedgEntry."Currency Code", ApplnCurrencyCode, AppliedVendLedgEntry."Remaining Pmt. Disc. Possible");
                                    AppliedVendLedgEntry."Amount to Apply" :=
                                      CurrExchRate.ExchangeAmtFCYToFCY(
                                        ApplnDate, AppliedVendLedgEntry."Currency Code", ApplnCurrencyCode, AppliedVendLedgEntry."Amount to Apply");
                                end;
                                if AppliedVendLedgEntry."Amount to Apply" <> 0 then
                                    AppliedAmount := Round(AppliedVendLedgEntry."Amount to Apply", AmountRoundingPrecision)
                                else
                                    AppliedAmount := Round(AppliedVendLedgEntry."Remaining Amount", AmountRoundingPrecision);
                                if PaymentToleranceMgtExt.CheckCalcPmtDiscPaymentsVend(
                                     PaymentLine, AppliedVendLedgEntry, 0, false) and
                                   ((Abs(PaymentLine.Amount) + ApplnRoundingPrecision >=
                                     Abs(AppliedAmount - AppliedVendLedgEntry."Remaining Pmt. Disc. Possible")) or
                                    (GenJnlLine.Amount = 0))
                                then
                                    PmtDiscAmount := AppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
                                if not DifferentCurrenciesInAppln then
                                    DifferentCurrenciesInAppln := ApplnCurrencyCode <> AppliedVendLedgEntry."Currency Code";
                                CheckRounding();
                            end;
                        ApplnType::"Applies-to ID":
                            begin
                                PaymentLine2 := PaymentLine;
                                AppliedVendLedgEntry.SetCurrentKey("Vendor No.", Open, Positive);
                                AppliedVendLedgEntry.SetRange("Vendor No.", PaymentLine."Account No");
                                AppliedVendLedgEntry.SetRange(Open, true);
                                AppliedVendLedgEntry.SetRange("Applies-to ID", PaymentLine."Applies-to ID");
                                PaymentRec.Get(PaymentLine.No);
                                HandleChosenEntries(3,
                                  PaymentLine2.Amount,
                                  PaymentRec.Currency,
                                  PaymentRec.Date);
                            end;
                    end;
                end;
        end;

        OnAfterCalcApplnAmount(Rec, AppliedAmount, ApplyingAmount);
    end;

    procedure CalcOppositeEntriesAmount(var TempAppliedVendorLedgerEntry: Record "Vendor Ledger Entry" temporary) Result: Decimal
    var
        SavedAppliedVendorLedgerEntry: Record "Vendor Ledger Entry";
        CurrPosFilter: Text;
    begin
        CurrPosFilter := TempAppliedVendorLedgerEntry.GetFilter(Positive);
        if CurrPosFilter <> '' then begin
            SavedAppliedVendorLedgerEntry := TempAppliedVendorLedgerEntry;
            TempAppliedVendorLedgerEntry.SetRange(Positive, not TempAppliedVendorLedgerEntry.Positive);
            if TempAppliedVendorLedgerEntry.FindSet() then
                repeat
                    TempAppliedVendorLedgerEntry.CalcFields("Remaining Amount");
                    Result += TempAppliedVendorLedgerEntry."Remaining Amount";
                until TempAppliedVendorLedgerEntry.Next() = 0;
            TempAppliedVendorLedgerEntry.SetFilter(Positive, CurrPosFilter);
            TempAppliedVendorLedgerEntry := SavedAppliedVendorLedgerEntry;
        end;
    end;

    procedure CheckRounding()
    begin
        ApplnRounding := 0;

        case CalcType of
            CalcType::PurchHeader:
                exit;
            CalcType::GenJnlLine:
                if (GenJnlLine."Document Type" <> GenJnlLine."Document Type"::Payment) and
                   (GenJnlLine."Document Type" <> GenJnlLine."Document Type"::Refund)
                then
                    exit;
        end;

        if ApplnCurrencyCode = '' then
            ApplnRoundingPrecision := GLSetup."Appln. Rounding Precision"
        else begin
            if ApplnCurrencyCode <> Rec."Currency Code" then
                Currency.Get(ApplnCurrencyCode);
            ApplnRoundingPrecision := Currency."Appln. Rounding Precision";
        end;

        if (Abs((AppliedAmount - PmtDiscAmount) + ApplyingAmount) <= ApplnRoundingPrecision) and DifferentCurrenciesInAppln then
            ApplnRounding := -((AppliedAmount - PmtDiscAmount) + ApplyingAmount);
    end;

    procedure ExchangeAmountsOnLedgerEntry(Type: Option Direct,GenJnlLine,PurchHeader; CurrencyCode: Code[10]; var CalcVendLedgEntry: Record "Vendor Ledger Entry"; PostingDate: Date)
    var
        CalculateCurrency: Boolean;
    begin
        CalcVendLedgEntry.CalcFields("Remaining Amount");

        if Type = Type::Direct then
            CalculateCurrency := ApplyingVendLedgEntry."Entry No." <> 0
        else
            CalculateCurrency := true;

        if (CurrencyCode <> CalcVendLedgEntry."Currency Code") and CalculateCurrency then begin
            CalcVendLedgEntry."Remaining Amount" :=
              CurrExchRate.ExchangeAmount(
                CalcVendLedgEntry."Remaining Amount", CalcVendLedgEntry."Currency Code", CurrencyCode, PostingDate);
            CalcVendLedgEntry."Remaining Pmt. Disc. Possible" :=
              CurrExchRate.ExchangeAmount(
                CalcVendLedgEntry."Remaining Pmt. Disc. Possible", CalcVendLedgEntry."Currency Code", CurrencyCode, PostingDate);
            CalcVendLedgEntry."Amount to Apply" :=
              CurrExchRate.ExchangeAmount(
                CalcVendLedgEntry."Amount to Apply", CalcVendLedgEntry."Currency Code", CurrencyCode, PostingDate);
        end;

        OnAfterExchangeAmountsOnLedgerEntry(CalcVendLedgEntry, VendLedgEntry, CurrencyCode);
    end;

    procedure GetApplnCurrencyCode(): Code[10]
    begin
        exit(ApplnCurrencyCode);
    end;

    procedure GetCalcType(): Integer
    begin
        exit(CalcType);
    end;

    procedure GetVendLedgEntry(var VendLedgEntry: Record "Vendor Ledger Entry")
    begin
        VendLedgEntry := Rec;
    end;

    procedure SetAppliesToID(AppliesToID2: Code[50])
    begin
        AppliesToID := AppliesToID2;
    end;

    procedure SetApplyingVendLedgEntry()
    var
        Vendor: Record Vendor;
    begin
        OnBeforeSetApplyingVendLedgEntry(ApplyingVendLedgEntry, GenJnlLine);

        case CalcType of
            CalcType::PurchHeader:
                begin
                    ApplyingVendLedgEntry."Posting Date" := PurchHeader."Posting Date";
                    if PurchHeader."Document Type" = PurchHeader."Document Type"::"Return Order" then
                        ApplyingVendLedgEntry."Document Type" := ApplyingVendLedgEntry."Document Type"::"Credit Memo"
                    else
                        ApplyingVendLedgEntry."Document Type" := ApplyingVendLedgEntry."Document Type"::Invoice;
                    ApplyingVendLedgEntry."Document No." := PurchHeader."No.";
                    ApplyingVendLedgEntry."Vendor No." := PurchHeader."Pay-to Vendor No.";
                    ApplyingVendLedgEntry.Description := PurchHeader."Posting Description";
                    ApplyingVendLedgEntry."Currency Code" := PurchHeader."Currency Code";
                    if ApplyingVendLedgEntry."Document Type" = ApplyingVendLedgEntry."Document Type"::"Credit Memo" then begin
                        ApplyingVendLedgEntry.Amount := TotalPurchLine."Amount Including VAT";
                        ApplyingVendLedgEntry."Remaining Amount" := TotalPurchLine."Amount Including VAT";
                    end else begin
                        ApplyingVendLedgEntry.Amount := -TotalPurchLine."Amount Including VAT";
                        ApplyingVendLedgEntry."Remaining Amount" := -TotalPurchLine."Amount Including VAT";
                    end;
                    CalcApplnAmount();
                end;
            CalcType::Direct:
                begin
                    if Rec."Applying Entry" then begin
                        if ApplyingVendLedgEntry."Entry No." <> 0 then
                            VendLedgEntry := ApplyingVendLedgEntry;
                        Codeunit.Run(Codeunit::"Vend. Entry-Edit", Rec);
                        if Rec."Applies-to ID" = '' then
                            SetVendApplId(false);
                        Rec.CalcFields(Amount);
                        ApplyingVendLedgEntry := Rec;
                        if VendLedgEntry."Entry No." <> 0 then begin
                            Rec := VendLedgEntry;
                            Rec."Applying Entry" := false;
                            SetVendApplId(false);
                        end;
                        Rec.SetFilter("Entry No.", '<> %1', ApplyingVendLedgEntry."Entry No.");
                        ApplyingAmount := ApplyingVendLedgEntry."Remaining Amount";
                        ApplnDate := ApplyingVendLedgEntry."Posting Date";
                        ApplnCurrencyCode := ApplyingVendLedgEntry."Currency Code";
                    end;
                    CalcApplnAmount();
                end;
            CalcType::GenJnlLine:
                begin
                    ApplyingVendLedgEntry."Posting Date" := GenJnlLine."Posting Date";
                    ApplyingVendLedgEntry."Document Type" := GenJnlLine."Document Type";
                    ApplyingVendLedgEntry."Document No." := GenJnlLine."Document No.";
                    if GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Vendor then begin
                        ApplyingVendLedgEntry."Vendor No." := GenJnlLine."Bal. Account No.";
                        Vendor.Get(ApplyingVendLedgEntry."Vendor No.");
                        ApplyingVendLedgEntry.Description := Vendor.Name;
                    end else begin
                        ApplyingVendLedgEntry."Vendor No." := GenJnlLine."Account No.";
                        ApplyingVendLedgEntry.Description := GenJnlLine.Description;
                    end;
                    ApplyingVendLedgEntry."Currency Code" := GenJnlLine."Currency Code";
                    ApplyingVendLedgEntry.Amount := GenJnlLine.Amount;
                    ApplyingVendLedgEntry."Remaining Amount" := GenJnlLine.Amount;
                    CalcApplnAmount();
                end;
            CalcType::Payments:
                begin
                    PaymentRec.Get(PaymentLine.No);
                    ApplyingVendLedgEntry."Posting Date" := PaymentRec.Date;
                    ApplyingVendLedgEntry."Document Type" := PaymentLine."Applies-to Doc Type";
                    ApplyingVendLedgEntry."Document No." := PaymentLine.No;
                    ApplyingVendLedgEntry."Vendor No." := PaymentLine."Account No";
                    ApplyingVendLedgEntry.Description := PaymentLine.Description;
                    ApplyingVendLedgEntry."Currency Code" := PaymentRec.Currency;
                    ApplyingVendLedgEntry.Amount := PaymentLine.Amount;
                    ApplyingVendLedgEntry."Remaining Amount" := PaymentLine.Amount;
                    CalcApplnAmount();
                end;
        end;
    end;

    procedure SetGenJnlLine(NewGenJnlLine: Record "Gen. Journal Line"; ApplnTypeSelect: Integer)
    begin
        GenJnlLine := NewGenJnlLine;
        GenJnlLineApply := true;

        if GenJnlLine."Account Type" = GenJnlLine."Account Type"::Vendor then
            ApplyingAmount := GenJnlLine.Amount;
        if GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Vendor then
            ApplyingAmount := -GenJnlLine.Amount;
        ApplnDate := GenJnlLine."Posting Date";
        ApplnCurrencyCode := GenJnlLine."Currency Code";
        CalcType := CalcType::GenJnlLine;

        case ApplnTypeSelect of
            GenJnlLine.FieldNo("Applies-to Doc. No."):
                ApplnType := ApplnType::"Applies-to Doc. No.";
            GenJnlLine.FieldNo("Applies-to ID"):
                ApplnType := ApplnType::"Applies-to ID";
        end;

        SetApplyingVendLedgEntry();
    end;

    procedure SetPaymentLine(NewPaymentLine: Record "Payment Lines"; ApplnTypeSelect: Integer)
    begin
        PaymentLine := NewPaymentLine;
        PaymentLineApply := true;
        PaymentRec.Get(PaymentLine.No);
        if PaymentLine."Account Type" = PaymentLine."Account Type"::Vendor then
            ApplyingAmount := PaymentLine.Amount;
        ApplnDate := PaymentRec.Date;
        ApplnCurrencyCode := PaymentRec.Currency;
        CalcType := CalcType::Payments;
        case ApplnTypeSelect of
            PaymentLine.FieldNo("Applies-to Doc. No."):
                ApplnType := ApplnType::"Applies-to Doc. No.";
            PaymentLine.FieldNo("Applies-to ID"):
                ApplnType := ApplnType::"Applies-to ID";
        end;
        SetApplyingVendLedgEntry();
    end;

    procedure SetPurch(NewPurchHeader: Record "Purchase Header"; var NewVendLedgEntry: Record "Vendor Ledger Entry"; ApplnTypeSelect: Integer)
    begin
        PurchHeader := NewPurchHeader;
        Rec.CopyFilters(NewVendLedgEntry);

        PurchPost.SumPurchLines(
          PurchHeader, 0, TotalPurchLine, TotalPurchLineLCY,
          VATAmount, VATAmountText);

        case PurchHeader."Document Type" of
            PurchHeader."Document Type"::"Return Order",
          PurchHeader."Document Type"::"Credit Memo":
                ApplyingAmount := TotalPurchLine."Amount Including VAT"
            else
                ApplyingAmount := -TotalPurchLine."Amount Including VAT";
        end;

        ApplnDate := PurchHeader."Posting Date";
        ApplnCurrencyCode := PurchHeader."Currency Code";
        CalcType := CalcType::PurchHeader;

        case ApplnTypeSelect of
            PurchHeader.FieldNo("Applies-to Doc. No."):
                ApplnType := ApplnType::"Applies-to Doc. No.";
            PurchHeader.FieldNo("Applies-to ID"):
                ApplnType := ApplnType::"Applies-to ID";
        end;

        SetApplyingVendLedgEntry();
    end;

    procedure SetVendApplId(CurrentRec: Boolean)
    var
        RaiseError: Boolean;
    begin
        if CalcType = CalcType::GenJnlLine then begin
            RaiseError := ApplyingVendLedgEntry."Posting Date" < Rec."Posting Date";
            OnBeforeEarlierPostingDateError(ApplyingVendLedgEntry, Rec, RaiseError, CalcType, PmtDiscAmount);
            if RaiseError then
                Error(
                  EarlierPostingDateErr, ApplyingVendLedgEntry."Document Type", ApplyingVendLedgEntry."Document No.",
                  Rec."Document Type", Rec."Document No.");
        end;

        if CalcType = CalcType::Payments then
            PaymentRec.Get(PaymentLine.No);
        if (CalcType = CalcType::Payments) and (ApplyingVendLedgEntry."Posting Date" < PaymentRec.Date) then
            Error(
              EarlierPostingDateErr, ApplyingVendLedgEntry."Document Type", ApplyingVendLedgEntry."Document No.",
              PaymentLine."Applies-to Doc Type", PaymentLine.No);

        if ApplyingVendLedgEntry."Entry No." <> 0 then
            GenJnlApply.CheckAgainstApplnCurrency(
              ApplnCurrencyCode, Rec."Currency Code", GenJnlLine."Account Type"::Vendor, true);

        VendLedgEntry.Copy(Rec);
        if CurrentRec then
            VendLedgEntry.SetRecFilter()
        else
            CurrPage.SetSelectionFilter(VendLedgEntry);
        if GenJnlLineApply then
            VendEntrySetApplID.SetApplId(VendLedgEntry, ApplyingVendLedgEntry, GenJnlLine."Applies-to ID")
        else
            if PaymentLineApply then
                VendEntrySetApplID.SetApplId(VendLedgEntry, ApplyingVendLedgEntry, PaymentLine."Applies-to ID")
            else
                VendEntrySetApplID.SetApplId(VendLedgEntry, ApplyingVendLedgEntry, PurchHeader."Applies-to ID");

        ActionPerformed := VendLedgEntry."Applies-to ID" <> '';
        CalcApplnAmount();
    end;

    procedure SetVendLedgEntry(NewVendLedgEntry: Record "Vendor Ledger Entry")
    begin
        Rec := NewVendLedgEntry;
    end;

    local procedure AmountToApplyOnAfterValidate()
    begin
        if ApplnType <> ApplnType::"Applies-to Doc. No." then begin
            CalcApplnAmount();
            CurrPage.Update(false);
        end;
    end;

    local procedure CalcApplnAmountToApply(AmountToApply: Decimal): Decimal
    var
        ApplnAmountToApply: Decimal;
    begin
        ValidExchRate := true;

        if ApplnCurrencyCode = Rec."Currency Code" then
            exit(AmountToApply);

        if ApplnDate = 0D then
            ApplnDate := Rec."Posting Date";
        ApplnAmountToApply :=
          CurrExchRate.ApplnExchangeAmtFCYToFCY(
            ApplnDate, Rec."Currency Code", ApplnCurrencyCode, AmountToApply, ValidExchRate);

        OnAfterCalcApplnAmountToApply(Rec, AmountToApply, ApplnAmountToApply);
        exit(ApplnAmountToApply);
    end;

    local procedure CalcApplnRemainingAmount(Amount: Decimal): Decimal
    var
        ApplnRemainingAmount: Decimal;
    begin
        ValidExchRate := true;
        if ApplnCurrencyCode = Rec."Currency Code" then
            exit(Amount);

        if ApplnDate = 0D then
            ApplnDate := Rec."Posting Date";
        ApplnRemainingAmount :=
          CurrExchRate.ApplnExchangeAmtFCYToFCY(
            ApplnDate, Rec."Currency Code", ApplnCurrencyCode, Amount, ValidExchRate);

        OnAfterCalcApplnRemainingAmount(Rec, ApplnRemainingAmount);
        exit(ApplnRemainingAmount);
    end;

    local procedure CheckActionPerformed() Result: Boolean
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeCheckActionPerformed(ActionPerformed, OK, CalcType, PostingDone, ApplyingVendLedgEntry, ApplnType, Result, IsHandled);
        if IsHandled then
            exit(Result);

        if ActionPerformed then
            exit(false);
        if (not (CalcType = CalcType::Direct) and not OK and not PostingDone) or
           (ApplnType = ApplnType::"Applies-to Doc. No.")
        then
            exit(false);
        exit((CalcType = CalcType::Direct) and not OK and not PostingDone);
    end;

    local procedure FindAmountRounding()
    begin
        if ApplnCurrencyCode = '' then begin
            Currency.Init();
            Currency.Code := '';
            Currency.InitRoundingPrecision();
        end else
            if ApplnCurrencyCode <> Currency.Code then
                Currency.Get(ApplnCurrencyCode);

        AmountRoundingPrecision := Currency."Amount Rounding Precision";
    end;

    local procedure FindApplyingEntry()
    begin
        if CalcType = CalcType::Direct then begin
            VendEntryApplID := UserId;
            if VendEntryApplID = '' then
                VendEntryApplID := '***';

            VendLedgEntry.SetCurrentKey("Vendor No.", "Applies-to ID", Open);
            VendLedgEntry.SetRange("Vendor No.", Rec."Vendor No.");
            if AppliesToID = '' then
                VendLedgEntry.SetRange("Applies-to ID", VendEntryApplID)
            else
                VendLedgEntry.SetRange("Applies-to ID", AppliesToID);
            VendLedgEntry.SetRange(Open, true);
            VendLedgEntry.SetRange("Applying Entry", true);
            if VendLedgEntry.FindFirst() then begin
                VendLedgEntry.CalcFields(Amount, "Remaining Amount");
                ApplyingVendLedgEntry := VendLedgEntry;
                Rec.SetFilter("Entry No.", '<>%1', VendLedgEntry."Entry No.");
                ApplyingAmount := VendLedgEntry."Remaining Amount";
                ApplnDate := VendLedgEntry."Posting Date";
                ApplnCurrencyCode := VendLedgEntry."Currency Code";
            end;
            CalcApplnAmount();
        end;
    end;

    local procedure HandleChosenEntries(Type: Option Direct,GenJnlLine,PurchHeader; CurrentAmount: Decimal; CurrencyCode: Code[10]; PostingDate: Date)
    var
        TempAppliedVendLedgEntry: Record "Vendor Ledger Entry" temporary;
        CanUseDisc: Boolean;
        FromZeroGenJnl: Boolean;
        IsHandled: Boolean;
        CorrectionAmount: Decimal;
        OldPmtdisc: Decimal;
        PossiblePmtdisc: Decimal;
        RemainingAmountExclDiscounts: Decimal;
    begin
        IsHandled := false;
        OnBeforeHandledChosenEntries(Type, CurrentAmount, CurrencyCode, PostingDate, AppliedVendLedgEntry, IsHandled);
        if IsHandled then
            exit;

        if not AppliedVendLedgEntry.FindSet() then
            exit;

        repeat
            TempAppliedVendLedgEntry := AppliedVendLedgEntry;
            TempAppliedVendLedgEntry.Insert();
        until AppliedVendLedgEntry.Next() = 0;

        FromZeroGenJnl := (CurrentAmount = 0) and (Type = Type::GenJnlLine);

        repeat
            if not FromZeroGenJnl then
                TempAppliedVendLedgEntry.SetRange(Positive, CurrentAmount < 0);
            if TempAppliedVendLedgEntry.FindFirst() then begin
                ExchangeAmountsOnLedgerEntry(Type, CurrencyCode, TempAppliedVendLedgEntry, PostingDate);

                case Type of
                    Type::Direct:
                        CanUseDisc := PaymentToleranceMgt.CheckCalcPmtDiscVend(VendLedgEntry, TempAppliedVendLedgEntry, 0, false, false);
                    Type::GenJnlLine:
                        CanUseDisc := PaymentToleranceMgt.CheckCalcPmtDiscGenJnlVend(GenJnlLine2, TempAppliedVendLedgEntry, 0, false)
                    else
                        CanUseDisc := false;
                end;

                if CanUseDisc and
                   (Abs(TempAppliedVendLedgEntry."Amount to Apply") >=
                    Abs(TempAppliedVendLedgEntry."Remaining Amount" - TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible"))
                then
                    if Abs(CurrentAmount) >
                       Abs(TempAppliedVendLedgEntry."Remaining Amount" - TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible")
                    then begin
                        PmtDiscAmount += TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
                        CurrentAmount += TempAppliedVendLedgEntry."Remaining Amount" - TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
                    end else
                        if Abs(CurrentAmount) =
                           Abs(TempAppliedVendLedgEntry."Remaining Amount" - TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible")
                        then begin
                            PmtDiscAmount += TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
                            CurrentAmount +=
                              TempAppliedVendLedgEntry."Remaining Amount" - TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
                            AppliedAmount += CorrectionAmount;
                        end else
                            if FromZeroGenJnl then begin
                                PmtDiscAmount += TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
                                CurrentAmount +=
                                  TempAppliedVendLedgEntry."Remaining Amount" - TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
                            end else begin
                                PossiblePmtdisc := TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
                                RemainingAmountExclDiscounts :=
                                  TempAppliedVendLedgEntry."Remaining Amount" - PossiblePmtdisc - TempAppliedVendLedgEntry."Max. Payment Tolerance";
                                if Abs(CurrentAmount) + Abs(CalcOppositeEntriesAmount(TempAppliedVendLedgEntry)) >=
                                   Abs(RemainingAmountExclDiscounts)
                                then begin
                                    PmtDiscAmount += PossiblePmtdisc;
                                    AppliedAmount += CorrectionAmount;
                                end;
                                CurrentAmount +=
                                  TempAppliedVendLedgEntry."Remaining Amount" - TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
                            end
                else begin
                    if ((CurrentAmount + TempAppliedVendLedgEntry."Amount to Apply") * CurrentAmount) >= 0 then
                        AppliedAmount += CorrectionAmount;
                    CurrentAmount += TempAppliedVendLedgEntry."Amount to Apply";
                end;
            end else begin
                TempAppliedVendLedgEntry.SetRange(Positive);
                TempAppliedVendLedgEntry.FindFirst();
                ExchangeAmountsOnLedgerEntry(Type, CurrencyCode, TempAppliedVendLedgEntry, PostingDate);
            end;

            if OldPmtdisc <> PmtDiscAmount then
                AppliedAmount += TempAppliedVendLedgEntry."Remaining Amount"
            else
                AppliedAmount += TempAppliedVendLedgEntry."Amount to Apply";
            OldPmtdisc := PmtDiscAmount;

            if PossiblePmtdisc <> 0 then
                CorrectionAmount := TempAppliedVendLedgEntry."Remaining Amount" - TempAppliedVendLedgEntry."Amount to Apply"
            else
                CorrectionAmount := 0;

            if not DifferentCurrenciesInAppln then
                DifferentCurrenciesInAppln := ApplnCurrencyCode <> TempAppliedVendLedgEntry."Currency Code";

            TempAppliedVendLedgEntry.Delete();
            TempAppliedVendLedgEntry.SetRange(Positive);
        until not TempAppliedVendLedgEntry.FindFirst();
        CheckRounding();
    end;

    local procedure LookupOKOnPush()
    begin
        OK := true;
    end;

    local procedure PostDirectApplication(PreviewMode: Boolean)
    var
        VendEntryApplyPostedEntries: Codeunit "VendEntry-Apply Posted Entries";
        Applied: Boolean;
        ApplicationDate: Date;
    begin
        if CalcType = CalcType::Direct then begin
            if ApplyingVendLedgEntry."Entry No." <> 0 then begin
                Rec := ApplyingVendLedgEntry;
                ApplicationDate := VendEntryApplyPostedEntries.GetApplicationDate(Rec);

                OnPostDirectApplicationBeforeSetValues(ApplicationDate);
                /* PostApplication.SetValues(Rec."Document No.", ApplicationDate);
                if ACTION::OK = PostApplication.RunModal() then begin
                    PostApplication.GetValues(NewDocumentNo, NewApplicationDate);
                    if NewApplicationDate < ApplicationDate then
                        Error(Text013, Rec.FieldCaption("Posting Date"), Rec.TableCaption);
                end else
                    Error(Text019); */

                /*OnPostDirectApplicationBeforeApply();
                if PreviewMode then
                    VendEntryApplyPostedEntries.PreviewApply(Rec, NewDocumentNo, NewApplicationDate)
                else
                    Applied := VendEntryApplyPostedEntries.Apply(Rec, NewDocumentNo, NewApplicationDate); */

                if (not PreviewMode) and Applied then begin
                    Message(Text012);
                    PostingDone := true;
                    CurrPage.Close();
                end;
            end else
                Error(Text002);
        end else
            Error(Text003);
    end;

    local procedure RecalcApplnAmount()
    begin
        CurrPage.Update(true);
        CalcApplnAmount();
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCalcApplnAmount(VendorLedgerEntry: Record "Vendor Ledger Entry"; var AppliedAmount: Decimal; var ApplyingAmount: Decimal)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCalcApplnAmountToApply(VendorLedgerEntry: Record "Vendor Ledger Entry"; var ApplnAmountToApply: Decimal; var ApplnAmtToApply: Decimal)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCalcApplnRemainingAmount(VendorLedgerEntry: Record "Vendor Ledger Entry"; var ApplnRemainingAmount: Decimal)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterExchangeAmountsOnLedgerEntry(var CalcVendorLedgerEntry: Record "Vendor Ledger Entry"; VendorLedgerEntry: Record "Vendor Ledger Entry"; CurrencyCode: Code[10])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCalcApplnAmount(var VendorLedgerEntry: Record "Vendor Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCheckActionPerformed(ActionPerformed: Boolean; OK: Boolean; CalcType: Option Direct,GenJnlLine,PurchHeader; PostingDone: Boolean; ApplyingVendLedgEntry: Record "Vendor Ledger Entry" temporary; ApplnType: Option " ","Applies-to Doc. No.","Applies-to ID"; var Result: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeEarlierPostingDateError(ApplyingVendLedgEntry: Record "Vendor Ledger Entry"; VendorLedgerEntry: Record "Vendor Ledger Entry"; var RaiseError: Boolean; CalcType: Option; PmtDiscAmount: Decimal)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeHandledChosenEntries(Type: Option Direct,GenJnlLine,PurchHeader; CurrentAmount: Decimal; CurrencyCode: Code[10]; PostingDate: Date; var AppliedVendLedgEntry: Record "Vendor Ledger Entry"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeSetApplyingVendLedgEntry(var ApplyingVendLedgEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPostDirectApplicationBeforeApply()
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPostDirectApplicationBeforeSetValues(var ApplicationDate: Date)
    begin
    end;
}
