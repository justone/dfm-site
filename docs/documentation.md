# Full Documentation

## Tour of files

Besides the `README.md` and `.gitignore`, there are four files/directories in the base branch.

* `bin/dfm` - The main utility for managing (installing/updating/uploading) dotfiles.
* `.dfminstall` - This is a config file for when `dfm install` is run.
* `.bashrc.load` - This file is the bootstrap file for loading any shell customizations.  The default only makes sure `$HOME/bin` is in the path so that `dfm` can be run easily.  This file is loaded because `dfm` puts the following line at the end of `.bashrc` on install: `. $HOME/.bashrc.load`
* `t` - Tests for the `dfm` utility.

## The 'dfm' utility

`dfm` stands for **D**ot **F**ile **M**anager.  The name was chosen because the best commands (like `svn` or `git`) are only three characters.

Running `dfm` is like running `git`.  There are subcommands, like `install` and `updates` that perform different functions.  Each subcommand has it's own set of options and there are also options that apply to all subcommands.

## Installing dotfiles

The main reason for `dfm` to exist is to install dotfiles.  This is done with the `install` subcommand.  Running `dfm install` will go through all the files and directories in the repository and install them in `$HOME` using symlinks.

### Skipping

You can control what files are skipped by adding `.dfminstall` files in your repository.  For instance, the [[default .dfminstall|http://github.com/justone/dotfiles/blob/master/.dfminstall]] file has the following contents:

```sh
README.md skip
CHANGELOG.md skip
t skip
```
Meaning that `README.md` and `CHANGELONG.md` and `t` will be skipped when running `dfm install`.

### Recursing

You can make `dfm install` recurse into a given directory by adding its name to the `.dfminstall` file.  For instance, the [[this .dfminstall file|http://github.com/justone/dotfiles/blob/personal/.dfminstall]] has the following contents:

```sh
.ssh recurse
README.md skip
t skip
```

Meaning that (in addition to the above skips) instead of making `~/.ssh` a symlink to `~/.dotfiles/.ssh`, the `~/.ssh` directory is left alone and files inside of `~/.dotfiles/.ssh` are symlinked into `~/.ssh`.  Put another way, it turns this:

```console
nate@host$ ls -al ~/.ssh
lrwxr-xr-x  1 nate  staff  31 Sep 14 11:25 /Users/nate/.ssh -> .dotfiles/.ssh
```

into this:

```console
nate@host$ ls -al ~/.ssh
total 240
drwxr-xr-x  12 nate  staff    408 Oct 14 16:50 .
drwxr-xr-x+ 82 nate  staff   2788 Oct 15 23:43 ..
drwxr-xr-x   5 nate  staff    170 Sep 14 11:25 .backup
lrwxr-xr-x   1 nate  staff     33 Sep 14 11:25 config -> ../.dotfiles/.ssh/config
-rw-------   1 nate  staff    1234 Aug 12  2010 id_dsa
-rw-r--r--   1 nate  staff    1234 Aug 12  2010 id_dsa.pub
-rw-r--r--   1 nate  staff  88264 Oct 13 14:55 known_hosts
```

Very handy for managing files inside directories that are extra volatile or that you just want to leave alone.

### Executing scripts

You can make `dfm install` execute a script by adding its name to the `.dfminstall` file and appending the 'exec' option.  For instance, given the following `.dfminstall` file:

```sh
setup.sh exec
```

When `dfm install` is run, the setup.sh script will be run after files at that level have been symlinked.

This is useful for manually differentiating one environment from another at install time rather than relying on something that can be detected.

You can combine this with the `skip` option so that the set up script doesn't get symlinked into the home directory.  If that is desired, the `skip` option should appear on its own line.  For example, to augment the above example to not symlink the `setup.sh` script:

```sh
setup.sh exec
setup.sh skip
```

### Fixing permissions

You can make `dfm install` change the permissions on a file by adding its name to the `.dfminstall` file and appending the 'chmod' option and a mode.  For instance, given the following `.dfminstall` file:

```sh
.ssh/config chmod 0600
```

When `dfm install` is run, the `.ssh/config` file will have its mode set to `0600`.

## Importing files

Adding new dotfiles to your repository can be a little tricky.  Here are the commands that need to be run:

```sh
$ cp .vimrc .dotfiles
$ dfm install
$ dfm add .vimrc
$ dfm ci -m 'adding .vimrc'
```

There is an `import` subcommand that accomplishes all of this:

```sh
$ dfm import .vimrc
INFO: Importing .vimrc from /home/user into /home/user/.dotfiles
INFO:   Symlinking .vimrc (.dotfiles/.vimrc).
INFO: Committing with message 'importing .vimrc'
[personal 8dbf30d] importing .vimrc
 1 file changed, 46 insertions(+)
 create mode 100644 .vimrc
```

## All subcommands

Here are the subcommands that are currently defined:

* `install` - this installs everything in the repo into `$HOME` using symlinks
* `import` - this adds a file (or directory) to the repo, symlinks it, and then does a commit.
* `uninstall` - the reverse of `install`, this removes symlinks in `$HOME` that point into the dotfiles repository
* `updates` - this fetches any new changes from the `origin` remote
* `mergeandinstall` or `mi` - this merges any new changes and re-runs `dfm install`
* `updatemergeandinstall` or `umi` - this does the above two commands (`updates` and `mergeandinstall`) in one
* anything else is interpreted as a git subcommand and in run in the dotfiles repository.  For instance, running `dfm status` is the same as running `cd ~/.dotfiles; git status; cd -`, but easier.

For more information, run `dfm --help` or `perldoc ~bin/dfm`.
