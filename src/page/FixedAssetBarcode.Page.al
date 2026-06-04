page 50010 "Fixed Asset Barcode"
{
    Caption = 'Fixed Asset Barcode';
    PageType = CardPart;
    SourceTable = "Fixed Asset";

    layout
    {
        area(content)
        {
            field(Barcode; Rec.Barcode)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Barcode field.';
                ShowCaption = false;
            }
        }
    }
}





