page 50013 "ICT Support Incidences"
{
    //CardPageID = "User Incidences Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "User Support Incident";
    SourceTableView = where(Status = filter(<> Closed));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Incident Reference"; Rec."Incident Reference")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Incident Reference field';
                }
                field("Incident Description"; Rec."Incident Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Incident Description field';
                }
                field("Incident Date"; Rec."Incident Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Incident Date field';
                }
                field(User; Rec.User)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User field';
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee No field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field("Incident Status"; Rec."Incident Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Incident Status field';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        if UserSetup.Get(UserId) then begin
            if not UserSetup."HOD User" then begin
                Rec.FilterGroup(2);
                Rec.SetRange(User, UserId);
            end;
        end;
    end;

    var
        UserSetup: Record "User Setup";
}





