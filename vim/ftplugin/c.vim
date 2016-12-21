set path=.,**
set tabstop=4 shiftwidth=4 softtabstop=4

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

nmap <F8> :call CSwitch()<CR>
nmap <F9> :vsplit call CSwitch()<CR>
