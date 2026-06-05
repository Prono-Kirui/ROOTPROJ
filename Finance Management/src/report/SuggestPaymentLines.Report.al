report 51000 "Suggest Payment Lines"
{
    ApplicationArea = All;
    Caption = 'Suggest Payment Lines';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/SuggestPaymentLines.rdl';
    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            RequestFilterFields = "No.", "Buy-from Vendor No.";

            trigger OnAfterGetRecord()
            begin
                GetLastPVLine(PVNo, LineNo);
                PurchInvLine.Reset();
                PurchInvLine.SetRange("Document No.", "No.");
                if PurchInvLine.FindFirst() then
                    repeat
                        PVLines.Init();
                        PVLines.No := PVNo;
                        PVLines."Line No" := LineNo + 1000;
                        PVLines."Account Type" := PVLines."Account Type"::Vendor;
                        PVLines."Account No" := "Purch. Inv. Header"."Buy-from Vendor No.";
                        PVLines.Validate("Account No");
                        PVLines.Description := "Purch. Inv. Header"."Posting Description";
                        PVLines.Amount := PurchInvLine.Amount;
                        PVLines.Validate(Amount);
                        PVLines."Applies-to Doc Type" := PVLines."Applies-to Doc Type"::Invoice;
                        PVLines."Applies-to Doc. No." := "Purch. Inv. Header"."No.";
                        PVLines."Dimension Set ID" := PurchInvLine."Dimension Set ID";
                        LineNo := LineNo + 1000;
                        PVLines.Insert();
                    until PurchInvLine.Next() = 0;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                field(Type; Type)
                {
                    ApplicationArea = All;
                    Caption = 'Type';
                    ToolTip = 'Specifies the value of the Type field';
                }
            }
        }
    }
    labels
    {
    }

    var
        PVLines: Record "Payment Lines";
        PurchInvLine: Record "Purch. Inv. Line";
        PVNo: Code[20];
        LineNo: Integer;
        Type: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";

    procedure GetLastPVLine(var DocumentNo: Code[20]; var LineNo: Integer)
    var
        PVLines2: Record "Payment Lines";
    begin
        PVLines2.Reset();
        PVLines2.SetRange(No, DocumentNo);
        if PVLines2.FindLast() then begin

            LineNo := PVLines2."Line No" + 1000;
            Message('%1', PVLines2."Line No" + 1000);
        end;
    end;

    procedure GetNo(var DocumentNo: Code[20])
    begin
        PVNo := DocumentNo;
    end;
}
