# Developing on dfm

Information on developing `dfm`.

## dfm is written in perl

`dfm` is written in perl for a few reasons:

* perl 5.8.x (at least) is installed by default on every UNIX-like system.
* Perl is great at this sort of thing
* I use perl at my day job

Also, `dfm` doesn't use any modules other than those that ship with perl 5.8.x.  This chief constraint means that `dfm` can run on any system without needing to first install dozens of modules.  CPAN is a great resource for sharing reusable bundles of code, but not for this application. Having no other dependencies than what is core means that getting up and running on a new system requires two things: `git` and `dfm`.

## Tests

Tests for `dfm` are in the `t` subdirectory.  These are rather simple right now, but eventually they will test all `dfm` functionality.

It's OK to use CPAN modules in tests as it is understood that developing `dfm` usually only happens on one or two machines.
