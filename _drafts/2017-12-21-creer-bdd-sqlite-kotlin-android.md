---
title: "Créer une base de données locale avec Anko SQLite [AK 9]"
categories: fr coding tutoriel android kotlin
author: macha
---

<div class="text-center lead" markdown="1">
  ![Android Kotlin](/assets/img/post/android-kotlin.png)
</div>

Ce tutoriel explique comment créer une base de données locale simple, sur
un appareil Android, avec le langage _Kotlin_. La bibliothèque _Anko SQLite_ est
utilisé pour manipuler la base de données _SQLite_ mise à disposition par
le _SDK Android_.

Notre cas d'étude concerne l'enregistrement des scores pour un jeu. Pour le moment,
nous commençons par enregistrer seulement le pseudonyme de l'utilisateur avec son score.

## Définir les tables

Dans notre cas, nous avons une seule table de scores. Il s'agit de créer un objet `ScoreTable`
la représentant :

```
object ScoreTable {
    val NAME = "Score"
    val ID = "_id"
    val PSEUDO = "pseudo"
    val SCORE = "score"
}
```
La table est nommé _Score_ et possède 3 champs, c'est-à-dire 3 colonnes :
 * un identifiant, _id_
 * un pseudo, _pseudo_
 * un total, _score_

### Implémenter une classe représentant les données

```
class Score(val pseudo:String, val score:Int)
```
Attention le nom et le type des attributs, de cette classe, doivent correspondre
exactement à ce que la requette de la BDD renvoie (cf. fonction `requestScores`
dans `ScoreDb`)

### Implémenter une classe Application pour un projet Android

 Cette classe est instanciée tout au long de l'exécution de l'application.

 avec MyApp la classe Application :
 ```
 class MyApp : Application() {

     companion object {
         lateinit var instance: MyApp
       }

       override fun onCreate() {
         super.onCreate()
         instance = this
     }

 }
 ```
 spécifier dans le fichier Manifest:
 ```
 <application
         android:name=".MyApp"
 ```

### Implémenter la classe _SqliteOpenHelper_

Une classe de type  _SqliteOpenHelper_ est une classe permettant de gérer la
construction de la base de données locale.


1. Importez la bibliothèque _Anko SQLite_
```
    compile "org.jetbrains.anko:anko-sqlite:$anko_version"
```
Créez la classe _Kotlin_ `ScoreDbHelper`, hérite de <i style='color:#00bfff'>ManagedSQLiteOpenHelper</i> :
```
class ScoreDbHelper(ctx: Context = MyApp.instance) : ManagedSQLiteOpenHelper(ctx,
        ScoreDbHelper.DB_NAME, null, ScoreDbHelper.DB_VERSION) {
          ...
}
```
```
    companion object {
        val DB_NAME = "forecast.db"
        val DB_VERSION = 1
        val instance by lazy { ScoreDbHelper() }
    }
```
```
    override fun onCreate(db: SQLiteDatabase) {
        db.createTable(ScoreTable.NAME, true, ScoreTable.ID to INTEGER + PRIMARY_KEY,
                ScoreTable.PSEUDO to TEXT,
                ScoreTable.SCORE to INTEGER
        )
    }
```
```
    override fun onUpgrade(db: SQLiteDatabase, oldVersion: Int, newVersion: Int) {
        db.dropTable(ScoreTable.NAME, true)
        onCreate(db)
    }
```

avec les imports:
```
import android.content.Context
import android.database.sqlite.SQLiteDatabase
import org.jetbrains.anko.db.*
```



### Implémenter la classe de gestion de la BDD

Cette classe implémente les requêtes SQL.
cf. RepositoryPattern

```
class ScoreDb(private val scoreDbHelper: ScoreDbHelper = ScoreDbHelper.instance) {
```
```

    fun requestScores() = scoreDbHelper.use {
        select(ScoreTable.NAME,
                ScoreTable.PSEUDO, ScoreTable.SCORE)
                .parseList(classParser<Score>())
    }
```
```
    private fun saveScore(pseudo: String, score: Int) = scoreDbHelper.use {
        insert(ScoreTable.NAME,
                ScoreTable.PSEUDO to pseudo,
                ScoreTable.SCORE to score)
    }
```
```
    fun saveScores(scoreList: List<Score>) {
        for (s in scoreList)
            saveScore(s.pseudo, s.score)
    }
}
```

### Faire les requêtes depuis l'interface utilisateur
```
val scoreDb = ScoreDb()

```
```
doAsync {
                            scoreDb.saveScores(allScore)
                        }
```
```
doAsync {
             val allScore = scoreDb.requestScores()
          }
```

### <i class="fa fa-globe" aria-hiden="true"></i> Références :

1. <a name="android"></a>[Documentation Anko ](https://github.com/Kotlin/anko/wiki/Anko-SQLite#using-anko-sqlite-in-your-project)
2. <a name="ankologger"></a>[Blog Anko](https://www.kotlindevelopment.com/anko-sqlite-database/)
3. [Databases on Android with Anko and Kotlin by Antonio Leiva](https://antonioleiva.com/databases-anko-kotlin/)
4. [Projet Github d'Antonio](https://github.com/antoniolg/Kotlin-for-Android-Developers)

*[AS]: Android Studio
[AK-2]: https://www.chillcoding.com/blog/2017/09/28/configurer-kotlin-projet-android/
[AK-3]: https://www.chillcoding.com/blog/2017/10/03/ajouter-extensions-kotlin/
