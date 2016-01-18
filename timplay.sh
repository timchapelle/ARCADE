#!/bin/bash

cat .tux
echo
read -n 1 x

case $x in 
	'p'|'P') cd PPC/ 
			./papierciseaupierrev3_0
		;;
	'h'|'H') cd Pendu/ 
			./pendu.sh 
		;;
	*) echo "Entre un choix valide : P ou H"
esac

