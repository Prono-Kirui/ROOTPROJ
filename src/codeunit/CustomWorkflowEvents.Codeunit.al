Codeunit 50040 "Custom Workflow Events"
{
    Subtype = Install;
    trigger OnRun()
    begin
        AddEventsToLib();
        AddEventsPredecessor();
    end;

    var
        WFHandler: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";
        WFEventHandler: Codeunit "Workflow Event Handling";
        SurestepWFEvents: Codeunit "Custom Workflow Events";
        WFResponseHandler: Codeunit "Workflow Response Handling";
        LoanRecoveryHeader: Record "Loan Recovery Header";

    procedure AddEventsToLib()
    begin
        //---------------------------------------------1. Approval Events--------------------------------------------------------------
        //Membership Application
        WFHandler.AddEventToLibrary(RunWorkflowOnSendMembershipApplicationForApprovalCode, Database::"Membership Applications", 'Approval of Membership Application is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelMembershipApplicationApprovalRequestCode, Database::"Membership Applications", 'An Approval request for  Membership Application is canceled.', 0, false);
        //-------------------------------------------End Approval Events-------------------------------------------------------------
        //Loans Register
        WFHandler.AddEventToLibrary(RunWorkflowOnSendLoansRegisterForApprovalCode, Database::"Loans Register", 'Approval of Loans Register is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelLoansRegisterApprovalRequestCode, Database::"Loans Register", 'An Approval request for  Loans Register is canceled.', 0, false);
        //-------------------------------------------End Approval Events-------------------------------------------------------------
        // //-------------------------------------------End Approval Events-------------------------------------------------------------
        //Loan Batch Disbursements
        WFHandler.AddEventToLibrary(RunWorkflowOnSendLoanBatchForApprovalCode, Database::"Loan Disburesment-Batching", 'Approval of a Loan Batch document is requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelLoanBatchApprovalRequestCode, Database::"Loan Disburesment-Batching", 'An Approval request for a Loan Batch document is canceled.', 0, false);
        //-------------------------------------------End Approval Events-------------------------------------------------------------
        //Change Request
        WFHandler.AddEventToLibrary(RunWorkflowOnSendMemberChangeRequestForApprovalCode, Database::"Change Request", 'Approval of Change Request is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelMemberChangeRequestApprovalRequestCode, Database::"Change Request", 'An Approval request for  Change Request is canceled.', 0, false);
        //-------------------------------------------End Approval Events-------------------------------------------------------------
        //Guarantor Substitution
        WFHandler.AddEventToLibrary(RunWorkflowOnSendGuarantorSubForApprovalCode, Database::"Guarantorship Substitution H", 'Approval of Guarantor Substitution is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelGuarantorSubApprovalRequestCode, Database::"Guarantorship Substitution H", 'An Approval request for Guarantor Substitution is canceled.', 0, false);
        //Share Transfer Application
        WFHandler.AddEventToLibrary(RunWorkflowOnSendShareTransApplicationForApprovalCode, Database::"Shares Transfer Header", 'Approval of Share Transfer is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelShareTransApplicationApprovalRequestCode, Database::"Shares Transfer Header", 'An Approval request for Share Transfer is canceled.', 0, false);

        WFHandler.AddEventToLibrary(RunWorkflowOnSendBOSATransfersForApprovalCode, Database::"BOSA Transfers", 'Approval of BOSA Transfers is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelBOSATransfersApprovalRequestCode, Database::"BOSA Transfers", 'An Approval request for BOSA Transfers is canceled.', 0, false);
        //LoanRestructure
        WFHandler.AddEventToLibrary(RunWorkflowOnSendLoanRestructureForApprovalCode, Database::"Loan Restructure", 'Approval of Loan Restructure is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelLoanRestructureApprovalRequestCode, Database::"Loan Restructure", 'An Approval request for Loan Restructureis canceled.', 0, false);
        //MembershipExist
        WFHandler.AddEventToLibrary(RunWorkflowOnSendMembershipExistForApprovalCode, Database::"Membership Exist", 'Approval of Membership Exist is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelMembershipExistApprovalRequestCode, Database::"Membership Exist", 'An Approval request for Membership Exist is canceled.', 0, false);
        //LoanRecoveryHeader
        WFHandler.AddEventToLibrary(RunWorkflowOnSendLoanRecoveryForApprovalCode, Database::"Loan Recovery Header", 'Approval of Loan Recovery is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelLoanRecoveryApprovalRequestCode, Database::"Loan Recovery Header", 'An Approval request for Loan Recovery is canceled.', 0, false);
        // DefaultNoticesRegister
        WFHandler.AddEventToLibrary(RunWorkflowOnDemandNoticeRegisterForApprovalCode, Database::"Default Notices Register", 'Approval of Default Notices Register is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelDemandNoticeApprovalRequestCode, Database::"Default Notices Register", 'An Approval request for Default Notices Register is canceled.', 0, false);
        // PartialLoanDisbursments: Record "Partial Loan Disbursments";
        WFHandler.AddEventToLibrary(RunWorkflowOnPartialLoanDisbursementsForApprovalCode, Database::"Partial Loan Disbursments", 'Approval of Partial Loan Disbursments is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelPartialLoanDisbursementsApprovalRequestCode, Database::"Partial Loan Disbursments", 'An Approval request for Partial Loan Disbursments is canceled.', 0, false);
        //-------------------------------------------End Approval Events-------------------------------------------------------------
        //-------------------------------------------End Approval Events-------------------------------------------------------------

    end;

    procedure AddEventsPredecessor()
    begin
        //--------1.Approval,Rejection,Delegation Predecessors----------------------
        //1. Membership Application
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendMembershipApplicationForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendMembershipApplicationForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendMembershipApplicationForApprovalCode);
        //2. Loans Register
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLoansRegisterForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendLoansRegisterForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendLoansRegisterForApprovalCode);
        //---------------------------------------End Approval,Rejection,Delegation Predecessors---------------------------------------------
        //4. Loan Batch Disbursement
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLoanBatchForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendLoanBatchForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendLoanBatchForApprovalCode);
        //6. Change Request
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendMemberChangeRequestForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendMemberChangeRequestForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendMemberChangeRequestForApprovalCode);

        //8.Guarantor Substitution
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendGuarantorSubForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendGuarantorSubForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendGuarantorSubForApprovalCode);

        //14. Share Transfers
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendShareTransApplicationForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendShareTransApplicationForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendShareTransApplicationForApprovalCode);
        //---------------------------------------End Approval,Rejection,Delegation Predecessors---------------------------------------------
        //BOSA Transfers
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendBOSATransfersForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendBOSATransfersForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendBOSATransfersForApprovalCode);
        //LoanRestructure

        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLoanRestructureForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendLoanRestructureForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendLoanRestructureForApprovalCode);
        //MembershipExist
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendMembershipExistForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendMembershipExistForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendMembershipExistForApprovalCode);
        //---------------------------------------End Approval,Rejection,Delegation Predecessors---------------------------------------------
        //LoanRestructure
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLoanRestructureForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendLoanRestructureForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendLoanRestructureForApprovalCode);
        //LoanRecoveryHeader
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLoanRecoveryForApprovalCode());
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendLoanRecoveryForApprovalCode());
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendLoanRecoveryForApprovalCode());
        // DefaultNoticesRegister
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, 'RUNWORKFLOWONDEMANDNOTICEREGISTERFORAPPROVAL');
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, 'RUNWORKFLOWONDEMANDNOTICEREGISTERFORAPPROVAL');
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, 'RUNWORKFLOWONDEMANDNOTICEREGISTERFORAPPROVAL');
        // PartialLoanDisbursments: Record "Partial Loan Disbursments";
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, 'RUNWORKFLOWONPARTIALLOANDISBURSEMENTSFORAPPROVAL');
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, 'RUNWORKFLOWONPARTIALLOANDISBURSEMENTSFORAPPROVAL');
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, 'RUNWORKFLOWONPARTIALLOANDISBURSEMENTSFORAPPROVAL');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    procedure OnAddWorkflowEventsToLibrary()
    begin
        AddEventsToLib();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    procedure OnAddWorkflowEventPredecessorsToLibrary()
    begin
        AddEventsPredecessor();
    end;


    //...............................................................................................................................................................................
    //A)Membership Applications
    procedure RunWorkflowOnSendMembershipApplicationForApprovalCode(): Code[128] //
    begin
        exit(UpperCase('RunWorkflowOnSendMembershipApplicationForApproval'));
    end;

    procedure RunWorkflowOnCancelMembershipApplicationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelMembershipApplicationApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Micropoint ApprovalsCodeUnit", 'FnOnSendMembershipApplicationForApproval', '', false, false)]
    procedure RunWorkflowOnSendMembershipApplicationForApproval(var MembershipApplication: Record "Membership Applications")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendMembershipApplicationForApprovalCode, MembershipApplication);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Micropoint ApprovalsCodeUnit", 'FnOnCancelMembershipApplicationApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelMembershipApplicationApprovalRequest(var MembershipApplication: Record "Membership Applications")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelMembershipApplicationApprovalRequestCode, MembershipApplication);
    end;
    //2. Loans Register
    //...................................................................................................
    procedure RunWorkflowOnSendLoansRegisterForApprovalCode(): Code[128] //
    begin
        exit(UpperCase('RunWorkflowOnSendLoansRegisterForApproval'));
    end;

    procedure RunWorkflowOnCancelLoansRegisterApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelLoansRegisterApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Micropoint ApprovalsCodeUnit", 'FnOnSendLoansRegisterForApproval', '', false, false)]
    procedure RunWorkflowOnSendLoansRegisterForApproval(var LoansRegister: Record "Loans Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLoansRegisterForApprovalCode, LoansRegister);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Micropoint ApprovalsCodeUnit", 'FnOnCancelLoansRegisterApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelLoansRegisterApprovalRequest(var LoansRegister: Record "Loans Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLoansRegisterApprovalRequestCode, LoansRegister);
    end;


    //...................................................................................................
    //4. Loan Batches
    procedure RunWorkflowOnSendLoanBatchForApprovalCode(): Code[128] //
    begin
        exit(UpperCase('RunWorkflowOnSendLoanBatchForApproval'));
    end;

    procedure RunWorkflowOnCancelLoanBatchApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelLoanBatchApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Micropoint ApprovalsCodeUnit", 'FnOnSendLoanBatchForApproval', '', false, false)]
    procedure RunWorkflowOnSendLoanBatchForApproval(var LoanDisburesmentBatching: Record "Loan Disburesment-Batching")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLoanBatchForApprovalCode, LoanDisburesmentBatching);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Micropoint ApprovalsCodeUnit", 'FnOnCancelLoanBatchApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelLoanBatchApprovalRequest(var LoanDisburesmentBatching: Record "Loan Disburesment-Batching")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLoanBatchApprovalRequestCode, LoanDisburesmentBatching);
    end;
    //...................................................................................................
    //6. Change Request
    procedure RunWorkflowOnSendMemberChangeRequestForApprovalCode(): Code[128] //
    begin
        exit(UpperCase('RunWorkflowOnSendMemberChangeRequestForApproval'));
    end;

    procedure RunWorkflowOnCancelMemberChangeRequestApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelMemberChangeRequestApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Micropoint ApprovalsCodeUnit", 'FnOnSendMemberChangeRequestForApproval', '', false, false)]
    procedure RunWorkflowOnSendMemberChangeRequestForApproval(var ChangeRequest: Record "Change Request")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendMemberChangeRequestForApprovalCode, ChangeRequest);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Micropoint ApprovalsCodeUnit", 'FnOnCancelMemberChangeRequestApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelMemberChangeRequestApprovalRequest(var ChangeRequest: Record "Change Request")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelMemberChangeRequestApprovalRequestCode, ChangeRequest);
    end;

    //...................................................................................................
    //8)Guarantor Substitution
    procedure RunWorkflowOnSendGuarantorSubForApprovalCode(): Code[128] //
    begin
        exit(UpperCase('RunWorkflowOnSendGuarantorSubForApproval'));
    end;

    procedure RunWorkflowOnCancelGuarantorSubApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelGuarantorSubApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Micropoint ApprovalsCodeUnit", 'FnOnSendGuarantorSubForApproval', '', false, false)]
    procedure RunWorkflowOnSendGuarantorSubForApproval(var GuarantorSubstitution: Record "Guarantorship Substitution H")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendGuarantorSubForApprovalCode, GuarantorSubstitution);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Micropoint ApprovalsCodeUnit", 'FnOnCancelGuarantorSubApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelGuarantorSubApprovalRequest(var GuarantorSubstitution: Record "Guarantorship Substitution H")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelGuarantorSubApprovalRequestCode, GuarantorSubstitution);
    end;
    //------------------------------------------------------------------------

    //14)Share Transfer
    procedure RunWorkflowOnSendShareTransApplicationForApprovalCode(): Code[128] //
    begin
        exit(UpperCase('RunWorkflowOnSendShareTransApplicationForApproval'));
    end;

    procedure RunWorkflowOnCancelShareTransApplicationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelShareTransApplicationApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Micropoint ApprovalsCodeUnit", 'FnOnSendShareTransApplicationForApproval', '', false, false)]
    procedure RunWorkflowOnSendShareTransApplicationForApproval(var ShareTransApplication: Record "Shares Transfer Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendShareTransApplicationForApprovalCode, ShareTransApplication);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Micropoint ApprovalsCodeUnit", 'FnOnCancelShareTransApplicationApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelShareTransApplicationApprovalRequest(var ShareTransApplication: Record "Shares Transfer Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelShareTransApplicationApprovalRequestCode, ShareTransApplication);
    end;
    //...................................................................................................

    //BOSA Transfers
    procedure RunWorkflowOnSendBOSATransfersForApprovalCode(): Code[128] //
    begin
        exit(UpperCase('RunWorkflowOnSendBOSATransfersForApproval'));
    end;

    procedure RunWorkflowOnCancelBOSATransfersApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelBOSATransfersApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Micropoint ApprovalsCodeUnit", 'FnOnSendBOSATransForApproval', '', false, false)]
    procedure RunWorkflowOnSendBOSATransForApproval(var BOSATransfers: Record "BOSA Transfers")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendBOSATransfersForApprovalCode, BOSATransfers);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Micropoint ApprovalsCodeUnit", 'FnOnCancelBOSATransApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelBOSATransfersApprovalRequest(var BOSATransfers: Record "BOSA Transfers")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelBOSATransfersApprovalRequestCode, BOSATransfers);
    end;
    //LoanRestructure
    procedure RunWorkflowOnSendLoanRestructureForApprovalCode(): Code[128] //
    begin
        exit(UpperCase('RunWorkflowOnSendLoanRestructureForApproval'));
    end;

    procedure RunWorkflowOnCancelLoanRestructureApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelLoanRestructureApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Micropoint ApprovalsCodeUnit", 'FnOnSendLoanRestructureForApproval', '', false, false)]
    procedure RunWorkflowOnSendLoanRestructureForApproval(var LoanRestructure: Record "Loan Restructure")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLoanRestructureForApprovalCode, LoanRestructure);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Micropoint ApprovalsCodeUnit", 'FnOnCancelLoanRestructureApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelLoanRestructureApprovalRequest(var LoanRestructure: Record "Loan Restructure")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLoanRestructureApprovalRequestCode, LoanRestructure);
    end;
    //MembershipExist
    procedure RunWorkflowOnSendMembershipExistForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendMembershipExistForApproval'));
    end;

    procedure RunWorkflowOnCancelMembershipExistApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelMembershipExistApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Micropoint ApprovalsCodeUnit", 'FnOnSendMembershipExistForApproval', '', false, false)]
    procedure RunWorkflowOnSendMembershipExistForApproval(var MembershipExit: Record "Membership Exist")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendMembershipExistForApprovalCode, MembershipExit);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Micropoint ApprovalsCodeUnit", 'FnOnCancelMembershipExistApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelMembershipExistApprovalRequest(var MembershipExit: Record "Membership Exist")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelMembershipExistApprovalRequestCode, MembershipExit);
    end;
    //LoanRecoveryHeader
    procedure RunWorkflowOnSendLoanRecoveryForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendLoanRecoveryForApproval'));
    end;

    procedure RunWorkflowOnCancelLoanRecoveryApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelLoanRecoveryApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Micropoint ApprovalsCodeUnit", 'FnOnSendLoanRecoveryForApproval', '', false, false)]
    procedure RunWorkflowOnSendLoanRecoveryForApproval(var LoanRecoveryHeader: Record "Loan Recovery Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLoanRecoveryForApprovalCode, LoanRecoveryHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Micropoint ApprovalsCodeUnit", 'FnOnCancelLoanRecoveryApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelLoanRecoveryApprovalRequest(var LoanRecoveryHeader: Record "Loan Recovery Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLoanRecoveryApprovalRequestCode, LoanRecoveryHeader);
    end;
    // DefaultNoticesRegister
    procedure RunWorkflowOnDemandNoticeRegisterForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RUNWORKFLOWONDEMANDNOTICEREGISTERFORAPPROVAL'));
    end;

    procedure RunWorkflowOnCancelDemandNoticeApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RUNWORKFLOWONCANCELDEMANDNOTICEAPPROVALREQUEST'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Micropoint ApprovalsCodeUnit", 'FnOnSendDefaultNoticesRegisterForApproval', '', false, false)]
    procedure RunWorkflowOnDemandNoticeRegisterForApproval(var DefaultNoticesRegister: Record "Default Notices Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnDemandNoticeRegisterForApprovalCode, DefaultNoticesRegister);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Micropoint ApprovalsCodeUnit", 'FnOnCancelDefaultNoticesRegisterApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelDemandNoticeApprovalRequest(var DefaultNoticesRegister: Record "Default Notices Register")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelDemandNoticeApprovalRequestCode, DefaultNoticesRegister);
    end;

    // PartialLoanDisbursments: Record "Partial Loan Disbursments";
    procedure RunWorkflowOnPartialLoanDisbursementsForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RUNWORKFLOWONPARTIALLOANDISBURSEMENTSFORAPPROVAL'));
    end;

    procedure RunWorkflowOnCancelPartialLoanDisbursementsApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RUNWORKFLOWONCANCELPARTIALLOANDISBURSEMENTSAPPROVALREQUEST'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Micropoint ApprovalsCodeUnit", 'FnOnSendPartialLoanDisbursementsForApproval', '', false, false)]
    procedure RunWorkflowOnPartialLoanDisbursementsForApproval(var PartialLoanDisbursments: Record "Partial Loan Disbursments")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnPartialLoanDisbursementsForApprovalCode, PartialLoanDisbursments);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Micropoint ApprovalsCodeUnit", 'FnOnCancelPartialLoanDisbursementsApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelPartialLoanDisbursementsApprovalRequest(var PartialLoanDisbursments: Record "Partial Loan Disbursments")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPartialLoanDisbursementsApprovalRequestCode, PartialLoanDisbursments);
    end;


}