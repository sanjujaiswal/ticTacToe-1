#!/bin/bash -x

function reset(){
	echo "Tic Tac Toe Game"
	player=x;
	gameStatus=1;
	declare -A board;
}

reset
