read day04_input

" Part 1
let g:won = v:false
let g:wonlines = {}

function! Win(call)
    call setpos('.', g:winpos)
    normal! {jV5j"ay
    exe "let sum = " .. substitute(substitute(trim(@a), "[ \n]", "+", "g"), "\\V++", "+", "g")
    normal! {
    let g:won = v:true
    if !has_key(g:wonlines, line('.'))
        let g:wonlines[line('.')] = v:true
        let g:last_win_sum = sum
        let g:last_win_call = str2nr(a:call)
    endif
endfunction

function! Check(call)
    let pos = getpos('.')

    normal! r0lr0h

    if match(getline('.'), "\\v^(\\_s*00\\_s*){5}") != -1
        let g:winpos = pos
        call Win(a:call)
        return "00"
    endif
    normal! {j
    exe "silent! normal! " .. pos[2] .. "|\<c-v>l4j\"ay"
    let col = substitute(@a, "\\n", "", "g")
    if match(col, "0000000000") != -1
        let g:winpos = pos
        call Win(a:call)
        return "00"
    endif

    call setpos('.', pos)
    return "00"
endfunction

let calls = split(getline(1), ",")
for call in calls
    if len(call) == 1 | let call = " " .. call | endif
    exe "3,$s/\\v" .. call .. ">/\\=Check(" .. trim(call) .. ")/g"
    if g:won
        call Print("part 1: " .. g:last_win_call * g:last_win_sum)
        break
    endif
endfor

" Part 2
%delete
read day04_input
let calls = split(getline(1), ",")
let g:wonlines = {}
for call in calls
    if len(call) == 1 | let call = " " .. call | endif
    exe "3,$s/\\v" .. call .. ">/\\=Check(" .. trim(call) .. ")/ge"
endfor
call Print("part 2: " .. g:last_win_call * g:last_win_sum)
