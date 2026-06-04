#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50415 "Checkoff Lines-Distributed"
{

    fields
    {
        field(1; "Payroll No"; Code[20])
        {
        }
        field(2; "Employee Name"; Text[150])
        {
        }
        field(3; "Member No"; Code[30])
        {
        }
        field(4; "Checkoff No"; Code[40])
        {
        }
        field(5; Deposits; Decimal)
        {
        }
        field(6; NORM_P; Decimal)
        {
        }
        field(7; NORM_I; Decimal)
        {
        }
        field(8; REFIN_P; Decimal)
        {
        }
        field(9; REFIN_I; Decimal)
        {
        }
        field(10; EMER_P; Decimal)
        {
        }
        field(11; EMER_I; Decimal)
        {
        }
        field(12; SCHOOL_P; Decimal)
        {
        }
        field(13; SCHOOL_I; Decimal)
        {
        }
        field(14; SPECIAL_P; Decimal)
        {
        }
        field(15; SPECIAL_I; Decimal)
        {
        }
        field(16; INSURANCE; Decimal)
        {
        }
        field(17; GOLDSAVE; Decimal)
        {
        }
        field(18; THIRDPARTY; Decimal)
        {
        }
        field(19; BENEVOLENT; Decimal)
        {
        }
        field(20; ADVANCE_P; Decimal)
        {
        }
        field(21; ADVANCE_I; Decimal)
        {
        }
        field(22; PHONE_P; Decimal)
        {
        }
        field(23; PHONE_I; Decimal)
        {
        }
        field(24; ADVANCENSE_P; Decimal)
        {
        }
        field(25; ADVANCENSE_I; Decimal)
        {
        }
        field(26; SHARES; Decimal)
        {
        }
        field(27; TOTAL_DISTRIBUTED; Decimal)
        {
            FieldClass = Normal;
        }
        field(28; "ID No"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Payroll No", "Checkoff No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record Customer;
}

