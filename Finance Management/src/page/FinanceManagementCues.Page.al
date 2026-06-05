page 51107 "Finance Management Cues"
{
    ApplicationArea = All;
    Caption = 'Finance Management Cues';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "Finance Management Cue";

    layout
    {
        area(Content)
        {
            cuegroup("Finance Documents")
            {
                Caption = 'Finance Documents';
                field(PaymentVouchers; Rec."Payment Voucher")
                {
                    Caption = 'Payment Voucher';
                    DrillDownPageId = "Payment Vouchers";
                    ToolTip = 'Specifies the value of the Payment Voucher field';
                }
                field(Imprests; Rec.Imprests)
                {
                    Caption = 'Imprests';
                    DrillDownPageId = Imprests;
                    ToolTip = 'Specifies the value of the Imprests field';
                }
                field(PettyCash; Rec."Petty cash")
                {
                    Caption = 'Petty cash';
                    DrillDownPageId = "Petty Cash List";
                    ToolTip = 'Specifies the value of the Petty cash field';
                }
                field(Receipt; Rec.Receipts)
                {
                    Caption = 'Receipts';
                    DrillDownPageId = Receipts;
                    ToolTip = 'Specifies the value of the Receipts field';
                }
                field("Imprest Surrenders"; Rec."Imprest Surrenders")
                {
                    Caption = 'Imprest Surrenders';
                    DrillDownPageId = "Imprest Surrenders";
                    ToolTip = 'Specifies the value of the Imprest Surrenders field';
                }
                field("Petty Cash Surrenders"; Rec."Petty Cash Surrenders")
                {
                    Caption = 'Petty Cash Surrenders';
                    DrillDownPageId = "Petty Cash Surrenders";
                    ToolTip = 'Specifies the value of the Petty Cash Surrenders field';
                }
                field("Inter-Bank Transfers"; Rec."Inter-Bank Transfers")
                {
                    Caption = 'Inter-Bank Transfers';
                    DrillDownPageId = "InterBank Transfer List";
                    ToolTip = 'Specifies the value of the Inter-Bank Transfers field';
                }
            }
            cuegroup("Finance Documents - Approved")
            {
                Caption = 'Finance Documents - Approved';
                field(PaymentVouchersApproved; Rec."Payment Voucher-Approved")
                {
                    Caption = 'Payment Vouchers - Approved';
                    DrillDownPageId = "Approved Payment Vouchers1";
                    ToolTip = 'Specifies the value of the Payment Vouchers - Approved field';
                }
                field("Imprests-Approved"; Rec."Imprests-Approved")
                {
                    Caption = 'Imprests-Approved';
                    DrillDownPageId = "Approved Imprests";
                    ToolTip = 'Specifies the value of the Imprests-Approved field';
                }
                field(PettyCashApproved; Rec."Petty Cash-Approved")
                {
                    Caption = 'Petty Cash - Approved';
                    DrillDownPageId = "Approved Petty Cash";
                    ToolTip = 'Specifies the value of the Petty Cash - Approved field';
                }
                field(AppReceipt; Rec.Receipts)
                {
                    Caption = 'Receipts - Approved';
                    DrillDownPageId = Receipts;
                    ToolTip = 'Specifies the value of the Receipts field';
                }
                field("Imprest Surrender-Approved"; Rec."Imprest Surrender-Approved")
                {
                    Caption = 'Imprest Surrender-Approved';
                    DrillDownPageId = "Approved Imprest Surrenders";
                    ToolTip = 'Specifies the value of the Imprest Surrender-Approved field';
                }
                field("PCash Surrender-Approved"; Rec."PCash Surrender-Approved")
                {
                    Caption = 'PCash Surrender-Approved';
                    DrillDownPageId = "Approved Petty Cash Surrenders";
                    ToolTip = 'Specifies the value of the PCash Surrender-Approved field';
                }
                field("AppInter-Bank Transfers"; Rec."App Inter-Bank Transfers")
                {
                    Caption = 'Inter-Bank Transfers-Approved';
                    DrillDownPageId = "Approved InterBank Transfer";
                    ToolTip = 'Specifies the value of the Inter-Bank Transfers field';
                }
            }
            cuegroup("Finance Documents - Posted")
            {
                Caption = 'Finance Documents - Posted';
                field(PVPosted; Rec."Posted Payment Voucher")
                {
                    Caption = 'Posted Payment Vocuhers';
                    DrillDownPageId = "Posted Payment Vouchers1";
                    Editable = false;
                    ToolTip = 'Specifies the value of the Posted Payment Vocuhers field';
                }
                field("Posted Imprests"; Rec."Posted Imprests")
                {
                    Caption = 'Posted Imprests';
                    DrillDownPageId = "Posted Imprests";
                    Editable = false;
                    ToolTip = 'Specifies the value of the Posted Imprests field';
                }
                field(PostedPettyCash; Rec."Posted petty cash")
                {
                    Caption = 'Posted Petty Cash';
                    DrillDownPageId = "Posted Petty cash";
                    Editable = false;
                    ToolTip = 'Specifies the value of the Posted Petty Cash field';
                }
                field(PostedReceipts; Rec."Posted Receipts")
                {
                    Caption = 'Posted Receipts';
                    DrillDownPageId = "Posted Receipts";
                    Editable = false;
                    ToolTip = 'Specifies the value of the Posted Receipts field';
                }
                field("Posted Imprest Surrenders"; Rec."Posted Imprest Surrenders")
                {
                    Caption = 'Posted Imprest Surrenders';
                    DrillDownPageId = "Posted Imprest Surrenders";
                    Editable = false;
                    ToolTip = 'Specifies the value of the Posted Imprest Surrenders field';
                }
                field("Posted Petty Cash Surrender"; Rec."Posted Petty Cash Surrender")
                {
                    Caption = 'Posted Petty Cash Surrender';
                    DrillDownPageId = "Posted Petty Cash Surrenders";
                    Editable = false;
                    ToolTip = 'Specifies the value of the Posted Petty Cash Surrender field';
                }
                field("Posted Inter-Bank Transfers"; Rec."Posted Inter-Bank Transfers")
                {
                    Caption = 'Posted Inter-Bank Transfers';
                    DrillDownPageId = "Posted InterBank Transfer";
                    ToolTip = 'Specifies the value of the Posted Inter-Bank Transfers field';
                }
            }
            cuegroup(Receivables)
            {
                Caption = 'Receivables';
                field(Customers; Rec.Customers)
                {
                    Caption = 'Customers';
                    ToolTip = 'Specifies the value of the Customers field';
                }
                field("Sales Invoices"; Rec."Sales Invoices")
                {
                    Caption = 'Sales Invoices';
                    DrillDownPageId = "Sales Invoice List";
                    ToolTip = 'Specifies the value of the Sales Invoices field';
                }
                field("Posted Sales Invoices"; Rec."Posted Sales Invoices")
                {
                    Caption = 'Posted Sales Invoices';
                    DrillDownPageId = "Posted Sales Invoices";
                    ToolTip = 'Specifies the value of the Posted Sales Invoices field';
                }
            }
            cuegroup(Payables)
            {
                Caption = 'Payables';
                field(Vendors; Rec.Vendors)
                {
                    Caption = 'Vendors';
                    ToolTip = 'Specifies the value of the Vendors field';
                }
                field("Purchase Invoices"; Rec."Purchase Invoices")
                {
                    Caption = 'Purchase Invoices';
                    DrillDownPageId = "Purchase Invoices";
                    ToolTip = 'Specifies the value of the Purchase Invoices field';
                }
                field("Posted Purchase Invoices"; Rec."Posted Purchase Invoices")
                {
                    Caption = 'Posted Purchase Invoices';
                    DrillDownPageId = "Posted Purchase Invoices";
                    ToolTip = 'Specifies the value of the Posted Purchase Invoices field';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;

        Rec.SetRange("User ID Filter", UserId);
    end;
}
