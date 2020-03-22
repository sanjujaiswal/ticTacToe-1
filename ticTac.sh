#!/bin/bash -x

#who play first
function whoPlayFirst(){
	randomPlayer=$((RANDOM%2))
	if [ $randomPlayer -eq 0 ]
	then
		echo "x"
	else
		echo "0"
	fi
}

#reset board
function reset(){
	echo "Tic Tac Toe Game"
	currentPlayer=$( whoPlayFirst $(()) );
	gameStatus=1;
	declare -A board;
}
reset
echo $currentPlayer
