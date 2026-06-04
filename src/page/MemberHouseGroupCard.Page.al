#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50762 "Member House Group Card"
{
    PageType = Card;
    SourceTable = "Member House Groups";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Cell Group Code"; Rec."Cell Group Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cell Group Name"; Rec."Cell Group Name")
                {
                    ApplicationArea = Basic;
                }
                field("Date Formed"; Rec."Date Formed")
                {
                    ApplicationArea = Basic;
                }
                field("Meeting Date"; Rec."Meeting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Group Leader"; Rec."Group Leader")
                {
                    ApplicationArea = Basic;
                }
                field("Group Leader Name"; Rec."Group Leader Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Group Leader Email"; Rec."Group Leader Email")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Group Leader Phone No"; Rec."Group Leader Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Assistant group Leader"; Rec."Assistant group Leader")
                {
                    ApplicationArea = Basic;
                }
                field("Assistant Group Name"; Rec."Assistant Group Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Assistant Group Leader Email"; Rec."Assistant Group Leader Email")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Assistant Group Leader Phone N"; Rec."Assistant Group Leader Phone N")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Credit Officer"; Rec."Credit Officer")
                {
                    ApplicationArea = Basic;
                    Caption = 'Credit Officer';
                }
                field("Field Officer"; Rec."Field Officer")
                {
                    ApplicationArea = Basic;
                }
                field("Meeting Place"; Rec."Meeting Place")
                {
                    ApplicationArea = Basic;
                }
                field("No of Members"; Rec."No of Members")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            // part(Control12; "Cell Group Members Subpage")
            // {
            //     SubPageLink = "Member House Group" = field("Cell Group Code");
            // }
        }
    }

    actions
    {
        area(creation)
        {
            action("House Group Statement Internal")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedOnly = true;

                trigger OnAction()
                begin
                    ObjCellGroups.Reset;
                    ObjCellGroups.SetRange(ObjCellGroups."Cell Group Code", Rec."Cell Group Code");
                    if ObjCellGroups.Find('-') then
                        Report.Run(50920, true, false, ObjCellGroups);
                end;
            }
            action("House Group Statement")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedOnly = true;

                trigger OnAction()
                begin
                    ObjCellGroups.Reset;
                    ObjCellGroups.SetRange(ObjCellGroups."Cell Group Code", Rec."Cell Group Code");
                    if ObjCellGroups.Find('-') then
                        Report.Run(50946, true, false, ObjCellGroups);
                end;
            }
            action("Member Savings History")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    ObjCust.Reset;
                    ObjCust.SetRange(ObjCust."Member House Group", Rec."Cell Group Code");
                    if ObjCust.Find('-') then
                        Report.Run(50929, true, false, ObjCust);
                end;
            }
            action("Meetings Schedule")
            {
                ApplicationArea = Basic;
                Image = FORM;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Meetings Schedule";
                RunPageLink = "Lead No" = field("Cell Group Code");
            }
        }
    }

    var
        ObjCellGroups: Record "Member House Groups";
        ObjCust: Record Customer;
}