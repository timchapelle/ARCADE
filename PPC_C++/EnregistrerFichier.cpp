#include <iostream>
#include <cstdlib>
#include <fstream>
using namespace std;


// CECI ENREGISTR DU CONTENU DANS UN FICHIER EN MODE CONSOLE !

int main() {
 
 // ENREGISTREMENT DES SCORES :
        
			// ouverture du flux d'écriture
        ofstream fichier("NomDuFichier", ios::app );//ios::app --> ouverture en écriture du fichier à la suite (app=append, >> en bash)

       // if(fichier) // si le fichier existe
       // {
       //     time_t now = time(0); // obtention de la date et l'heure --> now
         //   char* dt = ctime(&now); // conversion de now en string

         //   fichier<<endl<<"\tDate/heure : "<<dt<<endl;
         
            fichier<<" Votre texte " << endl; // Ecriture dans le fichier

            fichier.close(); // OBLIGATOIRE : fermeture du fichier
      //  }
        //else
        //    cerr << "Impossible d'ouvrir le fichier !" << endl;
        
 }
