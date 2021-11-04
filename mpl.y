%{
  #include <stdio.h>
  #include <string.h>
  #include <stdlib.h>

  int yylex();
  void yyerror(char *message);
  extern int yylineno;

%}

%start PROGRAM
%token GE LE IS ISNT
%token AND OR NOT
%token REAL ALPHA NUMBER
%token UNTIL DO END_LOOP IF ELSE_IF DEFUALT
%token identifier

%nonassoc ELSE_IF
%nonassoc DEFAULT
%right GE LE
%right IS ISNT
%left '+' '-'
%left '*' '/'
%right NOT
%right AND
%right OR



%%

PROGRAM: BEGIN line
       ;

line: stmt
    | line stmt
    ;

stmt:    ','
    | '.' {printf("-------------\nPROGRAM ENDED NUMBER OF LINES >> %d\n",yylineno);exit(0);}
    | exp ','
    | conditions ','
    | ifStruct
    | loopStruct
    ;

exp:
    | identifier
    | literal
    | declartion
    | exp '+' exp
    | exp '-' exp
    | exp '*' exp
    | exp '/' exp
    | exp '>' exp
    | exp '<' exp
    | exp LE exp
    | exp GE exp
    | exp IS exp
    | exp ISNT exp
    | exp OR exp
    | exp AND exp
    | exp NOT exp
    ;


declartion: NUMBER identifier
          | REAL identifier
          | ALPHA identifier
          ;


ifStruct:
        IF exp THEN line ','             %prec ELSE_IF
        | IF exp THEN line, DEFAULT THEN line, END_LOOP ','
        ;

loopStruct: UNTIL exp DO line END_LOOP ','
          ;

literal: NUMBERVAL
       | ALPHAVAL
       | REALVAL
       ;


%%

int main(void){


printf("\n------------------------------\nWELCOME TO OUR LEX-YACC PROGRAM\n>> THE PROGRAM SHOULD START WITH (>>)\n>> PROGRAM ENDS WITH (<<)\n>> WE KNOW HOW FRUSTRATING IT IS TO WRITE CODE IN CASE SENSITIVE PROGRAMS SO GUESS WHAT MPL IS CASE-INSENSITIVE!!\n");

if(!yyparse())
	{
		printf("YOU ARE A SMOOTH DUDE !!\nCODE COMPILED WITH NO ERRORS");
	}
else
	{
			printf("\nParsing failed\n");
	}

}

void yyerror(char *message) {
    fprintf(stderr, "Error | Line: %d >> %s\n",yylineno,message);
    exit(0);
}
