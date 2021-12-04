read day04_input

" Part 1
let g:winpos = [0, 0, 0, 0]
let g:won = v:false
function! Check(call)
    if g:won | return | endif
    let pos = getpos('.')

    normal! gellr0lr0
    call setpos('.', pos)

    if match(getline('.'), "[1-9]") == -1
        let g:won = v:true
        let g:winpos = pos
        return
    endif
    normal! {j
    exe "silent! normal! " .. pos[2] .. "|\<c-v>l4j\"ay"
    if match(@a, "[1-9]") == -1
        let g:won = v:true
        let g:winpos = pos
        return
    endif
    call setpos('.', pos)
    return "00"
endfunction
let calls = split(getline(1), ",")
for call in calls
    if len(call) == 1 | let call = " " .. call | endif
    exe "3,$s/\\v" .. call .. ">/\\=Check(" .. trim(call) .. ")/g"
    if g:won
        call setpos('.', winpos)
        normal! {jV5j"ay
        exe "let sum = " .. substitute(substitute(trim(@a), "[ \n]", "+", "g"), "\\V++", "+", "g")
        call Print("part 1: " .. str2nr(call) * sum)
        break
    endif
endfor

" Part 2

