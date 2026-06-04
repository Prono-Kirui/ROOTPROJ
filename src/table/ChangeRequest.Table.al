#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50552 "Change Request"
{
    DrillDownPageID = "Change Request List";
    LookupPageID = "Change Request List";

    fields
    {
        field(1; No; Code[30])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Change Request No");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Type; Option)
        {
            OptionCaption = ' ,Mobile Change,ATM Change,Backoffice Change,FrontOffice Change';
            OptionMembers = " ","Mobile Change","ATM Change","Backoffice Change","FrontOffice Change";

            trigger OnValidate()
            begin
                "Account No" := '';
            end;
        }
        field(3; "Account No"; Code[50])
        {
            TableRelation = if (Type = const("Backoffice Change")) Customer."No."
            else if (Type = const("Mobile Change")) Vendor."No."
            else if (Type = const("ATM Change")) Vendor."No."
            else if (Type = const("FrontOffice Change")) Vendor."No.";

            trigger OnValidate()
            begin
                //CLEAR(Picture);
                if ((Type = Type::"Mobile Change") or (Type = Type::"ATM Change") or (Type = Type::"FrontOffice Change")) then begin
                    vend.Reset;
                    vend.SetRange(vend."No.", "Account No");
                    if vend.Find('-') then begin
                        Name := vend.Name;
                        Branch := vend."Global Dimension 2 Code";
                        Address := vend.Address;
                        //  Picture:=vend.Picture;
                        //  Signature:=vend.Signature;

                        Email := vend."E-Mail";
                        "Mobile No" := vend."Mobile Phone No";
                        "Phone No" := vend."Phone No.";
                        //  "S-Mobile No":=vend. "S-Mobile No";
                        //  "ATM Collector Name":=vend."ATM Collector Name";
                        "ID No" := vend."ID No.";
                        "Personal No" := vend."Personal No.";
                        "Account Type" := vend."Account Type";
                        City := vend.City;
                        Section := vend.Section;
                        "Card Expiry Date" := vend."Card Expiry Date";
                        "Card No" := vend."Card No.";
                        "Card Valid From" := vend."Card Valid From";
                        "Card Valid To" := vend."Card Valid To";
                        "Marital Status" := vend."Marital Status";
                        "Member Account Status" := vend.Status;
                        //"Signing Instructions":=vend."Signing Instructions";
                        "Reason for change" := vend."Reason For Blocking Account";
                    end;
                end;


                if (Type = Type::"Backoffice Change") or (Type = Type::"Mobile Change") then begin
                    Memb.Reset;
                    Memb.SetRange(Memb."No.", "Account No");
                    if Memb.Find('-') then begin

                        Name := Memb.Name;
                        Branch := Memb."Global Dimension 2 Code";
                        Address := Memb.Address;
                        // Picture:=Memb.Picture;
                        // Signature := Memb.Signature;
                        //MESSAGE('Picture='+FORMAT(Memb.Picture)+' Sign='+FORMAT(Signature));
                        Email := Memb."E-Mail";
                        "Mobile No" := Memb."Mobile Phone No";
                        "Phone No" := Memb."Phone No.";
                        "ID No" := Memb."ID No.";
                        "Personal No" := Memb."Personal No";
                        City := Memb.City;
                        Section := Memb.Section;
                        "Marital Status" := Memb."Marital Status";
                        "Monthly Contributions" := Memb."Monthly Contribution";
                        //"Signing Instructions":=Memb."Signing Instructions";
                        "Member Account Status" := Memb.Status;
                        "Blocked Status" := Memb.Blocked;

                    end;

                end;
            end;
        }
        field(4; "Mobile No"; Code[50])
        {
        }
        field(5; Name; Text[40])
        {
        }
        field(6; "No. Series"; Code[30])
        {
        }
        field(7; Address; Code[30])
        {
        }
        field(8; Branch; Code[30])
        {
        }
        field(9; Picture; MediaSet)
        {
        }
        field(10; Signature; MediaSet)
        {
        }
        field(11; City; Code[30])
        {
        }
        field(12; "E-mail"; Code[30])
        {
        }
        field(13; "Personal No"; Code[30])
        {
        }
        field(14; "ID No"; Code[40])
        {
        }
        field(15; "Marital Status"; Option)
        {
            OptionCaption = 'Married,Single';
            OptionMembers = Married,Single;
        }
        field(16; "Passport No."; Code[30])
        {
        }
        field(17; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(18; "Account Type"; Code[30])
        {
        }
        field(19; "Account Category"; Code[30])
        {
        }
        field(20; Email; Code[40])
        {
        }
        field(21; Section; Code[40])
        {
        }
        field(22; "Card No"; Code[30])
        {
        }
        field(23; "Home Address"; Code[30])
        {
        }
        field(24; Loaction; Code[20])
        {
        }
        field(25; "Sub-Location"; Code[30])
        {
        }
        field(26; District; Code[30])
        {
        }
        field(27; "Reason for change"; Text[20])
        {
        }
        field(28; "Signing Instructions"; Text[40])
        {
        }
        field(29; "S-Mobile No"; Code[10])
        {
        }
        field(30; "ATM Approve"; Code[30])
        {
        }
        field(31; "Card Expiry Date"; Date)
        {
        }
        field(32; "Card Valid From"; Date)
        {
        }
        field(33; "Card Valid To"; Date)
        {
        }
        field(34; "Date ATM Linked"; Date)
        {
        }
        field(35; "ATM No."; Code[16])
        {
        }
        field(36; "ATM Issued"; Boolean)
        {
        }
        field(37; "ATM Self Picked"; Boolean)
        {
        }
        field(38; "ATM Collector Name"; Code[30])
        {
        }
        field(39; "ATM Collectors ID"; Code[20])
        {
        }
        field(40; "Atm Collectors Moile"; Code[30])
        {
        }
        field(41; "Member Type"; Option)
        {
            OptionCaption = ' ,class A,class B';
            OptionMembers = " ","class A","class B";
        }
        field(42; "Monthly Contributions"; Decimal)
        {
        }
        field(43; "Captured by"; Code[50])
        {
            Editable = false;
        }
        field(44; "Capture Date"; Date)
        {
            Editable = false;
        }
        field(46; "Approved by"; Code[50])
        {
            Editable = false;
        }
        field(47; "Approval Date"; Date)
        {
            Editable = false;
        }
        field(48; Changed; Boolean)
        {
            Editable = true;
        }
        field(49; "Responsibility Centers"; Code[20])
        {
            TableRelation = "Responsibility Center";
        }
        field(50; "Member Cell Group"; Code[30])
        {
            //  TableRelation = "Hexa Binary";

            trigger OnValidate()
            begin
                //if MemberCell.Get("Member Cell Group") then begin
                // "Member Cell Name":=MemberCell."Cell Group Name";
                //  end;
            end;
        }
        field(51; "Member Cell Name"; Code[30])
        {
        }
        field(52; "Group Account No"; Code[30])
        {
            TableRelation = Customer."No.";
        }
        field(53; "Group Account Name"; Code[30])
        {
        }
        field(54; "Member Account Status"; Option)
        {
            OptionCaption = 'Active,Non-Active,Blocked,Dormant,Re-instated,Deceased,Withdrawn,Retired,Termination,Resigned,Ex-Company,Casuals,Family Member,Defaulter,Applicant,Rejected,New';
            OptionMembers = Active,"Non-Active",Blocked,Dormant,"Re-instated",Deceased,Withdrawn,Retired,Termination,Resigned,"Ex-Company",Casuals,"Family Member",Defaulter,Applicant,Rejected,New;
        }
        field(55; "Mobile No(New Value)"; Code[50])
        {
        }
        field(56; "Name(New Value)"; Text[40])
        {
        }
        field(57; "No. Series(New Value)"; Code[30])
        {
        }
        field(58; "Address(New Value)"; Code[30])
        {
        }
        field(59; "Branch(New Value)"; Code[30])
        {
        }
        field(60; "Picture(New Value)"; Blob)
        {
            SubType = Bitmap;
        }
        field(61; "signinature(New Value)"; Blob)
        {
            SubType = Bitmap;
        }
        field(62; "City(New Value)"; Code[30])
        {
        }
        field(63; "E-mail(New Value)"; Code[30])
        {
        }
        field(64; "Personal No(New Value)"; Code[30])
        {
        }
        field(65; "ID No(New Value)"; Code[40])
        {
        }
        field(66; "Marital Status(New Value)"; Option)
        {
            OptionCaption = ' ,Single,Married,Divorced,Widower';
            OptionMembers = " ",Single,Married,Divorced,Widower;
        }
        field(67; "Passport No.(New Value)"; Code[30])
        {
        }
        field(68; "Status(New Value)"; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(69; "Account Type(New Value)"; Code[30])
        {
        }
        field(70; "Account Category(New Value)"; Code[30])
        {
        }
        field(71; "Email(New Value)"; Code[40])
        {
        }
        field(72; "Section(New Value)"; Code[40])
        {
        }
        field(73; "Card No(New Value)"; Code[30])
        {
        }
        field(74; "Home Address(New Value)"; Code[30])
        {
        }
        field(75; "Loaction(New Value)"; Code[20])
        {
        }
        field(76; "Sub-Location(New Value)"; Code[30])
        {
        }
        field(77; "District(New Value)"; Code[30])
        {
        }
        field(78; "Signing Instructions(NewValue)"; Text[40])
        {
        }
        field(79; "S-Mobile No(New Value)"; Code[10])
        {
        }
        field(80; "ATM No.(New Value)"; Date)
        {
        }
        field(81; "Monthly Contributions(NewValu)"; Decimal)
        {
        }
        field(82; "Member Account Status(NewValu)"; Option)
        {
            OptionCaption = 'Active,Non-Active,Blocked,Dormant,Re-instated,Deceased,Withdrawn,Retired,Termination,Resigned,Ex-Company,Casuals,Family Member,Defaulter,Applicant,Rejected,New';
            OptionMembers = Active,"Non-Active",Blocked,Dormant,"Re-instated",Deceased,Withdrawn,Retired,Termination,Resigned,"Ex-Company",Casuals,"Family Member",Defaulter,Applicant,Rejected,New;
        }
        field(83; "Charge Reactivation Fee"; Boolean)
        {
        }
        field(84; "Blocked Status"; Option)
        {
            OptionCaption = ' ,Ship,Invoice,All';
            OptionMembers = " ",Ship,Invoice,All;
        }
        field(85; "Blocked Statues(New)"; Option)
        {
            OptionCaption = ' ,Ship,Invoice,All';
            OptionMembers = " ",Ship,Invoice,All;
        }
        field(86; "Reason For Blocking Account(New)"; Text[20])
        {
        }
        //"Status (New Value)"
        field(87; "Status (New Value)"; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        //"Blocked (New)";
        field(88; "Blocked (New)"; Option)
        {
            OptionCaption = 'Yes,No';
            OptionMembers = Yes,No;
        }
        //"Status.(New)"
        field(89; "Status.(New)"; enum "Account Status")
        {

        }
        field(116; "Position In the Sacco(New)"; enum "Position In the Sacco")
        {
        }

        field(99; "Bank Code(Old)"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Banks.Code;

            trigger OnValidate()
            var
                Banks: Record Banks;
            begin
                /*Banks.RESET;
                    Banks.SETRANGE(Banks.Code,"Bank Code");
                    IF Banks.FIND('-') THEN
                      "Bank Name":=Banks."Bank Name";*/
            end;
        }
        field(100; "Bank Code(New)"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Banks.Code;

            trigger OnValidate()
            var
                Banks: Record Banks;
            begin
                Banks.Reset;
                Banks.SetRange(Banks.Code, "Bank Code(New)");
                if Banks.Find('-') then "Bank Name (New)" := Banks.Name;
            end;
        }
        field(101; "Bank Account No(Old)"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(102; "Bank Account No(New)"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        //"Bank Name (New)"
        field(103; "Bank Name (New)"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(110; "Bank Branch Name(New)"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(111; "Bank Branch Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(112; "Bank Branch Code(New)"; Code[50])
        {
            DataClassification = ToBeClassified;


            trigger OnValidate()
            begin

            end;
        }
        field(104; "KRA Pin(New)"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(105; "Picture(New Value1)"; Media)
        {
        }
        //"Date Of Birth"
        field(106; "Date Of Birth"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(107; Gender; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;

            trigger OnValidate()
            begin
            end;
        }
        //"SMS Notification (New)"
        field(108; "SMS Notification (New)"; Boolean)
        {


            trigger OnValidate()
            begin
            end;
        }
        field(109; "Phone No(New Value)"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(113; "Phone No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin


        if No = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Change Request No");
            NoSeriesMgt.InitSeries(SalesSetup."Change Request No", xRec."No. Series", 0D, No, "No. Series");
        end;

        "Captured by" := UserId;
        "Capture Date" := Today;
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        vend: Record Vendor;
        Memb: Record Customer;
        //  MemberCell: Record "Hexa Binary";
        MediaId: Guid;
}

