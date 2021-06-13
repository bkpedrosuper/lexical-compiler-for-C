/* Linguagem: Pascal-like */

/* ========================================================================== */
/* Abaixo, indicado pelos limitadores "%{" e "%}", as includes necessárias... */
/* ========================================================================== */

%{
    /* Para as funções atoi() e atof() */
    #include <math.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    int row = 1;
    int column = 1;
    int id = 0;
    typedef struct symbol{
        int id;
        int row;
        int column;
        char content[100];
        char *type;

    } symbol;
    symbol **symbolsTable;    
%}

/* ========================================================================== */
/* ===========================  Sessão DEFINIÇÔES  ========================== */
/* ========================================================================== */

ID       [a-zA-Z_][a-zA-Z0-9_]*
TYPE     int|float|void|char
RESERVED if|for|printf|scanf|return
INCLUDE  \#include
DEFINE \#define
LIBRARY <[a-z][a-z]*.h>

DIGIT [0-9]
INTEGER {DIGIT}+
FLOAT {DIGIT}+"."{DIGIT}*
OPERATOR "+"|"-"|"*"|"/"
STRING \".*\"


%%

{INCLUDE}   {
                printf("%s na linha %d e na coluna %d\n", yytext, row, column);

                symbolsTable[id] = (symbol *) malloc(sizeof(symbol));
                symbolsTable[id]->id = id;
                symbolsTable[id]->row = row;
                symbolsTable[id]->column = column;
                symbolsTable[id]->type = "DIRECTIVE";
                strcpy(symbolsTable[id]->content, yytext);

                
                id++;
                column += strlen(yytext);
            }

{DIGIT}+   {
                printf("Inteiro %s na linha %d e na coluna %d\n", yytext, row, column);

                symbolsTable[id] = (symbol *) malloc(sizeof(symbol));
                symbolsTable[id]->id = id;
                symbolsTable[id]->row = row;
                symbolsTable[id]->column = column;
                symbolsTable[id]->type = "INTEGER";
                strcpy(symbolsTable[id]->content, yytext);

                
                id++;
                column += strlen(yytext);
            }

{FLOAT}   {
                printf("Float %s na linha %d e na coluna %d\n", yytext, row, column);

                symbolsTable[id] = (symbol *) malloc(sizeof(symbol));
                symbolsTable[id]->id = id;
                symbolsTable[id]->row = row;
                symbolsTable[id]->column = column;
                symbolsTable[id]->type = "FLOAT";
                strcpy(symbolsTable[id]->content, yytext);

                id++;
                column += strlen(yytext);
            }

{RESERVED}  {
                printf("Palavra reservada %s na linha %d e na coluna %d\n", yytext, row, column);

                symbolsTable[id] = (symbol *) malloc(sizeof(symbol));
                symbolsTable[id]->id = id;
                symbolsTable[id]->row = row;
                symbolsTable[id]->column = column;
                symbolsTable[id]->type = "RESERVED";
                strcpy(symbolsTable[id]->content, yytext);

                id++;
                column += strlen(yytext);
            }

{TYPE}      {
                printf("tipo %s na linha %d e na coluna %d\n", yytext, row, column);

                symbolsTable[id] = (symbol *) malloc(sizeof(symbol));
                symbolsTable[id]->id = id;
                symbolsTable[id]->row = row;
                symbolsTable[id]->column = column;
                symbolsTable[id]->type = "TYPE";
                strcpy(symbolsTable[id]->content, yytext);

                id++;
                column += strlen(yytext);
            }

{ID}        {
                printf("identificador     %s na linha %d e coluna %d\n", yytext, row, column);

                symbolsTable[id] = (symbol *) malloc(sizeof(symbol));
                symbolsTable[id]->id = id;
                symbolsTable[id]->row = row;
                symbolsTable[id]->column = column;
                symbolsTable[id]->type = "IDENTIFIER";
                strcpy(symbolsTable[id]->content, yytext);

                id++;
                column += strlen(yytext);
            }

{LIBRARY}   {
                printf("biblioteca  %s na linha %d e coluna %d\n", yytext, row, column);

                symbolsTable[id] = (symbol *) malloc(sizeof(symbol));
                symbolsTable[id]->id = id;
                symbolsTable[id]->row = row;
                symbolsTable[id]->column = column;
                symbolsTable[id]->type = "LIBRARY";
                strcpy(symbolsTable[id]->content, yytext);

                id++;
                column += strlen(yytext);
            }

{DEFINE}   {
                printf("define  %s na linha %d e coluna %d\n", yytext, row, column);

                symbolsTable[id] = (symbol *) malloc(sizeof(symbol));
                symbolsTable[id]->id = id;
                symbolsTable[id]->row = row;
                symbolsTable[id]->column = column;
                symbolsTable[id]->type = "DEFINE";
                strcpy(symbolsTable[id]->content, yytext);

                id++;
                column += strlen(yytext);
            }

