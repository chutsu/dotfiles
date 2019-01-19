- Live latex preview with vim
- Itemize without bullets


## Live latex preview with vim

create $HOME/.latexmkrc

    $pdf_previewer = 'start evince';

in commandline type:

    latexmk -pvc -pdf -xelatex -interaction=nonstopmode foo.tex


## Itemize without bullets

    \begin{itemize}
      \item[] First.
      \item[] Second.
    \end{itemize}
