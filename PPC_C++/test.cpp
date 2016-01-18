#include <iostream>
#include <cstdlib>
#include <fstream>
using namespace std;


// CECI AFFICHE LE CONTENU D'UN FICHIER EN MODE CONSOLE !

int main() {


 
 ifstream fichier("RecapScores2.txt", ios::in);  // on ouvre le fichier en lecture
 
       if(fichier)
{
        string ligne;
        while(getline(fichier, ligne))  // tant que l'on peut mettre la ligne dans "contenu"
        {
                cout << ligne << endl;  // on l'affiche
        }
}

        else  // sinon
                cerr << "Impossible d'ouvrir le fichier !" << endl;
 
        return 0;
	}

