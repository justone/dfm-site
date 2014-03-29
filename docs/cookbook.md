Here are some sample `dfm` sessions that accomplish certain tasks.

## Changing a file

```console
nate@host:~$ dfm st                                     [1]
# On branch personal
nothing to commit (working directory clean)
nate@host:~$ vi .vimrc                                  [2]
nate@host:~$ dfm di                                     [3]
diff --git a/.vimrc b/.vimrc
index aee9939..1bfb368 100644
--- a/.vimrc
+++ b/.vimrc
@@ -3,6 +3,7 @@ set ai to shell=/bin/bash terse nowarn sm ruler redraw sw=4 ts=4
 "set noremap
 set hls
 set bs=2
+set history=100
 set bg=dark
 set showmode
 set incsearch
nate@host:~$ dfm ci -am 'bumping vim command history up to 100'  [4]
[personal bacdf4a] bumping vim command history up to 100
 1 files changed, 1 insertions(+), 0 deletions(-)
nate@host:~$ dfm push origin personal                   [5]
Counting objects: 5, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 316 bytes, done.
Total 3 (delta 2), reused 0 (delta 0)
To endot.org@endot.org:dotfiles.git
   6900bbc..bacdf4a  personal -> personal
nate@host:~$ dfm st                                     [6]
# On branch personal
nothing to commit (working directory clean)
```

1. clean start
2. edit .vimrc
3. difference shows added history setting
4. committing
5. push to origin
6. clean end

## Fetching updates and merging them onto a different system

```console
nate@host2:~$ dfm st                                    [1]
# On branch personal
nothing to commit (working directory clean)
nate@host2:~$ grep history .vimrc                       [2]
nate@host2:~$ dfm updates                               [3]
remote: Counting objects: 11, done.
remote: Compressing objects: 100% (6/6), done.
remote: Total 6 (delta 3), reused 0 (delta 0)
Unpacking objects: 100% (6/6), done.
From file:///home/54/users/.home/dotfiles
   95bd67a..fea0273  master     -> origin/master
   6900bbc..bacdf4a  personal   -> origin/personal
bacdf4a: bumping vim command history up to 100
nate@host2:~$ dfm updates --no-fetch                    [4]
bacdf4a: bumping vim command history up to 100
nate@host2:~$ dfm mi                                    [5]
INFO: using merge to bring in changes
Updating 6900bbc..bacdf4a
Fast forward
 .vimrc |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
INFO: re-installing dotfiles
INFO: Installing dotfiles...
nate@host2:~$ grep history .vimrc                       [6]
set history=100
nate@host2:~$ dfm st                                    [7]
# On branch personal
nothing to commit (working directory clean)
```

1. clean start
2. no history setting in .vimrc
3. fetching upstream changes, note last line shows what's new
4. running without fetching, just to show what's new
5. merge and install the new changes
6. history setting is there now
7. clean end

## Updating dfm itself

```console
nate@host:~$ dfm remote add upstream git://github.com/justone/dotfiles.git    [1]
nate@host:~$ dfm checkout master                                              [2]
nate@host:~$ dfm fetch upstream                                               [3]
nate@host:~$ dfm merge upstream/master                                        [4]
```

1. add upstream (only needs to be done once)
2. check out the branch to merge into
3. fetch changes
4. merge in changes
