page 51032 "Receipt Lines"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Receipt Lines';
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
                    Caption = 'Receipt Type';
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Receipt Type field';
                }
                field("Account Type"; Rec."Account Type")
                {
                    Caption = 'Account Type';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Account Type field';
                }
                field("Account No"; Rec."Account No")
                {
                    Caption = 'Account No';
                    ToolTip = 'Specifies the value of the Account No field';
                }
                field("Account Name"; Rec."Account Name")
                {
                    Caption = 'Account Name';
                    ToolTip = 'Specifies the value of the Account Name field';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(Currency; Rec.Currency)
                {
                    Caption = 'Currency';
                    ToolTip = 'Specifies the value of the Currency field';
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
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
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code';
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                    Visible = DimVisible1;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code';
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
                field("Gen. Posting Type"; Rec."Gen. Posting Type")
                {
                    Caption = 'Gen. Posting Type';
                    ToolTip = 'Specifies the value of the Gen. Posting Type field';
                    Visible = not DocReleased;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
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
        PaymentMgt: Codeunit "Payments Management";
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
        ShortcutDimCode: array[8] of Code[20];

    trigger OnInit()
    begin
        DocReleased := false;
    end;

    trigger OnOpenPage()
    begin
        SetPageView();
        SetDimensionVisibility();
    end;

    trigger OnAfterGetRecord()
    begin
        SetPageView();
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.InsertPaymentTypes();
    end;

    local procedure SetPageView()
    begin
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
    end;

    local procedure SetDimensionVisibility()
    var
        DimMgt: Codeunit DimensionManagement;
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
