---

I am currently writing a util to extract email addresses from a customer database and generate the SQL to insert them into our mailing list database. Rather than risk having two email addresses and therefore maybe spamming a customer, I wanted the get some SQL that would first check if the email existed within the database, and if not, then insert it.

After lots of horribly small examples SQL and about 45 Googles, I finally came up with some working code! Below you will see that I first check if a select statement does not exist. And then if it doesn't, I run the insert code. Nice and simple, yeah ...once it's done and working..

    IF NOT EXISTS (SELECT EmailAddress FROM t_MailingList
     WHERE EmailAddress = 'test') 
    BEGIN
     INSERT INTO t_MailingList
     (EmailAddress, AcceptsPostal, AcceptsEmail)
     VALUES ('test', 0, 1) 
    END

P.S, if you get the compound errors like I did, then I suggest either 1) asking an experienced sqler, 2) keeping calm or my preferred method 3) a hammer. Enjoy!