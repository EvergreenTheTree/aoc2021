read day06_input

exe "%s/,/\<cr>/g"
%sort n
let @a = "y$VG?\<c-r>=@\"\<cr>\<cr>:\<c-u>let @b = line(\"'>\") - line(\"'<'\") + 1\<cr>gvc\<c-r>=@b\<cr>\<esc>j"
exe "normal! Go\<esc>gg5@aggO0\<esc>Gdd3o0"

" Part 1
let @r = "gg\"addG\"ap7Gcc\<c-r>=@\" + @a\<cr>\<esc>"
normal 80@r

%yank s
call Print("part 1: " .. eval(substitute(trim(@s), "\n", "+", "g")))

" Part 2
normal 176@r

%yank s
call Print("part 2: " .. eval(substitute(trim(@s), "\n", "+", "g")))
