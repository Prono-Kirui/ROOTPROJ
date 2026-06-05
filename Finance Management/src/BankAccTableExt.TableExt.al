// tableextension 51003 BankAccTableExt extends "Bank Account"
// {
//     fields
//     {
//         field(51000; "Bank Type"; Enum "Bank Type")
//         {
//             Caption = 'Bank Type';
//             DataClassification = CustomerContent;
//         }
//         field(51001; "Cashier User ID"; Code[50])
//         {
//             Caption = 'Cashier User ID';
//             DataClassification = CustomerContent;
//             TableRelation = "User Setup";
//         }
//         field(51002; "Sort Code"; Code[50])
//         {
//             Caption = 'Sort Code';
//             DataClassification = CustomerContent;
//         }
//         field(51003; "Check Bank Limit"; Boolean)
//         {
//             Caption = 'Check Bank Limit';
//             DataClassification = CustomerContent;
//         }
//         field(51004; "Bank Limit (LCY)"; Decimal)
//         {
//             Caption = 'Bank Limit (LCY)';
//             DataClassification = CustomerContent;
//         }
//         field(51005; "Payment Document Nos"; Code[20])
//         {
//             Caption = 'Payment Document Nos';
//             DataClassification = CustomerContent;
//             TableRelation = "No. Series".Code;
//         }
//     }
// }
