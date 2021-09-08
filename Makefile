default:
	clear
	flex 2048.l
	bison -d 2048.y -Wconflicts-sr
	gcc -o 2048 2048_v3.c lex.yy.c 2048.tab.c -lfl