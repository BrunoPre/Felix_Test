*** Settings ***

Resource          resources/Felix_test_CU.resource
Suite Setup       Execution Camix
Suite Teardown    Arret Camix

*** Variables ***

#
# Données de test
#


*** Test Cases ***

#
# Scénario nominal : entrée dans le chat
#
Entrer Dans Le Chat
   Entrer Dans Le Chat

Entrer Dans Le Chat [Modification de l'IP] [Modification du port]
    [Template]    Entrer Dans Le Chat [Modification de l'IP] [Modification du port]
    127.0.0.1     12345
    127.0.0.1     12343
    145.0.1.2     12345


Entrer Dans Le Chat [Connexion Impossible]
   [Template]      Entrer Dans Le Chat [Modification de l'IP] [Modification du port]
   212.167.5.69    99999


*** Keywords ***

#
# Scénario nominal : entrée dans le chat
#
Entrer Dans Le Chat
    [Teardown]                                         Arret Felix
    # 1.
    L'utilisateur lance le Composant Felix
    # 2.
    Felix Affiche Vue Connexion
    # 3.
    L'utilisateur demande à se connecter
    # 4.
    Felix Affiche un message de connexion
    # 5. 6. 7. réalisation interne
    # 8. Camix transmet au composant Felix de l’utilisateur un message d’accueil dans le chat
    # 9.
    Felix ferme la vue Connexion
    # 10.
    Felix affiche la vue Chat
    # 11.
    Felix affiche un message d’accueil dans le chat

Entrer Dans Le Chat [Modification de l'IP] [Modification du port]
    [Arguments]                               ${ip}          ${port}
    [Teardown]                                Arret Felix
    L'utilisateur lance le Composant Felix

    Felix affiche Vue Connexion

    L'utilisateur change le port    ${port}

    L'utilisateur change l'ip    ${ip}

    L'utilisateur demande à se connecter

    Felix Affiche un message de connexion    ${ip}    ${port}

    Felix ferme la vue Connexion
    
    Felix affiche la vue Chat

    Felix affiche un message d’accueil dans le chat