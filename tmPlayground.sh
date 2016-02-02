#!/bin/bash
#Auteurs : Tim C. & Matth S.
#Release v1.0 : 18/01/2016

cat .tux
echo
read -n 1 x
statut='ko'
while [ $statut != 'ok' ] ; do
	case $x in 
	'p'|'P') statut='ok' 
			cd PPC/ 
			clear
			./papierciseaupierrev3_0
		;;
	'h'|'H') statut='ok'
			cd Pendu/
			clear
			./pendu.sh 
		;;
	'l'|'L') statut='ok' 
			cd PPC/
			clear
			./PierrePapierCiseauxLezardSpock_3.sh
		;;
	'c'|'C') statut='ok' 
			cd PPC_C++
			clear
			./PPCv2
		;;
	'b'|'B') statut='ok'
			cd lesBatonnets++/
			clear
			./lesBatonnets
		;;
	*) echo "Entre un choix valide, jeune padawan : [C-H-L-P]"
	   read -n 1 x
	esac
done
