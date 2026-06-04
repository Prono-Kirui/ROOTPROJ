tableextension 50006 "VendorExt" extends Vendor
{
    fields
    {
        field(50000; "Vendor Type"; Enum "Vendor Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor Type';
        }
        field(50001; "KRA PIN"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'KRA PIN';
        }
        field(50002; "Sort Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Sort Code';
        }
        field(50003; "PIN Certificate Expiry"; date)
        {
            DataClassification = CustomerContent;
            Caption = 'PIN Certificate Expiry';
        }
        field(50004; "Account Type"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Account Type';
        }
        field(50005; "Sacco Lawyer"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Sacco Lawyer';
        }
        field(50006; "Insurance Company"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Insurance Company';
        }
        field(50007; Auctioneer; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Auctioneer';
        }
        field(50008; "Employer Code"; Code[100])
        { }
        field(50009; "Salary Processing"; Boolean)
        { }
        field(50010; "ID No."; Code[200])
        { }
        field(68000; "Creditor Type"; Enum CreditorTypeExt)
        {
            DataClassification = CustomerContent;
            Caption = 'Creditor Type';
        }

        field(68001; "Personal No."; Code[20])
        {
        }
        field(68012; "BOSA Account No"; Code[20])
        {
            TableRelation = customer;
            Caption = 'Member No.';//
        }
        field(68016; Status; Option)
        {
            OptionCaption = 'Active,Frozen,Closed,Archived,New,Dormant,Deceased,Retired';
            OptionMembers = Active,Frozen,Closed,Archived,New,Dormant,Deceased,Retired;

            trigger OnValidate()
            begin
                if (Status = Status::Active) or (Status = Status::New) then
                    Blocked := Blocked::" "
                else
                    Blocked := Blocked::All
            end;
        }

        field(68018; "Account Category"; Option)
        {
            OptionCaption = 'Single,Joint,Corporate,Group,Branch,Project';
            OptionMembers = Single,Joint,Corporate,Group,Branch,Project;
        }
        field(68019; "FD Marked for Closure"; Boolean)
        {
        }
        field(68020; "Last Withdrawal Date"; Date)
        {
        }
        field(68021; "Last Overdraft Date"; Date)
        {
        }
        field(68022; "Last Min. Balance Date"; Date)
        {
        }
        field(68023; "Last Deposit Date"; Date)
        {
        }
        field(68024; "Last Transaction Posting Date"; Date)
        {
        }
        field(68025; "Date Closed"; Date)
        {
        }

        field(68027; "Expected Maturity Date"; Date)
        {
        }

        field(68029; "Date of Birth"; Date)
        {

            trigger OnValidate()
            begin
                /* IF "Date of Birth" > TODAY THEN
                 ERROR('Date of birth cannot be greater than today');
                 */

            end;
        }
        field(68030; "Last Transaction Date"; Date)
        {
            AutoFormatType = 1;
            CalcFormula = max("Vendor Ledger Entry"."Posting Date" where(Reversed = const(false)));
            Caption = 'Last Transaction Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(68032; "E-Mail Address"; Text[20])
        {
        }
        field(68033; Section; Code[20])
        {
        }
        field(68034; "Card No."; Code[20])
        {
        }
        field(68035; "Home Address"; Text[20])
        {
        }
        field(68036; Location; Text[20])
        {
        }
        field(68037; "Sub-Location"; Text[20])
        {
        }
        field(68038; District; Text[18])
        {
        }
        field(68039; "Resons for Status Change"; Text[2000])
        {
            Editable = true;
        }
        field(68040; "Closure Notice Date"; Date)
        {
        }


        field(68044; "FD Maturity Date"; Date)
        {

            trigger OnValidate()
            begin
                /*"FD Duration":="FD Maturity Date"-"Registration Date";
                 "FD Duration":=ROUND("FD Duration"/30,1);
                MODIFY;
                */

            end;
        }
        field(68045; "Savings Account No."; Code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(68046; "Old Account No."; Code[20])
        {
        }

        field(68047; "Debt Collector"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Debt Collector';
        }
        field(68048; "BOSA Account No."; Code[20])
        {
            // TableRelation = customer where("Creditor Type" = const("FOSA Account"));
            Caption = 'BOSA Account No.';
        }
        // "Debt Collector %"
        field(68049; "Debt Collector %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Debt Collector %';
        }

        field(68050; "Uncleared Cheques"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Uncleared Cheques';
        }

        ///**************************************************************************************mjk
        /// 

        field(78001; "Staff No"; Code[20])
        {
        }

        field(68003; "Last Maintenance Date"; Date)
        {
        }
        field(68004; "Activate Sweeping Arrangement"; Boolean)
        {
        }
        field(68005; "Sweeping Balance"; Decimal)
        {
        }
        field(68006; "Sweep To Account"; Code[30])
        {
            TableRelation = Vendor;
        }
        field(68007; "Fixed Deposit Status"; Option)
        {
            OptionCaption = ' ,Active,Matured,Closed,Not Matured';
            OptionMembers = " ",Active,Matured,Closed,"Not Matured";
        }
        field(68008; "Call Deposit"; Boolean)
        {
            trigger OnValidate()
            begin
            end;
        }
        field(68009; "Mobile Phone No"; Code[50])
        {
            trigger OnValidate()
            begin
            end;
        }
        field(68010; "Marital Status"; Option)
        {
            OptionCaption = ' ,Single,Married,Divorced,Widower';
            OptionMembers = " ",Single,Married,Divorced,Widower;
        }
        field(68011; "Registration Date"; Date)
        {
            trigger OnValidate()
            begin
                //IF FDType.GET("Fixed Deposit Type") THEN

            end;
        }

        field(68013; Signature; Media)
        {
            Caption = 'Signature';
            //SubType = Bitmap;
        }
        field(68014; "Passport No."; Code[50])
        {
        }
        field(68015; "Company Code"; Code[80])
        {
            TableRelation = "Sacco Employers";
        }

        field(68028; "ATM Transactions"; Decimal)
        {
            // CalcFormula = sum("ATM Transactions".Amount where("Account No" = field("No."), Posted = const(false)));
            // Editable = false;
            // FieldClass = FlowField;
        }

        field(78032; "E-Mail (Personal)"; Text[50])
        {
        }

        field(68041; "Fixed Deposit Type"; Code[20])
        {
            TableRelation = "Fixed Deposit Type".Code;

            trigger OnValidate()
            var
            // FDType: Record "Fixed Deposit Type";
            // interestCalc: Record "FD Interest Calculation Criter";
            begin
                // TestField("Registration Date");
                // if FDType.Get("Fixed Deposit Type") then "FD Maturity Date" := CalcDate(FDType.Duration, "Registration Date");
                // "Fixed Duration" := FDType.Duration;
                // "Fixed duration2" := FDType."No. of Months";
                // "FD Duration" := FDType."No. of Months";
                // "Fixed Deposit Status" := "fixed deposit status"::Active;
                // if interestCalc.Get(interestCalc.Code) then "Interest rate" := interestCalc."Interest Rate";
            end;
        }
        field(68042; "Interest Earned"; Decimal)
        {
            //CalcFormula = sum("Interest Buffer"."Interest Amount" where("Account No" = field("No.")));
            Editable = false;
            // FieldClass = FlowField;
        }
        field(68043; "Untranfered Interest"; Decimal)
        {
            //CalcFormula = sum("Interest Buffer"."Interest Amount" where("Account No" = field("No."), Transferred = const(false)));
            Editable = false;
            ///FieldClass = FlowField;
        }

        field(78048; "Amount to Transfer"; Decimal)
        {
            trigger OnValidate()
            begin
                CalcFields(Balance);
                TestField("Registration Date");
            end;
        }
        field(78049; Proffesion; Text[50])
        {
        }
        field(78050; "Signing Instructions"; Text[250])
        {
        }
        field(68051; Hide; Boolean)
        {
        }
        field(68052; "Monthly Contribution"; Decimal)
        {
        }
        field(68053; "Not Qualify for Interest"; Boolean)
        {
        }
        field(68054; Gender; Option)
        {
            OptionMembers = Male,Female;
        }
        field(68055; "Fixed Duration"; DateFormula)
        {
            trigger OnValidate()
            begin
                if "Account Type" = 'FIXED' then begin
                    TestField("Registration Date");
                    //"FD Maturity Date" := CalcDate("Fixed Duration", "Registration Date");
                end;
            end;
        }
        field(68056; "System Created"; Boolean)
        {
        }
        field(68057; "External Account No"; Code[50])
        {
        }
        field(68058; "Bank Code"; Code[20])
        {
            TableRelation = Banks.Code;
        }
        field(68059; Enabled; Boolean)
        {
        }
        field(68060; "Current Salary"; Decimal)
        {
            // CalcFormula = sum("Salary Processing Lines".Amount where("Account No." = field("No."), Date = field("Date Filter"), Processed = const(true)));
            // FieldClass = FlowField;
        }
        field(68061; "Defaulted Loans Recovered"; Boolean)
        {
        }
        field(68062; "Document No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(68063; "EFT Transactions"; Decimal)
        {
            // CalcFormula = sum("EFT Details".Amount where("Account No" = field("No."), "Not Available" = const(true), Transferred = const(false)));
            // FieldClass = FlowField;
        }
        field(68064; "Formation/Province"; Code[20])
        {
            trigger OnValidate()
            var
                Vend: Record Vendor;
            begin
                Vend.Reset;
                Vend.SetRange(Vend."Staff No", "Staff No");
                if Vend.Find('-') then begin
                    repeat
                        Vend."Formation/Province" := "Formation/Province";
                        Vend.Modify;
                    until Vend.Next = 0;
                end;
            end;
        }
        field(68065; "Division/Department"; Code[20])
        {
            TableRelation = "Member Departments"."No.";
        }
        field(68066; "Station/Sections"; Code[20])
        {
            TableRelation = "Member Section"."No.";
        }
        field(68067; "Neg. Interest Rate"; Decimal)
        {
        }
        field(68068; "Date Renewed"; Date)
        {
        }
        field(68069; "Last Interest Date"; Date)
        {
            //CalcFormula = max("Interest Buffer"."Interest Date" where("Account No" = field("No.")));
            //FieldClass = FlowField;
        }
        field(68070; "Don't Transfer to Savings"; Boolean)
        {
        }
        field(68071; "Type Of Organisation"; Option)
        {
            OptionCaption = ' ,Club,Association,Partnership,Investment,Merry go round,Other';
            OptionMembers = " ",Club,Association,Partnership,Investment,"Merry go round",Other;
        }
        field(68072; "Source Of Funds"; Option)
        {
            OptionCaption = ' ,Business Receipts,Income from Investment,Salary,Other';
            OptionMembers = " ","Business Receipts","Income from Investment",Salary,Other;
        }
        field(68073; "MPESA Mobile No"; Code[20])
        {
        }
        field(68074; "FOSA Default Dimension"; Integer)
        {
            CalcFormula = count("Default Dimension" where("Table ID" = const(23), "No." = field("No."), "Dimension Value Code" = const('FOSA')));
            FieldClass = FlowField;
        }
        field(68094; "ATM Prov. No"; Code[18])
        {
        }
        field(68095; "ATM Approve"; Boolean)
        {
            trigger OnValidate()
            var
                StatusPermissions: Record "Status Change Permision";
            begin
                if "ATM Approve" = true then begin
                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User Id", UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"ATM Approval");
                    if StatusPermissions.Find('-') = false then Error('You do not have permissions to do an Atm card approval');
                    "Card No." := "ATM Prov. No";
                    "Atm card ready" := false;
                    Modify;
                end;
            end;
        }
        field(68096; "Dividend Paid"; Decimal)
        {
            AutoFormatType = 1;
            // CalcFormula = - sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where("Vendor No." = field("No."),
            //                                                                        "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
            //                                                                        "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
            //                                                                        "Currency Code" = field("Currency Filter"),
            //                                                                        "Document No." = const('DIVIDEND'),
            //                                                                        "Posting Date" = const(03));
            Caption = 'Balance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(68120; "Force No."; Code[20])
        {
        }
        field(68121; "Card Expiry Date"; Date)
        {
        }
        field(68122; "Card Valid From"; Date)
        {
        }
        field(68123; "Card Valid To"; Date)
        {
        }
        field(69002; Service; Text[50])
        {
        }
        field(69005; Reconciled; Boolean)
        {
        }
        field(69009; "FD Duration"; Integer)
        {
            trigger OnValidate()
            begin
                // "FD Maturity Date":="Registration Date"+("FD Duration"*30);
                //MODIFY;
            end;
        }
        field(69010; "Employer P/F"; Code[20])
        {
        }
        field(69017; "Outstanding Balance"; Decimal)
        {
        }
        field(69018; "Atm card ready"; Boolean)
        {
            trigger OnValidate()
            var
                StatusPermissions: Record "Status Change Permision";
            begin
                if "Atm card ready" = true then begin
                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User Id", UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Atm card ready");
                    if StatusPermissions.Find('-') = false then Error('You do not have permission to change atm status');
                end;
            end;
        }
        field(69019; "Current Shares"; Decimal)
        {
        }
        field(69020; "Debtor Type"; Option)
        {
            OptionCaption = ',FOSA Account,Micro Finance';
            OptionMembers = " ","FOSA Account","Micro Finance";
        }
        field(69021; "Group Code"; Code[30])
        {
        }
        field(69022; "Group Account"; Boolean)
        {
        }
        field(69023; "Shares Recovered"; Boolean)
        {
        }
        field(69024; "Group Balance"; Decimal)
        {
        }
        field(69025; "Old Bosa Acc no"; Code[30])
        {
        }
        field(69026; "Group Loan Balance"; Decimal)
        {
            //CalcFormula = - sum("Cust. Ledger Entry"."Amount Posted" where("Transaction Type" = filter(Repayment | Loan | "Unallocated Funds"), "Group Code" = field("Group Code"), "Posting Date" = field("Date filter"), Reversed = const(false)));
            //FieldClass = FlowField;
        }
        field(69027; "ContactPerson Relation"; Code[20])
        {
        }
        field(69028; "ContactPerson Occupation"; Code[20])
        {
        }
        field(69029; "ContacPerson Phone"; Text[30])
        {
        }
        field(69030; "Recruited By"; Code[20])
        {
        }
        field(69031; "ClassB Shares"; Decimal)
        {
        }
        field(69032; "Date ATM Linked"; Date)
        {
        }
        field(69033; "ATM No."; Code[50])
        {
        }
        field(69034; "Reason For Blocking Account"; Text[50])
        {
        }
        field(69035; "Uncleared Loans"; Decimal)
        {
            CalcFormula = sum("Loans Register"."Net Payment to FOSA" where("Account No" = field("No."), Posted = filter(true), "Processed Payment" = filter(false)));
            FieldClass = FlowField;
        }
        field(69036; NetDis; Decimal)
        {
            CalcFormula = sum("Loans Register"."Net Payment to FOSA" where("Account No" = field("No."), "Processed Payment" = filter(false)));
            FieldClass = FlowField;
        }
        field(69037; "Transfer Amount to Savings"; Decimal)
        {
        }
        field(69038; "Notice Date"; Date)
        {
        }
        field(69039; "Account Frozen"; Boolean)
        {
            Editable = false;
        }
        field(69040; "Interest rate"; Decimal)
        {
        }
        field(69041; "Fixed duration2"; Integer)
        {
        }
        field(69042; "FDR Deposit Status Type"; Option)
        {
            Editable = false;
            OptionCaption = 'New,Renewed,Terminated';
            OptionMembers = New,Renewed,Terminated;
        }
        field(69043; "ATM Expiry Date"; Date)
        {
        }
        field(69044; "Authorised Over Draft"; Decimal)
        {
            // CalcFormula = sum("Over Draft Authorisation"."Approved Amount" where("Account No." = field("No."), Status = const(Approved), Expired = const(false), Liquidated = const(false), "Effective/Start Date" = field("Date Filter"), Posted = const(true)));
            // FieldClass = FlowField;
        }
        field(69045; "Net Salary"; Decimal)
        {
        }
        field(69046; "FD Maturity Instructions"; Option)
        {
            OptionCaption = ' ,Transfer to Savings,Transfer Interest & Renew,Renew';
            OptionMembers = " ","Transfer to Savings","Transfer Interest & Renew",Renew;
        }
        field(69047; "ATM Card Approved by"; Code[50])
        {
        }
        field(69048; "Disabled ATM Card No"; Code[18])
        {
            Editable = false;
        }
        field(69049; "Reason For Disabling ATM Card"; Text[200])
        {
        }
        field(69050; "Disable ATM Card"; Boolean)
        {
            trigger OnValidate()
            var
                StatusPermissions: Record "Status Change Permision";
            begin
                if "Disable ATM Card" = true then begin
                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User Id", UserId);
                    // StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"29");
                    if StatusPermissions.Find('-') = false then Error('You do not have permissions to disable Atm cards');
                    if "ATM No." = '' then Error('You cannot disable a blank ATM Card');
                    if "Reason For Disabling ATM Card" = '' then Error('You must specify reason for disabling this atm');
                    "Disabled ATM Card No" := "ATM No.";
                    "ATM No." := '';
                    "ATM Prov. No" := '';
                    "Atm card ready" := false;
                    "Disabled By" := UserId;
                    Modify;
                end;
            end;
        }
        field(69051; "Disabled By"; Code[50])
        {
        }
        field(69052; "Transfer Type"; Option)
        {
            OptionCaption = ' ,Deposits,Share Capital,Jaza Jaza';
            OptionMembers = " ",Deposits,"Share Capital","Jaza Jaza";
        }
        field(69053; "ATM Alert Sent"; Boolean)
        {
        }
        field(69054; "Old Vendor No."; Code[10])
        {
        }
        field(69055; "Loan No"; Code[20])
        {
            // TableRelation = "Loans Register"."Loan  No." where("Account No" = field("No."),
            //                                                     Posted = const(true),
            //                                                     "Outstanding Balance" = filter(> 0));
            //TableRelation = "Loans Register"."Loan  No." where("Account No" = field("No."), "Total Balance" = filter(<> 0));
        }
        field(69056; "Principle Amount"; Decimal)
        {
        }
        field(69057; "Interest Amount"; Decimal)
        {
        }
        field(69058; "Bankers Cheque Amount"; Decimal)
        {
        }
        field(69060; "Registered M-Sacco"; Boolean)
        {
        }
        field(69061; "Sms Notification"; Boolean)
        {
        }
        field(69062; "Reason for Enabling ATM Card"; Text[30])
        {
        }
        field(69063; "Enabled By"; Code[20])
        {
        }
        field(69064; "Date Enabled"; Date)
        {
        }
        field(69065; "Pepea Shares"; Decimal)
        {
            // CalcFormula = - sum("Detailed Vendor Ledg. Entry"."Amount Posted" where("Vendor No." = field("No."), "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"), "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"), "Currency Code" = field("Currency Filter"), "Transaction Type" = filter("Pepea Shares")));
            // FieldClass = FlowField;
        }
        field(69066; "Transaction Type Fosa"; Option)
        {
            OptionCaption = ' ,Pepea Shares,School Fees Shares';
            OptionMembers = " ","Pepea Shares","School Fees Shares";
        }
        field(69067; "School Fees Shares"; Decimal)
        {
            // CalcFormula = sum("Detailed Vendor Ledg. Entry"."Amount Posted" where("Vendor No." = field("No."), "Transaction Type Fosa" = filter("School Fees Shares")));
            // FieldClass = FlowField;
        }
        field(69068; "Pepea Share"; Decimal)
        {
            //CalcFormula = sum("Detailed Vendor Ledg. Entry"."Amount Posted" where("Vendor No." = field("No."), "Transaction Type Fosa" = filter("Pepea Shares")));
            //FieldClass = FlowField;
        }
        field(69069; "Modified By"; Code[45])
        {
        }
        field(69070; "Outstanding Loans"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."), "Transaction Type" = filter(Loan | "Unallocated Funds"), "Posting Date" = field("Date filter"), Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(69071; "Outstanding Interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("No."), "Transaction Type" = filter("Interest Due" | "Interest Paid"), "Posting Date" = field("Date filter"), Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(69072; "Grower No"; Code[20])
        {
        }
        field(69073; "Pastrol Cont"; Decimal)
        {
        }
        field(69074; "Paid RegFee"; Boolean)
        {
        }
        field(69075; "Piggy Amount"; Decimal)
        {
        }
        field(69076; "Junior Trip"; Decimal)
        {
        }
        field(69077; "Holiday Savings"; Decimal)
        {
        }
        field(69078; "Cheque Acc. No"; Code[20])
        {
        }
        field(69079; "Overdraft amount"; Decimal)
        {
        }
        field(69080; "Remaining balance"; Decimal)
        {
        }
        field(69081; "Outstanding Overdraft"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("BOSA Account No"), "Transaction Type" = filter(Loan), "Loan product Type" = const('OVERDRAFT'), "Posting Date" = field("Date filter"), Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(50062; "Do Not Include?"; Boolean)
        {
        }
        field(50063; "Oustanding Overdraft interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("BOSA Account No"), "Transaction Type" = filter("Interest due" | "Interest Paid"), "Loan product Type" = const('OVERDRAFT'), "Posting Date" = field("Date filter"), Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(50065; "Mobile Transactions"; Decimal)
        {
        }
        field(50066; "Account Balance"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            //CalcFormula = - Sum("Detailed Cust. Ledg. Entry".a WHERE("Vendor No." = FIELD("No."), "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"), "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"), "Currency Code" = FIELD("Currency Filter")));
            Caption = 'Balance';
            Editable = false;
            // FieldClass = FlowField;
        }
        field(6907001; "Outstanding okoa biashara"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("BOSA Account No"), "Transaction Type" = filter(Loan), "Loan product Type" = const('OKOA'), "Posting Date" = field("Date filter"), Reversed = const(false)));
            FieldClass = FlowField;
        }
        field(6907002; "FOSA Balance"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry".Amount WHERE("Vendor No." = FIELD("No."), "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"), "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"), "Currency Code" = FIELD("Currency Filter"), "Posting Date" = field("Date filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6907003; "Outstanding FOSA Interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("BOSA Account No"), "Transaction Type" = filter("Interest Due" | "Interest Paid"), "Posting Date" = field("Date filter"), Reversed = const(false), "Global Dimension 1 Code" = const('FOSA')));
            FieldClass = FlowField;
        }
        field(6907004; "Outstanding FOSA Loan"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("BOSA Account No"), "Transaction Type" = filter("Loan"), "Posting Date" = field("Date filter"), Reversed = const(false), "Global Dimension 1 Code" = const('FOSA')));
            FieldClass = FlowField;
        }
        field(6907005; "Outstanding Overdraft Interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("BOSA Account No"), "Transaction Type" = filter("Interest Due" | "Interest Paid"), "Posting Date" = field("Date filter"), Reversed = const(false), "Loan product Type" = const('OVERDRAFT')));
            FieldClass = FlowField;
        }
        field(6907006; "Outstanding OKOA Interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("BOSA Account No"), "Transaction Type" = filter("Interest Due" | "Interest Paid"), "Posting Date" = field("Date filter"), Reversed = const(false), "Loan product Type" = const('OKOA')));
            FieldClass = FlowField;
        }
        field(6907008; "Total Outstanding Overdraft"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("BOSA Account No"), "Transaction Type" = filter("Interest Due" | "Interest Paid" | "Loan"), "Posting Date" = field("Date filter"), Reversed = const(false), "Loan product Type" = const('OVERDRAFT')));
            FieldClass = FlowField;
        }
        field(6907009; "Total Outstanding Okoa"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Amount Posted" where("Customer No." = field("BOSA Account No"), "Transaction Type" = filter("Interest Due" | "Interest Paid" | "Loan"), "Posting Date" = field("Date filter"), Reversed = const(false), "Loan product Type" = const('OKOA')));
            FieldClass = FlowField;
        }
        field(6907010; "Total Debits"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry"."Debit Amount" WHERE("Vendor No." = FIELD("No."), "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"), "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"), "Currency Code" = FIELD("Currency Filter"), "Posting Date" = field("Date filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6907011; "Total Credits"; Decimal)
        {
            CalcFormula = - sum("Detailed Vendor Ledg. Entry"."Credit Amount" WHERE("Vendor No." = FIELD("No."), "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"), "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"), "Currency Code" = FIELD("Currency Filter"), "Posting Date" = field("Date filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6907012; "Total Active Loans"; Integer)
        {
            CalcFormula = count("Loans Register" WHERE("Account No" = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6907013; "Treat as Special Account ?"; Boolean)
        {
        }
        field(6907014; "Last Deposits Date"; Date)
        {
            CalcFormula = max("Detailed Vendor Ledg. Entry"."Posting Date" WHERE("Vendor No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6907015; "Last Deposits Amount"; Decimal)
        {
            CalcFormula = max("Detailed Vendor Ledg. Entry"."Credit Amount" WHERE("Vendor No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6907016; "Withheld Amount"; Decimal)
        {
        }
        field(6907017; "Receive Tellery Message"; Boolean)
        {
        }
        //"On Term Deposit Maturity"
        field(6907018; "On Term Deposit Maturity"; Option)
        {

            Caption = 'On Term Deposit Maturity';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Pay to FOSA Account_ Deposit+Interest,Roll Back Deposit+Interest,Roll Back Deposit Only';
            OptionMembers = " ","Pay to FOSA Account_ Deposit+Interest","Roll Back Deposit+Interest","Roll Back Deposit Only";
            trigger OnValidate()
            begin

            end;
        }
        //"Reason for Freezing Account"
        field(6907019; "Reason for Freezing Account"; Text[250])
        {
        }
        //"Account Frozen By"
        field(6907020; "Account Frozen By"; Text[250])
        {
        }
        //"Joint Account Name"
        field(6907021; "Joint Account Name"; Text[100])
        {
        }

        //"Cheque Discounted"
        field(6907022; "Cheque Discounted"; Decimal)
        {
        }
        //"Staff Account"
        field(6907023; "Staff Account"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        //"Allowable Cheque Discounting %"
        field(6907024; "Allowable Cheque Discounting %"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        //"S-Mobile No"
        field(6907025; "S-Mobile No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        //"E-Loan Qualification Amount"
        field(6907026; "E-Loan Qualification Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        //"Account Special Instructions"
        field(6907027; "Account Special Instructions"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        //"No Of Signatories"
        field(6907028; "No Of Signatories"; Integer)
        {
            DataClassification = CustomerContent;
        }
        //"Created By"
        field(6907029; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        //"Account Creation Date"
        field(6907030; "Account Creation Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        //"Excess Repayment Rule"
        field(6907031; "Excess Repayment Rule"; Option)
        {
            Caption = 'Excess Repayment Rule';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Advance Interest,Advance Principal,Advance Both';
            OptionMembers = " ","Advance Interest","Advance Principal","Advance Both";
            trigger OnValidate()
            begin

            end;

        }
        //"Over Draft Limit Amount"
        field(6907032; "Over Draft Limit Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            // Add any specific logic or validation needed for this field
        }
        //"Over Draft Limit Expiry Date"
        field(6907033; "Over Draft Limit Expiry Date"; Date)
        {
            DataClassification = CustomerContent;
            // Add any specific logic or validation needed for this field
        }
        //CodeDelete
        field(70000; CodeDelete; Boolean)
        {
            DataClassification = CustomerContent;
        }
        //"Payroll/Staff No2"
        field(70002; "Payroll/Staff No2"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        //"Address3-Joint"
        field(70003; Address3; Text[100])
        {
            DataClassification = CustomerContent;
        }
        //"Postal Code 2"
        field(70004; "Postal Code 2"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        //"Town 2"
        field(70005; "Town 2"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        //"Mobile No. 3"
        field(70006; "Mobile No. 3"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        //"Date of Birth2"
        field(70007; "Date of Birth2"; Date)
        {
            DataClassification = CustomerContent;
        }
        //"ID No.2"
        field(70008; "ID No.2"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        //"Passport 2"
        field(70009; "Passport 2"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        //"Member Parish 2"
        field(70010; "Member Parish 2"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        //"Member Parish Name 2"
        field(70001; Gender2; Enum "Employee Gender")
        {


        }


        // "Marital Status2"
        field(70012; "Marital Status2"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Single,Married,Divorced,Widowed';
            OptionMembers = " ",Single,Married,Divorced,Widowed;
        }


        //"Home Postal Code2"
        field(70013; "Home Postal Code2"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        //"Home Town2")
        field(70014; "Home Town2"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        //"Employer Code2"
        field(70015; "Employer Code2"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        //"Employer Name2"
        field(70016; "Employer Name2"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        //"E-Mail (Personal2)"
        field(70017; "E-Mail (Personal2)"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        //"Picture 2"
        field(70018; "Picture 2"; Blob)
        {
            DataClassification = CustomerContent;
        }
        //"Signature  2"
        field(70019; "Signature  2"; Blob)
        {
            DataClassification = CustomerContent;
        }
        //"Name 3"
        field(70020; Name3; Text[100])
        {
            DataClassification = CustomerContent;
        }
        //"Payroll/Staff No3"
        field(70021; "Payroll/Staff No3"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        //Address4
        field(70022; Address4; Text[100])
        {
            DataClassification = CustomerContent;
        }
        //"Postal Code 3"
        field(70023; "Postal Code 3"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        //"Town 3"
        field(70024; "Town 3"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        //"Mobile No. 4"
        field(70025; "Mobile No. 4"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        //"Date of Birth3"
        field(70026; "Date of Birth3"; Date)
        {
            DataClassification = CustomerContent;
        }
        //"ID No.3"
        field(70027; "ID No.3"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        //"Passport 3"
        field(70028; "Passport 3"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        //"Member Parish 3"
        field(70029; "Member Parish 3"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        //"Member Parish Name 3"
        field(70030; "Member Parish Name 3"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        //Gender3
        field(70031; Gender3; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Male,Female,Other';
            OptionMembers = " ",Male,Female,Other;
        }
        //"Marital Status3")
        field(70032; "Marital Status3"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Single,Married,Divorced,Widowed';
            OptionMembers = " ",Single,Married,Divorced,Widowed;
        }

        //"Home Postal Code3"
        field(70033; "Home Postal Code3"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        //"Home Town3"
        field(70034; "Home Town3"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        //"Employer Code3"
        field(70035; "Employer Code3"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        //"Employer Name3"
        field(70036; "Employer Name3"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        //"E-Mail (Personal3)"
        field(70037; "E-Mail (Personal3)"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        //"Picture 3"
        field(70038; "Picture 3"; Blob)
        {
            DataClassification = CustomerContent;
        }
        //"Signature  3"
        field(70039; "Signature  3"; Blob)
        {
            DataClassification = CustomerContent;
        }
        //"Fixed Deposit Start Date"
        field(70040; "Fixed Deposit Start Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        //"Fixed Deposit Certificate No."
        field(70041; "Fixed Deposit Certificate No."; Code[30])
        {
            DataClassification = CustomerContent;
        }

        //"Expected Interest On Term Dep"
        field(70042; "Expected Interest On Term Dep"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        //"Last Interest Earned Date"
        field(70043; "Last Interest Earned Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        // "Prevous Fixed Deposit Type"
        field(70044; "Prevous Fixed Deposit Type"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        //"Prevous FD Start Date"
        field(70045; "Prevous FD Start Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        //"Prevous Fixed Duration"
        field(70046; "Prevous Fixed Duration"; Integer)
        {
            DataClassification = CustomerContent;
        }
        //"Prevous Expected Int On FD"
        field(70047; "Prevous Expected Int On FD"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        //"Prevous FD Maturity Date"
        field(70048; "Prevous FD Maturity Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        //"Prevous FD Deposit Status Type"
        field(70049; "Prevous FD Deposit Status Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,New,Renewed,Terminated';
            OptionMembers = " ",New,Renewed,Terminated;
        }

        //"Prevous Interest Rate FD"
        field(70050; "Prevous Interest Rate FD"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        //"ATM Withdrawal Limit"
        field(70051; "ATM Withdrawal Limit"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        //"ATM Issued"
        field(70052; "ATM Issued"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        //"ATM Self Picked"
        field(70053; "ATM Self Picked"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        //"ATM Collector Name"
        field(70054; "ATM Collector Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        //"ATM Collector's ID"
        field(70055; "ATM Collector's ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        //"ATM Collector's Mobile"
        field(70056; "ATM Collector's Mobile"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        //"Bulk Withdrawal Appl Done"
        field(70057; "Bulk Withdrawal Appl Done"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        //"Bulk Withdrawal Appl Date"
        field(70058; "Bulk Withdrawal Appl Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        //"Bulk Withdrawal App Date For W"
        field(70059; "Bulk Withdrawal App Date For W"; Date)
        {
            DataClassification = CustomerContent;
        }
        //"Bulk Withdrawal Appl Amount"
        field(70060; "Bulk Withdrawal Appl Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        //"Bulk Withdrawal Fee"
        field(70061; "Bulk Withdrawal Fee"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        //"Bulk Withdrawal App Done By"
        field(70062; "Bulk Withdrawal App Done By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        //"Transaction Alerts"
        field(70063; "Transaction Alerts"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        //Name 3
        field(70064; Name4; Text[100])
        {
            DataClassification = CustomerContent;
        }
        //"Marital Status3"
        field(70065; "Marital Status4"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Single,Married,Divorced,Widowed';
            OptionMembers = " ",Single,Married,Divorced,Widowed;
        }
        //"Comission On Cheque Discount"
        field(70066; "Comission On Cheque Discount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        //"Cheque Book Account No"
        field(70067; "Cheque Book Account No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        //"Pension No"
        field(70068; "Pension No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        //Picture

        //"Assigned System ID"
        field(70070; "Assigned System ID"; Code[50])
        {
            DataClassification = CustomerContent;
        }

        //"ATM Collector's ID"
        field(70071; "System ID Activated"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        //Title
        field(70072; Title; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Mr,Mrs,Miss,Ms,Dr,Prof';
            OptionMembers = " ",Mr,Mrs,Miss,Ms,Dr,Prof;
        }
        //"Home Postal Code"
        field(70073; "Home Postal Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        //"Home Town"
        field(70074; "Home Town"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        //"Contact Person"
        field(70075; "Contact Person"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        //"Members Parish"
        field(70076; "Members Parish"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        //"Parish Name"
        field(70077; "Parish Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        //"Member's Residence"
        field(70078; "Member's Residence"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        //Uncleared Cheques

        //"Name of the Group/Corporate"
        field(70080; "Name of the Group/Corporate"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        // "Date of Registration"
        field(70081; "Date of Registration"; Date)
        {
            DataClassification = CustomerContent;
        }
        //"No of Members"
        field(70082; "No of Members"; Integer)
        {
            DataClassification = CustomerContent;
        }
        ///"Group/Corporate Trade"
        field(70083; "Group/Corporate Trade"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        //"Certificate No"
        field(70084; "Certificate No"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        //Town
        field(70085; Town; Text[50])
        {
            DataClassification = CustomerContent;
        }
        //"Self Recruited"
        field(70086; "Self Recruited"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        //"Recruiter Name"
        field(70087; "Recruiter Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        //"Relationship With Recruiter"
        field(70088; "Relationship With Recruiter"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        //"Referee Member No"
        field(70089; "Referee Member No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(70090; "Referee Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        //"Referee ID No"
        field(70091; "Referee ID No"; Code[20])
        {
            DataClassification = CustomerContent;
        }

        //"Referee Mobile Phone No"
        field(70092; "Referee Mobile Phone No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        //"Office Telephone No."
        field(70093; "Office Telephone No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        //"Extension No."
        field(70094; "Extension No."; Code[10])
        {
            DataClassification = CustomerContent;
        }
        //"Email Indemnified"
        field(70095; "Email Indemnified"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        //"Send E-Statements"
        field(70096; "Send E-Statements"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        //"Contact Person Phone"
        field(70097; "Contact Person Phone"; Code[20])
        {
            DataClassification = CustomerContent;
        }


    }
    keys
    {
        key(Key22; "Account Type")
        {
        }
        key(Key23; "BOSA Account No")
        {
        }
    }
    fieldgroups
    {
        addlast(DropDown;
        "ID No.")
        {
        }
    }
    trigger OnDelete()
    var
        ItemVendor: Record "Item Vendor";
        PurchPrice: Record "Purchase Price";
        PurchLineDiscount: Record "Purchase Line Discount";
        PurchPrepmtPct: Record "Purchase Prepayment %";
        CustomReportSelection: Record "Custom Report Selection";
    begin
        Error('You cannot delete an existing FOSA Account');
        MoveEntries.MoveVendorEntries(Rec);
        CommentLine.SetRange("Table Name", CommentLine."table name"::Vendor);
        CommentLine.SetRange("No.", "No.");
        CommentLine.DeleteAll;
        VendBankAcc.SetRange("Vendor No.", "No.");
        VendBankAcc.DeleteAll;
        OrderAddr.SetRange("Vendor No.", "No.");
        OrderAddr.DeleteAll;
        ItemCrossReference.SetCurrentkey("Cross-Reference Type", "Cross-Reference Type No.");
        ItemCrossReference.SetRange("Cross-Reference Type", ItemCrossReference."cross-reference type"::Vendor);
        ItemCrossReference.SetRange("Cross-Reference Type No.", "No.");
        ItemCrossReference.DeleteAll;
        PurchOrderLine.SetCurrentkey("Document Type", "Pay-to Vendor No.");
        PurchOrderLine.SetFilter("Document Type", '%1|%2', PurchOrderLine."document type"::Order, PurchOrderLine."document type"::"Return Order");
        PurchOrderLine.SetRange("Pay-to Vendor No.", "No.");
        if PurchOrderLine.FindFirst then Error(Text000, TableCaption, "No.", PurchOrderLine."Document Type");
        PurchOrderLine.SetRange("Pay-to Vendor No.");
        PurchOrderLine.SetRange("Buy-from Vendor No.", "No.");
        if PurchOrderLine.FindFirst then Error(Text000, TableCaption, "No.");
        UpdateContFromVend.OnDelete(Rec);
        DimMgt.DeleteDefaultDim(Database::Vendor, "No.");
        ServiceItem.SetRange("Vendor No.", "No.");
        ServiceItem.ModifyAll("Vendor No.", '');
        ItemVendor.SetRange("Vendor No.", "No.");
        ItemVendor.DeleteAll(true);
        PurchPrice.SetCurrentkey("Vendor No.");
        PurchPrice.SetRange("Vendor No.", "No.");
        PurchPrice.DeleteAll(true);
        PurchLineDiscount.SetCurrentkey("Vendor No.");
        PurchLineDiscount.SetRange("Vendor No.", "No.");
        PurchLineDiscount.DeleteAll(true);
        CustomReportSelection.SetRange("Source Type", Database::Vendor);
        CustomReportSelection.SetRange("Source No.", "No.");
        CustomReportSelection.DeleteAll;
        PurchPrepmtPct.SetCurrentkey("Vendor No.");
        PurchPrepmtPct.SetRange("Vendor No.", "No.");
        PurchPrepmtPct.DeleteAll(true);
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            PurchSetup.Get;
            PurchSetup.TestField("Vendor Nos.");
            NoSeriesMgt.InitSeries(PurchSetup."Vendor Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        if "Invoice Disc. Code" = '' then "Invoice Disc. Code" := "No.";
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
        "Modified By" := UserId;
        if (Name <> xRec.Name) or ("Search Name" <> xRec."Search Name") or ("Name 2" <> xRec."Name 2") or (Address <> xRec.Address) or ("Address 2" <> xRec."Address 2") or (City <> xRec.City) or ("Phone No." <> xRec."Phone No.") or ("Telex No." <> xRec."Telex No.") or ("Territory Code" <> xRec."Territory Code") or ("Currency Code" <> xRec."Currency Code") or ("Language Code" <> xRec."Language Code") or ("Purchaser Code" <> xRec."Purchaser Code") or ("Country/Region Code" <> xRec."Country/Region Code") or ("Fax No." <> xRec."Fax No.") or ("Telex Answer Back" <> xRec."Telex Answer Back") or ("VAT Registration No." <> xRec."VAT Registration No.") or ("Post Code" <> xRec."Post Code") or (County <> xRec.County) or ("E-Mail" <> xRec."E-Mail") or ("Home Page" <> xRec."Home Page") then begin
            //MODIFY;
            //UpdateContFromVend.OnModify(Rec);
            //IF FIND THEN;
        end;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
        "Modified By" := UserId;
    end;

    var
        Text000: label 'You cannot delete %1 %2 because there is at least one outstanding Purchase %3 for this vendor.';
        Text002: label 'You have set %1 to %2. Do you want to update the %3 price list accordingly?';
        Text003: label 'Do you wish to create a contact for %1 %2?';
        PurchSetup: Record "Purchases & Payables Setup";
        CommentLine: Record "Comment Line";
        PurchOrderLine: Record "Purchase Line";
        PostCode: Record "Post Code";
        VendBankAcc: Record "Vendor Bank Account";
        OrderAddr: Record "Order Address";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        ItemCrossReference: Record "Item Cross Reference";
        RMSetup: Record "Marketing Setup";
        ServiceItem: Record "Service Item";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        MoveEntries: Codeunit MoveEntries;
        UpdateContFromVend: Codeunit "VendCont-Update";
        DimMgt: Codeunit DimensionManagement;
        InsertFromContact: Boolean;
        AccountTypes: Record "Account Types-Saving Products";
        FDType: Record "Fixed Deposit Type";
        ReplCharge: Decimal;
        Vends: Record Vendor;
        gnljnlLine: Record "Gen. Journal Line";
        FOSAAccount: Record Vendor;
        Member: Record Customer;
        Vend: Record Vendor;
        Loans: Record "Loans Register";
        StatusPermissions: Record "Status Change Permision";
        // interestCalc: Record "FD Interest Calculation Criter";
        Text004: label 'Contact %1 %2 is not related to vendor %3 %4.';
        Text005: label 'post';
        Text006: label 'create';
        Text007: label 'You cannot %1 this type of document when Vendor %2 is blocked with type %3';
        Text008: label 'The %1 %2 has been assigned to %3 %4.\The same %1 cannot be entered on more than one %3.';
        Text009: label 'Reconciling IC transactions may be difficult if you change IC Partner Code because this %1 has ledger entries in a fiscal year that has not yet been closed.\ Do you still want to change the IC Partner Code?';
        Text010: label 'You cannot change the contents of the %1 field because this %2 has one or more open ledger entries.';
        Text011: label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        Text10000: label '%1 is not a valid RFC No.';
        Text10001: label '%1 is not a valid CURP No.';
        Text10002: label 'The RFC No. %1 is used by another company.';

    procedure AssistEdit(OldVend: Record Vendor): Boolean
    var
        Vend: Record Vendor;
    begin
        with Vend do begin
            Vend := Rec;
            PurchSetup.Get;
            PurchSetup.TestField("Vendor Nos.");
            if NoSeriesMgt.SelectSeries(PurchSetup."Vendor Nos.", OldVend."No. Series", "No. Series") then begin
                PurchSetup.Get;
                PurchSetup.TestField("Vendor Nos.");
                NoSeriesMgt.SetSeries("No.");
                Rec := Vend;
                exit(true);
            end;
        end;
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(Database::Vendor, "No.", FieldNumber, ShortcutDimCode);
        Modify;
    end;

    procedure ShowContact()
    var
        ContBusRel: Record "Contact Business Relation";
        Cont: Record Contact;
    begin
        if "No." = '' then exit;
        ContBusRel.SetCurrentkey("Link to Table", "No.");
        ContBusRel.SetRange("Link to Table", ContBusRel."link to table"::Vendor);
        ContBusRel.SetRange("No.", "No.");
        if not ContBusRel.FindFirst then begin
            if not Confirm(Text003, false, TableCaption, "No.") then exit;
            UpdateContFromVend.InsertNewContact(Rec, false);
            ContBusRel.FindFirst;
        end;
        Commit;
        Cont.SetCurrentkey("Company Name", "Company No.", Type, Name);
        Cont.SetRange("Company No.", ContBusRel."Contact No.");
        Page.Run(Page::"Contact List", Cont);
    end;

    procedure SetInsertFromContact(FromContact: Boolean)
    begin
        InsertFromContact := FromContact;
    end;

    procedure CheckBlockedVendOnDocs(Vend2: Record Vendor; Transaction: Boolean)
    begin
        if Vend2.Blocked = Vend2.Blocked::All then VendBlockedErrorMessage(Vend2, Transaction);
    end;

    procedure CheckBlockedVendOnJnls(Vend2: Record Vendor; DocType: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund; Transaction: Boolean)
    begin
        with Vend2 do begin
            if (Blocked = Blocked::All) or (Blocked = Blocked::Payment) and (DocType = Doctype::Payment) then VendBlockedErrorMessage(Vend2, Transaction);
        end;
    end;

    procedure CreateAndShowNewInvoice()
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        PurchaseHeader."Document Type" := PurchaseHeader."document type"::Invoice;
        PurchaseHeader.SetRange("Buy-from Vendor No.", "No.");
        PurchaseHeader.Insert(true);
        Commit;
        // Page.RunModal(Page::"Mini Purchase Invoice",PurchaseHeader)
    end;

    procedure CreateAndShowNewCreditMemo()
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        PurchaseHeader."Document Type" := PurchaseHeader."document type"::"Credit Memo";
        PurchaseHeader.SetRange("Buy-from Vendor No.", "No.");
        PurchaseHeader.Insert(true);
        Commit;
        //  Page.RunModal(Page::"Mini Purchase Credit Memo",PurchaseHeader)
    end;

    procedure VendBlockedErrorMessage(Vend2: Record Vendor; Transaction: Boolean)
    var
        "Action": Text[30];
    begin
        if Transaction then
            Action := Text005
        else
            Action := Text006;
        // For Divindends Export Comment this Error
        //ERROR(Text007,Action,Vend2."No.",Vend2.Blocked);
    end;

    procedure DisplayMap()
    var
        MapPoint: Record "Online Map Setup";
        MapMgt: Codeunit "Online Map Management";
    begin
        if MapPoint.FindFirst then
            MapMgt.MakeSelection(Database::Vendor, GetPosition)
        else
            Message(Text011);
    end;

    procedure CalcOverDueBalance() OverDueBalance: Decimal
    var
        [SecurityFiltering(Securityfilter::Filtered)]
        VendLedgEntryRemainAmtQuery: Query "Vend. Ledg. Entry Remain. Amt.";
    begin
        VendLedgEntryRemainAmtQuery.SetRange(Vendor_No, "No.");
        VendLedgEntryRemainAmtQuery.SetRange(IsOpen, true);
        VendLedgEntryRemainAmtQuery.SetFilter(Due_Date, '<%1', WorkDate);
        VendLedgEntryRemainAmtQuery.Open;
        if VendLedgEntryRemainAmtQuery.Read then OverDueBalance := VendLedgEntryRemainAmtQuery.Sum_Remaining_Amt_LCY;
    end;

    procedure ValidateRFCNo(Length: Integer)
    begin
        //if StrLen("RFC No.") <> Length then Error(Text10000, "RFC No.");
    end;

    procedure GetInvoicedPrepmtAmountLCY(): Decimal
    var
        PurchLine: Record "Purchase Line";
    begin
        PurchLine.SetCurrentkey("Document Type", "Pay-to Vendor No.");
        PurchLine.SetRange("Document Type", PurchLine."document type"::Order);
        PurchLine.SetRange("Pay-to Vendor No.", "No.");
        PurchLine.CalcSums("Prepmt. Amount Inv. (LCY)", "Prepmt. VAT Amount Inv. (LCY)");
        exit(PurchLine."Prepmt. Amount Inv. (LCY)" + PurchLine."Prepmt. VAT Amount Inv. (LCY)");
    end;

    procedure GetTotalAmountLCY(): Decimal
    begin
        CalcFields("Balance (LCY)", "Outstanding Orders (LCY)", "Amt. Rcd. Not Invoiced (LCY)", "Outstanding Invoices (LCY)");
        exit("Balance (LCY)" + "Outstanding Orders (LCY)" + "Amt. Rcd. Not Invoiced (LCY)" + "Outstanding Invoices (LCY)" - GetInvoicedPrepmtAmountLCY);
    end;
}