{STRING}    {
                printf("String  %s na linha %d e coluna %d\n", yytext, row, column);
                symbolsTable[id] = (symbol *) malloc(sizeof(symbol));
                symbolsTable[id]->id = id;
                symbolsTable[id]->row = row;
                symbolsTable[id]->column = column;
                symbolsTable[id]->type = "STRING";
                strcpy(symbolsTable[id]->content, yytext);

                id++;
                column += strlen(yytext);
            }

{OPERATOR}    {
                printf("Operador  %s na linha %d e coluna %d\n", yytext, row, column);

                symbolsTable[id] = (symbol *) malloc(sizeof(symbol));
                symbolsTable[id]->id = id;
                symbolsTable[id]->row = row;
                symbolsTable[id]->column = column;
                symbolsTable[id]->type = "OPERATOR";
                strcpy(symbolsTable[id]->content, yytext);

                id++;
                column += strlen(yytext);
            }

"("|")" {
            printf("Parênteses  %s na linha %d e coluna %d\n", yytext, row, column);

            symbolsTable[id] = (symbol *) malloc(sizeof(symbol));
            symbolsTable[id]->id = id;
            symbolsTable[id]->row = row;
            symbolsTable[id]->column = column;
            symbolsTable[id]->type = "PARENTHESES";
            strcpy(symbolsTable[id]->content, yytext);

            id++;
            column += strlen(yytext);
        }

"{"|"}" {
            printf("Chave  %s na linha %d e coluna %d\n", yytext, row, column);

            symbolsTable[id] = (symbol *) malloc(sizeof(symbol));
            symbolsTable[id]->id = id;
            symbolsTable[id]->row = row;
            symbolsTable[id]->column = column;
            symbolsTable[id]->type = "QUOTE";
            strcpy(symbolsTable[id]->content, yytext);

            id++;
            column += strlen(yytext);
        }

"["|"]" {
            printf("Colchete  %s na linha %d e coluna %d\n", yytext, row, column);

            symbolsTable[id] = (symbol *) malloc(sizeof(symbol));
            symbolsTable[id]->id = id;
            symbolsTable[id]->row = row;
            symbolsTable[id]->column = column;
            symbolsTable[id]->type = "BRACKET";
            strcpy(symbolsTable[id]->content, yytext);

            id++;
            column += strlen(yytext);
        }

"," {
            printf("Vírgula  %s na linha %d e coluna %d\n", yytext, row, column);

            symbolsTable[id] = (symbol *) malloc(sizeof(symbol));
            symbolsTable[id]->id = id;
            symbolsTable[id]->row = row;
            symbolsTable[id]->column = column;
            symbolsTable[id]->type = "COMMA";
            strcpy(symbolsTable[id]->content, yytext);

            id++;
            column += strlen(yytext);
        }

";" {
            printf("Ponto e Vírgula  %s na linha %d e coluna %d\n", yytext, row, column);

            symbolsTable[id] = (symbol *) malloc(sizeof(symbol));
            symbolsTable[id]->id = id;
            symbolsTable[id]->row = row;
            symbolsTable[id]->column = column;
            symbolsTable[id]->type = "SEMICOLON";
            strcpy(symbolsTable[id]->content, yytext);

            id++;
            column += strlen(yytext);
        }

"&"|"%" {
            printf("Car  %s na linha %d e coluna %d\n", yytext, row, column);

            symbolsTable[id] = (symbol *) malloc(sizeof(symbol));
            symbolsTable[id]->id = id;
            symbolsTable[id]->row = row;
            symbolsTable[id]->column = column;
            symbolsTable[id]->type = "SEMICOLON";
            strcpy(symbolsTable[id]->content, yytext);

            id++;
            column += strlen(yytext);
        }

"{"[^}\n]*"}"

[ ]         {
                ++column;
            }

[\n]          {
                ++row;
                column = 0;
            }

[\t]         {
                column += 4;
            }


.           printf("Caractere n reconhecido %s\n", yytext);

%%



int main( argc, argv )
int argc;
char **argv;
{
	++argv, --argc;
    symbolsTable = (symbol * *) malloc(sizeof(symbol*) * 99999);
    
	if ( argc > 0 )
		yyin = fopen( argv[0], "r" );
	else
		yyin = stdin;

	yylex();
	
	printf("# total de linhas = %d\n", row);

    printf("TABELA:\n");
    printf("id\t\t type\t\t row\t\t column\t\t value\n");
    for(int index=0; index<id; index++) {
        printf("%d\t\t %s\t\t %d\t\t %d\t\t %s\n", symbolsTable[index]->id, symbolsTable[index]->type, symbolsTable[index]->row, symbolsTable[index]->column, symbolsTable[index]->content );
    }
    
	return 0;
}
