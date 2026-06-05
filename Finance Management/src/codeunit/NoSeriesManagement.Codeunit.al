// codeunit 51050 NoSeriesManagement
// {
//     trigger OnRun()
//     begin
//         TryNo := GetNextNo(TryNoSeriesCode, TrySeriesDate, false);
//     end;

//     var
//         GlobalNoSeries: Record "No. Series";
//         LastNoSeriesLine: Record "No. Series Line";
//         GlobalNoSeriesCode: Code[20];
//         WarningNoSeriesCode: Code[20];
//         TryNoSeriesCode: Code[20];
//         TrySeriesDate: Date;
//         TryNo: Code[20];
// #pragma warning disable AS0072
//     [Obsolete('Please use method GetNextNo(Code[20]; Date) or PeekNextNo(Code[20]; UsageDate) in the codeunit "No. Series" or "No. Series - Batch" instead. GetNextNo(Code[20]; Date; Boolean) does not have the same behavior. Make sure to use the correct parameters.', '24.0')]
//     procedure GetNextNo(NoSeriesCode: Code[20]; SeriesDate: Date; ModifySeries: Boolean) Result: Code[20]
//     var
//         IsHandled: Boolean;
//     begin
//         IsHandled := false;
//         OnBeforeGetNextNo(NoSeriesCode, SeriesDate, ModifySeries, Result, IsHandled, LastNoSeriesLine);
//         if IsHandled then
//             exit(Result);

//         exit(DoGetNextNo(NoSeriesCode, SeriesDate, ModifySeries, false));
//     end;
// #pragma warning restore AS0072
//     [Obsolete('This event is obsolete. Please use the extensibility options provided by the No. Series module.', '24.0')]
//     [IntegrationEvent(false, false)]
//     local procedure OnBeforeGetNextNo(var NoSeriesCode: Code[20]; var SeriesDate: Date; var ModifySeries: Boolean; var Result: Code[20]; var IsHandled: Boolean; var NoSeriesLine: Record "No. Series Line")
//     begin
//     end;

//     procedure DoGetNextNo(NoSeriesCode: Code[20]; SeriesDate: Date; ModifySeries: Boolean; NoErrorsOrWarnings: Boolean): Code[20]
//     var
//         NoSeriesLine: Record "No. Series Line";
//         CurrNoSeriesLine: Record "No. Series Line";
//     begin
//         OnBeforeDoGetNextNo(NoSeriesCode, SeriesDate, ModifySeries, NoErrorsOrWarnings);
//         if SeriesDate = 0D then
//             SeriesDate := WorkDate();

//         FindNoSeriesLine(CurrNoSeriesLine, NoSeriesCode, SeriesDate);
//         if ModifySeries or (LastNoSeriesLine."Series Code" = '') or (LastNoSeriesLine."Series Code" <> NoSeriesCode) or ((LastNoSeriesLine."Line No." <> CurrNoSeriesLine."Line No.") and (LastNoSeriesLine."Series Code" = NoSeriesCode)) then begin
//             GlobalNoSeries.Get(NoSeriesCode);
//             if not FindNoSeriesLine(NoSeriesLine, NoSeriesCode, SeriesDate) then begin
//                 if NoErrorsOrWarnings then
//                     exit('');
//                 NoSeriesLine.SetRange("Starting Date");
//                 if not NoSeriesLine.IsEmpty() then
//                     Error(CannotAssignNewOnDateErr, NoSeriesCode, SeriesDate);
//                 Error(CannotAssignNewErr, NoSeriesCode);
//             end;
//             UpdateLastUsedDate := NoSeriesLine."Last Date Used" <> SeriesDate;
//             if ModifySeries and (not (NoSeriesLine.Implementation = "No. Series Implementation"::Sequence) or UpdateLastUsedDate) then begin
//                 NoSeriesLine.LockTable();
//                 NoSeriesLine.Find();
//             end;
//         end else
//             NoSeriesLine := LastNoSeriesLine;

//         if GlobalNoSeries."Date Order" and (SeriesDate < NoSeriesLine."Last Date Used") then begin
//             if NoErrorsOrWarnings then
//                 exit('');
//             Error(CannotAssignNewBeforeDateErr, GlobalNoSeries.Code, NoSeriesLine."Last Date Used");
//         end;

//         NoSeriesLine."Last Date Used" := SeriesDate;
//         if (NoSeriesLine.Implementation = "No. Series Implementation"::Sequence) and (LastNoSeriesLine."Series Code" = '') then
//             NoSeriesLine."Last No. Used" := NoSeriesLine.GetNextSequenceNo(ModifySeries)
//         else
//             if NoSeriesLine."Last No. Used" = '' then begin
//                 if NoErrorsOrWarnings and (NoSeriesLine."Starting No." = '') then
//                     exit('');
//                 NoSeriesLine.TestField("Starting No.");
//                 NoSeriesLine."Last No. Used" := NoSeriesLine."Starting No.";
//             end else
//                 if NoSeriesLine."Increment-by No." <= 1 then
//                     NoSeriesLine."Last No. Used" := IncStr(NoSeriesLine."Last No. Used")
//                 else
//                     IncrementNoText(NoSeriesLine."Last No. Used", NoSeriesLine."Increment-by No.");

//         // Ensure number is within the valid range
//         if (NoSeriesLine."Ending No." <> '') and
//            (NoSeriesLine."Last No. Used" > NoSeriesLine."Ending No.")
//         then begin
//             if NoErrorsOrWarnings then
//                 exit('');
//             Error(CannotAssignGreaterErr, NoSeriesLine."Ending No.", NoSeriesCode);
//         end;

//         if (NoSeriesLine."Ending No." <> '') and
//            (NoSeriesLine."Warning No." <> '') and
//            (NoSeriesLine."Last No. Used" >= NoSeriesLine."Warning No.") and
//            (NoSeriesCode <> WarningNoSeriesCode) and
//            (TryNoSeriesCode = '')
//         then begin
//             if NoErrorsOrWarnings then
//                 exit('');
//             WarningNoSeriesCode := NoSeriesCode;
//             Message(CannotAssignGreaterErr, NoSeriesLine."Ending No.", NoSeriesCode);
//         end;

//         if ModifySeries and NoSeriesLine.Open and (not (NoSeriesLine.Implementation = "No. Series Implementation"::Sequence) or UpdateLastUsedDate) then
//             ModifyNoSeriesLine(NoSeriesLine);
//         if not ModifySeries then
//             LastNoSeriesLine := NoSeriesLine;

//         OnAfterGetNextNo3(NoSeriesLine, ModifySeries);
//         exit(NoSeriesLine."Last No. Used");
//     end;
// }