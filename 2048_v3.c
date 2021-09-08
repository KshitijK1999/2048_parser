 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <termios.h>
#include <time.h>
#include <unistd.h>
#include <stdbool.h>
#include "functions.h"

typedef unsigned int uint;

void printnames(){
	for(int i=0;i<4;i++){
		for(int j=0;j<4;j++){
			int flag = 0;
			printf("%d %d - ",i,j);
			for(int k=0;k<=board[i][j].count;k++)
				
				if(board[i][j].count!=0)
				{
					printf("%s", board[i][j].name + k);
					flag=1;

				}
			printf(" ");
		}
	}
	printf("\n");
}

void name(char *s, int x, int y){
	if(board[x-1][y-1].val==0)
	{
		printf("Value in location is 0 cannot assign\n");
		printf("Please enter your command.\n");
		return;
	}
	strcpy(board[x-1][y-1].name[board[x-1][y-1].count], s);	
	board[x-1][y-1].count++;
	//printnames();
	for(int i=0;i<4;i++){
		for(int j=0;j<4;j++){
			fprintf(stderr,"%d ",board[i][j].val);
		}
	}
	printf(" ");
	for(int i=0;i<4;i++){
		for(int j=0;j<4;j++){
			for(int k=0;k<board[i][j].count;k++)
			{
				if(board[i][j].count!=0 && k==0)
					fprintf(stderr,"%d,%d%s",i+1,j+1,board[i][j].name[k]);
				if(board[i][j].count!=0 && k!=0)
					fprintf(stderr,"%s",board[i][j].name[k]);
				if(k+1<board[i][j].count)
					fprintf(stderr,",");
			}
			if(board[i][j].count!=0)
				fprintf(stderr," ");
		}
	}
	fprintf(stderr,"\n");
	drawBoard(); 
	printf("Please enter your command.\n");
}

void assign(int digit, int x, int y){
	board[x-1][y-1].val = digit;
	for(int i=0;i<4;i++){
		for(int j=0;j<4;j++){
			fprintf(stderr,"%d ",board[i][j].val);
		}
	}
	printf(" ");
	for(int i=0;i<4;i++){
		for(int j=0;j<4;j++){
			for(int k=0;k<board[i][j].count;k++)
			{
				if(board[i][j].count!=0 && k==0)
					fprintf(stderr,"%d,%d%s",i+1,j+1,board[i][j].name[k]);
				if(board[i][j].count!=0 && k!=0)
					fprintf(stderr,"%s",board[i][j].name[k]);
				if(k+1<board[i][j].count)
					fprintf(stderr,",");
			}
			if(board[i][j].count!=0)
				fprintf(stderr," ");
		}
	}
	fprintf(stderr,"\n");
	drawBoard(); 
	printf("Please enter your command.\n");
}

void getVal(int x, int y)
{
	printf("VALUE : %d\n", board[x-1][y-1].val);
	printf("Please enter your command.\n");
}


void initialize()
{
	for( int i = 0; i < 4; i++ )
	{
	    for( int j = 0; j < 4; j++ )
	    {
	    	board[i][j].val = 0;
	    	board[i][j].blocked = false;
	    	board[i][j].count = 0;
	    }
	}
}

void loop(char d, char opr)
{
    //printf("HI\n");
    waitKey(d,opr);
    addTile();
    for(int i=0;i<4;i++){
		for(int j=0;j<4;j++){
			fprintf(stderr,"%d ",board[i][j].val);
		}
	}
	printf(" ");
	for(int i=0;i<4;i++){
		for(int j=0;j<4;j++){
			for(int k=0;k<board[i][j].count;k++)
			{
				if(board[i][j].count!=0 && k==0)
					fprintf(stderr,"%d,%d%s",i+1,j+1,board[i][j].name[k]);
				if(board[i][j].count!=0 && k!=0)
					fprintf(stderr,"%s",board[i][j].name[k]);
				if(k+1<board[i][j].count)
					fprintf(stderr,","); 
			}
			if(board[i][j].count!=0)
				fprintf(stderr," ");
		}
	}
	fprintf(stderr,"\n");
    drawBoard(); 
    //printf("HI\n");
    //printnames();
    printf("Please enter your command.\n");
}

void drawBoard()
{
	//printf("Score: %d\n\n",score);
	for( int x = 0; x < 4; x++ )
	{
	    printf("+------+------+------+------+\n| ");
	    for( int y = 0; y < 4; y++ )
	    {
			
			printf("%5d",board[x][y].val);
			printf("| ");
	    }
	    printf("\n");
	}
	printf("+------+------+------+------+\n\n");
}

