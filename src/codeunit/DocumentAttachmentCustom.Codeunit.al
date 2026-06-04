codeunit 50002 "Document Attachment Custom"
{
    procedure DownloadDocument(FilePath: Text)
    var
        FileName: Text;
    begin
        FileName := FilePath;
        //FilePath := FileMgt.OpenFileDialog('Select File', FilePath, 'All Files(*.*)|*.*');

        //FileMgt.DownloadToFile(FilePath, FileMgt.GetFileName(FilePath));
    end;

    procedure CountFiles(DocID: Code[50]; PageCaption: Text; FileNameFilter: Text): Integer
    var
        CompanyInfo: Record "Company Information";
        NameValueBuffer: Record "Name/Value Buffer";
        FileMgt: Codeunit "File Management";
        FileCounter: Integer;
        FilePath: Text;
    begin
        CompanyInfo.Get();
        CompanyInfo.TestField(Name);
        CompanyInfo.TestField("Document Path");

        FilePath := CompanyInfo."Document Path" + '\' + CompanyInfo.Name + '\' + PageCaption + '\' + DocID;

        FileCounter := 0;
        NameValueBuffer.DeleteAll();
        FileCounter := NameValueBuffer.Count;
        exit(FileCounter);
    end;

    local procedure InsertRecordLink(RecID: RecordId; FileURL: Text[2048]; FileName: Text[250])
    var
        RecLink: Record "Record Link";
        LineNo: Integer;
    begin
        RecLink.LockTable();
        if RecLink.FindLast() then
            LineNo := RecLink."Link ID" + 1
        else
            LineNo := 1;

        RecLink.Init();
        RecLink."Link ID" := LineNo;
        RecLink."Record ID" := RecID;
        RecLink.URL1 := FileURL;
        RecLink.Description := FileName;
        RecLink.Type := RecLink.Type::Link;
        RecLink.Created := CurrentDateTime;
        RecLink.Company := CompanyName;
        RecLink."User ID" := UserId;
        RecLink.Insert();
    end;

    local procedure GetRecLinkFromMemberResponse(ResponseTxt: Text; FileName: Text) DocURL: Text
    var
        StartPos: Integer;
        EndPos: Integer;
        RawURL: Text;
    begin
        StartPos := StrPos(ResponseTxt, '"http');
        EndPos := StrPos(ResponseTxt, '"]]');

        RawURL := CopyStr(ResponseTxt, StartPos, (EndPos - StartPos)) + FileName + '"';
        DocURL := DelChr(RawURL, '=', '\|"');
    end;

    procedure CopyAttachmentsFromRec(RecID: RecordId; CopyFromTableNo: Integer; CopyFromRecNo: Code[50]; CopyToRecNo: Code[50]; DocumentType: Enum "Attachment Document Type")
    var
        DocumentAttachment, DocumentAttachmentCopy : Record "Document Attachment";
        RecRef: RecordRef;
    begin
        RecRef := RecID.GetRecord();

        DocumentAttachment.SetRange("Table ID", CopyFromTableNo);
        DocumentAttachment.SetRange("No.", CopyFromRecNo);
        if DocumentAttachment.FindSet() then
            repeat
                DocumentAttachmentCopy.Init();
                DocumentAttachmentCopy.TransferFields(DocumentAttachment);
                DocumentAttachmentCopy."Table ID" := RecRef.Number;
                DocumentAttachmentCopy."No." := CopyToRecNo;
                DocumentAttachmentCopy."Document Type" := DocumentType;
                if not DocumentAttachmentCopy.Get(RecRef.Number,
                                                 CopyToRecNo,
                                                  DocumentAttachmentCopy."Document Type",
                                                  DocumentAttachmentCopy."Line No.",
                                                  DocumentAttachmentCopy.ID) then
                    DocumentAttachmentCopy.Insert();
            until DocumentAttachment.Next() = 0;
    end;
}






