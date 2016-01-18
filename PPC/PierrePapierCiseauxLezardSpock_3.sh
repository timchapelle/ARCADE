#!/bin/bash


# @Author Matthieu Schmit
#
# 19 décembre 2015
#
# Pierre Papier Ciseaux Lezard Spock
#
#	Version améliorée de 'PierrePapierCiseaux.sh'
#	Partie à 2 manches gagnantes
#	Sauvegarde les scores dans un fichier externe
#
#	Modifications
#		22 déc. 2015
#			- Gère les mauvaises entrées des joueurs
#			- Nbre de manches gagnantes décidée par les joueurs
#		23 déc. 2015
#			- (léger) Changement d'affichage pour les scores
#		11 jan. 2016
#			- Possibilité de jouer contre l'ordinateur
#
#	A venir,
#		- Amélioration de l'affichage pour le gagnant d'une manche
#		- Recherche d'un joueur dans le fichier des scores
#
#
#	Aides :
#		https://www.admin-linux.fr/?p=9011
#		http://abs.traduc.org/abs-fr/



# Fonction Menu ()
#	Gère le menu du jeux
FCT_Menu () {
	clear
	echo -e "\\033[4;30m                                          $default"
	echo -e "|   $titre   |"
	echo "|                                        |"
	echo "|                                        |"
	echo "|       J --- Jouer                      |"
	echo "|       R --- Règles                     |"
	echo "|       S --- Scores                     |"
	echo "|       Q --- Quitter                    |"
	echo "|                                        |"
	echo "|                                        |"
	echo -e "\\033[4;30m|                              by SCHMIT |$default"

	read -n 1 choixMenu
	case $choixMenu in
		"j"|"J")
			clear
			echo -e "$titre"
			echo
			echo "Joueur contre l'ordinateur ? (O/N)"
			read -n 1 choixPC
			if [[ $choixPC = "o" || $choixPC = "O" ]]; then
				joueurORDI="OUI"
			else
				joueurORDI="NON"
			fi
			FCT_Jouer
			;;
		"s"|"S")
			FCT_Scores
			;;
		"r"|"R")
			FCT_Regles
			;;
		"q"|"Q")
			clear
			FCT_AuRevoir
			;;
		*)
			FCT_Menu
	esac
	FCT_Menu
}


# Fonction Regles ()
#	Affiche les règles (plutôt logique qd on y pense)
FCT_Regles () {
	clear
	echo -e "$titre"
	echo
	echo -e "\\033[4;34mREGLES$default"
	echo
	echo "    Les ciseaux coupent le papier"
	echo "    Le papier emballent la pierre"
	echo "    La pierre écrase le lézard"
	echo "    Le lézard empoisonne Spock"
	echo "    Spock casse les ciseaux"
	echo "    Les ciseaux décapitent le lézard"
	echo "    Le lézard mange le papier"
	echo "    Le papier discrédite Spock"
	echo "    Spock vaporise la pierre"
	echo "    La pierre casse les ciseaux"
	echo
	echo " --- Press any key to continue ---"
	read -n 1 x
}


# Fonction Verif ()
#	Test (et affichage) pour savoir quel joueur a remporté la manche
FCT_Verif () {
	echo -e "$titre"
	echo
	case $choix1 in
		"1")
			if [ $choix2 = "3" ] || [ $choix2 = "4" ] ; then
				echo -e "$couleurJ1$joueur1 remporte la manche$default"
				pointJ1=$((pointJ1+1))
			elif [ $choix2 = "2" ] || [ $choix2 = "5" ] ; then
				echo -e "$couleurJ2$joueur2 remporte la manche$default"
				pointJ2=$((pointJ2+1))
			else
				echo 'Egalite'
			fi
			;;
		"2")
			if [ $choix2 = "1" ] || [ $choix2 = "5" ] ; then
				echo -e "$couleurJ1$joueur1 remporte la manche$default"
				pointJ1=$((pointJ1+1))
			elif [ $choix2 = "3" ] || [ $choix = "4" ]; then
				echo -e "$couleurJ2$joueur2 remporte la manche$default"
				pointJ2=$((pointJ2+1))
			else
				echo 'Egalite'
			fi
			;;
		"3")
			if [ $choix2 = "2" ] || [ $choix2 = "4" ]; then
				echo -e "$couleurJ1$joueur1 remporte la manche$default"
				pointJ1=$((pointJ1+1))
			elif [ $choix2 = "1" ] || [ $choix2 = "5" ]; then
				echo -e "$couleurJ2$joueur2 remporte la manche$default"
				pointJ2=$((pointJ2+1))
			else
				echo 'Egalite'
			fi
			;;
		"4")
			if [ $choix2 = "2" ] || [ $choix2 = "5" ]; then
				echo -e "$couleurJ1$joueur1 remporte la manche$default"
				pointJ1=$((pointJ1+1))
			elif [ $choix2 = "1" ] || [ $choix2 = "3" ]; then
				echo -e "$couleurJ2$joueur2 remporte la manche$default"
				pointJ2=$((pointJ2+1))
			else
				echo 'Egalite'
			fi
			;;
		"5")
			if [ $choix2 = "1" ] || [ $choix2 = "3" ]; then
				echo -e "$couleurJ1$joueur1 remporte la manche$default"
				pointJ1=$((pointJ1+1))
			elif [ $choix2 = "2" ] || [ $choix2 = "4" ]; then
				echo -e "$couleurJ2$joueur2 remporte la manche$default"
				pointJ2=$((pointJ2+1))
			else
				echo 'Egalite'
			fi
			;;
		*)
			clear
			echo
			echo "Mauvaise entrée." 
			FCT_AuRevoir
	esac
	# Affichage du résultat de la manche
	echo
	echo -e "    ""$couleurJ1$joueur1 : $pointJ1$default"
	echo -e "    ""$couleurJ2$joueur2 : $pointJ2$default"
	echo
	echo " --- Press any key to continue ---"
	read -n 1 x
	clear
}


