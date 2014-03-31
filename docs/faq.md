# Why `.bashrc.load` instead of `.bashrc`?

Each OS or distribution generally has its own way of populating a default `.bashrc` in each new user's home directory.  This file works with the rest of the OS to load in special things like bash completion scripts or aliases.  The idea behind using `.bashrc.load` is that dotfiles should add new things to a system rather than overwriting built-in funcitonality.

For instance, if a system sources bash completion files for you, and your dotfiles overwrites the system-provided `.bashrc`, then you would have to replicate that functionality on your own.

If you don't want to use this behavior, all you need to do is run `dfm mv .bashrc.load .bashrc`, and dfm will happily remove the system-provided `.bashrc` and symlink yours in.  Or, if you want to use your own .bashrc, just make sure that `$HOME/bin` is in the $PATH or you won't be able to run dfm directly.
