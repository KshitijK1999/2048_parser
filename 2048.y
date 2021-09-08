%{
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include "fcntl.h"
#include <string.h>
#include <stdbool.h>
#include "functions.h"
%}
%token ADD SUBTRACT MULTIPLY DIVIDE UP DOWN LEFT RIGHT ASSIGN VALUE TO IN VAR IS FULLSTOP NUMBER X COMMA NL VARNAME 

%union{
	int intVal;
	char *stringVal;
}

%%
prog: input

input: dir line input|
assign line input|
set line input|
query line input|

dir: ADD UP FULLSTOP		{loop('W','+');}
|ADD DOWN FULLSTOP			{loop('S','+');}
|ADD LEFT FULLSTOP  		{loop('A','+');}
|ADD RIGHT FULLSTOP			{loop('D','+');}
|SUBTRACT UP FULLSTOP		{loop('W','-');}
|SUBTRACT DOWN FULLSTOP		{loop('S','-');}
|SUBTRACT LEFT FULLSTOP		{loop('A','-');}
|SUBTRACT RIGHT FULLSTOP	{loop('D','-');}
|MULTIPLY UP FULLSTOP		{loop('W','*');}
|MULTIPLY DOWN FULLSTOP		{loop('S','*');}
|MULTIPLY LEFT FULLSTOP		{loop('A','*');}
|MULTIPLY RIGHT FULLSTOP	{loop('D','*');}
|DIVIDE UP FULLSTOP			{loop('W','/');}
|DIVIDE DOWN FULLSTOP		{loop('S','/');}
|DIVIDE LEFT FULLSTOP		{loop('A','/');}
|DIVIDE RIGHT FULLSTOP		{loop('D','/');}
|ADD UP			{fprintf(stderr,"-1\n");	printf("You need to end a command with a full-stop.\n"); printf("Please enter your command.\n");}
|ADD DOWN		{fprintf(stderr,"-1\n");	printf("You need to end a command with a full-stop.\n"); printf("Please enter your command.\n");}
|ADD LEFT		{fprintf(stderr,"-1\n");	printf("You need to end a command with a full-stop.\n"); printf("Please enter your command.\n");}
|ADD RIGHT		{fprintf(stderr,"-1\n");	printf("You need to end a command with a full-stop.\n"); printf("Please enter your command.\n");}
|SUBTRACT UP	{fprintf(stderr,"-1\n");	printf("You need to end a command with a full-stop.\n"); printf("Please enter your command.\n");}
|SUBTRACT DOWN	{fprintf(stderr,"-1\n");	printf("You need to end a command with a full-stop.\n"); printf("Please enter your command.\n");}
|SUBTRACT LEFT	{fprintf(stderr,"-1\n");	printf("You need to end a command with a full-stop.\n"); printf("Please enter your command.\n");}
|SUBTRACT RIGHT	{fprintf(stderr,"-1\n");	printf("You need to end a command with a full-stop.\n"); printf("Please enter your command.\n");}
|MULTIPLY UP	{fprintf(stderr,"-1\n");	printf("You need to end a command with a full-stop.\n"); printf("Please enter your command.\n");}
|MULTIPLY DOWN	{fprintf(stderr,"-1\n");	printf("You need to end a command with a full-stop.\n"); printf("Please enter your command.\n");}
|MULTIPLY LEFT	{fprintf(stderr,"-1\n");	printf("You need to end a command with a full-stop.\n"); printf("Please enter your command.\n");}
|MULTIPLY RIGHT	{fprintf(stderr,"-1\n");	printf("You need to end a command with a full-stop.\n"); printf("Please enter your command.\n");}
|DIVIDE UP		{fprintf(stderr,"-1\n");	printf("You need to end a command with a full-stop.\n"); printf("Please enter your command.\n");}
|DIVIDE DOWN	{fprintf(stderr,"-1\n");	printf("You need to end a command with a full-stop.\n"); printf("Please enter your command.\n");}
|DIVIDE LEFT	{fprintf(stderr,"-1\n");	printf("You need to end a command with a full-stop.\n"); printf("Please enter your command.\n");}
|DIVIDE RIGHT	{fprintf(stderr,"-1\n");	printf("You need to end a command with a full-stop.\n"); printf("Please enter your command.\n");}
|VARNAME UP					{fprintf(stderr,"-1\n");	printf("Sorry I don't understand that.\n"); printf("Please enter your command.\n");}
|VARNAME DOWN				{fprintf(stderr,"-1\n");	printf("Sorry I don't understand that.\n"); printf("Please enter your command.\n");}
|VARNAME LEFT				{fprintf(stderr,"-1\n");	printf("Sorry I don't understand that.\n"); printf("Please enter your command.\n");}
|VARNAME RIGHT				{fprintf(stderr,"-1\n");	printf("Sorry I don't understand that.\n"); printf("Please enter your command.\n");}
|VARNAME UP	FULLSTOP		{fprintf(stderr,"-1\n");	printf("Sorry I don't understand that.\n"); printf("Please enter your command.\n");}
|VARNAME DOWN FULLSTOP		{fprintf(stderr,"-1\n");	printf("Sorry I don't understand that.\n"); printf("Please enter your command.\n");}
|VARNAME LEFT FULLSTOP		{fprintf(stderr,"-1\n");	printf("Sorry I don't understand that.\n"); printf("Please enter your command.\n");}
|VARNAME RIGHT FULLSTOP		{fprintf(stderr,"-1\n");	printf("Sorry I don't understand that.\n"); printf("Please enter your command.\n");}
|ADD VARNAME				{fprintf(stderr,"-1\n");	printf("Sorry I don't understand that.\n"); printf("Please enter your command.\n");}
|SUBTRACT VARNAME			{fprintf(stderr,"-1\n");	printf("Sorry I don't understand that.\n"); printf("Please enter your command.\n");}
|MULTIPLY VARNAME			{fprintf(stderr,"-1\n");	printf("Sorry I don't understand that.\n"); printf("Please enter your command.\n");}
|DIVIDE VARNAME				{fprintf(stderr,"-1\n");	printf("Sorry I don't understand that.\n"); printf("Please enter your command.\n");}
line: NL
assign: ASSIGN X TO X COMMA X FULLSTOP 			{assign($<intVal>2,$<intVal>4,$<intVal>6);}
|ASSIGN NUMBER TO X COMMA X FULLSTOP 			{assign($<intVal>2,$<intVal>4,$<intVal>6);}
|ASSIGN X TO X COMMA NUMBER FULLSTOP 			{fprintf(stderr,"-1\n");	printf("There is no tile like that. The tile coordinates must be in the range 1,2,3,4.\n"); printf("Please enter your command.\n");}
|ASSIGN X TO NUMBER COMMA X FULLSTOP 			{fprintf(stderr,"-1\n");	printf("There is no tile like that. The tile coordinates must be in the range 1,2,3,4.\n"); printf("Please enter your command.\n");}
|ASSIGN X TO NUMBER COMMA NUMBER FULLSTOP 		{fprintf(stderr,"-1\n");	printf("There is no tile like that. The tile coordinates must be in the range 1,2,3,4.\n"); printf("Please enter your command.\n");}
|ASSIGN NUMBER TO X COMMA NUMBER FULLSTOP 		{fprintf(stderr,"-1\n");	printf("There is no tile like that. The tile coordinates must be in the range 1,2,3,4.\n"); printf("Please enter your command.\n");}
|ASSIGN NUMBER TO NUMBER COMMA X FULLSTOP 		{fprintf(stderr,"-1\n");	printf("There is no tile like that. The tile coordinates must be in the range 1,2,3,4.\n"); printf("Please enter your command.\n");}
|ASSIGN NUMBER TO NUMBER COMMA NUMBER FULLSTOP  {fprintf(stderr,"-1\n");	printf("There is no tile like that. The tile coordinates must be in the range 1,2,3,4.\n");}
|ASSIGN X TO X COMMA X 							{fprintf(stderr,"-1\n");	printf("You need to end a command with a full-stop\n"); printf("Please enter your command.\n");}
|ASSIGN NUMBER TO X COMMA X 					{fprintf(stderr,"-1\n");	printf("You need to end a command with a full-stop\n"); printf("Please enter your command.\n");}
|ASSIGN X TO X COMMA NUMBER 					{fprintf(stderr,"-1\n");	printf("You need to end a command with a full-stop\n"); printf("Please enter your command.\n");}
|ASSIGN X TO NUMBER COMMA X 					{fprintf(stderr,"-1\n");	printf("You need to end a command with a full-stop\n"); printf("Please enter your command.\n");}
|ASSIGN X TO NUMBER COMMA NUMBER 				{fprintf(stderr,"-1\n");	printf("You need to end a command with a full-stop\n"); printf("Please enter your command.\n");}
|ASSIGN VARNAME TO X COMMA X 					{fprintf(stderr,"-1\n");	printf("Sorry I don't understand that.\n"); printf("Please enter your command.\n");}
|ASSIGN VARNAME TO X COMMA NUMBER 				{fprintf(stderr,"-1\n");	printf("Sorry I don't understand that.\n"); printf("Please enter your command.\n");}
|ASSIGN VARNAME TO NUMBER COMMA X 				{fprintf(stderr,"-1\n");	printf("Sorry I don't understand that.\n"); printf("Please enter your command.\n");}
|ASSIGN VARNAME TO NUMBER COMMA NUMBER 			{fprintf(stderr,"-1\n");	printf("Sorry I don't understand that.\n"); printf("Please enter your command.\n");}
set: VAR VARNAME IS X COMMA X FULLSTOP 		{printf("%s %d %d\n",$<stringVal>2,$<intVal>4,$<intVal>6);	name($<stringVal>2,$<intVal>4,$<intVal>6);}
|VAR VARNAME IS NUMBER COMMA X FULLSTOP 	{fprintf(stderr,"-1\n");	printf("There is no tile like that. The tile coordinates must be in the range 1,2,3,4.\n"); printf("Please enter your command.\n");}
|VAR VARNAME IS X COMMA NUMBER FULLSTOP 	{fprintf(stderr,"-1\n");	printf("There is no tile like that. The tile coordinates must be in the range 1,2,3,4.\n"); printf("Please enter your command.\n");}
|VAR VARNAME IS NUMBER COMMA NUMBER FULLSTOP{fprintf(stderr,"-1\n");	printf("There is no tile like that. The tile coordinates must be in the range 1,2,3,4.\n"); printf("Please enter your command.\n");}
|VAR VARNAME IS X COMMA X 					{fprintf(stderr,"-1\n");	printf("You need to end a command with a full-stop\n"); printf("Please enter your command.\n");}
|VAR VARNAME IS X COMMA NUMBER 				{fprintf(stderr,"-1\n");	printf("You need to end a command with a full-stop\n"); printf("Please enter your command.\n");}
|VAR VARNAME IS NUMBER COMMA X 				{fprintf(stderr,"-1\n");	printf("You need to end a command with a full-stop\n"); printf("Please enter your command.\n");}
|VAR VARNAME IS NUMBER COMMA NUMBER 		{fprintf(stderr,"-1\n");	printf("You need to end a command with a full-stop\n"); printf("Please enter your command.\n");}
|VAR ADD IS X COMMA X FULLSTOP				{fprintf(stderr,"-1\n");	printf("No, a keyword cannot be a variable name.\n"); printf("Please enter your command.\n");}
|VAR SUBTRACT IS X COMMA X FULLSTOP			{fprintf(stderr,"-1\n");	printf("No, a keyword cannot be a variable name.\n"); printf("Please enter your command.\n");}
|VAR MULTIPLY  IS X COMMA X FULLSTOP		{fprintf(stderr,"-1\n");	printf("No, a keyword cannot be a variable name.\n"); printf("Please enter your command.\n");}
|VAR DIVIDE IS X COMMA X FULLSTOP			{fprintf(stderr,"-1\n");	printf("No, a keyword cannot be a variable name.\n"); printf("Please enter your command.\n");}
|VAR LEFT IS X COMMA X FULLSTOP				{fprintf(stderr,"-1\n");	printf("No, a keyword cannot be a variable name.\n"); printf("Please enter your command.\n");}
|VAR RIGHT IS X COMMA X FULLSTOP			{fprintf(stderr,"-1\n");	printf("No, a keyword cannot be a variable name.\n"); printf("Please enter your command.\n");}
|VAR UP IS X COMMA X FULLSTOP				{fprintf(stderr,"-1\n");	printf("No, a keyword cannot be a variable name.\n"); printf("Please enter your command.\n");}
|VAR DOWN IS X COMMA X FULLSTOP				{fprintf(stderr,"-1\n");	printf("No, a keyword cannot be a variable name.\n"); printf("Please enter your command.\n");}
|VAR IS IS X COMMA X FULLSTOP				{fprintf(stderr,"-1\n");	printf("No, a keyword cannot be a variable name.\n"); printf("Please enter your command.\n");}
|VAR VAR IS X COMMA X FULLSTOP				{fprintf(stderr,"-1\n");	printf("No, a keyword cannot be a variable name.\n"); printf("Please enter your command.\n");}
|VAR ASSIGN IS X COMMA X FULLSTOP			{fprintf(stderr,"-1\n");	printf("No, a keyword cannot be a variable name.\n"); printf("Please enter your command.\n");}
|VAR TO IS X COMMA X FULLSTOP				{fprintf(stderr,"-1\n");	printf("No, a keyword cannot be a variable name.\n"); printf("Please enter your command.\n");}
|VAR VALUE IS X COMMA X FULLSTOP			{fprintf(stderr,"-1\n");	printf("No, a keyword cannot be a variable name.\n"); printf("Please enter your command.\n");}
|VAR IN IS X COMMA X FULLSTOP				{fprintf(stderr,"-1\n");	printf("No, a keyword cannot be a variable name.\n"); printf("Please enter your command.\n");}
|VAR VARNAME VARNAME 						{fprintf(stderr,"-1\n");	printf("Sorry I don't understand that.\n"); printf("Please enter your command.\n");}
query: VALUE IN X COMMA X FULLSTOP 			{getVal($<intVal>3,$<intVal>5);}
|VALUE IN NUMBER COMMA X FULLSTOP 			{fprintf(stderr,"-1\n");	printf("There is no tile like that. The tile coordinates must be in the range 1,2,3,4.\n"); printf("Please enter your command.\n");}
|VALUE IN X COMMA NUMBER FULLSTOP 			{fprintf(stderr,"-1\n");	printf("There is no tile like that. The tile coordinates must be in the range 1,2,3,4.\n"); printf("Please enter your command.\n");}
|VALUE IN NUMBER COMMA NUMBER FULLSTOP 		{fprintf(stderr,"-1\n");	printf("There is no tile like that. The tile coordinates must be in the range 1,2,3,4.\n"); printf("Please enter your command.\n");}
|VALUE IN X COMMA X 						{fprintf(stderr,"-1\n");	printf("You need to end a command with a full-stop\n"); printf("Please enter your command.\n");}
|VALUE IN NUMBER COMMA X 					{fprintf(stderr,"-1\n");	printf("You need to end a command with a full-stop\n"); printf("Please enter your command.\n");}
|VALUE IN X COMMA NUMBER 					{fprintf(stderr,"-1\n");	printf("You need to end a command with a full-stop\n"); printf("Please enter your command.\n");}
|VALUE IN NUMBER COMMA NUMBER 				{fprintf(stderr,"-1\n");	printf("You need to end a command with a full-stop\n"); printf("Please enter your command.\n");}
|VALUE VARNAME 								{fprintf(stderr,"-1\n");	printf("Sorry I don't understand that.\n"); printf("Please enter your command.\n");}
|error{yyerrok; yyclearin; fprintf(stderr,"-1\n"); printf("Sorry I don't understand that.\n"); printf("Please enter your command.\n");}
%%

yyerror(char *s){
	//fprintf(stderr, "%s\n",s);
	return 1;
}