void waitKey(char d, char opr)
{
	d &= 0x5F;

	switch( d )
	{
	    case 'W': move('W',opr); break;
	    case 'A': move('A',opr); break;
	    case 'S': move('S',opr); break;
	    case 'D': move('D',opr); break;
	}
	for( int y = 0; y < 4; y++ )
	    for( int x = 0; x < 4; x++ )
		board[x][y].blocked = false;
	}

void addTile()
	{
	for( int y = 0; y < 4; y++ )
	    for( int x = 0; x < 4; x++ )
		if( !board[x][y].val )
		{
		    uint a, b;
		    do
		    { a = rand() % 4; b = rand() % 4; }
		    while( board[a][b].val );

		    int s = rand() % 100;
		    if( s > 64 ) board[a][b].val = 4;
		    else board[a][b].val = 2;
		    if( canMove() ) return;
		}
	done = true;
}

bool canMove()
{
	for( int y = 0; y < 4; y++ )
	    for( int x = 0; x < 4; x++ )
		if( !board[x][y].val ) return true;

	for( int y = 0; y < 4; y++ )
	    for( int x = 0; x < 4; x++ )
	    {
		if( testAdd( x + 1, y, board[x][y].val ) ) return true;
		if( testAdd( x - 1, y, board[x][y].val ) ) return true;
		if( testAdd( x, y + 1, board[x][y].val ) ) return true;
		if( testAdd( x, y - 1, board[x][y].val ) ) return true;
	    }
	return false;
}

bool testAdd( int x, int y, uint v )
{
	if( x < 0 || x > 3 || y < 0 || y > 3 ) return false;
	return board[x][y].val == v;
}

void moveDir( int x, int y , int d, int e, char opr )
{
	if( board[x + d][y + e].val && board[x + d][y + e].val == board[x][y].val && !board[x][y].blocked && !board[x + d][y + e].blocked  )
	{
	    switch(opr)
	    {
	    	case '*':
	    	board[x + d][y + e].val = board[x + d][y + e].val*board[x][y].val;
	    	board[x][y].val = 0;
	    	break;
	    	case '-':
	    	board[x + d][y + e].val = board[x + d][y + e].val-board[x][y].val;
	    	board[x][y].val = 0;
	    	break;
	    	case '/':
	    	board[x + d][y + e].val = board[x + d][y + e].val/board[x][y].val;
	    	board[x][y].val = 0;
	    	break;
	    }
	    if(opr=='-')
	    {
	    	for(int i=0;i<board[x][y].count;i++)
	    	{
	    	strcpy(board[x][y].name[i], "\0");
	  		}
	  		for(int i=0;i<board[x+d][y+e].count;i++)
	    	{
	    	strcpy(board[x+d][y+e].name[i], "\0");
	  		}
	  		board[x + d][y + e].count = 0;
	  		board[x][y].count = 0;
	    }
	    int base = board[x + d][y + e].count;
	    for(int i=0;i<board[x][y].count;i++)
	    {
	    	//printf("before strcpy of first loop");
	    	strcpy(board[x + d][y + e].name[(base+i)] , board[x][y].name[i]);
	    	//printf("after strcpy of first loop");
	    	board[x + d][y + e].count++;
	    }
	    for(int i=0;i<board[x][y].count;i++)
	    {
	    	//printf("before strcpy of second loop");
	    	strcpy(board[x][y].name[i], "\0");
	    	//printf("after strcpy of second loop");
	    }
	    //printf("after second loop");
	    board[x][y].count = 0;
	    board[x][y].val = 0;
	    score += board[x + d][y + e].val;
	    board[x + d][y + e].blocked = true;
	    moved = true;
	}
	else if( !board[x + d][y + e].val && board[x][y].val )
	{
	    board[x + d][y + e].val = board[x][y].val;
	    board[x][y].val = 0;
	    int base = board[x + d][y + e].count;
	    for(int i=0;i<board[x][y].count;i++)
	    {
	    	//printf("before strcpy of first loop");
	    	strcpy(board[x + d][y + e].name[(base+i)] , board[x][y].name[i]);
	    	//printf("after strcpy of first loop");
	    	board[x + d][y + e].count++;
	    }
	    for(int i=0;i<board[x][y].count;i++)
	    {
	    	//printf("before strcpy of second loop");
	    	strcpy(board[x][y].name[i], "\0");
	    	//printf("after strcpy of second loop");
	    }
	    //printf("after second loop");
	    board[x][y].count = 0;
	    board[x][y].val = 0;
	    moved = true;
	}
	if( d > 0 ){
        if( x + d < 3 ) moveDir( x + d, y, 1, 0, opr );
      }else  if(d<0){
        if( x + d > 0 ) moveDir( x + d, y,-1, 0, opr );
      }else if(e>0){
        if( y + e < 3 ) moveDir( x, y + e, 0, 1, opr );
      }else{
        if( y + e > 0 ) moveDir( x, y + e, 0,-1, opr );
      }
}

