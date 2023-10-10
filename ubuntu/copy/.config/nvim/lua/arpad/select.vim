let g:state = 0

function! ExpandSelection()
    let l:line = getline('.')
    let l:start = col("'<")
    let l:end = col("'>")
    let l:cursor_pos = getpos(".")

    " Reset to State 1 if selection is entire line
    if l:start == 1 && l:end == len(l:line) + 1
        let g:state = 0
    endif

    if g:state == 0
        " Look for the nearest and smallest group around and select it
        let patterns = ['va(', 'va[', 'va{', 'va<', 'va"', "va'"]
        let min_start = l:start
        let min_end = l:end
        for pat in patterns
            call setpos('.', l:cursor_pos)  " Reset cursor position before each search
            let [s, e] = SearchAndSelect(pat)
            if s > 0 && e > 0 && (e - s < min_end - min_start)
                let min_start = s
                let min_end = e
            endif
        endfor
        if min_start != l:start || min_end != l:end
            execute 'normal! ' . min_start . '|v' . min_end . '|'
            let g:state = 1
            return
        endif
    elseif g:state == 1
        " if l:start > 1 && l:end <= len(l:line) && (l:line[l:start-2] =~ '\s' || l:line[l:end] =~ '\s')
        "     " If whitespace before/after group, select until it in both directions
        "     normal! ?[^[:space:]]\zs[[:space:]]\+<CR>v/\ze[[:space:]]\+[[:alnum:]]<CR>
        " else
        "     " If group character pair immediately around selection, select them and all non-whitespace surrounding them
        let patterns = ['va(', 'va[', 'va{', 'va<', 'va"', "va'"]
        let min_start = l:start
        let min_end = l:end
        for pat in patterns
            call setpos('.', l:cursor_pos)  " Reset cursor position before each search
            let [s, e] = SearchAndSelect(pat)
            if s > 0 && e > 0 && (e - s < min_end - min_start)
                let min_start = s
                let min_end = e
            endif
        endfor
        if min_start != l:start || min_end != l:end
            execute 'normal! ' . min_start . '|v' . min_end . '|'
            let g:state = 0
            return
        endif
        " endif
    endif
endfunction

function! SearchAndSelect(pattern)
    " Store the current visual selection
    let save_reg = @"
    silent! normal! gvy
    let temp = @"
    let start = 0
    let end = 0
    try
        execute 'normal! ' . a:pattern
        let start = col("'<")
        let end = col("'>")
    catch
    endtry
    " Restore the visual selection
    let @" = temp
    silent! normal! gv
    return [start, end]
endfunction

xnoremap <silent> <leader><leader> :<C-u>call ExpandSelection()<CR>
