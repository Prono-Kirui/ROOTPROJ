Page 50982 "General Cue"
{
    PageType = CardPart;
    SourceTable = "Members Cues";

    layout
    {
        area(content)
        {
            cuegroup(ApprovalRequestCue)
            {
                Caption = 'Approval Requests';

                field("Requests Sent for Approval"; Rec."Requests Sent for Approval")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "Approval Entries";
                }
                field("Requests to Approve"; Rec."Requests to Approve")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "Requests to Approve";
                }
            }
            cuegroup(ApprovalRequestCue2)
            {
                Caption = 'Approval Requests2';
                Visible = false;

                field("Requests Sent for Approval2"; Rec."Requests Sent for Approval")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "Approval Entries";
                }
                field("Requests to Approve2"; Rec."Requests to Approve")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "Requests to Approve";
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
