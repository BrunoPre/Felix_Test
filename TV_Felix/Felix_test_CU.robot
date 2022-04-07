*** Settings ***

Resource 					resources/Felix_test_CU.resource
Suite Setup       Execution Camix
Suite Teardown    Arret Camix

*** Variables ***

#
# Données de test
#

${IP_ADRESS} ${ADRESSE_CHAT}
${PORT_CHAT} ${PORT_CHAT}

*** Keywords ***

#
# Scénario nominal : entrée dans le chat
#
Entrer Dans Le Chat
	[Teardown] Arret Felix
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
  [Teardown] Arret Felix

  [Template] Entrer Dans Le Chat [Modification de l'IP] [Modification du port]
  ${ip} ${port}

Entrer Dans Le Chat [Connexion Impossible]
  [Teardown] Arret Felix

  [Template] Entrer Dans Le Chat [Connexion Impossible]


*** Test Cases ***

#
# Scénario nominal : entrée dans le chat
#
Entrer Dans Le Chat
	Entrer Dans Le Chat

Entrer Dans Le Chat [Modification de l'IP] [Modification du port]
	[Template] Entrer Dans Le Chat [Modification de l'IP] [Modification du port]

Entrer Dans Le Chat [Connexion Impossible]
	[Template] Entrer Dans Le Chat [Connexion Impossible]

*** Keywords ***