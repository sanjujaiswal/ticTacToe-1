#!/bin/bash

#constants
TOTALCOUNT=9;
ROW=3;
COLUMN=3;

#variables
moveCount=1;
computerPlayer="0";

#declare array
declare -A board

#who play first
function whoPlayFirst(){
	randomPlayer=$((RANDOM%2))
	if [ $randomPlayer -eq 0 ]
	then
		echo "x"
	else
		echo $computerPlayer
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
   for (( rowPosition=1;$rowPosition<=$ROW;rowPosition++ ))
   do
      for (( columnPosition=1;$columnPosition<=$COLUMN;columnPosition++ ))
      do
         board[$rowPosition,$columnPosition]="-"
      done
   done
	printBoard
}


# print board
function printBoard(){
	echo "---------------"
	for (( row=1;row<=$ROW;row++ ))
	do
		for (( column=1;column<=$COLUMN;column++ ))
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
	for (( i=1;i<=$ROW;i++ ))
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
}

#write mark on board
function placeMark(){
	if [[ ${board[$1,$2]} == - ]]
	then
		board[$1,$2]=$currentPlayer
		printBoard
		checkWin
		if [[ $gameStatus -eq 1 ]]
		then
			echo "$currentPlayer wins"
			exit
		fi
		changePlayer $currentPlayer
		((moveCount++))
	else
		echo "Already occupied"
	fi
}

#calculate column
function calColumn(){
	if [[ $1%$COLUMN -eq 0 ]]
	then
		column=$COLUMN;
	else
		column=$(($1%$COLUMN))
	fi
	echo $column
}

# check win before play
function playToWinAndBlock(){
	for (( row=1;row<=$ROW;row++ ))
	do
		for (( column=1;column<=$COLUMN;column++ ))
		do
			if [[ ${board[$row,$column]} == - ]]
			then
				board[$row,$column]=$currentPlayer
				checkWin
				if [[ $gameStatus -eq 0 ]]
				then
					board[$row,$column]="-"
				elif [[ $gameStatus -eq 1 && ${board[$row,$column]} -eq $currentPlayer ]]
				then
					printBoard
					echo "$currentPlayer wins ! "
					exit
				elif [[ $gameStatus -eq 1 ]]
				then
					board[$row,$column]=$currentPlayer
					printBoard
					gameStatus=0;
					((moveCount++))
					break
				fi
			fi
		done
	done
}

#start execution
reset
while [[ $moveCount -le $TOTALCOUNT ]]
do
	if [[ $currentPlayer == x ]]
	then
		read -p "Enter position between 1-9 : " position
		#calculate row and column
		row=$(((($position-1)/$ROW)+1))
		column=$( calColumn $position ) 
		placeMark $row $column
	else
		playToWinAndBlock
		row=$(((RANDOM%3)+1))
		column=$(((RANDOM%3)+1))
		placeMark $row $column
	fi 
done

if [[ $gameStatus -eq 0 ]]
then
	echo "Match tie ! "
fi
