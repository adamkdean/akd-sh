---

I found this somewhere online:

    for t in `git tag`
    do
        git push origin :$t
        git tag -d $t
    done

Saved it to `removetags.sh`, ran it, and now my life (and log) is much happier.