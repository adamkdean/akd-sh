---

On Linux, you can do this with `dd` like so, creating a 100 MB file (or thereabouts):

    dd if=/dev/zero of=output.png bs=1M count=100

On Windows servers, you can do this using `fsutil`, like so:

    fsutil file createnew output.png 104857600

Remember, 1024 bytes in a kilobyte, 1024*1024 bytes in a megabyte, and so forth.