Page 50780 "BOSA Cue"
{
    PageType = CardPart;
    SourceTable = "Members Cues";
    UsageCategory = Lists;
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            cuegroup(Group1)
            {
                Caption = 'MemberShip Accounts ';

                // CuegroupLayout = Wide;
                field("All Members"; Rec."All Members")
                {
                    ApplicationArea = Basic;
                    Image = Info;
                    Style = Favorable;
                    StyleExpr = true;
                    DrillDownPageId = "Member List";


                }
                field("Active Members"; Rec."Active Members")
                {
                    ApplicationArea = Basic;
                    Image = People;
                    Style = Favorable;
                    StyleExpr = true;
                    DrillDownPageId = "Member List";
                }
                field("NonActive Mbrs"; Rec."NonActive Mbrs")
                {
                    Caption = 'Dormant Members';
                    ApplicationArea = Basic;
                    Image = People;
                    Style = Favorable;
                    StyleExpr = true;
                    DrillDownPageId = "Member List";
                }
                field("Withdrawal Members"; Rec."Withdrawal Members")
                {
                    Caption = 'Withdrawal Members';
                    ApplicationArea = Basic;
                    Image = People;
                    Style = Favorable;
                    StyleExpr = true;
                    DrillDownPageId = "Member List";
                }
                //Deceased
                field("Deceased Members"; Rec."Deceased Members")
                {
                    Caption = 'Deceased Members';
                    ApplicationArea = Basic;
                    Image = People;
                    Style = Unfavorable;
                    StyleExpr = true;
                    DrillDownPageId = "Member List";
                }
                field("Male"; Rec."Male Members")
                {
                    ApplicationArea = Basic;
                    Image = People;
                    Style = Strong;
                    StyleExpr = true;
                    DrillDownPageId = "Member List";


                }
                field("Female"; Rec."FaMale Members")
                {
                    ApplicationArea = Basic;
                    Caption = 'Female Members';
                    Image = People;
                    Style = StrongAccent;
                    StyleExpr = true;
                    DrillDownPageId = "Member List";
                }

            }
            cuegroup("MC Members")
            {
                Caption = 'MC Member Accounts ';
                Visible = false;
                field("All MC Mbrs"; Rec."All CEEP Mbrs")
                {
                    Caption = 'All MC Mbrs';
                    ApplicationArea = Basic;
                    Image = none;

                    Style = Favorable;
                    StyleExpr = true;
                    DrillDownPageId = "Member List";
                }
                field("Active MC Mbrs"; Rec."Active CEEP Mbrs")
                {
                    Caption = 'Active MC Mbrs';
                    ApplicationArea = Basic;
                    Image = none;
                    Style = Favorable;
                    StyleExpr = true;
                    DrillDownPageId = "Member List";
                }
                field("InActive MC Mbrs"; Rec."Inactive CEEP Mbrs")
                {
                    Caption = 'Inactive MC Mbrs';
                    ApplicationArea = Basic;
                    Image = none;
                    Style = Favorable;
                    StyleExpr = true;
                    DrillDownPageId = "Member List";
                }
                field("MC Groups"; Rec."CEEP Groups")
                {
                    Caption = 'MC Groups';
                    ApplicationArea = Basic;
                    Image = none;
                    Style = Favorable;
                    StyleExpr = true;
                    DrillDownPageId = "Member List";
                }
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        if not Rec.Get(UserId) then begin
            Rec.Init;
            Rec."User ID" := UserId;
            Rec.Insert;
        end;
    end;
}
