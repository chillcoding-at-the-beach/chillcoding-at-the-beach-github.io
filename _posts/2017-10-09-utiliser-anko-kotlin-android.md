---
title: "Utiliser la bibliothèque Anko dans un projet Android [AK 4]"
categories: coding android fr
author: macha
---

<div class="text-center lead" markdown="1">
  ![Android Kotlin](/assets/img/post/android-kotlin.png)
</div>

Ce tutoriel explique comment ajouter la bibliothèque _Anko_, plus précisément
_Anko Commons_, dans un projet _Android Studio_, d'ores et déjà configuré avec
_Kotlin_ (cf. [Configurer _Kotlin_ dans un projet _Android Studio_ [AK 2]][AK-2]).
En outre, il est possible d'ajouter les extensions _Kotlin_ afin d'accéder facilement
aux éléments des vues _XML_ (cf. [AK-3]).

De plus, ce tutoriel introduit quelques fonctionnalités astucieuses disponibles
dans la bibliothèque _Anko Commons_, telles que :

  * [Afficher un message d'erreur](#log)
  * [Afficher un message rapide](#toast)
  * [Ouvrir une boîte de dialogue](#alert)
  * [Lancer un autre écran](#start)
  * [Lancer une page Internet](#browse)
  * [Proposer d'envoyer un email](#email)
  * [Proposer de partager du contenu](#share)

La bibliothèque _Anko_, écrite en _Kotlin_, contient en fait 4 sous bibliothèques [\[1\]](#github) :

 * _Anko Commons_ : contient des outils pour les développements _Android_ récurrents
 (<i style='color:green'>Intents</i>, <i style='color:green'>Dialogs</i>, <i style='color:green'>Log</i>, etc.)
 * _Anko Layouts_ : pour coder des vues dynamiquement
 * _Anko SQLite_ : pour travailler avec _Android SQLite_
 * _Anko Coroutines_: basée sur la bibliothèque _kotlinx.coroutines_

_Anko Commons_ est la bibliothèque incontournable pour le développement d'application
mobile _Android_ avec le langage _Kotlin_ !

## Importer la bibliothèque Anko Commons

1. Placez vous dans dans le fichier _gradle_ du projet `build.gradle (Project: MyProject)`
2. Ajoutez une variable contenant la version d'_Anko Commons_ à utiliser :

        ext.anko_version = '0.10.0'

3. Placez vous dans dans le fichier _gradle_ du module `build.gradle (Module: app)`
4. Ajoutez la dépendance _Anko Commons_ dans le bloc approprié `dependencies` :

        dependencies {
          ...
          compile "org.jetbrains.anko:anko-common:$anko_version"
        }

À présent, nous allons voir les principales facilitées de développement _Android_
apportées par cette bibliothèque.

## Afficher un message d'erreur <a name="log"></a>

Afin d'afficher des messages dans la console du développeur, soit dans la console
_Android Monitor_, le _SDK Android_ fournit la classe <i style='color:green'>Log</i>
(cf. [documentation officiel](https://developer.android.com/reference/android/util/Log.html)).
Son utilisation est quelque peu fastidieuse. En effet, les méthodes à utiliser
(<i style='color:green'>Log.i()</i>, <i style='color:green'>Log.e()</i>, etc.) prennent 2 paramètres :

* un _TAG_, une chaine de caractères comprenant le nom de la classe courante
* le message à afficher dans la console

En revanche, avec l'interface <i style='color:#00bfff'>AnkoLogger</i>, dont l'import
correspond à `import org.jetbrains.anko.AnkoLogger`, seul un paramètre est nécessaire [\[2\]](#ankologger).

Voici un exemple d'utilisation depuis une <i style='color:green'>Activity</i> :

1. Déclarez l'interface <i style='color:#00bfff'>AnkoLogger</i> :

        class MyActivity : Activity(), AnkoLogger {
            ...
        }

2. Affichez un message d'information :

        info("Kotlin is an island")

Avec le _SDK Android_, cela revient à utiliser la classe <i style='color:green'>Log</i>
dont l'import correspond à `import android.util.Log` :

```kotlin
 Log.i(MyActivity::class.java.simpleName, "Kotlin is an island")
```

##  Afficher un message rapide <a name="toast"></a>

Afin de présenter des messages d'information rapide à l'utilisateur, le _SDK Android_
fournit la classe <i style='color:green'>Toast</i> (cf. [documentation officiel](https://developer.android.com/guide/topics/ui/notifiers/toasts.html)).
Elle permet de créer un message avec <i style='color:green'>makeText()</i>,
cette dernière prend 3 paramètres :

* le contexte de l'application (`this` depuis une <i style='color:green'>Activity</i>,
`activity` depuis un <i style='color:green'>Fragment</i>)
* le message
* la durée d'affichage long ou court

Enfin, il s'agit d'afficher le message ainsi créé via la fonction <i style='color:green'>show()</i>
(l'appel indispensable à ne pas oublier lorsqu'on code à la plage ;).

La bibliothèque _Anko Commons_ simplifie cette tâche grâce à la fonction
<i style='color:#00bfff'>toast()</i>, dont l'import correspond à `import org.jetbrains.anko.toast`.
Elle peut être appelée de manière indifférente depuis une <i style='color:green'>Activity</i>
ou un <i style='color:green'>Fragment</i>, avec un seul paramètre (le texte à afficher).

1. Appelez la fonction <i style='color:#00bfff'>toast()</i> :

        toast(R.string.text_island)

2. Alternativement, pour afficher le message plus longtemps, il est possible
d'appeler la fonction <i style='color:#00bfff'>longToast()</i>, dont l'import
correspond à `import org.jetbrains.anko.longToast` :

        longToast(R.string.text_island)

Avec le _SDK Android_, cela revient à utiliser la classe <i style='color:green'>Toast</i>,
dont l'import correspond à `import android.widget.Toast`, depuis une <i style='color:green'>Activity</i> :

```
Toast.makeText(this, "${getString(R.string.text_island)}", Toast.LENGTH_SHORT).show()
```
ou bien :

```kotlin
Toast.makeText(this, "${getString(R.string.text_island)}", Toast.LENGTH_LONG).show()
```

##  Ouvrir une boite de dialogue <a name="alert"></a>

1. Appelez la fonction <i style='color:#00bfff'>alert()</i>, dont l'import
correspond à `import org.jetbrains.anko.alert`, cela dans son plus simple appareil :

        alert("YO").show()

2. Appelez la fonction <i style='color:#00bfff'>alert()</i>, avec les boutons classiques 'oui', 'non' :

        alert("YO") {
          yesButton { toast("Yep") }
          noButton { }
        }.show()

3. Appelez la fonction <i style='color:#00bfff'>alert()</i>, en offrant
une boîte de dialogue un peu plus évoluée :

        alert("YO") {
          title = "Awesome quote"
          positiveButton("Love") { toast("Yo") }
          negativeButton("Not at all") { }
          neutralButton("May be")
        }.show()

Avec le _SDK Android_, cela revient à utiliser la classe <i style='color:green'>AlertDialog</i>,
dont l'import correspond à `import android.app.AlertDialog`, depuis une <i style='color:green'>Activity</i> :

```kotlin
val bld = AlertDialog.Builder(this)
bld.setMessage(s)
bld.setNeutralButton("May be", null)
bld.create().show()
```

## Lancer un autre écran <a name="start"></a>

Afin d'empiler un second écran dans la pile d'écrans, le _SDK Android_ fournit
la classe <i style='color:green'>Intent</i> (cf. [documentation officiel](https://developer.android.com/training/basics/firstapp/starting-activity.html)),
représentant une intention, à combiner avec <i style='color:green'>startActivity()</i>.

La bibliothèque _Anko Commons_ propose la fonction avec un type réifié
<i style='color:#00bfff'>startActivity<>()</i>, dont l'import correspond à
`import org.jetbrains.anko.startActivity`. Elle permet de se passer de l'<i style='color:green'>Intent</i>.

1. Appelez la fonction <i style='color:#00bfff'>startActivity<>()</i>, depuis une
<i style='color:green'>Activity</i> :

        startActivity<MySecondaryActivity>()

2. Alternativement, il est possible d'ajouter des données à communiquer à la seconde
<i style='color:green'>Activity</i>, en passant des paramètres à la fonction <i style='color:#00bfff'>startActivity<>()</i> :

        startActivity<MySecondaryActivity>("id" to 3, "name" to "Macha")

Avec le _SDK Android_, cela revient à utiliser la classe <i style='color:green'>Intent</i>,
dont l'import correspond à `import android.content.Intent`, depuis une <i style='color:green'>Activity</i> :

```kotlin
val intent = Intent(this, MySecondaryActivity::class.java)
intent.putExtra("id", 3)
intent.putExtra("name", "Macha")
startActivity(intent)
```

## Ouvrir une page Internet <a name="browse"></a>

Afin d'ouvrir une page Internet avec le navigateur natif, il s'agit d'utiliser
une intention fournit par le _SDK Android_, tout comme le lancement d'un second écran.

La bibliothèque _Anko Commons_ propose la fonction <i style='color:#00bfff'>browse()</i>,
dont l'import correspond à `import org.jetbrains.anko.browse`.

1. Appelez la fonction <i style='color:#00bfff'>browse()</i> :

        browse("https://www.chillcoding.com/")

Avec le _SDK Android_, cela revient à utiliser la classe <i style='color:green'>Intent</i>,
comme suit, depuis une <i style='color:green'>Activity</i> :

```kotlin
val url = "https://www.chillcoding.com/"
val intent = Intent(Intent.ACTION_VIEW)
intent.data = Uri.parse(url)
startActivity(i)
```

## Proposer d'envoyer un email <a name="email"></a>

Afin  de proposer d'envoyer un email, à l'utilisateur, avec une application native,
le _SDK Android_ fournit la classe <i style='color:green'>Intent</i> avec un paramétrage spécifique.

La bibliothèque _Anko Commons_ propose la fonction <i style='color:#00bfff'>email()</i>,
dont l'import correspond à `import org.jetbrains.anko.email`.

1. Appelez la fonction <i style='color:#00bfff'>email()</i> :

        email("hello@chillcoding.com", getString(R.string.subject_feedback), "")

Avec le _SDK Android_, cela revient à utiliser la classe <i style='color:green'>Intent</i>,
instanciée de la façon suivante :

```kotlin
val intent = new Intent(Intent.ACTION_SENDTO);
intent.type = "text/plain"
intent.putExtra(Intent.EXTRA_EMAIL, "hello@chillcoding.com")
intent.putExtra(Intent.EXTRA_SUBJECT, getString(R.string.subject_feedback))
intent.putExtra(Intent.EXTRA_TEXT, "")

startActivity(Intent.createChooser(intent, "Send Email"))
```

## Proposer de partager du contenu <a name="share"></a>

Afin de proposer de partager du contenu via les applications disponibles, installées
au préalable par l'utilisateur (_Slack_, _Messenger_, etc.), le _SDK Android_ fournit
la classe <i style='color:green'>Intent</i> avec un paramétrage spécifique.

La bibliothèque _Anko Commons_ propose la fonction <i style='color:#00bfff'>share()</i>,
dont l'import correspond à `import org.jetbrains.anko.share`.

1. Appelez la fonction <i style='color:#00bfff'>share()</i> :

        share(getString(R.string.text_share_app), getString(R.string.app_name))

Avec le _SDK Android_, cela revient à utiliser la classe <i style='color:green'>Intent</i>
de la façon suivante :

```kotlin
val intent = Intent(Intent.ACTION_SEND);
intent.type = "text/plain"
intent.putExtra(Intent.EXTRA_SUBJECT, getString(R.string.app_name))
intent.putExtra(Intent.EXTRA_TEXT, getString(R.string.text_share_app))

startActivity(Intent.createChooser(intent, "Share"))
```

Par ailleurs, l'implémentation de la fonction <i style='color:#00bfff'>share()</i>
visible depuis la classe <i style='color:#00bfff'>Intents.kt</i> correspond à
la fonction d'extension suivante :

```kotlin
fun Context.share(text: String, subject: String = ""): Boolean {
    try {
        val intent = Intent(android.content.Intent.ACTION_SEND)
        intent.type = "text/plain"
        intent.putExtra(android.content.Intent.EXTRA_SUBJECT, subject)
        intent.putExtra(android.content.Intent.EXTRA_TEXT, text)
        startActivity(Intent.createChooser(intent, null))
        return true
    } catch (e: ActivityNotFoundException) {
        e.printStackTrace()
        return false
    }
}
```

<br>

## Retour d'expérience sur _Anko_
Finalement, la bibliothèque _Anko Commons_ offre des fonctions d'extensions
et autres implémentations _Kotlin_ intéressantes. En particulier, elle permet
de programmer très rapidement les tâches utilisateurs les plus courantes :

* [Voir un message rapide](#toast)
* [Interagir avec une boîte de dialogue](#alert)
* [Ouvrir un autre écran](#start)
* [Voir une page Internet](#browse)
* [Envoyer un email](#email)
* [Partager du contenu](#share)

Cela dit, il est important de savoir ce qu'il y a sous le capot (`Cmd` ou `Ctrl` + clique :)
afin de connaître l'implémentation effectuée à partir du _SDK Android_. Parfois,
il est nécessaire de mettre les mains dans le cambouis afin de développer une fonctionnalité
plus évoluée, voir plus complexe. La connaissance du _SDK Android_ est alors bienvenue.

Aussi, l'utilisation des fonctions _Anko Commons_ peuvent être restreintes à un contexte spécifique,
c'est-à-dire qu'elles peuvent être appelées depuis une <i style='color:green'>Activity</i>
ou bien depuis un <i style='color:green'>Fragment</i>. Leur intégration dans une architecture
spécifiquement alambiqué n'est alors pas forcément adéquate.

### <i class="fa fa-globe" aria-hiden="true"></i> Références :

1. <a name="github"></a>[Anko on GitHub](https://github.com/kotlin/anko)
2. <a name="ankologger"></a>[AnkoLogger documentation](https://github.com/Kotlin/anko/wiki/Anko-Commons-%E2%80%93-Logging)
3. [Dialogs using Anko by Antonio Leiva](https://antonioleiva.com/dialogs-android-anko-kotlin/)
4. [Why every Android developer should use Anko by Adrian Bukros](https://www.kotlindevelopment.com/why-should-use-anko/)

*[AS]: Android Studio
[AK-2]: https://www.chillcoding.com/blog/2017/09/28/configurer-kotlin-projet-android/
[AK-3]: https://www.chillcoding.com/blog/2017/10/03/ajouter-extensions-kotlin/
