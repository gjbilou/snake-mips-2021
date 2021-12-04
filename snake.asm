#                      _..._                 .           __.....__
#                    .'     '.             .'|       .-''         '.
#                   .   .-.   .          .'  |      /     .-''"'-.  `.
#                   |  '   '  |    __   <    |     /     /________\   \
#               _   |  |   |  | .:--.'.  |   | ____|                  |
#             .' |  |  |   |  |/ |   \ | |   | \ .'\    .-------------'
#            .   | /|  |   |  |`" __ | | |   |/  .  \    '-.____...---.
#          .'.'| |//|  |   |  | .'.''| | |    /\  \  `.             .'
#        .'.'.-'  / |  |   |  |/ /   | |_|   |  \  \   `''-...... -'
#        .'   \_.'  |  |   |  |\ \._,\ '/'    \  \  \
#                   '--'   '--' `--'  `"'------'  '---'
#
#
#
#                                               .......
#                                     ..  ...';:ccc::,;,'.
#                                 ..'':cc;;;::::;;:::,'',,,.
#                              .:;c,'clkkxdlol::l;,.......',,
#                          ::;;cok0Ox00xdl:''..;'..........';;
#                          o0lcddxoloc'.,. .;,,'.............,'
#                           ,'.,cc'..  .;..;o,.       .......''.
#                             :  ;     lccxl'          .......'.
#                             .  .    oooo,.            ......',.
#                                    cdl;'.             .......,.
#                                 .;dl,..                ......,,
#                                 ;,.                   .......,;
#                                                        ......',
#                                                       .......,;
#                                                       ......';'
#                                                      .......,:.
#                                                     .......';,
#                                                   ........';:
#                                                 ........',;:.
#                                             ..'.......',;::.
#                                         ..';;,'......',:c:.
#                                       .;lcc:;'.....',:c:.
#                                     .coooc;,.....,;:c;.
#                                   .:ddol,....',;:;,.
#                                  'cddl:'...,;:'.
#                                 ,odoc;..',;;.                    ,.
#                                ,odo:,..';:.                     .;
#                               'ldo:,..';'                       .;.
#                              .cxxl,'.';,                        .;'
#                              ,odl;'.',c.                         ;,.
#                              :odc'..,;;                          .;,'
#                              coo:'.',:,                           ';,'
#                              lll:...';,                            ,,''
#                              :lo:'...,;         ...''''.....       .;,''
#                              ,ooc;'..','..';:ccccccccccc::;;;.      .;''.
#          .;clooc:;:;''.......,lll:,....,:::;;,,''.....''..',,;,'     ,;',
#       .:oolc:::c:;::cllclcl::;cllc:'....';;,''...........',,;,',,    .;''.
#      .:ooc;''''''''''''''''''',cccc:'......'',,,,,,,,,,;;;;;;'',:.   .;''.
#      ;:oxoc:,'''............''';::::;'''''........'''',,,'...',,:.   .;,',
#     .'';loolcc::::c:::::;;;;;,;::;;::;,;;,,,,,''''...........',;c.   ';,':
#     .'..',;;::,,,,;,'',,,;;;;;;,;,,','''...,,'''',,,''........';l.  .;,.';
#    .,,'.............,;::::,'''...................',,,;,.........'...''..;;
#   ;c;',,'........,:cc:;'........................''',,,'....','..',::...'c'
#  ':od;'.......':lc;,'................''''''''''''''....',,:;,'..',cl'.':o.
#  :;;cclc:,;;:::;''................................'',;;:c:;,'...';cc'';c,
#  ;'''',;;;;,,'............''...........',,,'',,,;:::c::;;'.....',cl;';:.
#  .'....................'............',;;::::;;:::;;;;,'.......';loc.'.
#   '.................''.............'',,,,,,,,,'''''.........',:ll.
#    .'........''''''.   ..................................',;;:;.
#      ...''''....          ..........................'',,;;:;.
#                                ....''''''''''''''',,;;:,'.
#                                    ......'',,'','''..
#


################################################################################
#                  Fonctions d'affichage et d'entrée clavier                   #
################################################################################

