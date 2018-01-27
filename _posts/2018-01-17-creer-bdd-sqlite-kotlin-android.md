---
title: "Créer une base de données locale avec Anko SQLite [AK 9]"
categories: fr coding tutoriel android kotlin bdd
author: macha
---

<div class="text-center lead" markdown="1">
  ![Android Kotlin](/assets/img/post/android-kotlin.png)
</div>

Ce tutoriel explique comment créer une base de données (BDD) locale simple, sur
un appareil _Android_, avec le langage _Kotlin_. La bibliothèque _Anko SQLite_ est
utilisée pour manipuler la base de données _SQLite_ mise à disposition par
le _SDK Android_.
L'intérêt de mettre en place une BDD dans votre application est de pouvoir présenter,
à l'utilisateur, des volumes de données (introduit au préalable dans la BDD)
alors qu'il n'a pas de connexion internet.

Notre cas d'étude concerne l'enregistrement de cours sur les technologies mobiles.
Pour le moment, nous commençons par enregistrer seulement le titre du cours ainsi
que sa durée.

<!--more-->

## Implémenter une classe de donnée représentant un cours

1. Il s'agit de créer une nouvelle _data class Kotlin_, nommons la **MobileCourse** :

```kotlin
data class MobileCourse(val title: String, val time: Int)
```

Cette dernière permet de créer des objets de type **MobileCourse** ayant un titre,
"ABC d'android", et une durée en minute, 180, par exemple :

```kotlin
val course1 = MobileCourse("ABC D'Android", 120)
```

