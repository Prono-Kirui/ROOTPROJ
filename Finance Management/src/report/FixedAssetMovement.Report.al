report 51031 "Fixed Asset Movement"
{
    ApplicationArea = All;
    Caption = 'Fixed Asset Movement';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/FixedAssetMovement.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(FixedAsset; "Fixed Asset")
        {
            RequestFilterFields = "FA Class Code", "FA Subclass Code", "FA Posting Date Filter";
            column(No; "No.")
            {
            }
            column(Description; Description)
            {
            }
            column(FAClassCode; "FA Class Code")
            {
            }
            column(FASubclassCode; "FA Subclass Code")
            {
            }
            column(FAPostingGroup; "FA Posting Group")
            {
            }
            column(Acquired; Acquired)
            {
            }

            trigger OnPreDataItem()
            begin
                DateFilter := FixedAsset.GetFilter("FA Posting Date Filter");
            end;

            trigger OnAfterGetRecord()
            begin
            end;
        }
    }

    var
        DateFilter: Text;
}
