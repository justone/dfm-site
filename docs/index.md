# dfm, the dotfiles manager

dfm is a small utility that manages dotfiles.  It:

- makes it easy to install (and uninstall) your dotfiles on new servers
- easys fetching and merging changes that were pushed from other machines
- simplifies working with your dotfiles repository, no matter where you are

# Quick start

First, fork [this repo](http://github.com/justone/dotfiles).

Then, add your dotfiles:

```console
$ git clone git@github.com:username/dotfiles.git
$ cd dotfiles
$  # edit files
$  # edit files
$ git push origin master
```

Finally, to install your dotfiles onto a new system:

```console
$ cd $HOME
$ git clone git@github.com:username/dotfiles.git .dotfiles
$ ./.dotfiles/bin/dfm install # creates symlinks to install files
```

To add new dotfiles:

```console
$ dfm import .tmux.conf
$ dfm push origin master
```

To update your dotfiles:

```console
$ dfm updates
... shortlog of updates
$ dfm mi
... changes merged in and install run again
```

Or, to do the above in one step:

```console
$ dfm umi
... shortlog of updates
... changes merged in and install run again
```

# More information

[Full documentation](documentation.md)
