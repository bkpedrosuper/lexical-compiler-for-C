flex --noyywrap lex.lex
gcc lex.yy.c -lfl -o lex
./lex codigo-exemplo.c > out