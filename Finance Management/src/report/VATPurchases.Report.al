report 51040 "VAT Purchases"
{
    ApplicationArea = All;
    Caption = 'VAT Purchases';
    DefaultRenderingLayout = VATPurchasesRDL;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("VAT Entry"; "VAT Entry")
        {
            DataItemTableView = SORTING("Document Date") WHERE(Type = CONST(Purchase), "Document Type" = FILTER(Invoice | "Credit Memo"));
            RequestFilterFields = "Document Date";

            column(CompanyLogo; CompanyInformation.Picture)
            {
            }
            column(CompanyName; CompanyInformation.Name)
            {
            }
            column(CompanyAddress; CompanyInformation.Address)
            {
            }
            column(CompanyAddress2; CompanyInformation."Address 2")
            {
            }
            column(CompanyPostCode; CompanyInformation."Post Code")
            {
            }
            column(CompanyCity; CompanyInformation.City)
            {
            }
            column(CompanyPhone; CompanyInformation."Phone No.")
            {
            }
            column(CompanyFax; CompanyInformation."Fax No.")
            {
            }
            column(CompanyEmail; CompanyInformation."E-Mail")
            {
            }
            column(CompanyWebsite; CompanyInformation."Home Page")
            {
            }
            column(SupplierPIN; Vendor."VAT Registration No.")
            {
            }
            column(SupplierName; Vendor.Name)
            {
            }
            column(ExtDocNo; "VAT Entry"."External Document No.")
            {
            }
            column(DocumentDate; DocumentDate)
            {
            }
            column(InvoiceNo; InvoiceNo)
            {
            }
            column(Description; Description)
            {
            }
            column(AmountExclVAT; "VAT Entry".Base)
            {
            }
            column(VATAmount; "VAT Entry".Amount)
            {
            }
            column(AmountInclVAT; AmountInclVAT)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if not Vendor.Get("Bill-to/Pay-to No.") then
                    //ERROR(ERR_VENDOR_NO,"Bill-to/Pay-to No.","Entry No.");
                    //substituted with Vendor."VAT Registration No."
                    //SupplierPIN := Vendor."VAT Registration No.";



                    //SupplierName := Vendor.Name;
                    // BV 13/03/2019
                    //IF NOT Vendor."Revenue Authority" THEN BEGIN
                    // KRAEntry := FALSE;
                    //AmountExclVAT := "VAT Entry".Base;
                    //VATAmount := Amount;

                    "VAT Entry".Base := "VAT Entry".Base;
                "VAT Entry".Amount := "VAT Entry".Amount;
                AmountInclVAT := "VAT Entry".Base + "VAT Entry".Amount;


                /*END ELSE BEGIN
                  //Exclude KRA if Type G/l Account.
                  IF KRAEntry THEN
                    CurrReport.SKIP;
                  KRAEntry := TRUE;
                  AmountExclVAT := 0;
                  VATAmount := 0;
                  AmountInclVAT := 0;
                  PurchaInvLine.SETRANGE(PurchaInvLine."Document No.","VAT Entry"."Document No.");
                  IF PurchaInvLine.FIND('-') THEN BEGIN
                    REPEAT
                      IF (PurchaInvLine.Type=PurchaInvLine.Type::"G/L Account") THEN
                        VATAmount := VATAmount + PurchaInvLine.Amount
                      ELSE IF (PurchaInvLine.Type=PurchaInvLine.Type::"Charge (Item)") THEN
                        AmountExclVAT := 0;//AmountExclVAT + PurchaInvLine.Amount;
                    UNTIL PurchaInvLine.NEXT = 0;
                    AmountInclVAT := AmountExclVAT + VATAmount;
                  END;
                END;*/
                // BV 13/03/2019 end

                //SerialNo := CompanyInformationrmation."ETR Serial No.";
                DocumentDate := "VAT Entry"."Posting Date";
                InvoiceNo := "VAT Entry"."Document No.";
                Description := GetDescription("Gen. Prod. Posting Group");

            end;

            trigger OnPreDataItem()
            begin
                SetRange(Type, Type::Purchase);
                SetRange("Document Type", "Document Type"::Invoice);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    rendering
    {
        layout(VATPurchasesRDL)
        {
            Caption = 'VAT Purchases';
            LayoutFile = './src/report_layout/VATPurchases.rdl';
            Type = RDLC;
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
        Vendor: Record Vendor;
        InvoiceNo: Code[20];
        DocumentDate: Date;
        AmountInclVAT: Decimal;
        Description: Text[100];

    local procedure GetDescription(ProdPostingGroupCode: Code[20]) ProductDescription: Text[100]
    var
        GenProductPostingGroup: Record "Gen. Product Posting Group";
    begin
        ProductDescription := '';
        if ProdPostingGroupCode <> '' then
            if GenProductPostingGroup.Get(ProdPostingGroupCode) then
                ProductDescription := GenProductPostingGroup.Description;
    end;
}