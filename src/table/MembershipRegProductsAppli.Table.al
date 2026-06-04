#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50509 "Membership Reg. Products Appli"
{
    DrillDownPageID = "Membership App Products";
    LookupPageID = "Membership App Products";

    fields
    {
        field(1; "Membership Applicaton No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Membership Applications"."No.";
        }
        field(2; Names; Text[50])
        {
            NotBlank = true;
            TableRelation = "Membership Applications".Name;
        }
        field(3; Product; Code[20])
        {
            TableRelation = if ("Account Category" = filter(Single)) "Account Types-Saving Products".Code where("Corporate Account" = filter(false))
            else if ("Account Category" = filter(Corporate)) "Account Types-Saving Products".Code where("Corporate Account" = filter(true));

            trigger OnValidate()
            begin
                AccountTypes.Reset;
                AccountTypes.SetRange(AccountTypes.Code, Product);
                if AccountTypes.Find('-') then begin
                    "Product Source" := AccountTypes."Activity Code";
                    "Product Name" := AccountTypes.Description;

                    "Show On List" := AccountTypes."Show On List";
                end;
            end;
        }
        field(4; "Product Source"; Option)
        {
            OptionCaption = 'BOSA,FOSA,MICRO';
            OptionMembers = BOSA,FOSA,MICRO;
        }
        field(5; "Product Name"; Text[50])
        {
        }
        field(6; "Default Product"; Boolean)
        {
        }
        field(7; "Show On List"; Boolean)
        {
        }
        field(8; "Account Category"; Option)
        {
            OptionCaption = 'Single,Joint,Corporate,Group,Parish,Church,Church Department';
            OptionMembers = Single,Joint,Corporate,Group,Parish,Church,"Church Department";
        }
    }

    keys
    {
        key(Key1; "Membership Applicaton No", Product, "Product Name", "Account Category")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        AccountTypes: Record "Account Types-Saving Products";
        ObjMembershipApp: Record "Membership Applications";
}

