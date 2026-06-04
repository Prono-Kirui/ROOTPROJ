Table 50451 "Main Sector"
{
    fields
    {
        field(1; "Code"; Code[20])
        {
            Editable = false;
        }
        field(2; Description; Text[100])
        {
            Editable = false;
        }
    }
    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
