# Demande client

En tant que "client" je souhaiterais que vous développiez, et validiez par test logiciel, les fonctionnalités suivantes sur le logiciel de chat
(composants Camix et Felix).

## I) Fenêtre de connexion

Une fenêtre de connexion doit être ajoutée au composant Felix.

Au lancement du composant Felix, une fenêtre de connexion doit s'afficher. Cette fenêtre doit être munie :

[x] d'un champ "IP" éditable, accompagné du label "IP", initialisé avec l'adresse IP mentionnée dans le fichier de configuration de Felix ;

[x] d'un champ "Port" éditable, accompagné du label "Port", initialisé avec le port de connexion mentionné dans le fichier de configuration de Felix ;

[x] d'un bouton de connexion, avec le label "Connexion" ;

[x] d'un champ d'information non éditable, mentionnant "Saisir l'adresse et le port du serveur chat." à l'initialisation.

[] L'utilisateur doit pouvoir changer l'adresse IP et le port de connexion.

Lorsque l'utilisateur clique sur le bouton de connexion :

1) Le champ d'information mentionne "Connexion au chat @ADRESSE:PORT" (ou ADRESSE et PORT sont respectivement l'adresse et le port mentionnés dans les champs de saisie)
2) Felix se connecte au serveur chat à l'adresse et au port mentionnés.

Si la connexion est établie, la fenêtre de connexion se ferme et la fenêtre de chat actuellement disponible s'ouvre pour  ermettre de communiquer avec d'autres clients du chat. Sinon, la fenêtre de connexion reste ouverte et le champ d'information mentionne "Connexion au chat @ADRESSE:PORT impossible.", l'utilisateur peut alors changer l'adresse IP et le port de connexion  pour tenter une nouvelle connexion au chat.

## II) Sortie du chat

La saisie de la commande "/q" doit permettre de quitter le chat.
À la réception de cette commande, Camix :

- retourne le message "* Sortie du chat." au client qui sort du chat ;
- informe les autres utilisateurs du canal que le client quitte le chat ;
- désinscrit le client du canal dans lequel il se trouve ;
- ferme la connexion du client.

--
Merci,

Cordialement,
Matthias Brun
