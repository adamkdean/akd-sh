---
title: Mount Docker volume locally
slug: mount-docker-volume-locally
date: 2018-08-01 15:24
---

Here is something that's cool.

You can have a docker volume, `docker volume create example`, and you can mount this volume to a container, `docker run -v example:/path image`. You can also mount local directories to containers, `docker run -v $(pwd)/local:/path image`. But something you can't do, is mount a local directory to volume.

Scenario: you have a volume, you have a container using that volume, and you have some software that needs to access that volume data locally, outside of docker.

🚫`docker run -v $(pwd)/local:example image` isn't going to work.

Nor can you mount two things to the same place.

🚫`docker run -v example:/example -v $(pwd)/local:/example image` isn't going to work either.

The solution is to use intermediate symlinked container.

I call this solution "Arthur's Backdoor". (Created for [AM](https://twitter.com/ArthurMingard))

```
#
# Arthur's backdoor
#
FROM busybox
RUN mkdir /volume
RUN ln -s /local /volume
CMD ["/bin/sh"]
```

In this dockerfile you can see that we create a directory (later to be used as a mount point), and then we create a symlink directory pointing to the same place.

```
$ docker build -t arthurs-backdoor .
$ docker volume create my_precious_data
$ docker run -d -v my_precious_data:/volume -v $(pwd)/my_precious_data:/local arthurs_backdoor
```

We create a volume `my_precious_data`, then we run the backdoor, first mounting the volume `my_precious_data` to the container path `/volume`, and then mounting the local directory `$(pwd)/my_precious_data` to the container path `/local` which as we saw, is actually `/volume`.

Now you have mounted a docker volume to your local filesystem.
