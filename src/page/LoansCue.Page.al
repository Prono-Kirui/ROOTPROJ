Page 50479 "Loans Cue"
{
    PageType = CardPart;
    SourceTable = "loans Cuess";
    UsageCategory = Lists;
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            cuegroup(Group1)
            {
                Caption = 'BOSA LOANS ';

                field("New Applied Loans"; Rec."Applied Loans")
                {
                    ApplicationArea = Basic;
                    Image = Info;
                    Style = Favorable;
                    StyleExpr = true;
                    DrillDownPageId = "Loans Applied  List";
                }
                field("Active Loans"; Rec."Active Loans")
                {
                    ApplicationArea = Basic;
                    Image = Info;
                    Style = Favorable;
                    StyleExpr = true;
                    drillDownPageId = "Loans Posted List";
                }
                field("Pending Loans"; Rec."Pending Loans")
                {
                    ApplicationArea = Basic;
                    Image = Info;
                    Style = Favorable;
                    StyleExpr = true;
                    DrillDownPageId = "Loans Posted List";
                }
                field("Emergency Loans"; Rec."Emergency Loans")
                {
                    ApplicationArea = Basic;
                    Image = Info;
                    Style = Favorable;
                    StyleExpr = true;
                    DrillDownPageId = "Loans Posted List";
                }
                //MEDICAL
                field("Normal Loans"; Rec."Normal Loans")
                {
                    ApplicationArea = Basic;
                    Caption = 'Medical Loans';
                    Image = Info;
                    Style = Favorable;
                    StyleExpr = true;
                    DrillDownPageId = "Loans Posted List";
                }
                //school
                field("School Loans"; Rec."School Loans")
                {
                    ApplicationArea = Basic;
                    Image = Info;
                    Style = Favorable;
                    StyleExpr = true;
                    DrillDownPageId = "Loans Posted List";
                }
                //development
                field("Development Loans"; Rec."Development Loans")
                {
                    ApplicationArea = Basic;
                    Image = Info;
                    Style = Favorable;
                    StyleExpr = true;
                    DrillDownPageId = "Loans Posted List";
                }
                //Defaulter
                field("Defaulter Loans"; Rec."Defaulter Loans")
                {
                    ApplicationArea = Basic;
                    Image = Info;
                    Style = Unfavorable;
                    StyleExpr = true;
                    DrillDownPageId = "Loans Posted List";
                }


            }

            cuegroup(Group3)
            {
                Caption = 'MICRO LOANS ';
                Visible = false;
                field("Applied Micro Loans"; Rec."Applied Micro Loans")
                {
                    ApplicationArea = Basic;
                    Image = none;
                    Style = Favorable;
                    StyleExpr = true;
                    // DrillDownPageId = "Role Centre Loans Drill Down";
                }
                field("Pending Micro Loans"; Rec."Pending Micro Loans")
                {
                    ApplicationArea = Basic;
                    Image = none;
                    Style = Favorable;
                    StyleExpr = true;
                    // DrillDownPageId = "Role Centre Loans Drill Down";
                }
                field("Approved Micro Loans"; Rec."Active Micro Loans")
                {
                    ApplicationArea = Basic;
                    Image = none;
                    Style = Favorable;
                    StyleExpr = true;
                    //DrillDownPageId = "Role Centre Loans Drill Down";
                }
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        begin
            // Ensure a record exists and calculate FlowFields
            if not Rec.Get('') then begin
                Rec.Init();
                Rec."Primary Key" := '';
                Rec.Insert();
            end;
            Rec.CalcFields("Applied Loans", "Active Loans", "Pending Loans",
                          "Applied FOSA Loans", "Active FOSA Loans", "Pending FOSA Loans",
                          "Applied MICRO Loans", "Active MICRO Loans", "Pending MICRO Loans",
                          "Normal Loans", "School Loans", "Development Loans", "Emergency Loans");
        end;
    end;
}
