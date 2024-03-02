# Jeu du Snake en Assemblage MIPS

Bienvenue dans le Jeu du Snake, un jeu d'arcade classique réimplémenté en langage d'assemblage MIPS. Ce projet démontre les capacités de la programmation en assemblage MIPS et offre une expérience pratique avec le développement logiciel de bas niveau et les concepts d'architecture informatique.

## Vue d'ensemble du projet

Le Jeu du Snake est un jeu simple mais captivant où le joueur contrôle un serpent, le guidant pour manger de la nourriture tout en évitant les collisions avec les murs et sa propre queue. À mesure que le serpent mange, il s'allonge, augmentant la difficulté du jeu. Cette implémentation en assemblage MIPS fournit une version basique mais fonctionnelle du jeu, utilisant l'affichage bitmap du simulateur MARS et les E/S MMIO (Entrée/Sortie Mappée en Mémoire) pour le clavier et les graphismes.

## Prérequis

- Assurez-vous que Java est installé sur votre ordinateur.
- Téléchargez le simulateur MIPS MARS (Mars.jar) depuis la source officielle.

## Instructions de configuration

### Démarrer MARS et charger le programme

1. Ouvrez un terminal ou une invite de commande.
2. Naviguez jusqu'au répertoire contenant `Mars.jar` et le fichier `snake.asm`.
3. Exécutez la commande suivante pour démarrer MARS :

    ```bash
    java -jar Mars.jar
    ```

4. Chargez le code source **snake.asm** via le menu Fichier.

### Configurer l'affichage bitmap

Après avoir ouvert MARS, vous devrez activer et configurer manuellement l'affichage bitmap :

1. Allez dans le menu **Outils** de l'interface utilisateur MARS.
2. Sélectionnez **Affichage Bitmap** pour ouvrir l'outil d'affichage bitmap.
3. Appuyez sur le bouton **Connecter à MIPS**.
4. Configurez les paramètres d'affichage bitmap comme suit :
    - **Largeur par unité** : Réglez-la sur 16 pixels.
    - **Hauteur par unité** : Réglez-la sur 16 pixels.
    - **Largeur d'affichage** : Réglez-la sur 512 unités.
    - **Hauteur d'affichage** : Réglez-la sur 512 unités.
    - **Adresse de base** : Réglez-la sur 0x10010000 pour les données statiques.

### Configurer le simulateur MMIO pour le clavier et l'affichage

Étant donné que Snake est un jeu nécessitant une entrée clavier, nous devons activer le simulateur MMIO pour le clavier et l'affichage :

1. Allez dans le menu **Outils**.
2. Sélectionnez **Simulateur MMIO pour le clavier et l'affichage**.
3. Appuyez sur le bouton **Connecter à MIPS**.
4. Utilisez la section **Clavier : Les caractères tapés ici sont stockés dans Données du Récepteur 0xffff0004** pour l'entrée.

Cet outil simule l'entrée du clavier, vous permettant de contrôler le serpent.

### Exécuter le programme

Avec l'affichage bitmap et le MMIO clavier configurés, vous pouvez maintenant assembler et exécuter le jeu via l'interface MARS :

1. Cliquez sur le bouton **Assembler** dans la barre d'outils MARS pour assembler votre programme.
2. Pour exécuter le programme, cliquez sur le bouton **Exécuter**.

Le jeu devrait maintenant s'exécuter, avec le résultat affiché dans l'affichage bitmap et les interactions possibles via le simulateur MMIO clavier.

## Comment jouer

- Utilisez les touches `zqsd` (basées sur les claviers AZERTY) de votre clavier pour changer la direction du serpent.
- Guidez le serpent vers les éléments de nourriture qui apparaissent aléatoirement sur l'écran.
- Évitez de heurter les murs ou la queue du serpent.