void moveDiradd( int x, int y , int d, int e, char opr )
{
	if( board[x + d][y + e].val && !board[x][y].blocked && !board[x+d][y + e].blocked  )
	{
	    board[x + d][y + e].val = board[x + d][y + e].val+board[x][y].val;
	    int base = board[x + d][y + e].count;
	    for(int i=0;i<board[x][y].count;i++)
	    {
	    	//printf("before strcpy of first loop");
	    	strcpy(board[x + d][y + e].name[(base+i)] , board[x][y].name[i]);
	    	//printf("after strcpy of first loop");
	    	board[x + d][y + e].count++;
	    }
	    for(int i=0;i<board[x][y].count;i++)
	    {
	    	//printf("before strcpy of second loop");
	    	strcpy(board[x][y].name[i], "\0");
	    	//printf("after strcpy of second loop");
	    }
	    //printf("after second loop");
	    board[x][y].count = 0;
	    board[x][y].val = 0;
	    score += board[x + d][y + e].val;
	    board[x + d][y + e].blocked = true;
	    moved = true;
	}
	else if( !board[x + d][y + e].val && board[x][y].val )
	{
	    board[x + d][y + e].val = board[x][y].val;
	    int base = board[x + d][y + e].count;
	    for(int i=0;i<board[x][y].count;i++)
	    {
	    	//printf("before strcpy of first loop");
	    	strcpy(board[x + d][y + e].name[(base+i)] , board[x][y].name[i]);
	    	//printf("after strcpy of first loop");
	    	board[x + d][y + e].count++;
	    }
	    for(int i=0;i<board[x][y].count;i++)
	    {
	    	//printf("before strcpy of second loop");
	    	strcpy(board[x][y].name[i], "\0");
	    	//printf("after strcpy of second loop");
	    }
	    //printf("after second loop");
	    board[x][y].count = 0;
	    board[x][y].val = 0;
	    board[x][y].val = 0;
	    moved = true;
	}
	if( d > 0 ){
        if( x + d < 3 ) moveDiradd( x + d, y, 1, 0, opr );
      }else  if(d<0){
        if( x + d > 0 ) moveDiradd( x + d, y,-1, 0, opr );
      }else if(e>0){
        if( y + e < 3 ) moveDiradd( x, y + e, 0, 1, opr );
      }else{
        if( y + e > 0 ) moveDiradd( x, y + e, 0,-1, opr );
      }
}
void compute( int x, int y , int d, int e, char opr )
{
	if(opr=='+')
		moveDiradd(x,y,d,e,opr);
	else
		moveDir(x,y,d,e,opr);
}
void move( char d,char opr )
{
	switch( d )
	{
	    case 'A':
	    	for( int x = 0; x < 4; x++ )
		{
		    int y = 1;
		    while( y < 4 )
		    { if( board[x][y].val ) compute( x, y, 0, -1, opr); y++;}
		}
		break;
	    case 'D':
		for( int x = 0; x < 4; x++ )
		{
		    int y = 2;
		    while( y >= 0 )
		    { if( board[x][y].val ) compute( x, y, 0, 1, opr); y--;}
		}
		break;
	    case 'W':
		for( int y = 0; y < 4; y++ )
		{
		    int x = 1;
		    while( x < 4 )
		    { if( board[x][y].val ) compute( x, y, -1, 0, opr); x++;}
		}
		break;
	    case 'S':
		for( int y = 0; y < 4; y++ )
		{
		    int x = 2;
		    while( x >= 0 )
		    { if( board[x][y].val ) compute( x, y, 1, 0, opr); x--;}
		}
	}	
}
void main( int argc, char* argv[] )
{
    
	done = false; 
	moved = true;  
	score =  0;
	srand(time(0));
    initialize();
    addTile();
    for(int i=0;i<4;i++){
		for(int j=0;j<4;j++){
			fprintf(stderr,"%d ",board[i][j].val);
		}
	}
	printf(" ");
	for(int i=0;i<4;i++){
		for(int j=0;j<4;j++){
			for(int k=0;k<board[i][j].count;k++)
			{
				if(board[i][j].count!=0 && k==0)
					fprintf(stderr,"%d,%d%s",i+1,j+1,board[i][j].name[k]);
				if(board[i][j].count!=0 && k!=0)
					fprintf(stderr,"%s",board[i][j].name[k]);
				if(k+1<board[i][j].count)
					fprintf(stderr,",");
			}
			if(board[i][j].count!=0)
				fprintf(stderr," ");
		}
	}
	fprintf(stderr,"\n");
    drawBoard(); 
    printf("Please enter your command.\n");
	while(1){
		yyparse();
	}
}