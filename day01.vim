read day01

" Part 1
let g:count = 0 | %s/\v\ze^(\d+)\n(\d+)/\=execute("let g:count += " . (str2nr(submatch(1)) < str2nr(submatch(2))))/

" Part 2
let g:threecount = 0 | %s/\v\ze^(\d+)\n(\d+)\n(\d+)\n(\d+)\n/\=execute("let g:threecount += " . (submatch(1) + submatch(2) + submatch(3) < submatch(2) + submatch(3) + submatch(4)))/

call Print(printf("part 1: %d", g:count))
call Print(printf("part 2: %d", g:threecount))
