table 51005 "Payment Lines"
{
    Caption = 'Payment Lines';
    DataClassification = CustomerContent;
    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
        }
        field(3; Date; Date)
        {
            Caption = 'Date';
        }
        field(4; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
        }
        field(5; "Account No"; Code[20])
        {
            Caption = 'Account No';
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account" where(Blocked = const(false))
            else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset" where(Blocked = const(false))
            else
            if ("Account Type" = const(Customer)) Customer where(Blocked = const(" "))
            else
            if ("Account Type" = const("Bank Account")) "Bank Account" where(Blocked = const(false))
            else
            if ("Account Type" = const(Vendor)) Vendor where(Blocked = const(" "));

            trigger OnValidate()
            begin
                if "Payment Type" <> "Payment Type"::"Bank Transfer" then
                    if "Expenditure Type" = '' then
                        Error('Kindly select an appropriate %1 type', "Payment Type");

                GetPaymentHeader();
                case "Account Type" of
                    "Account Type"::"G/L Account":

                        if GLAccount.Get("Account No") then begin
                            GLAccount.TestField("Direct Posting", true);
                            "Account Name" := GLAccount.Name;
                            Description := GLAccount.Name;
                            "Gen. Posting Type" := GLAccount."Gen. Posting Type";
                        end;
                    "Account Type"::Vendor:

                        if Vendor.Get("Account No") then begin
                            "Account Name" := Vendor.Name;
                            "Our Account No." := Vendor."Our Account No.";
                            "Sort Code" := Vendor."Sort Code";
                            //Get payee
                            PaymentRec.Reset();
                            PaymentRec.SetRange(PaymentRec."No.", No);
                            if PaymentRec.FindFirst() then begin
                                PaymentRec.Payee := "Account Name";
                                PaymentRec."On behalf of" := "Account Name";
                                PaymentRec.Modify();
                            end;
                        end;
                    "Account Type"::Customer:
                        begin
                            Customer.Get("Account No");
                            "Account Name" := Customer.Name;
                        end;
                    "Account Type"::"Bank Account":
                        begin
                            Bank.Get("Account No");
                            "Account Name" := Bank.Name;
                            Validate(Currency, Bank."Currency Code");
                            if "Account No" = PaymentRec."Source Bank" then
                                Error('Receiving bank cannot be same as Source Bank');
                        end;
                    "Account Type"::"Fixed Asset":
                        begin
                            FixedAsset.Get("Account No");
                            "Account Name" := FixedAsset.Description;
                        end;
                end;

                PaymentRec.Reset();
                PaymentRec.SetRange(PaymentRec."No.", No);
                if PaymentRec.FindFirst() then begin
                    "Shortcut Dimension 1 Code" := PaymentRec."Shortcut Dimension 1 Code";
                    Validate("Shortcut Dimension 1 Code");
                    "Shortcut Dimension 2 Code" := PaymentRec."Shortcut Dimension 2 Code";
                    Validate("Shortcut Dimension 2 Code");
                end;

                Validate(Amount);
            end;
        }
        field(6; "Account Name"; Text[100])
        {
            Caption = 'Account Name';
        }
        field(7; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(8; Amount; Decimal)
        {
            Caption = 'Amount';
            Editable = true;

            trigger OnValidate()
            var
                PHeader: Record Payments;
                CurrencyValidationDate: Date;
            begin
                if "Expenditure Type" <> '' then
                    if RecTypes.Get("Expenditure Type", "Payment Type") then
                        if "VAT Code" <> '' then
                            RecTypes.TestField("VAT Bus. Posting Group");

                VATAmount := 0;
                "W/Tax Amount" := 0;
                WTVATAmount := 0;

                "VAT Amount" := 0;
                "W/Tax Amount" := 0;
                "Retention Amount" := 0;
                "W/T VAT Amount" := 0;

                CSetup.Get();
                CSetup.TestField("Rounding Precision");
                case CSetup."Rounding Type" of
                    CSetup."Rounding Type"::Up:
                        Direction := '>';
                    CSetup."Rounding Type"::Nearest:
                        Direction := '=';
                    CSetup."Rounding Type"::Down:
                        Direction := '<';
                end;

                case "Account Type" of
                    "Account Type"::"G/L Account":

                        if "VAT Code" <> '' then begin
                            if GLAccount.Get("Account No") then;
                            //GLAccount.TestField("VAT Bus. Posting Group");
                            if VATSetup.Get(RecTypes."VAT Bus. Posting Group", "VAT Code") then
                                if VATSetup."VAT %" <> 0 then begin
                                    if "VAT Exclusive" = false then
                                        VATAmount := Round(((Amount) / (1 + VATSetup."VAT %" / 100) * VATSetup."VAT %" / 100),
                                                         CSetup."Rounding Precision", Direction)
                                    else
                                        VATAmount := Round(((Amount) * (VATSetup."VAT %" / 100)),
                                                        CSetup."Rounding Precision", Direction);

                                    NetAmount := (Amount) - VATAmount;
                                    "VAT Amount" := VATAmount;
                                    if CSetup."Post VAT" then//Check IF VAT is to be posted
                                        "Net Amount" := Amount - VATAmount
                                    else
                                        "Net Amount" := Amount;
                                    if "W/Tax Code" <> '' then
                                        if GLAccount.Get("Account No") then
                                            if VATSetup.Get(RecTypes."VAT Bus. Posting Group", "W/Tax Code") then begin
                                                "W/TAmount" := Round(NetAmount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                                "W/Tax Amount" := "W/TAmount";
                                                NetAmount := NetAmount - "W/TAmount";
                                                if CSetup."Post VAT" then//Check IF VAT is to be posted
                                                    "Net Amount" := NetAmount
                                                else
                                                    "Net Amount" := Amount - "W/TAmount";
                                            end;

                                    if "W/T VAT Code" <> '' then begin//Compute W/T VAT
                                        if GLAccount.Get("Account No") then;
                                        if VATSetup.Get(RecTypes."VAT Bus. Posting Group", "W/T VAT Code") then begin
                                            if VATSetup2.Get(RecTypes."VAT Bus. Posting Group", "VAT Code") then;
                                            WTVATAmount := Round((VATAmount * VATSetup."VAT %" / 100 / (VATSetup2."VAT %" / 100)),
                                            CSetup."Rounding Precision", Direction);
                                            "W/T VAT Amount" := WTVATAmount;
                                            NetAmount := NetAmount - WTVATAmount;
                                            "Net Amount" := "Net Amount" - WTVATAmount;
                                        end;
                                    end;

                                end else begin
                                    "Net Amount" := Amount;
                                    NetAmount := Amount;
                                    if "W/Tax Code" <> '' then
                                        if GLAccount.Get("Account No") then
                                            if VATSetup.Get(RecTypes."VAT Bus. Posting Group", "W/Tax Code") then begin
                                                "W/TAmount" := Round(NetAmount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                                "W/Tax Amount" := "W/TAmount";
                                                NetAmount := NetAmount - "W/TAmount";
                                                "Net Amount" := Amount - "W/TAmount";
                                            end;
                                end;
                        end
                        else begin
                            "Net Amount" := Amount;
                            NetAmount := Amount;
                            if "W/Tax Code" <> '' then
                                if GLAccount.Get("Account No") then
                                    if VATSetup.Get(RecTypes."VAT Bus. Posting Group", "W/Tax Code") then begin
                                        "W/TAmount" := Round(NetAmount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                        "W/Tax Amount" := "W/TAmount";
                                        NetAmount := NetAmount - "W/TAmount";
                                        "Net Amount" := Amount - "W/TAmount";
                                    end;
                        end;
                    "Account Type"::Customer:

                        if "VAT Code" <> '' then begin
                            if Customer.Get("Account No") then;
                            //Customer.TestField("VAT Bus. Posting Group");
                            if VATSetup.Get(RecTypes."VAT Bus. Posting Group", "VAT Code") then begin
                                VATAmount := Round(((Amount) / (1 + VATSetup."VAT %" / 100) * VATSetup."VAT %" / 100),
                                           CSetup."Rounding Precision", Direction);
                                if VATSetup."VAT %" <> 0 then begin
                                    NetAmount := (Amount) - VATAmount;
                                    "VAT Amount" := VATAmount;
                                    if CSetup."Post VAT" then//Check IF VAT is to be posted
                                        "Net Amount" := Amount - VATAmount
                                    else
                                        "Net Amount" := Amount;
                                    if "W/Tax Code" <> '' then
                                        if Customer.Get("Account No") then
                                            if VATSetup.Get(RecTypes."VAT Bus. Posting Group", "W/Tax Code") then begin
                                                "W/TAmount" := Round(NetAmount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                                "W/Tax Amount" := "W/TAmount";
                                                NetAmount := NetAmount - "W/TAmount";
                                                if CSetup."Post VAT" then//Check IF VAT is to be posted
                                                    "Net Amount" := NetAmount
                                                else
                                                    "Net Amount" := Amount - "W/TAmount";
                                            end;
                                    if "W/T VAT Code" <> '' then begin//Compute W/T VAT
                                        if GLAccount.Get("Account No") then;
                                        if VATSetup.Get(RecTypes."VAT Bus. Posting Group", "W/T VAT Code") then begin
                                            if VATSetup2.Get(RecTypes."VAT Bus. Posting Group", "VAT Code") then;
                                            WTVATAmount := Round((VATAmount * VATSetup."VAT %" / 100 / (VATSetup2."VAT %" / 100)),
                                            CSetup."Rounding Precision", Direction);
                                            "W/T VAT Amount" := WTVATAmount;
                                            NetAmount := NetAmount - WTVATAmount;
                                            "Net Amount" := "Net Amount" - WTVATAmount;
                                        end;
                                    end;
                                end else begin
                                    "Net Amount" := Amount;
                                    NetAmount := Amount;
                                    if "W/Tax Code" <> '' then
                                        if Customer.Get("Account No") then
                                            if VATSetup.Get(RecTypes."VAT Bus. Posting Group", "W/Tax Code") then begin
                                                "W/TAmount" := Round(NetAmount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                                "W/Tax Amount" := "W/TAmount";
                                                NetAmount := NetAmount - "W/TAmount";
                                                "Net Amount" := Amount - "W/TAmount";
                                            end;
                                end;
                            end;
                        end
                        else begin
                            "Net Amount" := Amount;
                            NetAmount := Amount;
                            if "W/Tax Code" <> '' then begin
                                if Customer.Get("Account No") then;
                                //Customer.TestField("VAT Bus. Posting Group");
                                if VATSetup.Get(RecTypes."VAT Bus. Posting Group", "W/Tax Code") then begin
                                    "W/TAmount" := Round(NetAmount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                    "W/Tax Amount" := "W/TAmount";
                                    NetAmount := NetAmount - "W/TAmount";
                                    "Net Amount" := Amount - "W/TAmount";
                                end;
                            end;
                        end;
                    "Account Type"::Vendor:

                        if "VAT Code" <> '' then begin
                            if Vendor.Get("Account No") then;
                            //Vendor.TestField("VAT Bus. Posting Group");
                            if VATSetup.Get(RecTypes."VAT Bus. Posting Group", "VAT Code") then
                                if VATSetup."VAT %" <> 0 then begin
                                    if "Vatable Amount" = 0 then
                                        VATAmount := Round(((Amount) / (1 + VATSetup."VAT %" / 100) * VATSetup."VAT %" / 100),
                                                   CSetup."Rounding Precision", Direction)
                                    else
                                        VATAmount := Round((("Vatable Amount") * VATSetup."VAT %" / 100),
                                                  CSetup."Rounding Precision", Direction);
                                    NetAmount := (Amount) - VATAmount;
                                    "VAT Amount" := VATAmount;
                                    if CSetup."Post VAT" then//Check IF VAT is to be posted
                                        "Net Amount" := Amount - VATAmount
                                    else
                                        "Net Amount" := Amount;

                                    if "W/Tax Code" <> '' then
                                        if Vendor.Get("Account No") then
                                            if VATSetup.Get(RecTypes."VAT Bus. Posting Group", "W/Tax Code") then begin
                                                if "Levied Invoice H" = false then begin  //To cater for levied invoices
                                                    "W/TAmount" := Round(NetAmount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                                    "W/Tax Amount" := "W/TAmount";
                                                    NetAmount := Round((NetAmount - "W/TAmount"), CSetup."Rounding Precision", Direction);
                                                end else
                                                    if "Levied Invoice H" = true then begin //To cater for levied invoices
                                                        "W/TAmount" := Round(Amount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                                        "W/Tax Amount" := "W/TAmount";
                                                        "10% Not Wtheld" := Round(((10 / 100) * "Vatable Amount"), CSetup."Rounding Precision", Direction);
                                                        NetAmount := Round(("Vatable Amount" + "Other Charges" - "W/TAmount"), CSetup."Rounding Precision", Direction);
                                                    end;
                                                if CSetup."Post VAT" then//Check IF VAT is to be posted
                                                    "Net Amount" := NetAmount
                                                else
                                                    "Net Amount" := Round((Amount - "W/TAmount"), CSetup."Rounding Precision", Direction);
                                            end;

                                    if "W/T VAT Code" <> '' then //Compute W/T VAT
                                        if Vendor.Get("Account No") then
                                            if VATSetup.Get(RecTypes."VAT Bus. Posting Group", "W/T VAT Code") then
                                                if VATSetup2.Get(RecTypes."VAT Bus. Posting Group", "VAT Code") then
                                                    if "Levied Invoice H" = false then begin
                                                        WTVATAmount := Round((VATAmount * VATSetup."VAT %" / 100 / (VATSetup2."VAT %" / 100)),
                                                        CSetup."Rounding Precision", Direction);
                                                        "W/T VAT Amount" := WTVATAmount;
                                                        NetAmount := NetAmount - WTVATAmount;
                                                        "Net Amount" := "Net Amount" - WTVATAmount;
                                                    end else
                                                        if "Levied Invoice H" = true then begin
                                                            WTVATAmount := Round(("Vatable Amount" * VATSetup."VAT %" / 100),
                                                           CSetup."Rounding Precision", Direction);
                                                            "W/T VAT Amount" := WTVATAmount;
                                                            NetAmount := NetAmount - WTVATAmount;
                                                            "Net Amount" := "Net Amount" - WTVATAmount;
                                                        end;
                                end else begin
                                    "Net Amount" := Amount;
                                    NetAmount := Amount;
                                    if "W/Tax Code" <> '' then begin
                                        if Vendor.Get("Account No") then;
                                        Vendor.TestField("VAT Bus. Posting Group");
                                        if VATSetup.Get(RecTypes."VAT Bus. Posting Group", "W/Tax Code") then begin
                                            "W/TAmount" := Round(NetAmount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                            "W/Tax Amount" := "W/TAmount";
                                            NetAmount := NetAmount - "W/TAmount";
                                            "Net Amount" := Amount - "W/TAmount";
                                        end;
                                    end;
                                end;
                        end
                        else begin
                            "Net Amount" := Amount;
                            NetAmount := Amount;
                            if "W/Tax Code" <> '' then
                                if Vendor.Get("Account No") then
                                    if VATSetup.Get(RecTypes."VAT Bus. Posting Group", "W/Tax Code") then begin
                                        "W/TAmount" := Round(NetAmount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                        "W/Tax Amount" := "W/TAmount";
                                        NetAmount := NetAmount - "W/TAmount";
                                        "Net Amount" := Amount - "W/TAmount";
                                    end;
                        end;
                    "Account Type"::"Bank Account":
                        "Net Amount" := Amount;
                end;

                GetPaymentHeader();

                if PHeader.Get(No) then begin
                    if PHeader."Payment Release Date" <> 0D then
                        CurrencyValidationDate := PHeader."Payment Release Date"
                    else
                        CurrencyValidationDate := PHeader.Date;

                    //Convert FCY to LCY
                    CurrencyRec.InitRoundingPrecision();
                    if PHeader.Currency = '' then begin
                        "Amount (LCY)" := Round(Amount, CurrencyRec."Amount Rounding Precision");
                        "NetAmount LCY" := Round("Net Amount", CurrencyRec."Amount Rounding Precision");
                    end else
                        if CurrencyRec.Get(PHeader.Currency) then begin
                            "Amount (LCY)" := Round(
                              CurrExchRate.ExchangeAmtFCYToLCY(
                                CurrencyValidationDate, CopyStr(PHeader.Currency, 1, 10),
                                Amount, CurrExchRate.ExchangeRate(CurrencyValidationDate, CopyStr(PHeader.Currency, 1, 10))),
                                CurrencyRec."Amount Rounding Precision");

                            "NetAmount LCY" := Round(
                                CurrExchRate.ExchangeAmtFCYToLCY(
                                CurrencyValidationDate, CopyStr(PHeader.Currency, 1, 10),
                                "Net Amount", CurrExchRate.ExchangeRate(CurrencyValidationDate, CopyStr(PHeader.Currency, 1, 10))),
                                CurrencyRec."Amount Rounding Precision");
                        end;
                end;
            end;
        }
        field(9; Posted; Boolean)
        {
            Caption = 'Posted';
            Editable = false;
        }
        field(10; "Posted Date"; Date)
        {
            Caption = 'Posted Date';
        }
        field(11; "Posted Time"; Time)
        {
            Caption = 'Posted Time';
        }
        field(12; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(13; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(15; "VAT Code"; Code[20])
        {
            Caption = 'VAT Code';
            TableRelation = "VAT Product Posting Group";

            trigger OnValidate()
            begin
                Validate(Amount);
            end;
        }
        field(16; "W/Tax Code"; Code[20])
        {
            Caption = 'W/Tax Code';
            TableRelation = "VAT Product Posting Group";

            trigger OnValidate()
            begin
                Validate(Amount);
            end;
        }
        field(17; "Retention Code"; Code[20])
        {
            Caption = 'Retention Code';
            TableRelation = "VAT Product Posting Group";
        }
        field(18; "VAT Amount"; Decimal)
        {
            Caption = 'VAT Amount';
        }
        field(19; "W/Tax Amount"; Decimal)
        {
            Caption = 'W/Tax Amount';
        }
        field(20; "Retention Amount"; Decimal)
        {
            Caption = 'Retention Amount';

            trigger OnValidate()
            begin
                Validate(Amount)
            end;
        }
        field(21; "Net Amount"; Decimal)
        {
            Caption = 'Net Amount';
        }
        field(22; "W/T VAT Code"; Code[20])
        {
            Caption = 'W/T VAT Code';
            TableRelation = "VAT Product Posting Group";

            trigger OnValidate()
            begin
                Validate(Amount);
            end;
        }
        field(23; "W/T VAT Amount"; Decimal)
        {
            Caption = 'W/T VAT Amount';
        }
        field(37; Grouping; Code[20])
        {
            Caption = 'Grouping';
            TableRelation = "Vendor Posting Group".Code;
        }
        field(38; "Payment Type"; Enum "Payments Mgt Type")
        {
            Caption = 'Payment Type';
        }
        field(39; Purpose; Text[250])
        {
            Caption = 'Purpose';
        }
        field(83; Committed; Boolean)
        {
            Caption = 'Committed';
        }
        field(85; "NetAmount LCY"; Decimal)
        {
            Caption = 'NetAmount LCY';
        }
        field(87; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';

            trigger OnValidate()
            begin
                /*//IF "Applies-to Doc. No." <> '' THEN
                //TESTFIELD("Bal. Account No.",'');

              if ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") and (xRec."Applies-to Doc. No." <> '') and
                 ("Applies-to Doc. No." <> '')
              then begin
                SetAmountToApply("Applies-to Doc. No.","Account No.");
                SetAmountToApply(xRec."Applies-to Doc. No.","Account No.");
              end else
                if ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") and (xRec."Applies-to Doc. No." = '') then
                  SetAmountToApply("Applies-to Doc. No.","Account No.")
                else if ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") and ("Applies-to Doc. No." = '') then
                    SetAmountToApply(xRec."Applies-to Doc. No.","Account No.");
              */
            end;

            trigger OnLookup()
            begin
                //CODEUNIT.RUN(CODEUNIT::"Payment Voucher Apply",Rec);
                /*
                if (Rec."Account Type"<>Rec."Account Type"::Customer) and (Rec."Account Type"<>Rec."Account Type"::Vendor) then
                    Error('You cannot apply to %1',"Account Type");

                with Rec do begin
                  Amount:=0;
                  Validate(Amount);
                  PayToVendorNo := "Account No." ;
                  VendLedgEntry.SetCurrentKey("Vendor No.",Open);
                  VendLedgEntry.SetRange("Vendor No.",PayToVendorNo);
                  VendLedgEntry.SetRange(Open,true);
                  if "Applies-to ID" = '' then
                    "Applies-to ID" := No;
                  if "Applies-to ID" = '' then
                    Error(
                      Text000,
                      FieldCaption(No),FieldCaption("Applies-to ID"));
                  //ApplyVendEntries."SetPVLine-Delete"(PVLine,PVLine.FIELDNO("Applies-to ID"));
                  ApplyVendEntries.SetPVLine(Rec,VendLedgEntry,Rec.FieldNo("Applies-to ID"));
                  ApplyVendEntries.SETRECORD(VendLedgEntry);
                  ApplyVendEntries.SETTABLEVIEW(VendLedgEntry);
                  ApplyVendEntries.LOOKUPMODE(true);
                  OK := ApplyVendEntries.RunModal() = Action::LookupOK;
                  Clear(ApplyVendEntries);
                  if not OK then
                    exit;
                  VendLedgEntry.Reset();
                  VendLedgEntry.SetCurrentKey("Vendor No.",Open);
                  VendLedgEntry.SetRange("Vendor No.",PayToVendorNo);
                  VendLedgEntry.SetRange(Open,true);
                  VendLedgEntry.SetRange("Applies-to ID","Applies-to ID");
                  if VendLedgEntry.Find('-') then begin
                    "Applies-to Doc. Type" := 0;
                    "Applies-to Doc. No." := '';
                  end else
                    "Applies-to ID" := '';
                end;

                //Calculate  Total To Apply
                  VendLedgEntry.Reset();
                  VendLedgEntry.SetCurrentKey("Vendor No.",Open,"Applies-to ID");
                  VendLedgEntry.SetRange("Vendor No.",PayToVendorNo);
                  VendLedgEntry.SetRange(Open,true);
                  VendLedgEntry.SetRange("Applies-to ID","Applies-to ID");
                  if VendLedgEntry.Find('-') then begin
                        VendLedgEntry.CalcSums("Amount to Apply");
                        Amount:=Abs(VendLedgEntry."Amount to Apply");
                        Validate(Amount);
                  end;

                */
            end;
        }
        field(88; "Applies-to ID"; Code[50])
        {
            Caption = 'Applies-to ID';

            trigger OnValidate()
            begin
                /*
                //IF "Applies-to ID" <> '' THEN
                //  TESTFIELD("Bal. Account No.",'');
                if ("Applies-to ID" <> xRec."Applies-to ID") and (xRec."Applies-to ID" <> '') then begin
                  VendLedgEntry.SetCurrentKey("Vendor No.",Open);
                  VendLedgEntry.SetRange("Vendor No.","Account No.");
                  VendLedgEntry.SetRange(Open,true);
                  VendLedgEntry.SetRange("Applies-to ID",xRec."Applies-to ID");
                  if VendLedgEntry.FindFirst() then
                    VendEntrySetApplID.SetApplId(VendLedgEntry,TempVendLedgEntry,0,0,'');
                  VendLedgEntry.Reset();
                end;
                */
            end;
        }
        field(89; "Actual Spent"; Decimal)
        {
            Caption = 'Actual Spent';

            trigger OnValidate()
            begin
                "Remaining Amount" := Amount - "Actual Spent" - "Cash Receipt Amount";
            end;
        }
        field(90; "Remaining Amount"; Decimal)
        {
            Caption = 'Remaining Amount';
        }
        field(91; "Actual Spent (LCY)"; Decimal)
        {
            Caption = 'Actual Spent (LCY)';
        }
        field(92; "Remaining Amount (LCY)"; Decimal)
        {
            Caption = 'Remaining Amount (LCY)';
        }
        field(93; "Cash Receipt Amount"; Decimal)
        {
            Caption = 'Cash Receipt Amount';

            trigger OnValidate()
            begin
                Validate("Actual Spent");
            end;
        }
        field(94; "Cash Receipt Amount (LCY)"; Decimal)
        {
            Caption = 'Cash Receipt Amount (LCY)';
        }
        field(95; "Expenditure Type"; Code[20])
        {
            Caption = 'Expenditure Type';
            TableRelation = if ("Payment Type" = filter(Imprest)) "Receipts and Payment Types".Code where(Type = filter(Imprest),
                                                                                                          Blocked = const(false))
            else
            if ("Payment Type" = filter("Payment Voucher")) "Receipts and Payment Types".Code where(Type = filter("Payment Voucher"),
                                                                                                    Blocked = const(false))
            else
            if ("Payment Type" = filter("Petty Cash")) "Receipts and Payment Types".Code where(Type = filter("Petty Cash"),
                                                                                               Blocked = const(false))
            else
            if ("Payment Type" = filter(Receipt)) "Receipts and Payment Types".Code where(Type = filter(Receipt),
                                                                                          Blocked = const(false))
            else
            if ("Payment Type" = filter("Staff Claim")) "Receipts and Payment Types".Code where(Type = filter("Staff Claim"),
                                                                                                Blocked = const(false))
            else
            if ("Payment Type" = filter("Receipt-Property")) "Receipts and Payment Types".Code where(Type = filter("Receipt-Property"),
                                                                                                     Blocked = const(false))
            else
            if ("Payment Type" = filter("Input Tax")) "Receipts and Payment Types".Code where(Type = filter("Input Tax"),
                                                                                              Blocked = const(false))
            else
            if ("Payment Type" = filter("Property Expense" | "Property Expense Claim")) "Receipts and Payment Types".Code where(Type = const("Property Expense"),
                                                                                                                                Blocked = const(false));

            trigger OnValidate()
            begin
                GetPaymentHeader();
                RecTypes.Reset();
                RecTypes.SetRange(Code, "Expenditure Type");
                RecTypes.SetRange(Type, "Payment Type");
                if RecTypes.FindFirst() then begin
                    "Account Type" := RecTypes."Account Type";
                    "Account No" := RecTypes."Account No.";
                    if "Account No" <> '' then
                        Validate("Account No");
                    "Imprest Payment" := RecTypes."Imprest Payment";
                    "Claim Payment" := RecTypes."Claim Payment";
                    //"No of Days" := GetNoOfDays();

                    //Description:=RecTypes.Description;
                    "Based On Travel Rates" := RecTypes."Based On Travel Rates Table";
                    if "Based On Travel Rates" then begin
                        "No of Days" := GetNoOfDays();
                        //Amount := GetDestinationRate();
                        Validate(Amount);
                    end else begin
                        if "Daily Rate" <> 0 then
                            Amount := "Daily Rate" * "No of Days";
                        Validate(Amount);
                    end;
                end;
            end;
        }
        field(96; Comments; Text[250])
        {
            Caption = 'Comments';
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(481; "Bank Acc"; Code[20])
        {
            CalcFormula = lookup(Payments."Paying Bank Account" where("No." = field(No)));
            Caption = 'Bank Acc';
            Editable = false;
            FieldClass = FlowField;
        }
        field(482; "Receiving Bank"; Code[20])
        {
            Caption = 'Receiving Bank';
            TableRelation = "Bank Account";
        }
        field(483; "Vendor Invoice"; Code[20])
        {
            Caption = 'Vendor Invoice';
        }
        field(486; "Imprest Holder"; Code[20])
        {
            Caption = 'Imprest Holder';
        }
        field(487; "Surrender Date"; Date)
        {
            Caption = 'Surrender Date';
        }
        field(488; "Vatable Amount"; Decimal)
        {
            Caption = 'Vatable Amount';
        }
        field(489; "Other Charges"; Decimal)
        {
            Caption = 'Other Charges';

            trigger OnValidate()
            begin
                Validate(Amount);
            end;
        }
        field(490; "10% Not Wtheld"; Decimal)
        {
            Caption = '10% Not Wtheld';
        }
        field(491; "Levied Invoice H"; Boolean)
        {
            CalcFormula = lookup(Payments."Levied Invoice" where("No." = field(No)));
            Caption = 'Levied Invoice H';
            Editable = false;
            FieldClass = FlowField;
        }
        field(492; "Imprest Receipt No."; Code[20])
        {
            Caption = 'Imprest Receipt No.';
            Editable = false;
        }
        field(493; Destination; Code[50])
        {
            Caption = 'Destination';
            TableRelation = Destination."Destination Code";
        }
        field(494; "Daily Rate"; Decimal)
        {
            Caption = 'Daily Rate';
            trigger OnValidate()
            begin
                if "No of Days" <> 0 then
                    Validate(Amount, ("Daily Rate" * "No of Days"));
            end;
        }
        field(495; "Claim Receipt No."; Code[50])
        {
            Caption = 'Claim Receipt No.';
        }
        field(496; "Expenditure Date"; Date)
        {
            Caption = 'Expenditure Date';
        }
        field(497; "Expenditure Description"; Text[100])
        {
            Caption = 'Expenditure Description';
        }
        field(498; "No of Days"; Integer)
        {
            Caption = 'No of Days';

            trigger OnValidate()
            begin
                if "Expenditure Type" <> '' then
                    Validate("Expenditure Type");

                if "Daily Rate" <> 0 then
                    Validate(Amount, ("Daily Rate" * "No of Days"));
            end;
        }
        field(499; "VAT Exclusive"; Boolean)
        {
            Caption = 'VAT Exclusive';

            trigger OnValidate()
            begin
                Validate(Amount);
            end;
        }
        field(500; "Based On Travel Rates"; Boolean)
        {
            Caption = 'Based On Travel Rates';
        }
        field(501; "Sort Code"; Code[10])
        {
            Caption = 'Sort Code';
        }
        field(502; "Our Account No."; Text[20])
        {
            Caption = 'Our Account No.';
        }
        field(503; "Imprest No."; Code[20])
        {
            Caption = 'Imprest No.';
            TableRelation = Payments."No." where(Status = filter(Released),
                                                  Posted = const(false),
                                                  "Payment Type" = filter(Imprest));

            trigger OnValidate()
            var
                ImprestDoc: Record Payments;
                ImprestExistErr: Label 'This Imprest is already in PV Number %1', Comment = '%1 = Imprest No.';
            begin
                if ImprestDoc.Get("Imprest No.") then begin
                    PaymentLines.Reset();
                    PaymentLines.SetRange("Imprest No.", "Imprest No.");
                    if PaymentLines.FindFirst() then
                        Error(ImprestExistErr, PaymentLines.No);

                    //Get Total Imprest Amount
                    ImprestDoc.CalcFields("Imprest Amount", "Total Net Amount");
                    Validate("Account No", ImprestDoc."Account No.");
                    Currency := ImprestDoc.Currency;
                    Validate(Amount, ImprestDoc."Imprest Amount");
                    Description := ImprestDoc."Payment Narration";
                end;
            end;
        }
        field(504; "Claim Type"; Option)
        {
            Caption = 'Claim Type';
            OptionCaption = 'General Claim,Medical Claim';
            OptionMembers = "General Claim","Medical Claim";
        }
        field(505; "Imprest Payment"; Boolean)
        {
            Caption = 'Imprest Payment';
        }
        field(506; "Claim Payment"; Boolean)
        {
            Caption = 'Claim Payment';
        }
        field(507; "Claim No."; Code[10])
        {
            Caption = 'Claim No.';
            TableRelation = Payments."No." where(Status = filter(Released),
                                                  Posted = const(false),
                                                  "Payment Type" = filter("Staff Claim"));

            trigger OnValidate()
            begin
                if PaymentRec.Get("Claim No.") then begin
                    StaffNo := PaymentRec."Staff No.";
                    AccName := PaymentRec.Payee;

                    PaymentLines.Reset();
                    PaymentLines.SetRange(PaymentLines."Claim No.", "Claim No.");
                    if PaymentLines.FindFirst() then
                        Error('This Claim is already in PV Number %1', PaymentLines.No);

                    //Get Claim Details
                    PaymentLines2.Reset();
                    PaymentLines2.SetRange(PaymentLines2.No, "Claim No.");
                    if PaymentLines2.Find('-') then begin
                        //Gets total amount in case of multilined claim
                        PaymentLines2.CalcSums(Amount);
                        "Account No" := PaymentLines2."Account No";
                        Validate("Account No");
                        Description := PaymentLines2.Description + '_' + StaffNo + '-' + AccName;
                        Amount := PaymentLines2.Amount;
                        Validate(Amount);
                        "Expenditure Date" := PaymentLines2."Expenditure Date";
                        "Expenditure Description" := PaymentLines2."Expenditure Description";
                        "Claim Receipt No." := PaymentLines2."Claim Receipt No.";
                    end;
                end;
            end;
        }
        field(508; "Gen. Posting Type"; Enum "General Posting Type")
        {
            Caption = 'Gen. Posting Type';

            trigger OnValidate()
            begin
            end;
        }
        field(509; Currency; Code[20])
        {
            Caption = 'Currency';
            TableRelation = Currency;

            trigger OnValidate()
            begin

                if "Payment Type" = "Payment Type"::"Bank Transfer" then
                    if PaymentRec.Get(No) then
                        Amount := CurrExchRate.ExchangeAmtFCYToFCY(Today(), PaymentRec."Source Currency", CopyStr(Currency, 1, 10), PaymentRec."Source Bank Amount");

                Validate(Amount);
            end;
        }
        field(510; "Amount (LCY)"; Decimal)
        {
            Caption = 'Amount (LCY)';
        }
        field(511; "Applies-to Doc Type"; Enum "Gen. Journal Document Type")
        {
            Caption = 'Applies-to Doc. Type';
        }
        field(512; "Bank Account Branch"; Code[150])
        {
            Caption = 'Bank Account Branch';
        }
        field(513; "Bank Account No"; Code[150])
        {
            Caption = 'Bank Account No';
        }
    }

    keys
    {
        key(Key1; No, "Line No")
        {
            Clustered = true;
            SumIndexFields = Amount, "Remaining Amount", "Amount (LCY)", "Remaining Amount (LCY)";
        }
    }

    var
        Bank: Record "Bank Account";
        CSetup: Record "Cash Management Setups";
        CurrencyRec: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        Customer: Record Customer;
        FixedAsset: Record "Fixed Asset";
        GLAccount: Record "G/L Account";
        GLSetup: Record "General Ledger Setup";
        PaymentLines: Record "Payment Lines";
        PaymentLines2: Record "Payment Lines";
        PaymentRec: Record Payments;
        RecTypes: Record "Receipts and Payment Types";
        VATSetup: Record "VAT Posting Setup";
        VATSetup2: Record "VAT Posting Setup";
        Vendor: Record Vendor;
        DimMgt: Codeunit DimensionManagement;
        HasGotGLSetup: Boolean;
        GLSetupShortcutDimCode: array[8] of Code[20];
        StaffNo: Code[50];
        NetAmount: Decimal;
        VATAmount: Decimal;
        "W/TAmount": Decimal;
        WTVATAmount: Decimal;
        AccName: Text;
        Direction: Text[30];

    trigger OnInsert()
    begin
        if PaymentRec.Get(No) then
            Currency := PaymentRec.Currency;
    end;

    procedure CheckDocType(): Boolean
    begin
        PaymentRec.Reset();
        PaymentRec.SetRange("Payment Type", "Payment Type");
        PaymentRec.SetRange("No.", No);
        if PaymentRec.Find('-') then
            if PaymentRec."Multi-Donor" then
                exit(true)
            else
                exit(false);
    end;

    procedure GetAppliedDoc(): Code[50]
    var
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        DetailedCustLedgEntry2: Record "Detailed Cust. Ledg. Entry";
        DetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
        DetailedVendorLedgEntry2: Record "Detailed Vendor Ledg. Entry";
    begin
        if "Applies-to ID" <> '' then
            case "Account Type" of
                "Account Type"::Customer:
                    begin
                        DetailedCustLedgEntry.Reset();
                        DetailedCustLedgEntry.SetRange(DetailedCustLedgEntry."Customer No.", "Account No");
                        DetailedCustLedgEntry.SetRange(DetailedCustLedgEntry."Document No.", No);
                        DetailedCustLedgEntry.SetRange(DetailedCustLedgEntry."Credit Amount", Amount);
                        DetailedCustLedgEntry.SetRange(DetailedCustLedgEntry."Entry Type", DetailedCustLedgEntry."Entry Type"::Application);
                        if DetailedCustLedgEntry.FindFirst() then begin
                            DetailedCustLedgEntry2.Reset();
                            DetailedCustLedgEntry2.SetRange(DetailedCustLedgEntry2."Cust. Ledger Entry No.", DetailedCustLedgEntry."Cust. Ledger Entry No.");
                            if DetailedCustLedgEntry2.FindFirst() then
                                exit(DetailedCustLedgEntry2."Document No.");
                        end;
                    end;

                "Account Type"::Vendor:
                    begin
                        DetailedVendorLedgEntry.Reset();
                        DetailedVendorLedgEntry.SetRange(DetailedVendorLedgEntry."Vendor No.", "Account No");
                        DetailedVendorLedgEntry.SetRange(DetailedVendorLedgEntry."Document No.", No);
                        DetailedVendorLedgEntry.SetRange(DetailedVendorLedgEntry."Debit Amount", Amount);
                        DetailedVendorLedgEntry.SetRange(DetailedVendorLedgEntry."Entry Type", DetailedVendorLedgEntry."Entry Type"::Application);
                        if DetailedVendorLedgEntry.FindFirst() then begin
                            DetailedVendorLedgEntry2.Reset();
                            DetailedVendorLedgEntry2.SetRange(DetailedVendorLedgEntry2."Vendor Ledger Entry No.", DetailedVendorLedgEntry."Vendor Ledger Entry No.");
                            if DetailedVendorLedgEntry2.FindFirst() then
                                exit(DetailedVendorLedgEntry2."Document No.");
                        end;
                    end;
            end;
    end;

    procedure GetCurrency()
    begin
    end;

    procedure GetGLSetup()
    var
        GLSetupRec: Record "General Ledger Setup";
    begin
        if not HasGotGLSetup then begin
            GLSetupRec.Get();
            GLSetupShortcutDimCode[1] := GLSetupRec."Shortcut Dimension 1 Code";
            GLSetupShortcutDimCode[2] := GLSetupRec."Shortcut Dimension 2 Code";
            GLSetupShortcutDimCode[3] := GLSetupRec."Shortcut Dimension 3 Code";
            GLSetupShortcutDimCode[4] := GLSetupRec."Shortcut Dimension 4 Code";
            GLSetupShortcutDimCode[5] := GLSetupRec."Shortcut Dimension 5 Code";
            GLSetupShortcutDimCode[6] := GLSetupRec."Shortcut Dimension 6 Code";
            GLSetupShortcutDimCode[7] := GLSetupRec."Shortcut Dimension 7 Code";
            GLSetupShortcutDimCode[8] := GLSetupRec."Shortcut Dimension 8 Code";
            HasGotGLSetup := true;
        end;
    end;

    procedure ImprestLineExist(): Boolean
    var
        ImprestLines: Record "Payment Lines";
        ImprestRec: Record Payments;
    begin
        ImprestRec.Reset();
        ImprestRec.SetRange("Payment Type", ImprestRec."Payment Type"::"Imprest Surrender");
        ImprestRec.SetRange("No.", No);
        if ImprestRec.FindFirst() then begin
            ImprestLines.Reset();
            ImprestLines.SetRange(No, ImprestRec."Imprest Issue Doc. No");
            ImprestLines.SetRange("Line No", "Line No");
            if not ImprestLines.IsEmpty() then
                exit(true);
        end;
    end;

    procedure InsertPaymentTypes()
    begin
        PaymentRec.Reset();
        PaymentRec.SetRange(PaymentRec."No.", No);
        if PaymentRec.FindFirst() then
            "Payment Type" := PaymentRec."Payment Type";
    end;

    procedure LookupShortcutDimCode(FieldNumber: Integer; ShortcutDimCode: Code[20])
    begin
        /*if PaymentRec.Get(No) then;
        if FieldNumber = 5 then
            if PaymentRec."Multi-Donor" then
                DimMgt.LookupDimValueCode2(FieldNumber, ShortcutDimCode, "Dimension Set ID")
            else
                if "Dimension Set ID" <> 0 then
                    DimMgt.LookupDimValueCode2(FieldNumber, ShortcutDimCode, "Dimension Set ID")
                else
                    DimMgt.LookupDimValueCode2(FieldNumber, ShortcutDimCode, PaymentRec."Dimension Set ID");

        if FieldNumber = 6 then
            if PaymentRec."Multi-Donor" then
                DimMgt.LookupDimValueCode2(FieldNumber, ShortcutDimCode, "Dimension Set ID")
            else
                if "Dimension Set ID" <> 0 then
                    DimMgt.LookupDimValueCode2(FieldNumber, ShortcutDimCode, "Dimension Set ID")
                else
                    DimMgt.LookupDimValueCode2(FieldNumber, ShortcutDimCode, PaymentRec."Dimension Set ID");

        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);*/
    end;

    procedure ShowDimensions()
    begin
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2 %3', "Payment Type", No, "Line No"));
        //VerifyItemLineDim;
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        GLBudget: Record "G/L Budget Entry";
        PaymentsRec: Record Payments;
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");

        if (OldDimSetID <> "Dimension Set ID") and ((No <> '') and ("Line No" <> 0)) then;
        //MODIFY;
        //IF SalesLinesExist THEN
        //UpdateAllLineDim("Dimension Set ID",OldDimSetID);

        //Fetch Output and Ourcome from Budget
        if PaymentsRec.Get(No) then;
        if FieldNumber = 5 then begin
            GLSetup.Get();
            GLBudget.SetRange("Budget Name", GLSetup."Current Budget");
            GLBudget.SetRange("Budget Dimension 3 Code", ShortcutDimCode);
            //GLBudget.SETRANGE("Budget Type",GLBudget."Budget Type"::Disbursed);
            //GLBudget.SETRANGE("Budget Type",GLBudget."Budget Type"::"Donor Approved");
            if GLBudget.Find('-') then begin
                //Global Dimensions
                OldDimSetID := "Dimension Set ID";
                if PaymentsRec."Multi-Donor" then
                    DimMgt.ValidateShortcutDimValues(1, "Shortcut Dimension 1 Code", "Dimension Set ID")
                else
                    DimMgt.ValidateShortcutDimValues(1, PaymentsRec."Shortcut Dimension 1 Code", "Dimension Set ID");
                if (OldDimSetID <> "Dimension Set ID") and ((No <> '') and ("Line No" <> 0)) then begin
                    //IF FINDSET THEN
                    Modify();
                    DimMgt.UpdateGlobalDimFromDimSetID(
                         "Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
                end;

                OldDimSetID := "Dimension Set ID";
                if PaymentsRec."Multi-Donor" then
                    DimMgt.ValidateShortcutDimValues(2, "Shortcut Dimension 2 Code", "Dimension Set ID")
                else
                    DimMgt.ValidateShortcutDimValues(2, PaymentsRec."Shortcut Dimension 2 Code", "Dimension Set ID");
                if (OldDimSetID <> "Dimension Set ID") and ((No <> '') and ("Line No" <> 0)) then begin
                    //IF FINDSET THEN
                    Modify();
                    DimMgt.UpdateGlobalDimFromDimSetID(
                         "Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
                end;
                OldDimSetID := "Dimension Set ID";
                DimMgt.ValidateShortcutDimValues(3, GLBudget."Budget Dimension 1 Code", "Dimension Set ID");
                if (OldDimSetID <> "Dimension Set ID") and ((No <> '') and ("Line No" <> 0)) then
                    //IF FINDSET THEN
                    Modify();
                //Dim Value 4
                OldDimSetID := "Dimension Set ID";
                DimMgt.ValidateShortcutDimValues(4, GLBudget."Budget Dimension 2 Code", "Dimension Set ID");
                if (OldDimSetID <> "Dimension Set ID") and ((No <> '') and ("Line No" <> 0)) then
                    //IF FINDSET THEN
                    Modify();
            end;
        end;

        //G/L Account
        if FieldNumber = 6 then begin
            GLSetup.Get();
            GLBudget.SetRange("Budget Name", GLSetup."Current Budget");
            GLBudget.SetRange("Budget Dimension 4 Code", ShortcutDimCode);
            //GLBudget.SETRANGE("Budget Type",GLBudget."Budget Type"::Disbursed);
            //GLBudget.SETRANGE("Budget Type",GLBudget."Budget Type"::"Donor Approved");
            if GLBudget.FindFirst() then begin

                if "Account Type" <> "Account Type"::"G/L Account" then
                    "Account Type" := "Account Type"::"G/L Account";
                //MODIFY;

                if "Account No" <> GLBudget."G/L Account No." then begin
                    "Account No" := GLBudget."G/L Account No.";
                    Validate("Account No");
                    //MODIFY;
                end;
            end;
        end;
    end;

    procedure ValidateSurrenderLines()
    var
        ShortcutDimCode: array[8] of Code[20];
    begin
        TestField(Purpose);
        //TestField("Shortcut Dimension 1 Code");
        //TestField("Shortcut Dimension 2 Code");
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
        GetGLSetup();

        // IF ShortcutDimCode[5]='' THEN
        //  ERROR(Text000,GLSetupShortcutDimCode[5]);
        // IF ShortcutDimCode[6]='' THEN
        //  ERROR(Text000,GLSetupShortcutDimCode[6]);
    end;

    /* local procedure GetDestinationRate(): Decimal
    var
        Destination: Record Destination;
        DestinationRate: Record "Destination Rate Entry";
        TotalAmount: Decimal;
    begin
        Destination.Reset();
        Destination.SetRange("Destination Code", PaymentRec.Destination);
        if Destination.FindFirst() then begin
            DestinationRate.Reset();
            DestinationRate.SetRange("Destination Code", Destination."Destination Code");
            DestinationRate.SetRange("Employee Job Group", GetJobGroup());
            DestinationRate.SetRange("Advance Code", "Expenditure Type");
            if DestinationRate.FindFirst() then begin
                "Daily Rate" := DestinationRate."Daily Rate (Amount)";
                TotalAmount := "Daily Rate" * "No of Days";
                exit(TotalAmount);
                //PLines.MODIFY;
            end else
                Error('The job group rates for destination %1 have not been set up.', PaymentRec.Destination);
        end else
            Error('The destination %1 is not set up.', PaymentRec.Destination);
    end;

    local procedure GetJobGroup(): Code[50]
    var
        Employee: Record Employee;
    begin
        if PaymentRec.Get(No) then begin
            PaymentRec.TestField("Staff No.");

            Employee.Reset();
            Employee.SetRange("No.", PaymentRec."Staff No.");
            if Employee.FindFirst() then
                exit(Employee."Salary Scale");
        end
    end; */

    local procedure GetNoOfDays(): Integer
    begin
        if PaymentRec.Get(No) then
            exit(PaymentRec."No of Days");
    end;

    local procedure GetPaymentHeader()
    begin
        if PaymentRec.Get(No) then;
    end;
}
