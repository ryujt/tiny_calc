%option noyywrap
%option never-interactive

%{
#include <stdio.h>

#define T_FLOAT     1
#define T_INT       2
#define T_NEWLINE   3
#define T_PLUS      4
#define T_MINUS     5
#define T_MULTIPLY  6
#define T_DIVIDE    7
#define T_LEFT      8
#define T_RIGHT     9

double fval;
int ival;
%}

%%
[ \t]           ; // ignore all whitespace
[0-9]+\.[0-9]+  {fval = atof(yytext); return T_FLOAT;}
[0-9]+          {ival = atoi(yytext); return T_INT;}
\n              {return T_NEWLINE;}
"+"             {return T_PLUS;}
"-"             {return T_MINUS;}
"*"             {return T_MULTIPLY;}
"/"             {return T_DIVIDE;}
"("             {return T_LEFT;}
")"             {return T_RIGHT;}
%%

int main(int argc, char** argv) {
    yy_scan_string("314 * (1.23 + 2)");

    int result = yylex();
    while (result) {
        switch(result) {
            case T_FLOAT: printf("T_FLOAT: %g \n", fval); break;
            case T_INT: printf("T_INT: %d \n", ival); break;
            case T_NEWLINE: printf("T_NEWLINE \n"); break;
            case T_PLUS: printf("T_PLUS: %s \n", yytext); break;
            case T_MINUS: printf("T_MINUS: %s \n", yytext); break;
            case T_MULTIPLY: printf("T_MULTIPLY: %s \n", yytext); break;
            case T_DIVIDE: printf("T_DIVIDE: %s \n", yytext); break;
            case T_LEFT: printf("T_LEFT: %s \n", yytext); break;
            case T_RIGHT: printf("T_RIGHT: %s \n", yytext); break;
        }
        result = yylex();
    }
}