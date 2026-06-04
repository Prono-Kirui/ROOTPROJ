page 50001 "Password History Log"
{
    ApplicationArea = All;
    Caption = 'Password History Log';
    PageType = List;
    SourceTable = "Password History";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field(UserName; Rec.UserName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the UserName field.';
                }
                field("Last Password Change"; Rec."Last Password Change")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Password Change field.';
                }
                field("Next Password Change"; Rec."Next Password Change")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Next Password Change field.';
                }
                field("User Security ID"; Rec."User Security ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ser Security ID field.';
                    Visible = false;
                }
                field("Changed?"; Rec."Changed?")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Changed? field.';
                    Editable = false;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                    Editable = false;
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                    Editable = false;
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                    Editable = false;
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                    Editable = false;
                }

            }
        }
    }
}






