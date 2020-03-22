#!/bin/bash -x

function reset(){
	echo "Tic Tac Toe Game"
	currentPlayer=x;
	gameStatus=1;
	declare -A board;
}
reset
echo $currentPlayer
