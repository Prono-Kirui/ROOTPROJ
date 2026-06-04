Page 50216 "Guarantor Sub Subform"
{
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "Guarantorship Substitution L";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Guaranteed"; Rec."Amount Guaranteed")
                {
                    ApplicationArea = Basic;
                }
                field("Current Commitment"; Rec."Current Commitment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Substituted; Rec.Substituted)
                {
                    ApplicationArea = Basic;
                }
                field("Substitute Member"; Rec."Substitute Member")
                {
                    ApplicationArea = Basic;
                }
                field("Substitute Member Name"; Rec."Substitute Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sub Amount Guaranteed"; Rec."Sub Amount Guaranteed")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetCurrRecord()
    begin
        // IF GSubHeader.GET("Document No") THEN BEGIN
        //  IF GSubHeader.Status=GSubHeader.Status::Open THEN BEGIN
        //  SubPageEditable:=TRUE
        //  END ELSE
        //  IF GSubHeader.Status<>GSubHeader.Status::Open THEN BEGIN
        //  SubPageEditable:=FALSE;
        //    END;
        //  END;
    end;

    trigger OnAfterGetRecord()
    begin
        // IF GSubHeader.GET("Document No") THEN BEGIN
        //  IF GSubHeader.Status=GSubHeader.Status::Open THEN BEGIN
        //  SubPageEditable:=TRUE
        //  END ELSE
        //  IF GSubHeader.Status<>GSubHeader.Status::Open THEN BEGIN
        //  SubPageEditable:=FALSE;
        //    END;
        //  END;
    end;

    var
        SubPageEditable: Boolean;
    //GSubHeader: Record "Cheque Processing Charges";
}
