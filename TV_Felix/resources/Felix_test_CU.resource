***Settings***
Documentation resources pour le test de Felix
Library    RemoteSwingLibrary
Library    Process


*** Keywords ***

Execution Camix
  Start Process   Camix    java  -jar target/Felix_Java-v0.4.2-1.0-SNAPSHOT.jar
	...                 stdout=/dev/null    stderr=/dev/null
	Sleep  5s

Arret Felix
  System Exit

L'utilisateur lance le Composant Felix
  Start Process   Felix    java  -jar target/Felix_Java-v0.4.2-1.0-SNAPSHOT.jar
  ...                 stdout=/dev/null    stderr=/dev/null
  Sleep  3s

Felix Affiche Vue Connexion
  Select Window  VueConnexion
