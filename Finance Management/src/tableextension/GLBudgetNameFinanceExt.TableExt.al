tableextension 51005 GLBudgetNameFinanceExt extends "G/L Budget Name"
{
    fields
    {
        field(51000; "Budget Status"; Option)
        {
            Caption = 'Budget Status';
            DataClassification = CustomerContent;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(51001; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(51002; "Budget Option"; Option)
        {
            Caption = 'Budget Option';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Budgeting,ReAllocation';
            OptionMembers = " ",Budgeting,ReAllocation;
        }
    }
}
