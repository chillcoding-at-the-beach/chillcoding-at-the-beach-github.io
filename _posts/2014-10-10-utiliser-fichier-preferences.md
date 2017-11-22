---
title: "Utiliser le fichier de Préférences dans une application Android"
categories: fr coding tutoriel android-bdd
author: macha
---

<div class="text-center lead" markdown="1">
  ![Android Base de Données](/assets/img/post/android-bdd.png)
</div>

Le fichier _SharedPreferences_ ou _Preferences_ correspond au fichier de
préférences de l'application. On l'utilise pour sauvegarder des données
persistantes utiles pour le fonctionnement de l'app.

<!--more-->

Par exemple, pour une application destinée à un seul utilisateur, il serait
intéressant d'y stocker le profil de ce dernier (âge, sexe, etc.).

Ce fichier est accessible depuis une **Activity** ou un **Fragment**. D'une part,
il peut être ouvert en écriture, ou édition, afin d'y stocker des données sous
la forme pair(clé,valeur) ou clé est un _string_ permettant de référencer la
valeur et valeur est une donnée primitive telle qu'un _integer_, un _float_,
un _boolean_ ou un _string._ D'autre part, ce fichier peut être ouvert en
lecture afin d'y récupérer les données préalablement enregistrées.

## A] Ouverture en écriture :

Pour éditer le fichier de préférences :

    SharedPreferences sharedPref = getPreferences(Context.MODE_PRIVATE);
    SharedPreferences.Editor editor = sharedPref.edit();
    editor.putInt(PreferencesKeys.CRONO, val);
    editor.commit();

## B] Ouverture en lecture :

Pour récupérer la valeur dans un Fragment :

    SharedPreferences sharedPref = getActivity().getPreferences(Context.MODE_PRIVATE);
    mValue = sharedPref.getInt(PreferencesKeys.CRONO, mValue);
