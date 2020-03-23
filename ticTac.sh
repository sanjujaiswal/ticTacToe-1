#!/bin/bash

#constants
TOTALCOUNT=9;

#variables
moveCount=1;

#declare array
declare -A board
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
	gameStatus=0;
	initalize
}
#initialize board
function initalize(){
   for (( rowPosition=1;$rowPosition<=3;rowPosition++ ))
   do
      for (( columnPosition=1;$columnPosition<=3;columnPosition++ ))
      do
         board[$rowPosition,$columnPosition]="-"
      done
   done
	printBoard
}


# print board
function printBoard(){
	echo "---------------"
	for (( row=1;row<=3;row++ ))
	do
		for (( column=1;column<=3;column++ ))
		do
			echo -e "| ${board[$row,$column]} | \c"
		done
		echo
	done
	echo "---------------"
}

#change player
function changePlayer(){
	if [[ $1 == "x" ]]
	then
		currentPlayer="0";
	else
		currentPlayer="x";
	fi
}

#check win
function checkWin(){
	gameStatus=0;
	for (( i=1;i<=3;i++ ))
	do
		if [[ ${board[$i,1]} == $currentPlayer && ${board[$i,1]} == ${board[$i,2]} && ${board[$i,1]} == ${board[$i,3]} ]]
		then
			gameStatus=1;
		fi
		if [[ ${board[1,$i]} == $currentPlayer && ${board[1,$i]} == ${board[2,$i]} && ${board[1,$i]} == ${board[3,$i]} ]]
		then
			gameStatus=1;
		fi
	done
	
	if [[ ${board[1,1]} == $currentPlayer &&  ${board[1,1]} == ${board[2,2]} && ${board[1,1]} == ${board[3,3]} ]]
	then
		gameStatus=1;
	fi
	
	if [[ ${board[1,3]} == $currentPlayer && ${board[1,3]} == ${board[2,2]} && ${board[1,3]} == ${board[3,1]} ]]
	then
		gameStatus=1;
	fi
	
	echo $gameStatus
}

#write mark on board
function placeMark(){
	if [[ ${board[$1,$2]} == - ]]
	then
		board[$1,$2]=$currentPlayer
		printBoard
		if [[ $( checkWin $(()) ) -eq 1 ]]
		then
			echo "$currentPlayer wins"
			exit
		fi
		changePlayer $currentPlayer
	else
		echo "Already occupied"
	fi
}

#start execution
reset
while [[ $moveCount -le $TOTALCOUNT ]]
do
	read -p "Enter row " row
	read -p "Enter column " column
	placeMark $row $column
	((moveCount++)) 
done

if [[ $gameStatus -eq 0 ]]
then
	echo "Match tie ! "
fi 
