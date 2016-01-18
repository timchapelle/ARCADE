#!/bin/bash
#Auteurs : Tim C. & Matth S.
#Release v1.0 : 18/01/2016

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

