***Settings***
Documentation    resources pour le test de Felix
Library          RemoteSwingLibrary
Library          Process

*** Keywords ***

Execution Camix
          Log                      Execution Camix
          Process.Start Process    java               -jar    SUT/Camix-0.4.3.jar    stdout=/dev/null    stderr=/dev/null    alias=Camix
	Sleep    1s

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
    [Arguments]                    ${ip}=127.0.0.1    ${port}=12345
    Log  ${ip}
    Log  ${port}
    Wait Until Keyword Succeeds    3x                 1s               Assert Equals Strings    Information    Connexion au chat @${ip}:${port}
    Sleep                          3s

Felix ferme la vue Connexion

    # Close Window    Connexion
    Log    Felix ferme la vue Connexion

Felix affiche la vue Chat
    Window Should Be Open    Chat
    Log                      Felix affiche la vue Chat
    Sleep                    3s

Felix affiche un message d’accueil dans le chat
    Log    Felix affiche un message d’accueil dans le chat

L'utilisateur change l'ip
    [Arguments]               ${ip}
    Click On Component        IP
    Insert Into Text Field    IP       ${ip}

L'utilisateur change le port
    [Arguments]               ${port}
    Click On Component        Port
    Insert Into Text Field    Port       ${port}

Assert Equals Strings
    [Arguments]                   ${textfield}            ${expectedValue}
    Log  ${expectedValue}
    ${value} =                    Get Text Field Value    ${textfield}
    Should Be Equal As Strings    ${value}                ${expectedValue}