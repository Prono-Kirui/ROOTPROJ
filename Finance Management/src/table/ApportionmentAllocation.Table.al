table 51013 "Apportionment Allocation"
{
    Caption = 'Apportionment Allocation';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Document No."; Code[50])
        {
            Caption = 'Document No.';
        }
        field(2; Company; Text[50])
        {
            Caption = 'Company';
            TableRelation = Company.Name;
        }
        field(3; Allocation; Decimal)
        {
            Caption = 'Allocation (%)';
        }
        field(4; "Posted Doc No."; Code[50])
        {
            Caption = 'Posted Doc No.';
        }
        field(5; Processed; Boolean)
        {
            Caption = 'Processed';
        }
        field(6; "Expense Account"; Code[30])
        {
            Caption = 'Expense Account';
            TableRelation = "G/L Account";
        }
        field(7; Amount; Decimal)
        {
            Caption = 'Amount';

            trigger OnValidate()
            begin
                TotalAmount := 0;

                if Amount > 0 then;

                if Type = Type::Amount then begin
                    Payments.Reset();
                    Payments.SetRange("No.", "Document No.");
                    if Payments.FindFirst() then begin
                        Payments.CalcFields("Total Amount", "Total Net Amount");
                        TotalAmount := Payments."Total Amount";
                    end;

                    PurchaseHeader.Reset();
                    PurchaseHeader.SetRange("No.", "Document No.");
                    if PurchaseHeader.FindFirst() then begin
                        PurchaseHeader.CalcFields(Amount, "Amount Including VAT");
                        TotalAmount := PurchaseHeader."Amount Including VAT";
                    end;

                    ApportionmentTotals.Reset();
                    ApportionmentTotals.SetRange("No.", "Document No.");
                    if ApportionmentTotals.FindFirst() then begin
                        ApportionmentTotals.CalcFields("Total Amount");
                        TotalAmount := ApportionmentTotals."Total Amount";
                    end;

                    if Amount > TotalAmount then
                        Error('Amount can not be greater than Total Amount');

                    Allocation := (Amount / TotalAmount) * 100;
                end;
            end;
        }
        field(8; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Percentage,Amount';
            OptionMembers = Percentage,Amount;
        }
    }

    keys
    {
        key(Key1; "Document No.", Company)
        {
            Clustered = true;
        }
    }

    var
        ApportionmentTotals: Record "Apportionment Totals";
        Payments: Record Payments;
        PurchaseHeader: Record "Purchase Header";
        TotalAmount: Decimal;
}
