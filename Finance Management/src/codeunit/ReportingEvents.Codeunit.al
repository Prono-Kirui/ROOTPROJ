codeunit 51014 "Reporting Events"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reporting Triggers", 'SubstituteReport', '', false, false)]
    local procedure SubstituteReport(ReportId: Integer; RunMode: Option; RequestPageXml: Text; RecordRef: RecordRef; var NewReportId: Integer)
    begin
        case ReportId of
            Report::"Standard Sales - Invoice":
                NewReportId := Report::"Custom Sales - Invoice";
        end;
    end;
}
