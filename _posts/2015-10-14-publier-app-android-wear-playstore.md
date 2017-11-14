---
title: "Publier une app. Android Wear sur le Play Store"
categories: fr coding tutoriel android publication
author: macha
---

<div class="text-center lead" markdown="1">
  ![Android Montre connectée](/assets/img/post/android-wear.png)
</div>

Vous avez développé une app. pour la montre connectée Google et il ne vous reste
plus qu'à la publier. Attention, cela peut prendre plusieurs heures ! En
comparaison avec les app. pour smartphone, les app. pour smartwatch passent une
batterie de tests plus complexe avant d'être acceptées et disponibles sur le
Play Store.

<!--more-->

## Comment soumettre une app. Android Wear avec succès ?

Depuis la [console de développeur Android](https://play.google.com/apps/publish/) (ou Google Play Developer Console), il vous est recommandé le lien [Wear App Quality](https://developer.android.com/distribute/essentials/quality/wear.html) pour vérifier que votre app. est bien conforme aux règles de design, il y aussi le lien [Distribute to Android Wear](https://developer.android.com/distribute/googleplay/wear.html) pour comprendre le processus de publication et surtout il y a le lien technique sur [Packaging Wearable Apps](https://developer.android.com/training/wearables/apps/packaging.html). De plus, le mail d'android-wear-review@google.com de refus communique 2 liens supplémentaires, un sur les notifications [Adding Wearable Feature to Notifications](https://developer.android.com/training/wearables/notifications/index.html) et un sur la fiche Google Play [Graphic assets, screenshots, & video](https://support.google.com/googleplay/android-developer/answer/1078870?hl=en).

Dans la suite de cet article, il est présenté de manière exhaustive tous les points à vérifier pour éviter ce mail automatique de refus :


    Hi Developers at YourCompanyName,

    Thanks for submitting your app for Android Wear. This is a notification that your app, NameOfYourApp, with package name tatati.tintin.toto, has not been accepted as an Android Wear app on Google Play.

    Version Name: 2.0
    Version code: 12
    Production track: PRODUCTION

    REASON(S) FOR EXCLUSION:


    -Your app does not include at least one Android Wear screenshot in its Play Store Listing.

    Screenshots help explain your app’s functionality on the wearable. Wear screenshots can be added in the Google Play Developer Console, under Store Listing > Graphic Assets.

    Please refer to the following developer page for details:
    https://support.google.com/googleplay/android-developer/answer/1078870?hl=en
    ---------------
    -Your app does not have Android Wear functionality that’s visible to the user.

    If you’re adding wearable features to notifications, make sure that they are triggering when appropriate.

    If you’re building a wearable app, there may have been issues packaging it. Be sure to:
    - Include all the permissions declared in the manifest file of the wearable app in the manifest file of the mobile app. For example, if you specify the VIBRATE permission for the wearable app, you must also add that permission to the mobile app.
    - Ensure that both the wearable and mobile APKs have the same package name and version number.
    - Sign your app.
    - Test your app on a variety of different Android Wear devices and configurations.

    Please refer to the following developer pages for details:

    For packaging your app:
    https://developer.android.com/training/wearables/apps/packaging.html

    For creating apps that run directly on the wearable:
    https://developer.android.com/training/wearables/apps/index.html

    For adding wearable features to notifications:
    https://developer.android.com/training/wearables/notifications/index.html
    ---------------
    Please refer to the following developer pages for details: Wear App Quality - Developer Guidelines

    If your developer account is still in good standing, you may revise and upload an Android Wear compliant version of this application to be reviewed again.

    If you feel we have made this determination in error, please reply to this email for additional information.

    Regards,
    The Google Play Team

## A] Respecter les règles de Design Android Wear

  1. L'app. doit comporter au moins un écran visible sur la smartwatch.
  2. Les notifications ne doivent pas être envahissante et être déclenchées que lorsqu'elles sont nécessaires.

## B] Bien former un projet Android Wear et obtenir un APK valide pour le Play Store

Un projet Android Wear doit avoir au moins 2 modules, un pour l'app. smartwatch, nommé par exemple wearable/, et un autre pour l'app smartphone, nommé par exemple mobile/. Afin de générer un fichier APK signé acceptable par le Play Store vous devez vérifier les points suivants :

  1. Concernant les fichiers Manifest : le fichier Manifest du module mobile/ doit comporter les permissions de son module ainsi que les permissions du module wearable/ Par exemple : Fichier Manifest du module wearable/

    Fichier Manifest du module mobile/

      2. Le nom de package doit être identique dans les deux modules, mobile/ et wearable/

      3. Concernant les fichiers gradle :

            1. les fichiers gradle liés au module wearable/ et au module mobile/ doivent avoir des **versionCode** identiques et **versionsName** identiques

            2. le fichier gradle lié au module mobile/ doit inclure le module wearable/ dans les dépendances :

                dependencies {
           compile 'com.android.support:support-v4:20.0.+''
           wearApp project(':wearable')
        }

  4. Il ne reste plus qu'à générer le fichier APK signé via _Android Studio_ : Build > Generate Signed APK... avec votre Key Store, Key Alias et Password; puis l'importer dans la [console de développeur Android](https://play.google.com/apps/publish/).

## C] Préparer la fiche Play Store dans Google Play Developer Console

  1. Aller dans la [console de développeur Android](https://play.google.com/apps/publish/), en vous connectant avec votre compte Google dédié.
  2. Choisir une app. existante ou ajouter une nouvelle app.
  3. Préparer ou vérifier la Fiche Google Play Store.
    1. choisir au moins 2 impressions écrans pour le Téléphone, dans l'onglet Téléphone.
    2. choisir au moins 2 impressions écrans pour la Smartwatch, dans l'onglet Android Wear.
    3. compléter les descriptions de l'app.
  4. Ajouter votre fichier APK dans Fichiers APK (il doit vérifier tous les points A et B).
  5. Dans la partie Tarifs et disponibilité, cochez Distribuez votre application sur Android Wear. dans Catégories d'appareil > Android Wear
