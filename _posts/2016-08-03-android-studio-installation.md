---
title: "Installer un environnement de développement Android [AK 1]"
categories: fr coding tutoriel android
author: macha
last_update: 2018-01-15
---

<div class="text-center lead" markdown="1">
  ![Android Configuration](/assets/img/post/android-config.png)
</div>

Ce tutoriel détaille comment installer un environnement de développement _Android_.
_Android Studio_ est le logiciel officiel, supporté par Google et basé sur *IntelliJ*,
de la société *JetBrains*. Dans la suite, il conviendra d'utiliser l'abréviation _AS_.

Pour installer un environnement de développement _Android_, la solution la plus
adéquate est de télécharger _AS_ à partir du site officiel [\[1\]](#android).
Une alternative est de télécharger seulement le _SDK Android_ (_SDK_ est l'acronyme
de _Software Development Kit_) en utilisant un _IDE_ (_Integrated Development Environment_)
existant comme _Eclipse_ ou _Netbeans_.

Jusqu'à présent, le langage _Java_ était utilisé pour programmer sous _Android_.
Cela dit, depuis l'annonce officielle du support du langage _Kotlin_ dans _Android_
(cf. [article d'Introduction à Kotlin](/blog/2017/07/11/android-kotlin-introduction/)),
il est recommandé de privilégier ce dernier dans vos développements d'applications _Android_.
En effet, _Kotlin_ nous évite de taper des lignes de code inutiles (_boilerplate_ en anglais).
Par ailleurs, il est possible d’utiliser du _C_ ou _C++_, si cela est nécessaire
pour l’application. Par exemple, une application utilisant de manière intensive
le _CPU_, ou bien utilisant une bibliothèque _C_.

Dans la suite, nous nous concentrerons sur le développement d'application _Android_,
avec le langage _Kotlin_, dans _Android Studio_.

## Télécharger Android Studio

1. Allez sur le site de référence Android : [developer.android.com](https://developer.android.com/){:target="_blank"}
2. Puis dans la partie _DEVELOP_ > _Android Studio_
3. Téléchargez _AS_, acceptez les _Terms and Conditions_ et cliquez sur le bouton
_Download Android Stdudio for ..._
4. Dézipez le fichier téléchargé, suivez les instructions d'installation propre
à votre plateforme _Mac_, _Linux_ ou _Windows_.
5. Si _Java Development Kit_ n'est pas déjà installé sur votre ordinateur alors
une fenêtre devrait vous suggérer de le faire, suivre les instructions d'installation.

##  Installer les paquetages nécessaires à la création d'un projet

Veillez à ne télécharger que la ou les deux **dernière(s) version(s) d'Android**.
La dernière afin d'avoir une version à jour et l'avant dernière afin de pouvoir
exécuter le projet par défaut, créé via _AS_.

1. Lancez le logiciel _AS_, suivez les instructions d'installation.
2. _AS_ propose de configurer l'environnement de développement, choisissez
_Standard_ pour une première installation.
3. Acceptez les licences et cliquer sur _Finish_. Le téléchargement des derniers
  paquetages (ici relatifs à la dernière version O, API 26) est lancé et peut prendre
  quelques dizaines de minutes : "allez prendre un café" :coffee:.
4. Avant de commencer un nouveau projet, aller dans _Configure_ > _SDK Manager_ et
  remarquez les paquetages installés en cochant sur _Show Package Details_. Ici,
  pour l'API 26 :
 * SDK Platform
 * SYSTEM IMAGE (pour l'émulateur) : Google APIs Intel x86 Atom System Image
 * SRC : Sources for Android SDK

Remarque : Si vous avez choisi une installation _Custom_ au lieu de _Standard_,
vous avez la possibilité de télécharger _HAMX_ (un accélérateur d'émulateur).
Cela dit, son installation nécessite votre présence pour entrer le mot de passe
administrateur.

## Installer les paquetages nécessaires au lancement d'un émulateur

1. Téléchargez les paquetages nécessaires au lancement de l'émulateur :
 * _Intel x86 Emulator Accelerator (HAXM installer)_ dans le dossier `Extras/`
 * _ARM EABI v7a System Image_ dans le dossier de la dernière version du _SDK_
  téléchargé
2. Re-lancez _AS_ afin que ces téléchargements soient pris en compte
3. Créez un nouveau projet configuré avec le _SDK_ précédemment téléchargé
4. Ouvrez l'_AVD Manager_ disponible à partir de l'icône avec un _smartphone_
accompagné d'un aperçu de la tête de notre mascotte verte
5. Créez un émulateur avec les configurations suivantes :
  * Select Hardware : Configurez le matériel et cliquer sur _Next_.
    Par exemple sélectionnez un téléphone _Nexus S_ dont la résolution est 480x800
  * System Image : Configurer le système d'exploitation et cliquer sur _Next_. Par
    exemple : Release Name: Lollipop, API level: 22, ABI: x86, Target: Android 5.1.1
  * Android Virtual Device (AVD) : Observez la configuration via _Show Advanced Settings_
  et cliquer sur _Finish_
6. Lancez l'émulateur ainsi créé via l'icône "flèche verte" situé a côté de celui-ci

## Lancer un projet sur un émulateur ou un smartphone

1. Créez brièvement un projet _Android_
2. Exécutez le projet (en cliquant sur la flèche verte)
3. Choisir de lancer l'application sur l'émulateur précédemment lancé ou bien sur
le smartphone branché en USB à votre ordinateur
  * Si le smartphone est bien branché et n'apparait pas, vérifier qu'il est bien
  placé en mode _Debug_.
  * Il est aussi possible de vérifier qu'il soit bien connecté via un terminal :
   1. Ouvrez un terminal
   2. Placez vous dans le dossier `platforms-tools/` du _SDK_ (ex : `/Users/macha/Librairy/android/sdk/platforms-tool/`)
   3. Tapez la commande `adb device`, elle permet d'obtenir la liste des smartphones
   ou tablettes connectées

Note : dans _AS_, afin de connaître le dossier par défaut, dans lequel AS place
les _SDK_, allez dans _File_ > _Project Structure_ > _SDK Location_

Finalement, nous avons créé un projet vide et l'avons exécuté sur un émulateur
ou _smartphone_. Cela, après avoir installé _AS_ puis téléchargé les paquetages
relatifs aux dernières versions d'_Android_.

Pour commencer les 3 premières icônes à retenir sont :

  * ![Icône Android Execution : flèche verte](/assets/img/post/android/as-ic-execute.png) _Run 'app'_ : elle permet l'exécution d'un projet
  * ![Icône Android Emulateur : le _smartphone_ avec une tête de _droid_](/assets/img/post/android/as-ic-emulator.png) _AVD Manager_ : elle permet de créer, lancer des émulateurs
  * ![Icône Android Téléchargement : une flèche bleu vers le bas avec une tête de _droid_](/assets/img/post/android/as-ic-download.png) _SDK Manager_ : elle permet de télécharger le dernier _SDK Android_
  ou autres



### {% icon fa-globe %} Références

1. <a name="android"></a>[Site officiel Android](https://developer.android.com/index.html)

*[CPU]: Central Processing Unit
*[AS]: Android Studio
