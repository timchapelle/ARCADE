//
//  main.cpp
//  lesBatonnets
//
//  Created by Matthieu Schmit on 2/02/16.
//  Copyright © 2016 Matthieu Schmit. All rights reserved.
//

#include <iostream>
#include "Jeu.cpp"
using namespace std;


// Prototypes des fonctions
void menu();
void init();
void regles();
void scores();
void jouer (Jeu jeu);
int lecture(Jeu jeu);



int main(int argc, const char * argv[]) {
    menu();
    return 0;
}


// Menu du jeu
void menu () {
    char choix;
    cout << "Le jeu des bâtonnets -- Fort Boyard \n" << endl;
    cout << "   J. Jouer (contre IA)" << endl;
    cout << "   R. Règles" << endl;
    cout << "   S. Scores" << endl;
    cout << "   Q. Quitter" << endl;
    cout << "\n              BETA - by Schmit" << endl;
    cin >> choix;
    switch (choix) {
        case 'J':
        case 'j':
            init();
            break;
        case 'R':
        case 'r':
            regles();
            break;
        case 'S':
        case 's':
            scores();
            break;
        case 'q':
        case 'Q':
            exit(0);
            break;
        default:
            menu();
            break;
    }
}


// Initialise la partie
void init() {
    Jeu jeu;
    jeu.nouvellePartie();
    jouer(jeu);
}


// Joue
void jouer (Jeu jeu) {
    int nbTire;
    while (jeu.getNbBaton() > 0) {
        if (jeu.getTour() == 0) {
            // Ordi de jouer
            nbTire=rand()%3+1;
            cout << "L'ordi a pioché " << nbTire << " bâtonnet(s)" << endl;
            cout << "Il en reste " << jeu.getNbBaton()-nbTire << " sur la table." << endl;
        } else {
            // Joueur de jouer
            nbTire=lecture(jeu);
        }
        jeu.enleverBaton(nbTire);
        jeu.setTour();
    }
    if (jeu.getTour() == 0) {
        cout << "L'ordinateur a gagné." << endl;
    } else {
        cout << jeu.getNom() << " a gagné." << endl;
    }
    menu();
}


// Gère les erreurs d'entrées
int lecture (Jeu jeu) {
    int nb;
    cout << jeu.getNom() << ", combien de batonnets prends tu ?" << endl;
    cin >> nb;
    while ((nb != 1 && nb != 2 && nb != 3) || (nb > jeu.getNbBaton())) {
        cout << "Erreur d'entrée" << endl;
        cin >> nb;
    }
    return nb;
}


// Règles
void regles () {
    cout << "Regles" << endl;
    cout << "Pas encore dispo \n" << endl;
    menu();
}


// Scores
void scores () {
    cout << "Scores" << endl;
    cout << "Pas encore dispo \n" << endl;
    menu();
}



