table 50151 "Partial Loan Disbursments"
{
    Caption = 'Partial Loan Disbursments';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Partial Loan Disbursement List";
    LookupPageId = "Partial Loan Disbursement List";

    fields
    {
        field(1; "Document No"; Code[20])
        {
            Caption = 'Document No';

            trigger OnValidate()
            begin
                SalesSetup.Get;
                NoSeriesMgt.TestManual(SalesSetup."Partial Loan Disbursement Nos");
                "No. Series" := '';
            end;
        }
        field(2; "Loan No"; Code[20])
        {
            Caption = 'Loan No';
            TableRelation = "Loans Register"."Loan  No." where("Disburesment Type" = const("Tranche/Multiple Disbursement"), "Client Code" = field("Client Code"));

            trigger OnValidate()
            var
                LoansRegTable: record "Loans Register";
                PartialLoanTable: record "Partial Loan Disbursments";
            begin
                //.............................................
                LoansRegTable.Reset();
                LoansRegTable.SetRange(LoansRegTable."Loan  No.", "Loan No");
                if LoansRegTable.Find('-') then begin
                    LoansRegTable.CalcFields("Top Up Amount");
                    "Loan Product Type" := LoansRegTable."Loan Product Type";
                    "Loan Product Type Name" := LoansRegTable."Loan Product Type Name";
                    "Loan Installements" := LoansRegTable.Installments;
                    "Loan Interest" := LoansRegTable.Interest;
                    "Requested Amount" := LoansRegTable."Requested Amount";
                    "Approved Amount" := LoansRegTable."Approved Amount";
                    "Mode of Disbursement" := LoansRegTable."Disburesment Type";
                    //Message('Approved Amount is %1', "Approved Amount");
                    //"Main Sector":=LoansRegTable."Main Sector";
                    // "Sub-Sector":=LoansRegTable."Sub-Sector";
                    // "Specific Sector":=LoansRegTable."Specific Sector";
                    "Recovery Mode" := format(LoansRegTable."Recovery Mode");
                    PartialLoanTable.Reset();
                    PartialLoanTable.SetRange(PartialLoanTable."Loan No", "Loan No");
                    PartialLoanTable.SetRange(PartialLoanTable.Posted, true);
                    if PartialLoanTable.Find('-') then begin
                        repeat
                            if PartialLoanTable."Loan offset Amount" > 0 then begin
                                "Loan offset Amount" := 0
                            end else
                                "Loan offset Amount" := LoansRegTable."Top Up Amount";
                        until PartialLoanTable.Next = 0;
                    end;
                end;
                //.............................................................
                "Total Disbursed Amount" := 0;
                PartialLoanTable.Reset();
                PartialLoanTable.SetRange(PartialLoanTable."Loan No", "Loan No");
                PartialLoanTable.SetRange(PartialLoanTable.Posted, true);
                if PartialLoanTable.Find('-') then begin
                    repeat
                        "Total Disbursed Amount" += PartialLoanTable."Amount To Disburse";
                    until PartialLoanTable.Next = 0;
                end;
                Message('Already Disbursed Amount is %1 ...Approved Amount%2', "Total Disbursed Amount", "Approved Amount");
                "Remaining Amount To Disburse" := "Approved Amount" - "Total Disbursed Amount";
                //New Installments
                LoansRegTable.Reset();
                LoansRegTable.SetRange(LoansRegTable."Loan  No.", "Loan No");
                if LoansRegTable.Find('-') then begin
                    PartialLoanTable.Reset();
                    PartialLoanTable.SetRange(PartialLoanTable."Loan No", "Loan No");
                    PartialLoanTable.SetRange(PartialLoanTable.Posted, true);
                    if PartialLoanTable.FindLast() then begin
                        "New Loan Installements" := LoansRegTable.Installments - Round((Today - PartialLoanTable."Date Disbursed") / 30, 1, '=');
                        Message('New Installments are %1 ', "New Loan Installements");
                    end;
                end;
            end;
        }
        field(3; "Loan Product Type"; Code[50])
        {
            Caption = 'Loan Product Type';
        }
        field(4; "Loan Product Type Name"; Text[100])
        {
            Caption = 'Loan Product Type Name';
        }
        field(5; "Approved Amount"; Decimal)
        {
            Caption = 'Approved Amount';
        }
        field(6; "Disbursement Number"; Integer)
        {
            Caption = 'Disbursement Number';
            Editable = false;
            CalcFormula = Count("Partial Loan Disbursments" WHERE("Loan No" = field("Loan No"), Posted = CONST(true)));
            FieldClass = FlowField;
        }
        field(7; "Client Code"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            var
                LoansRegTable: record "Loans Register";
            begin
                LoansRegTable.Reset();
                LoansRegTable.SetRange(LoansRegTable."Client Code", "Client Code");
                if LoansRegTable.Find('-') then begin
                    "Client Name" := LoansRegTable."Client Name";
                end;
            end;
        }
        field(8; "Client Name"; Text[100])
        {
            Editable = false;
        }
        field(9; "Amount To Disburse"; Decimal)
        {
            trigger OnValidate()
            begin
                if "Amount To Disburse" > "Remaining Amount To Disburse" then begin
                    Error('The amount to disburse cannot be greater than Ksh. ' + Format("Remaining Amount To Disburse"));
                end;
            end;
        }
        field(10; "Total Disbursed Amount"; Decimal)
        {
        }
        field(11; "Remaining Amount To Disburse"; Decimal)
        {
        }
        field(12; "Date Disbursed"; Date)
        {
        }
        field(13; "Posted"; Boolean)
        {
        }
        field(14; "Approved By"; Code[100])
        {
        }
        field(15; "Date Created"; Date)
        {
        }
        field(16; "Posted By"; Code[100])
        {
        }
        field(17; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(18; "Approval Status"; enum "Record Status")
        {
            Editable = false;
        }
        field(19; "Captured By"; Code[50])
        {
            Editable = false;
        }
        field(20; "Loan Installements"; Integer)
        {
            Editable = false;
        }
        field(21; "Loan Interest"; Decimal)
        {
            Editable = false;
        }
        field(22; "Requested Amount"; Decimal)
        {
            Editable = false;
        }
        field(23; "Main Sector"; Code[20])
        {
            Editable = false;
        }
        field(24; "Sub-Sector"; Code[20])
        {
            Editable = false;
        }
        field(25; "Specific Sector"; Code[20])
        {
            Editable = false;
        }
        field(26; "Recovery Mode"; Code[50])
        {
            Editable = false;
        }
        field(27; "Mode of Disbursement"; Option)
        {
            // "Tranche/Multiple Disbursement"
            OptionCaption = ' ,Full/Single disbursement,Tranche/Multiple Disbursement';
            OptionMembers = " ","Full/Single disbursement","Tranche/Multiple Disbursement";
            // InitValue = "Tranche/Multiple Disbursement";
        }
        field(28; "New Loan Installements"; Integer)
        {
        }
        field(53054; "Paying Bank Account No"; Code[25])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(68012; "Cheque No."; Code[10])
        {

            trigger OnValidate()
            begin


            end;
        }
        field(68013; "Cheque Date"; Date)
        {
        }
        //charges
        field(70000; Charge; Boolean)
        {
            Caption = 'Charge';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                PCharges: Record "Loan Product Charges";
                TCharges: Decimal;
                ChargeAmt: Decimal;
                PChargeAmount: Decimal;
            begin
                //
                PartialLoanDisb.Reset();
                PartialLoanDisb.SetRange(PartialLoanDisb."Loan No", Rec."Loan No");
                PartialLoanDisb.SetRange(PartialLoanDisb.Posted, true);
                if PartialLoanDisb.Find('-') then begin
                    repeat
                        if PartialLoanDisb.Charge = true then begin
                            Error('This loan has already been charged on a previous disbursement. You cannot charge again.');
                        end;
                    until PartialLoanDisb.Next = 0;
                end;
                TCharges := 0;
                ChargeAmt := 0;

                PCharges.Reset;
                PCharges.SetRange(PCharges."Product Code", Rec."Loan Product Type");
                PCharges.SetFilter(PCharges."Loan Charge Type", '<>%1', PCharges."loan charge type"::"Loan Insurance");
                if PCharges.Find('-') then begin
                    repeat
                        if Charge then begin
                            if PCharges."Use Perc" = true then begin
                                PChargeAmount := ("Approved Amount" * PCharges.Percentage / 100);//LoanDisbAmount
                                if PChargeAmount < PCharges."Minimum Amount" then begin
                                    PChargeAmount := PCharges."Minimum Amount"
                                end else if PChargeAmount > PCharges."MAXIMUM Amount" then begin
                                    PChargeAmount := PCharges."MAXIMUM Amount"
                                end else
                                    PChargeAmount := ("Approved Amount" * PCharges.Percentage / 100);//LoanDisbAmount
                            end else
                                PChargeAmount := PCharges.Amount;
                        end;
                    until PCharges.Next = 0;
                    TCharges := TCharges + PChargeAmount;
                end;

                if Confirm('Do you want to charge a fee of %1 for Loan No. %2 (Member: %3)?', false, TCharges, Rec."Loan No", Rec."Client Name") then begin
                end else begin
                    Charge := false;
                end;


            end;
        }
        field(70001; "Loan offset"; Decimal)
        {
            Caption = 'Loan Offset';
            DataClassification = ToBeClassified;
        }
        field(70002; "Loan offset Amount"; Decimal)
        {
            Caption = 'Loan Offset Amount';
            DataClassification = ToBeClassified;
        }


    }
    keys
    {
        key(PK; "Document No")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        UserSetUp: Record "User Setup";
    begin
        if "Document No" = '' then begin
            "Approval Status" := "Approval Status"::Open;
            "Captured By" := UserId;
            "Mode of Disbursement" := "Mode Of Disbursement"::"Full/Single disbursement";
            Posted := false;
            "Date Created" := Today;
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Partial Loan Disbursement Nos");
            NoSeriesMgt.InitSeries(SalesSetup."Partial Loan Disbursement Nos", xRec."No. Series", 0D, "Document No", "No. Series");
        end;
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PartialLoanDisb: Record "Partial Loan Disbursments";
}
