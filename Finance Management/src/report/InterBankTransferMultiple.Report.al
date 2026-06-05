report 51023 "InterBank Transfer-Multiple"
{
    ApplicationArea = All;
    Caption = 'InterBank Transfers';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/InterBankTransferMultiple.rdl';

    dataset
    {
        dataitem(Payments; Payments)
        {
            column(No_Payments; Payments."No.")
            {
            }
            column(Date_Payments; Payments.Date)
            {
            }
            column(ShortcutDimension1Code_Payments; Payments."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_Payments; Payments."Shortcut Dimension 2 Code")
            {
            }
            column(PaymentNarration_Payments; Payments."Payment Narration")
            {
            }
            column(AccountNo_Payments; Payments."Account No.")
            {
            }
            column(RecBankName; GetBankName(Payments."Account No."))
            {
            }
            column(ReceivingBankAmount_Payments; Payments."Receiving Bank Amount")
            {
            }
            column(SourceBank_Payments; Payments."Source Bank")
            {
            }
            column(SourceCurrency_Payments; Payments."Source Currency")
            {
            }
            column(SourceBankAmount_Payments; Payments."Source Bank Amount")
            {
            }
            column(SourceBankName; GetBankName(Payments."Source Bank"))
            {
            }
            column(ReceivingAmountLCY_Payments; Payments."Receiving Amount LCY")
            {
            }
            column(SourceAmountLCY_Payments; Payments."Source Amount LCY")
            {
            }
            column(CreatedBy_Payments; Payments."Created By")
            {
            }
            column(Posted_Payments; Payments.Posted)
            {
            }
            column(PostedBy_Payments; Payments."Posted By")
            {
            }
            column(PostedDate_Payments; Payments."Posted Date")
            {
            }
            column(Currency_Payments; Payments.Currency)
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyFax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebsite; CompanyInfo."Home Page")
            {
            }
            column(PreparedBy; GetUserName(Approver[1]))
            {
            }
            column(DatePrepared; ApproverDate[1])
            {
            }
            column(PreparedBy_Signature; UserSetup.Signature)
            {
            }
            column(ExaminedBy; GetUserName(Approver[2]))
            {
            }
            column(DateApproved; ApproverDate[2])
            {
            }
            column(ExaminedBy_Signature; UserSetup1.Signature)
            {
            }
            column(VBC; GetUserName(Approver[3]))
            {
            }
            column(VBCDate; ApproverDate[3])
            {
            }
            column(VBC_Signature; UserSetup2.Signature)
            {
            }
            column(Authorizer; GetUserName(Approver[4]))
            {
            }
            column(DateAuthorized; ApproverDate[4])
            {
            }
            column(Authorizer_Signature; UserSetup3.Signature)
            {
            }
            column(Number_In_Words; NumberText[1])
            {
            }
            column(strCopyText; strCopyText)
            {
            }
            column(Dim1; GLSetup."Global Dimension 1 Code")
            {
            }
            column(Dim2; GLSetup."Global Dimension 2 Code")
            {
            }
            column(Dim3; GLSetup."Shortcut Dimension 3 Code")
            {
            }
            column(Dim4; GLSetup."Shortcut Dimension 4 Code")
            {
            }
            column(Dim5; GLSetup."Shortcut Dimension 5 Code")
            {
            }
            column(Dim6; GLSetup."Shortcut Dimension 6 Code")
            {
            }
            column(Dim7; GLSetup."Shortcut Dimension 7 Code")
            {
            }
            column(HeaderDimValueName_1; HeaderDimValueCode[1])
            {
            }
            column(HeaderDimValueName_2; HeaderDimValueCode[2])
            {
            }
            column(HeaderDimValueName_3; HeaderDimValueCode[3])
            {
            }
            column(HeaderDimValueName_4; HeaderDimValueCode[4])
            {
            }
            column(HeaderDimValueName_5; HeaderDimValueCode[5])
            {
            }
            column(HeaderDimValueName_6; HeaderDimValueCode[6])
            {
            }
            column(HeaderDimValueName_7; HeaderDimValueCode[7])
            {
            }
            column(HeaderDimValueName_8; HeaderDimValueCode[8])
            {
            }
            dataitem("Payment Lines"; "Payment Lines")
            {
                DataItemLink = No = field("No.");

                column(Currency_PaymentLines; "Payment Lines".Currency)
                {
                }
                column(AmountLCY_PaymentLines; "Payment Lines"."Amount (LCY)")
                {
                }
                column(AccountNo_PaymentLines; "Payment Lines"."Account No")
                {
                }
                column(AccountName_PaymentLines; "Payment Lines"."Account Name")
                {
                }
                column(Description_PaymentLines; "Payment Lines".Description)
                {
                }
                column(Amount_PaymentLines; "Payment Lines".Amount)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin

                Approver[1] := Payments."Created By";
                ApproverDate[1] := CreateDateTime(Payments.Date, Payments."Time Inserted");
                if UserSetup.Get(Approver[1]) then
                    UserSetup.CalcFields(Signature);

                ApprovalEntries.Reset();
                ApprovalEntries.SetCurrentKey("Sequence No.");
                ApprovalEntries.SetRange("Table ID", Database::Payments);
                ApprovalEntries.SetRange("Document No.", Payments."No.");
                ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Approved);
                if ApprovalEntries.Find('-') then
                    repeat
                        if ApprovalEntries."Sequence No." = 1 then begin
                            Approver[2] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[2] := ApprovalEntries."Last Date-Time Modified";
                            if UserSetup1.Get(Approver[2]) then
                                UserSetup1.CalcFields(Signature);
                        end;
                        if ApprovalEntries."Sequence No." = 2 then begin
                            Approver[3] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[3] := ApprovalEntries."Last Date-Time Modified";
                            if UserSetup2.Get(Approver[3]) then
                                UserSetup2.CalcFields(Signature);
                        end;
                    /* if ApprovalEntries."Sequence No." = 3 then begin
                        Approver[4] := ApprovalEntries."Last Modified By User ID";
                        ApproverDate[4] := ApprovalEntries."Last Date-Time Modified";
                        if UserSetup3.Get(Approver[4]) then
                            UserSetup3.CalcFields(Signature);
                    end; */
                    until ApprovalEntries.Next() = 0;

                if Posted then begin
                    Approver[4] := "Posted By";
                    ApproverDate[4] := CreateDateTime("Posted Date", "Time Posted");
                    if UserSetup3.Get(Approver[4]) then
                        UserSetup3.CalcFields(Signature);
                end;

                /*//Approvals
                ApprovalEntries.Reset();
                ApprovalEntries.SetRange("Table ID",Database::"Payments");
                ApprovalEntries.SetRange("Document No.",Payments."No.");
                ApprovalEntries.SetRange(Status,ApprovalEntries.Status::Approved);
                if ApprovalEntries.Find('-') then begin
                   i:=0;
                 repeat
                 i:=i+1;
                if i=1 then begin
                  Approver[1]:=ApprovalEntries."Sender ID";
                ApproverDate[1]:=ApprovalEntries."Date-Time Sent for Approval";
                 if UserSetup.Get(Approver[1]) then begin
                   if CashMgt."Append Sign To Documents"=true then
                    UserSetup.CalcFields(Signature);
                 end;

                Approver[2]:=ApprovalEntries."Approver ID";
                ApproverDate[2]:=ApprovalEntries."Last Date-Time Modified";
                 if UserSetup1.Get(Approver[2]) then begin
                   if CashMgt."Append Sign To Documents"=true then
                    UserSetup1.CalcFields(Signature);
                 end;
                end;

                if i=2 then
                begin
                Approver[3]:=ApprovalEntries."Approver ID";
                ApproverDate[3]:=ApprovalEntries."Last Date-Time Modified";
                 if UserSetup2.Get(Approver[3]) then begin
                   if CashMgt."Append Sign To Documents"=true then
                    UserSetup2.CalcFields(Signature);
                 end;
                end;

                if i=3 then
                begin
                Approver[4]:=ApprovalEntries."Approver ID";
                ApproverDate[4]:=ApprovalEntries."Last Date-Time Modified";
                 if UserSetup3.Get(Approver[4]) then begin
                   if CashMgt."Append Sign To Documents"=true then
                    UserSetup3.CalcFields(Signature);
                 end;
                end;
                until
                ApprovalEntries.Next()=0;
                end;*/

                //Get Header Dimensions
                DimSetEntry.Reset();
                DimSetEntry.SetRange("Dimension Set ID", Payments."Dimension Set ID");
                DimSetEntry.SetRange("Dimension Code", GLSetup."Global Dimension 1 Code");
                if DimSetEntry.FindFirst() then begin
                    DimSetEntry.CalcFields("Dimension Value Name");
                    HeaderDimValueCode[1] := DimSetEntry."Dimension Value Code";
                    HeaderDimValueName[1] := DimSetEntry."Dimension Value Name";
                end;

                DimSetEntry.Reset();
                DimSetEntry.SetRange("Dimension Set ID", Payments."Dimension Set ID");
                DimSetEntry.SetRange("Dimension Code", GLSetup."Global Dimension 2 Code");
                if DimSetEntry.FindFirst() then begin
                    DimSetEntry.CalcFields("Dimension Value Name");
                    HeaderDimValueCode[2] := DimSetEntry."Dimension Value Code";
                    HeaderDimValueName[2] := DimSetEntry."Dimension Value Name";
                end;
            end;
        }
    }
    labels
    {
    }

    var
        ApprovalEntries: Record "Approval Entry";
        CashMgt: Record "Cash Management Setups";
        CompanyInfo: Record "Company Information";
        DimSetEntry: Record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        UserSetup1: Record "User Setup";
        UserSetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        Approver: array[10] of Code[50];
        HeaderDimValueCode: array[8] of Code[50];
        ApproverDate: array[10] of DateTime;
        HeaderDimValueName: array[8] of Text;
        strCopyText: Text;
        NumberText: array[2] of Text[80];

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        GLSetup.Get();
        CashMgt.Get();
    end;

    local procedure GetBankName(BankCode: Code[50]): Text
    var
        BankAccount: Record "Bank Account";
    begin
        if BankAccount.Get(BankCode) then
            exit(BankAccount.Name);
    end;

    local procedure GetUserName(UserCode: Code[50]): Text
    begin
        // Users.RESET;
        // Users.SETRANGE("User Name",UserCode);
        // IF Users.FINDFIRST THEN
        exit(UserCode);
    end;
}
