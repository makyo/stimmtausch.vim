" vimmtausch - a vim plugin for Stimmtausch
" Home:https://github.com/makyo/vimmtausch
" by Madison Scott-Clary
"
" Stimmtausch is a client for connecting to MU*s, and since it uses FIFOs to
" do so, it's easy enough to interact with vim, thus this plugin.
"
" For more on Stimmtausch, see <https://stimmtausch.org>
"
" vim: et ts=4 sts=4 sw=4

function! StimmtauschWorld()
    " Messages the current world.
    if exists('s:name')
        echom 'Current world is: ' | echohl Directory | echom s:name | echohl None
    else
        echohl ErrorMsg | echom 'No world set! use <Leader># to set.' | echohl None
    endif
endfunction

function! StimmtauschSendLine()
    " Sends the current line to the connection.
    if exists('s:in')
        let l:infile = expand(s:in)
        execute '.w >> '.l:infile
        if has_key(g:stimmtausch, 'clear_on_send')
            normal ggdGi
        else
            normal o
        endif
        startinsert
    else
        echohl ErrorMsg | echom 'No world set! use <Leader># to set.' | echohl None
    endif
endfunction

function! StimmtauschSendSelection()
    " Sends the current selection to the connection.
    if exists('s:in')
        let l:infile = expand(s:in)
        execute "'<,'>w >> ".l:infile
        if has_key(g:stimmtausch, 'clear_on_send')
            normal ggdGi
        else
            normal Go
        endif
        startinsert
    else
        echohl ErrorMsg | echom 'No world set! use <Leader># to set.' | echohl None
    endif
endfunction

function! StimmtauschSetWorld(world)
    " Sets the world based in its 1-index in the config list
    let s:world = g:stimmtausch['worlds'][a:world]
    let s:name  = s:world['name']
    let s:out   = s:world['dir'].'/out'
    let s:in    = s:world['dir'].'/in'
    call StimmtauschWorld()
endfunction

function! s:StimmtauschSetup()
    " Settings
    set nonumber nospell nolist
    set wrap linebreak
    " Interferes with clicking links in other tmux panes.
    set mouse=n
    set syntax=stimmtausch ft=stimmtausch
    let l:break = '⮨'
    if has_key(g:stimmtausch, 'break_symbol')
        let l:break = g:stimmtausch['break_symbol']
    endif
    if has_key(g:stimmtausch, 'break_symbol') || has_key(g:stimmtausch, 'showbreak')
        set showbreak=l:break
    endif

    " Mappings
    imap <CR> <ESC>:call StimmtauschSendLine()<CR>
    vmap <CR> <ESC>:call StimmtauschSendSelection()<CR>
    imap <silent> <S-CR> <ESC>o
    let l:num = 1
    for world in g:stimmtausch['worlds']
        let l:idx = l:num - 1
        execute 'nmap <silent> <Leader>'.l:num.' :call StimmtauschSetWorld('.l:idx.')<CR>'
        let l:num += 1
    endfor
endfunction

function! g:Stimmtausch()
    " Star the whole thing. Consider mapping to <Leader>st
    if !exists('g:stimmtausch') || !has_key(g:stimmtausch, 'worlds')
        echohl ErrorMsg
        echom "You haven't set up g:stimmtausch yet!"
        echohl None
    else
        call s:StimmtauschSetup()
    endif
endfunction
