codeunit 50046 "RUAI Daily Activities"
{
    trigger OnRun()
    var
        CFTFactory: Codeunit "CFT Factory";
    begin
        CFTFactory.FnRecoverDefaultedMobileLoans();
        CFTFactory.FnSendMobileLoanReminders();  
    end;
}
