%{
// Внутри этого блока можно добавлять код на языке Си. Сюда добавляются
// подключения различных заголовочных файлов, объявления типов и функций,
// которые будут использоваться при работе лексического анализатора.
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"

extern FILE* yyin;
extern FILE* yyout;
#define RETURN_TOKEN(TYPE, VALUE) { strcpy(yylval.data, VALUE); return TYPE; }
%}


%%
"VAR"        {}
"END_VAR"    {}
"END_REPEAT" {}

"INT"        RETURN_TOKEN(INT, "int")
"STRING"     RETURN_TOKEN(STRING, "char*")
"BOOL"       RETURN_TOKEN(BOOL, "bool")

"TRUE"       RETURN_TOKEN(TRUE, "true")
"FALSE"      RETURN_TOKEN(FALSE, "false")

"TO"         RETURN_TOKEN(TO, "")
"BY"         RETURN_TOKEN(BY, "")
"DO"         RETURN_TOKEN(DO, "{")

"IF"         RETURN_TOKEN(IF, "if")
"ELSE"       RETURN_TOKEN(ELSE, "else")
"ELSEIF"     RETURN_TOKEN(ELSEIF, "else if")
"END_IF"     RETURN_TOKEN(END_IF, "}")
"THEN"       RETURN_TOKEN(THEN, "{")

"WHILE"      RETURN_TOKEN(WHILE, "while")
"END_WHILE"  RETURN_TOKEN(END_WHILE, "}")

"REPEAT"     RETURN_TOKEN(REPEAT, "do")
"UNTIL"      RETURN_TOKEN(UNTIL, "while")

"FOR"        RETURN_TOKEN(FOR, "for")
"END_FOR"    RETURN_TOKEN(END_FOR, "}")

":="         RETURN_TOKEN(ASSIGN, "=")
"="          RETURN_TOKEN(EQUAL, "==")

":"          RETURN_TOKEN(TYPE, yytext)
";"          RETURN_TOKEN(SEMICOLON, ";\n")

["+""\-""*""/""\\""<"">""<="">=""'""\""] RETURN_TOKEN(SIGNS, yytext)
[ \t\n\r]    ;

[0-9]+       RETURN_TOKEN(NUMBERS, yytext)
[a-zA-Z]+    RETURN_TOKEN(LETTERS, yytext)
.            { fprintf(stderr, "Unrecognized character %c in input\n", *yytext); } 

%%

int yywrap(){
    return 1;
}
