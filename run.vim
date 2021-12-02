#!/usr/bin/env bash
"true"; _SILENT=""; _QUIT=""; [[ -z $DEBUG ]] && _SILENT="-s" && _QUIT='-c q!'
"vim" -u $0 -X -N --noplugin -i NONE -E $_SILENT -c "call Main(\"$*\")" $_QUIT
"exit"

" This script can execute in both vim and bash. The bash part sets up vim so
" that it can execute vim scripts as though it were a headless interpreter.
" This is unbelievably cursed and I do not take any responsibility for what it
" might do if you run it.

" One unfortunate side effect of this setup is that error messages regarding
" vimscript get swallowed up. Set the DEBUG environment variable if you want to
" see them and type q!<Enter> to exit.

set noreadonly

let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')

function! Print(str)
    let str = a:str
    if type(a:str) != v:t_string
        let str = string(a:str)
    endif
    call writefile([str], "/dev/stdout", "s")
endfunction

function! ScriptFn(day)
    return "day" .. a:day .. ".vim"
endfunction

function! Start(day) abort
    let url = "https://adventofcode.com/2021/day/" .. str2nr(a:day) .. "/input"
    let input_file = "day" .. a:day .. "_input"
    let cookie = readfile(s:path .. "/session_cookie")[0]
    let script = ScriptFn(a:day)
    call system("curl " .. url .. " -H 'cookie: session=" .. cookie .. "' -o " .. input_file)
    if !filereadable(script)
        read template.vim
        execute "%s/dayxx/day" .. a:day .. "/g"
        execute "write " .. script
    endif
endfunction

function! Run(day) abort
    let script = ScriptFn(a:day)
    if filereadable(script)
        execute "source day" .. a:day .. ".vim"
    else
        call Print("ERROR: unable to read script " .. script)
        return
    endif
endfunction

function! Main(args) abort
    let argv = split(a:args, " ")
    let argc = len(argv)
    let start = v:false
    if argc > 2 || argc < 1
        call Print("usage: run.vim [-s] DAY")
        call Print("  -s   download input file and create vimscript file from template")
        call Print("  DAY  the day's code to run/start working on")
        return
    elseif argc == 2 && argv[0] ==# "-s"
        let start = v:true
    endif

    try
        let day = printf("%02d", argv[-1])
        if start
            call Start(day)
        else
            call Run(day)
        endif
    catch
        call Print("EXCEPTION: " .. v:exception)
        call Print("  in " .. v:throwpoint)
    endtry
endfunction