# Ces fonctions s'occupent de l'affichage et des entrées clavier.
# Il n'est pas obligatoire de comprendre ce qu'elles font.

.data

# Tampon d'affichage du jeu 256*256 de manière linéaire.

frameBuffer: .word 0 : 1024  # Frame buffer

# Code couleur pour l'affichage
# Codage des couleurs 0xwwxxyyzz où
#   ww = 00
#   00 <= xx <= ff est la couleur rouge en hexadécimal
#   00 <= yy <= ff est la couleur verte en hexadécimal
#   00 <= zz <= ff est la couleur bleue en hexadécimal

colors: .word 0x00000000, 0x00ff0000, 0xff00ff00, 0x00396239, 0x00ff00ff
.eqv black 0
.eqv red   4
.eqv green 8
.eqv greenV2  12
.eqv rose  16

# Dernière position connue de la queue du serpent.

lastSnakePiece: .word 0, 0

.text
j main

############################# printColorAtPosition #############################
# Paramètres: $a0 La valeur de la couleur
#             $a1 La position en X
#             $a2 La position en Y
# Retour: Aucun
# Effet de bord: Modifie l'affichage du jeu
################################################################################

printColorAtPosition:
lw $t0 tailleGrille
mul $t0 $a1 $t0
add $t0 $t0 $a2
sll $t0 $t0 2
sw $a0 frameBuffer($t0)
jr $ra

################################ resetAffichage ################################
# Paramètres: Aucun
# Retour: Aucun
# Effet de bord: Réinitialise tout l'affichage avec la couleur noir
################################################################################

resetAffichage:
lw $t1 tailleGrille
mul $t1 $t1 $t1
sll $t1 $t1 2
la $t0 frameBuffer
addu $t1 $t0 $t1
lw $t3 colors + black

RALoop2: bge $t0 $t1 endRALoop2
  sw $t3 0($t0)
  add $t0 $t0 4
  j RALoop2
endRALoop2:
jr $ra

################################## printSnake ##################################
# Paramètres: Aucun
# Retour: Aucun
# Effet de bord: Change la couleur de l'affichage aux emplacement ou se
#                trouve le serpent et sauvegarde la dernière position connue de
#                la queue du serpent.
################################################################################

printSnake:
subu $sp $sp 12
sw $ra 0($sp)
sw $s0 4($sp)
sw $s1 8($sp)

lw $s0 tailleSnake
sll $s0 $s0 2
li $s1 0

lw $a0 colors + greenV2
lw $a1 snakePosX($s1)
lw $a2 snakePosY($s1)
jal printColorAtPosition
li $s1 4

PSLoop:
bge $s1 $s0 endPSLoop
  lw $a0 colors + green
  lw $a1 snakePosX($s1)
  lw $a2 snakePosY($s1)
  jal printColorAtPosition
  addu $s1 $s1 4
  j PSLoop
endPSLoop:

subu $s0 $s0 4
lw $t0 snakePosX($s0)
lw $t1 snakePosY($s0)
sw $t0 lastSnakePiece
sw $t1 lastSnakePiece + 4

lw $ra 0($sp)
lw $s0 4($sp)
lw $s1 8($sp)
addu $sp $sp 12
jr $ra

################################ printObstacles ################################
# Paramètres: Aucun
# Retour: Aucun
# Effet de bord: Change la couleur de l'affichage aux emplacement des obstacles.
################################################################################

printObstacles:
subu $sp $sp 12
sw $ra 0($sp)
sw $s0 4($sp)
sw $s1 8($sp)

lw $s0 numObstacles
sll $s0 $s0 2
li $s1 0

POLoop:
bge $s1 $s0 endPOLoop
  lw $a0 colors + red
  lw $a1 obstaclesPosX($s1)
  lw $a2 obstaclesPosY($s1)
  jal printColorAtPosition
  addu $s1 $s1 4
  j POLoop
endPOLoop:

lw $ra 0($sp)
lw $s0 4($sp)
lw $s1 8($sp)
addu $sp $sp 12
jr $ra

