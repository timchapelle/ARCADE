#!/bin/bash

# @author Matthieu Schmit - 22 janvier 16
# 	Dessins des cartes : Tim C.
#
# jeuCarte.sh -- v1.0
# 
# Bataille, où les joueurs peuvent chosir leurs cartes
#
#	Prochainement :
#		Gestion des tours
#		Gestion des scores
#		Amélioration de l'affichage
#		Règles (?)
#		...



# Fonction Menu ()
#	Gère le menu du jeux
FCT_Menu () {
	clear
	echo -e "\\033[4;30m                                           $default"
	echo -e "|              $titre              |"
	echo "|                                         |"
	echo "|                                         |"
	echo "|       J --- Jouer                       |"
	echo "|       S --- Scores                      |"
	echo "|       Q --- Quitter                     |"
	echo "|                                  v1.0   |"
	echo "|                                         |"
	echo -e "\\033[4;30m|            by SCHMIT (dessins : Tim C.) |$default"

	read -n 1 choixMenu
	case $choixMenu in
		"j"|"J")
			FCT_Init
			;;
		"s"|"S")
			clear
			echo "Pas encore dispo"
			echo
			echo " --- Press any key to continue ---"
			read -n 1 x
			FCT_Menu
			;;
		"q"|"Q")
			clear
			echo "bye"
			exit 0
			;;
		*)
			FCT_Menu
	esac
	FCT_Menu
}

# Rempli la pioche pour les jeux où l'as = 14
FCT_Pioche_A14 () {
	d=$dossierDessin
	echo -e "$d""02_coeur\n""$d""03_coeur\n""$d""04_coeur\n""$d""05_coeur\n""$d""06_coeur\n""$d""07_coeur\n""$d""08_coeur\n""$d""09_coeur\n""$d""10_coeur\n""$d""11_coeur\n""$d""12_coeur\n""$d""13_coeur\n""$d""14_coeur" >> $nomFichier
	echo -e "$d""02_car\n""$d""03_car\n""$d""04_car\n""$d""05_car\n""$d""06_car\n""$d""07_car\n""$d""08_car\n""$d""09_car\n""$d""10_car\n""$d""11_car\n""$d""12_car\n""$d""13_car\n""$d""14_car" >> $nomFichier
	echo -e "$d""02_trfl\n""$d""03_trfl\n""$d""04_trfl\n""$d""05_trfl\n""$d""06_trfl\n""$d""07_trfl\n""$d""08_trfl\n""$d""09_trfl\n""$d""10_trfl\n""$d""11_trfl\n""$d""12_trfl\n""$d""13_trfl\n""$d""14_trfl" >> $nomFichier
	echo -e "$d""02_piq\n""$d""03_piq\n""$d""04_piq\n""$d""05_piq\n""$d""06_piq\n""$d""07_piq\n""$d""08_piq\n""$d""09_piq\n""$d""10_piq\n""$d""11_piq\n""$d""12_piq\n""$d""13_piq\n""$d""14_piq" >> $nomFichier
}

# Rempli la pioche pour les jeux où l'as = 1
FCT_Pioche_A01 () {
	d=$dossierDessin
	echo -e "$d""01_coeur\n""$d""02_coeur\n""$d""03_coeur\n""$d""04_coeur\n""$d""05_coeur\n""$d""06_coeur\n""$d""07_coeur\n""$d""08_coeur\n""$d""09_coeur\n""$d""10_coeur\n""$d""11_coeur\n""$d""12_coeur\n""$d""13_coeur" >> $nomFichier
	echo -e "$d""01_car\n""$d""02_car\n""$d""03_car\n""$d""04_car\n""$d""05_car\n""$d""06_car\n""$d""07_car\n""$d""08_car\n""$d""09_car\n""$d""10_car\n""$d""11_car\n""$d""12_car\n""$d""13_car" >> $nomFichier
	echo -e "$d""01_trfl\n""$d""02_trfl\n""$d""03_trfl\n""$d""04_trfl\n""$d""05_trfl\n""$d""06_trfl\n""$d""07_trfl\n""$d""08_trfl\n""$d""09_trfl\n""$d""10_trfl\n""$d""11_trfl\n""$d""12_trfl\n""$d""13_trfl" >> $nomFichier
	echo -e "$d""01_piq\n""$d""02_piq\n""$d""03_piq\n""$d""04_piq\n""$d""05_piq\n""$d""06_piq\n""$d""07_piq\n""$d""08_piq\n""$d""09_piq\n""$d""10_piq\n""$d""11_piq\n""$d""12_piq\n""$d""13_piq" >> $nomFichier
}


