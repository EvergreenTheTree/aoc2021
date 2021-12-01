e day01

" Part 1
let g:count = 0 | %s/\v\ze^(\d+)\n(\d+)/\=execute("let g:count += " . (str2nr(submatch(1)) < str2nr(submatch(2))))/ | echo g:count
" Part 2
let g:count = 0 | %s/\v\ze^(\d+)\n(\d+)\n(\d+)\n(\d+)\n/\=execute("let g:count += " . (submatch(1) + submatch(2) + submatch(3) < submatch(2) + submatch(3) + submatch(4)))/ | echo g:count
