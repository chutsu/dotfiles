#!/bin/bash
pdflatex "${1/.tex/}"
bibtex "${1/.tex/}"
pdflatex "${1/.tex/}"
pdflatex "${1/.tex/}"
rm "${1/.tex/}.log"
rm "*.aux"
