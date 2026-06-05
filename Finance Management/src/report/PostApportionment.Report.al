report 51025 "Post Apportionment"
{
    ApplicationArea = All;
    Caption = 'Post Apportionment';
    ProcessingOnly = true;
    ShowPrintStatus = false;
    dataset
    {
    }
    labels
    {
    }

    var
        Apportionment: Codeunit Apportionment;

    trigger OnPostReport()
    begin
        Apportionment.PostICApportionEntry();
    end;
}
