table 50009 "General Management Cue"
{
    Caption = 'General Management Cue';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        /* field(2; "User ID"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID';
        }
        field(3; "Approved Imprest"; Integer)
        {
            CalcFormula = count(Payments where("Payment Type" = filter(Imprest),
                                                Status = filter(Released),
                                                "User Id" = field("User ID Filter")));
            FieldClass = FlowField;
            Caption = 'Approved Imprest';
        }
        field(4; "Imprest Surrenders"; Integer)
        {
            CalcFormula = count(Payments where("Payment Type" = filter("Imprest Surrender"),
                                                Status = filter(<> Released),
                                                Posted = const(false),
                                                "User Id" = field("User ID Filter")));
            FieldClass = FlowField;
            Caption = 'Imprest Surrenders';
        }
        field(5; "Pending Staff Claim List"; Integer)
        {
            CalcFormula = count(Payments where("Payment Type" = filter("Staff Claim"),
                                                Status = filter("Pending Approval"),
                                                Posted = const(false),
                                                "User Id" = field("User ID Filter")));
            FieldClass = FlowField;
            Caption = 'Pending Staff Claim List';
        }
        field(6; Imprests; Integer)
        {
            CalcFormula = count(Payments where("Payment Type" = filter(Imprest),
                                                Status = filter(<> Released),
                                                Posted = const(false),
                                                "User Id" = field("User ID Filter")));
            FieldClass = FlowField;
            Caption = 'Imprests';
        }
        field(7; "Pending Imprests"; Integer)
        {
            CalcFormula = count(Payments where("Payment Type" = filter(Imprest),
                                                Status = filter("Pending Approval"),
                                                Posted = const(false),
                                                "User Id" = field("User ID Filter")));
            FieldClass = FlowField;
            Caption = 'Pending Imprests';
        }
        field(8; "Approved Imprest Surrenders"; Integer)
        {
            CalcFormula = count(Payments where("Payment Type" = const("Imprest Surrender"),
                                                Status = const(Released),
                                                Posted = const(false),
                                                "User Id" = field("User ID Filter")));
            FieldClass = FlowField;
            Caption = 'Approved Imprest Surrenders';
        }
        field(9; "Staff Claims List"; Integer)
        {
            CalcFormula = count(Payments where("Payment Type" = const("Staff Claim"),
                                                Status = filter(<> Released),
                                                Posted = const(false),
                                                "User Id" = field("User ID Filter")));
            FieldClass = FlowField;
            Caption = 'Staff Claims List';
        }
        field(10; "Approved Staff Claim"; Integer)
        {
            CalcFormula = count(Payments where("Payment Type" = const("Staff Claim"),
                                                Status = const(Released),
                                                Posted = const(false),
                                                "User Id" = field("User ID Filter")));
            FieldClass = FlowField;
            Caption = 'Approved Staff Claim';
        }
        field(11; "Purchase Request List"; Integer)
        {
            CalcFormula = count("Internal Request Header" where("Document Type" = filter(Purchase),
                                                                 "Fully Ordered" = filter(false),
                                                                 Status = filter(<> Released),
                                                                 "Requested By" = field("User ID Filter")));
            FieldClass = FlowField;
            Caption = 'Purchase Request List';
        }
        field(12; "Purchase Request Approved"; Integer)
        {
            CalcFormula = count("Internal Request Header" where("Document Type" = filter(Purchase),
                                                                 "Fully Ordered" = filter(false),
                                                                 Status = filter(Fulfilled | Released),
                                                                 Uncommitted = const(false),
                                                                 "Requested By" = field("User ID Filter")));
            FieldClass = FlowField;
            Caption = 'Purchase Request Approved';
        }
        field(13; "Store Request List"; Integer)
        {
            CalcFormula = count("Internal Request Header" where("Document Type" = filter(Stock),
                                                                 Status = filter(<> Released),
                                                                 "Requested By" = field("User ID Filter")));
            FieldClass = FlowField;
            Caption = 'Store Request List';
        }
        field(14; "Approved Store Request"; Integer)
        {
            CalcFormula = count("Internal Request Header" where("Document Type" = filter(Stock),
                                                                 Status = filter(Released),
                                                                 Posted = filter(false),
                                                                 "Requested By" = field("User ID Filter")));
            FieldClass = FlowField;
            Caption = 'Approved Store Request';
        }
        field(15; "Leave Application List"; Integer)
        {
            CalcFormula = count("Leave Application" where(Status = filter(Open), "User ID" = field("User ID Filter")));
            FieldClass = FlowField;
            Caption = 'Leave Application List';
        }
        field(16; "Transport Requests"; Integer)
        {
            CalcFormula = count("Travel Requests" where(Status = filter(<> Released), "User ID" = field("User ID Filter")));
            FieldClass = FlowField;
            Caption = 'Transport Requests';
        }
        field(17; "Approved Travel Requests"; Integer)
        {
            CalcFormula = count("Travel Requests" where(Status = const(Released), "User ID" = field("User ID Filter")));
            FieldClass = FlowField;
            Caption = 'Approved Travel Requests';
        }
        field(18; "Training Request List"; Integer)
        {
            CalcFormula = count("Training Request" where(Status = filter(Open), "User ID" = field("User ID Filter")));
            FieldClass = FlowField;
            Caption = 'Training Request List';
        }
        field(19; "Approved Training Request List"; Integer)
        {
            CalcFormula = count("Training Request" where(Status = filter(Released), "User ID" = field("User ID Filter")));
            FieldClass = FlowField;
            Caption = 'Approved Training Request List';
        }
        field(20; "Approval request entries"; Integer)
        {
            CalcFormula = count("Approval Entry" where(Status = const(Created), "Approver ID" = field("User ID Filter")));
            FieldClass = FlowField;
            TableRelation = "Approval Entry";
            Caption = 'Approval request entries';
        }
        field(21; "Pending Approvals"; Integer)
        {
            CalcFormula = count("Approval Entry" where(Status = filter(Open), "Approver ID" = field("User ID Filter")));
            FieldClass = FlowField;
            TableRelation = "Approval Entry";
            Caption = 'Pending Approvals';
        }
        field(22; "User ID Filter"; Code[50])
        {
            FieldClass = FlowFilter;
            Caption = 'User ID Filter';
        }
        field(23; "Pending Leave Applications"; Integer)
        {
            CalcFormula = count("Leave Application" where(Status = filter("Pending Approval"), "User ID" = field("User ID Filter")));
            FieldClass = FlowField;
            Caption = 'Pending Leave Applications';
        }
        field(24; "Approved Leave Applications"; Integer)
        {
            CalcFormula = count("Leave Application" where(Status = filter(Released), "User ID" = field("User ID Filter")));
            FieldClass = FlowField;
            Caption = 'Approved Leave Applications';
        }
        field(28; "Requests to Approve"; Integer)
        {
            CalcFormula = count("Approval Entry" where("Approver ID" = field("User ID Filter"),
                                                        Status = filter(Open)));
            Caption = 'Requests to Approve';
            FieldClass = FlowField;
        }
        field(29; "Requests Sent for Approval"; Integer)
        {
            CalcFormula = count("Approval Entry" where("Sender ID" = field("User ID Filter"),
                                                        Status = filter(Open)));
            Caption = 'Requests Sent for Approval';
            FieldClass = FlowField;
        } */
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}



