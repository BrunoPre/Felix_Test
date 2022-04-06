*** Settings ***

Library           RemoteSwingLibrary
Suite Setup       Start Test Application
Suite Teardown    Stop Test Application

*** Variables ***

#
# Données de test
#

${ID_PRODUIT}         11A
${QTT_PRODUIT}        2
${LIBELLE_PRODUIT}    produit un A
${PRIX_PRODUIT}       10,00 €
${INFO_ACHAT}         + produit un A \ \ x \ \ 2 \ x 10,00 €
${TOTAL_ACHAT}        20,00 €
${INFO_TICKET}        SEPARATOR=\n                                              <Ticket>
...                   produit un A \ \ \ \ \ \ x 2 \ \ \ \ \ x \ \ \ 10,00 €


${ID_PRODUIT_INCONNU}         id invalide
${QTT_PRODUIT_INCONNU}        3
${LIBELLE_PRODUIT_INCONNU}    Produit inconnu
${INFO_ACHAT_IMPOSSIBLE}      Achat impossible


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

Entrer Dans Le Chat [Modification de l'IP]
	#	1.
	L'utilisateur lance le Composant Felix
	# 2.
	Felix affiche la Vue Connexion
	# 3.
	L'utilisateur modifie l'adresse IP
	# 4.
	Felix Affiche Un Message De Connexion
	# 5. 6. 7. réalisation interne

	# 8. 0 autre felix

Entrer Dans Le Chat [Modification du port]
	#	1.
	Lancer Composant Felix
	# 2.
	Lancer Afficher Vue
	# 3.
	Modifier Port

Entrer Dans Le Chat [Connexion Impossible]

	# 1.
	Lancer Composant Felix
	# 2.
	Lancer Afficher Vue
	# 3.
	Message De Connexion Impossible
*** Keywords ***

Start Test Application
	Start Application    Monix               java -Duser.language=fr -Duser.country=FR -jar SUT/monix_java-5.4.2.jar -b
	...                  stdout=/dev/null    stderr=/dev/null
	Sleep                5s

Stop Test Application
	Switch To Application    Monix
	System Exit