################################## printCandy ##################################
# Paramètres: Aucun
# Retour: Aucun
# Effet de bord: Change la couleur de l'affichage à l'emplacement du bonbon.
################################################################################

printCandy:
subu $sp $sp 4
sw $ra ($sp)

lw $a0 colors + rose
lw $a1 candy
lw $a2 candy + 4
jal printColorAtPosition

lw $ra ($sp)
addu $sp $sp 4
jr $ra

eraseLastSnakePiece:
subu $sp $sp 4
sw $ra ($sp)

lw $a0 colors + black
lw $a1 lastSnakePiece
lw $a2 lastSnakePiece + 4
jal printColorAtPosition

lw $ra ($sp)
addu $sp $sp 4
jr $ra

################################## printGame ###################################
# Paramètres: Aucun
# Retour: Aucun
# Effet de bord: Effectue l'affichage de la totalité des éléments du jeu.
################################################################################

printGame:
subu $sp $sp 4
sw $ra 0($sp)

jal eraseLastSnakePiece
jal printSnake
jal printObstacles
jal printCandy

lw $ra 0($sp)
addu $sp $sp 4
jr $ra

############################## getRandomExcluding ##############################
# Paramètres: $a0 Un entier x | 0 <= x < tailleGrille
# Retour: $v0 Un entier y | 0 <= y < tailleGrille, y != x
################################################################################

getRandomExcluding:
move $t0 $a0
lw $a1 tailleGrille
li $v0 42
syscall
beq $t0 $a0 getRandomExcluding
move $v0 $a0
jr $ra

########################### newRandomObjectPosition ############################
# Description: Renvoie une position aléatoire sur un emplacement non utilisé
#              qui ne se trouve pas devant le serpent.
# Paramètres: Aucun
# Retour: $v0 Position X du nouvel objet
#         $v1 Position Y du nouvel objet
################################################################################

newRandomObjectPosition:
subu $sp $sp 4
sw $ra ($sp)

lw $t0 snakeDir
and $t0 0x1
bgtz $t0 horizontalMoving
li $v0 42
lw $a1 tailleGrille
syscall
move $t8 $a0
lw $a0 snakePosY
jal getRandomExcluding
move $t9 $v0
j endROPdir

horizontalMoving:
lw $a0 snakePosX
jal getRandomExcluding
move $t8 $v0
lw $a1 tailleGrille
li $v0 42
syscall
move $t9 $a0
endROPdir:

lw $t0 tailleSnake
sll $t0 $t0 2
la $t0 snakePosX($t0)
la $t1 snakePosX
la $t2 snakePosY
li $t4 0

ROPtestPos:
bge $t1 $t0 endROPtestPos
lw $t3 ($t1)
bne $t3 $t8 ROPtestPos2
lw $t3 ($t2)
beq $t3 $t9 replayROP
ROPtestPos2:
addu $t1 $t1 4
addu $t2 $t2 4
j ROPtestPos
endROPtestPos:

bnez $t4 endROP

lw $t0 numObstacles
sll $t0 $t0 2
la $t0 obstaclesPosX($t0)
la $t1 obstaclesPosX
la $t2 obstaclesPosY
li $t4 1
j ROPtestPos

endROP:
move $v0 $t8
move $v1 $t9
lw $ra ($sp)
addu $sp $sp 4
jr $ra

replayROP:
lw $ra ($sp)
addu $sp $sp 4
j newRandomObjectPosition

################################# getInputVal ##################################
# Paramètres: Aucun
# Retour: $v0 La valeur 0 (haut), 1 (droite), 2 (bas), 3 (gauche), 4 erreur
################################################################################

getInputVal:
lw $t0 0xffff0004
li $t1 115
beq $t0 $t1 GIbas
li $t1 122
beq $t0 $t1 GIhaut
li $t1 113
beq $t0 $t1 GIgauche
li $t1 100
beq $t0 $t1 GIdroite
li $v0 4
j GIend

GIhaut:
li $v0 0
j GIend

GIdroite:
li $v0 1
j GIend

GIbas:
li $v0 2
j GIend

GIgauche:
li $v0 3

GIend:
jr $ra

