pageextension 51018 BankAccountListExt extends "Bank Account List"
{
    layout
    {
        modify(Contact)
        {
            Visible = false;
        }

        modify("Currency Code")
        {
            Visible = true;
        }

        moveafter(Name; "Currency Code")
    }
}
