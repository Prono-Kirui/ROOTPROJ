#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50812 "Member Accounts"
{
    // CardPageID = "Product Card";
    DeleteAllowed = false;
    Editable = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = Vendor;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic;
                    StyleExpr = CoveragePercentStyle;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(ActionGroup11)
            {
                action("Account Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = false;
                    trigger OnAction()
                    begin
                        ObjAccount.Reset;
                        ObjAccount.SetRange(ObjAccount."No.", Rec."No.");
                        if ObjAccount.Find('-') then
                            Report.Run(51516890, true, false, ObjAccount)
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetStyles;
    end;

    trigger OnOpenPage()
    begin
        Rec.SetFilter(Status, '<>%1', Rec.Status::Closed);
    end;

    var
        CoveragePercentStyle: Text;
        MinimumBalance: Decimal;
        ObjAccount: Record Vendor;

    local procedure SetStyles()
    begin
        MinimumBalance := 1000;
        if Rec.Balance = 0 then
            CoveragePercentStyle := 'Strong'
        else
            if Rec.Balance < MinimumBalance then
                CoveragePercentStyle := 'Unfavorable'
            else
                CoveragePercentStyle := 'Favorable';
    end;
}

