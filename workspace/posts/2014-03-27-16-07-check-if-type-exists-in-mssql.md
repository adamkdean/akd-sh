---

    IF TYPE_ID(N'[dbo].[udt_SomeCustomType]') IS NOT NULL
    BEGIN
        -- type exists, do something here
    END

And of course, the other way round:

    IF TYPE_ID(N'[dbo].[udt_SomeCustomType]') IS NULL
    BEGIN
        -- type does not exist, do something here
    END

More SQL snippets to come.