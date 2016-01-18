#!/bin/bash

# Jeu du Pendu 
# Auteur : Tim C.
# v1.0 : 18/01/2016

Fct_Jeu() {
	clear
	potence=0
	listelettres=''
		
	echo -e "$ROUGE" "\t\t\tLE PENDU"
	echo -e "$JAUNE" "\t\t\t--------""$NORMAL\n\n"
		
	echo -e "$BLEU Joueur 1, quel est ton nom ? $NORMAL"
	read Joueur1
	echo -e "$BLEU Joueur 2, quel est ton nom ? $NORMAL"
	read Joueur2
	
	echo -e "\n $VERT Qui va devoir deviner le mot ?\n\n"
	echo -e "$JAUNE $Joueur1 (1)\t ou \t $Joueur2 ? (2) \n\n"
	read -n 1 x
	
	statut='ko'
	while [ $statut != 'ok' ] ; do
	
		if [ $x -eq 1 ] ; then 
		echo -e "$VERT $Joueur2, rentre le mot à deviner (3-10 lettres)\n\n$CACHE"
			devineur=$Joueur1
			cacheur=$Joueur2
		else 
			echo -e "$VERT $Joueur1, rentre le mot à deviner (3-10 lettres)\n\n$CACHE"
			devineur=$Joueur2
			cacheur=$Joueur1
		fi
		
	read MotAdeviner
	longueur=${#MotAdeviner}
		
		if [ $longueur -lt 3 ] ; then 
			echo -e "$DEF""$ROUGE Ce mot est trop court ! Entrez un mot de min. 3 caractères $NORMAL"
			statut='ko'
		elif  [ $longueur -gt 10 ] ; then
			echo -e "$DEF""$ROUGE Ce mot est trop long ! Entrez un mot contenant max. 10 caractères $NORMAL"
			statut='ko'
		else 
			echo -e "$DEF"
			clear
			echo -e "$BLEU\n\t\t\tC'est parti, on va donc jouer avec ${#MotAdeviner} lettres"
			statut='ok'
			Fct_ProposerLettre
		fi
	done 
	}
	
Fct_ProposerLettre() {
	
	while [ $potence -lt 10 ]; do
	echo -e "$BLEU Tapez une lettre : \n $NORMAL"
	read -n 1 lettre
	listelettres=$listelettres$lettre
		if [ "$(echo $MotAdeviner | grep $lettre)" = '' ] ; then 
			potence=$((potence+1))
		fi
	cat ./Dessins/${potence}.txt
	echo $MotAdeviner | sed -e "s/[^${listelettres}@]/ _/gI"
	echo "Ne sont pas dans le mot :"
	echo $listelettres | sed -e "s/[$MotAdeviner]//gI"
	
	Fct_Test_Mot_Complet	
	
	done
	
	Fct_Perdu
	}
	
Fct_Test_Mot_Complet() {
	
	reste_a_trouver=$( echo $MotAdeviner | sed -e "s/[$listelettres]//gI" )
	
	if [ "$reste_a_trouver" = '' ] ; then 
		
		echo -e "$VERT GAGNE !!! $devineur CHAMPION !!!"
		gagnant=$devineur
		perdant=$cacheur
		Fct_Scores
		
	else Fct_ProposerLettre
	 
	fi
	}

Fct_Perdu() {
	
	echo -e "$JAUNE t'as perdu !!! ahahah $cacheur t'a bien eu !"
	
	gagnant=$cacheur
	perdant=$devineur
	
	Fct_Scores
	}
	
Fct_Scores() {
	
	clear
	cat ./Dessins/${potence}.txt
	echo -e "$BLEU RESULTATS FINAUX :"
	echo -e "$VERT ------------------ \n\n"
	echo -e "Vainqueur : $gagnant\n"
	echo -e "$ROUGE""Loser : $perdant\n"
	echo -e "$JAUNE""Mot à deviner : $MotAdeviner (par $cacheur)"
    echo -e "Mot deviné : `echo -e "$MotAdeviner" | sed -e "s/[^${listelettres}@]/ _/g"` (par $devineur)"
    echo -e "Essais : ${#listelettres}"
	
	echo -e "Vainqueur : $gagnant\nPerdant : $perdant\nMot à deviner : $MotAdeviner \n\n" >> pendu.txt
	
	echo -e "$VERT""Voulez-vous rejouer ? O/N"
	read -n 1 choix
	
	case $choix in 
		'o'|'O') Fct_Jeu
					;;
			  *) exit 0
					;;
	esac
	}
		
#Couleurs:	
VERT="\\033[1;32m"
NORMAL="\\033[0;39m"
ROUGE="\\033[1;31m"
BLEU="\\033[1;34m"
JAUNE="\\033[1;33m"
CACHE="\\033[47;1;37m"
DEF="\\033[0;0m"

Fct_Jeu
