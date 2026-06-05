page 51094 "Posted Apportion Card"
{
    ApplicationArea = All;
    Caption = 'Posted Apportion Card';
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Apportion Header";
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field("Created Date"; Rec."Created Date")
                {
                    Caption = 'Created Date';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Created Date field';
                }
                field("User ID"; Rec."User ID")
                {
                    Caption = 'Created By';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Created By field';
                }
                field(Posted; Rec.Posted)
                {
                    Caption = 'Posted';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Posted field';
                }
                field(Type; Rec.Type)
                {
                    Caption = 'Type';
                    ToolTip = 'Specifies the value of the Type field';
                }
            }
            part(Control7; "Apportion Lines")
            {
                Caption = 'Apportion Lines';
                Editable = false;
                SubPageLink = "No." = field("No.");
                Visible = Rec."Type" = Rec."Type"::"By Entry No";
            }
            part(Control15; "Apportionment Totals")
            {
                Caption = 'Apportionment Totals';
                Editable = false;
                SubPageLink = "No." = field("No.");
                Visible = Rec."Type" <> Rec."Type"::" ";
            }
            part(Control13; "Apportion Lines-Multiple")
            {
                Caption = 'Apportion Lines-Multiple';
                Editable = false;
                SubPageLink = "No." = field("No.");
                Visible = Rec."Type" = Rec."Type"::"By Document No";
            }
            part(Control8; "Apportionment Allocation Lines")
            {
                Caption = 'Apportionment Allocation Lines';
                Editable = false;
                SubPageLink = "Document No." = field("No.");
                Visible = Rec."Type" <> Rec."Type"::" ";
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Process)
            {
                Caption = 'Process';
                Image = PostApplication;
                ToolTip = 'Executes the Process action';
                Visible = false;
                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to process?', false) then
                        Apportionment.ProcessApportion(Rec);

                    CurrPage.Close();
                end;
            }
            action(Post)
            {
                Caption = 'Post';
                ToolTip = 'Executes the Post action';
                Visible = false;
            }
            action("Process & Post")
            {
                Caption = 'Process & Post';
                Image = ExecuteAndPostBatch;
                ToolTip = 'Executes the Process & Post action';
                Visible = false;
                trigger OnAction()
                begin
                    Apportionment.ProcessApportion(Rec);
                    Apportionment.PostApportion(Rec);
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Category_Process';
                actionref(Process_Promoted; Process)
                {
                }
                actionref("Process & Post_Promoted"; "Process & Post")
                {
                }
            }
        }
    }

    var
        Apportionment: Codeunit Apportionment;
}
