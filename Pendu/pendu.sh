#!/bin/bash
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
#                                                     # 
#        LE JEU DU PENDU - PAR TIM C. & MATTH S.      # 
#                                                     #
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
# Release v1.0 : 18/01/2016

# Ce jeu a été codé uniquement avec des fonctions.
# Le jeu se lance en appelant uniquement la Fct_Menu. Rien d'autre (excepté l'initialisation
# des variables de couleurs de texte) ne se trouve dans le "main".
# 2 modes de jeu sont actuellement possibles : 1 vs 1 ou 1 vs CPU

# TODO : vérifier Fct_TirerUnMot (1 caractère en trop à la fin du mot tiré)

# Fonction Menu : appelée en premier lieu. Permet de définir le mode de jeu.
Fct_Menu() {
	clear
	
	potence=0         # (Ré-)Initialisation du compteur pour l'affichage des dessins de la potence
	listelettres=''   # Ré-initialisation de la liste de lettres entrées par l'utilisateur, si celui-ci rejoue.
	
	echo -e "$JAUNE" "\t\t\t ___________"
	echo -e "$JAUNE" "\t\t\t|           |"
	echo -e "$JAUNE" "\t\t\t| $ROUGE LE PENDU $JAUNE|"
	echo -e "$JAUNE" "\t\t\t|___________|""$NORMAL\n\n"
	echo -e "$BLEU\t _____________\t\t\t ______________"
	echo -e "$BLEU\t|             |\t\t\t|              |" 
	echo -e "$BLEU\t| $VERT (J)1 vs J2$BLEU |\t\t\t| $VERT J1 vs (C)PU$BLEU |"
	echo -e "$BLEU\t|_____________|\t\t\t|______________|"
	
	read -n 1 choixJeu       # Le prochain caractère lu sera stocké dans la variable 'choixJeu'
	case $choixJeu in        
		'j'|'J') Fct_Jeu
			;;
		'c'|'C')echo -e "$BLEU Joueur 1, quel est ton nom ? $NORMAL"
				read Joueur1 
				Joueur2='BrainMaster'    # Initialisation du nom du Bot
				cacheur='BrainMaster'    # Utile pour l'affichage plus tard
				devineur=Joueur1         # Idem
				Fct_TirerUnMot           # Appel de la fonction pour sélectionner un mot au hasard
			;;
		*) echo -e "$ROUGE Alors, ... C ou J, J ou C, à toi de choisir" 
		   read -n 1 choixJeu    # Si l'utilisateur entre un mauvaix choix, on relit son choix
	esac
}

# Fonction Jeu : utilisée en mode 1 vs 1

