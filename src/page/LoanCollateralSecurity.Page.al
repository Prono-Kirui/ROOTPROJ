#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50388 "Loan Collateral Security"
{
    PageType = ListPart;
    SourceTable = "Loan Collateral Details";
    Editable = true;

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {


                field("Collateral Registe Doc"; Rec."Collateral Registe Doc")
                {
                    ApplicationArea = Basic;
                }
                field("Registered Owner"; Rec."Registered Owner")
                {
                    ApplicationArea = Basic;
                    //Editable = false;
                    Editable = true;
                }


                field("Reference No"; Rec."Reference No")
                {
                    ApplicationArea = Basic;
                    //Editable = false;
                    Editable = true;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                    //Editable = false;
                    Editable = true;
                }
                field("Security Details"; Rec."Security Details")
                {
                    ApplicationArea = Basic;
                    //Editable = false;
                    Editable = true;
                }
                field("Registration/Reference No"; Rec."Registration/Reference No")
                {
                    ApplicationArea = Basic;
                    //Editable = false;
                    Editable = true;
                }
                field(Value; Rec.Value)
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Multiplier"; Rec."Collateral Multiplier")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Comitted Collateral Value"; Rec."Comitted Collateral Value")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Guarantee Value"; Rec."Guarantee Value")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = Basic;
                    // Editable = false;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                    // Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

