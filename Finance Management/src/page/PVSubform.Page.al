page 51036 "PV Subform"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'PV Subform';
    PageType = ListPart;
    SourceTable = "Payment Lines";
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Expenditure Type"; Rec."Expenditure Type")
                {
                    Caption = 'Payment Type';
                    Editable = not CanEdit and not IsStatusPending;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Payment Type field';

                    trigger OnValidate()
                    begin
                        SetPageView();
                        CurrPage.Update();
                    end;
                }
                field("Account Type"; Rec."Account Type")
                {
                    Caption = 'Account Type';
                    Editable = not CanEdit and not IsStatusPending;
                    ToolTip = 'Specifies the value of the Account Type field';
                }
                field("Imprest No."; Rec."Imprest No.")
                {
                    Caption = 'Imprest Number';
                    Editable = not CanEdit and not IsStatusPending;
                    ToolTip = 'Specifies the value of the Imprest Number field';
                    Visible = ImprestVisible;
                }
                field("Claim No."; Rec."Claim No.")
                {
                    Caption = 'Claim No.';
                    Editable = not CanEdit and not IsStatusPending;
                    ToolTip = 'Specifies the value of the Claim No. field';
                    Visible = ClaimVisible;
                }
                field("Account No"; Rec."Account No")
                {
                    Caption = 'Account No';
                    Editable = not CanEdit and not IsStatusPending;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Account No field';
                }
                field("Gen. Posting Type"; Rec."Gen. Posting Type")
                {
                    Caption = 'Gen. Posting Type';
                    ToolTip = 'Specifies the value of the Gen. Posting Type field';
                }
                field("Account Name"; Rec."Account Name")
                {
                    Caption = 'Account Name';
                    Editable = not CanEdit and not IsStatusPending;
                    ToolTip = 'Specifies the value of the Account Name field';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    Editable = not CanEdit and not IsStatusPending;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(Currency; Rec.Currency)
                {
                    Caption = 'Currency';
                    Editable = not CanEdit and not IsStatusPending;
                    ToolTip = 'Specifies the value of the Currency field';
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                    Editable = not CanEdit and not IsStatusPending;
                    ToolTip = 'Specifies the value of the Amount field';
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    Caption = 'Amount (LCY)';
                    ToolTip = 'Specifies the value of the Amount (LCY) field';
                }
                field("VAT Exclusive"; Rec."VAT Exclusive")
                {
                    Caption = 'VAT Exclusive';
                    Editable = not CanEdit and not IsStatusPending;
                    ToolTip = 'Specifies the value of the VAT Exclusive field';
                    Visible = false;
                }
                field("VAT Code"; Rec."VAT Code")
                {
                    Caption = 'VAT Code';
                    Editable = not CanEdit and not IsStatusPending;
                    ToolTip = 'Specifies the value of the VAT Code field';
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("W/Tax Code"; Rec."W/Tax Code")
                {
                    Caption = 'W/Tax Code';
                    Editable = not CanEdit and not IsStatusPending;
                    ToolTip = 'Specifies the value of the W/Tax Code field';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("W/T VAT Code"; Rec."W/T VAT Code")
                {
                    Caption = 'W/T VAT Code';
                    Editable = not CanEdit and not IsStatusPending;
                    ToolTip = 'Specifies the value of the W/T VAT Code field';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Retention Code"; Rec."Retention Code")
                {
                    Caption = 'Retention Code';
                    Editable = not CanEdit and not IsStatusPending;
                    ToolTip = 'Specifies the value of the Retention Code field';
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    Caption = 'VAT Amount';
                    Editable = not CanEdit and not IsStatusPending;
                    ToolTip = 'Specifies the value of the VAT Amount field';
                }
                field("W/Tax Amount"; Rec."W/Tax Amount")
                {
                    Caption = 'W/Tax Amount';
                    Editable = not CanEdit and not IsStatusPending;
                    ToolTip = 'Specifies the value of the W/Tax Amount field';
                }
                field("W/T VAT Amount"; Rec."W/T VAT Amount")
                {
                    Caption = 'W/T VAT Amount';
                    ToolTip = 'Specifies the value of the W/T VAT Amount field';
                    Visible = false;
                }
                field("Retention Amount"; Rec."Retention Amount")
                {
                    Caption = 'Retention Amount';
                    Editable = not CanEdit and not IsStatusPending;
                    ToolTip = 'Specifies the value of the Retention Amount field';
                }
                field("Vatable Amount"; Rec."Vatable Amount")
                {
                    Caption = 'Vatable Amount';
                    Editable = not CanEdit and not IsStatusPending;
                    ToolTip = 'Specifies the value of the Vatable Amount field';
                    Visible = LevyVisible;
                }
                field("Other Charges"; Rec."Other Charges")
                {
                    Caption = 'Other Charges';
                    Editable = not CanEdit and not IsStatusPending;
                    ToolTip = 'Specifies the value of the Other Charges field';
                    Visible = LevyVisible;
                }
                field("10% Not Wtheld"; Rec."10% Not Wtheld")
                {
                    Caption = '10% Not Wtheld';
                    Editable = not CanEdit and not IsStatusPending;
                    ToolTip = 'Specifies the value of the 10% Not Wtheld field';
                    Visible = LevyVisible;
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    Caption = 'Net Amount';
                    Editable = not CanEdit and not IsStatusPending;
                    ToolTip = 'Specifies the value of the Net Amount field';
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    Caption = 'Applies-to ID';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Applies-to ID field';
                    Visible = false;
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc Type")
                {
                    Caption = 'Applies-to Doc. Type';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Applies-to Doc. Type field';
                    Visible = false;
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    Caption = 'Applies-to Doc. No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Applies-to Doc. No. field';
                    Visible = false;
                }
                field(Purpose; Rec.Purpose)
                {
                    Caption = 'Purpose';
                    Editable = not CanEdit and not IsStatusPending;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Purpose field';
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code';
                    Editable = not CanEdit and not IsStatusPending;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                    Visible = DimVisible1;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code';
                    Editable = not CanEdit and not IsStatusPending;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field';
                    Visible = DimVisible2;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    Caption = 'ShortcutDimCode[3]';
                    CaptionClass = '1,2,3';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                    ToolTip = 'Specifies the value of the ShortcutDimCode[3] field';
                    Visible = DimVisible3;
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    Caption = 'ShortcutDimCode[4]';
                    CaptionClass = '1,2,4';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                    ToolTip = 'Specifies the value of the ShortcutDimCode[4] field';
                    Visible = DimVisible4;
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    Caption = 'ShortcutDimCode[5]';
                    CaptionClass = '1,2,5';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                    ToolTip = 'Specifies the value of the ShortcutDimCode[5] field';
                    Visible = DimVisible5;
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    Caption = 'ShortcutDimCode[6]';
                    CaptionClass = '1,2,6';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                    ToolTip = 'Specifies the value of the ShortcutDimCode[6] field';
                    Visible = DimVisible6;
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    Caption = 'ShortcutDimCode[7]';
                    CaptionClass = '1,2,7';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                    ToolTip = 'Specifies the value of the ShortcutDimCode[7] field';
                    Visible = DimVisible7;
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    Caption = 'ShortcutDimCode[8]';
                    CaptionClass = '1,2,8';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                    ToolTip = 'Specifies the value of the ShortcutDimCode[8] field';
                    Visible = DimVisible8;
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID';
                    ToolTip = 'Specifies the value of the Dimension Set ID field';
                }
                field("Levied Invoice H"; Rec."Levied Invoice H")
                {
                    Caption = 'Levied Invoice H';
                    ToolTip = 'Specifies the value of the Levied Invoice H field';
                    Visible = false;
                    trigger OnValidate()
                    begin
                        if Rec."Levied Invoice H" = true then
                            LevyVisible := true
                        else
                            LevyVisible := false;
                    end;
                }
                field(AppliedDoc; AppliedDoc)
                {
                    Caption = 'Applied Doc No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Applied Doc No. field';
                    Visible = false;
                }
                field("Sort Code"; Rec."Sort Code")
                {
                    Caption = 'Sort Code';
                    Editable = not CanEdit and not IsStatusPending;
                    ToolTip = 'Specifies the value of the Sort Code field';
                    Visible = false;
                }
                field("Our Account No."; Rec."Our Account No.")
                {
                    Caption = 'Our Account No.';
                    Editable = not CanEdit and not IsStatusPending;
                    ToolTip = 'Specifies the value of the Our Account No. field';
                    Visible = false;
                }
                field("Imprest Payment"; Rec."Imprest Payment")
                {
                    Caption = 'Imprest Payment';
                    ToolTip = 'Specifies the value of the Imprest Payment field';
                    trigger OnValidate()
                    begin
                        SetPageView();
                    end;
                }
                field("Claim Payment"; Rec."Claim Payment")
                {
                    Caption = 'Claim Payment';
                    ToolTip = 'Specifies the value of the Claim Payment field';
                    Visible = false;
                    trigger OnValidate()
                    begin
                        SetPageView();
                    end;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Dimensions)
            {
                Caption = 'Dimensions';
                Enabled = false;
                Image = Dimensions;
                ToolTip = 'Executes the Dimensions action';
                trigger OnAction()
                begin
                    Rec.ShowDimensions();
                    CurrPage.SaveRecord();
                end;
            }
            action("Apply Entries")
            {
                Caption = 'Apply Entries';
                Ellipsis = true;
                Image = ApplyEntries;
                ShortcutKey = 'Shift+F11';
                ToolTip = 'Select one or more ledger entries that you want to apply this record to so that the related posted documents are closed as paid or refunded.';
                Visible = not DocPosted;

                trigger OnAction()
                begin
                    PaymentMgt.ApplyEntry(Rec);
                end;
            }
            action("View Applied Entries")
            {
                Caption = 'View Applied Entries';
                Image = Approve;
                ToolTip = 'Executes the View Applied Entries action';
                Visible = DocPosted;
                trigger OnAction()
                begin
                    PaymentMgt.ViewAppliedEntries(Rec);
                end;
            }
        }
    }

    var
        Payments: Record Payments;
        DimMgt: Codeunit DimensionManagement;
        PaymentMgt: Codeunit "Payments Management";
        CanEdit: Boolean;
        ClaimVisible: Boolean;
        DimVisible1: Boolean;
        DimVisible2: Boolean;
        DimVisible3: Boolean;
        DimVisible4: Boolean;
        DimVisible5: Boolean;
        DimVisible6: Boolean;
        DimVisible7: Boolean;
        DimVisible8: Boolean;
        DocPosted: Boolean;
        DocReleased: Boolean;
        ImprestVisible: Boolean;
        IsStatusPending: Boolean;
        LevyVisible: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        AppliedDoc: Code[50];


    trigger OnInit()
    begin
        ClaimVisible := false;
        ImprestVisible := false;
    end;

    trigger OnOpenPage()
    begin
        if Rec."Levied Invoice H" = true then
            LevyVisible := true
        else
            LevyVisible := false;

        AppliedDoc := Rec.GetAppliedDoc();
        SetPageView();
        SetDimensionVisibility();
    end;

    trigger OnAfterGetRecord()
    begin
        if Rec."Levied Invoice H" = true then
            LevyVisible := true
        else
            LevyVisible := false;

        AppliedDoc := Rec.GetAppliedDoc();
        SetPageView();
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.InsertPaymentTypes();
    end;

    local procedure SetPageView()
    var
        DocStatus: Option Open,Released,"Pending Approval","Pending Prepayment",Canceled,Disapproved,Committed,Fulfilled;
    begin
        if Rec."Claim Payment" then
            ClaimVisible := true;

        if Rec."Imprest Payment" then
            ImprestVisible := true;

        if Payments.Get(Rec.No) then begin
            if Payments.Status = Payments.Status::Released then
                DocReleased := true
            else
                DocReleased := false;

            if Payments.Posted then
                DocPosted := true
            else
                DocPosted := false;
        end;

        if Payments.Get(Rec.No) then begin
            DocStatus := Payments.Status;
            case Payments.Status of
                Payments.Status::Released:
                    begin
                        CanEdit := true;
                        IsStatusPending := false;
                    end;
                Payments.Status::"Pending Approval":
                    begin
                        CanEdit := false;
                        IsStatusPending := true;
                    end
                else
                    CanEdit := false;
                    IsStatusPending := false;
            end;
        end;
    end;

    local procedure SetDimensionVisibility()
    begin
        DimVisible1 := false;
        DimVisible2 := false;
        DimVisible3 := false;
        DimVisible4 := false;
        DimVisible5 := false;
        DimVisible6 := false;
        DimVisible7 := false;
        DimVisible8 := false;

        DimMgt.UseShortcutDims(
          DimVisible1, DimVisible2, DimVisible3, DimVisible4, DimVisible5, DimVisible6, DimVisible7, DimVisible8);

        Clear(DimMgt);
    end;
}
