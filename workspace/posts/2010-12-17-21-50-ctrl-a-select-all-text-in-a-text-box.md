---

    private void txtInput_KeyDown(object sender, KeyEventArgs e)
    {
        if (e.Control && e.KeyCode == Keys.A)
        {
            txtInput.SelectAll();
            e.Handled = true;
            e.SuppressKeyPress = true;
        }
    }

And there you have it. Enjoy