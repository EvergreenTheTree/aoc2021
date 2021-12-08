read day05_input

let g:map = []
for i in range(1000)
    call add(g:map, [])
    for j in range(1000)
        call add(g:map[i], 0)
    endfor
endfor

" Part 1
function! PopulateMap()
    let x1 = str2nr(submatch(1)) - 1
    let x2 = str2nr(submatch(3)) - 1
    let y1 = str2nr(submatch(2)) - 1
    let y2 = str2nr(submatch(4)) - 1

    if x1 == x2
        let miny = min([y1, y2])
        for i in range(abs(y2 - y1) + 1)
            let g:map[miny + i][x1] += 1
            if g:map[miny + i][x1] == 2 | let g:numoverlaps += 1 | endif
        endfor
    elseif y1 == y2
        let minx = min([x1, x2])
        for i in range(abs(x1 - x2) + 1)
            let g:map[y1][minx + i] += 1
            if g:map[y1][minx + i] == 2 | let g:numoverlaps += 1 | endif
        endfor
    endif

    return submatch(0)
endfunction

let g:numoverlaps = 0
%s/\v(\d+),(\d+) -\> (\d+),(\d+)/\=PopulateMap()/

call Print("part 1: " .. g:numoverlaps)

" Part 2
function! PopulateMapDiagonal()
    let x1 = str2nr(submatch(1)) - 1
    let x2 = str2nr(submatch(3)) - 1
    let y1 = str2nr(submatch(2)) - 1
    let y2 = str2nr(submatch(4)) - 1

    if abs(x2 - x1) == abs(y2 - y1)
        let x = x1
        let y = y1
        let xdir = x1 < x2 ? 1 : -1
        let ydir = y1 < y2 ? 1 : -1
        while y != y2 + ydir
            let g:map[y][x] += 1
            if g:map[y][x] == 2 | let g:numoverlaps += 1 | endif
            let x += xdir
            let y += ydir
        endwhile
    endif
endfunction

%s/\v(\d+),(\d+) -\> (\d+),(\d+)/\=PopulateMapDiagonal()/

call Print("part 2: " .. g:numoverlaps)

call delete("map")
for row in g:map
    call writefile([join(row, "")], "map", "a")
endfor
