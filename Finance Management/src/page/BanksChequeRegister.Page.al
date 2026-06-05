page 51009 "Banks Cheque Register"
{
    ApplicationArea = All;
    Caption = 'Banks Cheque Register';
    PageType = List;
    SourceTable = "Bank Account";
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                Editable = false;
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    ToolTip = 'Specifies the value of the No. field';
                }
                field(Name; Rec.Name)
                {
                    Caption = 'Name';
                    ToolTip = 'Specifies the value of the Name field';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Cheques)
            {
                Caption = 'Cheque Register';
                Image = CheckList;
                RunObject = page "Cheque Register";
                RunPageLink = "Bank Account No." = field("No.");
                RunPageMode = View;
                ToolTip = 'Executes the Cheque Register action';
            }
            action(Generate)
            {
                Caption = 'Generate Cheque Nos';
                Image = CreateSerialNo;
                ToolTip = 'Executes the Generate Cheque Nos action';

                trigger OnAction()
                begin
                    if Confirm(Confirm001, false) = true then begin
                        BankAccount.Reset();
                        BankAccount.SetRange(BankAccount."No.", Rec."No.");
                        if BankAccount.FindFirst() then
                            Report.Run(Report::"Generate Cheque Nos", true, false, BankAccount);
                    end else
                        exit;
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Category_Process';
                actionref(Cheques_Promoted; Cheques)
                {
                }
                actionref(Generate_Promoted; Generate)
                {
                }
            }
        }
    }

    var
        BankAccount: Record "Bank Account";
        Confirm001: Label 'Are you sure you want to generate cheque nos for the selected bank?';
}
