pageextension 50017 "FA Card General Ext" extends "Fixed Asset Card"
{

    layout
    {
        addlast(factboxes)
        {
            part(FixedAssetBarcode; "Fixed Asset Barcode")
            {
                ApplicationArea = FixedAssets;
                Caption = 'Fixed Asset Barcode';
                SubPageLink = "No." = FIELD("No.");
            }
        }
    }
    actions
    {

        addlast(processing)
        {
            action(GenerateBarcode)
            {
                Caption = 'Generate Barcode';
                Image = BarCode;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                ToolTip = 'Generates a Fixed Asset Barcode';

                trigger OnAction()
                begin
                    GeneralManagement.GenerateFABarcode(Rec."No.");
                end;
            }
        }
    }

    var
        GeneralManagement: Codeunit "General Management";
}









