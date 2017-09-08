---

Let us say we want to scan for open ports from 1 to 1000, we can do that like so:

    nc -n -z -w 1 192.168.1.2 1-1000

`-n` prevents DNS lookup. `-z` will prevent Netcat from receiving any data. `-w 1` sets the timeout to 1 second.

You can also use `-v` to make it verbose, but this will obscure the visibility of successful attempts, which running it without shows.

An example output for the above command is:

> Connection to 192.168.1.2 80 port [tcp/*] succeeded!  
> Connection to 192.168.1.2 427 port [tcp/*] succeeded!  
> Connection to 192.168.1.2 515 port [tcp/*] succeeded!  

So useful!