################################ sleepMillisec #################################
# Paramètres: $a0 Le temps en milli-secondes qu'il faut passer dans cette
#             fonction (approximatif)
# Retour: Aucun
################################################################################

sleepMillisec:
move $t0 $a0
li $v0 30
syscall
addu $t0 $t0 $a0

SMloop:
bgt $a0 $t0 endSMloop
li $v0 30
syscall
j SMloop

endSMloop:
jr $ra

##################################### main #####################################
# Description: Boucle principal du jeu
# Paramètres: Aucun
# Retour: Aucun
################################################################################

main:

# Initialisation du jeu

jal resetAffichage
jal newRandomObjectPosition
sw $v0 candy
sw $v1 candy + 4

# Boucle de jeu

mainloop:

jal getInputVal
move $a0 $v0
jal majDirection
jal updateGameStatus
jal conditionFinJeu
bnez $v0 gameOver
jal printGame
li $a0 500
jal sleepMillisec
j mainloop

gameOver:
jal affichageFinJeu
li $v0 10
syscall

################################################################################
#                                Partie Projet                                 #
################################################################################

# À vous de jouer !

.data

tailleGrille:  .word 16        # Nombre de case du jeu dans une dimension.

# La tête du serpent se trouve à (snakePosX[0], snakePosY[0]) et la queue à
# (snakePosX[tailleSnake - 1], snakePosY[tailleSnake - 1])
tailleSnake:   .word 1         # Taille actuelle du serpent.
snakePosX:     .word 0 : 1024  # Coordonnées X du serpent ordonné de la tête à la queue.
snakePosY:     .word 0 : 1024  # Coordonnées Y du serpent ordonné de la t.

# Les directions sont représentés sous forme d'entier allant de 0 à 3:
snakeDir:      .word 1         # Direction du serpent: 0 (haut), 1 (droite)
                               #                       2 (bas), 3 (gauche)
numObstacles:  .word 0         # Nombre actuel d'obstacle présent dans le jeu.
obstaclesPosX: .word 0 : 1024  # Coordonnées X des obstacles
obstaclesPosY: .word 0 : 1024  # Coordonnées Y des obstacles
candy:         .word 0, 0      # Position du bonbon (X,Y)
scoreJeu:      .word 0         # Score obtenu par le joueur
message_fin_game: .asciiz "Game Over. Votre score est de : "

.text

################################# majDirection #################################
# Paramètres: $a0 La nouvelle position demandée par l'utilisateur. La valeur
#                 étant le retour de la fonction getInputVal.
# Retour: Aucun
# Effet de bord: La direction du serpent à été mise à jour.
# Post-condition: La valeur du serpent reste intacte si une commande illégale
#                 est demandée, i.e. le serpent ne peut pas faire de demi-tour
#                 en un unique tour de jeu. Cela s'apparente à du cannibalisme
#                 et à été proscrit par la loi dans les sociétés reptiliennes.
################################################################################

majDirection:

# En haut, ... en bas, ... à gauche, ... à droite, ... ces soirées là ...

#Prologue
subi $sp, $sp, 8 #augmenter la taille de la pile de 8 octets
sw $s0, 4($sp)   #sauvgarde du registre $s0 qu'on va utiliser dans la pile 
sw $ra, 0($sp)   #sauvgarde du registre $ra qui nous permet de revenir a la fonciton appelante dans la pile

#corps de la fonciton 
lw $s0, snakeDir #on mets la valeur dans snakeDir dans le registre $s0
sub $s0, $a0, $s0 #on effectue la difference entre $a0 et snakeDir (dans $s0) et on ne fait rien si le resultat est egal a 2 ou -2
beq $s0, 2, endMajDirection #si le resultat de la difference est 2 ne change pas snakeDir
beq $s0, -2, endMajDirection #si le resultat de la difference est -2 ne change pas snakeDir
sw $a0, snakeDir

#Epilogue
endMajDirection:
lw $s0, 4($sp) #on remet la valeur de $s0 sauvgarde dans la pile dans le registre $s0
lw $ra, 0($sp) #on remet la valeur de $ra sauvgarde dans la pile dans le registre $ra
addi $sp, $sp, 8 #desallocation de memoire (8 octets) de la pile alloue pendant le prologue de majDirection
jr $ra #retour a la fonction appelante


