# 2048_parser
In the terminal run the make command to execute the Makefile. Once the make file is run ./2048 is run the final code

Ctrl+C can be used to stop running the execution. 

Possible Errors handled
> Not adding a full stop after end of statements
> Keywords added for variable names
> Operations followed by incorrect names
> Operations preeceded by incorrect names. 
> Invalid points in the x,y matrix
> Adding multiple random texts
> Assigning variable names as values for (x,y) in matrix

Whenever there is a change in the the value in the matrix or there is a change in the text we print all the values and the texts in stderr

Add operation happens irrespective of whether the tiles are the same or not. While Multiply/Divide/Subtract happen only when the tiles have the same values.

ADD RIGHT : 0 0 1 1 -> 0 0 0 2
SUBTRACT RIGHT ; 0 0 1 1 -> 0 0 0 0 
MULTIPLY RIGHT : 0 0 4 4 -> 0 0 0 16
DIVIDE RIGHT : 0 0 4 4 -> 0 0 0 16

The top left corner is choose as (0,0) and a row major format is followed. 

The value of a tile can be changed any number of times using the assign function. The tile can also be given multiple names. When the tiles are merged the names are also merged accordingly. However a tile with a 0 value cannot be given a name. When two values are subtracted the names are however lost. 
