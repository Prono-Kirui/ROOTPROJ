page 50000 "ICT Setup"
{
    Caption = 'ICT Setup';
    PageType = Card;
    SourceTable = "ICT Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Role Change Requires Approval"; Rec."Role Change Requires Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Role Change Requires Approval field.';
                }
                field("Enforce Multiple Login Control"; Rec."Enforce Multiple Login Control")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Enforce Multiple Login Control field.';
                }
                field("User Group/Permisison Approval"; Rec."User Group/Permisison Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User Group/Permisison Approval field.';
                }
                field("Enforce Working Hours Policy"; Rec."Enforce Working Hours Policy")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Enforce Working Hours Policy field.';
                }
                group(WorkingHours)
                {
                    ShowCaption = false;
                    Editable = Rec."Enforce Working Hours Policy";
                    field("Working Hours Start Time"; Rec."Working Hours Start Time")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Working Hours Start Time field.';
                        ShowMandatory = true;
                    }
                    field("Working Hours End Time"; Rec."Working Hours End Time")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Working Hours End Time field.';
                        ShowMandatory = true;
                    }
                }
            }
            group(Password)
            {
                Caption = 'Password Policy';
                field("Enforce Password Expiry"; Rec."Enforce Password Expiry")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Enforce Password Expiry field.';
                }
                field("Pwd Reset Requires Approval"; Rec."Pwd Reset Requires Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Password Reset Requires Approval field.';
                }
                field("Last Password Change Date"; Rec."Last Password Change Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Password Change Date field.';
                    Visible = false;
                }
                field("Password Change Dateformula"; Rec."Password Change Dateformula")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Password Change Dateformula field.';
                }
                field("Next Password Change Date"; Rec."Next Password Change Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Next Password Change Date field.';
                    Editable = false;
                    Visible = false;
                }
            }
            group(Numbering)
            {
                field("Incidence Nos"; Rec."Incidence Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Incidence Nos field.';
                }
                field("Communication Nos"; Rec."Communication Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Communication Nos field.';
                }
                field("Password Reset Nos"; Rec."Password Reset Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Password Reset Nos field.';
                }
            }
            group(Emails)
            {
                field("Communication E-Mail"; Rec."Communication E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Communication E-Mail field.';
                }
                field("Escalation E-mail"; Rec."Escalation E-mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Escalation E-mail field.';
                }
                field("Security E-Mail"; Rec."Security E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Security E-Mail field.';
                }
            }
        }
    }

    trigger OnInit()
    begin
        if Rec.IsEmpty then
            Rec.Init();
    end;
}






