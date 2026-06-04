#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50791 "Interest Due Ledger Entries"
{
    Caption = 'Interest Due Ledger Entries';
    DataCaptionFields = "Customer No.";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Interest Due Ledger Entry";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Posting Date";  Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Type";  Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Document No.";  Rec."Document No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("External Document No.";  Rec."External Document No.")
                {
                    ApplicationArea = Basic;
                }
                field("Customer No.";  Rec."Customer No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan No";  Rec."Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction No.";  Rec."Transaction No.")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Type";  Rec."Loan Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Description;  Rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Credit Amount";  Rec."Credit Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Debit Amount";  Rec."Debit Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code"; Rec. "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Global Dimension 2 Code";  Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("IC Partner Code";  Rec."IC Partner Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Salesperson Code";  Rec."Salesperson Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Amount;  Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Amount (LCY)";  Rec."Amount (LCY)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("User ID";  Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date";  Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the Work Date Transaction Date,for transactions that are Backdated';
                }
                field("Bal. Account Type";  Rec."Bal. Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Bal. Account No."; Rec. "Bal. Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Source Code";  Rec."Source Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Reason Code";  Rec."Reason Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Reversed;  Rec.Reversed)
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field("Reversed by Entry No.";  Rec."Reversed by Entry No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Reversed Entry No."; Rec. "Reversed Entry No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Reversal Date";  Rec."Reversal Date")
                {
                    ApplicationArea = Basic;
                }
                field("Entry No.";  Rec."Entry No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Recoverd Loan";  Rec."Recoverd Loan")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part("Member Ledger Entry FactBox"; "Member Ledger Entry FactBox")
            {
                //SubPageLink = "Entry No." = field("Entry No.");
                Visible = true;
            }
            systempart(Control1102755003; Links)
            {
                Visible = false;
            }
            systempart(Control1102755001; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
    }

    trigger OnModifyRecord(): Boolean
    begin
        Codeunit.Run(Codeunit::"Cust. Entry-Edit", Rec);
        exit(false);
    end;

    var
        Navigate: Page Navigate;
        UserSetup: Record "User Setup";
        ObjMemberLedgerEntries: Record "Cust. Ledger Entry";
        ObjLoans: Record "Loans Register";
}

