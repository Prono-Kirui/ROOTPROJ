pageextension 50018 "FA List Gen Ext" extends "Fixed Asset List"
{
    actions
    {
        addlast(processing)
        {
            action("Generate Multiple Barcodes")
            {
                Caption = 'Generate Multiple Barcodes';
                Promoted = true;
                Image = BarCode;
                PromotedCategory = Process;
                ApplicationArea = All;
                ToolTip = 'Generates a Fixed Asset Barcode';

                trigger OnAction()
                var
                    GeneralManagement: Codeunit "General Management";
                begin
                    GeneralManagement.GenerateMultipleFABarcodes();
                end;
            }
        }
    }
}






