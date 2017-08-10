---
title: "Déployer une app. Android Wear sur une smartwatch"
categories: coding android wear fr
author: macha
---

<div class="text-center lead" markdown="1">
  ![Android HTTP Request](/assets/img/post/android-wear.png)
</div>

Pour déployer une app. Android Wear, en cours de développement, sur une montre connectée (ou smartwatch), il faut au préalable :

  * [installer un environnement de développement Android](/blog/2016/08/03/android-demarrage/)
  * disposer d'une smartwatch Android (ex : Moto 360 de Motorola, LG, Samsung, etc.)
  * disposer d'un smartphone Android d'une version supérieur à la 4.4 (Kitkat)
Dans ce tutoriel, accompagné d'un screencast, nous allons voir comment préparer un environnement de développement pour Android Wear, soit comment déployer une app. spécialement conçue pour la montre connectée.

<iframe width="560" height="315" src="https://www.youtube.com/embed/o4bqwPQbWRA" frameborder="0" allowfullscreen></iframe>

## A] Installer une app., provenant du store officiel, sur une smartwatch

Vous venez de recevoir une montre connectée et vous souhaitez la contrôler depuis votre téléphone, sans cela, impossible d'y installer quoi se soit ou même d'y voir l'heure^^. Il vous faut d'abord la connecter avec votre téléphone afin de pouvoir commencer à vous amuser. Rien de plus simple, il suffit de pairer, via l'app. _Android Wear_, la montre avec le téléphone. Il s'agit d'installer l'app. officielle _[Android Wear](https://play.google.com/store/apps/details?id=com.google.android.wearable.app&hl=en),_ disponible sur _Google play _. Cette app. n'est disponible que pour les smartphones Android de version supérieur à la 4.4, soit Kitkat. Après avoir téléchargé cette app., vérifiez que le bluetooth est bien activé sur le téléphone, puis suivez les instructions de pairage depuis _Android Wear_. Sur la montre, en glissant votre doigt de la droite vers la gauche, vous devriez voir apparaître  un numéro de pairage, identique à celui proposé par le téléphone, acceptez le pairage sur ce dernier. La montre se synchronise alors avec le téléphone. Suite à cette manipulation, allez dans l'app _Android Wear_ depuis votre téléphone, à partir de cette tour de contrôle vous pouvez changer le cadran et télécharger des app. pour votre gadget : boussole, mesure de fréquence cardiaque ([app. Bachamada](https://play.google.com/store/apps/details?id=fr.machada.bpm)), LeMonde, etc. Après avoir fait un tour d'horizon des app. existantes, passons aux choses sérieuses en déployant une app., en cours de développement, sur cet engin quelque peu difficile d'accès. Pour ce faire, il faut :

  * lever les barrières, soit B] Configurer une session de déboggage Android Wear
  * faire passer la voiture, soit C] Executer une app. Android Wear exemple

## B] Configurer une session de déboggage  Android Wear

  1. Débloquer le smartphone et la smartwatch, pour voir apparaitre le menu Developer options sur chacun :
    1. Appuyer 7 fois sur le numéro de build, visible depuis le menu About 
  2. Depuis le menu Developer options autoriser le déboggage :
    1. > USB debugging pour le smartphone
    2. > Debug over Bluetooth et > ADB debugging pour la smartwatch
  3. Dans les Settings de l'app. Android Wear, activer le menu > Debugging over Bluetooth et vérifier les status entre la smartwatch et le smartphone :

        Debugging over Bluetooth
    Host: disconnected
    Target: connected

  4. Ouvrir un pont de connection entre la smartwatch et le smartphone dans un terminal à l'aide des commandes :

        adb forward tcp:4444 localabstract:/adb-hub
    adb connect localhost:4444

  5. La smartwatch vibre et ouvre une pop-up vous demandant d'autoriser le deboggage over bluetooth, accepter
  6. Vérifier, à nouveau, les status dans les Settings de l'app. __Android Wear__, vous devriez voir :__ __

        Debugging overBluetooth
    Host: connected
    Target: connected

Note : la commande **adb** est accessible depuis le script placé dans le dossier _/Users/macha/Library/_Android/sdk/platform-tools Remarque : Voici quelques commandes supplémentaires :


    adb connect 127.0.0.1:4444
    adb disconnect localhost:4444
    adb forward --remove tcp:4444

## C] Executer une app. Android Wear exemple

  1.  Ouvrir Android Studio
  2. Importer un projet exemple Android Wear :
    1. Import an Android code sample
    2. Choisir par exemple _Skeleton Wearable App_
    3. Cliquer sur _Next_, puis _Finish_
  3. Executer le projet (en cliquant sur la flèche verte)
  4. Choisir de lancer l'app sur la smartwatch detectée
  5. Après quelques instants, l'app _Skeleton Wearable _se lance sur la smartwatch
Finalement, nous avons déployé l'app. _Skeleton Wearable_ sur une smartwatch. Et il est possible de voir les évènements qui s'y passent en ouvrant l'_Android Device Monitor (ADM)._ La prochaine étape est de [Publier une application Android Wear sur le Play Store](/blog/2015/10/14/publier-app-android-wear-playstore/).
