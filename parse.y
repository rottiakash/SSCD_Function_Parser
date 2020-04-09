%{
    #include<stdio.h>
    #include<stdlib.h>
    char params[100];
    char temp[30];
    int pcount=0;
    int varcount=0;
    char vars[100];
    char temp1[30];
    
%}
%union 
{
        char *string;
}

%token <string> TYPE
%token <string> ID
%token OTHER
%token <string> BODY
%type <string> X
%%
S: DEC S|DEF S|OTHER S|E|err S
err: error DEF {yyerrok;}
    | error DEC {yyerrok;}
DEC: TYPE' 'ID'('DPARAM')'';' {printf("\nFunction Declaration Parsed\nFunction Name: %s\nFunction Return Type: %s\nNumber of Parameter:%d\n%s\n\n",$3,$1,pcount,params);pcount=0;strcpy(params,"");}
    |TYPE' 'ID'('E')'';' {printf("\nFunction Declaration Parsed\nFunction Name: %s\nFunction Return Type: %s\nNumber of Parameter:%d\n%s\n\n",$3,$1,pcount,params);pcount=0;strcpy(params,"");}
DPARAM: X
       |X','DPARAM
       |X','' 'DPARAM
DPARAMT:X' 'ID','DPARAMT {sprintf(temp1,"Parameter %s of type %s\n",$3,$1);strcat(vars,temp1);varcount++;}
        | X' 'ID {sprintf(temp1,"Parameter %s of type %s\n",$3,$1);strcat(vars,temp1);varcount++;}
        |X' 'ID','' 'DPARAMT {sprintf(temp1,"Parameter %s of type %s\n",$3,$1);strcat(vars,temp1);varcount++;}
X: TYPE {sprintf(temp,"Parameter of type %s\n",$1);strcat(params,temp);pcount++;}
E:%empty
DEF:TYPE' 'ID'('DPARAMT')'BODY {printf("\nFunction Defination Parsed\nFunction Name: %s\nFunction Return Type: %s\nNumber of Parameter:%d\n%s\nFunction Body:%s\n\n",$3,$1,varcount,vars,$7);varcount=0;strcpy(vars,"");}
   | TYPE' 'ID'('E')'BODY {printf("\nFunction Defination Parsed\nFunction Name: %s\nFunction Return Type: %s\nNumber of Parameter:%d\n%s\nFunction Body:%s\n\n",$3,$1,varcount,vars,$7);varcount=0;strcpy(vars,"");}
;
%%
extern FILE *yyin;
int main(int argc,char** argv)
{
	yyin = fopen(argv[1],"r");
    yyparse();
    return 0;
}

int yyerror()
{
}