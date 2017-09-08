---

1. [Install Homebrew](http://adamkdean.co.uk/blog/read/138/install-homebrew-on-osx).
2. [Install VirtualBox](http://adamkdean.co.uk/blog/read/139/install-virtualbox-on-osx).
3. [Install Vagrant](http://adamkdean.co.uk/blog/read/140/install-vagrant-on-osx).

Now we can finally install Docker. We also need to install boot2docker.

    brew install docker
    brew install boot2docker
    boot2docker init
    boot2docker up
    export DOCKER_HOST=tcp://localhost:2375

And test it:

    docker version

Bear in mind that if boot2docker has a different port than 2375, use the correct one, and don't put a trailing slash either.