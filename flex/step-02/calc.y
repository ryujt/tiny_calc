%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();

void yyerror(const char* s);
%}

%union {
    float fval;
}

%token<fval> T_FLOAT
%token T_PLUS T_MINUS T_MULTIPLY T_DIVIDE T_LEFT T_RIGHT
%left T_PLUS T_MINUS
%left T_MULTIPLY T_DIVIDE

%type<fval> expression

%start calculation

%%
calculation:
    expression                          { printf("\tResult: %f\n", $1);}
;

expression:
    T_FLOAT                             { $$ = $1; }
    | expression T_PLUS expression      { $$ = $1 + $3; }
    | expression T_MINUS expression     { $$ = $1 - $3; }
    | expression T_MULTIPLY expression  { $$ = $1 * $3; }
    | expression T_DIVIDE expression    { $$ = $1 / $3; }
    | T_LEFT expression T_RIGHT         { $$ = $2; }
;
%%

int main() {
    return yyparse();
}

void yyerror(const char* s) {
    fprintf(stderr, "Parse error: %s\n", s);
    exit(1);
}
