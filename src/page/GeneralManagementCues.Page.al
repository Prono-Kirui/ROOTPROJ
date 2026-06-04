page 50024 "General Management Cues"
{
    Caption = 'General Management Cues';
    PageType = CardPart;
    SourceTable = "General Management Cue";
    RefreshOnActivate = true;

    /* layout
    {
        area(content)
        {
            cuegroup(Imprest)
            {
                field(Imprests; Rec.Imprests)
                {
                    DrillDownPageId = Imprests;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Imprests field';
                }
                field("Pending Imprests"; Rec."Pending Imprests")
                {
                    DrillDownPageId = "Pending Imprests";
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pending Imprests field';
                }
                field("Approved Imprest"; Rec."Approved Imprest")
                {
                    DrillDownPageId = "Approved Imprests";
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved Imprest field';
                }
                field("Imprest Surrenders"; Rec."Imprest Surrenders")
                {
                    DrillDownPageId = "Imprest Surrenders";
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Imprest Surrenders field';
                }
                field("Approved Imprest Surrenders"; Rec."Approved Imprest Surrenders")
                {
                    DrillDownPageId = "Approved Imprest Surrenders";
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved Imprest Surrenders field';
                }
            }
            cuegroup("Store request")
            {
                field("Store Request List"; Rec."Store Request List")
                {
                    DrillDownPageId = "Store Request List";
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Store Request List field';
                }
                field("Approved Store Request"; Rec."Approved Store Request")
                {
                    DrillDownPageId = "Approved Store Request";
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved Store Request field';
                }
            }
            cuegroup("Staff claims")
            {
                field("Staff Claims List"; Rec."Staff Claims List")
                {
                    DrillDownPageId = "Staff Claim List";
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Staff Claims List field';
                }
                field("Pending Staff Claim List"; Rec."Pending Staff Claim List")
                {
                    DrillDownPageId = "Pending Staff Claim List";
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pending Staff Claim List field';
                }
                field("Approved Staff Claim"; Rec."Approved Staff Claim")
                {
                    DrillDownPageId = "Approved Staff Claim";
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved Staff Claim field';
                }
            }
            cuegroup("Leave")
            {
                field("Leave Application List"; Rec."Leave Application List")
                {
                    DrillDownPageId = "Leave Application List";
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Leave Application List field';
                }
                field("Pending Leave Applications"; Rec."Pending Leave Applications")
                {
                    DrillDownPageId = "Leave Application List";
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pending Leave Applications field';
                }
                field("Approved Leave Applications"; Rec."Approved Leave Applications")
                {
                    DrillDownPageId = "Leave Application List";
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved Leave Applications field';
                }
            }
            cuegroup("Purchase Request")
            {
                field("Purchase Request List"; Rec."Purchase Request List")
                {
                    DrillDownPageId = "Purchase Request List";
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purchase Request List field';
                }
                field("Purchase Request Approved"; Rec."Purchase Request Approved")
                {
                    DrillDownPageId = "Purchase Request Approved";
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purchase Request Approved field';
                }
            }
            cuegroup("Training Request")
            {
                field("Training Request List"; Rec."Training Request List")
                {
                    DrillDownPageId = "Training Request List";
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Training Request List field';
                }
                field("Approved Training Request List"; Rec."Approved Training Request List")
                {
                    DrillDownPageId = "Approved Training Request List";
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved Training Request List field';
                }
            }
            cuegroup("Travel Request")
            {
                field("Transport Requests"; Rec."Transport Requests")
                {
                    DrillDownPageId = "Transport Request";
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transport Requests field';
                }
                field("Approved Travel Requests"; Rec."Approved Travel Requests")
                {
                    DrillDownPageId = "Transport Request";
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved Travel Requests field';
                }
            }
            cuegroup(Approvals)
            {
                Caption = 'Approvals';
                Visible = true;

                field("Requests to Approve"; Rec."Requests to Approve")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Requests to Approve";
                    ToolTip = 'Specifies the value of the Requests to Approve field';
                }
                field("Requests Sent for Approval"; Rec."Requests Sent for Approval")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Approval Request Entries";
                    ToolTip = 'Specifies the value of the Requests Sent for Approval field';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange("User ID Filter", UserId);

        if not Rec.Get('') then begin
            Rec.Init();
            Rec.Insert();
        end;

    end; */
}





