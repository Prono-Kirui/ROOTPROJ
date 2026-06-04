pageextension 50004 "Company Info Pag Ext" extends "Company Information"
{
    layout
    {
        addafter("Bank Branch No.")
        {
            field("Bank Branch Name"; Rec."Bank Branch Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bank Branch Name field';
            }
        }
        addafter(Communication)
        {
            group("Bank Details")
            {
                Caption = 'Company Bank Details';
                field("Company Bank Details"; BankDetailsText)
                {
                    MultiLine = true;
                    ApplicationArea = All;
                    Caption = 'Company Bank Details';
                    ToolTip = 'Specifies the value of the Company Bank Details field';

                    trigger OnValidate()
                    begin
                        Rec.CalcFields("Company Bank Details");
                        Rec."Company Bank Details".CreateInStream(InStr);
                        BankDetailsBigText.Read(InStr);

                        if BankDetailsText <> Format(BankDetailsBigText) then begin
                            Clear(Rec."Company Bank Details");
                            Clear(BankDetailsBigText);
                            BankDetailsBigText.AddText(BankDetailsText);
                            Rec."Company Bank Details".CreateOutStream(OutStr);
                            BankDetailsBigText.Write(OutStr);
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Company Bank Details");
        Rec."Company Bank Details".CreateInStream(InStr);
        BankDetailsBigText.Read(InStr);
        BankDetailsText := Format(BankDetailsBigText);
    end;

    var
        BankDetailsBigText: BigText;
        InStr: InStream;
        OutStr: OutStream;
        BankDetailsText: Text;
}





