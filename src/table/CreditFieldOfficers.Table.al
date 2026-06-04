#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50965 "Credit/Field Officers"
{
    DrillDownPageID = "Credit/Field Officers";
    LookupPageID = "Credit/Field Officers";

    fields
    {
        field(1; "User ID"; Code[20])
        {
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //   ObjUserMgt.LookupUserID("User ID");
            end;

            trigger OnValidate()
            begin

                // ObjUserMgt.ValidateUserID("User ID");

                ObjUsers.Reset;
                ObjUsers.SetRange("User ID", "User ID");
                if ObjUsers.Find('-') then begin
                    // "Credit Officer" := ObjUsers."Credit Officer";
                    Branch := ObjUsers."Branch Code";
                end;
            end;
        }
        field(2; Branch; Code[30])
        {
        }
        field(3; "Credit Officer"; Boolean)
        {
        }
        field(4; "Field Officer"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "User ID", Branch, "Credit Officer")
        {
        }
    }

    var
        ObjUsers: Record "User Setup";
        ObjUserMgt: Codeunit "User Management";
}

