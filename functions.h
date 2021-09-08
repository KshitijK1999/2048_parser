#ifndef FUNCTIONS_H
#define FUNCTIONS_H

struct tile 
{
	uint val;
    bool blocked;
    char name[32][100];
    int count;
};

struct tile board[4][4];
bool done, moved;
uint score;

extern void moveDir( int x, int y , int d, int e, char opr );
extern void compute( int x, int y , int d, int e, char opr );
extern void moveDiradd( int x, int y , int d, int e, char opr );
extern void assign(int digit, int x, int y);
extern void printnames();
extern void name(char *s, int x, int y);
extern void getVal(int x, int y);
extern int yyparse();
extern bool canMove();
extern void initialize();
extern void loop(char d, char opr);
extern void drawBoard();
extern void waitKey(char d, char opr);
extern void addTile();
extern bool canMove();
extern bool testAdd( int x, int y, uint v );
extern void move( char d,char opr );

#endif