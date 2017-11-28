---
title: "Configurer un projet Android pour utiliser Retrofit"
categories: fr coding tutoriel android-serveur
author: macha
---

<div class="text-center lead" markdown="1">
  ![Android Requête HTTP](/assets/img/post/android-request.png)
</div>

Ce tutoriel explique comment configurer un projet Android pour utiliser la
bibliothèque [**Retrofit 2.0**][Retrofit]. Une brève étude
sur les dépendances Android permettant de faire des requêtes HTTP (cf.
[question "What is the best library to make HTTP calls from Java/Android" sur Quora][Quora])
m'a orienté vers les travaux de Jake Wharton, pour le transfert de données textuelles (hors chargement d'image).


## Importer les bibliothèques nécessaires dans Android Studio


Il s'agit d'importer [**Retrofit**][Retrofit] développée par [_Square_][Square]. De plus, depuis la version 2 de **Retrofit**, il faut également importer un convertisseur de requête pour le format utilisé, JSON dans notre cas.

  1. Dans le fichier gradle de votre projet _Android Studio_, celui lié au module _app/_,  importer la dépendances [**Retrofit**][Retrofit] :

          dependencies {
            ...
            compile "com.squareup.retrofit2:retrofit:$retrofit_version"
          }
  avec, au 22 novembre 20017 : (prenez la dernière version figurant dans la partie gradle du site )
          ext.retrofit_version = '2.3.0'

  2. Importer également un convertisseur JSON, soit la bibliothèque _converter-moshi_ (prenez la dernière version indiqué sur le [site github][Moshi]):
          compile "com.squareup.retrofit2:converter-moshi:$retrofit_version"


Il existe d'autres convertisseurs, voici la liste proposé par [_Square_][Square] :

  * [Gson](https://github.com/google/gson): `com.squareup.retrofit:converter-gson` (JSON)
  * [Jackson](http://wiki.fasterxml.com/JacksonHome): `com.squareup.retrofit:converter-jackson` (JSON)
  * [Moshi](https://github.com/square/moshi/): `com.squareup.retrofit:converter-mosh` (JSON)
  * [Protobuf](https://developers.google.com/protocol-buffers/): `com.squareup.retrofit:converter-protobuf` ([Protocol Buffer](https://developers.google.com/protocol-buffers/) binary)
  * [Wire](https://github.com/square/wire): `com.squareup.retrofit:converter-wire` ([Wire](https://github.com/square/wire) pour protocol buffer-compatible)
  * [Simple XML](http://simple.sourceforge.net/): `com.squareup.retrofit:converter-simplexml` (XML)
 
## Ajouter les permissions de se connecter à Internet

Afin de pouvoir exécuter des requêtes HTTP sur un serveur distant, il faut également ajouter, à l'application Android, les permissions de se connecter à Internet.

  1. Dans le fichier Manifest de votre projet _Android Studio_, ajouter
  la permission internet :


    <uses-permission android:name="android.permission.INTERNET" />

Note : Les permissions sont placées dans la balise `manifest` et hors de la balise `application` (juste avant la balise application).

Finalement, dans ce tutoriel, il est expliqué comment importer les bibliothèques de **[Retrofit 2][Retrofit]**, pour le transfert HTTP, avec le format JSON et le convertisseur [Moshi][Moshi] dans un projet Android.

À présent vous pouvez réaliser des requêtes[ HTTP GET](requete-http-get-retrofit-android/) et [HTTP POST](http://www.machada.fr/requete-http-post-retrofit-android/), avec **[Retrofit 2][Retrofit]** dans une application Android.

### <i class="fa fa-globe" aria-hiden="true"></i> Références :

[Retrofit]: http://square.github.io/retrofit/
[Square]: http://square.github.io
[Quora]: https://www.quora.com/What-is-the-best-library-to-make-HTTP-calls-from-Java-Android
[Moshi]: https://github.com/square/moshi
[Get]: https://www.chillcoding.com/blog/2017/03/14/requete-http-get-retrofit-android/
[Post]: https://www.chillcoding.com/blog/2015/11/16/requete-http-post-retrofit-android/
