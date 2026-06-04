Codeunit 50039 "Micropoint ApprovalsCodeUnit"
{
    trigger OnRun()
    begin
    end;

    var
        MembApplicationTable: Record "Membership Applications";
        LoanApplications: Record "Loans Register";
        ShareTransfers: Record "Shares Transfer Header";
        LoanBatches: Record "Loan Disburesment-Batching";
        GuarantorSubstitution: Record "Guarantorship Substitution H";
        memberExit: Record "Membership Exist";
        BOSATransfers: Record "BOSA Transfers";
        LoanRestructure: Record "Loan Restructure";
        LoanRecoveryHeader: Record "Loan Recovery Header";
        DefaultNoticesRegister: Record "Default Notices Register";
        PartialLoanDisbursments: Record "Partial Loan Disbursments";




    //LoanRecoveryApplicationTable: Record "Loan Recovery Header";
    var
        Psalmkitswfevents: Codeunit "Custom Workflow Events";
        NoWorkflowEnabledErr: Label 'No Approval workflow for this record type is enabled';
        WorkflowManagement: Codeunit "Workflow Management";
    //1)--------------------------------------------------------------------Send Membership Applications request For Approval start
    procedure SendMembershipApplicationsRequestForApproval(MemberApplicationNo: Code[40]; var "Membership Applications": Record "Membership Applications")
    begin
        if FnCheckIfMembershipApplicationApprovalsWorkflowEnabled("Membership Applications") then begin
            FnOnSendMembershipApplicationForApproval("Membership Applications");
        end;
    end;

    local procedure FnCheckIfMembershipApplicationApprovalsWorkflowEnabled(var "Membership Applications": Record "Membership Applications"): Boolean;
    begin
        if not IsMembershipApplicationApprovalsWorkflowEnabled("Membership Applications") then Error(NoWorkflowEnabledErr);
        exit(true);
    end;
    //.
    procedure CancelMembershipApplicationsRequestForApproval(MemberApplicationNo: Code[40]; var "Membership Applications": Record "Membership Applications")
    begin
        FnOnCancelMembershipApplicationApprovalRequest("Membership Applications");
    end;

    local procedure IsMembershipApplicationApprovalsWorkflowEnabled(var MembershipApplication: Record "Membership Applications"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(MembershipApplication, Psalmkitswfevents.RunWorkflowOnSendMembershipApplicationForApprovalCode));
    end;

    local procedure FnCheckIfBOSAAccountRegistrationIsAllowed()
    begin
        Error('Procedure FnCheckIfBOSAAccountRegistrationIsAllowed not implemented.');
    end;

    [IntegrationEvent(false, false)]
    procedure FnOnSendMembershipApplicationForApproval(var MembershipApplication: Record "Membership Applications")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure FnOnCancelMembershipApplicationApprovalRequest(var MembershipApplication: Record "Membership Applications")
    begin
    end;
    //2)--------------------------------------------------------------------Send Loan Applications request For Approval start
    //Loans Register
    procedure SendLoansRegisterRequestForApproval(LoanApplicationNo: Code[40]; var "Loans Register": Record "Loans Register")
    begin
        if FnCheckIfLoansRegisterApprovalsWorkflowEnabled("Loans Register") then begin
            FnOnSendLoansRegisterForApproval("Loans Register");
        end;
    end;

    local procedure FnCheckIfLoansRegisterApprovalsWorkflowEnabled(var "Loans Register": Record "Loans Register"): Boolean;
    begin
        if not IsLoansRegisterApprovalsWorkflowEnabled("Loans Register") then Error(NoWorkflowEnabledErr);
        exit(true);
    end;
    //.
    procedure CancelLoansRegisterRequestForApproval(LoanApplicationNo: Code[40]; var "Loans Register": Record "Loans Register")
    begin
        FnOnCancelLoansRegisterApprovalRequest("Loans Register");
    end;

    local procedure IsLoansRegisterApprovalsWorkflowEnabled(var LoansRegister: Record "Loans Register"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(LoansRegister, Psalmkitswfevents.RunWorkflowOnSendLoansRegisterForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure FnOnSendLoansRegisterForApproval(var LoansRegister: Record "Loans Register")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure FnOnCancelLoansRegisterApprovalRequest(var LoansRegister: Record "Loans Register")
    begin
    end;
    //.

    //------------------------------------------------------------------------------------------------------
    //.................................................................................................
    //4)--------------------------------------------------------------------Send Loan Batches request For Approval start
    procedure SendLoanBatchRequestForApproval(LoanNo: Code[40]; var "Loan Disburesment-Batching": Record "Loan Disburesment-Batching")
    begin
        if FnCheckIfLoanBatchApprovalsWorkflowEnabled("Loan Disburesment-Batching") then begin
            FnOnSendLoanBatchForApproval("Loan Disburesment-Batching");
        end;
    end;

    local procedure FnCheckIfLoanBatchApprovalsWorkflowEnabled(var "Loan Disburesment-Batching": Record "Loan Disburesment-Batching"): Boolean;
    begin
        if not IsLoanBatchApprovalsWorkflowEnabled("Loan Disburesment-Batching") then Error(NoWorkflowEnabledErr);
        exit(true);
    end;
    //.
    procedure CancelLoanBatchRequestForApproval(LoanDisburesmentBatching: Code[40]; var "Loan Disburesment-Batching": Record "Loan Disburesment-Batching")
    begin
        FnOnCancelLoanBatchApprovalRequest("Loan Disburesment-Batching");
    end;

    local procedure IsLoanBatchApprovalsWorkflowEnabled(var LoanDisburesmentBatching: Record "Loan Disburesment-Batching"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(LoanDisburesmentBatching, Psalmkitswfevents.RunWorkflowOnSendLoanBatchForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure FnOnSendLoanBatchForApproval(var LoanDisburesmentBatching: Record "Loan Disburesment-Batching")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure FnOnCancelLoanBatchApprovalRequest(var LoanDisburesmentBatching: Record "Loan Disburesment-Batching")
    begin
    end;
    //------------------------------------------------------------------------------------------------------
    //5)--------------------------------------------------------------------Send Loan TopUp request For Approval start
    //------------------------------------------------------------------------------------------------------
    //6)--------------------------------------------------------------------Send Change request For Approval start
    procedure SendMemberChangeRequestForApproval(DocNo: Code[40]; var "Change Request": Record "Change Request")
    begin
        if FnCheckIfMemberChangeRequestApprovalsWorkflowEnabled("Change Request") then begin
            FnOnSendMemberChangeRequestForApproval("Change Request");
        end;
    end;

    local procedure FnCheckIfMemberChangeRequestApprovalsWorkflowEnabled(var "Change Request": Record "Change Request"): Boolean;
    begin
        if not IsMemberChangeRequestApprovalsWorkflowEnabled("Change Request") then Error(NoWorkflowEnabledErr);
        exit(true);
    end;
    //.
    procedure CancelMemberChangeRequestRequestForApproval(ChangeRequest: Code[40]; var "Change Request": Record "Change Request")
    begin
        FnOnCancelMemberChangeRequestApprovalRequest("Change Request");
    end;

    local procedure IsMemberChangeRequestApprovalsWorkflowEnabled(var ChangeRequest: Record "Change Request"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(ChangeRequest, Psalmkitswfevents.RunWorkflowOnSendMemberChangeRequestForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure FnOnSendMemberChangeRequestForApproval(var ChangeRequest: Record "Change Request")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure FnOnCancelMemberChangeRequestApprovalRequest(var ChangeRequest: Record "Change Request")
    begin
    end;
    //------------------------------------------------------------------------------------------------------

    //8)--------------------------------------------------------------------Guarantor Substitution request For Approval start
    procedure SendGuarantorSubRequestForApproval(GuarantorSubNo: Code[40]; var "Guarantorship Substitution H": Record "Guarantorship Substitution H")
    begin
        if FnCheckIfGuarantorSubApprovalsWorkflowEnabled("Guarantorship Substitution H") then begin
            FnOnSendGuarantorSubForApproval("Guarantorship Substitution H");
        end;
    end;

    local procedure FnCheckIfGuarantorSubApprovalsWorkflowEnabled(var "Guarantorship Substitution H": Record "Guarantorship Substitution H"): Boolean;
    begin
        if not IsGuarantorSubApprovalsWorkflowEnabled("Guarantorship Substitution H") then Error(NoWorkflowEnabledErr);
        exit(true);
    end;
    //.
    procedure CancelGuarantorSubRequestForApproval(GuarantorSubstitution: Code[40]; var "Guarantorship Substitution H": Record "Guarantorship Substitution H")
    begin
        FnOnCancelGuarantorSubApprovalRequest("Guarantorship Substitution H");
    end;

    local procedure IsGuarantorSubApprovalsWorkflowEnabled(var GuarantorSubstitution: Record "Guarantorship Substitution H"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(GuarantorSubstitution, Psalmkitswfevents.RunWorkflowOnSendGuarantorSubForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure FnOnSendGuarantorSubForApproval(var GuarantorSubstitution: Record "Guarantorship Substitution H")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure FnOnCancelGuarantorSubApprovalRequest(var GuarantorSubstitution: Record "Guarantorship Substitution H")
    begin
    end;


    //14)--------------------------------------------------------------------Send Membership Applications request For Approval start
    procedure SendShareTransApplicationsRequestForApproval(ShareTransApplicationNo: Code[40]; var "Shares Transfer Header": Record "Shares Transfer Header")
    begin
        if FnCheckIfShareTransApplicationApprovalsWorkflowEnabled("Shares Transfer Header") then begin
            FnOnSendShareTransApplicationForApproval("Shares Transfer Header");
        end;
    end;

    local procedure FnCheckIfShareTransApplicationApprovalsWorkflowEnabled(var "Shares Transfer Header": Record "Shares Transfer Header"): Boolean;
    begin
        if not IsShareTransApplicationApprovalsWorkflowEnabled("Shares Transfer Header") then Error(NoWorkflowEnabledErr);
        exit(true);
    end;
    //.
    procedure CancelShareTransApplicationsRequestForApproval(MemberApplicationNo: Code[40]; var "Shares Transfer Header": Record "Shares Transfer Header")
    begin
        FnOnCancelShareTransApplicationApprovalRequest("Shares Transfer Header");
    end;

    local procedure IsShareTransApplicationApprovalsWorkflowEnabled(var ShareTransApplication: Record "Shares Transfer Header"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(ShareTransApplication, Psalmkitswfevents.RunWorkflowOnSendShareTransApplicationForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure FnOnSendShareTransApplicationForApproval(var ShareTransApplication: Record "Shares Transfer Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure FnOnCancelShareTransApplicationApprovalRequest(var ShareTransApplication: Record "Shares Transfer Header")
    begin
    end;


    //bosa transfers
    procedure SendBOSATransRequestForApproval(No: Code[40]; var "BOSA Transfers": Record "BOSA Transfers")
    begin
        if FnCheckIfBOSATransApprovalsWorkflowEnabled("BOSA Transfers") then begin
            FnOnSendBOSATransForApproval("BOSA Transfers");
        end;
    end;

    local procedure FnCheckIfBOSATransApprovalsWorkflowEnabled(var "BOSA Transfers": Record "BOSA Transfers"): Boolean;
    begin
        if not IsBOSATransApprovalsWorkflowEnabled("BOSA Transfers") then Error(NoWorkflowEnabledErr);
        exit(true);
    end;
    //.
    procedure CancelBOSATransRequestForApproval(BOSATransfers: Code[40]; var "BOSA Transfers": Record "BOSA Transfers")
    begin
        FnOnCancelBOSATransApprovalRequest("BOSA Transfers");
    end;

    local procedure IsBOSATransApprovalsWorkflowEnabled(var BOSATransfers: Record "BOSA Transfers"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(BOSATransfers, Psalmkitswfevents.RunWorkflowOnSendBOSATransfersForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure FnOnSendBOSATransForApproval(var BOSATransfers: Record "BOSA Transfers")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure FnOnCancelBOSATransApprovalRequest(var BOSATransfers: Record "BOSA Transfers")
    begin
    end;
    //Loan Restu  LoanRestructure: Record "Loan Restructure";
    procedure SendLoanRestructureForApproval(No: Code[40]; var "Loan Restructure": Record "Loan Restructure")
    begin
        if FnCheckIfLoanRestructureApprovalsWorkflowEnabled("Loan Restructure") then begin
            FnOnSendLoanRestructureForApproval("Loan Restructure");
        end;
    end;

    local procedure FnCheckIfLoanRestructureApprovalsWorkflowEnabled(var "Loan Restructure": Record "Loan Restructure"): Boolean;
    begin
        if not IsLoanRestructureApprovalsWorkflowEnabled("Loan Restructure") then Error(NoWorkflowEnabledErr);
        exit(true);
    end;
    //.
    procedure CancelLoanRestructureForApproval(LoanRestructure: Code[40]; var "Loan Restructure": Record "Loan Restructure")
    begin
        FnOnCancelLoanRestructureApprovalRequest("Loan Restructure");
    end;

    local procedure IsLoanRestructureApprovalsWorkflowEnabled(var LoanRestructure: Record "Loan Restructure"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(LoanRestructure, Psalmkitswfevents.RunWorkflowOnSendLoanRestructureForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure FnOnSendLoanRestructureForApproval(var LoanRestructure: Record "Loan Restructure")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure FnOnCancelLoanRestructureApprovalRequest(var LoanRestructure: Record "Loan Restructure")
    begin
    end;
    //**************membership exist
    procedure SendMembershipExistForApproval(No: Code[40]; var "Membership Exist": Record "Membership Exist")
    begin
        if FnCheckIfMembershipExistApprovalsWorkflowEnabled("Membership Exist") then begin
            FnOnSendMembershipExistForApproval("Membership Exist");
        end;
    end;

    local procedure FnCheckIfMembershipExistApprovalsWorkflowEnabled(var "Membership Exist": Record "Membership Exist"): Boolean;
    begin
        if not IsMembershipExistApprovalsWorkflowEnabled("Membership Exist") then Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure CancelMembershipExistForApproval(No: Code[40]; var "Membership Exist": Record "Membership Exist")
    begin
        FnOnCancelMembershipExistApprovalRequest("Membership Exist");
    end;

    local procedure IsMembershipExistApprovalsWorkflowEnabled(var MembershipExit: Record "Membership Exist"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(MembershipExit, Psalmkitswfevents.RunWorkflowOnSendMembershipExistForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure FnOnSendMembershipExistForApproval(var MembershipExit: Record "Membership Exist")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure FnOnCancelMembershipExistApprovalRequest(var MembershipExit: Record "Membership Exist")
    begin
    end;
    //**************loan recovery
    procedure SendLoanRecoveryForApproval(No: Code[40]; var "Loan Recovery Header": Record "Loan Recovery Header")
    begin
        if FnCheckIfLoanRecoveryApprovalsWorkflowEnabled("Loan Recovery Header") then begin
            FnOnSendLoanRecoveryForApproval("Loan Recovery Header");
        end;
    end;

    local procedure FnCheckIfLoanRecoveryApprovalsWorkflowEnabled(var "Loan Recovery Header": Record "Loan Recovery Header"): Boolean;
    begin
        if not IsLoanRecoveryApprovalsWorkflowEnabled("Loan Recovery Header") then Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure CancelLoanRecoveryForApproval(No: Code[40]; var LoanRecoveryHeader: Record "Loan Recovery Header")
    begin
        FnOnCancelLoanRecoveryApprovalRequest(LoanRecoveryHeader);
    end;

    local procedure IsLoanRecoveryApprovalsWorkflowEnabled(var LoanRecoveryHeader: Record "Loan Recovery Header"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(LoanRecoveryHeader, Psalmkitswfevents.RunWorkflowOnSendLoanRecoveryForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure FnOnSendLoanRecoveryForApproval(var LoanRecoveryHeader: Record "Loan Recovery Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure FnOnCancelLoanRecoveryApprovalRequest(var LoanRecoveryHeader: Record "Loan Recovery Header")
    begin
    end;
    //**************Default Notices Register
    procedure SendDefaultNoticesRegisterForApproval(No: Code[40]; var "Default Notices Register": Record "Default Notices Register")
    begin
        if FnCheckIfDefaultNoticesRegisterApprovalsWorkflowEnabled("Default Notices Register") then begin
            FnOnSendDefaultNoticesRegisterForApproval("Default Notices Register");
        end;
    end;

    local procedure FnCheckIfDefaultNoticesRegisterApprovalsWorkflowEnabled(var "Default Notices Register": Record "Default Notices Register"): Boolean;
    begin
        if not IsDefaultNoticesRegisterApprovalsWorkflowEnabled("Default Notices Register") then Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure CancelDefaultNoticesRegisterForApproval(No: Code[40]; var "Default Notices Register": Record "Default Notices Register")
    begin
        FnOnCancelDefaultNoticesRegisterApprovalRequest("Default Notices Register");
    end;

    local procedure IsDefaultNoticesRegisterApprovalsWorkflowEnabled(var DefaultNoticesRegister: Record "Default Notices Register"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(DefaultNoticesRegister, 'RUNWORKFLOWONDEMANDNOTICEREGISTERFORAPPROVAL'));
    end;

    [IntegrationEvent(false, false)]
    procedure FnOnSendDefaultNoticesRegisterForApproval(var DefaultNoticesRegister: Record "Default Notices Register")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure FnOnCancelDefaultNoticesRegisterApprovalRequest(var DefaultNoticesRegister: Record "Default Notices Register")
    begin
    end;
    //**************Partial Loan Disbursments
    procedure SendPartialLoanDisbursementsRequestForApproval(No: Code[40]; var "Partial Loan Disbursments": Record "Partial Loan Disbursments")
    begin
        if FnCheckIfPartialLoanDisbursementsApprovalsWorkflowEnabled("Partial Loan Disbursments") then begin
            FnOnSendPartialLoanDisbursementsForApproval("Partial Loan Disbursments");
        end;
    end;

    local procedure FnCheckIfPartialLoanDisbursementsApprovalsWorkflowEnabled(var "Partial Loan Disbursments": Record "Partial Loan Disbursments"): Boolean;
    begin
        if not IsPartialLoanDisbursementsApprovalsWorkflowEnabled("Partial Loan Disbursments") then Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure CancelPartialLoanDisbursementsForApproval(No: Code[40]; var "Partial Loan Disbursments": Record "Partial Loan Disbursments")
    begin
        FnOnCancelPartialLoanDisbursementsApprovalRequest("Partial Loan Disbursments");
    end;

    local procedure IsPartialLoanDisbursementsApprovalsWorkflowEnabled(var PartialLoanDisbursments: Record "Partial Loan Disbursments"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(PartialLoanDisbursments, 'RUNWORKFLOWONPARTIALLOANDISBURSEMENTSFORAPPROVAL'));
    end;

    [IntegrationEvent(false, false)]
    procedure FnOnSendPartialLoanDisbursementsForApproval(var PartialLoanDisbursments: Record "Partial Loan Disbursments")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure FnOnCancelPartialLoanDisbursementsApprovalRequest(var PartialLoanDisbursments: Record "Partial Loan Disbursments")
    begin
    end;
}