%option noyywrap
%option never-interactive

%{
#include <stdio.h>
#include "calc.tab.c"
%}

%%
[ \t]           ; // ignore all whitespace
[0-9]+\.[0-9]+  {yylval.fval = atof(yytext); return T_FLOAT;}
[0-9]+          {yylval.fval = atof(yytext); return T_FLOAT;}
"+"             {return T_PLUS;}
"-"             {return T_MINUS;}
"*"             {return T_MULTIPLY;}
"/"             {return T_DIVIDE;}
"("             {return T_LEFT;}
")"             {return T_RIGHT;}
%%
