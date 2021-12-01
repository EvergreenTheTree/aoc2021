#!/usr/bin/env bash
"true"; _SILENT=""; _QUIT=""; [[ -z $DEBUG ]] && _SILENT="-s" && _QUIT='-c q!'
"vim" -u $0 -X -N --noplugin -i NONE -E $_SILENT -c "call Run(\"$*\")" $_QUIT
"exit"

" This script can execute in both vim and bash. The bash part sets up vim so
" that it can execute vim scripts as though it were a headless interpreter.
" This is unbelievably cursed and I do not take any responsibility for what it
" might do if you run it.

" One unfortunate side effect of this setup is that error messages regarding
" vimscript get swallowed up. Set the DEBUG environment variable if you want to
" see them and type q!<Enter> to exit.

set noreadonly

function! Print(str)
    let str = a:str
    if type(a:str) != v:t_string
        let str = string(a:str)
    endif
    call writefile([str], "/dev/stdout", "s")
endfunction

function! Run(args)
    let argv = split(a:args, " ")
    if len(argv) != 1
        call Print("usage: run.vim DAY")
        return
    endif

    let day = printf("%02d", argv[-1])
    let script = "day" . day . ".vim"
    if filereadable(script)
        execute "source day" . day . ".vim"
    else
        call Print("ERROR: unable to read script " . script)
    endif
endfunction
