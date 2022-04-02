#!/bin/bash

# Variables:

STARTLS=~/startDirLs.txt
CURLS=~/curDirLs.txt
LOGLS=~/chgDirLog.txt
CHECKLS=~/checkDirLs.txt

# Functions:

function LsDir () {
	find ~/ | grep -Pwv "$STARTLS|$CURLS|$LOGLS" | sort
}

function DiffLog () {
	diff $STARTLS $CURLS 
}
# Code:

if [ -e $STARTLS ]
    then
        if [ -f $STARTLS ]
            then
                echo "the '$STARTLS' file exists"
		LsDir > $CURLS
		
		DiffLog
		if $(echo $?)=0
			then
				echo "There are no changes in the checked directory"
			else
				if $(echo $?)=1
					then
						echo "Changes have been detected in the directory being checked!!!"
						DiffLog > $CHECKLS
				fi
		fi	
	
		
            else
                echo "'$STARTLS' - is not a file, a file named '$STARTLS' will be created"
                LsDir  > $STARTLS
        fi
    else
        echo "the '$STARTLS' file does not exist, this file will be created"
        LsDir > $STARTLS
fi

