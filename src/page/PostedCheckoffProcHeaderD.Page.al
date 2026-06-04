#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50485 "Posted Checkoff Proc. Header-D"
{
    DeleteAllowed = false;
    Editable = false;
    PageType = Card;
    SourceTable = "Checkoff Header-Distributed";
    SourceTableView = where(Posted = const(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Entered By"; Rec."Entered By")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting date"; Rec."Posting date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Loan CutOff Date"; Rec."Loan CutOff Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Count"; Rec."Total Count")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Document No./ Cheque No.';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Total Scheduled"; Rec."Total Scheduled")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = true;
                }
            }
            part("Checkoff Lines-Distributed"; "Checkoff Processing Lines-D")
            {
                Caption = 'Checkoff Lines-Distributed';
                SubPageLink = "Checkoff No" = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {


            action("Unallocated Funds")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = "Report";
                Visible = false;

                trigger OnAction()
                begin
                    ReptProcHeader.Reset;
                    ReptProcHeader.SetRange(ReptProcHeader.No, Rec.No);
                    if ReptProcHeader.Find('-') then
                        Report.Run(50542, true, false, ReptProcHeader);
                end;
            }
            group(ActionGroup1102755019)
            {
            }

            action("Process Checkoff Unallocated")
            {
                ApplicationArea = Basic;
                Visible = false;

                trigger OnAction()
                begin
                    MembLedg.Reset;
                    MembLedg.SetRange(MembLedg."Document No.", Rec."Document No");
                    if MembLedg.Find('-') = false then begin
                        Error('You Can Only do this process on Already Posted Checkoffs')
                    end;
                    ReceiptLine.Reset;
                    //ReceiptLine.SETRANGE(ReceiptLine."Receipt Header No",No);
                    //IF ReceiptLine.FIND('-') THEN
                    //REPORT.RUN(50543,TRUE,FALSE,ReceiptLine);
                end;
            }
            action("Process Annual Charge")
            {
                ApplicationArea = Basic;
                Image = AuthorizeCreditCard;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    Rec.TestField("Document No");
                    Rec.TestField(Amount);
                    ReceiptLine.Reset;
                    //ReceiptLine.SETRANGE(ReceiptLine."Receipt Header No",No);
                    //IF ReceiptLine.FIND('-') THEN
                    //REPORT.RUN(50100,TRUE,FALSE,ReceiptLine);
                end;
            }
            action("Mark as Posted")
            {
                ApplicationArea = Basic;
                Enabled = false;
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to mark this Checkoff as Posted ?', false) = true then begin
                        MembLedg.Reset;
                        MembLedg.SetRange(MembLedg."Document No.", Rec.Remarks);
                        if MembLedg.Find('-') = false then
                            Error('Sorry,You can only do this process on already posted Checkoffs');
                        Rec.Posted := true;
                        Rec."Posted By" := UserId;
                        Rec."Posting date" := Today;
                        Rec.Modify;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        MembLedg.Reset;
        MembLedg.SetRange(MembLedg."Document No.", Rec.Remarks);
        if MembLedg.Find('-') = true then
            ActionEnabled := false;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Posting date" := Today;
        Rec."Date Entered" := Today;
    end;

    var
        Gnljnline: Record "Gen. Journal Line";
        PDate: Date;
        DocNo: Code[20];
        RunBal: Decimal;
        ReceiptsProcessingLines: Record "Checkoff Lines-Distributed";
        LineNo: Integer;
        LBatches: Record "Loan Disburesment-Batching";
        Jtemplate: Code[30];
        JBatch: Code[30];
        "Cheque No.": Code[20];
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        ReptProcHeader: Record "Checkoff Header-Distributed";
        Cust: Record customer;
        MembPostGroup: Record "Customer Posting Group";
        Loantable: Record "Loans Register";
        LRepayment: Decimal;
        RcptBufLines: Record "Checkoff Lines-Distributed";
        LoanType: Record "Loan Products Setup";
        LoanApp: Record "Loans Register";
        Interest: Decimal;
        LineN: Integer;
        TotalRepay: Decimal;
        MultipleLoan: Integer;
        LType: Text;
        MonthlyAmount: Decimal;
        ShRec: Decimal;
        SHARESCAP: Decimal;
        DIFF: Decimal;
        DIFFPAID: Decimal;
        genstup: Record "Sacco General Set-Up";
        Memb: Record Customer;
        INSURANCE: Decimal;
        GenBatches: Record "Gen. Journal Batch";
        Datefilter: Text[50];
        ReceiptLine: Record "Checkoff Lines-Distributed";
        MembLedg: Record "Cust. Ledger Entry";
        SFactory: Codeunit "Micropoint Factory";
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        DOCUMENT_NO: Code[40];
        GenJournalLine: Record "Gen. Journal Line";
        ActionEnabled: Boolean;

    local procedure FnGetLoanNumber(MemberNo: Code[40]; "Loan Product Code": Code[100]): Code[100]
    var
        ObjLoans: Record "Loans Register";
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange("Client Code", MemberNo);
        ObjLoans.SetRange("Loan Product Type", "Loan Product Code");
        if ObjLoans.FindFirst then
            exit(ObjLoans."Loan  No.");
    end;

    local procedure FnGetFosaAccountNo(BosaAccountNo: Code[40]; "Product Code": Code[100]): Code[100]
    var
        ObjVendor: Record Vendor;
    begin
        ObjVendor.Reset;
        ObjVendor.SetRange("BOSA Account No", BosaAccountNo);
        ObjVendor.SetRange("Account Type", "Product Code");
        if ObjVendor.Find('-') then
            exit(ObjVendor."No.");
    end;

    local procedure FnCheckLoanErrors(LoanProduct: Code[100]; Amount: Decimal; MemberNo: Code[40]): Boolean
    var
        ObjLoans: Record "Loans Register";
    begin
        if Amount > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetRange("Client Code", MemberNo);
            ObjLoans.SetRange("Loan Product Type", LoanProduct);
            if ObjLoans.FindFirst = false then
                exit(true);
        end;
    end;
}

