---
title: "Configurer un projet Android pour utiliser Retrofit"
categories: fr coding tutoriel android serveur
author: macha
---

<div class="text-center lead" markdown="1">
  ![Android Requête HTTP](/assets/img/post/android-request.png)
</div>

Ce tutoriel explique comment configurer un projet Android pour utiliser la
librairie [**Retrofit 2.0**](http://square.github.io/retrofit/). Une brève étude
sur les librairies Android permettant de faire des requêtes HTTP (cf.
[question "What is the best library to make HTTP calls from Java/Android" sur Quora](https://www.quora.com/What-is-the-best-library-to-make-HTTP-calls-from-Java-Android))
m'a orienté vers la librairie [**Retrofit**](http://square.github.io/retrofit/)
pour le transfert de données textuelles (hors chargement d'image).

<!--more-->

## Importer les librairies nécessaires dans Android Studio

Il s'agit d'importer la librairie [**Retrofit**](http://square.github.io/retrofit/) développée par [_Square_](http://square.github.io). De plus, depuis la version 2 de **Retrofit**, il faut également importer un convertisseur de requête pour le format utilisé, JSON dans notre cas.

  1. Dans le fichier gradle de votre projet _Android Studio_, celui lié au module _app/_,  importer la librairie [**Retrofit**](http://square.github.io/retrofit/) :

        dependencies {
    compile 'com.squareup.retrofit:retrofit:2.0.0-beta2'
    }

  2. Importer également un convertisseur JSON, soit la librairie _converter-gson_ :

        compile 'com.squareup.retrofit:converter-gson:2.0.0-beta2'

Il existe d'autres convertisseurs, voici la liste proposé par [_Square_](http://square.github.io) :

  * [Gson](https://github.com/google/gson): `com.squareup.retrofit:converter-gson` (JSON)
  * [Jackson](http://wiki.fasterxml.com/JacksonHome): `com.squareup.retrofit:converter-jackson` (JSON)
  * [Moshi](https://github.com/square/moshi/): `com.squareup.retrofit:converter-mosh` (JSON)
  * [Protobuf](https://developers.google.com/protocol-buffers/): `com.squareup.retrofit:converter-protobuf` ([Protocol Buffer](https://developers.google.com/protocol-buffers/) binary)
  * [Wire](https://github.com/square/wire): `com.squareup.retrofit:converter-wire` ([Wire](https://github.com/square/wire) pour protocol buffer-compatible)
  * [Simple XML](http://simple.sourceforge.net/): `com.squareup.retrofit:converter-simplexml` (XML)
 
## Ajouter les permissions de se connecter à Internet

Afin de pouvoir executer des requêtes HTTP sur un serveur distant, il faut également ajouter, à l'application Android, les permissions de se connecter à Internet.

  1. Dans le fichier Manifest de votre projet _Android Studio_, ajouter :


    <uses-permission android:name="android.permission.INTERNET" />

  Finalement, dans ce tutoriel, il est expliqué comment importer les librairies de **[Retrofit](http://square.github.io/retrofit/)**, pour le transfert HTTP, avec le format JSON, dans un projet Android. Ceci peut facilement être transposé pour l'import d'autres librairies. De plus, à présent vous pouvez réaliser des requêtes[ HTTP GET](requete-http-get-retrofit-android/) et [HTTP POST](http://www.machada.fr/requete-http-post-retrofit-android/), avec **[Retrofit](http://square.github.io/retrofit/)** dans une application Android.
