page 51096 "Vote Transfer"
{
    ApplicationArea = All;
    Caption = 'Vote Transfer';
    PageType = Card;
    SourceTable = "Votebook Transfer";
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = not Rec.Posted;
                group(Transfer)
                {
                    Caption = 'Transfer Details';

                    field(No; Rec.No)
                    {
                        Caption = 'No';
                        Editable = false;
                        ToolTip = 'Specifies the value of the No field';
                    }
                    field(Date; Rec.Date)
                    {
                        Caption = 'Date';
                        ToolTip = 'Specifies the value of the Date field';
                    }
                    field("Budget Name"; Rec."Budget Name")
                    {
                        Caption = 'Budget Name';
                        ToolTip = 'Specifies the value of the Budget Name field';
                    }
                    field(Amount; Rec.Amount)
                    {
                        Caption = 'Amount';
                        ToolTip = 'Specifies the value of the Amount field';
                    }
                    field(Remarks; Rec.Remarks)
                    {
                        Caption = 'Remarks';
                        MultiLine = true;
                        ToolTip = 'Specifies the value of the Remarks field';
                    }
                    field("Balance As At"; Rec."Balance As At")
                    {
                        Caption = 'Use Budget Balance As At';
                        ToolTip = 'Specifies the value of the Use Budget Balance As At field';
                    }
                }
                group("Transfer From")
                {
                    Caption = 'Transfer From Details';

                    field("Source Vote"; Rec."Source Vote")
                    {
                        Caption = 'Source G/L Account';
                        ToolTip = 'Specifies the value of the Source G/L Account field';
                        trigger OnValidate()
                        begin
                            CurrPage.Update();
                        end;
                    }
                    field("Source Vote Name"; Rec."Source Vote Name")
                    {
                        Caption = 'Source G/L Account Name';
                        ToolTip = 'Specifies the value of the Source G/L Account Name field';
                    }
                    group(Dimensions)
                    {
                        Caption = 'Dimensions';
                        Visible = false;
                        field("Source Dimension 1"; Rec."Source Dimension 1")
                        {
                            Caption = 'Source Dimension 1';
                            ToolTip = 'Specifies the value of the Source Dimension 1 field';
                        }
                        field("Source Dimension 2"; Rec."Source Dimension 2")
                        {
                            Caption = 'Source Dimension 2';
                            ToolTip = 'Specifies the value of the Source Dimension 2 field';
                        }
                    }
                }
                group("Transfer To")
                {
                    Caption = 'Transfer To Details';

                    field("Destination Vote"; Rec."Destination Vote")
                    {
                        Caption = 'Destination G/L Account';
                        ToolTip = 'Specifies the value of the Destination G/L Account field';
                        trigger OnValidate()
                        begin
                            CurrPage.Update();
                        end;
                    }
                    field("Destination Vote Name"; Rec."Destination Vote Name")
                    {
                        Caption = 'Destination G/L Account Name';
                        ToolTip = 'Specifies the value of the Destination G/L Account Name field';
                    }
                    group(Dimensions_)
                    {
                        Caption = 'Dimensions_';
                        Visible = false;
                        field("Destination Dimension 1"; Rec."Destination Dimension 1")
                        {
                            Caption = 'Destination Dimension 1';
                            ToolTip = 'Specifies the value of the Destination Dimension 1 field';
                        }
                        field("Destination Dimension 2"; Rec."Destination Dimension 2")
                        {
                            Caption = 'Destination Dimension 2';
                            ToolTip = 'Specifies the value of the Destination Dimension 2 field';
                        }
                    }
                }
            }
            group("More Details")
            {
                Caption = 'More Details';
                Editable = not Rec.Posted;

                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field';
                }
                field("Raised By"; Rec."Raised By")
                {
                    Caption = 'Raised By';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Raised By field';
                }
                field("Raised Date"; Rec."Raised Date")
                {
                    Caption = 'Raised Date';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Raised Date field';
                }
                field(Posted; Rec.Posted)
                {
                    Caption = 'Posted';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Posted field';
                }
                field("Posted Date"; Rec."Posted Date")
                {
                    Caption = 'Posted Date';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Posted Date field';
                }
                field("Posted By"; Rec."Posted By")
                {
                    Caption = 'Posted By';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Posted By field';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                    ToolTip = 'Specifies the value of the Currency Code field';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Post)
            {
                Caption = 'Post Transfer';
                Image = TransferFunds;
                ToolTip = 'Executes the Post Transfer action';

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to post this vote transfer?', false) = true then begin
                        Rec.TestField(Remarks);
                        PaymentsManagement.PostVoteTransfer(Rec);
                        CurrPage.Update();
                    end;
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

    var
        PaymentsManagement: Codeunit "Payments Management";
}
