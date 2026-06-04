page 50092 "Shares Transfer Schedule"
{
    ApplicationArea = All;
    Caption = 'Shares Transfer Schedule';
    PageType = ListPart;
    SourceTable = "Shares Transfer List";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Reference No"; Rec."Reference No")
                {
                    ToolTip = 'Specifies the value of the Reference No field.';
                    Editable = false;
                    Enabled = false;
                }
                field("Member No"; Rec."Member No")
                {
                    ToolTip = 'Specifies the value of the Member No field.';
                    TableRelation = customer."No.";

                    trigger OnValidate()
                    var
                        CustomerTable: Record Customer;
                    begin
                        CustomerTable.reset();
                        CustomerTable.SetRange(CustomerTable."No.", Rec."Member No");
                        if CustomerTable.find('-') then begin
                            Rec."Member Name" := CustomerTable.Name;
                        end;
                    end;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Member Name field.';
                    Editable = false;
                    Enabled = false;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.';

                    trigger OnValidate()
                    begin
                        FnUpdateControls();
                    end;
                }
                field("Shares Currently"; Rec."Shares Currently")
                {
                    Enabled = false;
                    Style = Strong;
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                    Enabled = AmountEnabled;
                    Style = Strong;
                }
            }
        }
    }
    var
        AmountEnabled: Boolean;

    local procedure FnUpdateControls()
    begin
        if Rec."Transaction Type" = Rec."Transaction Type"::" " then begin
            AmountEnabled := false;
        end
        else if Rec."Transaction Type" <> Rec."Transaction Type"::" " then begin
            AmountEnabled := true;
        end;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        FnUpdateControls();
    end;

    trigger OnOpenPage()
    begin
        FnUpdateControls();
    end;
}
