#include <iostream>
#include <cstdlib>
#include <fstream>
using namespace std;


// CECI AFFICHE LE CONTENU D'UN FICHIER EN MODE CONSOLE !

int main() {


 
 ifstream fichier("NomDuFichier");  // on ouvre le fichier en lecture
 
       if(fichier) // si le fichier existe
{
        string ligne; // on crée une variable ligne de type string
        while(getline(fichier, ligne))  // tant que l'on peut mettre la ligne du fichier dans la variable string
        {
                cout << ligne << endl;  // on l'affiche
        }
        fichier.close(); // on ferme le fichier !! OBLIGATOIRE !!
}

        else  // sinon
                cerr << "Impossible d'ouvrir le fichier !" << endl;
 
        return 0;
	}

