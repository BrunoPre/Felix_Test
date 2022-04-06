*** Settings ***

Library    RemoteSwingLibrary
Suite Setup    Start Test Application
Suite Teardown    Stop Test Application

*** Variables ***

#
# Données de test
#

${ID_PRODUIT}       11A
${QTT_PRODUIT}      2
${LIBELLE_PRODUIT}  produit un A
${PRIX_PRODUIT}     10,00 €
${INFO_ACHAT}       + produit un A \ \ x \ \ 2 \ x 10,00 €
${TOTAL_ACHAT}      20,00 €
${INFO_TICKET}      SEPARATOR=\n    <Ticket>
...                 produit un A \ \ \ \ \ \ x 2 \ \ \ \ \ x \ \ \ 10,00 €


${ID_PRODUIT_INCONNU}       id invalide
${QTT_PRODUIT_INCONNU}      3
${LIBELLE_PRODUIT_INCONNU}  Produit inconnu
${INFO_ACHAT_IMPOSSIBLE}    Achat impossible


*** Test Cases ***

#
# Traiter passage en caisse, achat d'un produit.
#
Entrer Dans Le Chat
    # 1.
    Lancer Composant Felix
    # 2.
    Afficher Vue Connexion
    # 3.

Entrer Dans Le Chat [Modification de l'IP] [Modification du port]

#
# Traiter passage en caisse, achat d'un produit [Article non identifié]
#
Traiter Passage En Caisse Achat Produit Article Non Identifié
	Saisir l'identifiant d'un produit non identifié    ${ID_PRODUIT_INCONNU}
	Ajouter l'achat d'un produit non identifié    ${QTT_PRODUIT_INCONNU}


*** Keywords ***

Start Test Application
	Start Application   Monix    java -Duser.language=fr -Duser.country=FR -jar SUT/monix_java-5.4.2.jar -b
	...                 stdout=/dev/null  stderr=/dev/null
	Sleep    5s

Stop Test Application
	Switch To Application    Monix
	System Exit