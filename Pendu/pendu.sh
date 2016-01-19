#!/bin/bash

# Jeu du Pendu 
# Auteur : Tim C.
# coAuteur : Matthieu Schmit
# v1.0 : 18/01/2016

Fct_Menu() {
	clear
	potence=0
	listelettres=''
	
	echo -e "$JAUNE" "\t\t\t ___________"
	echo -e "$JAUNE" "\t\t\t|           |"
	echo -e "$JAUNE" "\t\t\t| $ROUGE LE PENDU $JAUNE|"
	echo -e "$JAUNE" "\t\t\t|___________|""$NORMAL\n\n"
	echo -e "$BLEU\t _____________\t\t\t ______________"
	echo -e "$BLEU\t|             |\t\t\t|              |" 
	echo -e "$BLEU\t| $VERT (J)1 vs J2$BLEU |\t\t\t| $VERT J1 vs (C)PU$BLEU |"
	echo -e "$BLEU\t|_____________|\t\t\t|______________|"
	
	read -n 1 choixJeu
	case $choixJeu in 
		'j'|'J') Fct_Jeu
			;;
		'c'|'C') Fct_TirerUnMot
			;;
		*) echo -e "$ROUGE Alors, ... C ou J, J ou C, à toi de choisir"
		   read -n 1 choixJeu
	esac
}

Fct_Jeu() {
	clear
	potence=0
	listelettres=''
		
	echo -e "$BLEU Joueur 1, quel est ton nom ? $NORMAL"
	read Joueur1
	if [[ $choixJeu = 'j' || $choixJeu = 'J' ]] ; then
		echo -e "$BLEU Joueur 2, quel est ton nom ? $NORMAL"
		read Joueur2
		echo -e "\n $VERT Qui va devoir deviner le mot ?\n\n"
		
		choixJ=3
		
		while [[ $choixJ -ne 1 && $choixJ -ne 2 ]] ; do 
			echo -e "$JAUNE $Joueur1 (1)\t ou \t $Joueur2 ? (2) \n\n"
			read -n 1 choixJ
		done
	
		statut='ko'
		while [ $statut != 'ok' ] ; do
	
			if [ $choixJ -eq 1 ] ; then 
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
								statut='ok'
			fi
		done
	else Joueur2='BrainMaster'
		 Fct_TirerUnMot
	fi
	Fct_TestAlpha	
	Fct_ProposerLettre
	}
	
Fct_ProposerLettre() {
	Fct_EnleverAccent
	
	echo -e "$BLEU\n\t\t\tC'est parti, on va donc jouer avec ${#MotAdeviner} lettres"
	while [ $potence -lt 10 ]; do
	echo -e "$BLEU Tapez une lettre : \n $NORMAL"
	read -n 1 lettre
	listelettres=$listelettres$lettre
		if [ "$(echo $MotAdeviner | grep $lettre)" = '' ] ; then 
			potence=$((potence+1))
		fi
	cat $dossierDessins${potence}.txt
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
	cat $dossierDessins${potence}.txt
	echo -e "$BLEU RESULTATS FINAUX :"
	echo -e "$VERT ------------------ \n\n"
	echo -e "Vainqueur : $gagnant\n"
	echo -e "$ROUGE""Loser : $perdant\n"
	echo -e "$JAUNE""Mot à deviner : $MotAdeviner (par $cacheur)"
    echo -e "Mot deviné : `echo -e "$MotAdeviner" | sed -e "s/[^${listelettres}@]/ _/g"` (par $devineur)"
    echo -e "Essais : ${#listelettres}"
	
	echo -e "Vainqueur : $gagnant\nPerdant : $perdant\nMot à deviner : $MotAdeviner \n\n" >> .pendu
	
	echo -e "$VERT""Voulez-vous rejouer ? O/N\nOu retourner au (M)enu ?"
	read -n 1 choix
	
	case $choix in 
		'o'|'O') Fct_Jeu
					;;
		'm'|'M') Fct_Menu
					;;
			  *) exit 0
	esac
	}

# Fct_EnleverAccent & Fct_TestAlpha : by M.S.
Fct_EnleverAccent () {
	saveMot=$MotAdeviner
	MotAdeviner=""

	for (( i = 0; i < ${#saveMot}; i++ )); do

		case ${saveMot:$i:1} in
			"é"|"è"|"ê"|"ë")
				MotAdeviner=$MotAdeviner"e"
				;;
			"à"|"â"|"ä")
				MotAdeviner=$MotAdeviner"a"
				;;
			"ç")
				MotAdeviner=$MotAdeviner"c"
				;;
			"ô"|"ö"|"ó"|"ò")
				MotAdeviner=$MotAdeviner"o"
				;;
			"î"|"ï"|"í"|"ì")
				MotAdeviner=$MotAdeviner"i"
				;;
			?)
				MotAdeviner=$MotAdeviner${saveMot:$i:1}
				;;
		esac
	done
}

Fct_TestAlpha () {
	i=0
	while [[ $i -lt ${#MotAdeviner} ]]; do
		if [[ ${MotAdeviner:$i:1} != [[:alpha:]] ]]; then
			echo "Entrez un vrai mot !!!"
			exit 1
		fi
		i=$((i+1))
	done
}

Fct_TirerUnMot () {
	
	nb1=$( wc -l $liste | cut -f1 -d' ' )
	n=$(( RANDOM % $nb1 + 1 ))
	MotAdeviner=$( sed -n ${n}p $liste )
	Fct_ProposerLettre
}
#Couleurs:	
VERT="\\033[1;32m"
NORMAL="\\033[0;39m"
ROUGE="\\033[1;31m"
BLEU="\\033[1;34m"
JAUNE="\\033[1;33m"
CACHE="\\033[47;1;37m"
DEF="\\033[0;0m"

fichierScores=".pendu"
dossierDessins=".Dessins/"
liste=".liste"

Fct_Menu

