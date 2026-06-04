pageextension 50002 "User Card Ext" extends "User Card"
{
    layout
    {
        modify(Password)
        {
            Enabled = PassEnabled;
        }
        // modify("User Security Groups")
        // {
        //     Enabled = UserGroupEditable;
        // }
        modify(Permissions)
        {
            Enabled = UserGroupEditable;
        }
    }

    actions
    {
        modify(ChangePassword)
        {
            trigger OnBeforeAction()
            var
                NoApprovedRequestErr: Label 'There is no approved Password Reset request for date %1 for %2.\Please submit a new request using the User Changes process.';
            begin
                if ICTSetup.Get() then
                    if ICTSetup."Pwd Reset Requires Approval" then begin
                        UserChanges.SetRange("User Security ID", Rec."User Security ID");
                        UserChanges.SetRange("Change Type", UserChanges."Change Type"::"Password Reset");
                        UserChanges.SetRange(Status, UserChanges.Status::Approved);
                        UserChanges.SetRange("Approved Date", Today());
                        //UserChanges.SetRange(Posted, false);
                        if not UserChanges.FindFirst() then
                            Error(NoApprovedRequestErr, Format(Today()), Rec."User Name");
                    end;
            end;
        }
    }

    var
        ICTSetup: Record "ICT Setup";
        UserChanges: Record "User Changes";
        PassEnabled: Boolean;
        UserGroupEditable: Boolean;

    trigger OnAfterGetRecord()
    begin
        if ICTSetup.Get() then begin
            if ICTSetup."Pwd Reset Requires Approval" then
                PassEnabled := false
            else
                PassEnabled := true;

            if ICTSetup."User Group/Permisison Approval" then begin
                UserGroupEditable := false;

                UserChanges.SetRange("User Security ID", Rec."User Security ID");
                UserChanges.SetRange("Change Type", UserChanges."Change Type"::"User Group/Permission Change");
                UserChanges.SetRange(Status, UserChanges.Status::Approved);
                UserChanges.SetRange("Approved Date", Today());
                if UserChanges.FindFirst() then
                    UserGroupEditable := true;

            end else
                UserGroupEditable := true;

        end else begin
            PassEnabled := true;
            UserGroupEditable := true;
        end;
    end;
}






