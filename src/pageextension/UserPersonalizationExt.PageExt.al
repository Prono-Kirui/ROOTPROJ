pageextension 50003 "User Personalization Ext" extends "User Personalization"
{
    layout
    {
    }

    trigger OnOpenPage()
    var
        ICTSetup: Record "ICT Setup";
        UserChanges: Record "User Changes";
        NoApprovedRequestErr: Label 'There is no approved Role Change request for date %1 for %2.\Please submit a new request using the User Changes process.';
    begin
        if ICTSetup.Get() then
            if ICTSetup."Role Change Requires Approval" then begin
                UserChanges.SetRange("User Security ID", Rec."User SID");
                UserChanges.SetRange("Change Type", UserChanges."Change Type"::"Role Change");
                UserChanges.SetRange(Status, UserChanges.Status::Approved);
                UserChanges.SetRange("Approved Date", Today());
                //UserChanges.SetRange(Posted, false);
                if not UserChanges.FindFirst() then
                    Error(NoApprovedRequestErr, Format(Today()), Rec."User ID");
            end;
    end;
}






