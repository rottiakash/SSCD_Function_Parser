%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
%}
%%
int|char|float|void|double|char|char\*\* {yylval.string=strdup(yytext);return TYPE;}
[a-zA-Z][_a-zA-Z0-9]* {yylval.string=strdup(yytext);return ID;}
\'[a-zA-Z]\' {return CHAR;}
[0-9]+ return INT;
[0-9]+\.[0-9]+ return FLOAT;
. return yytext[0];
\n ;
%%
