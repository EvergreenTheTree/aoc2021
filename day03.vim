read day03_input

function! ColCount(col, char)
    redir => c
    execute "silent %s/\\%" .. a:col .. "c" .. a:char .. "//ne"
    redir END
    return str2nr(matchstr(c, '\d\+'))
endfunction

" Part 1
let gamma = ""
let epsilon = ""
for i in range(1, 12)
    let zerocount = ColCount(i, "0")
    let onecount = ColCount(i, "1")
    let gamma .= (zerocount < onecount) ? "1" : "0"
    let epsilon .= (zerocount > onecount) ? "1" : "0"
endfor
call Print("part 1: " .. str2nr(gamma, 2) * str2nr(epsilon, 2))

" Part 2
let i = 1
while line('$') > 1
    let zerocount = ColCount(i, "0")
    let onecount = ColCount(i, "1")
    let char = (zerocount <= onecount) ? "1" : "0"
    execute "%v/\\%" .. i .. "c" .. char .. "/d"
    let i += 1
endwhile
let o = getline(1)

%delete
read day03_input

let i = 1
while line('$') > 1
    let zerocount = ColCount(i, "0")
    let onecount = ColCount(i, "1")
    let char = (zerocount <= onecount) ? "0" : "1"
    execute "%v/\\%" .. i .. "c" .. char .. "/d"
    let i += 1
endwhile
let co2 = getline(1)

call Print("part 2: " .. str2nr(o, 2) * str2nr(co2, 2))

