codeunit 51003 "Release Payments"
{
    Permissions = tabledata "Approval Entry" = rimd;
    TableNo = Payments;

    var
        Text003Err: Label 'The approval process must be canceled or completed to reopen this document.';

    trigger OnRun()
    begin
        if Rec.Status = Rec.Status::Released then
            exit;

        OnBeforeReleasePayments(Rec);

        Rec.Status := Rec.Status::Released;
        /*
        if "Payment Type"="Payment Type"::Imprest then
        Committment.ImprestCommittment(Rec);
        */
        Rec.Modify(true);

        OnAfterReleasePayments(Rec);
    end;

    procedure PerformManualRelease(var Payments: Record Payments)
    begin
        // IF ApprovalsMgmt.IsPaymentsApprovalsWorkflowEnabled(Payments) AND (Payments.Status = Payments.Status::Open) THEN
        //  ERROR(Text002);
        Codeunit.Run(Codeunit::"Release Payments", Payments);
    end;

    procedure PerformManualReopen(var Payments: Record Payments)
    begin
        if Payments.Status = Payments.Status::"Pending Approval" then
            Error(Text003Err);
        Reopen(Payments);
    end;

    procedure Reopen(var Payments: Record Payments)
    begin
        OnBeforeReopenPayments(Payments);
        if Payments.Status = Payments.Status::Open then
            exit;
        Payments.Status := Payments.Status::Open;
        Payments.Modify(true);
        OnAfterReopenPayments(Payments);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterReleasePayments(var Payments: Record Payments)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterReopenPayments(var Payments: Record Payments)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeReleasePayments(var Payments: Record Payments)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeReopenPayments(var Payments: Record Payments)
    begin
    end;
}
