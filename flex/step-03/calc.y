%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();

void yyerror(const char* s);
%}

%union {
	int ival;
	float fval;
}

%token<ival> T_INT
%token<fval> T_FLOAT
%token T_PLUS T_MINUS T_MULTIPLY T_DIVIDE T_LEFT T_RIGHT
%left T_PLUS T_MINUS
%left T_MULTIPLY T_DIVIDE

%type<ival> expression
%type<fval> mixed_expression

%%
calculation: expression                 { printf("\tResult: %i\n", $1); }
    | mixed_expression                  { printf("\tResult: %f\n", $1);}
;

mixed_expression: T_FLOAT                               { $$ = $1; }
	  | mixed_expression T_PLUS mixed_expression        { $$ = $1 + $3; }
	  | mixed_expression T_MINUS mixed_expression       { $$ = $1 - $3; }
	  | mixed_expression T_MULTIPLY mixed_expression    { $$ = $1 * $3; }
	  | mixed_expression T_DIVIDE mixed_expression      { $$ = $1 / $3; }
	  | T_LEFT mixed_expression T_RIGHT                 { $$ = $2; }
	  | expression T_PLUS mixed_expression              { $$ = $1 + $3; }
	  | expression T_MINUS mixed_expression             { $$ = $1 - $3; }
	  | expression T_MULTIPLY mixed_expression          { $$ = $1 * $3; }
	  | expression T_DIVIDE mixed_expression            { $$ = $1 / $3; }
	  | mixed_expression T_PLUS expression              { $$ = $1 + $3; }
	  | mixed_expression T_MINUS expression             { $$ = $1 - $3; }
	  | mixed_expression T_MULTIPLY expression          { $$ = $1 * $3; }
	  | mixed_expression T_DIVIDE expression            { $$ = $1 / (float)$3; }
;

expression: T_INT                                       { $$ = $1; }
	  | expression T_PLUS expression                    { $$ = $1 + $3; }
	  | expression T_MINUS expression                   { $$ = $1 - $3; }
	  | expression T_MULTIPLY expression                { $$ = $1 * $3; }
	  | expression T_DIVIDE expression                  { $$ = $1 / $3; }
	  | T_LEFT expression T_RIGHT                       { $$ = $2; }
;
%%

int main() {
    return yyparse();
}

void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}
