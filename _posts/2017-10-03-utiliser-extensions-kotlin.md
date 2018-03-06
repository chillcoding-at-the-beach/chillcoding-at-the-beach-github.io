---
title: "Utiliser les extensions Kotlin pour accéder facilement aux éléments de la vue [AK 4 A]"
categories: fr coding tutoriel android kotlin
author: macha
last_update: 2018-01-18
---

<div class="text-center lead" markdown="1">
  ![Android vue](/assets/img/post/android-view.png)
</div>

Ce tutoriel détaille comment utiliser les extensions _Kotlin_ dans un projet _Android Studio_, d'ores et déjà configuré avec _Kotlin_ (cf. [Configurer _Kotlin_ dans un projet _Android Studio_ [AK 2]][AK-2]). Cela afin d'accéder facilement aux éléments de la vue, déclarée dans un fichier _XML_.

<!--more-->

## Pré-requis : Savoir lier une vue à une activité

1. Créez un projet _Android Studio_  en cochant le support du langage _Kotlin_
2. Choisissez  comme modèle d'activité la vide soit `Empty Activity`
3. Laissez les noms entrés par défaut **MainActivity** pour l'<b style='color:green'>Activity</b> et **activity_main.xml** pour la vue (ou <i style='color:green'>layout</i>)
4. Dans **MainActivity**, remarquez l'appel de la fonction <i style='color:green'>setContentView()</i> permettant de lier la classe et la vue, dans la méthode <i style='color:green'>onCreate()</i>

```
  ...
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_my_main)
  }
  ...
```

Remarque : La fonction <i style='color:green'>setContentView()</i> prend en paramètre la vue créée par défaut **activity_main.xml**. Dans le code (_Kotlin_ ou _Java_), on accède à cette vue via le fichier `R`, ce dernier contient toutes les références des ressources et il est automatiquement généré par _Android Studio_. Ainsi une vue contenue dans le dossier `layout/` est accessible dans le code via `R.layout.` + le nom du fichier _XML_ qui la contient.

## Pré-requis : Observer l'ajout des extensions Kotlin

1. Placez vous dans le fichier _gradle_ relatif au module du projet, soit
`build.gradle (Module: app)`
2. En tête du fichier observez les plugins automatiquement ajouté par _AS_ :

```
apply plugin: 'com.android.application'
apply plugin: 'kotlin-android'
apply plugin: 'kotlin-android-extensions'

android {
...
```

_AS_ configure par défaut un projet _Android_ avec les 3 plugins suivants :

 * `com.android.application` : contient les classes relatives au _SDK Android_
 * `kotlin-android` : pour le support du langage _Kotlin_
 * `kotlin-android-extensions` : pour l'accès facile aux éléments de la vue entre autres

##  Accéder à un élément de la vue depuis le code Kotlin

Si vous exécutez le projet créé par défaut, avec le modèle d'activité vide, alors
vous devriez voir à l'écran le texte _Hello World!_ s'afficher.
Dans cette partie, l'objectif est de modifier ce texte par _Hello Kotlin :)_ ,
via la classe **MainActivity**.

1. Placez vous dans la vue, soit le fichier **activity_main.xml** situé dans le dossier `layout/`
2. Ajoutez un identifiant, par exemple _myText_, à l'élément graphique de type
<b style='color:green'>TextView</b>
 * soit via l'éditeur graphique intégré à AS
 * soit directement dans le fichier _XML_, en passant en mode `Text` plutôt que `Design`

   ```
   ...
   <TextView
          android:id="@+id/myText"
  ...
   ```
   Remarquez l'annotation`@+id/` pour la déclaration d'un nouvel identifiant _XML_.
3. Placez vous dans la classe principale de votre projet : **MainActivity**,
en particulier dans la méthode <i style='color:green'>onCreate()</i>
4. Vous pouvez à présent, accéder à l'élément graphique de type <b style='color:green'>TextView</b>,
via la variable _myText_, dans le code _Kotlin_
 * commencez à tapez _my_, puis `Enter` cela aura pour effet de sélectionner
 `myText from activity_main for Activity (Android extensions) TextView`
5. Remarquez l'import automatique :

       import kotlinx.android.synthetic.main.activity_main.*

6. Modifiez le texte, via l'attribut <i style='color:green'>text</i>, disponible
pour tous les objets de type <b style='color:green'>TextView</b> :

       myText.text = "Hello Kotlin :)"


Enfin, après exécution du projet, vous devriez voir s'afficher à l'écran _Hello Kotlin :)_ !

##  Comparer avec la solution habituelle

Sans les extensions _Kotlin_, afin de modifier un élément de la vue depuis du code :
d'une part, il s'agit d'ajouter un identifiant à l'élément graphique, comme fait
précédemment; d'autre part, il s'agit de récupérer cet élément via la fonction
<i style='color:green'>findViewById()</i> prenant en paramètre sa référence `R.id.myText`.
Il s'agirait donc de coder la ligne supplémentaire :

* en _Java_

```Java
TextView myText = (TextView) findViewById(R.id.myText);
```
* en _Kotlin_

```Kotlin
var myText = findViewById(R.id.myText) as TextView
```
ou bien

```kotlin
var myText:TextView = findViewById(R.id.myText)
```

Remarquez la conversion, en <b style='color:green'>TextView</b>, de l'objet
renvoyé par la fonction <i style='color:green'>findViewById()</i>. De plus, une
déclaration de variable est faite : _myText_, cela est sujet à des fuites mémoires;
en utilisant les extensions _Kotlin_, cela vous assure une bonne gestion des
éléments de la vue. Grâce au plugin d'extensions _Kotlin_, ils sont mis en cache
dans des variables déclarées une seule fois.

Note : L'intérêt de modifier les éléments graphiques depuis du code, plutôt que
directement dans le fichier _XML_, c'est de pouvoir les modifier dynamiquement
pendant l'exécution de l'application. Par exemple, un texte pourrait être changé
si l'utilisateur clique sur un bouton.

Finalement, cet article explique comment les extensions _Kotlin_ sont ajoutées dans un
projet _Kotlin Android_. Ensuite, il détaille comment modifier un élément de la
vue depuis du code _Kotlin_. Cela, en lui ajoutant un identifiant depuis la vue,
puis en utilisant cet identifiant comme une variable de classe depuis le code.

### {% icon fa-globe %} Référence

* [Antonio Leiva - Kotlin Android Extensions: Say goodbye to findViewById](https://antonioleiva.com/kotlin-android-extensions/)

*[AS]: Android Studio
[AK-2]: https://www.chillcoding.com/blog/2017/09/28/configurer-kotlin-projet-android/
