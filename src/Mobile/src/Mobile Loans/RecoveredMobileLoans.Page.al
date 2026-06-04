page 50691 "Recovered Mobile Loans"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Loans Register";
    UsageCategory = Administration;
    Editable = false;
    SourceTableView = where("Loan Product Type" = filter('RUAIMOBI'));
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Loan  No."; Rec."Loan  No.")
                {

                }
                field("Client Code"; Rec."Client Code")
                {
                    Caption = 'Member No';
                }
                field("Loan Product Type"; rec."Loan Product Type") { }
                field("Client Name"; rec."Client Name") { }
                field("Mobile Loan Recovered"; rec."Mobile Loan Recovered") { }
                field("Mobile Loan Recovered By"; rec."Mobile Loan Recovered By") { }
                field("Mobile Loan Recovery Date"; rec."Mobile Loan Recovery Date") { }
                field("Recovered Arrears Amount"; rec."Recovered Arrears Amount") { }
                field("Outstanding Balance"; rec."Outstanding Balance") { }
                field("Approved Amount"; rec."Approved Amount") { }
                field("Expected Date of Completion"; rec."Expected Date of Completion") { }
                field("Loan Disbursement Date"; rec."Loan Disbursement Date") { }
                field("1D After Loan Completion Date"; rec."1D After Loan Completion Date")
                {
                    Caption = '1D After Loan Completion Date';
                }
                field("1D Before Loan Completion Date"; rec."1D Before Loan Completion Date")
                {
                    Caption = '1D Before Loan Completion Date';
                }
                field("7D Before Loan Completion Date"; rec."7D Before Loan Completion Date")
                {
                    Caption = '7D Before Loan Completion Date';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Mobile Loan Recovery")
            {
                ApplicationArea = Basic;
                Enabled = true;
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    CFTFactory: Codeunit "CFT Factory";
                begin
                    If Not Confirm('Are you sure you need to recover defaulted mobile loans ?') then begin
                        exit;
                    end;
                    CFTFactory.FnRecoverDefaultedMobileLoans();
                    Message('Loans Recovered Successfuly.');
                end;
            }
            action("Mobile Loan Recovery Reminders")
            {
                ApplicationArea = Basic;
                Enabled = true;
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    CFTFactory: Codeunit "CFT Factory";
                begin
                    If Not Confirm('Are you sure you need to send mobile loan reminders ?') then begin
                        exit;
                    end;
                    CFTFactory.FnSendMobileLoanReminders();
                    Message('Mobile Loan Reminders Sent Successfuly.');
                end;
            }
        }
    }
}
