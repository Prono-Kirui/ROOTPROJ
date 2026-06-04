Table 50255 "Appraisal Salary Set-up"
{
    // DrillDownPageID = "Appraisal Salary Set-up";
    // LookupPageID = "Appraisal Salary Set-up";

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
        }
        field(3; Type; Option)
        {
            OptionCaption = ' ,Earnings,Deductions,Basic,Asset,Liability,Rental,Farming';
            OptionMembers = " ",Earnings,Deductions,Basic,Asset,Liability,Rental,Farming;
        }
        field(4; "Statutory Ded"; Boolean)
        {
            trigger OnValidate()
            begin
                //"AppraisalSDetails`".RESET;
                //"AppraisalSDetails`".SETRANGE("AppraisalSDetails`".Code,)
                AppraisalSDetails.Statutory := "Statutory Ded";
            end;
        }
        field(5; "Statutory Amount"; Decimal)
        {
        }
        field(6; "Statutory(%)"; Decimal)
        {
        }
        field(7; "Long Term Deductions"; Boolean)
        {
        }
        field(8; bASIC; Boolean)
        {
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
    var
        AppraisalSDetails: Record "Loan Appraisal Salary Details";
}
