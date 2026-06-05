page 51086 "Apportionment Allocation Lines"
{
    ApplicationArea = All;
    Caption = 'Apportionment Allocation Lines';
    PageType = ListPart;
    SourceTable = "Apportionment Allocation";
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field(Company; Rec.Company)
                {
                    Caption = 'Company';
                    ToolTip = 'Specifies the value of the Company field';
                }
                field(Type; Rec.Type)
                {
                    Caption = 'Type';
                    ToolTip = 'Specifies the value of the Type field';
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = Rec."Type" = Rec."Type"::Amount;
                    ShowCaption = false;
                    ToolTip = 'Specifies the value of the Amount field';
                    Visible = Rec."Type" = Rec."Type"::Amount;
                }
                field(Allocation; Rec.Allocation)
                {
                    Caption = 'Allocation (%)';
                    ToolTip = 'Specifies the value of the Allocation (%) field';
                }
            }
        }
    }
}
