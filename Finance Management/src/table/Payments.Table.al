table 51004 Payments
{
    Caption = 'Payments';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                case "Payment Type" of
                    "Payment Type"::"Payment Voucher":
                        if "No." <> xRec."No." then begin
                            NoSeriesMgt.TestManual(CashMgt."PV Nos");
                            "No. Series" := '';
                        end;
                    "Payment Type"::Imprest:
                        if "No." <> xRec."No." then begin
                            NoSeriesMgt.TestManual(CashMgt."Imprest Nos");
                            "No. Series" := '';
                        end;
                    "Payment Type"::"Petty Cash":
                        if "No." <> xRec."No." then begin
                            NoSeriesMgt.TestManual(CashMgt."Petty Cash Nos");
                            "No. Series" := '';
                        end;
                    "Payment Type"::"Petty Cash Surrender":
                        if "No." <> xRec."No." then begin
                            NoSeriesMgt.TestManual(CashMgt."Petty Cash Surrender Nos");
                            "No. Series" := '';
                        end;
                    "Payment Type"::"Imprest Surrender":
                        if "No." <> xRec."No." then begin
                            NoSeriesMgt.TestManual(CashMgt."Imprest Surrender Nos");
                            "No. Series" := '';
                        end;
                    "Payment Type"::Receipt:
                        if "No." <> xRec."No." then begin
                            NoSeriesMgt.TestManual(CashMgt."Receipt Nos");
                            "No. Series" := '';
                        end;
                    "Payment Type"::"Bank Transfer":
                        if "No." <> xRec."No." then begin
                            NoSeriesMgt.TestManual(CashMgt."Bank Transfer Nos");
                            "No. Series" := '';
                        end;
                    "Payment Type"::"Staff Claim":
                        if "No." <> xRec."No." then begin
                            NoSeriesMgt.TestManual(CashMgt."Staff Claim Nos");
                            "No. Series" := '';
                        end;
                    "Payment Type"::"Input Tax":
                        if "No." <> xRec."No." then begin
                            NoSeriesMgt.TestManual(CashMgt."Input Tax Nos");
                            "No. Series" := '';
                        end;
                    "Payment Type"::"Property Expense":
                        if "No." <> xRec."No." then begin
                            NoSeriesMgt.TestManual(CashMgt."Property Expense Nos");
                            "No. Series" := '';
                        end;
                    "Payment Type"::"Property Expense Surrender":
                        if "No." <> xRec."No." then begin
                            NoSeriesMgt.TestManual(CashMgt."Property Expense Surrender Nos");
                            "No. Series" := '';
                        end;
                    "Payment Type"::"Property Expense Claim":
                        if "No." <> xRec."No." then begin
                            NoSeriesMgt.TestManual(CashMgt."Property Expense Claim Nos");
                            "No. Series" := '';
                        end;
                end;
            end;
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
            Editable = false;

            trigger OnValidate()
            begin
                /*
                 case "Payment Type" of
                  "Payment Type"::Imprest:
                    begin
                     //Get the Imprest Deadline Date
                     if not CashMgt.Get() then
                      Error(Text000);
                      CashMgt.TestField("Imprest Due Date");
                       if Date<>0D then
                        "Imprest Deadline":=CalcDate(CashMgt."Imprest Due Date",Date);
                    end;
                 end;
                 */
            end;
        }
        field(3; "Pay Code"; Code[10])
        {
            Caption = 'Pay Code';
        }
        field(4; "Pay Mode"; Code[20])
        {
            Caption = 'Pay Mode';
            TableRelation = "Payment Method";
        }
        field(5; "Cheque No"; Code[20])
        {
            Caption = 'Cheque No';
            TableRelation = if ("Cheque Type" = filter("Computer Check")) "Cheque Register"."Cheque No." where("Bank Account No." = field("Paying Bank Account"),
                                                                                                              Issued = const(false),
                                                                                                              Voided = const(false),
                                                                                                              Cancelled = const(false));

            trigger OnValidate()
            begin
                /*
                if "Cheque No"<>'' then begin
                PV.Reset();
                PV.SetRange(PV."Cheque No","Cheque No");
                if PV.Find('-') then begin
                if PV."No." <> "No." then
                   Error(Text002);
                end;
                end;
                */
                if "Cheque No" <> '' then
                    if "Cheque Type" = "Cheque Type"::"Computer Check" then
                        if Confirm('Are you sure you want to issue Cheque No. %1', false, "Cheque No") then begin
                            ChequeRegister.Reset();
                            ChequeRegister.SetRange(ChequeRegister."Cheque No.", "Cheque No");
                            if ChequeRegister.FindFirst() then begin
                                ChequeRegister."Entry Status" := ChequeRegister."Entry Status"::Issued;
                                ChequeRegister."Issued By" := CopyStr(UserId, 1, MaxStrLen(ChequeRegister."Issued By"));
                                ChequeRegister."Issued Doc No." := "No.";
                                ChequeRegister."Cheque Date" := "Cheque Date";
                                ChequeRegister.Issued := true;
                                ChequeRegister.Modify();
                            end;
                        end else
                            "Cheque No" := '';
            end;
        }
        field(6; "Cheque Date"; Date)
        {
            Caption = 'Cheque Date';
        }
        field(8; Payee; Text[250])
        {
            Caption = 'Payee';
        }
        field(9; "On behalf of"; Text[250])
        {
            Caption = 'On behalf of';
            Editable = false;
        }
        field(10; "Created By"; Code[50])
        {
            Caption = 'Created By';
            TableRelation = "User Setup"."User ID";
        }
        field(11; Posted; Boolean)
        {
            Caption = 'Posted';
        }
        field(12; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            Editable = true;
        }
        field(13; "Posted Date"; Date)
        {
            Caption = 'Posted Date';
            Editable = true;
        }
        field(14; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(15; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(16; "Time Posted"; Time)
        {
            Caption = 'Time Posted';
        }
        field(17; "Total Amount"; Decimal)
        {
            CalcFormula = sum("Payment Lines".Amount where(No = field("No.")));
            Caption = 'Total Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; "Paying Bank Account"; Code[20])
        {
            Caption = 'Paying Bank Account';
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                if Bank.Get("Paying Bank Account") then begin
                    "Bank Name" := Bank.Name;
                    Currency := Bank."Currency Code";

                    if CashMgt.Get() then
                        if CashMgt."Use Bank Pmt Doc Nos" then
                            Bank.TestField("Payment Document Nos");
                end;
            end;
        }
        field(19; Status; Option)
        {
            Caption = 'Status';
            Editable = true;
            OptionCaption = 'Open,Pending Approval,Pending Prepayment,Released,Rejected,,Closed,Archived';
            OptionMembers = Open,"Pending Approval","Pending Prepayment",Released,Rejected,,Closed,Archived;
        }
        field(20; "Payment Type"; Enum "Payments Mgt Type")
        {
            Caption = 'Payment Type';
        }
        field(21; Currency; Code[20])
        {
            Caption = 'Currency';
            TableRelation = Currency;

            trigger OnValidate()
            begin
                if "Payment Type" = "Payment Type"::"Bank Transfer" then
                    if Currency <> '' then begin
                        Validate("Receiving Bank Amount", (CurrExchRate.ExchangeAmtFCYToFCY(Today(), "Source Currency", CopyStr(Currency, 1, 10), "Source Bank Amount")));
                        "Exchange Rate" := Round("Receiving Bank Amount" / "Source Bank Amount", 0.0001, '=');
                    end else begin
                        CurrencyRec.InitRoundingPrecision();
                        "Receiving Bank Amount" := (Round(CurrExchRate.ExchangeAmtFCYToLCY(
                                                          Date, "Source Currency",
                                                          "Source Bank Amount", CurrExchRate.ExchangeRate(Date, "Source Currency")),
                                                          CurrencyRec."Amount Rounding Precision"));
                        Validate("Receiving Bank Amount");

                        if "Source Bank Amount" <> 0 then
                            "Exchange Rate" := Round("Receiving Bank Amount" / "Source Bank Amount", 0.0001, '=');
                    end;

                PaymentLine.Reset();
                PaymentLine.SetRange(No, "No.");
                if PaymentLine.FindSet() then
                    repeat
                        PaymentLine.Validate(Currency, Currency);
                        PaymentLine.Modify();
                    until PaymentLine.Next() = 0;
            end;
        }
        field(22; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(23; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
            Editable = true;
        }
        field(24; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Account Type" = const(Vendor)) Vendor;

            trigger OnValidate()
            begin
                case "Account Type" of
                    "Account Type"::"G/L Account":
                        begin
                            if GLAccount.Get("Account No.") then;
                            GLAccount.TestField("Direct Posting", true);
                            "Account Name" := GLAccount.Name;
                        end;
                    "Account Type"::Vendor:
                        begin
                            if Vendor.Get("Account No.") then;
                            Vendor.TestField(Blocked, Vendor.Blocked::" ");
                            "Account Name" := Vendor.Name;
                            Payee := Vendor.Name;
                        end;
                    "Account Type"::Customer:
                        begin
                            Customer.Get("Account No.");
                            Customer.TestField(Blocked, Customer.Blocked::" ");
                            "Account Name" := Customer.Name;

                            //Validate Employee details
                            UserSetup.Reset();
                            UserSetup.SetRange(UserSetup."Customer No.", "Account No.");
                            if UserSetup.FindFirst() then begin
                                if Customer.Get(UserSetup."Customer No.") then begin
                                    Customer.CalcFields("Balance (LCY)");
                                    if "Payment Type" = "Payment Type"::Imprest then
                                        if Customer."Balance (LCY)" > 0 then
                                            Error('You cannot apply for a new imprest because you have an outstanding balance of KES %1', Customer."Balance (LCY)");
                                end;
                                UserSetup.TestField("Employee No.");
                                "Staff No." := UserSetup."Employee No.";
                                //"Salary Scale" := GetSalaryScale("Staff No.");
                                "Responsibility Center" := UserSetup."Responsibility Centre";
                            end;
                        end;
                    "Account Type"::"Bank Account":
                        begin
                            Bank.Get("Account No.");
                            "Account Name" := Bank.Name;
                            Validate(Currency, Bank."Currency Code");
                        end;
                    "Account Type"::"Fixed Asset":
                        begin
                            FixedAsset.Get("Account No.");
                            "Account Name" := FixedAsset.Description;
                        end;
                end;
            end;
        }
        field(25; "Account Name"; Text[100])
        {
            Caption = 'Account Name';
        }
        field(26; "Imprest Amount"; Decimal)
        {
            CalcFormula = sum("Payment Lines".Amount where(No = field("No.")));
            Caption = 'Imprest Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; Surrendered; Boolean)
        {
            Caption = 'Surrendered';
        }
        field(28; "Applies- To Doc No."; Code[20])
        {
            Caption = 'Applies- To Doc No.';

            trigger OnLookup()
            begin
                /*

                case "Account Type" of
                  "Account Type"::Customer:

                   begin
                        CustLedger.Reset();
                        CustLedger.SetCurrentKey(CustLedger."Customer No.",Open,"Document No.");
                        CustLedger.SetRange(CustLedger."Customer No.","Account No.");
                        CustLedger.SetRange(Open,true);
                        CustLedger.CalcFields(CustLedger.Amount);
                       if Page.RunModal(25,CustLedger) = Action::LookupOK then begin

                        "Applies- To Doc No.":=CustLedger."Document No.";
                       end;
                      end;
                   end;
                   */
            end;
        }
        field(29; "Petty Cash Amount"; Decimal)
        {
            CalcFormula = sum("Payment Lines".Amount where(No = field("No.")));
            Caption = 'Petty Cash Amount';
            Editable = false;
            FieldClass = FlowField;
        }
#pragma warning disable AA0232
        field(33; "Remaining Amount"; Decimal)
#pragma warning restore AA0232
        {
            CalcFormula = sum("Payment Lines"."Remaining Amount" where(No = field("No.")));
            Caption = 'Remaining Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(34; "Receipt Created"; Boolean)
        {
            Caption = 'Receipt Created';
        }
        field(35; "Imprest Deadline"; Date)
        {
            Caption = 'Imprest Deadline';
            Editable = false;
        }
        field(36; "Surrender Date"; Date)
        {
            Caption = 'Surrender Date';
            Editable = true;
        }
        field(37; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(38; "Imprest Type"; Option)
        {
            Caption = 'Imprest Type';
            OptionCaption = 'Normal,Project Imprest';
            OptionMembers = Normal,"Project Imprest";
        }
        field(41; "Travel Date"; Date)
        {
            Caption = 'Travel Date';
        }
        field(42; Cashier; Text[50])
        {
            Caption = 'Cashier';
        }
        field(68; "Payment Release Date"; Date)
        {
            Caption = 'Payment Release Date';

            trigger OnValidate()
            begin
                if "Payment Release Date" <> 0D then
                    if PaymentLinesExist() then
                        ValidateLineCurrency();
            end;
        }
        field(69; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
        }
        field(81; "Surrender Status"; Option)
        {
            Caption = 'Surrender Status';
            OptionCaption = ' ,Full,Partial';
            OptionMembers = " ",Full,Partial;
        }
        field(82; "Departure Date"; Date)
        {
            Caption = 'Departure Date';
        }
        field(85; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            begin
                /*
                TestField(Status,Status::Pending);
                if not UserMgt.CheckRespCenter(1,"Shortcut Dimension 3 Code") then
                  Error(
                    Text001,
                    RespCenter.TableCaption,UserMgt.GetPurchasesFilter);

                */
                /*
               "Location Code" := UserMgt.GetLocation(1,'',"Responsibility Center");
               if "Location Code" = '' then begin
                 if InvtSetup.Get() then
                   "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
               end else begin
                 if Location.Get("Location Code") then;
                 "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";
               end;

               UpdateShipToAddress;
                  */
                /*
             CreateDim(
               Database::"Responsibility Center","Responsibility Center",
               Database::Vendor,"Pay-to Vendor No.",
               Database::"Salesperson/Purchaser","Purchaser Code",
               Database::Campaign,"Campaign No.");

             if xRec."Responsibility Center" <> "Responsibility Center" then begin
               RecreatePaymentLines(FieldCaption("Responsibility Center"));
               "Assigned User ID" := '';
             end;
               */
            end;
        }
        field(86; "Cheque Type"; Option)
        {
            Caption = 'Cheque Type';
            OptionCaption = ' ,Computer Check,Manual Check';
            OptionMembers = " ","Computer Check","Manual Check";
        }
        field(88; "Payment Narration"; Text[250])
        {
            Caption = 'Payment Narration';
        }
        field(89; "Total VAT Amount"; Decimal)
        {
            CalcFormula = sum("Payment Lines"."VAT Amount" where(No = field("No.")));
            Caption = 'Total VAT Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(90; "Total Witholding Tax Amount"; Decimal)
        {
            CalcFormula = sum("Payment Lines"."W/Tax Amount" where(No = field("No.")));
            Caption = 'Total Witholding Tax Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(91; "Total Net Amount"; Decimal)
        {
            CalcFormula = sum("Payment Lines"."Net Amount" where(No = field("No.")));
            Caption = 'Total Net Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(92; "Total Payment Amount LCY"; Decimal)
        {
            CalcFormula = sum("Payment Lines"."NetAmount LCY" where(No = field("No.")));
            Caption = 'Total Net Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(93; "Total Retention Amount"; Decimal)
        {
            CalcFormula = sum("Payment Lines"."Retention Amount" where(No = field("No.")));
            Caption = 'Total Retention Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(94; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(95; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(98; "Actual Amount Spent"; Decimal)
        {
            CalcFormula = sum("Payment Lines"."Actual Spent" where(No = field("No.")));
            Caption = 'Actual Amount Spent';
            Editable = false;
            FieldClass = FlowField;
        }
        field(99; "Cash Receipt Amount"; Decimal)
        {
            CalcFormula = sum("Payment Lines"."Cash Receipt Amount" where(No = field("No.")));
            Caption = 'Cash Receipt Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(100; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
        field(106; "Imprest Issue Doc. No"; Code[20])
        {
            Caption = 'Imprest Issue Doc. No';
            TableRelation = Payments."No." where("Payment Type" = const(Imprest),
                                                  Posted = const(true),
                                                  Surrendered = const(false));

            trigger OnValidate()
            begin
                CheckIfSurrenderExists("Imprest Issue Doc. No");

                if PaymentRec.Get("Imprest Issue Doc. No") then
                    if "Payment Type" = "Payment Type"::"Imprest Surrender" then begin
                        if PaymentRec.Surrendered then
                            Error(ImprestFullySurrenderedLbl, "Imprest Issue Doc. No");

                        "Account Type" := PaymentRec."Account Type";
                        "Account No." := PaymentRec."Account No.";
                        Validate("Account No.");
                        "Pay Mode" := PaymentRec."Pay Mode";
                        "Cheque No" := PaymentRec."Cheque No";
                        "Cheque Date" := PaymentRec."Cheque Date";
                        "Paying Bank Account" := PaymentRec."Paying Bank Account";
                        Currency := PaymentRec.Currency;
                        "Payment Narration" := PaymentRec."Payment Narration";
                        "Multi-Donor" := PaymentRec."Multi-Donor";
                        "Staff No." := PaymentRec."Staff No.";
                        "Payment Narration" := PaymentRec."Payment Narration";
                        Destination := PaymentRec.Destination;
                        "No of Days" := PaymentRec."No of Days";
                        "Date of Project" := PaymentRec."Date of Project";
                        "Date of Completion" := PaymentRec."Date of Completion";
                        "Due Date" := PaymentRec."Due Date";
                        "Posted Date" := PaymentRec."Posted Date";

                        "Shortcut Dimension 1 Code" := PaymentRec."Shortcut Dimension 1 Code";
                        Validate("Shortcut Dimension 1 Code");
                        "Shortcut Dimension 2 Code" := PaymentRec."Shortcut Dimension 2 Code";
                        Validate("Shortcut Dimension 2 Code");
                        "Dimension Set ID" := PaymentRec."Dimension Set ID";
                        "Shortcut Dimension 3 Code" := PaymentRec."Shortcut Dimension 3 Code";
                        Validate("Shortcut Dimension 3 Code");
                        Validate("Dimension Set ID");

                        PaymentLine.Reset();
                        PaymentLine.SetRange(No, PaymentRec."No.");
                        if PaymentLine.Find('-') then
                            repeat
                                ImpSurrLines.Init();
                                ImpSurrLines.TransferFields(PaymentLine);
                                ImpSurrLines."Payment Type" := ImpSurrLines."Payment Type"::"Imprest Surrender";
                                ImpSurrLines.No := "No.";
                                ImpSurrLines."Line No" := GetNextLineNo();
                                ImpSurrLines.Purpose := PaymentRec."Payment Narration";
                                ImpSurrLines.Insert();
                            until PaymentLine.Next() = 0;
                    end;
            end;
        }
        field(107; "Date Surrendered"; Date)
        {
            Caption = 'Date Surrendered';
        }
        field(108; "Surrendered By"; Code[50])
        {
            Caption = 'Surrendered By';
            TableRelation = "User Setup";
        }
        field(109; "Actual Petty Cash Amount Spent"; Decimal)
        {
            CalcFormula = sum("Payment Lines"."Actual Spent" where(No = field("No."),
                                                                    "Payment Type" = const("Petty Cash Surrender")));
            Caption = 'Actual Petty Cash Amount Spent';
            Editable = false;
            FieldClass = FlowField;
        }
        field(110; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(5, "Shortcut Dimension 5 Code");
            end;
        }
        field(111; "Remaining Petty Cash Amount"; Decimal)
        {
            CalcFormula = sum("Payment Lines"."Remaining Amount" where(No = field("No."),
                                                                        "Payment Type" = const("Petty Cash")));
            Caption = 'Remaining Petty Cash Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(112; "Receipted Petty Cash Amount"; Decimal)
        {
            CalcFormula = sum("Payment Lines"."Cash Receipt Amount" where(No = field("No."),
                                                                           "Payment Type" = const("Petty Cash Surrender")));
            Caption = 'Receipted Petty Cash Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(113; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(6, "Shortcut Dimension 6 Code");
            end;
        }
        field(114; "Shortcut Dimension 7 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code';
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(7, "Shortcut Dimension 7 Code");
            end;
        }
        field(115; "Shortcut Dimension 8 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(8, "Shortcut Dimension 8 Code");
            end;
        }
        field(116; "Petty Cash Issue Doc.No"; Code[20])
        {
            Caption = 'Petty Cash Issue Doc.No';
            TableRelation = Payments."No." where("Payment Type" = const("Petty Cash"),
                                                  Posted = const(true),
                                                  Surrendered = const(false));

            trigger OnValidate()
            begin

                if PaymentRec.Get("Petty Cash Issue Doc.No") then begin
                    if PaymentRec.Surrendered then
                        Error(PettyCashFullySurrenderedLbl, "Petty Cash Issue Doc.No");

                    "Account Type" := PaymentRec."Account Type";
                    "Account No." := PaymentRec."Account No.";
                    Validate("Account No.");
                    "Pay Mode" := PaymentRec."Pay Mode";
                    "Paying Bank Account" := PaymentRec."Paying Bank Account";
                    Validate("Paying Bank Account");
                    "Cheque No" := PaymentRec."Cheque No";
                    "Cheque Date" := PaymentRec."Cheque Date";
                    Currency := PaymentRec.Currency;
                    "Payment Narration" := PaymentRec."Payment Narration";
                    "Staff No." := PaymentRec."Staff No.";

                    "Shortcut Dimension 1 Code" := PaymentRec."Shortcut Dimension 1 Code";
                    Validate("Shortcut Dimension 1 Code");
                    "Shortcut Dimension 2 Code" := PaymentRec."Shortcut Dimension 2 Code";
                    Validate("Shortcut Dimension 2 Code");
                    "Dimension Set ID" := PaymentRec."Dimension Set ID";
                    "Shortcut Dimension 3 Code" := PaymentRec."Shortcut Dimension 3 Code";
                    Validate("Shortcut Dimension 3 Code");

                    PaymentLine.Reset();
                    //PaymentLine.SETRANGE("Payment Type",PaymentRec."Payment Type"::"Petty Cash");
                    PaymentLine.SetRange(No, PaymentRec."No.");
                    if PaymentLine.Find('-') then
                        repeat
                            //LineNo := LineNo + 10000;
                            ImpSurrLines.Init();
                            ImpSurrLines.TransferFields(PaymentLine);
                            GetNextLineNo();
                            ImpSurrLines."Line No" := GetNextLineNo();
                            ImpSurrLines."Payment Type" := ImpSurrLines."Payment Type"::"Petty Cash Surrender";
                            ImpSurrLines.No := "No.";
                            ImpSurrLines.Purpose := PaymentLine.Description;
                            //ImpSurrLines."Actual Spent":=PaymentLine.Amount;
                            // if not PaymentRec."Multi-Donor" then begin
                            //     ImpSurrLines."Shortcut Dimension 1 Code" := PaymentRec."Shortcut Dimension 1 Code";
                            //     Validate("Shortcut Dimension 1 Code");
                            //     ImpSurrLines."Shortcut Dimension 2 Code" := PaymentRec."Shortcut Dimension 2 Code";
                            //     Validate("Shortcut Dimension 2 Code");
                            //     ImpSurrLines.Purpose := PaymentRec."Payment Narration";
                            // end else begin
                            //     ImpSurrLines."Shortcut Dimension 1 Code" := PaymentLine."Shortcut Dimension 1 Code";
                            //     Validate("Shortcut Dimension 1 Code");
                            //     ImpSurrLines."Shortcut Dimension 2 Code" := PaymentLine."Shortcut Dimension 2 Code";
                            //     Validate("Shortcut Dimension 2 Code");
                            //     ImpSurrLines."Shortcut Dimension 3 Code" := PaymentLine."Shortcut Dimension 3 Code";
                            //     Validate("Shortcut Dimension 3 Code");
                            //     ImpSurrLines.Purpose := PaymentLine.Description;
                            // end;

                            // Validate("Dimension Set ID");
                            // if not ImpSurrLines.Get(ImpSurrLines.No, ImpSurrLines."Line No") then
                            //     ImpSurrLines.Insert
                            // else begin
                            //ImpSurrLines.Reset;
                            //     ImpSurrLines.SetRange("Payment Type", ImpSurrLines."Payment Type"::"Petty Cash Surrender");
                            //     ImpSurrLines.SetRange(No, "No.");
                            //     ImpSurrLines.SetRange("Line No", PaymentLine."Line No");
                            //     if ImpSurrLines.Find('-') then begin
                            //         ImpSurrLines.TransferFields(PaymentLine);
                            //         ImpSurrLines."Payment Type" := ImpSurrLines."Payment Type"::"Petty Cash Surrender";
                            //         ImpSurrLines.No := "No.";
                            //         //ImpSurrLines."Actual Spent":=PaymentLine.Amount;
                            //         ImpSurrLines.Modify;
                            //     end;
                            // end;
                            ImpSurrLines.Insert();
                        until PaymentLine.Next() = 0;
                end;
            end;
        }
        field(117; "Petty Cash Net Amount"; Decimal)
        {
            CalcFormula = sum("Payment Lines"."Net Amount" where(No = field("No."),
                                                                  "Payment Type" = filter("Petty Cash" | "Petty Cash Surrender")));
            Caption = 'Petty Cash Net Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(118; "Multi-Donor"; Boolean)
        {
            Caption = 'Multi-Donor';

            trigger OnValidate()
            begin
                if not "Multi-Donor" then
                    if PaymentLinesExist() then
                        if Confirm(DisableMultiDonorProceedLbl, false) then
                            DeletePaymentLines()
                        else
                            "Multi-Donor" := true;
            end;
        }
        field(119; "Received From"; Text[100])
        {
            Caption = 'Received From';

            trigger OnValidate()
            begin
                "On behalf of" := "Received From";
            end;
        }
        field(120; "Receipt Amount"; Decimal)
        {
            CalcFormula = sum("Payment Lines".Amount where(No = field("No.")));
            Caption = 'Receipt Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(121; "Imp Surr Receipt Amount"; Decimal)
        {
            CalcFormula = sum("Payment Lines"."Cash Receipt Amount" where(No = field("Imprest Surrender Doc. No")));
            Caption = 'Imp Surr Receipt Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(122; "Imprest Surrender Doc. No"; Code[20])
        {
            Caption = 'Imprest Surrender Doc. No';
            TableRelation = Payments."No." where("Payment Type" = const("Imprest Surrender"),
                                                  Posted = const(false));

            trigger OnValidate()
            begin
                if PaymentRec.Get("Imprest Surrender Doc. No") then
                    if "Payment Type" = "Payment Type"::"Imprest Surrender" then begin
                        if PaymentRec.Surrendered then
                            Error(ImprestFullySurrenderedLbl, "Imprest Issue Doc. No");

                        "Account Type" := PaymentRec."Account Type";
                        "Account No." := PaymentRec."Account No.";
                        Validate("Account No.");
                        "Pay Mode" := PaymentRec."Pay Mode";
                        "Cheque No" := PaymentRec."Cheque No";
                        "Cheque Date" := PaymentRec."Cheque Date";
                        "Paying Bank Account" := PaymentRec."Paying Bank Account";
                        Currency := PaymentRec.Currency;
                        "Payment Narration" := PaymentRec."Payment Narration";
                        "Multi-Donor" := PaymentRec."Multi-Donor";

                        Validate("Paying Bank Account");

                        "Shortcut Dimension 1 Code" := PaymentRec."Shortcut Dimension 1 Code";
                        Validate("Shortcut Dimension 1 Code");
                        "Shortcut Dimension 2 Code" := PaymentRec."Shortcut Dimension 2 Code";
                        Validate("Shortcut Dimension 2 Code");
                        "Dimension Set ID" := PaymentRec."Dimension Set ID";
                        Validate("Dimension Set ID");

                        PaymentLine.Reset();
                        PaymentLine.SetRange(No, PaymentRec."No.");
                        if PaymentLine.Find('-') then
                            repeat
                                ImpSurrLines.Init();
                                ImpSurrLines.TransferFields(PaymentLine);
                                ImpSurrLines."Payment Type" := ImpSurrLines."Payment Type"::"Imprest Surrender";
                                ImpSurrLines.No := "No.";
                                //ImpSurrLines."Actual Spent":=PaymentLine.Amount;
                                if "Multi-Donor" = true then begin
                                    ImpSurrLines."Shortcut Dimension 1 Code" := PaymentLine."Shortcut Dimension 1 Code";
                                    Validate("Shortcut Dimension 1 Code");
                                    ImpSurrLines."Shortcut Dimension 2 Code" := PaymentLine."Shortcut Dimension 2 Code";
                                    Validate("Shortcut Dimension 2 Code");
                                end else begin
                                    ImpSurrLines."Shortcut Dimension 1 Code" := PaymentRec."Shortcut Dimension 1 Code";
                                    Validate("Shortcut Dimension 1 Code");
                                    ImpSurrLines."Shortcut Dimension 2 Code" := PaymentRec."Shortcut Dimension 2 Code";
                                    Validate("Shortcut Dimension 2 Code");
                                end;
                                Validate("Dimension Set ID");
                                ImpSurrLines.Purpose := PaymentLine.Description;

                                if not ImpSurrLines.Get(ImpSurrLines.No, ImpSurrLines."Line No") then
                                    ImpSurrLines.Insert()
                                else begin
                                    ImpSurrLines.Reset();
                                    ImpSurrLines.SetRange("Payment Type", ImpSurrLines."Payment Type"::"Imprest Surrender");
                                    ImpSurrLines.SetRange(No, "No.");
                                    ImpSurrLines.SetRange("Line No", PaymentLine."Line No");
                                    if ImpSurrLines.Find('-') then begin
                                        ImpSurrLines.TransferFields(PaymentLine);
                                        ImpSurrLines."Payment Type" := ImpSurrLines."Payment Type"::"Imprest Surrender";
                                        ImpSurrLines.No := "No.";
                                        ImpSurrLines.Modify();
                                    end;
                                end;
                            until PaymentLine.Next() = 0;
                    end;
            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDocDim();
            end;
        }
        field(50000; "Withheld VAT"; Decimal)
        {
            CalcFormula = sum("Payment Lines"."W/T VAT Amount" where(No = field("No."),
                                                                      "Payment Type" = const("Payment Voucher")));
            Caption = 'Withheld VAT';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "Bank Name"; Text[100])
        {
            CalcFormula = lookup("Bank Account".Name where("No." = field("Paying Bank Account")));
            Caption = 'Bank Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50018; "Notification Sent"; Boolean)
        {
            Caption = 'Notification Sent';
        }
        field(50019; "DateTime Sent"; DateTime)
        {
            Caption = 'DateTime Sent';
        }
        field(50020; "Vendor Entry No"; Integer)
        {
            CalcFormula = lookup("Vendor Ledger Entry"."Entry No." where("Document No." = field("No.")));
            Caption = 'Vendor Entry No';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50021; "User Id"; Code[30])
        {
            Caption = 'User Id';
            TableRelation = "User Setup";
        }
        field(50022; "User Department"; Code[20])
        {
            Caption = 'User Department';
            Editable = false;
            FieldClass = Normal;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7));
        }
        field(50023; "HOD Comments"; Text[100])
        {
            Caption = 'HOD Comments';
        }
        field(50024; "Finance Comments"; Text[200])
        {
            Caption = 'Finance Comments';
        }
        field(50025; "HOD Approver"; Code[20])
        {
            Caption = 'HOD Approver';
        }
        field(50026; "Finance Approver"; Code[200])
        {
            Caption = 'Finance Approver';
        }
        field(50027; "ISD Department"; Option)
        {
            Caption = 'ISD Department';
            Editable = false;
            FieldClass = Normal;
            OptionCaption = ' ,ISD Support,ISD Programs';
            OptionMembers = " ","ISD Support","ISD Programs";
        }
        field(50028; "Time Inserted"; Time)
        {
            Caption = 'Time Inserted';
        }
        field(50029; "Levied Invoice"; Boolean)
        {
            Caption = 'Levied Invoice';
        }
        field(50030; "Cash Receipt No. Surr"; Code[20])
        {
            CalcFormula = lookup("Payment Lines"."Imprest Receipt No." where(No = field("No.")));
            Caption = 'Cash Receipt No. Surr';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50031; "Staff No."; Code[20])
        {
            Caption = 'Staff No.';
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                UserSetup.Reset();
                UserSetup.SetRange("Employee No.", "Staff No.");
                if not UserSetup.FindFirst() then
                    Error('There is no user setup for Staff No. %1', "Staff No.")
                else begin
                    UserSetup.TestField("Customer No.");
                    UserSetup.TestField("Responsibility Centre");
                    if Customer.Get(UserSetup."Customer No.") then begin
                        Customer.CalcFields("Balance (LCY)");
                        if "Payment Type" = "Payment Type"::Imprest then
                            if Customer."Balance (LCY)" > 0 then
                                Error('You cannot apply for a new imprest because you have an outstanding balance of KES %1', Customer."Balance (LCY)");
                    end;
                    "Account No." := UserSetup."Customer No.";
                    Validate("Account No.");
                    //"Salary Scale" := GetSalaryScale("Staff No.");
                    "Responsibility Center" := UserSetup."Responsibility Centre";

                    //MaxNo := GetJobGroupImprests("Staff No.");

                    PaymentRec.Reset();
                    PaymentRec.SetRange(PaymentRec."Payment Type", "Payment Type");
                    PaymentRec.SetRange(Posted, true);
                    PaymentRec.SetRange(Surrendered, false);
                    PaymentRec.SetRange(Cashier, UserId);
                    /* if PaymentRec.Count >= MaxNo then
                        Error(AccountError, Format("Payment Type")); */
                end;
            end;
        }
        field(50032; "Date of Project"; Date)
        {
            Caption = 'Date of Project';

            trigger OnValidate()
            begin
                if ("Payment Type" in ["Payment Type"::Imprest]) and ("Date of Project" < Today) then
                    Error('Start Date %1 can not be less than Today - %2', "Date of Project", Today);

                if "No of Days" <> 0 then
                    Validate("No of Days");
            end;
        }
        field(50033; "Date of Completion"; Date)
        {
            Caption = 'Date of Completion';

            trigger OnValidate()
            begin
                CashMgt.Get();
                CashMgt.TestField("Imprest Due Date");
                "Due Date" := CalcDate(CashMgt."Imprest Due Date", "Date of Completion");

                //Get no of days
                "No of Days" := ("Date of Completion" - "Date of Project");
            end;
        }
        field(50034; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(50035; "No of Days"; Integer)
        {
            Caption = 'No of Days';

            trigger OnValidate()
            begin
                CompletionDateFormula := Format("No of Days") + 'D';

                /*if "Date of Project"<>0D then
                  begin
                    "Date of Completion":=CalcDate(CompletionDateFormula,"Date of Project");
                    if "Date of Completion"<>0D then
                      Validate("Date of Completion");
                  end;

                if "Payment Type"="Payment Type"::Imprest then
                  begin
                    PaymentLine.Reset();
                    PaymentLine.SetRange(PaymentLine.No,"No.");
                    if PaymentLine.Find('-') then
                      begin
                        repeat
                          PaymentLine."No of Days":="No of Days";
                          PaymentLine.Modify();

                          if PaymentLine."Expenditure Type"<>'' then
                            PaymentLine.Validate("Expenditure Type");
                        until PaymentLine.Next()=0;
                      end;
                  end;
                  */
            end;
        }
        field(50036; Destination; Code[20])
        {
            Caption = 'Destination';
            TableRelation = Destination."Destination Code";

            trigger OnValidate()
            begin
                if not "Apply on behalf" then begin
                    TestField(Cashier);
                    GetStaffNo(Cashier);
                end;
            end;
        }
        field(50037; "Receiving Bank Amount"; Decimal)
        {
            Caption = 'Receiving Bank Amount';

            trigger OnValidate()
            begin
                CurrencyRec.InitRoundingPrecision();

                if Currency = '' then
                    "Receiving Amount LCY" := Round("Receiving Bank Amount", CurrencyRec."Amount Rounding Precision")
                else
                    "Receiving Amount LCY" := Round(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          Date, CopyStr(Currency, 1, 10),
                          "Receiving Bank Amount", CurrExchRate.ExchangeRate(Date, CopyStr(Currency, 1, 10))),
                          CurrencyRec."Amount Rounding Precision");
            end;
        }
        field(50038; "Source Bank"; Code[20])
        {
            Caption = 'Source Bank';
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                if Bank.Get("Source Bank") then begin
                    "Source Currency" := Bank."Currency Code";
                    Validate("Source Currency");
                end;
            end;
        }
        field(50039; "Source Currency"; Code[10])
        {
            Caption = 'Source Currency';
            TableRelation = Currency.Code;

            trigger OnValidate()
            begin
                if "Source Bank Amount" <> 0 then
                    Validate("Source Bank Amount");
            end;
        }
        field(50040; "Source Bank Amount"; Decimal)
        {
            Caption = 'Source Bank Amount';

            trigger OnValidate()
            begin
                CurrencyRec.InitRoundingPrecision();

                if "Source Currency" = '' then
                    "Source Amount LCY" := Round("Source Bank Amount", CurrencyRec."Amount Rounding Precision")
                else
                    "Source Amount LCY" := Round(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          Date, "Source Currency",
                          "Source Bank Amount", CurrExchRate.ExchangeRate(Date, "Source Currency")),
                          CurrencyRec."Amount Rounding Precision");

                if "Transfer Type" = "Transfer Type"::"Multiple Banks" then begin
                    PaymentLine.SetRange(No, "No.");
                    PaymentLine.SetRange("Payment Type", "Payment Type");
                    if PaymentLine.FindSet() then
                        repeat
                            if PaymentLine.Currency <> '' then begin
                                PaymentLine.Validate(Amount, CurrExchRate.ExchangeAmtFCYToFCY(Today(), "Source Currency", CopyStr(PaymentLine.Currency, 1, 10), "Source Bank Amount"));
                                PaymentLine.Modify();
                            end;
                        until PaymentLine.Next() = 0;
                end else
                    if "Account No." <> '' then
                        Validate("Account No.");
            end;
        }
        field(50041; "Receiving Amount LCY"; Decimal)
        {
            Caption = 'Receiving Amount LCY';
        }
        field(50042; "Source Amount LCY"; Decimal)
        {
            Caption = 'Source Amount LCY';
        }
        field(50043; "Procurement Plan"; Code[15])
        {
            Caption = 'Procurement Plan';
        }
        field(50044; "Check Printed"; Boolean)
        {
            Caption = 'Check Printed';
        }
        field(50045; "EFT File Generated"; Boolean)
        {
            Caption = 'EFT File Generated';
        }
        field(50046; "EFT Reference"; Text[30])
        {
            Caption = 'EFT Reference';
        }
        field(50047; "Imprest Receipt"; Boolean)
        {
            Caption = 'Imprest Receipt';

            trigger OnValidate()
            begin
                if "Imprest Receipt" = true then
                    "Account Type" := "Account Type"::Customer;
            end;
        }
        field(50048; "Direct Expense"; Boolean)
        {
            Caption = 'Direct Expense';
        }
        field(50049; "Travel Type"; Option)
        {
            Caption = 'Travel Type';
            OptionCaption = 'Local,Foreign';
            OptionMembers = "Local",Foreign;
        }
        field(50050; "Total Witholding VAT Tax"; Decimal)
        {
            CalcFormula = sum("Payment Lines"."W/T VAT Amount" where(No = field("No.")));
            Caption = 'Total Witholding VAT Tax';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50051; "Payee PIN"; Code[15])
        {
            Caption = 'Payee PIN';
        }
        field(50052; "Claim Type"; Option)
        {
            Caption = 'Claim Type';
            OptionCaption = ' ,General Claim,Medical Claim,Imprest Claim';
            OptionMembers = " ","General Claim","Medical Claim",Imprest;

            trigger OnValidate()
            begin
                if "Payment Type" = "Payment Type"::"Staff Claim" then
                    if "Claim Type" = "Claim Type"::Imprest then
                        if HasImprestAccountBalance("Account No.") then
                            Error('You have an outstanding imprest balance of KES %1', ImpBalance);
            end;
        }
        field(50053; "Gen. Posting Type"; Option)
        {
            Caption = 'Gen. Posting Type';
            OptionCaption = ' ,Purchase,Sale,Settlement';
            OptionMembers = " ",Purchase,Sale,Settlement;

            trigger OnValidate()
            begin
                // IF "Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Bank Account"] THEN
                //  TESTFIELD("Gen. Posting Type","Gen. Posting Type"::" ");
                // IF ("Gen. Posting Type" = "Gen. Posting Type"::Settlement) AND (CurrFieldNo <> 0) THEN
                //  ERROR(Text006,"Gen. Posting Type");
                // CheckVATInAlloc;
                // IF "Gen. Posting Type" > 0 THEN
                //  VALIDATE("VAT Prod. Posting Group");
                // IF "Gen. Posting Type" <> "Gen. Posting Type"::Purchase THEN
                //  VALIDATE("Use Tax",FALSE)
            end;
        }
        field(50054; "Imprest Surrender Receipt"; Boolean)
        {
            Caption = 'Imprest Surrender Receipt';
        }
        field(50055; "Imprest Posted by PV"; Code[20])
        {
            Caption = 'Imprest Posted by PV';
        }
        field(50056; "EFT Date"; Date)
        {
            Caption = 'EFT Date';
        }
        field(50057; "RTGS Date"; Date)
        {
            Caption = 'RTGS Date';
        }
        field(50058; "Salary Scale"; Code[10])
        {
            Caption = 'Salary Scale';
        }
        field(50059; "Transfer Type"; Enum "Bank Transfer Type")
        {
            Caption = 'Transfer Type';
        }
        field(50060; "Petty Cash Amount (LCY)"; Decimal)
        {
            CalcFormula = sum("Payment Lines"."Amount (LCY)" where(No = field("No.")));
            Caption = 'Petty Cash Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60000; "Asset Type"; Option)
        {
            Caption = 'Asset Type';
            OptionCaption = ' ,Money Market,Property,Equity,Bond,Mortgage,Unit Trust,Forex';
            OptionMembers = " ","Money Market",Property,Equity,Bond,Mortgage,"Unit Trust",Forex;
        }
        field(60001; "TPS Invoice No."; Code[20])
        {
            Caption = 'TPS Invoice No.';
        }
        field(60002; "TPS Loan No."; Code[20])
        {
            Caption = 'TPS Loan No.';
        }
        field(60003; "Remove from Schedule"; Boolean)
        {
            Caption = 'Remove from Schedule';
        }
        field(60004; PRN; Code[20])
        {
            Caption = 'PRN';
        }
        field(60005; "Date Created"; Date)
        {
            Caption = 'Date Created';
        }
        field(60006; "PV Type"; Option)
        {
            Caption = 'PV Type';
            OptionMembers = Normal,Pension;
        }
        field(60007; Apportion; Boolean)
        {
            Caption = 'Apportion';

            trigger OnValidate()
            begin
                TestField("No Apportion", false);

                //Check If Applied Invoice is Apportioned
                Apportionment.CheckIfInvoiceApportioned("No.");
            end;
        }
        field(60008; "Deposit Receipt"; Boolean)
        {
            Caption = 'Deposit Receipt';
        }
        field(60009; "Property Expense Doc. No"; Code[20])
        {
            Caption = 'Property Expense Doc. No.';
            TableRelation = Payments."No." where("Payment Type" = const("Property Expense"),
                                                  Posted = const(true),
                                                  Surrendered = const(false));

            trigger OnValidate()
            begin
                //CheckIfSurrenderExists("Imprest Issue Doc. No");

                if PaymentRec.Get("Property Expense Doc. No") then
                    if "Payment Type" = "Payment Type"::"Property Expense Surrender" then begin
                        if PaymentRec.Surrendered then
                            Error(ImprestFullySurrenderedLbl, "Imprest Issue Doc. No");

                        "Account Type" := PaymentRec."Account Type";
                        "Account No." := PaymentRec."Account No.";
                        Validate("Account No.");
                        "Pay Mode" := PaymentRec."Pay Mode";
                        "Cheque No" := PaymentRec."Cheque No";
                        "Cheque Date" := PaymentRec."Cheque Date";
                        "Paying Bank Account" := PaymentRec."Paying Bank Account";
                        Currency := PaymentRec.Currency;
                        "Payment Narration" := PaymentRec."Payment Narration";
                        "Multi-Donor" := PaymentRec."Multi-Donor";
                        "Staff No." := PaymentRec."Staff No.";
                        "Payment Narration" := PaymentRec."Payment Narration";
                        Destination := PaymentRec.Destination;
                        "No of Days" := PaymentRec."No of Days";
                        "Date of Project" := PaymentRec."Date of Project";
                        "Date of Completion" := PaymentRec."Date of Completion";
                        "Due Date" := PaymentRec."Due Date";
                        "Posted Date" := PaymentRec."Posted Date";

                        "Shortcut Dimension 1 Code" := PaymentRec."Shortcut Dimension 1 Code";
                        Validate("Shortcut Dimension 1 Code");
                        "Shortcut Dimension 2 Code" := PaymentRec."Shortcut Dimension 2 Code";
                        Validate("Shortcut Dimension 2 Code");
                        "Dimension Set ID" := PaymentRec."Dimension Set ID";
                        "Shortcut Dimension 3 Code" := PaymentRec."Shortcut Dimension 3 Code";
                        Validate("Shortcut Dimension 3 Code");
                        Validate("Dimension Set ID");

                        PaymentLine.Reset();
                        //PaymentLine.SETRANGE("Payment Type",PaymentRec."Payment Type"::Imprest);
                        PaymentLine.SetRange(No, PaymentRec."No.");
                        if PaymentLine.Find('-') then
                            repeat

                                ImpSurrLines.Init();
                                ImpSurrLines.TransferFields(PaymentLine);
                                ImpSurrLines."Payment Type" := ImpSurrLines."Payment Type"::"Property Expense Surrender";
                                ImpSurrLines.No := "No.";
                                if "Multi-Donor" = true then begin
                                    ImpSurrLines."Shortcut Dimension 1 Code" := PaymentLine."Shortcut Dimension 1 Code";
                                    Validate("Shortcut Dimension 1 Code");
                                    ImpSurrLines."Shortcut Dimension 2 Code" := PaymentLine."Shortcut Dimension 2 Code";
                                    Validate("Shortcut Dimension 2 Code");
                                end else begin
                                    ImpSurrLines."Shortcut Dimension 1 Code" := PaymentRec."Shortcut Dimension 1 Code";
                                    Validate("Shortcut Dimension 1 Code");
                                    ImpSurrLines."Shortcut Dimension 2 Code" := PaymentRec."Shortcut Dimension 2 Code";
                                    Validate("Shortcut Dimension 2 Code");
                                    Validate("Shortcut Dimension 3 Code");
                                end;
                                Validate("Dimension Set ID");
                                ImpSurrLines.Purpose := PaymentRec."Payment Narration";

                                if not ImpSurrLines.Get(ImpSurrLines.No, ImpSurrLines."Line No") then
                                    ImpSurrLines.Insert()
                                else begin
                                    ImpSurrLines.Reset();
                                    ImpSurrLines.SetRange("Payment Type", ImpSurrLines."Payment Type"::"Property Expense Surrender");
                                    ImpSurrLines.SetRange(No, "No.");
                                    ImpSurrLines.SetRange("Line No", PaymentLine."Line No");
                                    if ImpSurrLines.Find('-') then begin
                                        ImpSurrLines.TransferFields(PaymentLine);
                                        ImpSurrLines."Payment Type" := ImpSurrLines."Payment Type"::"Property Expense Surrender";
                                        ImpSurrLines.No := "No.";
                                        ImpSurrLines.Modify();
                                    end;
                                end;
                            until PaymentLine.Next() = 0;
                    end;
            end;
        }
        field(60010; "Payroll Transfered"; Boolean)
        {
            Caption = 'Payroll Transfered';
            Editable = false;
        }
        field(60011; "No Apportion"; Boolean)
        {
            Caption = 'No';

            trigger OnValidate()
            begin
                TestField(Apportion, false);
            end;
        }
        field(60012; "Vendor Name"; Text[50])
        {
            Caption = 'Vendor Name';
        }
        field(60013; "Property Expense Pmt"; Boolean)
        {
            Caption = 'Property Expense Pmt';
        }
        field(60014; "Confirm Receipt"; Boolean)
        {
            Caption = 'Confirm Receipt';

            trigger OnValidate()
            begin
            end;
        }
        field(60015; "Apply on behalf"; Boolean)
        {
            Caption = 'Apply on behalf';
        }
        field(60016; "Confirm Receipt User"; Code[50])
        {
            Caption = 'Confirm Receipt User';
        }
        field(60017; "Confirm Receipt Date-Time"; DateTime)
        {
            Caption = 'Confirm Receipt Date-Time';
        }
        field(60018; TrainingNo; Code[20])
        {
            Caption = 'TrainingNo';
        }
        field(60019; "Payment Advice Sent"; Boolean)
        {
            Caption = 'Payment Advice Sent';
        }
        field(60020; "Posted Document No."; Code[20])
        {
            Caption = 'Posted Document No.';
        }
        field(60021; "Total Amount (LCY)"; Decimal)
        {
            CalcFormula = sum("Payment Lines"."Amount (LCY)" where(No = field("No.")));
            Caption = 'Total Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60022; "Exchange Rate"; Decimal)
        {
            Caption = 'Exchange Rate';
            DecimalPlaces = 0 : 18;
            trigger OnValidate()
            begin
                Validate("Receiving Bank Amount", "Source Bank Amount" * "Exchange Rate");
                Validate("Source Amount LCY", "Receiving Amount LCY");
            end;
        }
        field(60023; "Petty Cash Type"; Enum "Petty Cash Type")
        {
            Caption = 'Petty Cash Type';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Account Name", Currency)
        {
        }
    }

    var
        Bank: Record "Bank Account";
        CashMgt: Record "Cash Management Setups";
        ChequeRegister: Record "Cheque Register";
        CurrencyRec: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        Customer: Record Customer;
        FixedAsset: Record "Fixed Asset";
        GLAccount: Record "G/L Account";
        GeneralLedgerSetup: Record "General Ledger Setup";
        ImpSurrLines: Record "Payment Lines";
        PaymentLine: Record "Payment Lines";
        PaymentRec: Record Payments;
        UserSetup: Record "User Setup";
        Vendor: Record Vendor;
        Apportionment: Codeunit Apportionment;
        DimMgt: Codeunit DimensionManagement;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ImpBalance: Decimal;
        MultiDocErrorErr: Label 'Kindly utilize your open documents before creating a new one';
        NoUserAccErr: Label 'You do not have a user account. Please contact the system administrator.';
        SurrExistsErrorErr: Label 'Imprest issued document %1 has been used in another Imprest Surrender document %2', Comment = '%1 = Imprest Issue Doc. No, %2 = Imprest Surrender Doc. No';
        ImprestFullySurrenderedLbl: Label 'The imprest %1 has been fully surrendered', Comment = '%1 = Imprest Issue Doc. No';
        PettyCashFullySurrenderedLbl: Label 'The petty cash %1 has been fully surrendered', Comment = '%1 = Petty Cash Doc. No';
        DisableMultiDonorProceedLbl: Label 'By disabling Multi-Donor the dimensions on the lines shall be reset \ You wish to proceed?';
        ChangedDimLbl: Label 'You may have changed a dimension.\\Do you want to update the lines?';
        CompletionDateFormula: Text;

    trigger OnInsert()
    begin
        CashMgt.Get();
        CashMgt.TestField("Max Open Documents");
        GeneralLedgerSetup.Get();

        case "Payment Type" of
            "Payment Type"::"Payment Voucher":
                begin
                    CheckPendingDocs("Payment Type", CashMgt."Max Open Documents");
                    CashMgt.TestField("PV Nos");
                    if "No." = '' then
                        NoSeriesMgt.InitSeries(CashMgt."PV Nos", xRec."No. Series", 0D, "No.", "No. Series");
                end;

            "Payment Type"::Imprest:
                begin
                    CashMgt.TestField("Max Imprests Unsurrendered");
                    CheckPendingDocs("Payment Type", CashMgt."Max Open Documents");
                    CashMgt.TestField("Imprest Nos");
                    if "No." = '' then
                        NoSeriesMgt.InitSeries(CashMgt."Imprest Nos", xRec."No. Series", 0D, "No.", "No. Series");
                    InsertUserAccount();
                    CheckUnsurrenderedDoc("Payment Type");
                end;

            "Payment Type"::"Petty Cash":
                begin
                    CheckPendingDocs("Payment Type", CashMgt."Max Open Documents");
                    CashMgt.TestField("Petty Cash Nos");
                    if "No." = '' then
                        NoSeriesMgt.InitSeries(CashMgt."Petty Cash Nos", xRec."No. Series", 0D, "No.", "No. Series");
                    //Currency:=GeneralLedgerSetup."LCY Code";
                    InsertUserAccount();
                    CheckUnsurrenderedDoc("Payment Type");
                end;

            "Payment Type"::"Petty Cash Surrender":
                begin
                    CheckPendingDocs("Payment Type", CashMgt."Max Open Documents");
                    CashMgt.TestField("Petty Cash Surrender Nos");
                    if "No." = '' then
                        NoSeriesMgt.InitSeries(CashMgt."Petty Cash Surrender Nos", xRec."No. Series", 0D, "No.", "No. Series");
                    InsertUserAccount();
                end;

            "Payment Type"::"Imprest Surrender":
                begin
                    CheckPendingDocs("Payment Type", CashMgt."Max Open Documents");
                    CashMgt.TestField(CashMgt."Imprest Surrender Nos");
                    if "No." = '' then
                        NoSeriesMgt.InitSeries(CashMgt."Imprest Surrender Nos", xRec."No. Series", 0D, "No.", "No. Series");
                    InsertUserAccount();
                    "Surrender Date" := Today;
                end;

            "Payment Type"::"Bank Transfer":
                begin
                    CashMgt.TestField(CashMgt."Bank Transfer Nos");
                    if "No." = '' then
                        NoSeriesMgt.InitSeries(CashMgt."Bank Transfer Nos", xRec."No. Series", 0D, "No.", "No. Series");
                end;

            "Payment Type"::Receipt:
                begin
                    CashMgt.TestField(CashMgt."Receipt Nos");
                    if "No." = '' then
                        NoSeriesMgt.InitSeries(CashMgt."Receipt Nos", xRec."No. Series", 0D, "No.", "No. Series");
                end;

            "Payment Type"::"Staff Claim":
                begin
                    CheckPendingDocs("Payment Type", CashMgt."Max Open Documents");
                    CashMgt.TestField(CashMgt."Staff Claim Nos");
                    if "No." = '' then
                        NoSeriesMgt.InitSeries(CashMgt."Staff Claim Nos", xRec."No. Series", 0D, "No.", "No. Series");
                    InsertUserAccount();
                end;

            "Payment Type"::"Input Tax":
                begin
                    CashMgt.TestField(CashMgt."Input Tax Nos");
                    if "No." = '' then
                        NoSeriesMgt.InitSeries(CashMgt."Input Tax Nos", xRec."No. Series", 0D, "No.", "No. Series");
                end;

            "Payment Type"::"Property Expense":
                begin
                    CashMgt.TestField("Property Expense Nos");
                    if "No." = '' then
                        NoSeriesMgt.InitSeries(CashMgt."Property Expense Nos", xRec."No. Series", 0D, "No.", "No. Series");
                    InsertUserAccount();
                end;

            "Payment Type"::"Property Expense Surrender":
                begin
                    CashMgt.TestField("Property Expense Surrender Nos");
                    if "No." = '' then
                        NoSeriesMgt.InitSeries(CashMgt."Property Expense Surrender Nos", xRec."No. Series", 0D, "No.", "No. Series");
                    InsertUserAccount();
                    "Surrender Date" := Today;
                end;

            "Payment Type"::"Property Expense Claim":
                begin
                    CashMgt.TestField("Property Expense Claim Nos");
                    if "No." = '' then
                        NoSeriesMgt.InitSeries(CashMgt."Property Expense Claim Nos", xRec."No. Series", 0D, "No.", "No. Series");
                    InsertUserAccount();
                    "Surrender Date" := Today;
                end;
        end;

        Date := Today;
        "Time Inserted" := Time;
        Cashier := CopyStr(UserId, 1, MaxStrLen(Cashier));
        "User Id" := CopyStr(UserId, 1, MaxStrLen("User Id"));
        "Created By" := CopyStr(UserId, 1, MaxStrLen("Created By"));
    end;

    procedure DefaultPettyCash(var BankCode: Code[20]): Code[20]
    var
        BankRec: Record "Bank Account";
        PaymentMethod: Record "Payment Method";
    begin
        BankRec.Reset();
        BankRec.SetRange("Bank Type", BankRec."Bank Type"::Cash);
        if BankRec.Findfirst() then
            BankCode := BankRec."No.";

        PaymentMethod.Reset();
        PaymentMethod.SetRange("Bal. Account Type", PaymentMethod."Bal. Account Type"::Cash);
        if PaymentMethod.FindFirst() then
            exit(PaymentMethod.Code);
    end;

    procedure DeletePaymentLines(): Boolean
    begin
        PaymentLine.Reset();
        PaymentLine.SetRange("Payment Type", "Payment Type");
        PaymentLine.SetRange(No, "No.");
        if PaymentLine.Find('-') then
            repeat
                PaymentLine."Shortcut Dimension 1 Code" := '';
                PaymentLine."Shortcut Dimension 2 Code" := '';
                PaymentLine."Dimension Set ID" := 0;
                PaymentLine.Modify();
            until PaymentLine.Next() = 0;
    end;

    procedure GetAccountNo(): Code[20]
    var
        UserSetupRec: Record "User Setup";
    begin
        if UserSetupRec.Get(UserId) then;
        UserSetupRec.TestField("Employee No.");
        exit(UserSetupRec."Employee No.");
    end;

    procedure GetPettyCashBank() PettyBank: Code[50]
    var
        Banks: Record "Bank Account";
    begin
        Banks.Reset();
        Banks.SetRange("Bank Type", Banks."Bank Type"::Cash);
        if Banks.FindFirst() then begin
            PettyBank := Banks."No.";
            exit(PettyBank);
        end;
    end;

    procedure MarkAsPosted()
    begin
        Posted := true;
        "Posted By" := CopyStr(UserId, 1, MaxStrLen("Posted By"));
        "Posted Date" := Today;
        "Time Posted" := Time;
        Modify();
    end;

    procedure Navigate()
    var
        NavigateForm: Page Navigate;
    begin
        NavigateForm.SetDoc("Payment Release Date", "Posted Document No.");
        NavigateForm.Run();
    end;

    procedure PaymentLinesExist(): Boolean
    begin
        PaymentLine.Reset();
        // PaymentLine.ReadIsolation := IsolationLevel::ReadUncommitted;
        PaymentLine.SetRange("Payment Type", "Payment Type");
        PaymentLine.SetRange(No, "No.");
        exit(not PaymentLine.IsEmpty);
    end;

    procedure ValidateLineCurrency()
    begin
        PaymentLine.Reset();
        PaymentLine.SetRange("Payment Type", "Payment Type");
        PaymentLine.SetRange(No, "No.");
        PaymentLine.LockTable();
        if PaymentLine.FindSet() then
            repeat
                PaymentLine.Validate(Currency);
                PaymentLine.Modify();
            until PaymentLine.Next() = 0;
    end;

    procedure ShowDocDim()
    begin
        /* OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet2(
            "Dimension Set ID", StrSubstNo('%1 %2', "Payment Type", "No."),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        if OldDimSetID <> "Dimension Set ID" then begin
            if PaymentLinesExist then
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end; */
    end;

    procedure ValidateSurrender()
    var
        PCLines: Record "Payment Lines";
    begin
        TestField("Surrender Date");
        PCLines.Reset();
        PCLines.SetRange("Payment Type", "Payment Type");
        PCLines.SetRange(No, "No.");
        if PCLines.Find('-') then
            repeat
                PCLines.ValidateSurrenderLines();
            until PCLines.Next() = 0;
    end;

    local procedure CheckIfSurrenderExists(SurrenderDoc: Code[50])
    begin
        PaymentRec.SetRange("Payment Type", PaymentRec."Payment Type"::"Imprest Surrender");
        PaymentRec.SetRange("Imprest Issue Doc. No", SurrenderDoc);
        if PaymentRec.FindFirst() then
            Error(SurrExistsErrorErr, SurrenderDoc, PaymentRec."No.");
    end;

    local procedure CheckPendingDocs(PayType: Enum "Payments Mgt Type"; MaxNo: Integer)
    begin
        PaymentRec.Reset();
        PaymentRec.SetRange("Payment Type", PayType);
        PaymentRec.SetRange(Cashier, UserId);
        PaymentRec.SetFilter(Status, '%1', PaymentRec.Status::Open);
        if PaymentRec.Count() > MaxNo then
            Error(MultiDocErrorErr);
    end;

    local procedure CheckUnsurrenderedDoc(PayType: Enum "Payments Mgt Type")
    begin
        if GuiAllowed then begin
            // MaxNo := GetJobGroupImprests(StaffNo);

            PaymentRec.Reset();
            PaymentRec.SetRange("Payment Type", PayType);
            PaymentRec.SetRange(Posted, true);
            PaymentRec.SetRange(Surrendered, false);
            PaymentRec.SetRange(Cashier, UserId);
            /* if PaymentRec.Count >= MaxNo then
                Error(AccountError, Format("Payment Type")); */
        end;
    end;

    local procedure GetNextLineNo(): Integer
    var
        paymentlines: Record "Payment Lines";
    begin
        paymentlines.Reset();
        paymentlines.SetRange(paymentlines.No, "No.");
        if paymentlines.FindLast() then
            exit(paymentlines."Line No" + 10000)
        else
            exit(10000);
    end;

    /* local procedure GetSalaryScale(StaffNo: Code[50]): Code[10]
    var
        Employee: Record Employee;
    begin
        if Employee.Get(StaffNo) then begin
            Employee.TestField("Salary Scale");
            exit(Employee."Salary Scale");
        end else
            Error('Staff %1 does not exist', StaffNo);
    end; */

    local procedure GetStaffNo(UserCode: Code[50]): Code[50]
    var
        Users: Record "User Setup";
    begin
        if Users.Get(UserCode) then begin
            "Staff No." := Users."Employee No.";
            exit(Users."Employee No.");
        end;
    end;

    local procedure HasImprestAccountBalance(AcNo: Code[50]): Boolean
    var
        CustRec: Record Customer;
    begin
        if CustRec.Get(AcNo) then begin
            CustRec.CalcFields("Balance (LCY)");
            ImpBalance := CustRec."Balance (LCY)";
            if CustRec."Balance (LCY)" > 0 then
                exit(true);
            exit(false);
        end;
    end;

    local procedure InsertUserAccount()
    var
        UserSetupRec: Record "User Setup";
    begin
        if not UserSetupRec.Get(UserId) then
            Error(NoUserAccErr)
        else
            if GuiAllowed then begin
                UserSetupRec.TestField("Customer No.");
                UserSetupRec.TestField("Responsibility Centre");
                UserSetupRec.TestField("Global Dimension 1 Code");
                UserSetupRec.TestField("Global Dimension 2 Code");

                "Shortcut Dimension 1 Code" := UserSetupRec."Global Dimension 1 Code";
                "Shortcut Dimension 2 Code" := UserSetupRec."Global Dimension 2 Code";
                Validate("Shortcut Dimension 1 Code");
                Validate("Shortcut Dimension 2 Code");

                if Customer.Get(UserSetupRec."Customer No.") then begin
                    Customer.CalcFields("Balance (LCY)");
                    if "Payment Type" = "Payment Type"::Imprest then
                        if Customer."Balance (LCY)" > 0 then
                            Error('You cannot apply for a new imprest because you have an outstanding balance of KES %1', Customer."Balance (LCY)");
                end;
                "Account No." := UserSetupRec."Customer No.";
                Validate("Account No.");
                UserSetupRec.TestField("Employee No.");
                "Staff No." := UserSetupRec."Employee No.";
                // "Salary Scale" := GetSalaryScale("Staff No.");
                "Responsibility Center" := UserSetupRec."Responsibility Centre";
            end;
    end;

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        NewDimSetID: Integer;
    begin

        // Update all lines with changed dimensions.

        if NewParentDimSetID = OldParentDimSetID then
            exit;
        if not Confirm(ChangedDimLbl) then
            exit;

        PaymentLine.Reset();
        PaymentLine.SetRange("Payment Type", "Payment Type");
        PaymentLine.SetRange(PaymentLine.No, "No.");
        //PaymentLine.LockTable;
        if PaymentLine.Find('-') then
            repeat
                NewDimSetID := DimMgt.GetDeltaDimSetID(PaymentLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                if PaymentLine."Dimension Set ID" <> NewDimSetID then begin
                    PaymentLine."Dimension Set ID" := NewDimSetID;
                    DimMgt.UpdateGlobalDimFromDimSetID(
                      PaymentLine."Dimension Set ID", PaymentLine."Shortcut Dimension 1 Code", PaymentLine."Shortcut Dimension 2 Code");
                    PaymentLine.Modify();
                end;
            until PaymentLine.Next() = 0;
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");

        if OldDimSetID <> "Dimension Set ID" then
            if PaymentLinesExist() then
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
    end;

    procedure AssistEdit(OldPaymentRec: Record Payments): Boolean
    var
        PRec: Record Payments;
    begin
        PRec := Rec;
        if NoSeriesMgt.SelectSeries(GetNoSeries(), OldPaymentRec."No. Series", PRec."No. Series") then begin
            NoSeriesMgt.SetSeries(PRec."No.");
            Rec := PRec;
            exit(true);
        end;
    end;

    local procedure GetNoSeries(): Code[20]
    var
        CashMgtSetup: Record "Cash Management Setups";
    begin
        CashMgtSetup.Get();

        case "Payment Type" of
            "Payment Type"::"Payment Voucher":
                exit(CashMgtSetup."PV Nos");
            "Payment Type"::Imprest:
                exit(CashMgtSetup."Imprest Nos");
            "Payment Type"::"Petty Cash":
                exit(CashMgtSetup."Petty Cash Nos");
            "Payment Type"::"Petty Cash Surrender":
                exit(CashMgtSetup."Petty Cash Surrender Nos");
            "Payment Type"::"Imprest Surrender":
                exit(CashMgtSetup."Imprest Surrender Nos");
            "Payment Type"::"Bank Transfer":
                exit(CashMgtSetup."Bank Transfer Nos");
            "Payment Type"::Receipt:
                exit(CashMgtSetup."Receipt Nos");
            "Payment Type"::"Staff Claim":
                exit(CashMgtSetup."Staff Claim Nos");
            "Payment Type"::"Input Tax":
                exit(CashMgtSetup."Input Tax Nos");
            "Payment Type"::"Property Expense":
                exit(CashMgtSetup."Property Expense Nos");
            "Payment Type"::"Property Expense Surrender":
                exit(CashMgtSetup."Property Expense Surrender Nos");
            "Payment Type"::"Property Expense Claim":
                exit(CashMgtSetup."Property Expense Claim Nos");
        end;
    end;
}
