function ftplugin#cpp#SwitchToSource()
  let l:header_file=expand('%:r')
  let l:cpp_file=expand(join(['src'] + split(l:header_file, '/')[2:-1], '/') . '.cpp')
  execute 'edit' l:cpp_file
endfunction

function ftplugin#cpp#SwitchToHeader()
  let l:header_path="include/".g:project_name
  :e %:s?src?\=l:header_path?:r.hpp
endfunction

function ftplugin#cpp#SwitchCPPFile()
  if expand('%:e') == 'hpp'
    call ftplugin#cpp#SwitchToSource()
    return
  endif

  if expand('%:e') == 'cpp'
    call ftplugin#cpp#SwitchToHeader()
    return
  endif

  echo 'Error a recognized C++ File!'
endfunction

function ftplugin#cpp#IsTestFile()
  return expand('%:t')=~"test" || expand('%:t')=~".hpp"
endfunction
