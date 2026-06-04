#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50383 "Receipt Allocation-BOSA"
{
    PageType = ListPart;
    SourceTable = "Receipt Allocation";
    Editable = true;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                    // Visible = false;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account No';
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        // if ("Transaction Type" <> "transaction type"::"Member Account") and ("Transaction Type" <> "transaction type"::" ") then begin
                        //     "Account Type" := "account type"::Member
                        // end else
                        //     "Account Type" := "account type"::Vendor;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin


    end;

    var
        sto: Record "Standing Orders";
        Loan: Record "Loans Register";
        ReceiptAllocation: Record "Receipt Allocation";
        ReceiptH: Record "Receipts & Payments";
}

