#!/bin/sh

rsync -avze 'ssh -p 22' site/ endot.org@endot.org:~/domains/dfm.endot.org/html/
