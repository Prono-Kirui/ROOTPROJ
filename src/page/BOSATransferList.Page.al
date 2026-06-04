Page 50979 "BOSA Transfer List"
{
    ApplicationArea = Basic;
    CardPageID = Transfers;
    PageType = List;
    Editable = false;
    DeleteAllowed = true;
    SourceTable = "BOSA Transfers";
    SourceTableView = where(Posted = const(false), Approved = const(false));
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                }
                field("Schedule Total"; Rec."Schedule Total")
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Posted; Rec.Posted)
                {
                }
                field("Captured By"; Rec."Captured By")
                {
                    Style = StrongAccent;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        Rec.SetRange("Captured By", UserId);
    end;
}
