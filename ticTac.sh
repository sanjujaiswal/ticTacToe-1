#!/bin/bash 

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
	initalize
}

#initialize board
function initalize(){
   for (( rowPosition=1;rowPosition<=3;rowPosition++ ))
   do
      echo "---------"
      for (( columnPosition=1;columnPosition<=3;columnPosition++ ))
      do
         board[$rowPosition,$columnPosition]="-"
      done
      echo "| ${board[@]} |"
   done
	echo "---------"
}

reset
echo $currentPlayer
