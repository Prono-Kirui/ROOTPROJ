Codeunit 50156 "Journal Post Successful"
{
    trigger OnRun()
    begin
    end;

    procedure PostedSuccessfully() Posted: Boolean
    begin
        Posted := false;
        /*ValPost.SETRANGE(ValPost.UserID,USERID);
             ValPost.SETRANGE(ValPost."Value Posting",1);
             IF ValPost.FIND('-') THEN
                Posted:=TRUE;*/
    end;
}
