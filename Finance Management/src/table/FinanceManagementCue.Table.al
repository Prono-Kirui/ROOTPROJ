table 51017 "Finance Management Cue"
{
    Caption = 'Finance Management Cue';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
        }
        field(2; Vendors; Integer)
        {
            CalcFormula = count(Vendor);
            Caption = 'Vendors';
            Editable = false;
            FieldClass = FlowField;
        }
        field(3; Customers; Integer)
        {
            CalcFormula = count(Customer);
            Caption = 'Customers';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Payment Voucher"; Integer)
        {
            CalcFormula = count(Payments where("Payment Type" = const("Payment Voucher"), Posted = const(false), Status = filter(<> Released)));
            Caption = 'Payment Voucher';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Posted Payment Voucher"; Integer)
        {
            CalcFormula = count(Payments where("Payment Type" = const("Payment Voucher"), Posted = const(true)));
            Caption = 'Posted Payment Voucher';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; Receipts; Integer)
        {
            CalcFormula = count(Payments where(Posted = const(false),
                            "Payment Type" = const(Receipt)));
            Caption = 'Receipts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Posted Receipts"; Integer)
        {
            CalcFormula = count(Payments where(Posted = const(true),
                            "Payment Type" = const(Receipt)));
            Caption = 'Posted Receipts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Petty cash"; Integer)
        {
            CalcFormula = count(Payments where("Payment Type" = const("Petty Cash"),
                            Status = filter(<> Released),
                            Posted = const(false)));
            Caption = 'Petty cash';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Posted petty cash"; Integer)
        {
            CalcFormula = count(Payments where("Payment Type" = const("Petty Cash"),
                            Status = const(Released),
                            Posted = const(true)));
            Caption = 'Posted petty cash';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Sales Invoices"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const(Invoice)));
            Caption = 'Sales Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Posted Sales Invoices"; Integer)
        {
            CalcFormula = count("Sales Invoice Header");
            Caption = 'Posted Sales Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; "Requests to Approve"; Integer)
        {
            CalcFormula = count("Approval Entry" where("Approver ID" = field("User ID Filter"),
                                                        Status = filter(Open)));
            Caption = 'Requests to Approve';
            Editable = false;
            FieldClass = FlowField;
        }
        field(25; "Requests Sent for Approval"; Integer)
        {
            CalcFormula = count("Approval Entry" where("Sender ID" = field("User ID Filter"),
                                                        Status = filter(Open)));
            Caption = 'Requests Sent for Approval';
            Editable = false;
            FieldClass = FlowField;
        }
        field(26; "User ID Filter"; Code[50])
        {
            Caption = 'User ID Filter';
            FieldClass = FlowFilter;
        }
        field(27; "Payment Voucher-Approved"; Integer)
        {
            CalcFormula = count(Payments where("Payment Type" = const("Payment Voucher"), Posted = const(false), Status = const(Released)));
            Caption = 'Payment Voucher-Approved';
            Editable = false;
            FieldClass = FlowField;
        }
        field(28; "Imprests-Approved"; Integer)
        {
            CalcFormula = count(Payments where("Payment Type" = const(Imprest), Posted = const(false), Status = const(Released)));
            Caption = 'Imprests-Approved';
            Editable = false;
            FieldClass = FlowField;
        }
        field(29; "Petty Cash-Approved"; Integer)
        {
            CalcFormula = count(Payments where("Payment Type" = const("Petty Cash"), Posted = const(false), Status = const(Released)));
            Caption = 'Petty Cash-Approved';
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Imprest Surrender-Approved"; Integer)
        {
            CalcFormula = count(Payments where("Payment Type" = const("Imprest Surrender"), Posted = const(false), Status = const(Released)));
            Caption = 'Imprest Surrender-Approved';
            Editable = false;
            FieldClass = FlowField;
        }
        field(31; "PCash Surrender-Approved"; Integer)
        {
            CalcFormula = count(Payments where("Payment Type" = const("Petty Cash Surrender"), Posted = const(false), Status = const(Released)));
            Caption = 'PCash Surrender-Approved';
            Editable = false;
            FieldClass = FlowField;
        }
        field(32; Imprests; Integer)
        {
            CalcFormula = count(Payments where("Payment Type" = const(Imprest),
                            Status = filter(<> Released),
                            Posted = const(false)));
            Caption = 'Imprests';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33; "Imprest Surrenders"; Integer)
        {
            CalcFormula = count(Payments where("Payment Type" = const("Imprest Surrender"),
                            Status = filter(<> Released),
                            Posted = const(false)));
            Caption = 'Imprest Surrenders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(34; "Petty Cash Surrenders"; Integer)
        {
            CalcFormula = count(Payments where("Payment Type" = const("Petty Cash Surrender"),
                            Status = filter(<> Released),
                            Posted = const(false)));
            Caption = 'Petty Cash Surrenders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(35; "Posted Imprests"; Integer)
        {
            CalcFormula = count(Payments where("Payment Type" = const(Imprest), Posted = const(true)));
            Caption = 'Posted Imprests';
            Editable = false;
            FieldClass = FlowField;
        }
        field(36; "Posted Imprest Surrenders"; Integer)
        {
            CalcFormula = count(Payments where("Payment Type" = const("Imprest Surrender"), Posted = const(true)));
            Caption = 'Posted Imprest Surrenders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(37; "Posted Petty Cash Surrender"; Integer)
        {
            CalcFormula = count(Payments where("Payment Type" = const("Petty Cash Surrender"), Posted = const(true)));
            Caption = 'Posted Petty Cash Surrender';
            Editable = false;
            FieldClass = FlowField;
        }
        field(38; "Inter-Bank Transfers"; Integer)
        {
            CalcFormula = count(Payments where("Payment Type" = const("Bank Transfer"), Posted = const(false), Status = filter(<> Released)));
            Caption = 'Inter-Bank Transfers';
            Editable = false;
            FieldClass = FlowField;
        }
        field(39; "Posted Inter-Bank Transfers"; Integer)
        {
            CalcFormula = count(Payments where("Payment Type" = const("Bank Transfer"), Posted = const(true)));
            Caption = 'Posted Inter-Bank Transfers';
            Editable = false;
            FieldClass = FlowField;
        }
        field(40; "Purchase Invoices"; Integer)
        {
            CalcFormula = count("Purchase Header" where("Document Type" = const(Invoice)));
            Caption = 'Purchase Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(41; "Posted Purchase Invoices"; Integer)
        {
            CalcFormula = count("Purch. Inv. Header");
            Caption = 'Posted Purchase Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(42; "App Inter-Bank Transfers"; Integer)
        {
            CalcFormula = count(Payments where("Payment Type" = const("Bank Transfer"), Posted = const(false), Status = filter(Released)));
            Caption = 'Inter-Bank Transfers-Approved';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
