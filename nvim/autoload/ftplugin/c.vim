function! ftplugin#c#SwitchFile()
  if expand('%:e') == 'h'
    find %:t:r.c
    return
  endif

  if expand('%:e') == 'c'
    find %:t:r.h
    return
  endif

  echo 'Error! Not a recognized file!'
endfunction
