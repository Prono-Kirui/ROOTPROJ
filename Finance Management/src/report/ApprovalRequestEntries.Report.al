report 51029 "Approval Request Entries"
{
    ApplicationArea = All;
    Caption = 'Approval Request Entries';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/GlvsApprovalEntries.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(ApprovalEntry; "Approval Entry")
        {
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    Caption = 'GroupName';
                }
            }
        }
    }
}
