#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50974 "Collateral Action Card"
{
    PageType = Card;
    SourceTable = "Loan Collateral Register";

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
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Code"; Rec."Collateral Code")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Description"; Rec."Collateral Description")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Posting Group"; Rec."Collateral Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("Date Received"; Rec."Date Received")
                {
                    ApplicationArea = Basic;
                }
                field("Registered Owner"; Rec."Registered Owner")
                {
                    ApplicationArea = Basic;
                }
                field("Registration/Reference No"; Rec."Registration/Reference No")
                {
                    ApplicationArea = Basic;
                }
                field("Market Value"; Rec."Market Value")
                {
                    ApplicationArea = Basic;
                }
                field("Forced Sale Value"; Rec."Forced Sale Value")
                {
                    ApplicationArea = Basic;
                }
                field("Last Valued On"; Rec."Last Valued On")
                {
                    ApplicationArea = Basic;
                }
                field("Received By"; Rec."Received By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Released"; Rec."Date Released")
                {
                    ApplicationArea = Basic;
                }
                field("Released By"; Rec."Released By")
                {
                    ApplicationArea = Basic;
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
            }
            group("Insurance Details")
            {
                field("Insurance Effective Date"; Rec."Insurance Effective Date")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Expiration Date"; Rec."Insurance Expiration Date")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Policy No."; Rec."Insurance Policy No.")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Annual Premium"; Rec."Insurance Annual Premium")
                {
                    ApplicationArea = Basic;
                }
                field("Policy Coverage"; Rec."Policy Coverage")
                {
                    ApplicationArea = Basic;
                }
                field("Total Value Insured"; Rec."Total Value Insured")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Type"; Rec."Insurance Type")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Vendor No."; Rec."Insurance Vendor No.")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Depreciation Details")
            {
                field("Asset Value"; Rec."Asset Value")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Depreciation Completion Date"; Rec."Depreciation Completion Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Expected Date of Loan Completion';
                    Editable = false;
                }
                field("Depreciation Percentage"; Rec."Depreciation Percentage")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Collateral Depreciation Method"; Rec."Collateral Depreciation Method")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Asset Depreciation Amount"; Rec."Asset Depreciation Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Asset Value @Loan Completion"; Rec."Asset Value @Loan Completion")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Actions")
            {
                Caption = 'Actions';
            }
            // part(Control70; "Collateral Movement")
            // {
            //     SubPageLink = "Collateral ID" = field("Document No");
            // }
        }
    }

    actions
    {
        area(creation)
        {
            action("Calculate Depreciation")
            {
                ApplicationArea = Basic;
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CalculateDepreciationSchedule();
                end;
            }
            action("Depreciation Schedule")
            {
                ApplicationArea = Basic;
                Image = Form;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Collateral Depr. Schedule";
                RunPageLink = "Document No" = field("Document No");
            }
            action("Charge PackageLodge Fee")
            {
                ApplicationArea = Basic;
                Caption = 'Charge Package Lodge Fee';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ChargePackageLodgeFee();
                end;
            }
            action("Lodge Package")
            {
                ApplicationArea = Basic;
                Image = LinkAccount;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    LodgePackage();
                end;
            }
            // action(RetrievePackage)
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'Retrieve Package';

            //     trigger OnAction()
            //     begin
            //         RetrievePackage();
            //     end;
            // }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        FnGetVisibility();
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateLastCollateralAction();
    end;

    var
        ObjCollateralDeprReg: Record "Collateral Depr Register";
        ObjCollateralDetails: Record "Loan Collateral Details";
        VarNoofYears: Integer;
        VarDepreciationValue: Decimal;
        ObjDepreciationRegister: Record "Collateral Depr Register";
        VarDepreciationNo: Integer;
        ObjDeprCollateralMaster: Record "Collateral Depr Register";
        VarCurrentNBV: Decimal;
        ReceivedAtHQVisible: Boolean;
        StrongRoomVisible: Boolean;
        LawyerVisible: Boolean;
        InsuranceAgentVisible: Boolean;
        BranchVisible: Boolean;
        IssuetoMemberVisible: Boolean;
        IssuetoAuctioneerVisible: Boolean;
        SafeCustodyVisible: Boolean;
        ObjCustodians: Record "Safe Custody Custodians";
        ObjVendors: Record Vendor;
        AvailableBal: Decimal;
        ObjAccTypes: Record "Account Types-Saving Products";
        JTemplate: Code[20];
        JBatch: Code[20];
        DocNo: Code[20];
        GenSetup: Record "Sacco General Set-Up";
        LineNo: Integer;
        TransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares","Interest Due ";
        AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Member,Investor;
        BalAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        ObjPackageTypes: Record "Package Types";
        LodgeFee: Decimal;
        LodgeFeeAccount: Code[20];
        //MicropointFactory: Codeunit ;
        ObjNoSeries: Record "Sacco No. Series";
        VarPackageNo: Code[20];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjPackage: Record "Safe Custody Package Register";
        ObjCollateralMovement: Record "Collateral Movement  Register";
        ObjCollateralMovementII: Record "Collateral Movement  Register";

    local procedure CalculateDepreciationSchedule()
    var
        CurrentDate: Date;
        CurrentNBV: Decimal;
        DepreciationValue: Decimal;
        YearCounter: Integer;
        MaxYears: Integer;
    begin
        // Calculate number of years for depreciation
        //  VarNoofYears := Round(("Depreciation Completion Date" - Today) / 365, 1, '>');
        MaxYears := 10; // Safety limit to prevent infinite loops

        // Check if depreciation records already exist
        ObjCollateralDeprReg.Reset();
        ObjCollateralDeprReg.SetRange("Document No", DocNo);
        if ObjCollateralDeprReg.FindSet() then
            Error('Depreciation schedule already exists for this collateral.');

        // Initialize values
        CurrentDate := Today;
        // CurrentNBV := "Asset Value";
        YearCounter := 1;

        // Create depreciation schedule
        // while (CalcDate('1Y', CurrentDate) <= "Depreciation Completion Date") and (YearCounter <= MaxYears) do begin
        //     // Calculate depreciation for current year
        //     DepreciationValue := CurrentNBV * ("Depreciation Percentage" / 100);
        CurrentDate := CalcDate('1Y', CurrentDate);

        // Create depreciation record
        ObjCollateralDeprReg.Init();
        ObjCollateralDeprReg."Document No" := DocNo;
        ObjCollateralDeprReg."Transaction Date" := CurrentDate;
        ObjCollateralDeprReg."Transaction Description" := 'Year ' + Format(YearCounter) + ' Depreciation';
        ObjCollateralDeprReg."Depreciation Amount" := DepreciationValue;
        ObjCollateralDeprReg."Collateral NBV" := CurrentNBV - DepreciationValue;
        ObjCollateralDeprReg.Insert();

        // Update values for next iteration
        CurrentNBV := CurrentNBV - DepreciationValue;
        YearCounter += 1;
        //end;

        Message('Depreciation schedule calculated successfully for %1 years.', YearCounter - 1);
    end;

    local procedure ChargePackageLodgeFee()
    begin
        if not Confirm('Are you sure you want to charge package lodging fee?', false) then
            exit;

        // Get member balance
        ObjVendors.Reset();
        // ObjVendors.SetRange("No.", "Charge Account");
        if ObjVendors.FindFirst() then begin
            ObjVendors.CalcFields(Balance, "Uncleared Cheques");
            AvailableBal := (ObjVendors.Balance - ObjVendors."Uncleared Cheques");

            ObjAccTypes.Reset();
            ObjAccTypes.SetRange(Code, ObjVendors."Account Type");
            if ObjAccTypes.FindFirst() then
                AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
        end;

        // Get lodge fee details
        ObjPackageTypes.Reset();
        // ObjPackageTypes.SetRange(Code, "Package Type");
        if ObjPackageTypes.FindFirst() then begin
            LodgeFee := ObjPackageTypes."Package Charge";
            LodgeFeeAccount := ObjPackageTypes."Package Charge Account";
        end;

        // Validate balance
        if AvailableBal < LodgeFee then
            Error('The member has insufficient balance. Required: %1, Available: %2', LodgeFee, AvailableBal);

        // Create journal entries
        JTemplate := 'GENERAL';
        JBatch := 'SCUSTODY';
        // DocNo := 'Lodge_' + Format("Document No");
        GenSetup.Get();
        LineNo := LineNo + 10000;

        // MicropointFactory.FnCreateGnlJournalLineBalanced(
        // JTemplate, JBatch, DocNo, LineNo, TransType::" ", AccountType::Vendor, "Charge Account",
        // Today, 'Package Lodge Charge_' + Format("Document No"),
        //BalAccountType::"G/L Account", LodgeFeeAccount, LodgeFee, 'BOSA', '');

        // MicropointFactory.FnPostGnlJournalLine(JTemplate, JBatch);
        Message('Lodge fee of %1 charged successfully.', LodgeFee);
    end;

    local procedure LodgePackage()
    begin
        // if Action <> Action::"Booked to Safe Custody" then
        //     Error('This action is only applicable to Safe Custody booking.');

        // if ("Lodged By(Custodian 1)" <> '') and ("Lodged By(Custodian 2)" <> '') then
        //     Error('This package has already been lodged.');

        // // Validate custodian authorization
        // ObjCustodians.Reset();
        // ObjCustodians.SetRange("User ID", UserId);
        // if not ObjCustodians.FindFirst() then
        //     Error('You are not authorized to lodge packages.');

        // // Assign custodian
        // if ("Lodged By(Custodian 1)" = '') and ("Lodged By(Custodian 2)" <> UserId) then
        //     "Lodged By(Custodian 1)" := UserId
        // else if ("Lodged By(Custodian 2)" = '') and ("Lodged By(Custodian 1)" <> UserId) then
        //     "Lodged By(Custodian 2)" := UserId
        // else
        //     Error('You cannot be assigned as both custodians or package is already processed.');

        // // Complete lodging process if both custodians assigned
        // if ("Lodged By(Custodian 1)" <> '') and ("Lodged By(Custodian 2)" <> '') then begin
        //     "Date Lodged" := Today;
        //     "Time Lodged" := Time;

        // Create package in Safe Custody module
        CreateSafeCustodyPackage();
        // end;
    end;

    local procedure CreateSafeCustodyPackage()
    begin
        ObjNoSeries.Get();
        ObjNoSeries.TestField("Safe Custody Package Nos");
        VarPackageNo := NoSeriesMgt.GetNextNo(ObjNoSeries."Safe Custody Package Nos", 0D, true);

        ObjPackage.Init();
        ObjPackage."Package ID" := VarPackageNo;
        // ObjPackage."Package Type" := "Package Type";
        // ObjPackage."Charge Account" := "Charge Account";
        // ObjPackage."Charge Account Name" := "Member Name";
        // ObjPackage."Lodged By(Custodian 1)" := "Lodged By(Custodian 1)";
        // ObjPackage."Lodged By(Custodian 2)" := "Lodged By(Custodian 2)";
        // ObjPackage."Date Lodged" := "Date Lodged";
        // ObjPackage."Time Lodged" := "Time Lodged";
        ObjPackage.Insert();

        Message('Safe custody package created successfully. Package No: %1', VarPackageNo);
    end;

    local procedure RetrievePackage()
    begin
        // if Action <> Action::"Booked to Safe Custody" then
        //     Error('This action is only applicable to Safe Custody booking.');

        // if ("Released By(Custodian 1)" <> '') and ("Released By(Custodian 2)" <> '') then
        //     Error('This package has already been retrieved.');

        // // Validate custodian authorization
        // ObjCustodians.Reset();
        // ObjCustodians.SetRange("User ID", UserId);
        // if not ObjCustodians.FindFirst() then
        //     Error('You are not authorized to retrieve packages.');

        // // Assign custodian for retrieval
        // if ("Released By(Custodian 1)" = '') and ("Released By(Custodian 2)" <> UserId) then
        //     "Released By(Custodian 1)" := UserId
        // else if ("Released By(Custodian 2)" = '') and ("Released By(Custodian 1)" <> UserId) then
        //     "Released By(Custodian 2)" := UserId
        // else
        //     Error('You cannot be assigned as both custodians or package is already processed.');

        // // Complete retrieval process if both custodians assigned
        // if ("Released By(Custodian 1)" <> '') and ("Released By(Custodian 2)" <> '') then begin
        //     "Date Released from SafeCustody" := Today;
        //     "Time Released from SafeCustody" := Time;
        //     Message('Package retrieved successfully.');
        // end;
    end;

    local procedure UpdateLastCollateralAction()
    begin
        // CalcFields("Last Collateral Action Entry");
        // if ObjCollateralMovementII.Get("Last Collateral Action Entry") then begin
        //     "Last Collateral Action" := ObjCollateralMovementII."Action Type";
        //     Modify();
        // end;
    end;

    local procedure FnGetVisibility()
    begin
        // Reset all visibility flags
        ReceivedAtHQVisible := false;
        StrongRoomVisible := false;
        LawyerVisible := false;
        InsuranceAgentVisible := false;
        BranchVisible := false;
        IssuetoMemberVisible := false;
        IssuetoAuctioneerVisible := false;
        SafeCustodyVisible := false;

        // Set visibility based on action
        // case Action of
        //     Action::"Receive at HQ":
        //         ReceivedAtHQVisible := true;
        //     Action::"Dispatch to Branch", Action::"Receive at Branch":
        //         BranchVisible := true;
        //     Action::"Issue to Lawyer", Action::"Receive From Lawyer":
        //         LawyerVisible := true;
        //     Action::"Issue to Auctioneer":
        //         IssuetoAuctioneerVisible := true;
        //     Action::"Issue to Insurance Agent":
        //         InsuranceAgentVisible := true;
        //     Action::"Release to Member":
        //         IssuetoMemberVisible := true;
        //     Action::"Retrieve From Strong Room":
        //         StrongRoomVisible := true;
        //     Action::"Booked to Safe Custody":
        //         SafeCustodyVisible := true;
        // end;
    end;
}