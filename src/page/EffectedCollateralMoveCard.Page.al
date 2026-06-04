#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50811 "Effected Collateral Move. Card"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Collateral Movement  Register";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Action Application date"; Rec."Action Application date")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral ID"; Rec."Collateral ID")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Description"; Rec."Collateral Description")
                {
                    ApplicationArea = Basic;
                }
                field("Registered Owner"; Rec."Registered Owner")
                {
                    ApplicationArea = Basic;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Type"; Rec."Collateral Type")
                {
                    ApplicationArea = Basic;
                }
                field("Date Received"; Rec."Date Received")
                {
                    ApplicationArea = Basic;
                }
                field("Received By"; Rec."Received By")
                {
                    ApplicationArea = Basic;
                }
                field("Reference No"; Rec."Reference No")
                {
                    ApplicationArea = Basic;
                }
                field("Asset Value"; Rec."Asset Value")
                {
                    ApplicationArea = Basic;
                }
                field("Asset Depreciation Amount"; Rec."Asset Depreciation Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Asset Value @Loan Completion"; Rec."Asset Value @Loan Completion")
                {
                    ApplicationArea = Basic;
                }
                field("Depreciation Completion Date"; Rec."Depreciation Completion Date")
                {
                    ApplicationArea = Basic;
                }
                field("Action Type"; Rec."Action Type")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CustodiansDetailsvisible := false;
                        LawyersDetailsvisible := false;
                        InsuranceDetailsvisible := false;
                        BranchDetailsvisible := false;

                        if ObjCollateralActions.Get(Rec."Action Type") then begin
                            if ObjCollateralActions."Action Scope" = ObjCollateralActions."action scope"::Lawyer then begin
                                LawyersDetailsvisible := true;
                            end;
                            if ObjCollateralActions."Action Scope" = ObjCollateralActions."action scope"::Insurance then begin
                                InsuranceDetailsvisible := true;
                            end;
                            if ObjCollateralActions."Action Scope" = ObjCollateralActions."action scope"::Branch then begin
                                BranchDetailsvisible := true;
                            end;
                            if ObjCollateralActions."No Of Users to Effect Action" = ObjCollateralActions."no of users to effect action"::Dual then begin
                                CustodiansDetailsvisible := true;
                            end;
                        end;
                    end;
                }
                field("Actioned By(Custodian 1)"; Rec."Actioned By(Custodian 1)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Actioned By';
                }
                field("Actioned On(Custodian 1)"; Rec."Actioned On(Custodian 1)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Actioned On';
                }
                group("Custodians Details")
                {
                    Caption = 'Custodian 2 Details';
                    Visible = CustodiansDetailsvisible;
                    field("Actioned By(Custodian 2)"; Rec."Actioned By(Custodian 2)")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Actioned By';
                    }
                    field("Actioned On(Custodian 2)"; Rec."Actioned On(Custodian 2)")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Actioned On';
                    }
                }
                group("Lawyer Details")
                {
                    Visible = LawyersDetailsvisible;
                    field("Lawyer Code"; Rec."Lawyer Code")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Lawyer Name"; Rec."Lawyer Name")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group("Insurance Details")
                {
                    Visible = InsuranceDetailsvisible;
                    field("Insurance Agent Code"; Rec."Insurance Agent Code")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Insurance Agent Name"; Rec."Insurance Agent Name")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group("Auctioneer Details")
                {
                    Visible = Auctioneervisible;
                    field("Auctioneer Code"; Rec."Auctioneer Code")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Auctioneer Name"; Rec."Auctioneer Name")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group("Branch Details")
                {
                    Visible = BranchDetailsvisible;
                    field("Action Branch"; Rec."Action Branch")
                    {
                        ApplicationArea = Basic;
                    }
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = Basic;
                }
                field("Last Collateral Action"; Rec."Last Collateral Action")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Action Effected"; Rec."Action Effected")
                {
                    ApplicationArea = Basic;
                }
                field("Action Effected On"; Rec."Action Effected On")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Effect Action")
            {
                ApplicationArea = Basic;
                Image = PostDocument;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.TestField("Action Type");
                    if Rec."Action Effected" = true then
                        Error('Application has already been effected');

                    if Confirm('Confirm Action ?', false) = true then begin
                        if Rec."No Of Users to Effect Action" = Rec."no of users to effect action"::Single then begin
                            FnRunControlFieldInfo;

                            Rec."Actioned By(Custodian 1)" := UserId;
                            Rec."Actioned On(Custodian 1)" := WorkDate;
                            Rec."Action Effected" := true;
                            Rec."Action Effected On" := WorkDate;
                        end;

                        if Rec."No Of Users to Effect Action" = Rec."no of users to effect action"::Dual then begin
                            FnRunControlFieldInfo;

                            ObjCustodians.Reset;
                            ObjCustodians.SetRange(ObjCustodians."Custodian Of", ObjCustodians."custodian of"::"Safe Custody");
                            ObjCustodians.SetRange(ObjCustodians."User ID", UserId);
                            if ObjCustodians.Find('-') = false then begin
                                Error('Not Authorized to Perform this Action');
                            end;

                            if Rec."Actioned By(Custodian 1)" = '' then begin
                                Rec."Actioned By(Custodian 1)" := UserId;
                                Rec."Actioned On(Custodian 1)" := WorkDate;
                            end else
                                if (Rec."Actioned By(Custodian 1)" <> '') and (Rec."Actioned By(Custodian 1)" <> UserId) then begin
                                    Rec."Actioned By(Custodian 2)" := UserId;
                                    Rec."Actioned On(Custodian 2)" := WorkDate;
                                end;

                            if (Rec."Actioned By(Custodian 1)" <> '') and (Rec."Actioned By(Custodian 2)" <> '') then begin
                                Rec."Action Effected" := true;
                                Rec."Action Effected On" := WorkDate;
                            end;
                        end;

                        if Rec."Action Type" = 'BOOKED TO SAFE CUSTODY' then begin
                            FnRunMoveCollateraltoSafeCustody;
                        end;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CustodiansDetailsvisible := false;
        LawyersDetailsvisible := false;
        InsuranceDetailsvisible := false;
        BranchDetailsvisible := false;
        Auctioneervisible := false;

        if ObjCollateralActions.Get(Rec."Action Type") then begin
            if ObjCollateralActions."Action Scope" = ObjCollateralActions."action scope"::Lawyer then begin
                LawyersDetailsvisible := true;
            end;
            if ObjCollateralActions."Action Scope" = ObjCollateralActions."action scope"::Insurance then begin
                InsuranceDetailsvisible := true;
            end;
            if ObjCollateralActions."Action Scope" = ObjCollateralActions."action scope"::Auctioneer then begin
                Auctioneervisible := true;
            end;
            if ObjCollateralActions."Action Scope" = ObjCollateralActions."action scope"::Branch then begin
                BranchDetailsvisible := true;
            end;
            if ObjCollateralActions."No Of Users to Effect Action" = ObjCollateralActions."no of users to effect action"::Dual then begin
                CustodiansDetailsvisible := true;
            end;
        end;
    end;

    var
        CustodiansDetailsvisible: Boolean;
        LawyersDetailsvisible: Boolean;
        InsuranceDetailsvisible: Boolean;
        BranchDetailsvisible: Boolean;
        Auctioneervisible: Boolean;
        ObjCollateralActions: Record "Collateral Movement Actions";
        ObjCustodians: Record "Safe Custody Custodians";
        ObjNoSeries: Record "Sacco No. Series";
        VarDocumentNo: Code[30];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjSafeCustody: Record "Safe Custody Package Register";
        ObjLoanCollateral: Record "Loan Collateral Details";
        ObjLoans: Record "Loans Register";
        VarChargeFOSAAccount: Code[30];
        VarChargeFOSAAccountName: Text[50];
        ObjCollateralMovement: Record "Collateral Movement  Register";

    local procedure FnRunControlFieldInfo()
    begin
        if ObjCollateralActions.Get(Rec."Action Type") then begin
            if ObjCollateralActions."Action Scope" = ObjCollateralActions."action scope"::Lawyer then begin
                Rec.TestField("Lawyer Code");
            end;
            if ObjCollateralActions."Action Scope" = ObjCollateralActions."action scope"::Insurance then begin
                Rec.TestField("Insurance Agent Code");
            end;
            if ObjCollateralActions."Action Scope" = ObjCollateralActions."action scope"::Auctioneer then begin
                Rec.TestField("Auctioneer Code");
            end;
            if ObjCollateralActions."Action Scope" = ObjCollateralActions."action scope"::Branch then begin
                Rec.TestField("Action Branch");
            end;

        end;
    end;

    local procedure FnRunMoveCollateraltoSafeCustody()
    begin
        if ObjNoSeries.Get then begin
            ObjNoSeries.TestField(ObjNoSeries."Safe Custody Package Nos");
            VarDocumentNo := NoSeriesMgt.GetNextNo(ObjNoSeries."Safe Custody Package Nos", 0D, true);
            if VarDocumentNo <> '' then begin

                ObjLoanCollateral.CalcFields(ObjLoanCollateral."Loan Issued Date", ObjLoanCollateral."Outstanding Balance");
                ObjLoanCollateral.Reset;
                ObjLoanCollateral.SetCurrentkey(ObjLoanCollateral."Loan Issued Date");
                ObjLoanCollateral.SetRange(ObjLoanCollateral."Collateral Registe Doc", Rec."Collateral ID");
                ObjLoanCollateral.SetFilter(ObjLoanCollateral."Outstanding Balance", '=%1', 0);
                if ObjLoanCollateral.FindLast then begin

                    ObjLoans.Reset;
                    ObjLoans.SetRange(ObjLoans."Loan  No.", ObjLoanCollateral."Loan No");
                    if ObjLoans.FindSet then begin
                        VarChargeFOSAAccount := ObjLoans."Account No";
                        VarChargeFOSAAccountName := ObjLoans."Client Name";
                    end;

                end;

                ObjSafeCustody.Init;
                ObjSafeCustody."Package ID" := VarDocumentNo;
                ObjSafeCustody."Package Type" := 'Envelope';
                ObjSafeCustody."Package Description" := Rec."Collateral Description";
                Evaluate(ObjSafeCustody."Custody Period", '1Y');
                ObjSafeCustody."Maturity Date" := WorkDate;
                ObjSafeCustody."Member No" := Rec."Member No.";
                ObjSafeCustody."Date Received" := WorkDate;
                ObjSafeCustody."Time Received" := Time;
                ObjSafeCustody."Received By" := UserId;
                ObjSafeCustody."Lodged By(Custodian 1)" := Rec."Actioned By(Custodian 1)";
                ObjSafeCustody."Lodged By(Custodian 2)" := Rec."Actioned By(Custodian 2)";
                ObjSafeCustody."Date Lodged" := Rec."Action Effected On";
                ObjSafeCustody."Member Name" := Rec."Member Name";
                ObjSafeCustody."Maturity Instruction" := ObjSafeCustody."maturity instruction"::Rebook;
                ObjSafeCustody.Status := ObjSafeCustody.Status::Approved;
                ObjSafeCustody."Package Status" := ObjSafeCustody."package status"::Lodged;
                ObjSafeCustody."Charge Account" := VarChargeFOSAAccount;
                ObjSafeCustody."Charge Account Name" := VarChargeFOSAAccountName;
                ObjSafeCustody.Insert;
            end;


        end;
    end;
}

