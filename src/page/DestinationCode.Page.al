page 50007 "Destination Code"
{
    PageType = List;
    SourceTable = Destination;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;

                field("Destination Code"; Rec."Destination Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Destination Code field';
                }
                field("Destination Name"; Rec."Destination Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Destination Name field';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Country/Region Code field';
                }
                field("Destination Type"; Rec."Destination Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Destination Type field';
                    Visible = false;
                }
                field("Other Area"; Rec."Other Area")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Other Area field';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        /* area(processing)
        {
            action("&Rates Setup")
            {
                Caption = '&Rates Setup';
                Image = ReceiptLines;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Destination Rate";
                RunPageLink = "Destination Code" = field("Destination Code");
                ApplicationArea = All;
                ToolTip = 'Executes the &Rates Setup action';
            }
        } */
    }
}





