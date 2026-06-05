page 51081 "Proposed Budget Card"
{
    ApplicationArea = All;
    Caption = 'Proposed Budget Card';
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Proposed Budget Header";
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(Name; Rec.Name)
                {
                    Caption = 'Name';
                    ToolTip = 'Specifies the value of the Name field';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(Posted; Rec.Posted)
                {
                    Caption = 'Posted';
                    ToolTip = 'Specifies the value of the Posted field';
                }
                field("Posted By"; Rec."Posted By")
                {
                    Caption = 'Posted By';
                    ToolTip = 'Specifies the value of the Posted By field';
                }
                field("Date-Time Posted"; Rec."Date-Time Posted")
                {
                    Caption = 'Date-Time Posted';
                    ToolTip = 'Specifies the value of the Date-Time Posted field';
                }
            }
            part("Proposed Budget Lines"; "Proposed Budget Lines")
            {
                Caption = 'Proposed Budget Lines';
                Editable = false;
                SubPageLink = "Budget Name" = field(Name);
                SubPageView = where(Proposed = filter(true));
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Post)
            {
                Caption = 'Post To Final Budget';
                Image = PostedDeposit;
                ToolTip = 'Executes the Post To Final Budget action';

                trigger OnAction()
                begin
                    //FinanceManagement.PostFinalBudget(Rec);
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Category_Process';
                actionref(Post_Promoted; Post)
                {
                }
            }
        }
    }
}
