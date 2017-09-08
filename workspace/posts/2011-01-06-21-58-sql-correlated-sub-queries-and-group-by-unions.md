---

So this part I'm working on now gets a list of hosts whose last record (latency check) is past a frequency threshold. The current SQL is great, it checks from a view whether the last date is past the threshold but I realised one small problem.. it doesn't get new hosts who have zero records. It will only work for previously checked hosts!

    SELECT HostId, MAX(Hostname) AS Hostname, MAX(CheckDate) AS CheckDate, MAX(Frequency) AS Frequency
    FROM vw_HostRecords
    GROUP BY HostId
    HAVING (DATEADD(minute, MAX(Frequency), MAX(CheckDate)) < GETDATE())

And so I had to again improve my SQL, onto correlated sub-queries. It is actually quite simple it just sounds clever but shh.. here is the SQL to check if a row exists in the records and if it doesn't, it selects that row from the hosts. Basically it gets all the new ones for me.

    SELECT Id AS HostId, Hostname, Frequency
    FROM t_Hosts
    WHERE (
       Id NOT IN (
          SELECT HostId
          FROM t_Records
          WHERE (HostId IS NOT NULL)
       )
    )

So now I need to mix these using a union, and adding in CheckDate = NULL so that the UNION works (as to use that, both selects must have the same fields/columns).. and we end up with this lovely piece of work:

    SELECT HostId, MAX(Hostname) AS Hostname, MAX(Frequency) AS Frequency, MAX(CheckDate) AS CheckDate
    FROM vw_HostRecords
    GROUP BY HostId
    HAVING (DATEADD(minute, MAX(Frequency), MAX(CheckDate)) < GETDATE())
    UNION
    SELECT Id AS HostId, Hostname, Frequency, NULL AS CheckDate
    FROM t_Hosts
    WHERE (
       Id NOT IN (
          SELECT HostId
          FROM t_Records
          WHERE (HostId IS NOT NULL)
       )
    )

Awesome, no?

Edit: Had to fix a bug, it seems you also have to get all the fields in the right order as well, as SQL will not mix and match for you!

So: select a, b, c from table_a union select a, b, c from union_b etc!

Edit 2: Removed OR from having line