Table 50295 "Credit Reference Bureau"
{
    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(2; Surname; Text[50])
        {
        }
        field(3; Forename1; Text[50])
        {
        }
        field(4; Forename2; Text[50])
        {
        }
        field(5; Forename3; Text[50])
        {
        }
        field(6; "Trading As"; Text[20])
        {
        }
        field(7; "Date of Birth"; Text[30])
        {
        }
        field(8; "Client Number"; Code[10])
        {
        }
        field(9; "Account Number"; Code[10])
        {
        }
        field(10; "Old Account Number"; Code[10])
        {
        }
        field(11; Gender; Code[10])
        {
        }
        field(12; Nationality; Code[5])
        {
        }
        field(13; "Marital Status"; Code[1])
        {
        }
        field(14; "Primary Ident Doc Type"; Code[3])
        {
        }
        field(15; "Primary Ident Doc No"; Code[15])
        {
        }
        field(16; "Secondary Ident Doc Type"; Code[3])
        {
        }
        field(17; "Secondary Ident Doc No"; Code[20])
        {
        }
        field(18; "Other Ident Doc Type"; Code[3])
        {
        }
        field(19; "Other Ident Doc No"; Code[15])
        {
        }
        field(20; "Passport Country Code"; Code[3])
        {
        }
        field(21; "Mobile Telephone No"; Code[15])
        {
        }
        field(22; "Home Telephone No"; Code[15])
        {
        }
        field(23; "Work Telephone No"; Code[15])
        {
        }
        field(24; "Postal Address 1"; Code[50])
        {
        }
        field(25; "Postal Address 2"; Code[50])
        {
        }
        field(26; "Postal Location Town"; Text[30])
        {
        }
        field(27; "Postal Location Country"; Text[30])
        {
        }
        field(28; "Post Code"; Code[20])
        {
        }
        field(29; "Physical Address 1"; Text[50])
        {
        }
        field(30; "Physical Address 2"; Text[50])
        {
        }
        field(31; "Plot Number"; Code[10])
        {
        }
        field(32; "Location Town"; Text[20])
        {
        }
        field(33; "Location Country"; Code[3])
        {
        }
        field(34; "Type of Residency"; Code[1])
        {
        }
        field(35; "PIN Number"; Code[15])
        {
        }
        field(36; "Consumer E-Mail"; Text[50])
        {
        }
        field(37; "Employer Name"; Text[40])
        {
        }
        field(38; "Occupational Industry Type"; Code[3])
        {
        }
        field(39; "Employment Date"; Code[10])
        {
        }
        field(40; "Employment Type"; Code[3])
        {
        }
        field(41; "Income Amount"; Text[30])
        {
        }
        field(42; "Lenders Registered Name"; Text[50])
        {
        }
        field(43; "Lenders Trading Name"; Text[50])
        {
        }
        field(44; "Lenders Branch Name"; Text[20])
        {
        }
        field(45; "Lenders Branch Code"; Text[20])
        {
        }
        field(46; "Account Joint/Single Indicator"; Code[1])
        {
        }
        field(47; "Account Product Type"; Code[1])
        {
        }
        field(48; "Date Account Opened"; Code[10])
        {
        }
        field(49; "Instalment Due Date"; Text[30])
        {
        }
        field(50; "Original Amount"; Text[30])
        {
        }
        field(51; "Currency of Facility"; Code[3])
        {
        }
        field(52; "Current Balance in KES"; Text[30])
        {
        }
        field(53; "Current Balance"; Text[30])
        {
        }
        field(54; "Overdue Balance"; Text[30])
        {
        }
        field(55; "Overdue Date"; Text[30])
        {
        }
        field(56; "Nr of Days In Arrears"; Text[10])
        {
        }
        field(57; "Nr of Instalments In Arrears"; Text[10])
        {
        }
        field(58; "Prudential Risk Classification"; Code[1])
        {
        }
        field(59; "Account Status"; Code[1])
        {
        }
        field(60; "Account Status Date"; Text[30])
        {
        }
        field(61; "Account Closure Reason"; Text[50])
        {
        }
        field(62; "Repayment Period"; Text[10])
        {
        }
        field(63; "Deferred Payment Date"; Code[10])
        {
        }
        field(64; "Deferred Payment Amount"; Text[10])
        {
        }
        field(65; "Payment Frequency"; Code[1])
        {
        }
        field(66; "Disbursement Date"; Text[30])
        {
        }
        field(67; "Next Instalment Amount"; Text[10])
        {
        }
        field(68; "Date of Latest Payment"; Text[30])
        {
        }
        field(69; "Last Payment Amount"; Text[30])
        {
        }
        field(70; "Type of Security"; Code[1])
        {
        }
        field(71; "Group ID"; Code[10])
        {
        }
    }
    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