############################### updateGameStatus ###############################
# Paramètres: Aucun
# Retour: Aucun
# Effet de bord: L'état du jeu est mis à jour d'un pas de temps. Il faut donc :
#                  - Faire bouger le serpent
#                  - Tester si le serpent à manger le bonbon
#                    - Si oui déplacer le bonbon et ajouter un nouvel obstacle
################################################################################

#updateGameStatus:

# jal hiddenCheatFunctionDoingEverythingTheProjectDemandsWithoutHavingToWorkOnIt
sD3:
subi $s3, $s3, 1
sw $s3, snakePosY
j verifCandy

sD1:
addi $s3, $s3, 1
sw $s3, snakePosY
j verifCandy

sD0:
subi $s2, $s2, 1
sw $s2, snakePosX
j verifCandy

sD2:
addi $s2, $s2, 1
sw $s2, snakePosX
j verifCandy

decalX:
move $s6, $s1
mul $s6, $s6, 4
add $s6, $s6, $s4
lw $s7, -4($s6)
sw $s7, ($s6)

subi $s1, $s1, 1

beq $s1, 0,decalY 

j decalX

decalY:
la $s5, snakePosY #contient l'@ du premiere element des Y de snake
move $s6, $t0
mul $s6, $s6, 4
add $s6, $s6, $s5
lw $s7, -4($s6)
sw $s7, ($s6)

subi $t0, $t0, 1

beq $t0, 0,bougerTete 

j decalY


updateGameStatus:
#Prologue 
subi $sp, $sp, 36 #allocation de 9 case memoire dans la pile
sw $s0, 32($sp) #sauvgarde de s0 dans la pile
sw $s1, 28($sp) #sauvgarde de s1 dans la pile
sw $s2, 24($sp) #sauvgarde de s2 dans la pile
sw $s3, 20($sp) #sauvgarde de s3 dans la pile
sw $s4, 16($sp) #sauvgarde de s4 dans la pile
sw $s5, 12($sp) #sauvgarde de s5 dans la pile
sw $s6, 8($sp) #sauvgarde de s6 dans la pile
sw $s7, 4($sp) #sauvgarde de s7 dans la pile
sw $ra, 0($sp) #sauvgarde de ra dans la pile


#Corps de la fonction 
lw $s0, snakeDir
lw $s1, tailleSnake 
lw $t0, tailleSnake
lw $s2, snakePosX #X de la tete du snake
lw $s3, snakePosY #Y de la tete du snake

la $s4, snakePosX #contient l'@ du premiere element des X de snake
j decalX

 


bougerTete:
beq $s0, 3, sD3 #si snakeDir est 3 
beq $s0, 1, sD1 #si snakeDir est 1 
beq $s0, 0, sD0 #si snakeDir est 0
beq $s0, 2, sD2 #si snakeDir est 2


verifCandy:
lw $s1, tailleSnake
lw $s2, snakePosX
lw $s3, snakePosY
lw $s4, candy
lw $s5, candy+4
lw $s6, scoreJeu
beq $s2, $s4, ajoutCandy
j endUGS

ajoutCandy:
bne $s3, $s5, endUGS
addi $s1, $s1, 1
sw $s1, tailleSnake
addi $s6, $s6, 1
sw $s6, scoreJeu


# Retour: $v0 Position X du nouvel objet
#         $v1 Position Y du nouvel objet

jal newRandomObjectPosition
sw $v0, candy
sw $v1, candy+4

lw $s2, numObstacles
addi $s2, $s2, 1
sw $s2, numObstacles


jal newRandomObjectPosition

la $s1, obstaclesPosX
la $s6, obstaclesPosY
sw $v0, ($s1)
sw $v1, ($s6)






#Epilogue
endUGS:

lw $s0, 32($sp)
lw $s1, 28($sp)
lw $s2, 24($sp)
lw $s3, 20($sp)
lw $s4, 16($sp)
lw $s5, 12($sp)
lw $s6, 8($sp)
lw $s7, 4($sp)
lw $ra, 0($sp)
addi $sp, $sp, 36 #desallocation memoire de la pile 
jr $ra #retour a la fonction appelante

