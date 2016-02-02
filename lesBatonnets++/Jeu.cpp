//
//  Jeu.cpp
//  lesBatonnets
//
//  Created by Matthieu Schmit on 2/02/16.
//  Copyright © 2016 Matthieu Schmit. All rights reserved.
//
//  class Jeu

#include <iostream>
using namespace std;

class Jeu {
    int nbBatonnets;
    string nom;
    int tour;
    
    // Constructeur pour une nouvelle partie
    public: void nouvellePartie () {
        nbBatonnets=rand()%10+20;
        tour=rand()%1;
        cout << "\nQuel est ton nom ?" << endl;
        cin >> nom;
        if (tour == 0) {
            cout << "C'est l'ordinateur qui commence," << endl;
        } else {
            cout << "C'est " << nom << " qui commence," << endl;
        }
        cout << "et il y a " << nbBatonnets << " bâtonnets." << endl;
        cout << "\nBonne chance..\n" << endl;
    }
    
    // Calcul le numéro du joueur
    public: void setTour () {
        if (tour == 0) {
            tour=1;
        } else {
            tour=0;
        }
    }
    
    // Enlève le(s) batonnet(s) du tas
    public: void enleverBaton (int nb) {
        nbBatonnets=nbBatonnets-nb;
        if (nbBatonnets < 0) {
            nbBatonnets=0;
        }
    }
    
    // Renvoie le nombre de batonnets restant
    public: int getNbBaton () {
        return nbBatonnets;
    }
    
    // Renvoie le numéro du joueur dont c'est le tour
    public: int getTour () {
        return tour;
    }
    
    // Renvoie le nom du joueur
    public: string getNom () {
        return nom;
    }
    
    
};