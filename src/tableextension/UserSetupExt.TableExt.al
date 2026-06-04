tableextension 50009 "UserSetupExt" extends "User Setup"
{


    fields
    {
        field(50000; Picture; BLOB)
        {
            DataClassification = CustomerContent;
            SubType = Bitmap;
            Caption = 'Picture';
        }
        field(50001; "Employee No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Employee."No.";// where(Status = const(Active), "Employee Type" = filter(<> "Board Member"));
            Caption = 'Employee No.';
        }
        field(50002; "Immediate Supervisor"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";
            Caption = 'Immediate Supervisor';
        }
        field(50004; Signature; Blob)
        {
            Subtype = Bitmap;
            DataClassification = CustomerContent;
            Caption = 'Signature';
        }


        field(50005; "HOD User"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'HOD User';
        }
        field(50003; "Customer No."; Code[20])
        {
            TableRelation = Customer;
            DataClassification = CustomerContent;
            Caption = 'Customer No.';
        }
        field(50006; "HOD Imprest Approver"; Code[50])
        {
            TableRelation = "User Setup";
            DataClassification = CustomerContent;
            Caption = 'HOD Imprest Approver';
        }
        field(50007; "Show All"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Show All';
        }
        field(50008; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 1 Code';
        }
        field(50009; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = const(false));
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 2 Code';
        }
        field(50010; "Delegated From"; Code[50])
        {
            TableRelation = "User Setup";
            DataClassification = CustomerContent;
            Caption = 'Delegated From';
        }
        field(50011; "Responsibility Centre"; Code[10])
        {
            AccessByPermission = tabledata "Responsibility Center" = RIMD;
            DataClassification = CustomerContent;
            TableRelation = "Responsibility Center";
            Caption = 'Responsibility Center';
        }
        field(50012; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(50013; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(50014; "Imprest Account"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Customer;
            Caption = 'Imprest Account';
        }
        field(50015; "Post Journals"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'View Journals';
        }
        field(50016; "Post Bank Reconcilliation"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Post Bank Reconcilliation';
        }
        field(50017; "Allow Posting From [Time]"; Time)
        {
            Caption = 'Allow Posting From [Time]';
            DataClassification = CustomerContent;
        }
        field(50018; "Allow Posting To [Time]"; Time)
        {
            Caption = 'Allow Posting To [Time]';
            DataClassification = CustomerContent;
        }
        field(50019; "Show Hidden"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Show Hidden';
        }
        field(50020; "Reverse Register"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Reverse Register';
        }
        field(50021; "Multiple Login"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Multiple Login';
        }
        field(50022; "Post Reversals"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Post Reversals';
        }
        field(50023; "Allow Login After Hours"; Boolean)
        {
            Caption = 'Allow Login After Hours';
            DataClassification = SystemMetadata;
        }
        field(50024; "Request Admin"; Boolean)
        {
            Caption = 'Request Admin';
            DataClassification = SystemMetadata;
        }
        field(50025; "Approval Status"; Enum ApprovalStatus)
        {
            Caption = 'Approval Status';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(50026; "User Type"; Option)
        {
            Caption = 'User Type';
            DataClassification = SystemMetadata;
            OptionMembers = "Limited to User","View All","Approval Limits";
        }
        field(50027; "Last Password Change"; Date)
        {
            Caption = 'Last Password Change';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(50028; "Password Does Not Expire"; Boolean)
        {
            Caption = 'Password Does Not Expire';
            DataClassification = SystemMetadata;
        }
        field(50029; "Allow Multiple Login"; Boolean)
        {
            Caption = 'Allow Multiple Login';
            DataClassification = SystemMetadata;
        }
        field(50031; "View HR Information"; Boolean)
        {
            Caption = 'View HR Information';
            DataClassification = SystemMetadata;
        }
        field(50032; "Edit HR Information"; Boolean)
        {
            Caption = 'Edit HR Information';
            DataClassification = SystemMetadata;
        }
        field(50033; "Branch Code"; Code[20])
        {
            Caption = 'Branch Code';
            DataClassification = SystemMetadata;
        }
        field(50034; "BOSA Account No"; Code[200])
        {
            Caption = 'BOSA Account No';
            DataClassification = SystemMetadata;
        }
        field(50035; "ID No."; Code[20])
        {
            Caption = 'ID No.';
            DataClassification = SystemMetadata;
        }

        field(50036; "Over Draft Limit Expiry Date"; Date)
        {
            Caption = 'Over Draft Limit Expiry Date';
            DataClassification = SystemMetadata;
        }
        field(50037; "Over Draft Limit Amount"; Decimal)
        {
            Caption = 'Over Draft Limit Amount';
            DataClassification = SystemMetadata;
        }
        field(50038; "Over Draft Limit Currency"; Code[10])
        {
            Caption = 'Over Draft Limit Currency';
            DataClassification = SystemMetadata;
            TableRelation = Currency;
        }
        field(50039; "Credit Officer"; Code[200])
        {
            Caption = 'Credit Officer';
            DataClassification = SystemMetadata;

        }

        field(50040; "Uncleared Cheques"; Decimal)
        {
            Caption = 'Uncleared Cheques';
            DataClassification = SystemMetadata;
        }
        field(50041; status; Option)
        {
            Caption = 'Status';
            DataClassification = SystemMetadata;
            OptionMembers = Active,Closed,Dormant,Frozen,Deceased,Resigned,Terminated;
        }
        // field(50042; "Credit Officer"; Text[100])
        // {
        //     Caption = 'Credit Officer';
        //     DataClassification = SystemMetadata;
        // }

        field(50043; "Exempt Logs"; Boolean)
        {
            Caption = 'Exempt Logs';
            DataClassification = SystemMetadata;
        }
        field(50044; "Two Factor Auth OTP"; Integer)
        {
            Caption = 'Two Factor Auth OTP';
            DataClassification = SystemMetadata;
        }
        field(51015; "Show Hiden"; Boolean)
        {
        }
        field(51017; "Department Code"; Code[50])
        {
        }
        field(51018; "Responsibility Center"; Code[50])
        {
        }
        field(51019; "Post Leave Days Allocations"; Boolean)
        {
        }
        field(51020; "User Can Process Dividends"; Boolean)
        {
        }
        field(51021; "Exempt OTP On LogIn"; Boolean)
        {
        }
        field(51022; "Exempt Posting Date Update"; Boolean)
        {
        }

        field(51024; "Can POST Loans"; Boolean)
        {
        }
        field(51025; "Can POST Overdraft"; Boolean)
        {
        }
        field(51000; "Financial User"; Boolean)
        {
        }
        field(51001; "Payroll User"; Boolean)
        {
        }
        field(51003; "View Cashier Report"; Boolean)
        {
        }
        field(51004; "Reversal Right"; Boolean)
        {
        }
        field(51005; "UnLimited Posting"; Boolean)
        {
        }
        field(51006; State; Option)
        {
            Caption = 'State';
            OptionCaption = 'Enabled,Disabled';
            OptionMembers = Enabled,Disabled;
        }
        field(51007; "Expiry Date"; DateTime)
        {
            Caption = 'Expiry Date';
        }
        field(51008; "Windows Security ID"; Text[119])
        {
            Caption = 'Windows Security ID';
        }
        field(51009; "Change Password"; Boolean)
        {
            Caption = 'Change Password';
        }
        field(51011; "Authentication Email"; Text[250])
        {
            Caption = 'Authentication Email';
        }
        field(51012; "Contact Email"; Text[250])
        {
            Caption = 'Contact Email';
        }
        //"View Special Accounts"
        field(51013; "View Special Accounts"; Boolean)
        { }



    }




}





