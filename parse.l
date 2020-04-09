%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
%}
%%
int|char|bool|float|void|double|char|char\*\* {yylval.string=strdup(yytext);return TYPE;}
[a-zA-Z][_a-zA-Z0-9]* {yylval.string=strdup(yytext);return ID;}
\{[^}]*\} {yylval.string=strdup(yytext);return BODY;}
. return yytext[0];
\n ;
%%
