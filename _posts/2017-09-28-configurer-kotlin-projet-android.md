---
title: "Configurer Kotlin dans un projet Android Studio"
categories: coding android fr
author: macha
---

<div class="text-center lead" markdown="1">
  ![Android HTTP Request](/assets/img/post/android-config.png)
</div>

Ce tutoriel détaille comment configurer _Kotlin_ dans un projet  fraichement créé sous _Android Studio_.

## Pré-requis : Télécharger le plugin Kotlin
1. Allez dans la partie `Plugins` d'_Android Studio_
  * Accédez au menu `Recherche` du logiciel
  * Tapez plugin puis sélectionnez `Plugins`, situé en bas dans la partie `Actions`
2. Recherchez le plugin _Kotlin_, éventuellement, cliquez sur `Search in repositories`
3. Vous devriez voir le plugin `Kotlin, Kotlin language support` de _JetBrains_, cliquez sur `Install`
4. Redémarrez AS

## Configurer Kotlin dans votre projet
1. Allez dans la partie `Tools`, situé dans la barre du menu textuel d'entête
2. Puis dans `Kotlin`, sélectionnez `Configure Kotlin in project`
3. Choisissez `Android with Gradle` dans la fenêtre `Choose Configurator`
4. Laissez la sélection sur `All modules` depuis la fenêtre `Configure Kotlin with Android with Gradle`, puis cliquez sur `Ok`
5. Cliquez sur `Sync` depuis la fenêtre jaune relative au fichier _gradle_. Chaque changement apporté dans ces fichiers nécessite une synchronisation du projet
4. Remarquez les lignes ajoutées dans les fichiers _gradle_
 * dans le fichier _gradle_ du module `build.gradle (Module: app)`
```
apply plugin: 'kotlin-android'
...
dependencies {
...
compile "org.jetbrains.kotlin:kotlin-stdlib-jre7:$kotlin_version"
...
}
```
 * dans le fichier _gradle_ du projet `build.gradle (Project: MyProject)`
 ```
 ext.kotlin_version = '1.1.4'
 ...
 classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
```
Remarque : Une bonne pratique est d'utiliser une variable comme `ext.kotlin_version` contenant le numéro de version à utiliser pour la dépendance  utilisée, ici : `org.jetbrains.kotlin:kotlin-stdlib-jre7`.

Exercice : Ajoutez une variable `ext.support_version` pour les dépendances provenant de `com.android.support`

##  Transformer la classe principale en code Kotlin

1. Placez vous dans la classe principale de votre projet, écrite par défaut en _Java_, usuellement nommé `MainActivity`
2. Sélectionnez `Convert Java File to Kotlin File` depuis la partie `Code`, situé dans la barre du menu textuel d'entête (notez le raccourci clavier proposé)
3. Remarquez la conversion automatique effectuée, elle n'est pas toujours parfaite selon le modèle de projet choisi

À présent, il est temps de programmer un projet exceptionnellement en _Kotlin_ !

*[AS]: Android Studio
