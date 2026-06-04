page 50732 "House Group Registration Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Editable = true;
    SourceTable = "House Groups Registration";

    layout
    {
        area(Content)
        {
            group(General)
            {


                field("Cell Group Code"; Rec."Cell Group Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Cell Group Name"; Rec."Cell Group Name")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Date Formed"; Rec."Date Formed")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Meeting Date"; Rec."Meeting Date")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Group Leader"; Rec."Group Leader")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Group Leader Name"; Rec."Group Leader Name")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Group Leader Email"; Rec."Group Leader Email")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Group Leader Phone No"; Rec."Group Leader Phone No")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Assistant group Leader"; Rec."Assistant group Leader")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Assistant Group Name"; Rec."Assistant Group Name")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Assistant Group Leader Email"; Rec."Assistant Group Leader Email")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Assistant Group Leader Phone No"; Rec."Assistant Group Leader Phone No")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Credit Officer"; Rec."Credit Officer")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Field Officer"; Rec."Field Officer")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Meeting Place"; Rec."Meeting Place")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("No of Members"; Rec."No of Members")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(EnableCreateHouse)
            {

                trigger OnAction()
                begin
                    IF CONFIRM('Are you sure you want to Create this House Group?', FALSE) = TRUE THEN BEGIN
                        IF ObjSaccoNos.GET THEN BEGIN
                            ObjSaccoNos.TESTFIELD(ObjSaccoNos."House Group Nos");
                            VarHouseNo := NoSeriesMgt.GetNextNo(ObjSaccoNos."House Group Nos", 0D, TRUE);

                            ObjHouseG.INIT;
                            ObjHouseG."Cell Group Code" := VarHouseNo;
                            ObjHouseG."Cell Group Name" := Rec."Cell Group Name";
                            ObjHouseG."Group Leader" := Rec."Group Leader";
                            ObjHouseG."Group Leader Name" := Rec."Group Leader Name";
                            ObjHouseG."Group Leader Email" := Rec."Group Leader Email";
                            ObjHouseG."Group Leader Phone No" := Rec."Group Leader Phone No";
                            ObjHouseG."Assistant group Leader" := Rec."Assistant group Leader";
                            ObjHouseG."Assistant Group Name" := Rec."Assistant Group Name";
                            ObjHouseG."Assistant Group Leader Email" := Rec."Assistant Group Leader Email";
                            ObjHouseG."Assistant Group Leader Phone N" := Rec."Assistant Group Leader Phone N";
                            ObjHouseG."Meeting Place" := Rec."Meeting Place";
                            ObjHouseG.INSERT;

                        END;
                    END;

                end;
            }
            action("Send Approval Request")
            {

                trigger OnAction()
                begin

                end;
            }
            action("Cancel Approval Request")
            {

                trigger OnAction()
                begin

                end;
            }
            action(Approval)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;

        ObjCellGroups: Record "Member House Groups";
        ObjCust: Record Customer;
        DocumentType: Option;
        EnableCreateHouse: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        EnabledApprovalWorkflowsExist: Boolean;
        MemberNoEditable: Boolean;
        AccountNoEditable: Boolean;
        ChangeTypeEditable: Boolean;
        AccountTypeEditable: Boolean;
        VarBOSANOKVisible: Boolean;
        VarFOSANOKVisible: Boolean;
        VarAccountAgentVisible: Boolean;
        ObjSaccoNos: Record "Sacco No. Series";
        VarHouseNo: Code[30];
        ObjHouseG: Record "Member House Groups";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
}