page 50091 "New Shares Transfer Card"
{
    ApplicationArea = All;
    Caption = 'Shares Transfer Card';
    PageType = Card;
    SourceTable = "Shares Transfer Header";
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Reference No"; Rec."Reference No")
                {
                    ToolTip = 'Specifies the value of the Reference No field.';
                    Editable = false;
                }
                field("Transfer Type"; Rec."Transfer Type")
                {
                    ToolTip = 'Specifies the value of the Transfer Type field.';

                    trigger OnValidate()
                    begin
                        FnUpdateControls();
                    end;
                }
                field("Member No"; Rec."Member No")
                {
                    ToolTip = 'Specifies the value of the Reference No field.';
                    Enabled = MembeEnabled;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Reference No field.';
                    Editable = false;
                    Enabled = false;
                }
                field("Shares Amount"; Rec."Shares Amount")
                {
                    ToolTip = 'Specifies the value of the Reference No field.';
                    Caption = 'Member Shares';
                    Editable = false;
                    Enabled = false;
                }
                field("Amount To Transfer"; Rec."Amount To Transfer")
                {
                    ToolTip = 'Specifies the value of the Reference No field.';
                }
                field("Transfer Description"; Rec."Transfer Description")
                {
                    ToolTip = 'Specifies the value of the Transfer Description field.';
                }
                field("Posting Date Used"; Rec."Posting Date Used")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                    Caption = 'Posting Date';
                }
                field("Line Amount To Transfer"; Rec."Line Amount To Transfer")
                {
                    ToolTip = 'Specifies the value of the Line Amount To Transfer field.';
                    Caption = 'Scheduled Transfer Amount';
                    Editable = false;
                    Enabled = false;
                    Style = AttentionAccent;
                }
                field("Charge Fee"; Rec."Charge Fee")
                {
                    ToolTip = 'Specifies the value of the Charge Fee field.';
                }
                field("Charges Amount"; Rec."Charges Amount")
                {
                    ToolTip = 'Specifies the value of the Charges Amount field.';
                    Caption = 'Charges Amount';
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Reference No field.';
                    Editable = false;
                    Enabled = false;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ToolTip = 'Specifies the value of the Captured By field.';
                    Editable = false;
                    Enabled = false;
                }
                field("Date Captured"; Rec."Date Captured")
                {
                    ToolTip = 'Specifies the value of the Date Captured field.';
                    Editable = false;
                    Enabled = false;
                }
            }
            part(Control1102760014; "Shares Transfer Schedule")
            {
                //Editable = TransfersEditable;
                SubPageLink = "Reference No" = field("Reference No");
                Caption = 'Shares Schedule';
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action("Refresh")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = RefreshLines;

                trigger OnAction()
                begin
                    CurrPage.Update();
                end;
            }
            action("Send Approval")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = SendApprovalRequest;
                Enabled = EnableSendApproval;

                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::Open then
                        Error('Only Open Requests can be sent for Approval !');

                    if Confirm('Send Approval Request ?', false) = false then begin
                        exit;
                    end
                    else begin
                        Rec.TestField("Amount To Transfer");
                        Rec.TestField("Member No");
                        Rec.TestField("Shares Amount");
                        Rec.CalcFields("Line Amount To Transfer");
                        Rec.Status := Rec.Status::Approved;
                        Rec.Modify(true);
                        if Rec."Line Amount To Transfer" <> Rec."Amount To Transfer" then Error('The Amount To Transfer MUST be equal to the scheduled amount !');
                        ApprovalsCodeUnit.SendShareTransApplicationsRequestForApproval(rec."Reference No", Rec);
                        CurrPage.Close();
                    end;
                    FnUpdateControls();
                    Message('Approval Request Sent Successfully');
                    CurrPage.Close();
                end;
            }
            action("Cancel Approval")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = Cancel;
                Enabled = CancelApproval;

                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::Pending then
                        Error('Only Pending Requests can be cancelled !');
                    if Confirm('Cancel Approval Request ?', false) = false then begin
                        exit;
                    end
                    else begin
                        ApprovalsCodeUnit.CancelShareTransApplicationsRequestForApproval(rec."Reference No", Rec);
                        CurrPage.Close();
                    end;
                    FnUpdateControls();
                end;
            }
        }
    }
    local procedure FnUpdateControls()
    begin
        if Rec."Transfer Type" = Rec."Transfer Type"::" " then begin
            MembeEnabled := false;
        end
        else if Rec."Transfer Type" <> Rec."Transfer Type"::" " then begin
            MembeEnabled := true;
        end;
        if Rec.Status = Rec.Status::Open then begin
            EnableSendApproval := true;
        end
        else if Rec.Status = Rec.Status::Pending then begin
            CancelApproval := true;
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

    var
        MembeEnabled: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        EnableSendApproval: Boolean;
        CancelApproval: Boolean;
        ApprovalsCodeUnit: Codeunit "Micropoint ApprovalsCodeUnit";
}
