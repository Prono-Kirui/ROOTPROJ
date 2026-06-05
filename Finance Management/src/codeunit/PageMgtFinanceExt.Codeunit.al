codeunit 51012 "Page Mgt Finance Ext"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', false, false)]
    local procedure OnAfterGetPageID(RecordRef: RecordRef; var PageID: Integer)
    begin

        case RecordRef.Number of
            //Payments
            Database::Payments:
                PageID := (GetPaymentsPageID(RecordRef));
            //Budget approval
            Database::"Budget Approval Header":
                PageID := GetBudgetApprovalPage(RecordRef);
            //Proposed Budget approval
            Database::"Proposed Budget Header":
                PageID := (Page::"Proposed Budget Card");
            Database::"User Changes":
                PageID := Page::"User Change Card";
        end;
    end;

    local procedure GetPaymentsPageID(RecordRef: RecordRef): Integer
    var
        Payments: Record Payments;
    begin
        RecordRef.SetTable(Payments);
        case Payments."Payment Type" of
            Payments."Payment Type"::Imprest:
                exit(Page::Imprest);
            Payments."Payment Type"::"Imprest Surrender":
                exit(Page::"Imprest Surrender");
            Payments."Payment Type"::"Petty Cash":
                exit(Page::"Petty Cash");
            Payments."Payment Type"::"Petty Cash Surrender":
                exit(Page::"Petty Cash Surrender");
            Payments."Payment Type"::"Payment Voucher":
                exit(Page::"Payment Voucher");
            Payments."Payment Type"::"Staff Claim":
                exit(Page::"Staff Claim");
            Payments."Payment Type"::"Bank Transfer":
                exit(Page::"InterBank Transfer");
            Payments."Payment Type"::"Property Expense":
                exit(Page::"Property Expense Request");
            Payments."Payment Type"::"Property Expense Surrender":
                exit(Page::"Property Expense Surrender");
        end;
    end;

    local procedure GetBudgetApprovalPage(RecordRef: RecordRef): Integer
    var
        BudgetRec: Record "Budget Approval Header";
    begin
        RecordRef.SetTable(BudgetRec);
        case BudgetRec."Budget Type" of
            BudgetRec."Budget Type"::Budget:
                exit(Page::"Budget Approved Card");
        /* BudgetRec."Budget Type"::"Procurement Plan":
            exit(Page::"Procurement Plan Approved Card"); */
        end;
    end;
}
