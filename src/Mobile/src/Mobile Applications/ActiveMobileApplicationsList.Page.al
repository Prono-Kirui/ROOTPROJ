page 50407 "ActiveMobile Applications List"
{
    PageType = List;
    SourceTable = "CFTMobile Applications";
    ApplicationArea = All;
    Caption = 'Active Mobile Applications';
    UsageCategory = Administration;
    SourceTableView = where("Approval Status" = CONST(Approved), "Mobile Status" = const(Active), SentToServer = filter(true), "CFT Registered" = filter(true));
    Cardpageid = 50456;
    Editable = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.';
                }
                field("Current Account No"; Rec."Current Account No")
                {
                    ApplicationArea = All;
                    Caption = 'Current Account No';
                }
                field("Current Account Status"; Rec."Current Account Status")
                {
                    ApplicationArea = All;
                    Caption = 'Current Account Status';
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                    Caption = 'Account Name';
                }
                field("Telephone"; Rec."Telephone")
                {
                    ApplicationArea = All;
                    Caption = 'Telephone';
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = All;
                    Caption = 'ID No';
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = All;
                    Caption = 'Approval Status';
                }
                field("Date Applied"; Rec."Date Applied")
                {
                    ApplicationArea = All;
                    Caption = 'Date Applied';
                }
                field("Time Applied"; Rec."Time Applied")
                {
                    ApplicationArea = All;
                    Caption = 'Time Applied';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Caption = 'Created By';
                }
                field("Sent"; Rec."Sent")
                {
                    ApplicationArea = All;
                    Caption = 'Sent';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                    Caption = 'No. Series';
                }
                field("SentToServer"; Rec."SentToServer")
                {
                    ApplicationArea = All;
                    Caption = 'Sent To Server';
                }
                field("Mobile Status"; Rec."Mobile Status")
                {
                    ApplicationArea = All;
                    Caption = 'Mobile Status';
                }
                field("Last PIN Reset"; Rec."Last PIN Reset")
                {
                    ApplicationArea = All;
                    Caption = 'Last PIN Reset Date';
                }
                field("Reset By"; Rec."Reset By")
                {
                    ApplicationArea = All;
                    Caption = 'Reset By';
                }
                field("Activated By"; Rec."Activated By")
                {
                    ApplicationArea = All;
                    Caption = 'Activated By';
                }
                field("Last Activation"; Rec."Last Activation")
                {
                    ApplicationArea = All;
                    Caption = 'Last Activation DateTime';
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    Caption = 'Member No.';
                }
                field("CFT Registered"; Rec."CFT Registered")
                {
                    ApplicationArea = All;
                    Caption = 'CFT Registered';
                }
                field("UpdateNos"; Rec."UpdateNos")
                {
                    ApplicationArea = All;
                    Caption = 'Update Nos';
                }
                field("Response Message"; Rec."Response Message")
                {
                    ApplicationArea = All;
                    Caption = 'Response Message';
                }
                field("Last PIN Reset Time"; Rec."Last PIN Reset Time")
                {
                    ApplicationArea = All;
                    Caption = 'Last PIN Reset Time';
                }
                field("Till Registered"; Rec."Till Registered")
                {
                    ApplicationArea = All;
                    Caption = 'Till Registered';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {

        }
    }


}
