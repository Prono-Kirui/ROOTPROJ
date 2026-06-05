pageextension 51027 "Bank Acc. Rec. List Ext" extends "Bank Acc. Reconciliation List"
{
    actions
    {
        modify(Post)
        {
            Visible = false;
        }
        modify(PostAndPrint)
        {
            Visible = false;
        }
    }
}
