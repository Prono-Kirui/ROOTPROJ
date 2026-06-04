XmlPort 50101 "Import Paybill Transactions"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Cust. Ledger Entry";
            "Cust. Ledger Entry")
            {
                XmlName = 'Paybill';

                fieldelement(No;
                "Cust. Ledger Entry"."Entry No.")
                {
                }
                fieldelement(Mobile_No;
                "Cust. Ledger Entry"."Document No.")
                {
                }
                fieldelement(Amount;
                "Cust. Ledger Entry".Amount)
                {
                }
                fieldelement(Header_No;
                "Cust. Ledger Entry"."Transaction Type")
                {
                }
                fieldelement(Transaction_No;
                "Cust. Ledger Entry"."Posting Date")
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
