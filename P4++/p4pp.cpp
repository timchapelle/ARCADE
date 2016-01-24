/*  ______   _____
 * |  _   ) / _   |      _       _
 * | |_) / / /_|  |_____| |_____| |_____
 * |   _/ /____    _____   _____   _____| 
 * |  |        |  |     |_|     |_|
 * |_ |        |__|
 * 
 * Auteur : Tim Chapelle
 * Release alpha: 24/01/2016
 * 
 * Jeu de Puissance 4 en C++.
 * */
#include <iostream>
#include <array>
using namespace std;

enum Couleur { vide, rouge, jaune };
typedef array<array<Couleur, 7>, 6> Grille;

// Fonction d'initialisation de la grille
void initialise(Grille& grille)  // on pourrait aussi imaginer Grille grille(initialise())
{	
	for(auto &ligne : grille) {  //on itère sur chaque ligne puis sur chaque case
		for(auto &kase : ligne) { // kase et pas case (mot réservé) &kase : si pas de & le contenu ne sera pas modifié
			kase = vide;
		}
	}
}
// Fonction d'affichage de la grille
// Affiche O pour une case rouge, X pour une jaune et ' ' pour une vide
void affiche(const Grille& grille)  // protège l'affichage de la grille d'une modification intempestive de son contenu
{ 
	for(auto ligne : grille) {  // ici pas de & car on ne fait que consulter le contenu, on ne le modifie pas
		cout << " |";
		for(auto kase : ligne) {
			if (kase == vide) {
				cout << ' ';
			} 	else if (kase == rouge) {
				cout << 'O';
			}	else {
				cout << 'X';
			}
			cout << '|';
		}
		cout << endl;
	} // Maintenant on affiche les numéros de colonnes en dessous de la grille, précédés du symbole ' = '
	cout << '=';
	for(size_t i(1);i <= grille[0].size(); ++i) {
		cout << '=' << i;
	}
	cout << "==";
	cout << endl << endl;
}
// Fonction "Joue"
bool joue(Grille& grille, size_t colonne, Couleur couleur) // size_t : TOUJOURS entier positif 
{	
	// si le numéro de colonne n'est pas valide, le coup n'est pas valide :
	if (colonne >= grille[0].size()) {
		return false;
	}
	// on parcourt la colonne en partant du bas ...
	size_t ligne(grille.size() -1); 
	// ...jusqu'à trouver une case vide... 
	// ...ou jusqu'en haut de la colonne si la colonne est pleine :
	bool pleine(false);
	while ((not pleine) and grille[ligne][colonne] != vide) { // tant que la grille à la position [ligne][colonne] n'est pas vide
		if (ligne == 0 ) {
			pleine = true;
		} else {
			--ligne;
		}
	}
	if (not pleine) {
		grille[ligne][colonne] = couleur;
		return true;
	} else {
		return false;
	}
}
// Fonction demande_et_joue(grille, couleur_joueur) :
void demande_et_joue(Grille& grille, Couleur couleur_joueur) 
{	size_t colonne;
	bool valide( joue(grille, colonne, couleur_joueur) );
	cout << "Joueur ";
	if (couleur_joueur == jaune) {
		cout << 'X';
	} else {
		cout << 'O';
	} 
	cout << " : entrez un numéro de colonne " << endl;
	
	do {
		cin >> colonne;
		--colonne; // les indices des tableaux commencent par 0 en C++ !!!
	  
		valide = joue(grille, colonne, couleur_joueur);
		if (not valide) {
		cout << " > Ce coup n'est pas valide !" << endl;
		}
	} while(not valide);
}
//Fonction compte : 
// if (compte(grille, ligne, colonne, -1, +1) >= 4 ...
unsigned int compte(const Grille& grille, 
					size_t ligne_depart, size_t colonne_depart, 
					int dir_ligne, int dir_colonne)
{ 
	unsigned int compteur(0);
	size_t ligne(ligne_depart);
	size_t colonne(colonne_depart);
	
	while (ligne < grille.size() and
		   colonne < grille[ligne].size() and
		   grille[ligne][colonne] == grille[ligne_depart][colonne_depart]) {
		++ compteur;
		ligne   = ligne   + dir_ligne;
		colonne = colonne + dir_colonne;		
	}
	return compteur;
}
// Fonction pour vérifier si un joueur a gagné :
bool est_ce_gagne(const Grille& grille, Couleur couleur_joueur) 
{	
	for(size_t ligne(0); ligne < grille.size(); ++ligne) {
		for(size_t colonne(0); colonne < grille[ligne].size(); ++ colonne) {
			Couleur couleur_case(grille[ligne][colonne]);
			
			if (couleur_case == couleur_joueur) {
				const size_t ligne_max(grille.size() - 4);
				const size_t colonne_max(grille[ligne].size() - 4);
				
				if (// en diagonale, vers le haut et la droite : 
					(ligne >= 3 and colonne <= colonne_max and
					compte(grille, ligne, colonne, -1,+1) >= 4) or
					
					// horizontalement, vers la droite :
					(colonne <= colonne_max and
					compte(grille, ligne, colonne, 0, +1) >= 4) or
					
					//en diagonale, vers le bas et la droite :
					(ligne <= ligne_max and colonne <= colonne_max and
					compte(grille, ligne, colonne, +1, +1) >= 4) or
					
					// verticalement, vers le bas :
					(ligne <= ligne_max and
					compte(grille, ligne, colonne, +1, 0) >= 4)) {
					return true;
				}
			}
		}
	}
	return false;
}

// Fonction "plein"
bool plein(const Grille& grille) {
	//Si on trouve une case vide sur la premiere ligne, la grille n'est pas pleine
	for(auto kase : grille[0]) {
		if (kase == vide) {
			return false;
		}
	}
	// Sinon, la grille est pleine :
	return true;
}

int main() 
{
	Grille grille;
	
	initialise(grille);
	affiche(grille);
	
	Couleur couleur_joueur(jaune);
	bool gagne;
	
	do {
		demande_et_joue(grille, couleur_joueur);
	  	affiche(grille);
	  
		gagne = est_ce_gagne(grille, couleur_joueur);
		
		// on change la couleur pour la couleur de l'autre joueur :
		if (couleur_joueur == jaune) {
		  couleur_joueur = rouge;
		} else {
		  couleur_joueur = jaune;
		}
	} while (not gagne and not plein(grille));
	
	
	if (gagne) {
		if (couleur_joueur == jaune) {
			cout << "Le joueur O a gagné!" << endl;
		} else {
			cout << "Le joueur X a gagné!" << endl;
		}
	} else {
		cout << "Match nul !" << endl;
	}
	
	return 0;
}
