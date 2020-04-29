%{
    #include<stdio.h>
    #include<stdlib.h>
    char params[100];
    char temp[30];
    int pcount=0;
    int varcount=0;
    char vars[100];
    char temp1[30];
    char temp2[100];
    char cps[400];
%}
%union 
{
        char *string;
}

%token <string> TYPE
%token <string> ID
%token OTHER
%token INT
%token FLOAT
%token CHAR
%token <string> BODY
%type <string> X
%%
S: CALL S|DEC S|DEF S|OTHER S|E|err S 
err: error DEF {yyerrok;}
    | error DEC {yyerrok;}
    | error CALL {yyerrok;}
DEC: TYPE' 'ID'('DPARAM')'';' {printf("\nFunction Declaration Parsed\nFunction Name: %s\nFunction Return Type: %s\nNumber of Parameter:%d\n%s\n*****************\n\n",$3,$1,pcount,params);pcount=0;strcpy(params,"");}
    |TYPE' 'ID'('E')'';' {printf("\nFunction Declaration Parsed\nFunction Name: %s\nFunction Return Type: %s\nNumber of Parameter:%d\n%s\n*****************\n\n",$3,$1,pcount,params);pcount=0;strcpy(params,"");}
DPARAM: X
       |X','DPARAM
       |X','' 'DPARAM
DPARAMT:X' 'ID','DPARAMT {sprintf(temp1,"Parameter %s of type %s\n",$3,$1);strcat(vars,temp1);varcount++;}
        | X' 'ID {sprintf(temp1,"Parameter %s of type %s\n",$3,$1);strcat(vars,temp1);varcount++;}
        |X' 'ID','' 'DPARAMT {sprintf(temp1,"Parameter %s of type %s\n",$3,$1);strcat(vars,temp1);varcount++;}
X: TYPE {sprintf(temp,"Parameter of type %s\n",$1);strcat(params,temp);pcount++;}
E:/* empty */ 
DEF:TYPE' 'ID'('DPARAMT')' {printf("\nFunction Defination Parsed\nFunction Name: %s\nFunction Return Type: %s\nNumber of Parameter:%d\n%s\n*****************\n\n",$3,$1,varcount,vars);varcount=0;strcpy(vars,"");}
   | TYPE' 'ID'('E')' {printf("\nFunction Defination Parsed\nFunction Name: %s\nFunction Return Type: %s\nNumber of Parameter:%d\n%s\n*****************\n\n",$3,$1,varcount,vars);varcount=0;strcpy(vars,"");}
CALL: ID'('E')'';' {printf("Fucntion Call parsed\nFunction Name: %s\n\n*****************\n\n",$1);}
    | ID'('CPARAMS')'';' {printf("Fucntion Call parsed\nFunction Name: %s%s\n\n*****************\n\n",$1,cps);}
CPARAMS: VTYPE|VTYPE','CPARAMS|VTYPE','' 'CPARAMS ;
VTYPE: INT {sprintf(temp2,"\nParameter of type int");strcat(cps,temp2);}
    | FLOAT {sprintf(temp2,"\nParameter of type float/double");strcat(cps,temp2);}
    | CHAR {sprintf(temp2,"\nParameter of type char");strcat(cps,temp2);}
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