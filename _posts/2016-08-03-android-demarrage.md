---
title: "Installer un environnement de développement Android"
categories: fr coding tutoriel android
author: macha
---

<div class="text-center lead" markdown="1">
  ![Android Configuration](/assets/img/post/android-config.png)
</div>

Ce tutoriel détaille comment installer un environnement de développement _Android_.
_Android Studio_, il conviendra d'utiliser l'abréviation _AS_, est le logiciel officiel, supporté par Google, basé sur IntelliJ de la société JetBrains.

Pour installer un environnement de développement _Android_, la solution la plus adéquate est de
télécharger _AS_ à partir du site officiel.
Une alternative est de télécharger seulement le _SDK Android_ (_SDK_ est l'acronyme de _System Development Kit_) en utilisant un _IDE_
(_Integrated Development Environment_) existant comme _Eclipse_ ou _Netbeans_.

Jusqu'à présent, le langage _Java_ était utilisé pour programmer sous _Android_. Cela dit, depuis l'annonce officiel du support du langage _Kotlin_ dans _Android_ (cf. [article d'Introduction à Kotlin](/blog/2017/07/11/android-kotlin-introduction/)), il est recommandé de privilégier ce dernier dans vos développements d'application _Android_. En effet, _Kotlin_ nous évite de taper des lignes de code inutiles, _boilerplate_ en anglais.
Par ailleurs, il est possible d’utiliser du _C_ ou _C++_, si cela est nécessaire pour l’application
Par exemple, une application utilisant de manière intensive le _CPU_, ou bien utilisant une bibliothèque _C_.

Dans la suite, nous nous concentrerons sur le développement d'application _Android_, avec le langage _Kotlin_, dans _Android Studio_.

<!--more-->

## Télécharger Android Studio

1. Allez sur le site de référence Android : [developer.android.com](https://developer.android.com/){:target="_blank"}
2. Puis dans la partie _DEVELOP_ > _Android Studio_
3. Téléchargez AS
4. Lancez le logiciel
5. Si _Java Development Kit_ n'est pas déjà installé sur votre ordinateur alors une fenêtre devrait vous
  suggérer de le faire, suivre les instructions d'installation
6. Re-lancez AS

##  Installer les paquetages nécessaires à la création d'un projet

1. AS propose de configurer l'environnement de développement, choisissez Standard
2. Acceptez les licences et cliquer sur _Finish_. Le téléchargement des derniers
  paquetages (ici relatifs à la dernière version O, API 26) est lancé et peut prendre
  quelques dizaines de minutes. Veillez à ne télécharger que la **dernière version d'Android**.
3. Avant de commencer un nouveau projet, aller dans _Configure_ > _SDK Manager_ et
  remarquer les paquetages installés. Ici, pour l'API 26 :
 * SDK Platform
 * SYSTEM IMAGE (pour l'émulateur) : Google APIs Intel x86 Atom System Image
 * SRC : Sources for Android SDK


## Installer les paquetages nécessaires au lancement d'un émulateur

1. Téléchargez les paquetages nécéssaires au lancement de l'émulateur :
 * _Intel x86 Emulator Accelerator (HAXM installer)_ dans le dossier _Extras/_
 * _ARM EABI v7a System Image_ dans le dossier de la dernière version du _SDK_
  téléchargé
2. Re-lancez AS afin que ces téléchargements soient pris en compte, si besoin
3. Créez un nouveau projet configuré avec le _SDK_ précédemment téléchargé
4. Ouvrez l'_AVD Manager_ disponible à partir de l'icône avec un _smartphone_ accompagné d'un aperçu de la tête  de notre mascotte verte, en bas à droite
5. Créez un émulateur avec les configurations suivantes :
  * Select Hardware : Configurez le matériel et cliquer sur _Next_.
    Par exemple Category : Phone, Name : Nexus S, Size : 4.0'', Resolution :
    480x800, Density : hdpi
  * System Image : Configurer le système d'exploitation et cliquer sur _Next_. Par
    exemple Release Name : Lollipop, API level : 22, ABI : armeabi-v7a, Target :
    Android 5.1.1
  * Android Virtual Device (AVD) : Vérifiez la configuration et cliquer sur Finish
6. Lancez l'émulateur ainsi créé via l'icône flèche verte situé a côté de celui-ci

## Lancer un projet sur un émulateur ou un smartphone

1. Reprenez le projet _Android_ déjà créé ou créez en un brièvement
2. Exécutez le projet (en cliquant sur la flèche verte)
3. Choisir de lancer l'app. sur l'émulateur précédemment lancé ou bien sur le smartphone branché en USB à votre ordinateur
  * Si le smartphone est bien branché et n'apparait pas, vérifier qu'il est bien placé en mode _Debug_.
  * Il est aussi possible de vérifier qu'il soit bien connecté via un terminal :
   1. Ouvrez un terminal
   2. Placez vous dans le dossier `platforms-tools/` du _SDK_ (ex : `/Users/macha/Librairy/android/sdk/platforms-tool/`)
   3. Tapez la commande _adb device_, elle permet d'obtenir la liste des smartphones ou tablettes connectées

Note : dans AS, afin de connaître le dossier par défaut, dans lequel AS place les _SDK_, allez dans _File_ > _Project Structure_ > _SDK Location_

Finalement, nous avons créé un projet vide et l'avons exécuté sur un émulateur ou _smartphone_. Cela, après avoir installé AS puis téléchargé les paquetages relatifs la dernière version d'_Android_.

Pour commencer les 3 premiers icônes à retenir sont :

  * _AVD Manager_ : le _smartphone_ avec une tête de _droid_
  * _SDK Manager_ : une flèche bleu vers le bas avec une tête de _droid_
  * Exécution d'un projet : la flèche verte

Le _SDK Manager_ permet de télécharger le dernier _SDK Android_ ou autres.

*[CPU]: Central Processing Unit
*[AS]: Android Studio
