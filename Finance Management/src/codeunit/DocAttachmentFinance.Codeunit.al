codeunit 51013 "Doc Attachment Finance"
{
    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
    local procedure AddCustomTablesOnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of
            Database::Payments:
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
    local procedure AddCustomTablesOnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        Payments: Record Payments;
    begin
        case DocumentAttachment."Table ID" of
            Database::Payments:
                begin
                    RecRef.Open(Database::Payments);
                    if Payments.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(Payments);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
    local procedure InsertCustomTablesOnAfterInitFieldsFromRecRef(var RecRef: RecordRef; var DocumentAttachment: Record "Document Attachment")
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of
            Database::Payments:
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value();
                    DocumentAttachment.Validate("No.", RecNo);
                    DocumentAttachment.Validate("Document Type", GetAttachmentDocumentTypeFromRec(RecRef));
                end;
        end;
    end;

    local procedure GetAttachmentDocumentTypeFromRec(RecRef: RecordRef): Enum "Document Attachment File Type"
    begin
        case RecRef.Number of
            Database::Payments:
                exit(Enum::"Attachment Document Type"::Payments);
        end;
    end;
}
