page 50089 "Disbursed Loan Trunches"
{
    ApplicationArea = All;
    Caption = 'Disbursed Loan Trunches';
    PageType = ListPart;
    SourceTable = "Partial Loan Disbursments";
    SourceTableView = where("Disbursement Number" = filter(<> 0),
                            "Posted" = filter(true));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No"; Rec."Document No")
                {
                    ToolTip = 'Specifies the value of the Document No field.';
                }
                field("Disbursement Number"; Rec."Disbursement Number")
                {
                    ToolTip = 'Specifies the value of the Disbursement Number field.';
                }
                field("Amount To Disburse"; Rec."Amount To Disburse")
                {
                    Caption = 'Disbursed Amount';
                    ToolTip = 'Specifies the value of the Amount To Disburse field.';
                }
                field("Captured By"; Rec."Captured By")
                {
                    ToolTip = 'Specifies the value of the Captured By field.';
                }
                field("Approved By"; Rec."Approved By")
                {
                    ToolTip = 'Specifies the value of the Approved By field.';
                }
                field("Date Disbursed"; Rec."Date Disbursed")
                {
                    ToolTip = 'Specifies the value of the Date Disbursed field.';
                }
                field("Posted By"; Rec."Posted By")
                {
                    ToolTip = 'Specifies the value of the Posted By field.';
                }
                field("Remaining Amount To Disburse"; Rec."Remaining Amount To Disburse")
                {
                    ToolTip = 'Specifies the value of the Remaining Amount To Disburse field.';
                }
                field("Total Disbursed Amount"; Rec."Total Disbursed Amount")
                {
                    ToolTip = 'Specifies the value of the Total Disbursed Amount field.';
                }
            }
        }
    }
}