# Fonction Jouer()
# 	Corps du jeu
#	Boucles gérant les manches et les tours
FCT_Jouer () {
	clear
	echo  -e "$titre"
	echo
	echo -e "$couleurJ1 Nom du premier joueur ?"
	read -p "     " joueur1
	echo -e "$default"
	if [[ $joueurORDI = "NON" ]] ; then
		echo -e "$couleurJ2 Nom du deuxième joueur ?"
		read -p "     " joueur2
		echo -e "$default"
	else
		joueur2="ORDINATEUR"
	fi
	echo
	echo "Combien de manches gagnantes pour une partie ?"
	read nbManche
	let $nbManche
	while [[ $? -eq 1 ]] ; do
		echo -e "$rouge""    MAUVAIS CHOIX. RECOMMENCE.""$default"
		read nbManche
		let $nbManche
	done
	clear

	pointJ1=0
	pointJ2=0

	# Boucle pour joueur
	# Sortie de boucle : le premier à gagner $nbManche manches
	while [ $pointJ1 -ne $nbManche ] && [ $pointJ2 -ne $nbManche ] ; do
		echo -e "$titre"
		echo
		echo -e "$couleurJ1$joueur1, à toi de jouer"
		echo -e "$choix"
		read choix1
		let $choix1 
		while [[ $? -eq 1 ]] || [ $choix1 != "1" ] && [ $choix1 != "2" ] && [ $choix1 != "3" ] && [ $choix1 != "4" ] && [ $choix1 != "5" ] ; do
			echo -e "$rouge    MAUVAIS CHOIX. RECOMMENCE$couleurJ1"
			read choix1
			let $choix1
		done
		echo -e "$default"
		clear

		if [[ $joueurORDI = "NON" ]]; then
			echo -e "$titre"
			echo
			echo -e "$couleurJ2$joueur2, à toi de jouer"
			echo -e "$choix"
			read choix2
			let $choix2
			while [[ $? -eq 1 ]] || [ $choix2 != "1" ] && [ $choix2 != "2" ] && [ $choix2 != "3" ] && [ $choix2 != "4" ] && [ $choix2 != "5" ] ; do
				echo -e "$rouge    MAUVAIS CHOIX. RECOMMENCE.$couleurJ2"
				read choix2
				let $choix2
			done
			echo -e "$default"
		else
			FCT_IA
		fi

		clear
		FCT_Verif
	done
	
	# Met à jour le fichier des scores
	echo -e `date` >> $fichScores
	if [ $pointJ1 -gt $pointJ2 ] ; then
		echo -e "   ""$vert$joueur1   $pointJ1$default - $rouge$pointJ2   $joueur2$default" >> $fichScores
	else
		echo -e "   ""$vert$joueur2   $pointJ2$default - $rouge$pointJ1   $joueur1$default" >> $fichScores
	fi
	echo >> $fichScores

	#Affiche les 3 dernières lignes du fichier (=le résultat de la partie)
	tail -n 3 $fichScores

	echo " --- Press any key to continue ---"
	read -n 1 x
 }


FCT_IA () {
	choix2=$((RANDOM % 5))
	choix2=$(($choix2+1))
	echo -e "$titre"
	echo
	echo -e "$couleurJ2""L'ordinateur a choisi :"
	case $choix2 in
		1 )
			echo "Pierre"
			;;
		2 )
			echo "Papier"
			;;
		3 )
			echo "Ciseaux"
			;;
		4 )
			echo "Lezard"
			;;
		5 )
			echo "Spock"
			;;
	esac
	echo -e "$default"
	echo " --- Press any key to continue ---"
	read -n 1 x
}


