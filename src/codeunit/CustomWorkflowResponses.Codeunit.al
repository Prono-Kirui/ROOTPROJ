Codeunit 50341 "Custom Workflow Responses"
{
    Subtype = Install;
    trigger OnRun()
    begin
    AddResponsesToLib();
    OnAddWorkflowResponsesToLibrary();
    end;

    var
        WFEventHandler: Codeunit "Workflow Event Handling";
        WFResponseHandler: Codeunit "Workflow Response Handling";
        MsgToSend: Text[250];
        CompanyInfo: Record "Company Information";
        AFactory: Codeunit "Micropoint Factory";

    procedure AddResponsesToLib()
var
    WorkflowResponseHandling: Codeunit "Workflow Response Handling";
begin
    WorkflowResponseHandling.AddResponseToLibrary(
        'CUSTOMAPPROVAL',  // Use a simple string instead of CreateApprovalRequestsCode
        Database::"Membership Applications",
        'Create an approval request for the record and send a notification.',
        'GROUP 0');
        
    WorkflowResponseHandling.AddResponseToLibrary(
        'CUSTOMAPPROVAL',
        Database::"Loans Register",
        'Create an approval request for the record and send a notification.',
        'GROUP 0');
end;

    procedure AddResponsePredecessors()
    begin
        //-----------------------------End AddOn--------------------------------------------------------------------------------------
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling",
    'OnAddWorkflowResponsesToLibrary', '', false, false)]
    procedure OnAddWorkflowResponsesToLibrary()
    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    begin
        WorkflowResponseHandling.AddResponseToLibrary(
            WorkflowResponseHandling.CreateApprovalRequestsCode(),
            Database::"Membership Applications",
            'Create an approval request for the record and send a notification.',
            'GROUP 0');

        WorkflowResponseHandling.AddResponseToLibrary(
            WorkflowResponseHandling.CreateApprovalRequestsCode(),
            Database::"Loans Register",
            'Create an approval request for the record and send a notification.',
            'GROUP 0');

        WorkflowResponseHandling.AddResponseToLibrary(
            WorkflowResponseHandling.CreateApprovalRequestsCode(),
            Database::"Loan Disburesment-Batching",
            'Create an approval request for the record and send a notification.',
            'GROUP 0');

        WorkflowResponseHandling.AddResponseToLibrary(
            WorkflowResponseHandling.CreateApprovalRequestsCode(),
            Database::"Change Request",
            'Create an approval request for the record and send a notification.',
            'GROUP 0');

        WorkflowResponseHandling.AddResponseToLibrary(
            WorkflowResponseHandling.CreateApprovalRequestsCode(),
            Database::"Guarantorship Substitution H",
            'Create an approval request for the record and send a notification.',
            'GROUP 0');

        WorkflowResponseHandling.AddResponseToLibrary(
            WorkflowResponseHandling.CreateApprovalRequestsCode(),
            Database::"Shares Transfer Header",
            'Create an approval request for the record and send a notification.',
            'GROUP 0');

        WorkflowResponseHandling.AddResponseToLibrary(
            WorkflowResponseHandling.CreateApprovalRequestsCode(),
            Database::"BOSA Transfers",
            'Create an approval request for the record and send a notification.',
            'GROUP 0');

        WorkflowResponseHandling.AddResponseToLibrary(
            WorkflowResponseHandling.CreateApprovalRequestsCode(),
            Database::"Loan Restructure",
            'Create an approval request for the record and send a notification.',
            'GROUP 0');

        WorkflowResponseHandling.AddResponseToLibrary(
            WorkflowResponseHandling.CreateApprovalRequestsCode(),
            Database::"Membership Exist",
            'Create an approval request for the record and send a notification.',
            'GROUP 0');

        WorkflowResponseHandling.AddResponseToLibrary(
            WorkflowResponseHandling.CreateApprovalRequestsCode(),
            Database::"Loan Recovery Header",
            'Create an approval request for the record and send a notification.',
            'GROUP 0');

        WorkflowResponseHandling.AddResponseToLibrary(
            WorkflowResponseHandling.CreateApprovalRequestsCode(),
            Database::"Default Notices Register",
            'Create an approval request for the record and send a notification.',
            'GROUP 0');

        WorkflowResponseHandling.AddResponseToLibrary(
            WorkflowResponseHandling.CreateApprovalRequestsCode(),
            Database::"Partial Loan Disbursments",
            'Create an approval request for the record and send a notification.',
            'GROUP 0');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', true, true)]
    procedure SetStatusToPendingApproval(var Variant: Variant)
    var
        RecRef: RecordRef;
        IsHandled: Boolean;
        MembershipApplication: Record "Membership Applications";
        LoansRegister: Record "Loans Register";
        LoanBatchDisbursements: Record "Loan Disburesment-Batching";
        ChangeRequest: Record "Change Request";
        GuarantorSubstitution: Record "Guarantorship Substitution H";
        ShareTransferHeader: record "Shares Transfer Header";
        MembershipExist: record "Membership Exist";
        BOSATransfers: record "BOSA Transfers";
        LoanRestructure: Record "Loan Restructure";
        LoanRecoveryHeader: Record "Loan Recovery Header";
        DefaultNoticesRegister: Record "Default Notices Register";

        PartialLoanDisbursments: Record "Partial Loan Disbursments";
    begin
        case RecRef.Number of //PettyCash Reimbursement

            //Guarantor Substitution
            Database::"Guarantorship Substitution H":
                begin
                    RecRef.SetTable(GuarantorSubstitution);
                    GuarantorSubstitution.Validate(Status, GuarantorSubstitution.Status::Pending);
                    GuarantorSubstitution.Modify(true);
                    Variant := GuarantorSubstitution;
                end;

            //Membership Application
            Database::"Membership Applications":
                begin
                    RecRef.SetTable(MembershipApplication);
                    MembershipApplication.Validate(Status, MembershipApplication.Status::"Pending Approval");
                    MembershipApplication.Modify(true);
                    Variant := MembershipApplication;
                end;
            //Loans Register
            Database::"Loans Register":
                begin
                    RecRef.SetTable(LoansRegister);
                    LoansRegister.Validate("Approval Status", LoansRegister."Approval Status"::Pending);
                    LoansRegister.Validate("loan status", LoansRegister."loan status"::Appraisal);
                    LoansRegister.Modify(true);
                    Variant := LoansRegister;
                end;


            //Loan Batch Disbursements
            Database::"Loan Disburesment-Batching":
                begin
                    RecRef.SetTable(LoanBatchDisbursements);
                    LoanBatchDisbursements.Validate(status, LoanBatchDisbursements.status::"Pending Approval");
                    LoanBatchDisbursements.Modify(true);
                    Variant := LoanBatchDisbursements;
                end;

            //Change Request
            Database::"Change Request":
                begin
                    RecRef.SetTable(ChangeRequest);
                    ChangeRequest.Validate(status, ChangeRequest.Status::Pending);
                    ChangeRequest.Modify(true);
                    Variant := ChangeRequest;
                end;

            //Share Transfer
            Database::"Shares Transfer Header":
                begin
                    RecRef.SetTable(ShareTransferHeader);
                    ShareTransferHeader.Validate(Status, ShareTransferHeader.Status::Pending);
                    ShareTransferHeader.Modify(true);
                    Variant := ShareTransferHeader;
                end;
            Database::"Membership Exist":
                begin
                    RecRef.SetTable(MembershipExist);
                    MembershipExist.Validate(Status, MembershipExist.Status::Pending);
                    MembershipExist.Modify(true);
                    Variant := MembershipExist;
                end;
            Database::"BOSA Transfers":
                begin
                    RecRef.SetTable(BOSATransfers);
                    BOSATransfers.Validate(Status, BOSATransfers.Status::"Pending Approval");
                    BOSATransfers.Modify(true);
                    Variant := BOSATransfers;
                end;
            Database::"Loan Restructure":
                begin
                    RecRef.SetTable(LoanRestructure);
                    LoanRestructure.Validate(Status, LoanRestructure.Status::"Pending Approval");
                    LoanRestructure.Modify(true);
                    Variant := LoanRestructure;
                end;
            //LoanRecoveryHeader: Record "Loan Recovery Header";
            Database::"Loan Recovery Header":
                begin
                    RecRef.SetTable(LoanRecoveryHeader);
                    LoanRecoveryHeader.Validate(Status, LoanRecoveryHeader.Status::Pending);
                    LoanRecoveryHeader.Modify(true);
                    Variant := LoanRecoveryHeader;
                end;
            // DefaultNoticesRegister
            Database::"Default Notices Register":
                begin
                    RecRef.SetTable(DefaultNoticesRegister);
                    DefaultNoticesRegister.Validate(Status, DefaultNoticesRegister.Status::"Pending Approval");
                    DefaultNoticesRegister.Modify(true);
                    Variant := DefaultNoticesRegister;
                end;
            //PartialLoanDisbursments
            Database::"Partial Loan Disbursments":
                begin
                    RecRef.SetTable(PartialLoanDisbursments);
                    PartialLoanDisbursments.Validate("Approval Status", PartialLoanDisbursments."Approval Status"::Pending);
                    PartialLoanDisbursments.Modify(true);
                    Variant := PartialLoanDisbursments;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        MembershipApplication: Record "Membership Applications";
        LoansRegister: Record "Loans Register";
        LoanBatchDisbursements: Record "Loan Disburesment-Batching";
        ChangeRequest: Record "Change Request";
        GuarantorSubstitution: Record "Guarantorship Substitution H";
        ShareTransferHeader: record "Shares Transfer Header";
        MembershipExist: record "Membership Exist";
        BOSATransfers: record "BOSA Transfers";
        LoanRestructure: Record "Loan Restructure";
        LoanRecoveryHeader: Record "Loan Recovery Header";
        DefaultNoticesRegister: Record "Default Notices Register";
        PartialLoanDisbursments: Record "Partial Loan Disbursments";
    begin
        case RecRef.Number of

            //Guarantor Substitution
            DATABASE::"Guarantorship Substitution H":
                begin
                    RecRef.SetTable(GuarantorSubstitution);
                    GuarantorSubstitution.Status := GuarantorSubstitution.Status::Open;
                    GuarantorSubstitution.Modify(true);
                    Handled := true;
                end;

            //Membership Application
            DATABASE::"Membership Applications":
                begin
                    RecRef.SetTable(MembershipApplication);
                    MembershipApplication.Status := MembershipApplication.Status::Open;
                    MembershipApplication.Modify(true);
                    Handled := true;
                end;
            //Loan Application
            Database::"Loans Register":
                begin
                    RecRef.SetTable(LoansRegister);
                    LoansRegister."Approval Status" := LoansRegister."Approval Status"::Open;
                    LoansRegister.Validate("loan status", LoansRegister."loan status"::Application);
                    LoansRegister.Modify(true);
                    Handled := true;
                end;

            //Loan Batch Disbursements
            Database::"Loan Disburesment-Batching":
                begin
                    RecRef.SetTable(LoanBatchDisbursements);
                    LoanBatchDisbursements.status := LoanBatchDisbursements.status::Open;
                    LoanBatchDisbursements.Modify(true);
                    Handled := true;
                end;

            // //Change Request
            Database::"Change Request":
                begin
                    RecRef.SetTable(ChangeRequest);
                    ChangeRequest.status := ChangeRequest.status::Open;
                    ChangeRequest.Modify(true);
                    Handled := true;
                end;


            //Share Transfer
            DATABASE::"Shares Transfer Header":
                begin
                    RecRef.SetTable(ShareTransferHeader);
                    ShareTransferHeader.Status := ShareTransferHeader.Status::Open;
                    ShareTransferHeader.Modify(true);
                    Handled := true;
                end;
            //Membership Exist
            DATABASE::"Membership Exist":
                begin
                    RecRef.SetTable(MembershipExist);
                    MembershipExist.Status := MembershipExist.Status::Open;
                    MembershipExist.Modify(true);
                    Handled := true;
                end;
            //BOSA Transfers
            DATABASE::"BOSA Transfers":
                begin
                    RecRef.SetTable(BOSATransfers);
                    BOSATransfers.Status := BOSATransfers.Status::Open;
                    BOSATransfers.Modify(true);
                    Handled := true;
                end;
            Database::"Loan Restructure":
                begin
                    RecRef.SetTable(LoanRestructure);
                    LoanRestructure.Status := LoanRestructure.Status::Open;
                    LoanRestructure.Modify(true);
                    Handled := true;
                end;
            //LoanRecoveryHeader: Record "Loan Recovery Header";
            Database::"Loan Recovery Header":
                begin
                    RecRef.SetTable(LoanRecoveryHeader);
                    LoanRecoveryHeader.Status := LoanRecoveryHeader.Status::Open;
                    LoanRecoveryHeader.Modify(true);
                    Handled := true;
                end;
            // DefaultNoticesRegister
            Database::"Default Notices Register":
                begin
                    RecRef.SetTable(DefaultNoticesRegister);
                    DefaultNoticesRegister.Status := DefaultNoticesRegister.Status::Open;
                    DefaultNoticesRegister.Modify(true);
                    Handled := true;
                end;
            // PartialLoanDisbursments: Record "Partial Loan Disbursments";
            Database::"Partial Loan Disbursments":
                begin
                    RecRef.SetTable(PartialLoanDisbursments);
                    PartialLoanDisbursments."Approval Status" := PartialLoanDisbursments."Approval Status"::Open;
                    PartialLoanDisbursments.Modify(true);
                    Handled := true;
                end;
        end
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        MembershipApplication: Record "Membership Applications";
        LoansRegister: Record "Loans Register";
        LoanBatchDisbursements: Record "Loan Disburesment-Batching";
        ChangeRequest: Record "Change Request";
        GuarantorSubstitution: Record "Guarantorship Substitution H";
        ShareTransferHeader: record "Shares Transfer Header";
        MembershipExist: record "Membership Exist";
        BOSATransfers: record "BOSA Transfers";
        LoanRestructure: Record "Loan Restructure";
        LoanRecoveryHeader: Record "Loan Recovery Header";
        DefaultNoticesRegister: Record "Default Notices Register";
        PartialLoanDisbursments: Record "Partial Loan Disbursments";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of

            //Guarantor Substitution
            Database::"Guarantorship Substitution H":
                begin
                    RecRef.SetTable(GuarantorSubstitution);
                    GuarantorSubstitution.Validate(Status, GuarantorSubstitution.Status::Pending);
                    GuarantorSubstitution.Modify(true);
                    IsHandled := true;
                end;

            //Membership Application
            Database::"Membership Applications":
                begin
                    RecRef.SetTable(MembershipApplication);
                    MembershipApplication.Validate(Status, MembershipApplication.Status::"Pending Approval");
                    MembershipApplication.Modify(true);
                    IsHandled := true;
                end;

            //Loan Application
            Database::"Loans Register":
                begin
                    RecRef.SetTable(LoansRegister);
                    LoansRegister.Validate("Approval Status", LoansRegister."Approval Status"::Pending);
                    LoansRegister.Validate("loan status", LoansRegister."loan status"::Appraisal);
                    LoansRegister.Modify(true);
                    IsHandled := true;
                end;


            //Loan Batch Disbursements
            Database::"Loan Disburesment-Batching":
                begin
                    RecRef.SetTable(LoanBatchDisbursements);
                    LoanBatchDisbursements.Validate(Status, LoanBatchDisbursements.Status::"Pending Approval");
                    LoanBatchDisbursements.Modify(true);
                    IsHandled := true;
                end;

            //Change Request
            Database::"Change Request":
                begin
                    RecRef.SetTable(ChangeRequest);
                    ChangeRequest.Validate(Status, ChangeRequest.Status::Pending);
                    ChangeRequest.Modify(true);
                    IsHandled := true;
                end;

            //Share Transfer
            Database::"Shares Transfer Header":
                begin
                    RecRef.SetTable(ShareTransferHeader);
                    ShareTransferHeader.Validate(Status, ShareTransferHeader.Status::Pending);
                    ShareTransferHeader.Modify(true);
                    IsHandled := true;
                end;
            //Membership Exist
            Database::"Membership Exist":
                begin
                    RecRef.SetTable(MembershipExist);
                    MembershipExist.Validate(Status, MembershipExist.Status::Pending);
                    MembershipExist.Modify(true);
                    IsHandled := true;
                end;
            //BOSA Transfers
            Database::"BOSA Transfers":
                begin
                    RecRef.SetTable(BOSATransfers);
                    BOSATransfers.Validate(Status, BOSATransfers.Status::"Pending Approval");
                    BOSATransfers.Modify(true);
                    IsHandled := true;
                end;
            Database::"Loan Restructure":
                begin
                    RecRef.SetTable(LoanRestructure);
                    LoanRestructure.Validate(Status, LoanRestructure.Status::"Pending Approval");
                    LoanRestructure.Modify(true);
                    IsHandled := true;
                end;
            //LoanRecoveryHeader: Record "Loan Recovery Header";
            Database::"Loan Recovery Header":
                begin
                    RecRef.SetTable(LoanRecoveryHeader);
                    LoanRecoveryHeader.Validate(Status, LoanRecoveryHeader.Status::Pending);
                    LoanRecoveryHeader.Modify(true);
                    IsHandled := true;
                end;
            // DefaultNoticesRegister
            Database::"Default Notices Register":
                begin
                    RecRef.SetTable(DefaultNoticesRegister);
                    DefaultNoticesRegister.Validate(Status, DefaultNoticesRegister.Status::"Pending Approval");
                    DefaultNoticesRegister.Modify(true);
                    IsHandled := true;
                end;
            // PartialLoanDisbursments: Record "Partial Loan Disbursments";
            Database::"Partial Loan Disbursments":
                begin
                    RecRef.SetTable(PartialLoanDisbursments);
                    PartialLoanDisbursments.Validate("Approval Status", PartialLoanDisbursments."Approval Status"::Pending);
                    PartialLoanDisbursments.Modify(true);
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', true, true)]
    local procedure SetRecStatusToPendingApproval(var Variant: Variant)
    var
        RecRef: RecordRef;
        IsHandled: Boolean;
        MembershipApplication: Record "Membership Applications";
        LoansRegister: Record "Loans Register";
        LoanBatchDisbursements: Record "Loan Disburesment-Batching";
        ChangeRequest: Record "Change Request";
        GuarantorSubstitution: Record "Guarantorship Substitution H";
        ShareTransferHeader: record "Shares Transfer Header";
        MembershipExist: record "Membership Exist";
        BOSATransfers: record "BOSA Transfers";
        LoanRestructure: Record "Loan Restructure";
        LoanRecoveryHeader: Record "Loan Recovery Header";
        DefaultNoticesRegister: Record "Default Notices Register";
        PartialLoanDisbursments: Record "Partial Loan Disbursments";
    begin
        case RecRef.Number of

            //Guarantor Substitution
            Database::"Guarantorship Substitution H":
                begin
                    RecRef.SetTable(GuarantorSubstitution);
                    GuarantorSubstitution.Validate(Status, GuarantorSubstitution.Status::Pending);
                    GuarantorSubstitution.Modify(true);
                    Variant := GuarantorSubstitution;
                end;

            //Membership Application
            Database::"Membership Applications":
                begin
                    RecRef.SetTable(MembershipApplication);
                    MembershipApplication.Validate(Status, MembershipApplication.Status::"Pending Approval");
                    MembershipApplication.Modify(true);
                    Variant := MembershipApplication;
                end;

            //Loan Application
            Database::"Loans Register":
                begin
                    RecRef.SetTable(LoansRegister);
                    LoansRegister.Validate("Approval Status", LoansRegister."Approval Status"::Pending);
                    LoansRegister.Validate("loan status", LoansRegister."loan status"::Appraisal);
                    LoansRegister.Modify(true);
                    Variant := LoansRegister;
                end;


            //Loan Batch Disbursements
            Database::"Loan Disburesment-Batching":
                begin
                    RecRef.SetTable(LoanBatchDisbursements);
                    LoanBatchDisbursements.Validate(status, LoanBatchDisbursements.Status::"Pending Approval");
                    LoanBatchDisbursements.Modify(true);
                    Variant := LoanBatchDisbursements;
                end;

            //Change Request
            Database::"Change Request":
                begin
                    RecRef.SetTable(ChangeRequest);
                    ChangeRequest.Validate(status, ChangeRequest.Status::Pending);
                    ChangeRequest.Modify(true);
                    Variant := ChangeRequest;
                end;

            //Share Transfer
            Database::"Shares Transfer Header":
                begin
                    RecRef.SetTable(ShareTransferHeader);
                    ShareTransferHeader.Validate(Status, ShareTransferHeader.Status::Pending);
                    ShareTransferHeader.Modify(true);
                    Variant := ShareTransferHeader;
                end;

            //Membership Exist
            Database::"Membership Exist":
                begin
                    RecRef.SetTable(MembershipExist);
                    MembershipExist.Validate(Status, MembershipExist.Status::Pending);
                    MembershipExist.Modify(true);
                    Variant := MembershipExist;
                end;
            //BOSA Transfers
            Database::"BOSA Transfers":
                begin
                    RecRef.SetTable(BOSATransfers);
                    BOSATransfers.Validate(Status, BOSATransfers.Status::"Pending Approval");
                    BOSATransfers.Modify(true);
                    Variant := BOSATransfers;
                end;
            Database::"Loan Restructure":
                begin
                    RecRef.SetTable(LoanRestructure);
                    LoanRestructure.Validate(Status, LoanRestructure.Status::"Pending Approval");
                    LoanRestructure.Modify(true);
                    Variant := LoanRestructure;
                end;
            //LoanRecoveryHeader: Record "Loan Recovery Header";
            Database::"Loan Recovery Header":
                begin
                    RecRef.SetTable(LoanRecoveryHeader);
                    LoanRecoveryHeader.Validate(Status, LoanRecoveryHeader.Status::Pending);
                    LoanRecoveryHeader.Modify(true);
                    Variant := LoanRecoveryHeader;
                end;
            // DefaultNoticesRegister
            Database::"Default Notices Register":
                begin
                    RecRef.SetTable(DefaultNoticesRegister);
                    DefaultNoticesRegister.Validate(Status, DefaultNoticesRegister.Status::"Pending Approval");
                    DefaultNoticesRegister.Modify(true);
                    Variant := DefaultNoticesRegister;
                end;
            // PartialLoanDisbursments: Record "Partial Loan Disbursments";
            Database::"Partial Loan Disbursments":
                begin
                    RecRef.SetTable(PartialLoanDisbursments);
                    PartialLoanDisbursments.Validate("Approval Status", PartialLoanDisbursments."Approval Status"::Pending);
                    PartialLoanDisbursments.Modify(true);
                    Variant := PartialLoanDisbursments;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        MemberShipApp: Record "Membership Applications";
        LoansRegister: Record "Loans Register";
        LoanBatchDisbursements: Record "Loan Disburesment-Batching";
        ChangeRequest: Record "Change Request";
        GuarantorSubstitution: Record "Guarantorship Substitution H";
        ShareTransferHeader: record "Shares Transfer Header";
        MembershipExist: record "Membership Exist";
        BOSATransfers: record "BOSA Transfers";
        LoanRestructure: Record "Loan Restructure";
        LoanRecoveryHeader: Record "Loan Recovery Header";
        DefaultNoticesRegister: Record "Default Notices Register";
        PartialLoanDisbursments: Record "Partial Loan Disbursments";
    begin
        case RecRef.Number of

            //"Guarantorship Substitution H"
            DATABASE::"Guarantorship Substitution H":
                begin
                    RecRef.SetTable(GuarantorSubstitution);
                    GuarantorSubstitution.Status := GuarantorSubstitution.Status::Approved;
                    GuarantorSubstitution.Modify(true);
                    Handled := true;
                end;

            //Membership applications
            DATABASE::"Membership Applications":
                begin
                    RecRef.SetTable(MemberShipApp);
                    MemberShipApp.Status := MemberShipApp.Status::Approved;
                    MemberShipApp.Modify(true);
                    Handled := true;
                end;

            //Loans Applications
            DATABASE::"Loans Register":
                begin
                    RecRef.SetTable(LoansRegister);
                    LoansRegister."Approval Status" := LoansRegister."Approval Status"::Approved;
                    LoansRegister.Validate("loan status", LoansRegister."loan status"::Disbursed);
                    LoansRegister.Modify(true);
                    //send sms
                    //AFactory.FnSendNotifications(LoansRegister."Loan  No.");
                    Handled := true;
                end;


            //Loan Batching
            DATABASE::"Loan Disburesment-Batching":
                begin
                    RecRef.SetTable(LoanBatchDisbursements);
                    LoanBatchDisbursements.Status := LoanBatchDisbursements.Status::Approved;
                    LoanBatchDisbursements.Modify(true);
                    Handled := true;
                end;

            //Change Request
            DATABASE::"Change Request":
                begin
                    RecRef.SetTable(ChangeRequest);
                    ChangeRequest.Status := ChangeRequest.Status::Approved;
                    ChangeRequest.Modify(true);
                    Handled := true;
                end;


            //Shares Transfer
            DATABASE::"Shares Transfer Header":
                begin
                    RecRef.SetTable(ShareTransferHeader);
                    ShareTransferHeader.Status := ShareTransferHeader.Status::Approved;
                    ShareTransferHeader."Approved By" := UserId;
                    ShareTransferHeader.Modify(true);
                    Handled := true;
                end;
            //

            //Membership Exist
            DATABASE::"Membership Exist":
                begin
                    RecRef.SetTable(MembershipExist);
                    MembershipExist.Validate(Status, MembershipExist.Status::Approved);
                    MembershipExist.Modify(true);
                    Handled := true;
                end;
            //BOSA Transfers
            DATABASE::"BOSA Transfers":
                begin
                    RecRef.SetTable(BOSATransfers);
                    BOSATransfers.Status := BOSATransfers.Status::Approved;
                    Message('appro is %1', BOSATransfers.Status);
                    BOSATransfers."Approved By" := UserId;
                    BOSATransfers.Modify(true);
                    Handled := true;
                end;
            Database::"Loan Restructure":
                begin
                    RecRef.SetTable(LoanRestructure);
                    LoanRestructure.Status := LoanRestructure.Status::Approved;
                    LoanRestructure."Approved By" := UserId;
                    LoanRestructure."Approved Date" := WorkDate();
                    LoanRestructure.Modify(true);
                    Handled := true;
                end;
            //LoanRecoveryHeader: Record "Loan Recovery Header";
            Database::"Loan Recovery Header":
                begin
                    RecRef.SetTable(LoanRecoveryHeader);
                    LoanRecoveryHeader.Status := LoanRecoveryHeader.Status::Approved;
                    LoanRecoveryHeader."Approved By" := UserId;
                    LoanRecoveryHeader."Approved Date" := WorkDate();
                    LoanRecoveryHeader.Modify(true);
                    Handled := true;
                end;
            // DefaultNoticesRegister
            Database::"Default Notices Register":
                begin
                    RecRef.SetTable(DefaultNoticesRegister);
                    DefaultNoticesRegister.Status := DefaultNoticesRegister.Status::Approved;
                    DefaultNoticesRegister.Modify(true);
                    Handled := true;
                end;
            // PartialLoanDisbursments: Record "Partial Loan Disbursments";
            Database::"Partial Loan Disbursments":
                begin
                    RecRef.SetTable(PartialLoanDisbursments);
                    PartialLoanDisbursments."Approval Status" := PartialLoanDisbursments."Approval Status"::Approved;
                    PartialLoanDisbursments.Modify(true);
                    Handled := true;
                end;

        end;
    end;
}
