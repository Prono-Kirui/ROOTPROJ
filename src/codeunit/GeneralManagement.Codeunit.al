codeunit 50005 "General Management"
{
    procedure GenerateFABarcode(DocNo: Text)
    var
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        TypeHelper: Codeunit "Type Helper";
        Client: HttpClient;
        Response: HttpResponseMessage;
        InStr: InStream;
        FixedAsset: Record "Fixed Asset";
        BarCodeBase64: Text;
    begin
        FixedAsset.Get(DocNo);

        Client.Get('https://barcode.tec-it.com/barcode.ashx?data=' + TypeHelper.UrlEncode(DocNo) + '&code=Code128&translate-esc=on&imagetype=Jpg', Response);
        TempBlob.CreateInStream(InStr);
        Response.Content().ReadAs(InStr);

        BarCodeBase64 := Base64Convert.ToBase64(InStr);
        FixedAsset.Barcode.ImportStream(InStr, FixedAsset.Description);
        FixedAsset.Modify();
    end;

    procedure GenerateMultipleFABarcodes()
    var
        FixedAsset: Record "Fixed Asset";
    begin
        FixedAsset.SetRange(Blocked, false);
        if FixedAsset.FindSet() then
            repeat
                if not FixedAsset.Barcode.HasValue() then
                    GenerateFABarcode(FixedAsset."No.");
            until FixedAsset.Next() = 0;
    end;

    local procedure InitTextVariable()
    var
        WText039: Label 'EIGHT';
        WText049: Label 'EIGHTEEN';
        WText057: Label 'EIGHTY';
        WText042: Label 'ELEVEN';
        WText046: Label 'FIFTEEN';
        WText054: Label 'FIFTY';
        WText036: Label 'FIVE';
        WText053: Label 'FORTY';
        WText035: Label 'FOUR';
        WText045: Label 'FOURTEEN';
        WText060: Label 'MILLION';
        WText040: Label 'NINE';
        WText050: Label 'NINETEEN';
        WText058: Label 'NINETY';
        WText032: Label 'ONE';
        WText038: Label 'SEVEN';
        WText048: Label 'SEVENTEEN';
        WText056: Label 'SEVENTY';
        WText037: Label 'SIX';
        WText047: Label 'SIXTEEN';
        WText055: Label 'SIXTY';
        WText041: Label 'TEN';
        WText044: Label 'THIRTEEN';
        WText052: Label 'THIRTY';
        WText059: Label 'THOUSAND';
        WText034: Label 'THREE';
        WText043: Label 'TWELVE';
        WText051: Label 'TWENTY';
        WText033: Label 'TWO';
        ExponentText: array[5] of Text[30];
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        WText061: Label 'BILLION';
    begin
        OnesText[1] := WText032;
        OnesText[2] := WText033;
        OnesText[3] := WText034;
        OnesText[4] := WText035;
        OnesText[5] := WText036;
        OnesText[6] := WText037;
        OnesText[7] := WText038;
        OnesText[8] := WText039;
        OnesText[9] := WText040;
        OnesText[10] := WText041;
        OnesText[11] := WText042;
        OnesText[12] := WText043;
        OnesText[13] := WText044;
        OnesText[14] := WText045;
        OnesText[15] := WText046;
        OnesText[16] := WText047;
        OnesText[17] := WText048;
        OnesText[18] := WText049;
        OnesText[19] := WText050;
        TensText[1] := '';
        TensText[2] := WText051;
        TensText[3] := WText052;
        TensText[4] := WText053;
        TensText[5] := WText054;
        TensText[6] := WText055;
        TensText[7] := WText056;
        TensText[8] := WText057;
        TensText[9] := WText058;
        ExponentText[1] := '';
        ExponentText[2] := WText059;
        ExponentText[3] := WText060;
        ExponentText[4] := WText061;
    end;

    procedure GetAmountInWords(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
    var
        PrintExponent: Boolean;
        Cents: Integer;
        Exponent: Integer;
        Hundreds: Integer;
        NoTextIndex: Integer;
        Ones: Integer;
        Tens: Integer;
        WText026: Label 'ZERO';
        ExponentText: array[5] of Text[30];
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        WText027: Label 'HUNDRED';
        WText028: Label 'AND';
        CentsTxt: Label 'CENTS';
        DecimalPosition: Integer;
    begin
        Clear(NoText);
        InitTextVariable();

        NoTextIndex := 1;
        NoText[1] := '****';
        if No < 1 then
            AddToNoText(NoText, NoTextIndex, PrintExponent, WText026)
        else begin
            for Exponent := 4 downto 1 do begin
                PrintExponent := false;
                Ones := No div Power(1000, Exponent - 1);
                Hundreds := Ones div 100;
                Tens := (Ones mod 100) div 10;
                Ones := Ones mod 10;
                if Hundreds > 0 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, WText027);
                end;
                if Tens >= 2 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    if Ones > 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                end else
                    if (Tens * 10 + Ones) > 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                if PrintExponent and (Exponent > 1) then
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                No := No - (Hundreds * 100 + Tens * 10 + Ones) * Power(1000, Exponent - 1);
            end;
        end;

        DecimalPosition := 100;
        Cents := No * DecimalPosition;
        if Cents <> 0 then begin
            AddToNoText(NoText, NoTextIndex, PrintExponent, WText028);
            AddToNoText(NoText, NoTextIndex, PrintExponent, (Format(No * DecimalPosition) + ' ' + CentsTxt));
        end;

        if CurrencyCode <> '' then
            AddToNoText(NoText, NoTextIndex, PrintExponent, CurrencyCode);
    end;

    local procedure AddToNoText(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    var
        WText029: Label '%1 results in a written number that is too long.';
    begin
        PrintExponent := true;
        while StrLen(NoText[NoTextIndex] + ' ' + AddText) > MaxStrLen(NoText[1]) do begin
            NoTextIndex := NoTextIndex + 1;
            if NoTextIndex > ArrayLen(NoText) then
                Error(WText029, AddText);
        end;
        NoText[NoTextIndex] := DelChr(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;
}



