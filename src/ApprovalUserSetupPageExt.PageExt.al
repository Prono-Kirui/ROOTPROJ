// pageextension 50013 "ApprovalUserSetupPageExt" extends "Approval User Setup"
// {
//     layout
//     {
//     }

//     actions
//     {
//         addlast(Navigation)
//         {
//             action("User Signature")
//             {
//                 Promoted = true;
//                 PromotedIsBig = true;
//                 Image = Signature;
//                 RunObject = page "User Signatures";
//                 RunPageLink = "User ID" = field("User ID");
//                 ApplicationArea = All;
//                 ToolTip = 'Executes the User Signature action';
//             }
//         }
//     }
// }





