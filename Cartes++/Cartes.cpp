#include <iostream>
#include <string>
#include <vector>
#include <stdio.h> 
#include <stdlib.h> 
#include <time.h> 
using namespace std;

vector<string> TabCouleur = { "Coeur", "Carreau", "Trèfle", "Pique" };
vector<string> TabValeur = {"As", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Valet", "Dame", "Roi"};

struct Carte { // définition d'une carte : 
	int valeur; //0 à 12 pour As à Roi
	int couleur; // 0 à 3 coeur carreau trèfle pique
};

Carte Paquet[52]; // Création d'un paquet de 52 cartes
int indiceMax;  // indice de cartes maximal (52 au départ)
// Initialisation du jeu : en sortie, Paquet[0] vaut As de Coeur, et ainsi de suite
void InitPaquet() {
	int val, coul, i;
	i=0;
	for (coul = 0; coul <= 3 ; coul++) {
		for (val = 0; val < 13 ; val++) {
			Paquet[i].valeur=val;
			Paquet[i].couleur=coul;
			i++;
		}
	}
}
// Distribuer Cartes 
// Renvoie une carte à la fois 
// En entrée, pCarte pointe sur une structure déjà allouée et en sortie on renvoie le même pointeur
// Pas besoin de mélanger le tableau au départ, ni de vérifier qu'une carte a déjà été distribuée, ... 
Carte *Distribue(Carte *pCarte) {
	int indice;
	if (indiceMax != 0) {
		indice=rand()%(indiceMax);
	} else {
		indice=0;
	  }
	*pCarte = Paquet[indice]; // On renseigne la carte choisie, prise au hasard 
	Paquet[indice] = Paquet[indiceMax]; // Très important : insérer la dernière carte du paquet à la place !
	indiceMax--;// On enlève une carte du paquet : 
	return pCarte;// On retourne la carte tirée :
}
int main() {
	Carte carte;
	srand(time(NULL)); // On initialise le générateur aléatoire
	indiceMax=51; // On initialise les 51 cartes à tirer, la 52ème étant la restante
	InitPaquet(); // On initialise le paquet
	//Distribution proprement dite :
	for (int i = 0; i < 52; i++) {
		Distribue(&carte);
		cout << i+1 << " -- " << TabValeur[carte.valeur] << " de " << TabCouleur[carte.couleur] << &carte << endl;
	}
	return 0;
}
