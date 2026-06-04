table 50005 "User Support Incident"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Incident Reference"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Incident Reference';

            trigger OnValidate()
            begin

                /* case Type of
                    Type::AUDIT,
                    Type::Risk:
                        begin
                            if "Incident Reference" <> xRec."Incident Reference" then
                                NoSeriesMgt.TestManual(HRSetup."Incidences Nos");
                        end;
                end; */
            end;
        }
        field(2; "Incident Description"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Incident Description';
        }
        field(3; "Incident Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Incident Date';
        }
        field(4; "Incident Status"; Option)
        {
            OptionCaption = 'Unresolved,Resolved';
            OptionMembers = Unresolved,Resolved;
            DataClassification = CustomerContent;
            Caption = 'Incident Status';
        }
        field(5; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "Serial No. Information";
            ;
            DataClassification = CustomerContent;
        }
        field(6; "Action taken"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Action taken';

            trigger OnValidate()
            begin
                "Action By" := UserId;
            end;
        }
        field(7; "Action Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Action Date';
        }
        field(8; User; Code[50])
        {
            TableRelation = User;
            DataClassification = CustomerContent;
            Caption = 'User';
        }
        field(9; "System Support Email Address"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'System Support Email Address';
        }
        field(10; "User email Address"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'User email Address';
        }
        field(11; Type; Option)
        {
            OptionCaption = 'ICT,ADM,REGISTRY,KEYS,AUDIT,Risk';
            OptionMembers = ICT,ADM,REGISTRY,"KEYS",AUDIT,Risk;
            DataClassification = CustomerContent;
            Caption = 'Type';
        }
        field(12; "File No"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'File No';
        }
        field(13; "Incident Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Incident Time';
        }
        field(14; "Action Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Action Time';
        }
        field(15; "Employee No"; Code[20])
        {
            TableRelation = Employee;
            DataClassification = CustomerContent;
            Caption = 'Employee No';

            trigger OnValidate()
            begin
                if Employee.Get("Employee No") then begin
                    "Shortcut Dimension 1 Code" := Employee."Global Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := Employee."Global Dimension 2 Code";
                end;
            end;
        }
        field(16; "Employee Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Employee Name';
        }
        field(17; Sent; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Sent';
        }
        field(18; "Incidence Resolved"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Incidence Resolved';
        }
        field(19; "Work place Controller"; Code[10])
        {
            TableRelation = Employee;
            DataClassification = CustomerContent;
            Caption = 'Work place Controller';
        }
        field(20; "Work place Controller Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Work place Controller Name';
        }
        field(21; "Incidence Location"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Incidence Location';
        }
        field(22; "Incidence Location Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Incidence Location Name';
        }
        field(23; "Incidence Outcome"; Option)
        {
            OptionCaption = '  ,Dangerous,Serious bodily injury,Work caused illness,Serious electrical incident,Dangerous electrical event,MajorAccident under the OSHA Act';
            OptionMembers = "  ",Dangerous,"Serious bodily injury","Work caused illness","Serious electrical incident","Dangerous electrical event","MajorAccident under the OSHA Act";
            DataClassification = CustomerContent;
            Caption = 'Incidence Outcome';
        }
        field(24; "Incident Outcome"; Option)
        {
            OptionCaption = '  ,Yes,No';
            OptionMembers = "  ",Yes,No;
            DataClassification = CustomerContent;
            Caption = 'Incident Outcome';
        }
        field(25; "Remarks HR"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Remarks HR';
        }
        field(26; "User Informed?"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'User Informed?';
        }
        field(27; Priority; Option)
        {
            OptionCaption = ' ,Low,Medium,High';
            OptionMembers = " ",Low,Medium,High;
            DataClassification = CustomerContent;
            Caption = 'Priority';
        }
        field(28; "Expected Action Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Expected Action Date';
        }
        field(29; "User Remarks"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'User Remarks';
        }
        field(30; "Incident Rating"; Option)
        {
            OptionCaption = 'Low,Medium,High';
            OptionMembers = Low,Medium,High;
            DataClassification = CustomerContent;
            Caption = 'Incident Rating';
        }
        field(31; "Incident Type"; Option)
        {
            OptionCaption = 'Hardware,Software';
            OptionMembers = Hardware,Software;
            DataClassification = CustomerContent;
            Caption = 'Incident Type';
        }
        field(32; Status; Option)
        {
            OptionCaption = 'Open,Pending,Solved,Escalated,Closed';
            OptionMembers = Open,Pending,Solved,Escalated,Closed;
            DataClassification = CustomerContent;
            Caption = 'Status';

            trigger OnValidate()
            begin


            end;
        }
        field(33; "Escalate To"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
            DataClassification = CustomerContent;
            Caption = 'Escalate To';

            trigger OnValidate()
            var
                EscalateToOnselfErr: Label 'You can not escalate a case to yourself';
            begin
                if "Escalate To" = UserId() then
                    Error(EscalateToOnselfErr);

                UserSetup.Get("Escalate To");
                UserSetup.TestField("E-Mail");

                "Escalate To Email" := UserSetup."E-Mail";
            end;
        }
        field(34; "Escalation Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Escalation Date';
        }
        field(35; "Screen Shot"; BLOB)
        {
            DataClassification = CustomerContent;
            SubType = Bitmap;
            Caption = 'Screen Shot';
        }
        field(36; "Action By"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Action By';
        }
        field(37; "Delegated To"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Delegated To';
        }
        field(38; "Delegated To Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Delegated To Name';
        }
        field(39; "Delegated User ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Delegated User ID';
        }
        field(40; "Incident Cause"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Incident Cause';
        }
        field(41; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(42; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(43; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                //ShowDimensions;
            end;

            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }
        field(44; "Linked Risk"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Linked Risk';
        }
        field(45; "Rejection reason"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Rejection reason';
        }
        field(46; "Linked Risk Description"; Blob)
        {
            DataClassification = CustomerContent;
            Caption = 'Linked Risk Description';
        }
        field(47; "Responsibility Center"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center".Code;
            Caption = 'Send Request To';

            trigger OnValidate()
            var
                UserSetup: Record "User Setup";
                Resp: Record "Responsibility Center";
            begin
                if "Responsibility Center" <> '' then begin
                    if Resp.Get("Responsibility Center") then begin
                        Resp.TestField("E-Mail");
                        Resp.TestField("Head User");
                        "Responsible User E-Mail" := Resp."E-Mail";
                        "Responsible User HOD" := Resp."Head User";
                    end;
                end else begin
                    "Responsible User E-Mail" := '';
                    "Responsible User HOD" := '';
                end;

                /*UserSetup.SetRange("Request Admin", true);
                if UserSetup.FindFirst() then begin
                    UserSetup.Testfield("E-Mail");
                    "Responsible User HOD" := UserSetup."User ID";
                    "Responsible User E-Mail" := UserSetup."E-Mail";
                end else
                    Error('Please specify a Request Admin for %1 Responsibility Center in User Setup', "Responsibility Center"); */


            end;
        }
        field(48; "Responsible User HOD"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(49; "Responsible User E-Mail"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Escalate To Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Escalated By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Escalation Levels"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Level 1 Support,Level 2 Support,Level 3 Support,External Consultant';
            OptionMembers = "Level 1 Support","Level 2 Support","Level 3 Support","External Consultant";
            Caption = 'Escalation Level';

        }
        field(53; "Escalation Recommendation"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Incident Cause';
        }
        field(54; "Support Recommendation"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Incident Cause';
        }


    }

    keys
    {
        key(Key1; "Incident Reference")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Incident Reference", "Incident Description")
        {
        }
    }

    trigger OnInsert()
    begin
        if not ICTSetup.Get() then begin
            ICTSetup.Init();
            ICTSetup.Insert();
        end;

        if not HRSetup.Get() then begin
            HRSetup.Init();
            HRSetup.Insert();
        end;

        /*  case Type of
             Type::AUDIT,
             Type::Risk:
                 begin
                     HRSetup.TestField("Incidences Nos");
                     NoSeriesMgt.InitSeries(HRSetup."Incidences Nos", xRec."No. Series", Today, "Incident Reference", "No. Series");
                 end else
                         NoSeriesMgt.InitSeries(ICTSetup."Incidence Nos", xRec."No. Series", 0D, "Incident Reference", "No. Series");
         end; */

        User := UserId;
        ;
        if UserSetup.Get(UserId) then begin
            if Employee.Get(UserSetup."Employee No.") then begin
                "Employee No" := Employee."No.";
                "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                Validate("Employee No");
                "User email Address" := Employee."E-Mail";
                "Incident Date" := Today;
                "Incident Time" := Time;
                "Incident Status" := "Incident Status"::Unresolved;
                case Type of
                    Type::AUDIT:
                        begin
                            "Shortcut Dimension 1 Code" := Employee."Global Dimension 1 Code";
                            Validate("Shortcut Dimension 1 Code");
                            "Shortcut Dimension 2 Code" := Employee."Global Dimension 2 Code";
                            Validate("Shortcut Dimension 2 Code");
                        end;
                end;
            end;
        end;
    end;

    var
        HRSetup: Record "Human Resources Setup";
        Employee: Record Employee;
        ICTSetup: Record "ICT Setup";
        UserSetup: Record "User Setup";
        DimMgt: Codeunit DimensionManagement;
    // NoSeriesMgt: Codeunit NoSeriesManagement;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}
