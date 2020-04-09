#!/bin/bash
printf "Enter the C/C++ file name:"
read filename
lex parse.l
yacc -d parse.y
cc -w lex.yy.c y.tab.c -ll
./a.out $filename > output.txt
echo "Result saved in output.txt"