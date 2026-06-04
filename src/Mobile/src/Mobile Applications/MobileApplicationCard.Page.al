page 50456 "Mobile Application Card"
{
    PageType = Card;
    SourceTable = "CFTMobile Applications";
    ApplicationArea = All;
    DeleteAllowed = false;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Basic Information';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Current Account No"; Rec."Current Account No")
                {
                    ApplicationArea = All;
                    Editable = AccountNoEditable;

                }
                field("Current Account Status"; Rec."Current Account Status")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Telephone"; Rec."Telephone")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Date Applied"; Rec."Date Applied")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Additional;
                }
                field("Time Applied"; Rec."Time Applied")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Additional;

                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Additional;
                }
                field("SentToServer"; Rec."SentToServer")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Additional;
                }
                field("Mobile Status"; Rec."Mobile Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                }


                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Deactivate")
            {
                ApplicationArea = All;
                Image = Cancel;
                Enabled = (Rec."Mobile Status" = Rec."Mobile Status"::Active) and (Rec."Approval Status" = Rec."Approval Status"::Approved);
                trigger OnAction()
                begin
                    If Confirm('Do you need to deactivate this account') then begin
                        Rec."Mobile Status" := Rec."Mobile Status"::Inactive;
                        Rec.Telephone := '';
                        Rec.MODIFY(true);
                        MESSAGE('Record Successfully Deactivated');
                    end;
                end;
            }

            action("Activate Account")
            {
                ApplicationArea = All;
                Image = Edit;
                Enabled = ((Rec."Mobile Status" = Rec."Mobile Status"::Inactive)) and (Rec."Approval Status" = Rec."Approval Status"::Approved);
                trigger OnAction()
                begin
                    if confirm('Do you need to activate this account ?') then begin
                        Customer.RESET();
                        Customer.SETRANGE("No.", Rec."Current Account No");
                        Customer.SETRANGE(Status, Customer.Status::Active);
                        if Customer.FINDLAST() then begin
                            Customer.TestField("Phone No.");
                            Rec.Telephone := Customer."Phone No.";
                            Rec."Mobile Status" := Rec."Mobile Status"::Active;
                            Rec.MODIFY(true);
                        end;
                        MESSAGE('Record Successfully Activated');

                    end;
                end;


            }

            action(UpdateTelephone)
            {
                ApplicationArea = All;
                Caption = 'Update Telephone', comment = 'NLB="YourLanguageCaption"';
                Image = Refresh;

                trigger OnAction()
                begin
                    Customer.SetRange("No.", Rec."Current Account No");
                    Customer.SetFilter("Status", '%1', Customer.Status::Active);
                    if Customer.FindFirst() then begin
                        if Customer."Mobile Phone No" = '' then begin
                            Error('The selected customer does not have a mobile number. Go please add');
                        end;
                        Rec."Telephone" := '254' + CopyStr(Customer."Phone No.", StrLen(Customer."Phone No.") - 8, 9);
                        Rec.Modify();
                        Message('Telephone Updated Successfully.');
                    end;
                end;
            }

            action("Approve")
            {
                ApplicationArea = All;
                Image = Edit;
                Enabled = (Rec."Mobile Status" = Rec."Approval Status"::Open);
                trigger OnAction()
                begin
                    if confirm('Do you need to approve this account ?') then begin
                        Customer.RESET();
                        Customer.SETRANGE("No.", Rec."Current Account No");
                        Customer.SETRANGE(Status, Customer.Status::Active);
                        if Customer.FINDLAST() then begin
                            Rec."Approval Status" := Rec."Approval Status"::Approved;
                            Rec.MODIFY(true);
                        end;
                        MESSAGE('Record Successfully Activated');

                    end;
                end;


            }
        }
        area(Promoted)
        {
            group("Account Actions")
            {
                actionref("Deactivate Account"; Deactivate)
                {

                }
                actionref("Activate__Account"; "Activate Account")
                {

                }
            }
        }
    }


    trigger OnOpenPage()
    begin

        FnAddRecordRestriction();

        if Rec."No. Series" = '' then
            Rec."No. Series" := 'CPO';
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        AccountNoEditable := true;
        if Rec."No. Series" = '' then
            Rec."No. Series" := 'CPO';
    end;

    trigger OnAfterGetRecord()

    begin

        FnAddRecordRestriction();

    end;

    var
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        EditableData: Boolean;

        RECORDID: RecordId;
        AccountNoEditable: Boolean;

        RecRef: RecordRef;
        Customer: Record Customer;


    local procedure FnAddRecordRestriction()

    begin
        IF Rec."Approval Status" = Rec."Approval Status"::Open THEN BEGIN
            AccountNoEditable := TRUE;
        END ELSE
            IF Rec."Approval Status" = Rec."Approval Status"::"Pending Approval" THEN BEGIN
                AccountNoEditable := FALSE;
            END ELSE
                IF Rec."Approval Status" = Rec."Approval Status"::Approved THEN BEGIN
                    AccountNoEditable := FALSE;
                END;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        FnAddRecordRestriction();

    end;



}

