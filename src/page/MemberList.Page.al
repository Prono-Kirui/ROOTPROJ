#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50366 "Member List"
{
    ApplicationArea = Basic;
    Caption = 'Member List';
    CardPageID = "Member Account Card new";
    Editable = false;
    DeleteAllowed = false;
    //InsertAllowed = false;
    PageType = List;
    SourceTable = Customer;
    SourceTableView = sorting("No.") order(ascending);
    UsageCategory = Lists;
    AboutTitle = 'About customers';
    AboutText = 'Here you overview all registered customers, their balances, and the sales statistics. With [Customer Templates](?page=1381 "Opens the Customer Templates") you can quickly create new customers having common details defined by the template.';

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a unique number that identifies the customer. The number can be generated automatically from a number series, or you can number each of them manually.';
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer''s name that appears on all related documents. For companies, specify the company''s name here, and then add the relevant people as contacts that you link to this customer.';
                }


                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the customer''s telephone number.';
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }

                field("Personal No"; Rec."Personal No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll No';
                }


                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                // field(MemberLiability; MemberLiability)
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Member Liability';
                // }
                field("Member House Group"; Rec."Member House Group")
                {
                    ApplicationArea = Basic;
                }
                field("Member House Group Name"; Rec."Member House Group Name")
                {
                    ApplicationArea = Basic;
                }

                field("Privacy Blocked"; Rec."Privacy Blocked")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies whether to limit access to data for the data subject during daily operations. This is useful, for example, when protecting data from changes while it is under privacy review.';
                    Visible = false;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies when the customer card was last modified.';
                    Visible = false;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the customer posting group that is used to determine the general ledger accounts that are used for posting transactions for this customer.';

                }
                field("Customer Type"; Rec."Customer Type")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the type of customer, such as a member or a microfinance customer.';

                }
                field("PassBook Fee Paid"; Rec."PassBook Fee Paid")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }





            }
        }




        area(factboxes)
        {
            part(Control1000000052; "Member Statistics FactBox")
            {
                Caption = 'Member Statistics FactBox';
                SubPageLink = "No." = field("No.");
            }

        }
    }

    actions
    {
        area(Processing)
        {
            action("Send Deposit Reminder SMS")
            {
                ApplicationArea = All;
                Caption = 'Send Deposit Reminder SMS';
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Send SMS reminders to members about their monthly deposit contributions.';

                trigger OnAction()
                var
                    Customer: Record Customer;
                begin
                    Customer.Copy(Rec);
                    CurrPage.SetSelectionFilter(Customer);
                    Report.Run(Report::"sms To deposit", true, false, Customer);
                end;
            }
        }
    }
}
