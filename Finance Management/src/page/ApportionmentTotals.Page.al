page 51093 "Apportionment Totals"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Apportionment Totals';
    PageType = ListPart;
    SourceTable = "Apportionment Totals";
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    Caption = 'G/L Account No.';
                    ToolTip = 'Specifies the value of the G/L Account No. field';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    Caption = 'Total Amount';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Total Amount field';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SelectDocs)
            {
                Caption = 'Select Documents';
                Image = SelectEntries;
                ToolTip = 'Executes the Select Documents action';
                ///Promoted = true;
               // PromotedCategory = Process;
                //PromotedIsBig = true;
                Visible = not HeaderPosted;

                trigger OnAction()
                begin
                    Apportionment.LookupDocuments(Rec);
                end;
            }
        }
    }

    var
        ApportionHeader: Record "Apportion Header";
        Apportionment: Codeunit Apportionment;
        HeaderPosted: Boolean;

    trigger OnOpenPage()
    begin
        SetPageAppearance();
    end;

    trigger OnAfterGetRecord()
    begin
        SetPageAppearance();
    end;

    local procedure GetHeader()
    begin
        if ApportionHeader.Get(Rec."No.") then;
    end;

    local procedure SetPageAppearance()
    begin
        GetHeader();
        if ApportionHeader.Posted then
            HeaderPosted := true
        else
            HeaderPosted := false;
    end;
}