# Sort une carte de la pioche au hasard
FCT_PiocheCarte () {
	# Nombre de cartes restantes dans la pioche
	nbligne=`wc -l $nomFichier`
	xy=${#nomFichier} # nbre de caractères du nom du fichier
	nbligne=${nbligne:0:$((${#nbligne}-$xy))} 
	
	# Choisi une carte au hasard dans la pioche
	numCarte=$(( ( RANDOM % ${nbligne} )  + 1 ))

	# Supprime la carte de la pioche
	carte=`sed -n "${numCarte} p" $nomFichier`
	sed -i".temp" "${numCarte}d" $nomFichier
	rm "$nomFichier".temp
}


# Affiche jusqu'à 8 cartes sur la même ligne
# $1=carte1 ; $2=carte2 ; ... ; $8=carte8
FCT_AffichageCartes () {
	echo
	for (( i = 1; i < 7; i++ )); do
		ligneC1=`sed -n "${i} p" $1`
		if [[ $2 ]]; then
			ligneC2=`sed -n "${i} p" $2`
		else
			ligneC2=""
		fi
		if [[ $3 ]]; then
			ligneC3=`sed -n "${i} p" $3`
		else
			ligneC3=""
		fi
		if [[ $4 ]]; then
			ligneC4=`sed -n "${i} p" $4`
		else
			ligneC4=""
		fi
		if [[ $5 ]]; then
			ligneC5=`sed -n "${i} p" $5`
		else
			ligneC5=""
		fi
		if [[ $6 ]]; then
			ligneC6=`sed -n "${i} p" $6`
		else
			ligneC6=""
		fi
		if [[ $7 ]]; then
			ligneC7=`sed -n "${i} p" $7`
		else
			ligneC7=""
		fi
		if [[ $8 ]]; then
			ligneC8=`sed -n "${i} p" $8`
		else
			ligneC8=""
		fi
		echo -e "$ligneC1    $ligneC2    $ligneC3    $ligneC4    $ligneC5    $ligneC6    $ligneC7    $ligneC8"
	done
	
	for (( i = 0; i < 8; i++ )); do
		cpt=$((cpt+1))
		if [[ $cpt -le taille ]]; then
			if [[ $cpt -ge 10 ]]; then
				echo -n "    $cpt        "
			else
				echo -n "    $cpt         "
			fi
		fi
	done
	echo
	echo
}


# Affiche la main d'un joueur
# $1 = fichierDuJoueur
FCT_AffichageMain () {
	main="$1"
	echo
	nbC=`wc -l $main`
	xy=${#main} # nbre de caractères du nom du fichier
	nbC=${nbC:0:$((${#nbC}-$xy))}
	taille=$nbC
	nbC=$((nbC+7))
	nbBoucle=$((1+nbC/8))
	j=1
	k=1
	cpt=0
	while [[ $j -lt $nbBoucle ]]; do
		k2=$((k+1)) ; k3=$((k+2)) ; k4=$((k+3)) ; k5=$((k+4)) ; k6=$((k+5)) ; k7=$((k+6)) ; k8=$((k+7))
		FCT_AffichageCartes `sed -n "${k} p" $main` `sed -n "${k2} p" $main` `sed -n "${k3} p" $main` `sed -n "${k4} p" $main` `sed -n "${k5} p" $main` `sed -n "${k6} p" $main` `sed -n "${k7} p" $main` `sed -n "${k8} p" $main`
		j=$((j+1))
		k=$((k+8))
	done
	echo
	echo
}


# Distribue $1 cartes pour le joueur $2(fichierMain)
FCT_Distribue () {
	for (( i = 0; i < $1; i++ )); do
		FCT_PiocheCarte
		echo "$carte" >> $2
	done
}


# Initialise la partie
FCT_Init () {
	clear
	echo -e $titre
	echo -e "\\033[4;34m\\033[1;34mBataille\\033[0m"
	echo
	echo -e "$couleurJ1""Nom joueur 1 ?"
	read nom1
	echo -e "$couleurJ2""Nom joueur 2 ?"
	read nom2
	echo -e "$default"
	echo
	echo "Considérer l'as comme la carte la plus forte ? [0/N]"
	read -n 1 choix
	if [[ $choix = "o" || $choix = "O" ]]; then
		FCT_Pioche_A14
	else
		FCT_Pioche_A01
	fi

	mainJ01="$dossierPartie""$nom1"
	mainJ02="$dossierPartie""$nom2"

	FCT_Distribue 26 $mainJ01
	FCT_Distribue 26 $mainJ02

	# Trie les mains par ordre croissant
	sort $mainJ01 >> temp1
	rm $mainJ01
	cat temp1 >> $mainJ01
	rm temp1
	sort $mainJ02 >> temp2
	rm $mainJ02
	cat temp2 >> $mainJ02
	rm temp2

	FCT_Jouer
}



FCT_Jouer () {
	clear
	echo -e "$titre -- Bataille"
	echo
	echo -e "$couleurJ1$nom1$default ce sera à toi de jouer.."
	echo
	echo " --- Press any key to continue ---"
	read -n 1 x
	echo
	echo -e "$couleurJ1""Quelle carte choisis tu ?"
	FCT_AffichageMain $mainJ01
	read choix1
	echo -e "$default"

	clear
	echo -e "$titre -- Bataille"
	echo
	echo -e "$couleurJ2$nom2$default ce sera à toi de jouer.."
	echo
	echo " --- Press any key to continue ---"
	read -n 1 x
	echo
	echo -e "$couleurJ2""Quelle carte choisis tu ?"
	FCT_AffichageMain $mainJ02
	read choix2
	echo -e "$default"
	

	FCT_Comparer `sed -n "${choix1} p" $mainJ01` `sed -n "${choix2} p" $mainJ01`


	# Supprime les cartes choisies des mains
	sed -i".temp" "${choix1}d" $mainJ01
	rm "$mainJ01".temp
	sed -i".temp" "${choix2}d" $mainJ02
	rm "$mainJ02".temp


	FCT_Jouer
	exit 0
}


# Compare deux cartes
# $1 carte 1
# $2 carte 2
FCT_Comparer () {
	c1=$1
	c2=$2
	carte1=${c1:10:2}
	carte2=${c2:10:2}
	echo "c1 : $carte1 ; $c1"
	echo "c2 : $carte2 ; $c2"
	if [[ $carte1 -gt $carte2 ]]; then
		echo "Carte 1 plus grande."
		echo "Joueur 1 gagne"
	elif [[ $carte1 -lt $carte2 ]]; then
		echo "Carte 2 plus grande"
		echo "Joueur 2 gagne"
	else
		echo "Egalite"
	fi
	echo
	echo " --- Press any key to continue ---"
	read -n 1 x
}



# Variable globale
dossierPartie=".partie/"
dossierDessin=".dessinsCartes/"
nomFichier="$dossierPartie""dock"
titre="\\033[4;34m\\033[1;34mJeu de cartes\\033[0m"
couleurJ1="\\033[35m"
couleurJ2="\\033[36m"
vert="\\033[32m"
rouge="\\033[31m"
default="\\033[0m"

# Supprime le dossier de la partie antérieure, s'il existe
if [[ -e $dossierPartie ]]; then
	rm -Rf $dossierPartie
fi
# Crée le dossier de la partie
mkdir $dossierPartie


FCT_Menu


