set noreadonly

function! Run(args)
    let argv = split(a:args, " ")
    let day = printf("%02d", argv[-1])
    execute "source day" . day . ".vim"
endfunction

function! Print(str)
    call writefile([a:str], "/dev/stdout")
endfunction
