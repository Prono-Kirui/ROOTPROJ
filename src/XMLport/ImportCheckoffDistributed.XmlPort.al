XmlPort 50102 "Import Checkoff Distributed"
{
    Format = VariableText;

    schema
    {
        //"Checkoff Lines-Distributed"
        textelement(root)
        {
            tableelement("Checkoff Lines-Distributed";
            "Checkoff Lines-Distributed")
            {
                XmlName = 'Paybill';

                fieldelement(Header_No;
                "Checkoff Lines-Distributed"."Checkoff No")
                {
                    MinOccurs = Zero;
                }
                fieldelement(MemberNo;
                "Checkoff Lines-Distributed"."Member No")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Deposits;
                "Checkoff Lines-Distributed".Deposits)
                {
                    MinOccurs = Zero;
                }

                fieldelement(TotalAmount;
                "Checkoff Lines-Distributed".TOTAL_DISTRIBUTED)
                {
                    MinOccurs = Zero;
                }



            }
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
}
