pageextension 51089 "G/L Registers-Ext" extends "G/L Registers"
{
    layout
    {
        // Add changes to page layout here
        addafter("Creation Date")
        {
            //   field(Rec;Rec.)
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}