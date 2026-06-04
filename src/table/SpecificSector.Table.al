Table 50453 "Specific-Sector"
{
    fields
    {
        field(1; "Code"; Code[20])
        {
            Editable = false;
        }
        field(2; Description; Text[150])
        {
            Editable = false;
        }
        field(3; No; Code[20])
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
