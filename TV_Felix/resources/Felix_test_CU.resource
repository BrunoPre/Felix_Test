***Settings***
Documentation    resources pour le test de Felix
Library          RemoteSwingLibrary
Library          Process

*** Keywords ***

Execution Camix
    Process.Start Process    java    SUT/Camix-0.4.3.jar    stdout=/dev/null    stderr=/dev/null    alias=Camix 
	Sleep    200ms

Arret Camix
    Terminate Process    Camix
    Log                  Arret Camix

Arret Felix
    Log            Arret Felix
    System Exit


L'utilisateur lance le Composant Felix
    Start Application    Felix    java -jar SUT/Felix-0.4.3.jar    stdout=/dev/null    stderr=/dev/null
	Sleep    500ms

Felix Affiche Vue Connexion
    Log              Felix Affiche Vue Connexion
    Select Window    Connexion

L'utilisateur demande à se connecter
    Log                   L'utilisateur demande à se connecter
    Click On Component    Connexion

Felix Affiche un message de connexion
    Log    Felix Affiche un message de connexion
    

Felix ferme la vue Connexion
    Log    Felix ferme la vue Connexion

Felix affiche la vue Chat
    Log    Felix affiche la vue Chat

Felix affiche un message d’accueil dans le chat
    Log    Felix affiche un message d’accueil dans le chat