---

    $ ps aux | grep -c adam
    93

But if we use wc, we would also need to trim it:

    $ ps aux | grep adam | wc -l
            94

So, use -c.