read day07_input

" Part 1
exe "%s/,/\<cr>/g"
%sort n

" Save this for later so we don't have to sort again
let g:max = str2nr(getline('$'))

let medl = line('$') / 2
exe medl .. "yank a"
exe medl .. ",$s/\\d\\+/\\=submatch(0) - @a/"
exe "1," .. (medl - 1) .. "s/\\v(\\d+)/\\=@a - submatch(1)/"
%yank s
call Print("part 1 " .. eval(substitute(trim(@s), "\n", "+", "g")))

" Part 2
%delete
read day07_input
exe "%s/,/\<cr>/g"

" Brute force, not proud of this
let g:min_fuel = v:numbermax

function! Fuel(num)
    let sum = 0
    %s!\d\+!\=submatch(0) + execute("let sum += " .. ((abs(a:num - submatch(0)) * (abs(a:num - submatch(0)) + 1)) / 2))!g
    %yank s
    if sum < g:min_fuel
        let g:min_fuel = sum
    endif
endfunction

for i in range(g:max + 1)
    call Fuel(i)
endfor

call Print("part 2: " .. g:min_fuel)