L'intérêt d'utiliser une classe de donnée est la génération automatique de fonction
d'affichage tel que _toString()_, de copie d'objet, _copy()_, d'égalité, _equals()_,
etc [\[1\]](#dataclass).

## Définir les tables de la BDD

Dans notre cas, nous avons une seule table de cours.
La table est nommée _MobileCourse_ et possède 3 champs, c'est-à-dire 3 colonnes :

  * un identifiant, _id_
  * un titre, _title_
  * une durée, _time_

Il s'agit de créer un _object Kotlin_, nommons le **MobileCourseTable**,
il permet de stocker dans des variables statiques le nom de la table ainsi que
le nom des colonnes de la table.
Cet _object Kotlin_ est déclaré dans un fichier `Tables.kt`, ce dernier contiendra
tous les objets représentant les tables de la BDD.

1. Voici la déclaration de **MobileCourseTable** dans le fichier `Tables.kt`:

        object MobileCourseTable {
            val NAME = "MobileCourse"
            val ID = "_id"
            val TITLE = "title"
            val TIME = "time"
        }


## Implémenter la classe _DbHelper_

Une classe de type _DbHelper_ est une classe permettant de
gérer la construction et la version de la BDD locale, sur un appareil physique.
Dans le cadre d'un projet _Android_ programmé exceptionnellement en langage _Kotlin_,
nous allons utiliser la classe abstraite <b style='color:#00bfff'>ManagedSQLiteOpenHelper</b>
disponible dans la bibliothèque _Anko SQLite_  [\[2\]](#ankosqlite). Cette classe abstraite
permet de s'affranchir des opérations d'ouverte, d'écriture et de fermeture de la BDD.
Elle utilise la classe <b style='color:green'>SqliteOpenHelper</b> du _SDK Android_.

1. Importez la bibliothèque _Anko SQLite_ :

       implementation "org.jetbrains.anko:anko-sqlite:$anko_version"

2. Créez la classe _DbHelper_ **CourseDbHelper**, elle hérite de <b style='color:#00bfff'>ManagedSQLiteOpenHelper</b> :

        class CourseDbHelper(ctx: Context) : ManagedSQLiteOpenHelper(ctx,
                DB_NAME, null, DB_VERSION) {

        }

3. Créez un `companion object` dans **CourseDbHelper**, il contiendra les variables statiques :

        companion object {
            val DB_NAME = "course.db"
            val DB_VERSION = 1
        }

Note : Ces variables statiques sont utilisées dans le constructeur codé en 2.
Il s'agit de _verrouiller_ le nom de la BDD ainsi que son numéro de version.
Ces attributs sont constants, ils restent les mêmes tout au long de l'exécution
de l'application.

Après avoir renseigné le constructeur de <b style='color:#00bfff'>ManagedSQLiteOpenHelper</b>,
il s'agit à présent d'implémenter ses fonctions membres :

   * <i style='color:#00bfff'>onCreate()</i> : se charge de créer les tables de la BDD
   * <i style='color:#00bfff'>onUpgrade()</i> : se charge de mettre à jour la BDD à la nouvelle version

4. Implémentez la fonction <i style='color:#00bfff'>onCreate()</i> :

        override fun onCreate(db: SQLiteDatabase) {
            db.createTable(MobileCourseTable.NAME, true, MobileCourseTable.ID to INTEGER + PRIMARY_KEY,
                    MobileCourseTable.TITLE to TEXT,
                    MobileCourseTable.TIME to INTEGER
            )
        }

Ici, il s'agit de créer les tables de la BDD, cela via la fonction <i style='color:#00bfff'>createTable()</i> appliquée à l'objet de type
<b style='color:green'>SQLiteDatabase</b>.
Elle attend, à minima, 3 paramètres :

 * le nom de la table
 * un booléen (à `true` car si la table n'existe pas alors la créer)
 * les colonnes de la table, au moins une, une paire avec le nom de la colonne et son type SQL

5. Implémenter la fonction <i style='color:#00bfff'>onUpgrade()</i> :

        override fun onUpgrade(db: SQLiteDatabase, oldVersion: Int, newVersion: Int) {
            db.dropTable(MobileCourseTable.NAME, true)
            onCreate(db)
        }

Pour simplifier la mise à jour de la BDD, nous allons supprimer la table existante
avec la fonction <i style='color:#00bfff'>dropTable()</i> appliquée à l'objet
de type <b style='color:green'>SQLiteDatabase</b>. Elle attend 2 paramètres :

* le nom de la table
* un booléen (à `true` car si la table existe alors la supprimer)

L'idéal serait de récupérer les données de la table pour les insérer dans celle de
la nouvelle version de BDD.

Pour information, voici les importations faites dans **CourseDbHelper** :

```
import android.content.Context
import android.database.sqlite.SQLiteDatabase
import org.jetbrains.anko.db.*
```

## Implémenter la classe de gestion de la BDD

Il s'agit d'implémenter une classe _Db_, plus précisément **CourseDb**, elle
contient les requêtes SQL, faite à partir d'un _DbHelper_, en particulier
**CourseDbHelper** (cf. _RepositoryPattern_).

1. Créez la classe _Db_, **CourseDb**, avec un constructeur prenant en paramètre
un objet de type _DbHelper_ soit **CourseDbHelper** :

       class CourseDb(private val dbHelper: CourseDbHelper) { }

2. Dans la classe **CourseDb**, créez une fonction pour récupérer les cours présent dans la BDD :

        fun requestCourse() = dbHelper.use {
            select(MobileCourseTable.NAME,
                    MobileCourseTable.TITLE, MobileCourseTable.TIME)
                    .parseList(classParser<MobileCourse>())
        }

La fonction _requestCourse()_ utilise la fonction <i style='color:#00bfff'>select()</i>
pour récupérer dans la table `MobileCourseTable.NAME` les colonnes `MobileCourseTable.TITLE` et
`MobileCourseTable.TIME`. Cette dernière renvoie un résultat nécessitant d'être _parsé_ via
<i style='color:#00bfff'>parseList()</i>, cette dernière prend en paramètre un <i style='color:#00bfff'>rowParser</i> construit de cette façon : `classParser<MobileCourse>()`.

Attention, le nom et le type des attributs de la classe **MobileCourse**
doivent correspondre exactement à ce que la requête de la BDD renvoie : un titre
de type champs textuel et une durée de type nombre.

3. Dans la classe **CourseDb**, créez la fonction _saveCourse()_ :

        fun saveCourse(course: MobileCourse) = dbHelper.use {
            insert(MobileCourseTable.NAME,
                    MobileCourseTable.TITLE to course.title,
                    MobileCourseTable.TIME to course.time)
        }

Elle prend en paramètre un objet de type **MobileCourse** et l'insère dans la BDD
via la fonction <i style='color:#00bfff'>insert()</i>.

4. Créez la fonction _saveCourses()_ :

        fun saveCourses(courseList: List<MobileCourse>) {
            for (c in courseList)
                saveCourse(c)
        }

Elle prend en paramètre une liste de **MobileCourse** et insère chaque élément de
la liste dans la BDD via _saveCourse()_.

## Faire les requêtes depuis la classe principale

Depuis une <b style='color:green'>Activity</b> ou un <b style='color:green'>Fragment</b>,
on introduit et lit la BDD dans un _thread_ différent de l'_UIThread_ via  <i style='color:#00bfff'>doAsync</i>. Cela afin de ne pas ralentir l'interface utilisateur.

1. Créez en variable de classe, un objet de type **CourseDb** :

       val courseDb = CourseDb(CourseDbHelper(applicationContext))

2. Créez un cours **MobileCourse** et introduisez le dans la BDD :

        doAsync {
          val course1 = MobileCourse("ABC Android",120)
          courseDb.saveCourse(course1)
        }

3. Lisez ce qu'il y a à présent dans la BDD :

        doAsync {
          val list = courseDb.requestScores()
        }

4. Ajoutez un _callBack_, un appel à la fonction _showList()_, depuis l'<i style='color:#00bfff'>uiThread</i> dans le <i style='color:#00bfff'>doAsync</i> :

        doAsync {
          val list = courseDb.requestScores()
          uiThread {
            showList()
          }
        }

5. Déclarez l'interface <i style='color:#00bfff'>AnkoLogger</i> sur votre
<b style='color:green'>Activity</b> ou <b style='color:green'>Fragment</b> principal,
afin de pouvoir afficher rapidement des messages dans la console _Logcat_
(cf. [Utiliser la bibliothèque Anko dans un projet Android [AK 4]][AK-4]).

6. Créez la fonction _showList()_, elle montre dans la console _Logcat_ le contenu de `list`:

        private fun showList() {
                info("NB COURS : ${list.size}")
                for (c in list)
                    info("Voici un cours ${c.title}")
            }


## Plus loin : optimisation d'allocation mémoire

Il s'agit d'implémenter le _design pattern Singleton_ dans la classe _DbHelper_
ainsi que dans la classe  <b style='color:green'>Application</b> du projet _Android_.

### Implémentez le design pattern singleton dans le _DbHelper_

1. Ajoutez dans le _companion object_ de la classe **CourseDbHelper** la constante suivante :

       val instance by lazy { CourseDbHelper() }

2. Modifiez le constructeur de **CourseDb**, il devient :

       class CourseDb(private val dbHelper: CourseDbHelper = CourseDbHelper.instance) {

### Implémenter une classe Application dans un projet Android

Cette classe est instanciée tout au long de l'exécution de l'application.

 1. Créez la classe **App**, elle hérite de la classe <b style='color:green'>Application</b> :

        class App : Application() {

           companion object {
               lateinit var instance: App
             }

             override fun onCreate() {
               super.onCreate()
               instance = this
           }
        }

 2. Spécifiez la nouvelle classe **App** dans le fichier `Manifest` :

         <application
                 android:name=".App"

3. Modifiez le constructeur de **CourseDbHelper**, il devient :

       class CourseDbHelper(ctx: Context = MyApp.instance)

À présent, il est possible de créez une instance de **CourseDb** de cette façon :

```kotlin
val courseDb = CourseDb()
```

Finalement, cet article présente l'utilisation de la bibliothèque _Anko SQLite_
dans un projet _Android_. Elle permet de manipuler des données structurées et
persistantes avec SQLite (données structurées : relativement volumineuses ; données
persistantes : subsistantes après l’exécution d’une application). Cela dit, comme
dit dans le blog [\[3\]](#ankosqlite), cette bibliothèque n'est pas idéale pour les
performances. En effet, il vaut mieux utiliser l'_ORM Room_[\[7\]](#room) pour un
projet de grande envergure.

### {% icon fa-globe %} Références

1. <a name="dataclass"></a>[Documentation Kotlin : Data classes](https://kotlinlang.org/docs/reference/data-classes.html)
2. <a name="ankosqlite"></a>[Documentation Anko SQLite ](https://github.com/Kotlin/anko/wiki/Anko-SQLite#using-anko-sqlite-in-your-project)
3. <a name="ankosqliteblog"></a>[Blog Anko](https://www.kotlindevelopment.com/anko-sqlite-database/)
4. [Databases on Android with Anko and Kotlin by Antonio Leiva](https://antonioleiva.com/databases-anko-kotlin/)
5. [Using Anko to run background tasks by Antonio Leiva](https://antonioleiva.com/anko-background-kotlin-android/)
6. [Projet Github d'Antonio](https://github.com/antoniolg/Kotlin-for-Android-Developers)
7. <a name="room"></a>[Android: Room](https://developer.android.com/topic/libraries/architecture/room.html)

*[AS]: Android Studio
[AK-4]: https://www.chillcoding.com/blog/2017/10/09/utiliser-anko-kotlin-android/
