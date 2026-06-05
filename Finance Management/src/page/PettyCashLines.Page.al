page 51019 "Petty Cash Lines"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Petty Cash Lines';
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
                    Caption = 'Petty Cash Type';
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Petty Cash Type field';
                }
                field("Account Type"; Rec."Account Type")
                {
                    Caption = 'Account Type';
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
                    Editable = false;
                    ToolTip = 'Specifies the value of the Account Name field';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Narration';
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Narration field';
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Amount field';
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
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(1, Rec."Shortcut Dimension 1 Code");
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code';
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field';
                    Visible = DimVisible2;
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(2, Rec."Shortcut Dimension 2 Code");
                    end;
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
                field(No; Rec.No)
                {
                    Caption = 'No';
                    Enabled = false;
                    ToolTip = 'Specifies the value of the No field';
                }
                field("Line No"; Rec."Line No")
                {
                    Caption = 'Line No';
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Line No field';
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
        }
    }

    var
        DimVisible1: Boolean;
        DimVisible2: Boolean;
        DimVisible3: Boolean;
        DimVisible4: Boolean;
        DimVisible5: Boolean;
        DimVisible6: Boolean;
        DimVisible7: Boolean;
        DimVisible8: Boolean;
        ShortcutDimCode: array[8] of Code[20];

    trigger OnOpenPage()
    begin
        SetDimensionVisibility();
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.InsertPaymentTypes();
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