############################### conditionFinJeu ################################
# Paramètres: Aucun
# Retour: $v0 La valeur 0 si le jeu doit continuer ou toute autre valeur sinon.
################################################################################





traverserTableObs:


addi $s5, $s5, 4
addi $s6, $s6, 4
lw $s2, ($s5)
lw $s3, ($s6)
addi $s7, $s7, 1
j verifObs


traverserCorpsSnake:

addi $s5, $s5, 4
addi $s6, $s6, 4
lw $s2, 4($s5)
lw $s3, 4($s6)
addi $s7 $s7 1
j verifCorps




error:
li $v0, 1
j endCFJ


continue:

li $v0 0
j endCFJ



conditionFinJeu:


subi $sp, $sp, 36 #allocation de 9 case memoire dans la pile
sw $s0, 32($sp) #sauvgarde de s0 dans la pile
sw $s1, 28($sp) #sauvgarde de s1 dans la pile
sw $s2, 24($sp) #sauvgarde de s2 dans la pile
sw $s3, 20($sp) #sauvgarde de s3 dans la pile
sw $s4, 16($sp) #sauvgarde de s4 dans la pile
sw $s5, 12($sp) #sauvgarde de s5 dans la pile
sw $s6, 8($sp) #sauvgarde de s6 dans la pile
sw $s7, 4($sp) #sauvgarde de s7 dans la pile
sw $ra, 0($sp) #sauvgarde de ra dans la pile

# Aide: Remplacer cette instruction permet d'avancer dans le projet.
li $v0 0





lw $s0, snakePosX
lw $s1, snakePosY

la $s5, obstaclesPosX
la $s6, obstaclesPosY
lw $s2, ($s5)
lw $s3, ($s6)
lw $s4, numObstacles
li $s7, 0


#verifier si il touche le bord
beq $s0, -1, error
beq $s0, 16, error
beq $s1, -1, error
beq $s1, 16, error

verifObs:
#verifier s'il touche un obstacle 

beq $s7, $s4, kk
bne $s0, $s2, traverserTableObs
bne $s1, $s3, traverserTableObs
j error


kk:

lw $s0, snakePosX #valeur de X de la tete du snake
lw $s1, snakePosY #valeur de Y de la tete du snake

la $s5, snakePosX #@ de X de la tete du snake
la $s6, snakePosY #@ de Y de la tete du snake
lw $s2, 4($s5) #s2, va contenir le contenu de la 2 eme case suivant la tete X
lw $s3, 4($s6) #s3, va contenir le contenu de la 2 eme case suivant la tete Y
lw $s4, tailleSnake
li $s7, 1



verifCorps:
#verifier s'il touche son corps
beq $s7, $s4, continue

bne $s0, $s2, traverserCorpsSnake
bne $s1, $s3, traverserCorpsSnake
j error



endCFJ:
lw $s0, 32($sp)
lw $s1, 28($sp)
lw $s2, 24($sp)
lw $s3, 20($sp)
lw $s4, 16($sp)
lw $s5, 12($sp)
lw $s6, 8($sp)
lw $s7, 4($sp)
lw $ra, 0($sp)
addi $sp, $sp, 36 #desallocation memoire de la pile 
jr $ra

############################### affichageFinJeu ################################
# Paramètres: Aucun
# Retour: Aucun
# Effet de bord: Affiche le score du joueur dans le terminal suivi d'un petit
#                mot gentil (Exemple : «Quelle pitoyable prestation !»).
# Bonus: Afficher le score en surimpression du jeu.
################################################################################

affichageFinJeu:

subi $sp, $sp, 12

sw $v0, 8($sp)
sw $a0, 4($sp)
sw $ra, 0($sp)
# Fin.



la $a0, message_fin_game
li $v0, 4
syscall
lw $a0, scoreJeu
li $v0, 1
syscall



lw $v0, 8($sp)
lw $a0, 4($sp)
lw $ra, 0($sp)
addi $sp, $sp, 12
jr $ra
