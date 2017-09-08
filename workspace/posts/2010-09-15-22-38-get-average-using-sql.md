---

Todays snippet is quite cool, I was inspired by this post:
http://www.dreamincode.net/forums/topic/190437-floating-point-division/

Basically, you return the average by counting up the price of every item in a table, then divide it by the number of rows in said table. All in SQL.

    SELECT (SELECT SUM(Price) FROM t_Items) /
        (SELECT COUNT(*) FROM t_Items)
            AS Expr1

Enjoy!