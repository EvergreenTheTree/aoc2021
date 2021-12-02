read day02_input

" Part 1
let g:forward = 0
let g:up = 0
let g:down = 0
%s/\v\zeforward (\d+)/\=execute("let g:forward += " . submatch(1))/
%s/\v\zeup (\d+)/\=execute("let g:up += " . submatch(1))/
%s/\v\zedown (\d+)/\=execute("let g:down += " . submatch(1))/
call Print("part 1: " . string(g:forward * (g:down - g:up)))

" Part 2
let g:aim = 0
let g:horizontal = 0
let g:depth = 0
function! AccumulatePos()
    if submatch(1) ==# "forward"
        let g:horizontal += submatch(2)
        let g:depth += g:aim * submatch(2)
    elseif submatch(1) ==# "up"
        let g:aim -= submatch(2)
    elseif submatch(1) ==# "down"
        let g:aim += submatch(2)
    endif
endfunction
%s/\v\ze(\w+) (\d+)/\=AccumulatePos()/
call Print("part 2: " . string(g:horizontal * g:depth))
