pageextension 51005 "Fixed Asset Card Page Ext" extends "Fixed Asset Card"
{
    layout
    {
        modify("Budgeted Asset")
        {
            Caption = 'Budgeted Asset/for budget purposes';
        }
        modify(DepreciationStartingDate)
        {
            ShowMandatory = true;
        }
        modify(NumberOfDepreciationYears)
        {
            ShowMandatory = true;
        }
        modify(Blocked)
        {
            Caption = 'Blocked/Fully Retired';
        }

        modify(Inactive)
        {
            Caption = 'Inactive/Partially Retired';
        }
        addlast(General)
        {
            field("Asset Tagging"; Rec."Asset Tagging")

            {
                ApplicationArea = All;
                Caption = 'Asset Tagging';
                ToolTip = 'Specifies the value of the Asset Tagging field';
            }
            field("G/L Budget Line"; Rec."G/L Budget Line")
            {
                ApplicationArea = All;
                Caption = 'Budget Line';
                ToolTip = 'Specifies the value of the G/L Budget Line field';
            }
        }
        addlast("Depreciation Book")
        {
            field("FA Posting Group"; Rec."FA Posting Group")
            {
                ApplicationArea = All;
                Caption = 'FA Posting Group';
                ToolTip = 'Specifies the value of the FA Posting Group field';
            }
        }
    }
    actions
    {
        addafter(Analysis)
        {
            action(SendApprovalRequest)
            {
                ApplicationArea = All;
                Caption = 'Send A&pproval Request';
                //Enabled = not OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                ToolTip = 'Executes the Send A&pproval Request action';
            }
        }
        addlast(Category_Process)
        {
            actionref(SendApprovalRequest_Promoted; SendApprovalRequest)
            {
            }
        }
    }
}
