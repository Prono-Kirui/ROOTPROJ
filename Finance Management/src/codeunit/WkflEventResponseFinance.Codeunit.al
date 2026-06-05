codeunit 51011 "Wkfl Event Response Finance"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]
    local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "Wkfl Event Handling Finance";
        WorkFlowResponse: Codeunit "Workflow Response Handling";
    begin
        case ResponseFunctionName of
            WorkFlowResponse.SetStatusToPendingApprovalCode():
                begin
                    //Payments
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendPaymentsForApprovalCode());
                    //Budget
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendBudgetRequestForApprovalCode());
                    //Proposed Budget
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendProposedBudgetForApprovalCode());
                    //Bank Rec
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendBankRecForApprovalCode());
                    //User Changes
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendUserChangesForApprovalCode());
                end;
            WorkFlowResponse.CreateApprovalRequestsCode():
                begin
                    //Payments
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnSendPaymentsForApprovalCode());
                    //Budget
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnSendBudgetRequestForApprovalCode());
                    //Proposed Budget
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnSendProposedBudgetForApprovalCode());
                    //Bank Rec
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnSendBankRecForApprovalCode());
                    //User Changes
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnSendUserChangesForApprovalCode());
                end;
            WorkFlowResponse.SendApprovalRequestForApprovalCode():
                begin
                    //Payments
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendPaymentsForApprovalCode());
                    //Budget
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendBudgetRequestForApprovalCode());
                    //Proposed Budget
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendProposedBudgetForApprovalCode());
                    //Bank Rec
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendBankRecForApprovalCode());
                    //User Changes
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendUserChangesForApprovalCode());
                end;
            WorkFlowResponse.OpenDocumentCode():
                begin
                    //Payments
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunWorkflowOnRejectPaymentsCode());
                    //Budget
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunWorkflowOnCancelBudgetRequestForApprovalCode());
                    //Proposed Budget
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunWorkflowOnCancelProposedBudgetForApprovalCode());
                    //Bank Rec
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunWorkflowOnCancelBankRecForApprovalCode());
                    //User Changes
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunWorkflowOnCancelUserChangesApprovalRequestCode());
                end;
            WorkFlowResponse.CancelAllApprovalRequestsCode():
                begin
                    //Payments
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnCancelPaymentsApprovalRequestCode());
                    //Budget
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnCancelBudgetRequestForApprovalCode());
                    //Proposed Budget
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnCancelProposedBudgetForApprovalCode());
                    //Bank Rec
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnCancelBankRecForApprovalCode());
                    //User Changes
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnCancelUserChangesApprovalRequestCode());
                end;
            WorkFlowResponse.ReleaseDocumentCode():
                ;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        BRecon: Record "Bank Acc. Reconciliation";
        BApproval: Record "Budget Approval Header";
        BName: Record "G/L Budget Name";
        Payments: Record Payments;
        UserChanges: Record "User Changes";
        ReleasePayments: Codeunit "Release Payments";
        WorkflowResponses: Codeunit "Workflow Responses Finance";
        VarVariant: Variant;
    begin
        VarVariant := RecRef;
        case RecRef.Number of
            //Payments
            Database::Payments:
                begin
                    Payments.SetView(RecRef.GetView());
                    Handled := true;
                    ReleasePayments.PerformManualRelease(VarVariant);
                end;
            //Budget
            Database::"Budget Approval Header":
                begin
                    BApproval.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReleaseBudget(VarVariant);
                end;
            //Proposed Budget
            Database::"G/L Budget Name":
                begin
                    BName.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReleaseProposedBudget(VarVariant);
                end;
            //Bank Rec
            Database::"Bank Acc. Reconciliation":
                begin
                    BRecon.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReleaseBankRec(VarVariant);
                end;
            //User Changes
            Database::"User Changes":
                begin
                    UserChanges.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReleaseUserChanges(VarVariant);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        BRecon: Record "Bank Acc. Reconciliation";
        BApproval: Record "Budget Approval Header";
        BName: Record "G/L Budget Name";
        Payments: Record Payments;
        UserChanges: Record "User Changes";
        ReleasePayments: Codeunit "Release Payments";
        WorkflowResponses: Codeunit "Workflow Responses Finance";
        VarVariant: Variant;
    begin
        VarVariant := RecRef;

        case RecRef.Number of
            //Payments
            Database::Payments:
                begin
                    Payments.SetView(RecRef.GetView());
                    Handled := true;
                    ReleasePayments.Reopen(VarVariant);
                end;
            //Budget
            Database::"Budget Approval Header":
                begin
                    BApproval.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReopenBudget(VarVariant);
                end;
            //Proposed Budget
            Database::"G/L Budget Name":
                begin
                    BName.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReopenProposedBudget(VarVariant);
                end;
            //Bank Rec
            Database::"Bank Acc. Reconciliation":
                begin
                    BRecon.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReopenBankRec(VarVariant);
                end;
            //User Changes
            Database::"User Changes":
                begin
                    UserChanges.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReOpenUserChanges(VarVariant);
                end;
        end;
    end;
}
