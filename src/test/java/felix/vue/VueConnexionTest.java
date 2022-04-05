package felix.vue;

import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.mockito.Mockito;
import org.netbeans.jemmy.JemmyProperties;
import org.netbeans.jemmy.TimeoutExpiredException;
import org.netbeans.jemmy.operators.JButtonOperator;
import org.netbeans.jemmy.operators.JFrameOperator;
import org.netbeans.jemmy.operators.JTextFieldOperator;

import felix.Felix;
import felix.communication.Connexion;
import felix.controleur.ControleurFelix;

public class VueConnexionTest {

    /**
     * Vue Connexion nécessaire aux tests.
     */
    private VueConnexion vueConnexion;

    /**
     * Mock d'un contrôleur nécessaire aux tests.
     */
    private ControleurFelix controleurMock;

    /**
     * Mock d'une connexion nécessaire aux tests.
     */
    private Connexion connexionMock;


    /**
     * Opérateurs de JFrame pour accéder à la fenêtre de la vue.
     */
    private JFrameOperator fenetre;

    /**
     * Opérateurs de JTextField pour accéder aux champs texte de la vue :
     * <ul>
     *     <li>l'adresse IP</li>
     *     <li>les messages d'information de connexion</li>
     *     <li>le port</li>
     * </ul>
     */
    private JTextFieldOperator texteIP, texteInformation, textePort;



    /**
     * Opérateurs de JButton pour accéder aux boutons de la vue : bouton "Connecter" de la vue
     */
    private JButtonOperator boutonConnecter;

    /**
     * Fixe les propriétés de Jemmy pour les tests.
     * Crée un mock de ...
     * Crée et affiche la vue nécessaire aux tests.
     *
     * <p>Code exécuté avant chaque test.</p>
     *
     * @throws Exception toute exception.
     *
     * @see org.netbeans.jemmy.JemmyProperties
     *
     */
    @Before
    public void setUp() throws Exception
    {
        // Fixe les timeouts de Jemmy :
        // https://javadoc.io/doc/org.netbeans/jemmy/latest/org/netbeans/jemmy/JemmyProperties.html
        // https://javadoc.io/doc/org.netbeans/jemmy/latest/org/netbeans/jemmy/FrameWaiter.html
        // https://javadoc.io/doc/org.netbeans/jemmy/latest/org/netbeans/jemmy/operators/ComponentOperator.html
        // (ex-doc : http://wiki.netbeans.org/Jemmy_Operators_Environment#Timeouts),
        // ici : 3s pour l'affichage d'une frame ou d'un composant (widget),
        //       ou une attente de changement d'état (waitText par exemple).
        final Integer timeout = 3000;
        JemmyProperties.setCurrentTimeout("FrameWaiter.WaitFrameTimeout", timeout);
        JemmyProperties.setCurrentTimeout("ComponentOperator.WaitComponentTimeout", timeout);
        JemmyProperties.setCurrentTimeout("ComponentOperator.WaitStateTimeout", timeout);

        // Création d'un mock de contrôleur.
        this.controleurMock = Mockito.mock(ControleurFelix.class);
        Assert.assertNotNull(this.controleurMock);


        // Création de la vue nécessaire aux tests.
        // La vue s'appuie sur le mock de contrôleur.
        this.vueConnexion = new VueConnexion(this.controleurMock);
        Assert.assertNotNull(this.vueConnexion);

        // Affichage de la vue et accès à cette vue.
        this.vueConnexion.affiche();
        this.accesVue();
    }



    /**
     * Fermeture de la vue caisse.
     *
     * <p>Code exécuté après chaque test.</p>
     *
     * @throws Exception toute exception.
     *
     */
    @After
    public void tearDown() throws Exception
    {
        // 2 secondes d'observation par suspension du thread
        final Long timeout = Long.valueOf(2000);
        Thread.sleep(timeout);

        if (this.vueConnexion != null) {
            this.vueConnexion.ferme();
        }
    }

    private void accesVue()
    {
        // Accès à la fenêtre de la vue de la connexion (par son titre).
        try {
            this.fenetre = new JFrameOperator(Felix.IHM.getString("FENETRE_CONNEXION_TITRE"));
        }
        catch (TimeoutExpiredException e) {
            Assert.fail("La fenêtre de la vue connexion n'est pas accessible : " + e.getMessage());
        }

        try {
            // Index pour la récupération des widgets.
            Integer index = 0;

            // Accès au champ de saisie de l'adresse IP (par son index).
            this.texteIP = new JTextFieldOperator(this.fenetre, index++);

            // Accès au champ de saisie du port (par son index).
            this.textePort = new JTextFieldOperator(this.fenetre, index++);



            // Ré-initialisation de l'index pour l'accès aux boutons.
            index = 0;

            // Accès au bouton de connexion (par son index).
            this.boutonConnecter = new JButtonOperator(this.fenetre, index++);

        }
        catch (TimeoutExpiredException e) {
            Assert.fail("Problème d'accès à un composant de la vue Connexion : " + e.getMessage());
        }
    }

    /**
     * Test l'initialisation des différents champs de la vue.
     *
     * <p>Méthodes concernées :
     * <ul>
     * <li> private void construireControles()
     * <li> private void initialiseIdQuantiteLibellePrix()
     * </ul>
     * </p>
     */
    @Test
    public void testInitialiseVue()
    {
        /*
         * Données de test.
         */
        final String texteIPAttendu = Felix.CONFIGURATION.getString("ADRESSE_CHAT");
        final String textePortAttendu = Felix.CONFIGURATION.getString("PORT_CHAT");
        final String texteInformationAttendu = Felix.IHM.getString("FENETRE_CONNEXION_MESSAGE_DEFAUT");

        final String boutonConnecterAttendu = Felix.IHM.getString("FENETRE_CONNEXION_BOUTON_CONNECTER");

        /*
         * Configuration et chargement du mock du contrôleur.
         */

        // Le mock du contrôleur sera sollicité lors de la perte du focus du champ
        // de saisie d'un identifiant lors de la fermeture de la fenêtre.
        // Le contrôleur retourne alors le mock de la connexion.
        Mockito.when(this.controleurMock.donneConnexion()).thenReturn(this.connexionMock);

        /*
         * Exécution du test.
         */
        try {
            // Récupération des valeurs des champs de la vue.
            final String texteIPActuel = this.texteIP.getText();
            final String textePortActuel = this.textePort.getText();


            // Récupération les libellés des boutons de la vue.
            final String boutonConnecterActuel = this.boutonConnecter.getText();


            // Assertions.
            Assert.assertEquals("Adresse IP par défaut invalide.", texteIPAttendu, texteIPActuel);
            Assert.assertEquals("Port par défaut invalide.", textePortAttendu, textePortActuel);
            Assert.assertEquals(
                    "Libellé du bouton de connexion invalide.",
                    boutonConnecterAttendu, boutonConnecterActuel);
        }
        catch (Exception e) {
            Assert.fail("Manipulation de la vue Connexion invalide." + e.getMessage());
        }

        /* Attention : la vérification des sollicitations faite au mock n'a pas de sens ici,
         * puisque celui-ci ne sera sollicité qu'à la fermeture de la fenêtre.
         */
    }



}
