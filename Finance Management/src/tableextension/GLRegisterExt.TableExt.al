tableextension 51010 GLRegisterExt extends "G/L Register"
{
    fields
    {
        field(51000; "Document No."; Code[50])
        {
            CalcFormula = lookup("G/L Entry"."Document No." where("Entry No." = field("From Entry No.")));
            Caption = 'Document No.';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}
