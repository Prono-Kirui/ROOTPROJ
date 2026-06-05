xmlport 51000 "Import PV Lines"
{
    Caption = 'Import Exam Results';
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Payment Lines"; "Payment Lines")
            {
                AutoUpdate = true;
                XmlName = 'PayLines';

                fieldelement(AcNo; "Payment Lines"."Account No")
                {
                }
                fieldelement(Amount; "Payment Lines".Amount)
                {
                }
                fieldelement(Desc; "Payment Lines".Description)
                {
                }

                trigger OnAfterInitRecord()
                begin
                    "Payment Lines"."Expenditure Type" := PayType;
                    GetPaymentType("Payment Lines"."Expenditure Type");
                end;

                trigger OnBeforeInsertRecord()
                begin
                    "Payment Lines".No := PaymentHeaderNo;
                    "Payment Lines"."Line No" := GetLineNo();
                end;
            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                field("Payment Type"; PayType)
                {
                    ApplicationArea = All;
                    Caption = 'Payment Type';
                    TableRelation = "Receipts and Payment Types".Code where(Type = filter("Payment Voucher"));
                    ToolTip = 'Specifies the value of the Payment Type field';
                }
            }
        }
    }

    var
        RecTypes: Record "Receipts and Payment Types";
        PayType: Code[20];
        PaymentHeaderNo: Code[50];

    procedure GetHeaderNo(PayHeader: Record Payments)
    begin
        PaymentHeaderNo := PayHeader."No.";
    end;

    local procedure GetLineNo(): Integer
    var
        PLines: Record "Payment Lines";
        LineNo: Integer;
    begin
        PLines.Reset();
        PLines.SetRange(No, PaymentHeaderNo);
        if PLines.FindLast() then
            LineNo := PLines."Line No" + 10000
        else
            LineNo := 10000;

        exit(LineNo);
    end;

    local procedure GetPaymentType(PType: Code[20])
    begin
        RecTypes.Reset();
        RecTypes.SetRange(Code, PType);
        if RecTypes.FindFirst() then begin
            "Payment Lines"."Account Type" := RecTypes."Account Type";
            "Payment Lines".Description := RecTypes.Description;
        end;
    end;
}
