page 50502 "Member Picture"
{
    Caption = 'Applicant Picture';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "Membership Applications";

    layout
    {
        area(content)
        {
            field(Picture; Rec.Picture)
            {
                ApplicationArea = All;
                ShowCaption = false;
                ToolTip = 'Specifies the picture of the Member.';
                ShowMandatory = true;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(TakePicture)
            {
                ApplicationArea = All;
                Caption = 'Take';
                Image = Picture;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Open camera on the device.';
                // Visible = CameraAvailable;

                trigger OnAction()
                begin
                    TakeNewPicture();
                end;
            }
            action(ImportPicture)
            {
                ApplicationArea = All;
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';
                trigger OnAction()
                var
                    FileInStream: InStream;
                    FileName: Text;
                    ClientFileName: Text;
                begin
                    Rec.TestField(Rec."No.");
                    if rec."Account Type" = Rec."Account Type"::Single then begin
                        Rec.TestField(Rec."ID No.");
                    end;
                    Rec.TestField(Rec.Name);

                    // Check if picture already exists and confirm override
                    if Rec.Picture.HasValue() then
                        if not Confirm(OverrideImageQst) then
                            exit;

                    // Correct way to upload file in extensions
                    if not File.UploadIntoStream('Select Picture', '', 'Image Files|*.jpg;*.jpeg;*.png;*.bmp;*.gif', FileName, FileInStream) then
                        exit;

                    // Clear existing picture and import new one
                    Clear(Rec.Picture);
                    Rec.Picture.ImportStream(FileInStream, FileName);

                    // Save the record
                    if not Rec.Modify(true) then
                        Rec.Insert(true);

                    Message('Picture uploaded successfully.');
                end;

            }
            action(ExportFile)
            {
                ApplicationArea = All;
                Caption = 'Export';
                Enabled = DeleteExportEnabled;
                Image = Export;
                ToolTip = 'Export the picture to a file.';

                trigger OnAction()
                var
                    DummyPictureEntity: Record "Picture Entity";
                    FileManagement: Codeunit "File Management";
                    ToFile: Text;
                    ExportPath: Text;
                begin
                    // Rec.TestField(Rec."No.");
                    // Rec.TestField(rec.Name);
                    // ToFile := DummyPictureEntity.GetDefaultMediaDescription(Rec);
                    // ExportPath := TemporaryPath + rec."No." + Format(rec.Picture.MediaId);
                    // rec.Picture.ExportFile(ExportPath);
                    // FileManagement.ExportImage(ExportPath, ToFile);
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete Picture.';

                trigger OnAction()
                begin
                    Rec.TestField(Rec."No.");
                    if not Confirm(DeleteImageQst) then exit;
                    Clear(Rec.Picture);
                    Rec.Modify(true);
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        SetEditableOnPictureActions();
    end;

    trigger OnOpenPage()
    begin
        CameraAvailable := Camera.IsAvailable();
    end;

    var
        Camera: Codeunit Camera;
        [InDataSet]
        CameraAvailable: Boolean;
        OverrideImageQst: Label 'The existing Passport picture will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: Label 'Select a picture to upload';
        DeleteExportEnabled: Boolean;
        MimeTypeTok: Label 'image/jpeg', Locked = true;
        DownloadImageTxt: label 'Download image';

    // procedure TakeNewPicture()
    // var
    //     PictureInstream: InStream;
    //     PictureDescription: Text;
    // begin
    //     Rec.TestField(Rec."No.");
    //     Rec.TestField(rec.Name);
    //     if Rec.Picture.HasValue() then if not Confirm(OverrideImageQst) then exit;
    //     if Camera.GetPicture(PictureInstream, PictureDescription) then begin
    //         Clear(rec.Picture);
    //         //rec."Passport Picture".ImportStream(PictureInstream, PictureDescription, MimeTypeTok);
    //         Rec.Modify(true)
    //     end;
    // end;
    procedure TakeNewPicture()
    var
        PictureInstream: InStream;
        PictureDescription: Text;
        Camera: Codeunit Camera;
    begin
        Rec.TestField(Rec."No.");
        Rec.TestField(Rec.Name);

        // Check if picture already exists and confirm override
        if Rec.Picture.HasValue() then
            if not Confirm(OverrideImageQst) then
                exit;

        // Take picture using camera
        if Camera.GetPicture(PictureInstream, PictureDescription) then begin
            Clear(Rec.Picture);

            // Import the picture from camera stream
            Rec.Picture.ImportStream(PictureInstream, PictureDescription);

            // Save the record
            if Rec.Modify(true) then
                Message('Picture taken and saved successfully.')
            else
                Error('Failed to save the picture.');
        end else begin
            Message('No picture was taken.');
        end;
    end;

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Rec.Picture.HasValue;
    end;
}
