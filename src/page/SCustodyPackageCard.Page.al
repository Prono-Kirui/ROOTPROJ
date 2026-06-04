#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50945 "SCustody Package Card"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Safe Custody Package Register";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Package ID"; Rec."Package ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Package Type"; Rec."Package Type")
                {
                    ApplicationArea = Basic;
                }
                field("Package Description"; Rec."Package Description")
                {
                    ApplicationArea = Basic;
                }
                field("Custody Period"; Rec."Custody Period")
                {
                    ApplicationArea = Basic;
                }
                field("Charge Account"; Rec."Charge Account")
                {
                    ApplicationArea = Basic;
                }
                field("Charge Account Name"; Rec."Charge Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Maturity Instruction"; Rec."Maturity Instruction")
                {
                    ApplicationArea = Basic;
                }
                field("File Serial No"; Rec."File Serial No")
                {
                    ApplicationArea = Basic;
                }
                field("Date Received"; Rec."Date Received")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Time Received"; Rec."Time Received")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Received By"; Rec."Received By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Lodged By(Custodian 1)"; Rec."Lodged By(Custodian 1)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Lodged By(Custodian 2)"; Rec."Lodged By(Custodian 2)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Lodged"; Rec."Date Lodged")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Time Lodged"; Rec."Time Lodged")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Released By(Custodian 1)"; Rec."Released By(Custodian 1)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Released By(Custodian 2)"; Rec."Released By(Custodian 2)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Released"; Rec."Date Released")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Time Released"; Rec."Time Released")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Collected By"; Rec."Collected By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Collected On"; Rec."Collected On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Collected At"; Rec."Collected At")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Maturity Date"; Rec."Maturity Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Retrieved By(Custodian 1)"; Rec."Retrieved By(Custodian 1)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Retrieved By (Custodian 2)"; Rec."Retrieved By (Custodian 2)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Retrieved On"; Rec."Retrieved On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Retrieved At"; Rec."Retrieved At")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Package Re_Booked On"; Rec."Package Re_Booked On")
                {
                    ApplicationArea = Basic;
                }
                field("Package Rebooked By"; Rec."Package Rebooked By")
                {
                    ApplicationArea = Basic;
                }
                field("Package Re_Lodge Fee Charged"; Rec."Package Re_Lodge Fee Charged")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            // part(Control41; "Package Retrieval SubPage")
            // {
            //     Caption = 'Package Retrieval Request Hsitory';
            //     SubPageLink = "Package ID" = field("Package ID");
            // }
        }
    }

    actions
    {
        area(creation)
        {
            group(Documents)
            {
                action("Package Agent")
                {
                    ApplicationArea = Basic;
                    Image = DocumentEdit;
                    Promoted = true;
                    PromotedCategory = Process;
                    // RunObject = Page "SCustody Agent List";
                    // RunPageLink = "Package ID" = field("Package ID");
                }
                action("Package Items")
                {
                    ApplicationArea = Basic;
                    Image = DocumentEdit;
                    Promoted = true;
                    PromotedCategory = Process;
                    // RunObject = Page "Safe Custody Item List";
                    // RunPageLink = "Package ID" = field("Package ID");
                }
            }
            action("Retrieve Package")
            {
                ApplicationArea = Basic;
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;
                //  RunObject = Page "Package Retrieval Request List";
            }
        }
    }

    var
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval;
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        MicropointFactory: Codeunit "Micropoint Factory";
        JTemplate: Code[20];
        JBatch: Code[20];
        GenSetup: Record "Sacco General Set-Up";
        DocNo: Code[20];
        LineNo: Integer;
        TransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares";
        AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Member,Investor;
        BalAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        ObjPackageTypes: Record "Package Types";
        LodgeFee: Decimal;
        LodgeFeeAccount: Code[20];
        ObjCustodians: Record "Safe Custody Custodians";
        ObjItems: Record "Safe Custody Item Register";
        ObjAgents: Record "Safe Custody Agents Register";
}

