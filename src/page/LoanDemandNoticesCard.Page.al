#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50981 "Loan Demand Notices Card"
{
    PageType = Card;
    SourceTable = "Default Notices Register";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                    Editable = MemberNoEditable;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan In Default"; Rec."Loan In Default")
                {
                    ApplicationArea = Basic;
                    Editable = LoanInDefaultEditable;
                }
                field("Loan Product"; Rec."Loan Product")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Instalments"; Rec."Loan Instalments")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Completion Date"; Rec."Expected Completion Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Amount In Arrears"; Rec."Amount In Arrears")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Days In Arrears"; Rec."Days In Arrears")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Outstanding Balance"; Rec."Loan Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Notice Type"; Rec."Notice Type")
                {
                    ApplicationArea = Basic;
                    Editable = NoticeTypeEditable;

                    trigger OnValidate()
                    begin
                        FnenableVisbility();
                    end;
                }


                field("Demand Notice Date"; Rec."Demand Notice Date")
                {
                    ApplicationArea = Basic;
                    Editable = DemandNoticeDateEditable;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }



                field("Email Sent"; Rec."Email Sent")
                {
                    ApplicationArea = Basic;
                }
                field("SMS Sent"; Rec."SMS Sent")
                {
                    ApplicationArea = Basic;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                //VarAuctioneerDetailsVisible
                field(VarAuctioneerDetailsVisible; VarAuctioneerDetailsVisible)
                {
                    Caption = 'Auctioneer Details';
                    ApplicationArea = Basic;
                }

            }
            group("Auctioneer Details")
            {
                Visible = VarAuctioneerDetailsVisible;
                field("Auctioneer No"; Rec."Auctioneer No")
                {
                    ApplicationArea = Basic;
                }
                field("Auctioneer  Name"; Rec."Auctioneer  Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Auctioneer Address"; Rec."Auctioneer Address")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Auctioneer Mobile No"; Rec."Auctioneer Mobile No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Auctioneer Email"; Rec."Auctioneer Email")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                //Debt Collector Notice
                field(VarDebtCollectorVisible; VarDebtCollectorVisible)
                {
                    ApplicationArea = Basic;
                    Caption = 'Debt Collector Details Visible';
                    //Editable = false;
                }
                //VarCRBNoticeVisible
                field(VarCRBNoticeVisible; VarCRBNoticeVisible)
                {
                    ApplicationArea = Basic;
                    Caption = 'CRB Notice Details Visible';
                    //Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group("Demand Letters")
            {
                action("Demand Notice Letter")
                {
                    ApplicationArea = Basic;
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = VarDemandNoticeVisible;

                    trigger OnAction()
                    begin
                        if Rec.Status <> Rec.Status::Approved THEN
                            ERROR('You can only print Demand Notice for Approved Demand Notices');

                        ObjLoans.Reset;
                        ObjLoans.SetRange(ObjLoans."Loan  No.", Rec."Loan In Default");
                        if ObjLoans.FindSet then begin
                            Report.Run(50925, true, true, ObjLoans);
                        end;

                    end;
                }
                action("CRB Demand Letter")
                {
                    ApplicationArea = Basic;
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = VarCRBNoticeVisible;

                    trigger OnAction()
                    begin
                        if Rec.Status <> Rec.Status::Approved THEN
                            ERROR('You can only print CRB Notice for Approved Demand Notices');
                        ObjLoans.Reset;
                        ObjLoans.SetRange(ObjLoans."Loan  No.", Rec."Loan In Default");
                        if ObjLoans.FindSet then begin
                            Report.Run(50926, true, true, ObjLoans);
                        end;
                    end;
                }
                action("Debt Collector Demand Letter")
                {
                    ApplicationArea = Basic;
                    Caption = 'Debt Collector Demand Letter';
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = VarDebtCollectorVisible;

                    trigger OnAction()
                    begin
                        if Rec.Status <> Rec.Status::Approved THEN
                            ERROR('You can only print Debt Collector Notice for Approved Demand Notices');
                        ObjDemands.Reset;
                        ObjDemands.SetRange(ObjDemands."Document No", Rec."Document No");
                        if ObjDemands.FindSet then begin
                            Report.Run(50928, true, true, ObjDemands);
                        end;
                    end;
                }



            }
            group(Approvals)
            {
                Caption = 'Approvals';
                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::DemandNotice;
                        ApprovalEntries.Setfilters(Database::"Default Notices Register", DocumentType, Rec."Document No");
                        ApprovalEntries.Run;
                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Text001: label 'This transaction is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalmentcodeUnit.SendDefaultNoticesRegisterForApproval(Rec."Document No", Rec);
                        Message('Approval Request Sent Successfully');
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Enabled = CanCancelApprovalForRecord;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalmentcodeUnit.CancelDefaultNoticesRegisterForApproval(Rec."Document No", Rec);
                        Message('Approval Request Cancelled Successfully');
                        CurrPage.Close();

                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        /*
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        EnabledApprovalWorkflowsExist :=TRUE;
        IF Rec.Status=Status::Approved THEN BEGIN
          OpenApprovalEntriesExist:=FALSE;
          CanCancelApprovalForRecord:=FALSE;
          EnabledApprovalWorkflowsExist:=FALSE;
          END;
          */

    end;

    trigger OnAfterGetRecord()
    begin
        FnenableVisbility;
        FNenableEditing;
        FnRunShowRelevantButton;

        EnableSendNotice := false;
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        // CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Rec.Status::Approved)) then
            EnableSendNotice := true;
    end;

    trigger OnOpenPage()
    begin
        FnenableVisbility;
        FNenableEditing;
        FnRunShowRelevantButton;
    end;

    var
        ApprovalmentcodeUnit: Codeunit "Micropoint ApprovalsCodeUnit";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange,HouseRegistration,LoanPayOff,FixedDeposit,RTGS,DemandNotice;
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
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
        ObjLoans: Record "Loans Register";
        ObjDemands: Record "Default Notices Register";
        VarAuctioneerDetailsVisible: Boolean;
        // SMTPSetup: Record "SMTP Mail Setup";
        ObjHouseGroup: Record "Member House Groups";
        EnableSendNotice: Boolean;
        MemberNoEditable: Boolean;
        LoanInDefaultEditable: Boolean;
        NoticeTypeEditable: Boolean;
        DemandNoticeDateEditable: Boolean;
        EnableSend: Boolean;
        VarEmailSubject: Text[200];
        VarEmailBody: Text[250];
        ObjLoanType: Record "Loan Products Setup";
        VarLoanProductName: Text[50];
        ObjGensetup: Record "Sacco General Set-Up";
        VarDepartmentMail: Text[50];
        VarHouseLeaderMail: Text[50];
        VarAssHouseLeaderMail: Text[50];
        VarDemandNoticeVisible: Boolean;
        VarCRBNoticeVisible: Boolean;
        VarDebtCollectorVisible: Boolean;
        VarCCEmails: Text;

    local procedure FnenableVisbility()
    begin
        VarAuctioneerDetailsVisible := false;

        if Rec."Notice Type" = Rec."notice type"::"Debt Collector Notice" then begin
            VarAuctioneerDetailsVisible := true;
        end
    end;

    local procedure FNenableEditing()
    begin
        if Rec.Status = Rec.Status::Open then begin
            MemberNoEditable := true;
            LoanInDefaultEditable := true;
            NoticeTypeEditable := true;
            DemandNoticeDateEditable := true
        end else
            MemberNoEditable := false;
        LoanInDefaultEditable := false;
        NoticeTypeEditable := false;
        DemandNoticeDateEditable := false;
    end;

    // local procedure FnRunSendCopytoHouseGroupLeader(VarDemandNoticeNo: Code[30]; VarHouseGroup: Code[50]; VarMemberName: Text[100])
    // var
    //     Filename: Text[100];
    //     SMTPSetup: Record "SMTP Mail Setup";
    //     SMTPMail: Codeunit UnknownCodeunit400;
    //     VarMemberEmail: Text[50];
    //     ObjMember: Record "Members Register";
    //     Attachment: Text[250];
    //     ObjLoanType: Record "Loan Products Setup";
    //     VarProductDescription: Code[50];
    //     ObjDemandNotices: Record "Default Notices Register";
    //     LeaderName: Text[100];
    // begin
    //     //================================================Send to Group Leader
    //     SMTPSetup.Get();

    //     ObjLoans.Reset;
    //     ObjLoans.SetRange(ObjLoans."Loan  No.", VarDemandNoticeNo);
    //     if ObjLoans.FindSet then begin
    //         if ObjHouseGroup.Get(VarHouseGroup) then begin
    //             VarMemberEmail := Lowercase(ObjHouseGroup."Group Leader Email");
    //             LeaderName := Lowercase(ObjHouseGroup."Group Leader Name");
    //         end;
    //         Filename := '';
    //         Filename := SMTPSetup."Path to Save Report" + 'DemandNotice.pdf';
    //         Report.SaveAsPdf(Report::"Loan Demand Notice", Filename, ObjLoans);

    //         if ObjLoanType.Get("Loan Product") then begin
    //             VarLoanProductName := ObjLoanType."Product Description";
    //         end;

    //         VarEmailSubject := 'Loan Demand Notice';
    //         VarEmailBody := 'Please find attached a demand notice for a ' + VarLoanProductName + 'Loan Account ' + "Loan In Default" + ' defaulted by ' + "Member Name" + ' a member of your House Group';

    //         EnableSend := MicropointFactory.FnSendStatementViaMail(LeaderName, VarEmailSubject, VarEmailBody, VarMemberEmail, 'DemandNotice.pdf', '');

    //     end;


    //     //==============================================Send to Assistant Group Leader
    //     ObjLoans.Reset;
    //     ObjLoans.SetRange(ObjLoans."Loan  No.", VarDemandNoticeNo);
    //     if ObjLoans.FindSet then begin
    //         if ObjHouseGroup.Get(VarHouseGroup) then begin
    //             VarMemberEmail := Lowercase(ObjHouseGroup."Assistant Group Leader Email");
    //             LeaderName := Lowercase(ObjHouseGroup."Assistant Group Name");
    //         end;
    //         Filename := '';
    //         Filename := SMTPSetup."Path to Save Report" + 'DemandNotice.pdf';
    //         Report.SaveAsPdf(Report::"Loan Demand Notice", Filename, ObjLoans);

    //         if ObjLoanType.Get("Loan Product") then begin
    //             VarProductDescription := ObjLoanType."Product Description";
    //         end;

    //         VarEmailSubject := 'Loan Demand Notice';
    //         VarEmailBody := 'Please find attached a demand notice for a ' + VarLoanProductName + 'Loan Account ' + "Loan In Default" + ' defaulted by ' + "Member Name" + ' a member of your House Group';

    //         EnableSend := MicropointFactory.FnSendStatementViaMail(LeaderName, VarEmailSubject, VarEmailBody, VarMemberEmail, 'DemandNotice.pdf', '');
    //     end;
    // end;

    // local procedure FnRunSendCopyGuarantors(VarLoanNo: Code[30]; VarMemberName: Code[100])
    // var
    //     Filename: Text[100];
    //     SMTPSetup: Record "SMTP Mail Setup";
    //     SMTPMail: Codeunit UnknownCodeunit400;
    //     VarMemberEmail: Text[50];
    //     ObjMember: Record "Members Register";
    //     Attachment: Text[250];
    //     ObjLoanType: Record "Loan Products Setup";
    //     VarProductDescription: Code[50];
    //     ObjDemandNotices: Record "Default Notices Register";
    //     MemberName: Text[100];
    //     ObjLoanGuarantors: Record "Loans Guarantee Details";
    // begin
    //     SMTPSetup.Get();

    //     ObjLoans.Reset;
    //     ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
    //     if ObjLoans.FindSet then begin
    //         ObjLoanGuarantors.Reset;
    //         ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Loan No", VarLoanNo);
    //         if ObjLoanGuarantors.FindSet then begin
    //             repeat
    //                 if ObjMember.Get(ObjLoanGuarantors."Member No") then begin
    //                     VarMemberEmail := Lowercase(ObjMember."E-Mail");
    //                     MemberName := Lowercase(ObjMember.Name);
    //                 end;

    //                 Filename := '';
    //                 Filename := SMTPSetup."Path to Save Report" + 'DemandNotice.pdf';
    //                 Report.SaveAsPdf(Report::"Loan Demand Notice", Filename, ObjLoans);
    //                 if ObjLoanType.Get("Loan Product") then begin
    //                     VarProductDescription := ObjLoanType."Product Description";
    //                 end;

    //                 if ObjLoanType.Get("Loan Product") then begin
    //                     VarProductDescription := ObjLoanType."Product Description";
    //                 end;

    //                 VarEmailSubject := 'Loan Demand Notice';
    //                 VarEmailBody := 'Please find attached a demand notice for a ' + VarLoanProductName + 'Loan Account ' + "Loan In Default" + ' defaulted by ' + "Member Name";

    //                 EnableSend := MicropointFactory.FnSendStatementViaMail(MemberName, VarEmailSubject, VarEmailBody, VarMemberEmail, 'DemandNotice.pdf', '');

    //             until ObjLoanGuarantors.Next = 0;
    //         end;
    //     end;
    // end;

    // local procedure FnRunSendDemandNoticeCopyDepartment(VarDemandNoticeNo: Code[30]; VarMemberName: Code[100])
    // var
    //     Filename: Text[100];
    //     SMTPSetup: Record "SMTP Mail Setup";
    //     SMTPMail: Codeunit UnknownCodeunit400;
    //     VarMemberEmail: Text[50];
    //     ObjMember: Record "Members Register";
    //     Attachment: Text[250];
    //     ObjLoanType: Record "Loan Products Setup";
    //     VarProductDescription: Code[50];
    //     ObjDemandNotices: Record "Default Notices Register";
    //     LeaderName: Text[100];
    //     ObjLoanGuarantors: Record "Loans Guarantee Details";
    //     ObjGensetup: Record "Sacco General Set-Up";
    // begin
    //     SMTPSetup.Get();
    //     ObjGensetup.Get();

    //     ObjLoans.Reset;
    //     ObjLoans.SetRange(ObjLoans."Loan  No.", VarDemandNoticeNo);
    //     if ObjLoans.FindSet then begin

    //         if ObjMember.Get(ObjLoanGuarantors."Member No") then begin
    //             VarMemberEmail := Lowercase(ObjGensetup."Credit Department E-mail");
    //             LeaderName := 'Credit Team';
    //         end;
    //         Filename := '';
    //         Filename := SMTPSetup."Path to Save Report" + 'DemandNotice.pdf';
    //         Report.SaveAsPdf(Report::"Loan Demand Notice", Filename, ObjLoans);
    //         if ObjLoanType.Get("Loan Product") then begin
    //             VarProductDescription := ObjLoanType."Product Description";
    //         end;


    //         if ObjLoanType.Get("Loan Product") then begin
    //             VarProductDescription := ObjLoanType."Product Description";
    //         end;

    //         VarEmailSubject := 'Loan Demand Notice';
    //         VarEmailBody := 'Please find attached a demand notice for a ' + VarLoanProductName + 'Loan Account ' + "Loan In Default" + ' defaulted by ' + "Member Name";

    //         EnableSend := MicropointFactory.FnSendStatementViaMail(LeaderName, VarEmailSubject, VarEmailBody, VarMemberEmail, 'DemandNotice.pdf', '');

    //     end;
    // end;

    // local procedure FnRunSendCRBNoticeCopyDepartment(VarLoanDefaulted: Code[30]; VarMemberName: Code[100])
    // var
    //     Filename: Text[100];
    //     SMTPSetup: Record "SMTP Mail Setup";
    //     SMTPMail: Codeunit UnknownCodeunit400;
    //     VarMemberEmail: Text[50];
    //     ObjMember: Record "Members Register";
    //     Attachment: Text[250];
    //     ObjLoanType: Record "Loan Products Setup";
    //     VarProductDescription: Code[50];
    //     ObjDemandNotices: Record "Default Notices Register";
    //     LeaderName: Text[100];
    //     ObjLoanGuarantors: Record "Loans Guarantee Details";
    //     ObjGensetup: Record "Sacco General Set-Up";
    // begin
    //     SMTPSetup.Get();
    //     ObjGensetup.Get();

    //     ObjLoans.Reset;
    //     ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanDefaulted);
    //     if ObjLoans.FindSet then begin

    //         if ObjMember.Get(ObjLoanGuarantors."Member No") then begin
    //             VarMemberEmail := Lowercase(ObjGensetup."Credit Department E-mail");
    //             LeaderName := 'Credit Team';
    //         end;
    //         Filename := '';
    //         Filename := SMTPSetup."Path to Save Report" + 'CRBNotice.pdf';
    //         Report.SaveAsPdf(Report::"Loan CRB Notice", Filename, ObjLoans);

    //         if ObjLoanType.Get("Loan Product") then begin
    //             VarProductDescription := ObjLoanType."Product Description";
    //         end;


    //         VarEmailSubject := 'Loan CRB Notice';
    //         VarEmailBody := 'Please find attached a CRB notice for a ' + VarLoanProductName + 'Loan Account ' + "Loan In Default" + ' defaulted by ' + "Member Name";

    //         EnableSend := MicropointFactory.FnSendStatementViaMail(LeaderName, VarEmailSubject, VarEmailBody, VarMemberEmail, 'CRBNotice.pdf', '');

    //     end;
    // end;

    // local procedure FnRunSendAuctioneerNoticeCopyDepartment(VarDemandNoticeNo: Code[30]; VarMemberName: Code[100])
    // var
    //     Filename: Text[100];
    //     SMTPSetup: Record "SMTP Mail Setup";
    //     SMTPMail: Codeunit UnknownCodeunit400;
    //     VarMemberEmail: Text[50];
    //     ObjMember: Record "Members Register";
    //     Attachment: Text[250];
    //     ObjLoanType: Record "Loan Products Setup";
    //     VarProductDescription: Code[50];
    //     ObjDemandNotices: Record "Default Notices Register";
    //     LeaderName: Text[100];
    //     ObjLoanGuarantors: Record "Loans Guarantee Details";
    //     ObjGensetup: Record "Sacco General Set-Up";
    // begin
    //     SMTPSetup.Get();
    //     ObjGensetup.Get();

    //     ObjLoans.Reset;
    //     ObjLoans.SetRange(ObjLoans."Loan  No.", VarDemandNoticeNo);
    //     if ObjLoans.FindSet then begin
    //         ObjLoanGuarantors.Reset;
    //         ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Loan No", VarDemandNoticeNo);
    //         if ObjLoanGuarantors.FindSet then begin
    //             repeat
    //                 if ObjMember.Get(ObjLoanGuarantors."Member No") then begin
    //                     VarMemberEmail := Lowercase(ObjGensetup."Credit Department E-mail");
    //                     LeaderName := Lowercase(ObjMember.Name);
    //                 end;
    //                 Filename := '';
    //                 Filename := SMTPSetup."Path to Save Report" + 'AuctioneerNotice.pdf';
    //                 Report.SaveAsPdf(Report::"Loan Debt Collector Notice", Filename, ObjLoans);
    //                 if ObjLoanType.Get("Loan Product") then begin
    //                     VarProductDescription := ObjLoanType."Product Description";
    //                 end;

    //                 VarEmailSubject := 'Loan Auctioneer Notice';
    //                 VarEmailBody := 'Please find attached Auctioneer notice for a ' + VarLoanProductName + 'Loan Account ' + "Loan In Default" + ' defaulted by ' + "Member Name";

    //                 EnableSend := MicropointFactory.FnSendStatementViaMail(LeaderName, VarEmailSubject, VarEmailBody, VarMemberEmail, 'AuctioneerNotice.pdf', '');
    //             until ObjLoanGuarantors.Next = 0;
    //         end;
    //     end;
    // end;

    local procedure FnRunShowRelevantButton()
    begin
        VarDemandNoticeVisible := false;
        VarCRBNoticeVisible := false;
        VarDebtCollectorVisible := false;

        if (Rec."Notice Type" = rec."notice type"::"1st Demand Notice") or (Rec."Notice Type" = rec."notice type"::"2nd Demand Notice") then begin
            VarDemandNoticeVisible := true;
        end;

        if Rec."Notice Type" = rec."notice type"::"CRB Notice" then begin
            VarCRBNoticeVisible := true;
        end;

        if Rec."Notice Type" = rec."notice type"::"Debt Collector Notice" then begin
            VarDebtCollectorVisible := true;
        end;
    end;
}

