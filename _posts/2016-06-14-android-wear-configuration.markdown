---
title: "Déployer une app. Android Wear sur une smartwatch"
categories: fr coding tutoriel android wear
author: macha
---

<div class="text-center lead" markdown="1">
  ![Android Montre connectée](/assets/img/post/android-wear.png)
</div>

Pour déployer une app. Android Wear, en cours de développement, sur une montre connectée (ou smartwatch), il faut au préalable :

* installer un environnement de développement Android
* disposer d'une smartwatch Android (ex : Moto 360 de Motorola, LG, Samsung, etc.)
* disposer d'un smartphone Android d'une version supérieur à la 4.4 (Kitkat)

Dans ce tutoriel, accompagné d'une vidéo, nous allons voir comment préparer un environnement de développement pour _Android Wear_. En particulier, il est décrit comment déployer une application spécialement conçue pour la montre connectée.

<iframe width="800" height="450" src="https://www.youtube.com/embed/o4bqwPQbWRA" frameborder="0" allowfullscreen></iframe>

<!--more-->

## Installer une app., provenant du store officiel, sur une smartwatch

Vous venez de recevoir une montre connectée et vous souhaitez la contrôler depuis votre téléphone, sans cela, impossible d'y installer quoi se soit ou même d'y voir l'heure^^. Il vous faut d'abord la connecter à votre téléphone afin de pouvoir commencer à vous amuser. Rien de plus simple, il suffit de pairer, via l'application [Android Wear](https://play.google.com/store/apps/details?id=com.google.android.wearable.app&hl=en), la montre avec le téléphone.

Il s'agit d'installer l'[application officielle Android Wear](https://play.google.com/store/apps/details?id=com.google.android.wearable.app&hl=en), disponible sur _Google Play_. Cette application n'est disponible que pour les smartphones Android de version supérieur à la 4.4, soit Kitkat.

Après avoir téléchargé l'application [Android Wear](https://play.google.com/store/apps/details?id=com.google.android.wearable.app&hl=en), vérifiez que le bluetooth est bien activé sur le téléphone, puis suivez les instructions de pairage depuis _Android Wear_. Sur la montre, en glissant votre doigt de la droite vers la gauche, vous devriez voir apparaître  un numéro de pairage, identique à celui proposé par le téléphone, acceptez le pairage sur ce dernier. La montre se synchronise alors avec le téléphone.

Suite à cette manipulation, allez dans l'application _Android Wear_ depuis votre téléphone, à partir de cette tour de contrôle vous pouvez changer le cadran et télécharger des applications pour votre gadget : boussole, mesure de fréquence cardiaque ([Bachamada](https://play.google.com/store/apps/details?id=fr.machada.bpm&hl=fr)), LeMonde, etc.

Après avoir fait un tour d'horizon des applications existantes, passons aux choses sérieuses en déployant une application _Android_, en cours de développement, sur cet engin quelque peu difficile d'accès. Pour ce faire, il faut :

* lever les barrières : Configurer une session de déboggage Android Wear
* faire passer la voiture : Exécuter une app. Android Wear exemple

## Configurer une session de déboggage  Android Wear

1. Débloquer le smartphone et la smartwatch, pour voir apparaitre le menu _Developer options_ sur chacun :
Appuyer 7 fois sur le numéro de _build_, visible depuis le menu _About_
2. Depuis le menu _Developer options_, autoriser le déboggage :
 * USB debugging pour le smartphone
 * Debug over Bluetooth
 * ADB debugging pour la smartwatch
3. Dans les _Settings_ de l'application _Android Wear_, activer le menu _Debugging over Bluetooth_ et vérifier les status entre la smartwatch et le smartphone :

   ```
    Debugging over Bluetooth
    Host: disconnected
    Target: connected
   ```
4. Ouvrir un pont de connection entre la smartwatch et le smartphone via un terminal à l'aide des commandes :

   ```
    adb forward tcp:4444 localabstract:/adb-hub
    adb connect localhost:4444
   ```
5. La smartwatch vibre et ouvre une pop-up vous demandant d'autoriser le _deboggage over bluetooth_, accepter
6. Vérifier, à nouveau, les status dans les _Settings_ de l'application _Android Wear_, vous devriez voir :

   ```
    Debugging overBluetooth
    Host: connected
    Target: connected
   ```
Note : la commande adb est accessible depuis le script placé dans le dossier `/Users/macha/Library/Android/sdk/platform-tools`, voici quelques commandes supplémentaires :

   ```
    adb connect 127.0.0.1:4444
    adb disconnect localhost:4444
    adb forward --remove tcp:4444
   ```

## Executer une app. Android Wear exemple

1. Ouvrir _Android Studio_
2. Importer un projet exemple _Android Wear_ :
 * _Import an Android code sample_
 * Choisir par exemple –Skeleton Wearable App_
 * Cliquer sur _Next_, puis _Finish_
3. Executer le projet (en cliquant sur la flèche verte)
4. Choisir de lancer l'app sur la smartwatch detectée
5. Après quelques instants, l'app _Skeleton Wearable_ se lance sur la smartwatch

Finalement, nous avons déployé l'application _Skeleton Wearable_ sur une smartwatch. Et il est possible de voir les évènements qui s'y passent en ouvrant l'_Android Device Monitor_ (ADM).

La prochaine étape est de Publier une application Android Wear sur le Play Store.
