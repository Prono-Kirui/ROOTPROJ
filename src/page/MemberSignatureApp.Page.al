#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50874 "Member Signature-App"
{
    PageType = CardPart;
    SourceTable = "Membership Applications";

    layout
    {
        area(content)
        {
            field(Signature; Rec.Signature)
            {
                ApplicationArea = Basic, Suite;
                ShowCaption = false;
                ToolTip = 'Specifies the picture that has been inserted for the signature.';
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
                Image = Camera;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Activate the camera on the device.';
                Visible = CameraAvailable and (HideActions = false);

                trigger OnAction()
                begin
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
                    Clear(Rec.Signature);
                    Rec.Signature.ImportStream(FileInStream, FileName);

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
                Visible = (CameraAvailable = false) and (HideActions = false);

                trigger OnAction()
                var
                    NameValueBuffer: Record "Name/Value Buffer";
                    TempNameValueBuffer: Record "Name/Value Buffer" temporary;
                    FileManagement: Codeunit "File Management";
                    ToFile: Text;
                    ExportPath: Text;
                begin

                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete the record.';
                Visible = HideActions = false;

                trigger OnAction()
                begin
                end;
            }
        }
    }

    var
        CameraAvailable: Boolean;
        DeleteExportEnabled: Boolean;
        OverrideImageQst: label 'The existing picture will be replaced. Do you want to continue?';
        DeleteImageQst: label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: label 'Select a picture to upload';
        DownloadImageTxt: label 'Download image';
        HideActions: Boolean;




    local procedure SetEditableOnPictureActions()
    begin
        //DeleteExportEnabled := Rec.Signature.Count <> 0;
    end;


    procedure SetHideActions()
    begin
        HideActions := true;
    end;



}

