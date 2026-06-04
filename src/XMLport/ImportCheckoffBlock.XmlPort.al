XmlPort 50100 "Import Checkoff Block"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("ReceiptsProcessing_L-Checkoff";
            "ReceiptsProcessing_L-Checkoff")
            {
                XmlName = 'checkoff';

                fieldelement(No;
                "ReceiptsProcessing_L-Checkoff"."Receipt Header No")
                {
                }
                fieldelement(Mobile_No;
                "ReceiptsProcessing_L-Checkoff"."Staff/Payroll No")
                {
                }
                fieldelement(Amount;
                "ReceiptsProcessing_L-Checkoff".Amount)
                {
                }
                fieldelement(Header_No;
                "ReceiptsProcessing_L-Checkoff"."Employer Code")
                {
                }
                fieldelement(Transaction_No;
                "ReceiptsProcessing_L-Checkoff"."Receipt Line No")
                {
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
