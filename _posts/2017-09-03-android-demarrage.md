---
title: "Installer un environnement de développement Android"
category: coding
author: macha
---
Pour installer un environnement de développement Android, vous pouvez soit télécharger l’environnement complet à partir du site officiel, soit télécharger seulement le SDK Android (System Development Kit) en utilisant un IDE (Integrated Development Environment) existant comme Eclipse ou Netbeans.
En général, le langage Java est utilisé pour programmer sous Android. Cependant, il est possible d’utiliser du C ou C++ si cela est nécessaire pour l’application (cf. application utilisant de manière intensive le CPU).

Ce tuto détaille comment installer un environnement de développement Android, pour le langage Java avec Android Studio (AS).

## Télécharger Android Studio
1. Aller sur le site de référence Android : developer.android.com
2. Puis dans la partie Develop > Tool
3. Télécharger Android Studio, AS
4. Lancer AS,
5. Si Java n'est pas déjà installé sur votre ordinateur alors une pop-up va vous suggérer de le faire, suivre les instructions d'installation, il faudra également installer le dernier JDK
6. Re-lancer AS

##  Installer les packages nécessaires à la création d'un projet sous AS

1. AS propose de configurer l'environnement de développement, choisir Standard
2. Accepter les licences et cliquer sur Finish. Le téléchargement des derniers packages (ici relatifs au SDK Lollipop, API 22) est lancé et peut prendre quelques dizaines de minutes
3. Avant de commencer un nouveau projet, aller dans Configure > SDK Manager et remarquer les packages installés. Ici, pour l'API 22 :
 * SDK Platform
 * SYSTEM IMAGE (pour l'émulateur) : Google APIs Intel x86 Atom System Image
 * SRC : Sources for Android SDK


## Installer les packages nécessaires au lancement d'un émulateur
1. Télécharger les packages nécéssaire au lancement de l'émulateur :
 * Intel x86 Emulator Accelerator (HAXM installer) dans le dossier Extras/
 * ARM EABI v7a System Image dans le dossier de la dernière version du SDK téléchargé (ici Android 5.1.1 (API 22)/)
2. Re-lancer AS afin que ces téléchargements soient pris en compte
3. Créer un nouveau projet configuré avec le SDK précédemment téléchargé (ici, API 22)
4. Ouvrer l'AVD Manager (cf. Icône pour ouvrir l'AVD Manager)
5. Créer un émulateur avec les configurations suivantes :
* Select Hardware : Configurer le matériel et cliquer sur Next.
Par exemple Category : Phone, Name : Nexus S, Size : 4.0'', Resolution : 480x800, Density : hdpi
 * System Image : Configurer le système d'exploitation et cliquer sur Next. Par exemple Release Name : Lollipop, API level : 22, ABI : armeabi-v7a, Target : Android 5.1.1
Android Virtual Device (AVD) : Vérifier la configuration et cliquer sur Finish
6. Lancer l'émulateur ainsi créé

Remarque : l'impression écran Icône pour ouvrir l'AVD Manager, présente également

l'icône pour ouvrir le SDK Manager (à droite), permettant de télécharger le dernier SDK Android ou autres
l'icône pour ouvrir Android Device Manager, permettant de voir les logs des émulateurs lancés ou smartphones connectés
Note : Il est recommandé d'installer le package des sources exemples pour la suite des tutos.

## Lancer un projet sur un émulateur ou un smartphone

1. Créer brièvement un nouveau projet android
2. Executer le projet (en cliquant sur la flèche verte)
3. Choisir de lancer l'app sur l'émulateur précédemment lancé ou bien sur le smartphone connecté
Si le smartphone est bien branché et n'apparait pas, vérifier qu'il est bien placé en mode Debug.
Il est aussi possible de vérifier qu'il soit bien connecté via un terminal :
1. Ouvrer un terminal
2. Placer vous dans le dossier platforms-tools/ du sdk  (ex : /Users/macha/Librairy/android/sdk/platforms-tool/)
Depuis AS, aller dans File>Project Structure>SDK Location pour connaître le dossier par défaut dans lequel AS place les sdk
3. Taper la commande adb device, elle permet d'obtenir la liste des smartphones ou tablettes connectées
