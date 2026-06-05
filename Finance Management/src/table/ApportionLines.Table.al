table 51015 "Apportion Lines"
{
    Caption = 'Apportion Lines';
    DataClassification = CustomerContent;
    fields
    {
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            ClosingDates = true;
        }
        field(5; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(7; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(8; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
            TableRelation = "G/L Account"."No.";
        }
        field(9; "G/L Entry No."; Integer)
        {
            Caption = 'G/L Entry No.';
            TableRelation = "G/L Entry"."Entry No." where("G/L Account No." = field("G/L Account No."),
                                                           Amount = filter(> 0),
                                                           Apportioned = filter(false));

            trigger OnValidate()
            begin
                GetHeader();
                if GLEntry.Get("G/L Entry No.") then
                    TransferFields(GLEntry);
            end;
        }
        field(10; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = if ("Bal. Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Bal. Account Type" = const(Customer)) Customer
            else
            if ("Bal. Account Type" = const(Vendor)) Vendor
            else
            if ("Bal. Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Bal. Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Bal. Account Type" = const("IC Partner")) "IC Partner"
            else
            if ("Bal. Account Type" = const(Employee)) Employee;
        }
        field(17; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(23; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));
        }
        field(24; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = const(false));
        }
        field(27; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //UserMgt.LookupUserID("User ID");
            end;
        }
        field(51; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        }
        field(53; "Debit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Debit Amount';
        }
        field(54; "Credit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Credit Amount';
        }
        field(55; "Document Date"; Date)
        {
            Caption = 'Document Date';
            ClosingDates = true;
        }
        field(56; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
        }
        field(57; "Source Type"; Option)
        {
            Caption = 'Source Type';
            OptionCaption = ' ,Customer,Vendor,Bank Account,Fixed Asset,Employee';
            OptionMembers = " ",Customer,Vendor,"Bank Account","Fixed Asset",Employee;
        }
        field(58; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            TableRelation = if ("Source Type" = const(Customer)) Customer
            else
            if ("Source Type" = const(Vendor)) Vendor
            else
            if ("Source Type" = const("Bank Account")) "Bank Account"
            else
            if ("Source Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Source Type" = const(Employee)) Employee;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                //ShowDimensions;
            end;
        }
        field(50031; "Investment Code"; Code[50])
        {
            //TableRelation = "Investment Register";
            Caption = 'Investment Code';
        }
        field(50032; "No. Of Units"; Decimal)
        {
            Caption = 'No. Of Units';

            trigger OnValidate()
            begin
                /* if "Receipt Payment Type"="Receipt Payment Type"::"Unit Trust" then begin
                 if Brokers.Get("Unit Trust Member No") then begin

                 Brokers.CalcFields("No.Of Units","Acquisition Cost","Current Value",Revaluations);
                 if "No. Of Units">Brokers."No.Of Units" then
                  Error('You cannot redeem more units than you have!!');

                   if  Brokers."No.Of Units" >0 then
                // "Current unit price":=Brokers."Current Value"/Brokers."No.Of Units" ;
                 //"Price Per Share":="Current unit price";
                Validate("Price Per Share");
                Validate(Amount);
                  end;

                 end else begin
                  if "No. Of Units"<0 then
                  Error('You Cannot Sale Negative No. of Shares!!');

                   Validate(Amount);
                 end;*/
            end;
        }
        field(50033; "Investment Transaction Type"; Option)
        {
            Caption = 'Investment Transaction Type';
            OptionCaption = ',Acquisition,Disposal,Interest,Dividend,Bonus,Revaluation,Share-split,Premium,Discounts,Gain(Loss) on Disposal,Interest Receivable,Dividend Receivable,Right Issue';
            OptionMembers = ,Acquisition,Disposal,Interest,Dividend,Bonus,Revaluation,"Share-split",Premium,Discounts,"Gain(Loss) on Disposal","Interest Receivable","Dividend Receivable","Right Issue";
        }
        field(60030; "Nominal Value"; Decimal)
        {
            Caption = 'Nominal Value';
        }
        field(60031; "Payment Ref"; Code[20])
        {
            Caption = 'Payment Ref';
        }
        field(60050; "Document Filter"; Text[250])
        {
            Caption = 'Document Filter';

            trigger OnLookup()
            begin
                LookupDocuments();
            end;
        }
        field(60051; Posted; Boolean)
        {
            Caption = 'Posted';
        }
        field(51519585; "Property Code"; Code[30])
        {
            Caption = 'Property Code';
        }
        field(51519586; "Transaction Code"; Code[30])
        {
            Caption = 'Transaction Code';
        }
        field(51519590; "Entry Type[Income/expense]"; Option)
        {
            Caption = 'Entry Type[Income/expense]';
            OptionCaption = ' ,Income,Expense';
            OptionMembers = " ",Income,Expense;
        }
        field(51519591; "Lease No"; Code[20])
        {
            Caption = 'Lease No';
        }
        field(51519613; Rent; Boolean)
        {
            Caption = 'Rent';
        }
        field(51519614; "Property Expense"; Boolean)
        {
            Caption = 'Property Expense';
        }
        field(51519615; "Property Floor"; Code[20])
        {
            Caption = 'Property Floor';
        }
        field(51519616; "Property Unit Code"; Code[20])
        {
            Caption = 'Property Unit Code';
        }
        field(51519617; "Charge code"; Code[40])
        {
            Caption = 'Charge code';
        }
        field(51519702; "Property Transaction Type"; Option)
        {
            Caption = 'FA Posting Type';
            OptionCaption = 'Acquisition Cost,Revaluation,Revenue,Maintenance,Tenant Purchase,Interest,Repayments,Accrued Income,Interest Paid';
            OptionMembers = "Acquisition Cost",Revaluation,Revenue,Maintenance,"Tenant Purchase",Interest,Repayment,"Accrued Income","Interest Paid";
        }
        field(51519703; "Loan No."; Code[20])
        {
            Caption = 'Loan No.';
        }
        field(51519704; "Property Receipt Type"; Option)
        {
            Caption = 'Property Transaction Type';
            OptionCaption = ' ,Rent Receipt,Property Expense,TPS Repayment,TPS Deposit';
            OptionMembers = " ","Rent Receipt","Property Expense","TPS Repayment","TPS Deposit";
        }
        field(51519705; "Period Reference"; Date)
        {
            Caption = 'Period Reference';
            TableRelation = "Accounting Period"."Starting Date";

            trigger OnValidate()
            begin
            end;
        }
    }

    keys
    {
        key(Key1; "No.", "G/L Account No.", "G/L Entry No.")
        {
            Clustered = true;
        }
    }

    var
        ApportionHeader: Record "Apportion Header";
        GLEntry: Record "G/L Entry";

    procedure LookupDocuments()
    var
        GLEntryRec: Record "G/L Entry";
        GLEntryCopy: Record "G/L Entry";
        GLEntries: Page "Apportion G/L Entries";
    begin
        TestField("G/L Account No.");
        GLEntryRec.SetRange(GLEntryRec."G/L Account No.", "G/L Account No.");
        GLEntryRec.SetRange(GLEntryRec.Apportioned, false);
        GLEntryRec.SetFilter(GLEntryRec.Amount, '>%1', 0);
        GLEntries.SetTableView(GLEntryRec);
        GLEntries.LookupMode(true);
        if GLEntries.RunModal() = Action::LookupOK then
            GLEntryCopy.Copy(GLEntryRec);
        //GLFilters:=GLEntries.GetSelectionFilter;
    end;

    local procedure GetHeader()
    begin
        if ApportionHeader.Get("No.") then;
    end;
}