Fct_Jeu() {
	clear
	potence=0
	listelettres=''
		
	echo -e "$BLEU Joueur 1, quel est ton nom ? $NORMAL"
	read Joueur1
	
	echo -e "$BLEU Joueur 2, quel est ton nom ? $NORMAL"
	read Joueur2
	echo -e "\n $VERT Qui va devoir deviner le mot ?\n\n"
		
# Boucle pour forcer les joueurs à rentrer un choix de cacheur/devineur valable
	choixJ=3
	while [[ $choixJ -ne 1 && $choixJ -ne 2 ]] ; do 
		echo -e "$JAUNE $Joueur1 (1)\t ou \t $Joueur2 ? (2) \n\n"
		read -n 1 choixJ
	done # Fin de boucle
	
# Boucle pour forcer l'utilisateur à entrer un mot entre 3 et 10 caractères
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
	
		longueur=${#MotAdeviner}  # longueur = Nombre de caractres de la variable MotAdeviner
	
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
	done # Fin de boucle

	Fct_TestAlpha        # Appel de la fonction vérifiant la présence de caractères numériques dans le mot entré par l'utilisateur
	Fct_EnleverAccent	 # Appel de la fonction permettant d'enlever les accents du mot entré par l'utilisateur
	Fct_ProposerLettre   # Appel de la fonction permettant de commencer à deviner le mot
	}
	
# Fonction ProposerLettre : permet de proposer des lettres et de vérifier leur présence dans le mot à deviner
Fct_ProposerLettre() {
		
	echo -e "$BLEU\n\t\t\tC'est parti, $Joueur2 a choisi un mot de ${#MotAdeviner} lettres"
	
# Début de boucle : tant que l'utilisateur n'a pas fait 10 erreurs, faire ...
	while [ $potence -lt 10 ]; do
	echo -e "$BLEU Tapez une lettre : \n $NORMAL"
	read -n 1 lettre
	echo
	listelettres=$listelettres$lettre
		if [ "$(echo $MotAdeviner | grep $lettre)" = '' ] ; then    # Si la lettre ne se trouve pas dans le mot à deviner
			potence=$((potence+1))                                  # alors on incrémente la potence de 1
		fi
	cat $dossierDessins${potence}.txt                               # Affichage du dessin de potence correspondant
	echo $MotAdeviner | sed -e "s/[^${listelettres}@]/ _/g"         # Remplacement et affichage des lettres du mot par des ' _ '
	echo "Ne sont pas dans le mot :"
	echo $listelettres | sed -e "s/[$MotAdeviner]//gI"              # Affichage des lettres proposées ne se trouvant pas dans le mot à deviner
	
	Fct_Test_Mot_Complet	 # Appel de la fonction permettant de tester si le joueur a trouvé toutes les lettres
	
	done
	
	Fct_Perdu   # Après 10 mauvaises tentatives, on lance la Fonction Perdu !
	}
	
Fct_Test_Mot_Complet() {
	
	# Reste à trouver = le mot à deviner = le mot moins les lettres déjà proposées, supprimées.
	reste_a_trouver=$( echo $MotAdeviner | sed -e "s/[$listelettres]//gI" )
	
	if [ "$reste_a_trouver" = '' ] ; then    # S'il n'y a plus rien à trouver, alors ...
		
		echo -e "$VERT GAGNE !!! $devineur CHAMPION !!!"
		gagnant=$devineur
		perdant=$cacheur
		Fct_Scores       # Appel de la Fonction Scores
		
	else Fct_ProposerLettre                  # Sinon, on appelle à nouveau la Fonction ProposerLettre
	 
	fi  # Fin de s'il n'y a plus rien à trouver
	}

#Fonction Perdu : appelée lorsque l'utilisateur a perdu :
Fct_Perdu() {
	
	echo -e "$JAUNE t'as perdu !!! ahahah $cacheur t'a bien eu !"
	
	gagnant=$cacheur
	perdant=$devineur
	
	Fct_Scores  # Appel de la fonction Scores
	}

# Fonction Scores : affichage + enregistrement des scores dans un fichier externe	
Fct_Scores() {
	
	clear
	cat $dossierDessins${potence}.txt    # On affiche l'état d'avancement du pendu
	echo -e "$BLEU RESULTATS FINAUX :"
	echo -e "$VERT ------------------ \n\n"
	echo -e "Vainqueur : $gagnant\n"
	echo -e "$ROUGE""Loser : $perdant\n"
	echo -e "$JAUNE$cacheur avait choisi le mot : ""$MotAdeviner"
	echo -e "Mot deviné : `echo -e "$MotAdeviner" | sed -e "s/[^${listelettres}@]/ _/g"` (par $devineur)"
    echo -e "Essais : ${#listelettres}"

# Enregistrement du résumé de la partie dans le fichier .pendu
	echo -e "Vainqueur : $gagnant\nPerdant : $perdant\nMot à deviner : $MotAdeviner \n\n" >> .pendu

# Invitation à rejouer	
	echo -e "$VERT""Voulez-vous rejouer ? O/N"
	read -n 1 choix
	
	case $choix in 
		'o'|'O') Fct_Menu
					;;
		*) echo "A la prochaine sur Hangman !"
		   exit 0
	esac
	}


# Fonction EnleverAccent permet de remplacer les caractères accuentués entrés par l'utilisateur 
# par leur équivalent sans accent.

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
			"û"|"ü"|"ù"|"ú")
				MotAdeviner=$MotAdeviner"u"
				;;
			$IFS) MotAdeviner=$MotAdeviner	
				;;
			?)
				MotAdeviner=$MotAdeviner${saveMot:$i:1}
				;;
		esac
	done
}

# Fonction TestAlpha teste la présence de caractères numériques dans le mot proposé par l'utilisateur.
Fct_TestAlpha () {
	i=0
	while [[ $i -lt ${#MotAdeviner} ]]; do
		if [[ ${MotAdeviner:$i:1} != [[:alpha:]] ]]; then
			echo "Entrez un mot ne contenant pas de caractères numériques"
			exit 1
		fi
		i=$((i+1))
	done
}

# Fonction TirerUnMot : utilisée lorsque l'utilisateur joue contre le CPU

Fct_TirerUnMot () {
	
	nb1=$( wc -l $listetxt | cut -f1 -d' ' )  # compte le nombre de lignes dans le fichier listetxt et en extrait le premier champ
	n=$(( RANDOM % $nb1 + 1 ))                # déclaration d'un nombre aléatoire, utilisé pour sélectionner une ligne hasard
	MotAdeviner=$( sed -n ${n}p $listetxt ) # Le mot à trouver = le premier champ de la ligne n du fichier listetxt

	taille=${#MotAdeviner}                  # Résolution temporaire du bug de merde du caractère en trop
	taille=$((taille-1))
	MotAdeviner=${MotAdeviner:0:$taille}
	
	Fct_ProposerLettre # Appel de la fonction permettant de commencer à jouer
}

#Déclaration des variables globales : 

# Couleurs de texte :	
VERT="\\033[1;32m"
NORMAL="\\033[0;39m"
ROUGE="\\033[1;31m"
BLEU="\\033[1;34m"
JAUNE="\\033[1;33m"
CACHE="\\033[47;1;37m"
DEF="\\033[0;0m"

# Fichiers externes utilisés
fichierScores=".pendu"
dossierDessins=".Dessins/"
listetxt=".liste"

# Appel de la Fonction Menu, pour lancer le jeu

Fct_Menu

# Fin de programme
