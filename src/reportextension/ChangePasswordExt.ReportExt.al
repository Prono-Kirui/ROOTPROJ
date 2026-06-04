reportextension 50000 "Change Password Ext" extends "Change Password"
{
    trigger OnPostReport()
    begin
        //Mark previous records as changed
        Changepassword.SetRange(UserName, UserId);
        Changepassword.SetRange("Changed?", false);
        if Changepassword.FindSet() then
            repeat
                Changepassword."Changed?" := true;
                Changepassword.Modify();
            until Changepassword.Next() = 0;

        //insert to password log table
        Changepassword.Init();
        Changepassword.No := Changepassword.GetNextLineNo();
        Changepassword.Validate("Last Password Change", Today);
        Changepassword."User Security ID" := UserSecurityId();
        Changepassword.UserName := UserId();
        Changepassword.Insert();

        if UserSetup.Get(UserId()) then begin
            UserSetup."Last Password Change" := Today();
            UserSetup.Modify();
        end;
    end;

    var
        Changepassword: Record "Password History";
        UserSetup: Record "User Setup";
        EntryNo: Integer;
}


