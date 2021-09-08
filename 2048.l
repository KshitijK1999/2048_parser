%{
#include "2048.tab.h"
%}

%option noyywrap


%%
"."			{return FULLSTOP;}
","			{return COMMA;}
[\n]		{return NL;}		
"ADD"		{return ADD;}
"SUBTRACT"	{return SUBTRACT;}
"MULTIPLY"	{return MULTIPLY;}
"DIVIDE"	{return DIVIDE;}
"RIGHT"		{return RIGHT;}
"UP"		{return UP;}
"DOWN"		{return DOWN;}
"LEFT"		{return LEFT;}
"VAR"		{return VAR;}
"IS"		{return IS;}
"ASSIGN"	{return ASSIGN;}
"TO"		{return TO;}
"VALUE"		{return VALUE;}
"IN"		{return IN;}
[1234]		{yylval.intVal = atoi(yytext);	return X;}
[0-9]+		{yylval.intVal = atoi(yytext);	return NUMBER;}
[A-Za-z0-9_]+	{yylval.stringVal = strdup(yytext);	return VARNAME;}
[ \t]
.
%%