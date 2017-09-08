---

Are things ever that simple? MSSQL decided to tell me that because one field had a foreign key (FK) to the primary key (PK), the other field couldn't also have an FK to the PK, and that's not okay (OK). That's !OK .. 

Luckily, SQL has things called triggers, and they're actually pretty useful. The below SQL creates a trigger that deletes any rows from the second table, that have the same id as the row being deleted from the first table:

    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
    -- ==============================================
    -- Author: Adam K Dean
    -- Website: http://imdsm.blogspot.com/
    -- Create date: 12/09/10
    -- Description: Deletes relationships on deletion
    -- of row in the main database. Replaces the need
    -- for two foreign keys on the same primary key
    -- which is unfortunately impossible.
    -- ==============================================
    ALTER TRIGGER DeleteRelationships ON t_Sites AFTER DELETE
    AS
    BEGIN
      
     DELETE FROM t_Relationships 
     WHERE ReferrerId IN (SELECT Id FROM Deleted)
      OR TargetId IN (SELECT Id FROM Deleted)
     
    END
    GO

Somehow I managed to make this work, finding snippets and testing them, because lets face it, the SQL examples have so many options it's like a wall of text has just hit you at 150 pages per second, not really as easy to use as looking at some chinese hackers code and picking out the bits you need.

It seems the `Deleted` object refers to the deleted row, and well the rest is pretty simple.

Hope this helps you, or future me, if you're suffering the same Jeremy SQ-yle problems as I was!