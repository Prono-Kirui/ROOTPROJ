codeunit 50006 "Approval Mgt Ext General"
{
     Subtype = Install;
     
    var
        ApproverIDInserted: Boolean;

    //Insert Rejection Comment on Rejection of a document
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeRejectApprovalRequests', '', false, false)]
    local procedure InsertCommentsOnRejectApprovalRequest(ApprovalEntry: Record "Approval Entry"; var IsHandled: Boolean)
    var
        RejectionComments: Page "Rejection Comments";
        InputRejectCommentErr: Label 'Please input rejection comment';
        Comment: Text;
    begin
        IsHandled := false;

        //Prompt and Insert Rejection Comment
        if RejectionComments.RunModal() = Action::OK then begin
            Comment := RejectionComments.GetRejectComment();
            if Comment = '' then
                Error(InputRejectCommentErr);
            InsertRejectionComment(ApprovalEntry, Comment, ApprovalEntry."Table ID");
        end;
    end;

    //Insert Description
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeApprovalEntryInsert', '', false, false)]
    local procedure OnBeforeApprovalEntryInsert(var ApprovalEntry: Record "Approval Entry"; ApprovalEntryArgument: Record "Approval Entry")
    begin
        ApprovalEntry.Description := ApprovalEntryArgument.Description;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    local procedure OnApproveApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        NextApprovalEntry: Record "Approval Entry";
    begin
        if ApprovalEntry."Approval Stage" <> '' then begin
            if MinimumApprovalsReached(ApprovalEntry) then begin

                NextApprovalEntry.SetCurrentKey("Table ID", "Document Type", "Document No.");
                NextApprovalEntry.SetRange("Table ID", ApprovalEntry."Table ID");
                NextApprovalEntry.SetRange("Document Type", ApprovalEntry."Document Type");
                NextApprovalEntry.SetRange("Document No.", ApprovalEntry."Document No.");
                NextApprovalEntry.SetFilter(Status, '%1|%2', NextApprovalEntry.Status::Created, NextApprovalEntry.Status::Open);
                NextApprovalEntry.SetRange("Approval Stage", ApprovalEntry."Approval Stage");
                if NextApprovalEntry.Find('-') then
                    repeat
                        NextApprovalEntry.Validate(Status, NextApprovalEntry.Status::Approved);
                        NextApprovalEntry.Modify(true);
                    until NextApprovalEntry.Next() = 0;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnAfterCreateApprReqForApprTypeWorkflowUserGroup', '', false, false)]
    local procedure OnAfterCreateApprReqForApprTypeWorkflowUserGroup(WorkflowStepArgument: Record "Workflow Step Argument"; ApprovalEntryArgument: Record "Approval Entry")
    var
        ApprovalEntry: Record "Approval Entry";
        WkFlow: Record Workflow;
        WkFlowUserGrp: Record "Workflow User Group Member";
    //OnlinePortal: Codeunit "Online Portal Services";
    begin
        //if WkFlowUserGrp.Get(WorkflowStepArgument."Workflow User Group Code", WorkflowStepArgument."Approver User ID") then;
        if ApprovalEntry.Get(ApprovalEntryArgument."Entry No.") then begin
            ApprovalEntry."Approval Stage" := WkFlowUserGrp."Approval Stages";
            ApprovalEntry."Workflow User Group Code" := WorkflowStepArgument."Workflow User Group Code";
            //ApprovalEntry."Staff No." := OnlinePortal.GetEmpIDFromUserID(ApprovalEntry."Sender ID");
            //ApprovalEntry."Approver Staff No." := OnlinePortal.GetEmpIDFromUserID(ApprovalEntry."Approver ID");
            ApprovalEntry.Modify();
        end;

        //Modifcation
        if WkFlow.Get(ApprovalEntryArgument."Approval Code") then;
        if not ApproverIDInserted and WkFlow."Insert Approver ID" then
            MakeApprovalEntry2(ApprovalEntryArgument, ApprovalEntryArgument."Sequence No.", ApprovalEntryArgument."Approver ID", WorkflowStepArgument,
                               WkFlowUserGrp."Approval Stages", WorkflowStepArgument."Workflow User Group Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnAfterCreateApprReqForApprTypeSalespersPurchaser', '', false, false)]
    local procedure OnAfterCreateApprReqForApprTypeSalespersPurchaser(WorkflowStepArgument: Record "Workflow Step Argument"; ApprovalEntryArgument: Record "Approval Entry")
    var
        WkFlow: Record Workflow;
    begin
        //Modifcation
        if WkFlow.Get(ApprovalEntryArgument."Approval Code") then;
        if not ApproverIDInserted and WkFlow."Insert Approver ID" then
            MakeApprovalEntry2(ApprovalEntryArgument, ApprovalEntryArgument."Sequence No.", ApprovalEntryArgument."Approver ID", WorkflowStepArgument,
                               ApprovalEntryArgument."Approval Stage", ApprovalEntryArgument."Workflow User Group Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnAfterCreateApprReqForApprTypeApprover', '', false, false)]
    local procedure OnAfterCreateApprReqForApprTypeApprover(WorkflowStepArgument: Record "Workflow Step Argument"; ApprovalEntryArgument: Record "Approval Entry")
    var
        WkFlow: Record Workflow;
    begin
        //Modifcation
        if WkFlow.Get(ApprovalEntryArgument."Approval Code") then;
        if not ApproverIDInserted and WkFlow."Insert Approver ID" then
            MakeApprovalEntry2(ApprovalEntryArgument, ApprovalEntryArgument."Sequence No.", ApprovalEntryArgument."Approver ID", WorkflowStepArgument,
                               ApprovalEntryArgument."Approval Stage", ApprovalEntryArgument."Workflow User Group Code");
    end;

    local procedure MinimumApprovalsReached(ApprovalEntry: Record "Approval Entry"): Boolean
    var
        LastApprovalEntry: Record "Approval Entry";
        ApprovalStages: Record "Approval Stages";
        MinimumApprovers: Integer;
        NoOfApprovals: Integer;
    begin
        LastApprovalEntry.Reset();
        LastApprovalEntry.SetCurrentKey("Table ID", "Document Type", "Document No.");
        LastApprovalEntry.SetRange("Table ID", ApprovalEntry."Table ID");
        LastApprovalEntry.SetRange("Document Type", ApprovalEntry."Document Type");
        LastApprovalEntry.SetRange("Document No.", ApprovalEntry."Document No.");
        LastApprovalEntry.SetRange("Approval Stage", ApprovalEntry."Approval Stage");
        LastApprovalEntry.SetFilter(Status, '=%1', LastApprovalEntry.Status::Approved);
        NoOfApprovals := LastApprovalEntry.Count;

        //Get Current Approval Stage
        if ApprovalStages.Get(ApprovalEntry."Workflow User Group Code", ApprovalEntry."Approval Stage") then
            MinimumApprovers := ApprovalStages."Minimum Approvers";

        if NoOfApprovals >= MinimumApprovers then
            exit(true)
        else
            exit(false);
    end;

    procedure InsertRejectionComment(AppEntry: Record "Approval Entry"; Comments: Text; TableID: Integer)
    var
        CommentLine: Record "Approval Comment Line";
        LineNo: Integer;
    begin
        if CommentLine.FindLast() then
            LineNo := CommentLine."Entry No." + 1
        else
            LineNo := 1;

        CommentLine.Init();
        CommentLine."Entry No." := LineNo;
        CommentLine."Table ID" := TableID;
        //CommentLine."Document Type" := "Document Type";
        CommentLine."Document No." := AppEntry."Document No.";
        CommentLine."Date and Time" := CreateDateTime(Today, Time);
        CommentLine.Comment := Comments;
        CommentLine."Record ID to Approve" := AppEntry."Record ID to Approve";
        CommentLine."Workflow Step Instance ID" := AppEntry."Workflow Step Instance ID";
        CommentLine."User ID" := UserId;
        CommentLine.Insert();
    end;

    local procedure MakeApprovalEntry2(ApprovalEntryArgument: Record "Approval Entry"; SequenceNo: Integer; ApproverId: Code[50]; WorkflowStepArgument: Record "Workflow Step Argument"; ApprovalStage: Code[20]; WorkFlowUserGroup: Code[20])
    var
        ApprovalEntry: Record "Approval Entry";
        UserSetup: Record "User Setup";
    //OnlinePortal: Codeunit "Online Portal Services";
    begin
        ApprovalEntry."Table ID" := ApprovalEntryArgument."Table ID";
        ApprovalEntry."Document Type" := ApprovalEntryArgument."Document Type";
        ApprovalEntry."Document No." := ApprovalEntryArgument."Document No.";
        ApprovalEntry."Salespers./Purch. Code" := ApprovalEntryArgument."Salespers./Purch. Code";
        ApprovalEntry."Sequence No." := SequenceNo - 1;
        ApprovalEntry."Sender ID" := UserId;
        ApprovalEntry.Amount := ApprovalEntryArgument.Amount;
        ApprovalEntry."Amount (LCY)" := ApprovalEntryArgument."Amount (LCY)";
        ApprovalEntry."Currency Code" := ApprovalEntryArgument."Currency Code";
        UserSetup.Get(UserId);
        UserSetup.TestField("Approver ID");
        ApprovalEntry."Approver ID" := UserSetup."Approver ID";
        ApprovalEntry."Workflow Step Instance ID" := ApprovalEntryArgument."Workflow Step Instance ID";
        if ApproverId = UserId then
            ApprovalEntry.Status := ApprovalEntry.Status::Approved
        else
            ApprovalEntry.Status := ApprovalEntry.Status::Created;
        ApprovalEntry."Date-Time Sent for Approval" := CreateDateTime(Today, Time);
        ApprovalEntry."Last Date-Time Modified" := CreateDateTime(Today, Time);
        ApprovalEntry."Last Modified By User ID" := UserId;
        ApprovalEntry."Due Date" := CalcDate(WorkflowStepArgument."Due Date Formula", Today);

        case WorkflowStepArgument."Delegate After" of
            WorkflowStepArgument."Delegate After"::Never:
                Evaluate(ApprovalEntry."Delegation Date Formula", '');
            WorkflowStepArgument."Delegate After"::"1 day":
                Evaluate(ApprovalEntry."Delegation Date Formula", '<1D>');
            WorkflowStepArgument."Delegate After"::"2 days":
                Evaluate(ApprovalEntry."Delegation Date Formula", '<2D>');
            WorkflowStepArgument."Delegate After"::"5 days":
                Evaluate(ApprovalEntry."Delegation Date Formula", '<5D>');
            else
                Evaluate(ApprovalEntry."Delegation Date Formula", '');
        end;
        ApprovalEntry."Available Credit Limit (LCY)" := ApprovalEntryArgument."Available Credit Limit (LCY)";
        SetApproverType(WorkflowStepArgument, ApprovalEntry);
        SetLimitType(WorkflowStepArgument, ApprovalEntry);
        ApprovalEntry."Record ID to Approve" := ApprovalEntryArgument."Record ID to Approve";
        ApprovalEntry."Approval Code" := ApprovalEntryArgument."Approval Code";

        //Business Solutions Modifications
        ApprovalEntry."Approval Stage" := ApprovalStage;
        ApprovalEntry."Workflow User Group Code" := WorkFlowUserGroup;
        //ApprovalEntry."Staff No." := OnlinePortal.GetEmpIDFromUserID(ApprovalEntry."Sender ID");
        //ApprovalEntry."Approver Staff No." := OnlinePortal.GetEmpIDFromUserID(ApprovalEntry."Approver ID");

        ApprovalEntry.Insert(true);
        ApproverIDInserted := true;
    end;

    local procedure SetApproverType(WorkflowStepArgument: Record "Workflow Step Argument"; var ApprovalEntry: Record "Approval Entry")
    begin
        case WorkflowStepArgument."Approver Type" of
            WorkflowStepArgument."Approver Type"::"Salesperson/Purchaser":
                ApprovalEntry."Approval Type" := ApprovalEntry."Approval Type"::"Sales Pers./Purchaser";
            WorkflowStepArgument."Approver Type"::Approver:
                ApprovalEntry."Approval Type" := ApprovalEntry."Approval Type"::Approver;
            WorkflowStepArgument."Approver Type"::"Workflow User Group":
                ApprovalEntry."Approval Type" := ApprovalEntry."Approval Type"::"Workflow User Group";
        end;
    end;

    local procedure SetLimitType(WorkflowStepArgument: Record "Workflow Step Argument"; var ApprovalEntry: Record "Approval Entry")
    begin
        case WorkflowStepArgument."Approver Limit Type" of
            WorkflowStepArgument."Approver Limit Type"::"Approver Chain",
        WorkflowStepArgument."Approver Limit Type"::"First Qualified Approver":
                ApprovalEntry."Limit Type" := ApprovalEntry."Limit Type"::"Approval Limits";
            WorkflowStepArgument."Approver Limit Type"::"Direct Approver":
                ApprovalEntry."Limit Type" := ApprovalEntry."Limit Type"::"No Limits";
            WorkflowStepArgument."Approver Limit Type"::"Specific Approver":
                ApprovalEntry."Limit Type" := ApprovalEntry."Limit Type"::"No Limits";
        end;

        if ApprovalEntry."Approval Type" = ApprovalEntry."Approval Type"::"Workflow User Group" then
            ApprovalEntry."Limit Type" := ApprovalEntry."Limit Type"::"No Limits";
    end;
}