# Fonction Scores()
#	Affiche les scores des dernières parties
#	Possibilité de supprimer les scores en mémoire
FCT_Scores () {
	clear

	echo -e "\\033[4;30m                                          $default"
	echo -e "|   $titre   |"
	echo "|                                        |"
	echo -e "|      \\033[4;34mSCORES$default                            |"
	echo "|                                        |"
	echo "|       S --- Voir scores                |"
	echo "|       R --- Rechercher un joueur       |"
	echo "|       D --- Supprimer scores           |"
	echo "|       M --- Retour menu                |"
	echo "|       Q --- Quitter                    |"
	echo -e "\\033[4;30m|                                        |$default"

	read -n 1 choix

	case $choix in 
		"s"|"S"|"r"|"R"|"d"|"D")
			if [ -e $fichScores ] ; then
				if [ $choix = "s" ] || [ $choix = "S" ] ; then
					clear
					echo -e "$titre - \\033[4;34mSCORES$default"
					echo
					cat $fichScores
					echo
					echo " --- Press any key to continue ---"
					read -n 1 x
					FCT_Scores
				elif [ $choix = "d" ] || [ $choix = "D" ] ; then
					clear
					echo -e "$titre"
					echo
					echo "Absolument certain de tout supprimer ? (O/N)"
					read -n 1 ON
					if [ $ON = "o" ] || [ $ON = "O" ] ; then
						rm $fichScores
						clear
						echo "Scores supprimés"
						sleep 2
						FCT_Menu
					else
						echo
						echo "Bah faut pas demander de les supprimer alors. Crétin..."
						sleep 4
						FCT_Scores
					fi
				elif [ $choix = "r" ] || [ $choix = "R" ] ; then
					clear
					echo "Recherche bientôt disponible.."
					echo
					echo " --- Press any key to continue ---"
					read -n 1 x
					FCT_Scores
				fi
			else
				clear
				echo -e "$titre"
				echo
				echo "Aucun score enregistré"
				echo "Va jouer un peu, puis reviens ici"
				echo
				echo " --- Press any key to continue ---"
				read -n 1 x
				FCT_Menu
			fi	
			;;
		"m"|"M")
			FCT_Menu
			;;
		"q"|"Q")
			FCT_AuRevoir
			;;
		*)
			FCT_Scores
	esac
}


# Fonction AuRevoir()
#	Affiche, qd on quitte, Valéry Giscard d'Estaing et son fameux 'Au revoir.'
#	A venir, inshallah : en couleur
FCT_AuRevoir () {
	echo
	echo -e '   |                         ;*`¨=.                          |'
	echo -e '   |                        :..  .:.                         |'
	echo -e '   |                        !!*][5..                         |'  
	echo -e '   |                        :F.{] :`                         |' 
	echo -e '   |                         ;=[]]i.                         |'
	echo -e '   |                   :.,=^`{lepF}. `"=..                   |'
	echo -e '   |                  ;       L#{kF      J:                  |'
	echo -e '   |                  ]       TLJ3L-=    :\.                 ('
	echo -e '   |                 ;.        lC$.        .                 |'
	echo -e '   |       .zUX@Q....L   .   .         :                     |'
	echo -e '   | ,..;+Valéry+z5s&s.-      .:..     :    :-~~~~~~~=====~~~('
	echo -e '   |    }+Giscard+@5QE`  :;.zSKE2Eh<zs;  `   .               |'
	echo -e '   |    4+d`Estaing+2K.  J25@5E5dUDuZ@E;;;;;ci..             |'
	echo
	echo
	echo -e "    #####  #   #     #####  #####  #   #  #####  #####  #####"
	echo -e "    #   #  #   #     #   #  #      #   #  #   #    #    #   #"
	echo -e "    #####  #   #     #####  #####  #   #  #   #    #    #####"
	echo -e "    #   #  #   #     #  #   #       # #   #   #    #    #  #"
	echo -e "    #   #  #####     #   #  #####    #    #####  #####  #   #"
	echo
	exit 0
}


# 'main' du jeu

# Initialisation des variables 'globales'
titre="\\033[4;34m\\033[1;34mPierre Papier Ciseaux Lezard Spock\\033[0m"
couleurJ1="\\033[35m"
couleurJ2="\\033[36m"
vert="\\033[32m"
rouge="\\033[31m"
default="\\033[0m"
fichScores=".ScoresPPCLS"

choix="\n1. Pierre\n2. Papier\n3. Ciseaux\n4. Lezard\n5. Spock\n\n"

# Debut du jeux
FCT_Menu
