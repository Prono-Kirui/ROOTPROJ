report 50080 "Update Customer"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './Layouts/customerupdate.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Customer; Customer)
        {
            column(No_; "No.")
            {

            }
            trigger OnAfterGetRecord()
            begin
                if Customer.get("No.") then
                    Customer."Customer Type" := "Customer Type"::Member;
                Customer."Customer Posting Group" := 'MEMBER';
                Customer.Modify();
            end;
        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(LayoutName)
                {

                }
            }
        }
    }



    var
        myInt: Integer;
        cust: Record Customer;
}