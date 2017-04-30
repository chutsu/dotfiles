set path=.,**
set tabstop=2 shiftwidth=2 softtabstop=2

if !exists('*CSwitch')
    function! CSwitch()
        let fext = expand('%:e')
        if fext == "h"
            find %:t:r.c
        else
            find %:t:r.h
        endif
    endfunction
endif

" nmap <F7> :vsplit <bar> call CSwitch()<CR>
" nmap <F8> :call CSwitch()<CR>
" nmap <F9> :set splitright <bar> vsplit <bar> call CSwitch()<CR>
