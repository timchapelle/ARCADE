// PAPIER - PIERRE - CISEAU ++
// Auteur : Tim C. - 2016
// Essai de traduction en C++ du célèbre jeu PapierPierreCiseau_v2.0

#include <iostream> // nécessaire pour cin/cout (entre autres)
#include <fstream>  // nécessaire pour lire/écrire dans des fichiers
#include <string>   // nécessaire pour utiliser des string
#include <stdio.h>  // nécessaire pour la manipulation des flux I/O
#include <time.h>   // nécessaire pour l'obtention de l'heure
#include <ctime>    // idem
#include <cstdlib>  // nécessaire pour les fonctions ifstream/ofstream

using namespace std;

void Fct_Menu() 
{
	string bvertfjaune="\e[42;1;33m", bjaunefrouge="\e[43;1;31m", brougefjaune="\e[41;1;33m",fin="\e[0m",vertn="\e[40;5;38;82m";
	
	 cout<<"\t\t"<<bvertfjaune<<"   PAPIER   "<<bjaunefrouge<<"   PIERRE   "<<brougefjaune<<"   CISEAU   "<<vertn<<"   ++   "<<fin<<endl;
}        
 
 void Fct_Jeu()     
 

int main() {
	
	Fct_Menu();
	
    char rejouer='O';   // déclaration et initialisation de la variable permettant de rejouer
    string Joueur1,Joueur2,vainqueur; // déclaration de variables
    string rouge="\e[91m",normal="\e[39m",vert="\e[92m",jaune="\e[93m",bleu="\e[94m",mauve="\e[95m"; // déclaration des couleurs du texte
    string vertn="\e[40;38;5;82m", noirv="\e[30;48;5;82m", fin="\e[0m";
    int scoreJ1=0,scoreJ2=0,tour=1,nbTours,choix1,choix2; // déclaration et initialisation de variables
       
    while (rejouer == 'o' || rejouer == 'O') // Début de la boucle principale
    {		
			// AFFICHAGE DU TITRE ET INITIALISATION DES JOUEURS/DU NOMBRE DE TOURS
		
        cout<<"\t\t"<<noirv<<"   PAPIER   "<<vertn<<"   PIERRE   "<<noirv<<"   CISEAU   "<<vertn<<"   ++   "<<fin<<endl;
        
        cout<<jaune<<"\nJoueur 1, quel est ton prénom ?\n"<<bleu<<endl; cin>>Joueur1;
        cout<<jaune<<"\nJoueur 2, quel est ton prénom ?\n"<<bleu<<endl; cin>>Joueur2;
        cout<<jaune<<"\nCombien de tours voulez-vous jouer ?\n"<<bleu<<endl; cin>>nbTours;
    
			// JEU
    
        while (tour <= nbTours) // Forcer nombre de tours = nombre de tours choisi par l'utilisateur
        {
				// TOUR DE JEU 
			
			cout<<rouge<<endl<< "Tour : " << tour << "\n--------" << endl;
            cout<<jaune<<Joueur1<<" , quelle est ton arme ?"<<vert<<"\n\n\t1. Pierre\n\t2. Papier\n\t3. Ciseau"<<bleu<<endl; cin>>choix1;
            cout<<jaune<<Joueur2<<" , quelle est ton arme ?"<<vert<<"\n\n\t1. Pierre\n\t2. Papier\n\t3. Ciseau"<<bleu<<endl; cin>>choix2;
				
            tour++; // incrémentation du nombre de tours

				// DETERMINATION DU RESULTAT DU TOUR

            if ( choix1 == choix2 )
            {
                cout<<"Egalite"<<endl;
            }
            else if (choix1==1 && choix2==2)
            {
                cout<<"Le papier englobe la pierre. Un point pour "<<Joueur2<<endl<<endl;
                scoreJ2++;
            }
            else if (choix2==1 && choix1==2)
            {
                cout<<"Le papier englobe la pierre. Un point pour "<<Joueur1<<endl<<endl;
                scoreJ1++;
            }
            else if (choix1==2 && choix2==3)
            {
                cout<<"Le ciseau coupe le papier. Un point pour "<<Joueur2<<endl<<endl;
                scoreJ2++;
            } 
            else if (choix2==2 && choix1==3)
            {
                cout<<"Le ciseau coupe le papier. Un point pour "<<Joueur1<<endl<<endl;
                scoreJ1++;
            }
            else if (choix1==1 && choix2==3)
            {
                cout<<"La pierre casse les ciseaux. Un point pour "<<Joueur1<<endl<<endl;
                scoreJ1++;
            }
            else if (choix2==1 && choix1==3)
            {
                cout<<"La pierre casse les ciseaux. Un point pour "<<Joueur2<<endl<<endl;
                scoreJ2++;
            }
            else {
				cout <<rouge<< "Mauvais choix !"<<endl<<endl;
				tour--;
				 }
				
            
            cout<<bleu<<"Score : "<<Joueur1<<" "<<scoreJ1<<" - "<<scoreJ2<<" "<<Joueur2<<normal<<endl;
            
        } // fin de la boucle while ( tour < nbTours ) n

			// DETERMINATION ET AFFICHAGE DU VAINQUEUR :
        
        if (scoreJ1 < scoreJ2)
        {
            string vainqueur = Joueur2;
            cout<<vert<<"\tVainqueur : "<<Joueur2<<endl<<rouge<<"\tLoser : "<<Joueur1<<normal<<endl;
        }
        else if (scoreJ1 > scoreJ2)
        {
            string vainqueur = Joueur1;
            cout<<vert<<"\n\n\tVainqueur : "<<Joueur1<<endl<<rouge<<"\t Loser : "<<Joueur2<<normal<<endl;
        }
        else cout<<endl<<endl<<"Egalite !"<<endl<<endl;

			// ENREGISTREMENT DES SCORES :
        
			// Ouverture du flux d'écriture
         ofstream fichier("RecapScores2.txt", ios::app );//ios::app --> ouverture en écriture du fichier à la suite (app=append, >> en bash | trunc = on efface, > en bash)

            time_t now = time(0); // obtention de la date et l'heure --> now
            char* dt = ctime(&now); // conversion de now en string

            fichier<<endl<<"\tDate/heure : "<<dt<<endl;
            fichier<<"Joueur 1 : "<<Joueur1<<" - "<<scoreJ1<<endl<<"Joueur 2 : "<<Joueur2 <<" - "<<scoreJ2<<endl;

            fichier.close(); // OBLIGATOIRE : fermeture du fichier

			// Invitation à rejouer :
        
        cout<<"\t\n\n"<<" On s'en refait une ? (O/N) ... ou on regarde les SCORES (S) ?"<<endl;
        cin>>rejouer;
        
        if ((rejouer == 'o') || (rejouer == 'O'))
			 
			 cout<<endl<<"\t\tC'est parti !"<<endl<<endl; // On recommence la boucle si le joueur tape 'o' ou 'O'
		
			// AFFICHAGE DES SCORES :
		
		else if (rejouer == 's' || rejouer == 'S') 
		{
			ifstream fichier("RecapScores2.txt"); // On ouvre le fichier en lecture
			
			if(fichier) // Si le fichier existe
			{
			string ligne; // On crée une variable de type string dans laquelle on va venir mettre chaque ligne du fichier
				
				while(getline(fichier, ligne))  // tant que l'on peut mettre la ligne du fichier dans la variable ligne
				{
                cout << ligne << endl;  // on l'affiche
                }
			fichier.close(); // On ferme le fichier (!! OBLIGATOIRE !!)
				
			cout<<"\n\n\t Voulez-vous rejouer ? (O/N)"<<endl;cin>>rejouer;
			}	

				else
				cerr << "Impossible d'ouvrir le fichier !" << endl;
		}
				
			// FIN DE L'AFFICHAGE DES SCORES
			
        else {cout<<"\n\n Bye Bye !";return EXIT_SUCCESS;} // On quitte le jeu si l'utilisateur ne veut pas rejouer 
	
    } // fin de la boucle principale while ( rejouer = o || O )
 } // fin du main
 
 // FIN DU PROGRAMME

