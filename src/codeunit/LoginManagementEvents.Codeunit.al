codeunit 50004 "Login Management Events"
{
    Permissions = tabledata User = rim;

    //[EventSubscriber(ObjectType::Codeunit, Codeunit::LogInManagement, 'OnBeforeLogInStart', '', false, false)]
    //[EventSubscriber(ObjectType::Codeunit, Codeunit::"System Initialization", 'OnAfterLogin', '', false, false)]

#pragma warning disable AL0432
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Company Triggers", 'OnCompanyOpen', '', false, false)]
    local procedure CheckLogInHours()
    var
        CompanyInformation: Record "Company Information";
        LoginManagement: Codeunit LogInManagement;
        UserSetup: Record "User Setup";
        ICTSetup: Record "ICT Setup";
        Description: Text;
        OverHours: Boolean;
        NotAllowedToAccessErr: Label 'You are only allowed to access the system from %1 to %2. Kindly contact your ICT for assistance';
        NotAllowedToAccessNonWorkingErr: Label 'You are not allowed to access the system on %1. Kindly contact your ICT for assistance';
    begin
        OverHours := false;

        if GuiAllowed then
            if ICTSetup.Get() then
                if ICTSetup."Enforce Working Hours Policy" then
                    if UserSetup.Get(UserId()) then
                        if not UserSetup."Time Sheet Admin." then begin
                            //Non-working days
                            if CompanyInformation.Get() then begin
                                CompanyInformation.TestField("Base Calendar Code");
                                //if HRManagement.CheckNonWorkingDay(CompanyInformation."Base Calendar Code", Today(), Description) then
                                if not UserSetup."Allow Login After Hours" then begin
                                    Error(NotAllowedToAccessNonWorkingErr, Description);
                                    StopSession(SessionId());
                                end;
                            end;

                            //Working Hours
                            ICTSetup.TestField("Working Hours Start Time");
                            ICTSetup.TestField("Working Hours End Time");

                            if (Time() < ICTSetup."Working Hours Start Time") or (Time() > ICTSetup."Working Hours Start Time") then
                                OverHours := true;

                            /* if (Time() > ICTSetup."Working Hours Start Time") then
                                OverHours := true; */

                            if (OverHours) and (not UserSetup."Allow Login After Hours") then begin
                                Error(NotAllowedToAccessErr, ICTSetup."Working Hours Start Time", ICTSetup."Working Hours End Time");
                                StopSession(SessionId());
                            end;
                        end;
    end;

    //[EventSubscriber(ObjectType::Codeunit, Codeunit::"System Initialization", 'OnAfterLogin', '', false, false)]
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Company Triggers", 'OnCompanyOpen', '', false, false)]
    local procedure CheckMultipleLogins()
    var
        ActiveSession: Record "Active Session";
        UserSetup: Record "User Setup";
        User: Record User;
        NotAllowedMultipleLoginsErr: Label 'You are not allowed to have multiple logins in the system. Kindly contact your administrator for assistance';
        LoginDate: Date;
        ICTSetup: Record "ICT Setup";
    begin
        if GuiAllowed then
            if ICTSetup.Get() then
                if ICTSetup."Enforce Multiple Login Control" then
                    if UserSetup.Get(UserId()) then
                        if not UserSetup."Allow Multiple Login" then begin
                            ActiveSession.SetRange("User ID", UserId());
                            ActiveSession.SetRange("Login Datetime", CreateDateTime(Today(), 000000T), CreateDateTime(Today(), 235959T));
                            if ActiveSession.Count > 2 then
                                Error(NotAllowedMultipleLoginsErr);
                        end;
        /* User.SetRange("User Security ID", UserSecurityId);
        User.FindFirst();
        UserSetup.Get(User."User Name");

        if UserSetup."Multiple Login" <= 1 then begin
            Error(NotAllowedMultipleLoginsErr);
        end; */
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"System Initialization", 'OnAfterLogin', '', false, false)]
    local procedure InitPasswordLogIfEmpty()
    var
        ChangePassword: Record "Password History";
        UserSetup: Record "User Setup";
        ICTSetup: Record "ICT Setup";
    begin
        if GuiAllowed then
            if ICTSetup.Get() then
                if ICTSetup."Enforce Password Expiry" then begin
                    UserSetup.Reset();
                    UserSetup.SetRange("User ID", UserId);
                    UserSetup.SetRange("Password Does Not Expire", false);
                    if UserSetup.FindSet() then begin
                        ChangePassword.Reset();
                        ChangePassword.SetRange(UserName, UserSetup."User ID");
                        if not ChangePassword.FindFirst() then begin
                            ChangePassword.Init();
                            ChangePassword.No := ChangePassword.GetNextLineNo();
                            ChangePassword.UserName := UserSetup."User ID";
                            ChangePassword.Validate("Last Password Change", Today());
                            ChangePassword."User Security ID" := GetUserSecurityID(UserSetup."User ID");
                            ChangePassword."Changed?" := false;
                            ChangePassword.Insert();
                        end;
                    end;
                end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"System Initialization", 'OnAfterLogin', '', false, false)]
    local procedure CheckifPasswordhadExpired()
    var
        ChangePassword: Record "Password History";
        User: Record User;
        ICTSetup: Record "ICT Setup";
        UserSetup: Record "User Setup";
        PasswordExpiryMsg: Label 'Hi %1, Your password has expired. You will be required to change it on your next login';
    begin
        if GuiAllowed then
            if ICTSetup.Get() then
                if ICTSetup."Enforce Password Expiry" then begin
                    UserSetup.SetRange("User ID", UserId);
                    if not UserSetup."Password Does Not Expire" then begin
                        ChangePassword.SetCurrentKey(No);
                        ChangePassword.SetRange("User Security ID", UserSecurityId());
                        if ChangePassword.FindLast() then
                            if ChangePassword."Next Password Change" = Today() then
                                if User.Get(ChangePassword."User Security ID") then begin
                                    Message(StrSubstNo(PasswordExpiryMsg, UserId()));
                                    User.Validate("Change Password", true);
                                    User.Modify()
                                end;
                    end;
                end;
    end;

    local procedure GetUserSecurityID(UserName: Code[50]): GUID
    var
        UserRec: Record User;
    begin
        UserRec.SetRange("User Name", UserName);
        if UserRec.FindFirst() then
            exit(UserRec."User Security ID");
    end;
}





