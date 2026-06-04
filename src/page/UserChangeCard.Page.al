page 50005 "User Change Card"
{
    Caption = 'User Change Card';
    PageType = Card;
    SourceTable = "User Changes";
    PromotedActionCategories = 'New,Process,Report,Approvals';
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = Rec.Status = Rec.Status::Open;

                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                    Editable = false;
                }
                field("Change Type"; Rec."Change Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Change Type field.';
                }
                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User Name field.';
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reason field.';
                    MultiLine = true;
                    ShowMandatory = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable = false;
                }
                group("History")
                {
                    Editable = false;
                    field("Created By"; Rec."Created By")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Created By field.';
                    }
                    field(SystemCreatedAt; Rec.SystemCreatedAt)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                    }
                    field("Approved By"; Rec."Approved By")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Approved By field.';
                    }
                    field("Approved Date"; Rec."Approved Date")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Approved Date field.';
                    }
                    field(Posted; Rec.Posted)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Posted field.';
                    }
                }
            }
        }
    }

    /* actions
    {
        area(Processing)
        {
            action("Send Approval Request")
            {
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Enabled = Rec.Status = Rec.Status::Open;
                ApplicationArea = All;
                ToolTip = 'Executes the Send Approval Request action';

                trigger OnAction()
                begin
                    if Rec."Change Type" = Rec."Change Type"::" " then
                        Error('Please define a Change Type');

                    if ApprovalMgt.CheckUserChangesWorkflowEnabled(Rec) then
                        ApprovalMgt.OnSendUserChangesForApproval(Rec);
                    CurrPage.Close();
                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel Approval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Enabled = Rec.Status = Rec.Status::"Pending Approval";
                ApplicationArea = All;
                ToolTip = 'Executes the Cancel Approval Request action';

                trigger OnAction()
                begin
                    ApprovalMgt.OnCancelUserChangesRequest(Rec);
                    CurrPage.Close();
                end;
            }
            action("View Approvals")
            {
                Caption = 'View Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ApplicationArea = All;
                ToolTip = 'Executes the View Approvals action';

                trigger OnAction()
                var
                    Approvals: Record "Approval Entry";
                    ApprovalEntries: Page "Approval Entries";
                begin
                    Approvals.Reset();
                    Approvals.SetRange("Table ID", Database::"User Changes");
                    Approvals.SetRange("Document No.", Rec."Document No.");
                    ApprovalEntries.SetTableView(Approvals);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.Run();
                end;
            }

            action("Reset Password")
            {
                ApplicationArea = All;
                Enabled = Rec.Status = Rec.Status::Approved;
                Visible = not Rec.Posted and (Rec."Change Type" = Rec."Change Type"::"Password Reset");
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ChangePaymentTolerance;

                trigger OnAction()
                var
                    UserCard: Page "User Card";
                    UserRec: Record User;
                begin
                    UserRec.SetRange("User Security ID", Rec."User Security ID");
                    UserCard.SetTableView(UserRec);
                    UserCard.Run();
                    Commit();

                    Rec.Posted := true;
                    Rec.Modify();
                end;
            }
            action("Change Role")
            {
                ApplicationArea = All;
                Enabled = Rec.Status = Rec.Status::Approved;
                Visible = not Rec.Posted and (Rec."Change Type" = Rec."Change Type"::"Role Change");
                Promoted = true;
                PromotedCategory = Process;
                Image = UserInterface;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    UserPers: Page "User Personalization";
                    UserPersRec: Record "User Personalization";
                begin
                    UserPersRec.SetRange("User SID", Rec."User Security ID");
                    UserPers.SetTableView(UserPersRec);
                    UserPers.Run();
                    Commit();

                    Rec.Posted := true;
                    Rec.Modify();
                end;
            }
            action("User Group/Permission Change")
            {
                ApplicationArea = All;
                Enabled = Rec.Status = Rec.Status::Approved;
                Visible = not Rec.Posted and (Rec."Change Type" = Rec."Change Type"::"User Group/Permission Change");
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ChangeCustomer;

                trigger OnAction()
                var
                    UserCard: Page "User Card";
                    UserRec: Record User;
                begin
                    UserRec.SetRange("User Security ID", Rec."User Security ID");
                    UserCard.SetTableView(UserRec);
                    UserCard.Run();
                    Commit();

                    Rec.Posted := true;
                    Rec.Modify();
                end;
            }
        }
    }

    var
        ApprovalMgt: Codeunit ApprovalMgtCuExtension; */
}






