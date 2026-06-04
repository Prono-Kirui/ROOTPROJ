#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50410 "Loan Products Setup List"
{
    CardPageID = "Loan Products Setup Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loan Products Setup";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field("Product Description"; Rec."Product Description")
                {
                    ApplicationArea = Basic;
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic;
                }
                field("Interest rate"; Rec."Interest rate")
                {
                    ApplicationArea = Basic;
                }
                field("Special Code"; Rec."Special Code")
                {
                    ApplicationArea = Basic;
                }
                field("Check Off Recovery"; Rec."Check Off Recovery")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                    ApplicationArea = Basic;
                }
                field("Grace Period - Principle (M)"; Rec."Grace Period - Principle (M)")
                {
                    ApplicationArea = Basic;
                }
                field("Grace Period - Interest (M)"; Rec."Grace Period - Interest (M)")
                {
                    ApplicationArea = Basic;
                }
                field("Use Cycles"; Rec."Use Cycles")
                {
                    ApplicationArea = Basic;
                }
                field("Instalment Period"; Rec."Instalment Period")
                {
                    ApplicationArea = Basic;
                }
                field("No of Installment"; Rec."No of Installment")
                {
                    ApplicationArea = Basic;
                }
                field("Default Installements"; Rec."Default Installements")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Calculation Days"; Rec."Penalty Calculation Days")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Percentage"; Rec."Penalty Percentage")
                {
                    ApplicationArea = Basic;
                }
                field("Recovery Priority"; Rec."Recovery Priority")
                {
                    ApplicationArea = Basic;
                }
                field("Min No. Of Guarantors"; Rec."Min No. Of Guarantors")
                {
                    ApplicationArea = Basic;
                }
                field("Min Re-application Period"; Rec."Min Re-application Period")
                {
                    ApplicationArea = Basic;
                }
                field("Shares Multiplier"; Rec."Shares Multiplier")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Calculation Method"; Rec."Penalty Calculation Method")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Paid Account"; Rec."Penalty Paid Account")
                {
                    ApplicationArea = Basic;
                }
                field("Min. Loan Amount"; Rec."Min. Loan Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Max. Loan Amount"; Rec."Max. Loan Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Account"; Rec."Loan Account")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Interest Account"; Rec."Loan Interest Account")
                {
                    ApplicationArea = Basic;
                }
                field("Receivable Interest Account"; Rec."Receivable Interest Account")
                {
                    ApplicationArea = Basic;
                }
                field("Action"; Rec.Action)
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Account"; Rec."BOSA Account")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Personal Loan Account"; Rec."BOSA Personal Loan Account")
                {
                    ApplicationArea = Basic;
                }
                field("Top Up Commision Account"; Rec."Top Up Commision Account")
                {
                    ApplicationArea = Basic;
                }
                field("Top Up Commision"; Rec."Top Up Commision")
                {
                    ApplicationArea = Basic;
                }
                field("Check Off Loan No."; Rec."Check Off Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Product)
            {
                Caption = 'Product';
                action("Product Charges")
                {
                    ApplicationArea = Basic;
                    Caption = 'Product Charges';
                    Image = Setup;
                    Promoted = true;
                    PromotedCategory = Process;
                    // RunObject = Page "Loan Product Charges";
                    // RunPageLink = "Product Code" = field(Code);
                }
                action("Loan to Share Ratio Analysis")
                {
                    ApplicationArea = Basic;
                    Image = Setup;
                    Promoted = true;
                    PromotedCategory = Process;
                    // RunObject = Page "Product Deposit>Loan Analysis";
                    // RunPageLink = "Product Code" = field(Code);
                }
            }
        }
    }
}

