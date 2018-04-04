# Live latex preview with vim

create $HOME/.latexmkrc

    $pdf_previewer = 'start evince';

in commandline type:

    latexmk -pvc -pdf -xelatex -interaction=nonstopmode foo.tex

