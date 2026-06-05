page 51124 "Payment Amounts Factbox"
{
    ApplicationArea = All;
    Caption = 'Payment Amounts Factbox';
    PageType = CardPart;
    SourceTable = Payments;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                ShowCaption = false;

                field("Total Amount"; Rec."Total Amount")
                {
                    Caption = 'Total Amount';
                    ToolTip = 'Specifies the value of the Total Amount field';
                }
                field("Total Amount (LCY)"; Rec."Total Amount (LCY)")
                {
                    Caption = 'Total Amount (LCY)';
                    ToolTip = 'Specifies the value of the Total Amount (LCY) field.';
                }
                field("Total VAT Amount"; Rec."Total VAT Amount")
                {
                    Caption = 'Total VAT Amount';
                    ToolTip = 'Specifies the value of the Total VAT Amount field';
                }
                field("Total Witholding Tax Amount"; Rec."Total Witholding Tax Amount")
                {
                    Caption = 'Total Witholding Tax Amount';
                    ToolTip = 'Specifies the value of the Total Witholding Tax Amount field';
                }
                field("Total Witholding VAT Tax"; Rec."Total Witholding VAT Tax")
                {
                    Caption = 'Total Witholding VAT Tax';
                    ToolTip = 'Specifies the value of the Total Witholding VAT Tax field';
                }
                field("Total Retention Amount"; Rec."Total Retention Amount")
                {
                    Caption = 'Total Retention Amount';
                    ToolTip = 'Specifies the value of the Total Retention Amount field';
                }
                field("Total Net Amount"; Rec."Total Net Amount")
                {
                    Caption = 'Total Net Amount';
                    ToolTip = 'Specifies the value of the Total Net Amount field';
                }
                field("Total Payment Amount LCY"; Rec."Total Payment Amount LCY")
                {
                    Caption = 'Total Net Amount (LCY)';
                    ToolTip = 'Specifies the value of the Total Payment Amount LCY field';
                }
            }
        }
    }
}
