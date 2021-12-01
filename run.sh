#!/usr/bin/env bash
vim -u run.vim -X -N --noplugin -i NONE -E -s -c "call Run(\"$*\")" -c "q!"
