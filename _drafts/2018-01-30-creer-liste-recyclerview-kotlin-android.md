---
title: "Afficher une liste d'éléments avec un RecyclerView [AK 6]"
categories: fr coding tutoriel android kotlin
author: macha
---

<div class="text-center lead" markdown="1">
  ![Android Kotlin](/assets/img/post/android-kotlin.png)
</div>

Ce tutoriel explique comment implémenter, de manière simple, un
<b style='color:green'>RecyclerView</b>, en _Android_ avec le langage _Kotlin_.
Le <b style='color:green'>RecyclerView</b> est un composant visuel _Android_
de type conteneur, ce type de vue permet d'afficher un tableau d'éléments, sous
différentes formes (liste, grille, etc.). Par exemple, une
<b style='color:green'>GridView</b> permet d'afficher un tableau d'images dans
une grille.
Dans cet article, nous nous intéressons au <b style='color:green'>RecyclerView</b>,
il permet d'afficher, dans une vue liste, un tableau d'éléments, ici le tableau
des versions _Android_.
L'implémentation ce fait en trois étapes :

  {% icon fa-code %} Mise en place de l'<b style='color:green'>Activity</b> principale et des données
  {% icon fa-code %} Implémentation de l'adaptateur relatif au <b style='color:green'>RecyclerView</b>
  {% icon fa-code %} Configuration du <b style='color:green'>RecyclerView</b> dans l’activité principale


## Mise en place de l'_Activity_ principale et des données

Tout d'abord, il s'agit de mettre en place l'<b style='color:green'>Activity</b> principale
ainsi que le tableau d'éléments, ce dernier contient les données à afficher.

1. Créez un nouveau projet _Android Studio_, avec comme <b style='color:green'>Activity</b> principale **MainActivity**.

Ensuite, il s'agit de créer une classe représentant nos éléments à afficher, plus précisément,
une classe représentant une version d'_Android_. Pour commencer, notre version d'_Android_
ne possède qu'un nom (_name_).

2. Il s'agit de créer une nouvelle _data class Kotlin_, nommons la **MyAndroidVersion** :

```kotlin
data class MyAndroidVersion(val name: String)
```

Cette dernière permet de créer des objets de type **MyAndroidVersion** ayant un nom,
"Lollipop", par exemple :

```kotlin
val loli = MyAndroidVersion("Lollipop")
```

L'intérêt d'utiliser une classe de donnée est la génération automatique de fonction
d'affichage tel que _toString()_, de copie d'objet, _copy()_, d'égalité, _equals()_,
etc [\[1\]](#dataclass).

3. Créez le tableau d'éléments dans **MainActivity** :

```kotlin
val androidVersionArray = arrayOf(MyAndroidVersion("Banana"),
           MyAndroidVersion("Lollipop"))
```

4. Importez la bibliothèque de support du <b style='color:green'>RecyclerView</b> dans le fichier _gradle_ du projet `build.gradle (Project: MyProject)` (cf. [Configurer Kotlin dans un projet Android Studio [AK 2]][AK-2]) :

```
dependencies {      
...
  implementation “com.android.support:recyclerview-v7:$support_version”
...
 }
```
 avec dans le fichier _gradle_ du projet `build.gradle (Project: MyProject)` :

 ```
     ext.support_version = '26.1.0'
 ```
5. Déclarer le composant <b style='color:green'>RecyclerView</b> dans la vue principale, **activity_main.xml** :

```XML
<android.support.v7.widget.RecyclerView xmlns:android="http://schemas.android.com/apk/res/android"
    android:id="@+id/androidVersionRecyclerView"
    android:layout_width="match_parent"
    android:layout_height="match_parent" />

```
Remarquez la valeur `match_parent`, correspondre au parent, pour les attributs `android:layout_width` et `android:layout_height`.

À présent, les données sont créées, présentes dans le tableau `androidVersionArray`. De plus, l'<b style='color:green'>Activity</b> principale **MainActivity** déclare un <b style='color:green'>RecyclerView</b>, `androidVersionRecyclerView`.
Il s'agit, à présent, d'implémenter un adaptateur de données pour le composant visuel <b style='color:green'>RecyclerView</b>, soit une classe héritant de <b style='color:green'>RecyclerView.Adapter</b>.

## Implémentation de l'adaptateur relatif au RecyclerView

1. Déclarez une classe héritant de <b style='color:green'>RecyclerView.Adapter</b>
```
class AndroidVersionAdapter(val items: Array<MyAndroidVersion>) : RecyclerView.Adapter<AndroidVersionAdapter.ViewHolder>() {

}
```
2. Ajoutez le fichier de la vue représentant une ligne :
```
<?xml version="1.0" encoding="utf-8"?>
<android.support.constraint.ConstraintLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:layout_width="match_parent"
    android:layout_height="@dimen/common_width">

    <ImageView
        android:id="@+id/androidVersionImg"
        android:layout_width="@dimen/common_width"
        android:layout_height="@dimen/common_width" />

    <View
        android:layout_width="match_parent"
        android:layout_height="1dp"
        android:background="@color/colorPrimaryDark" />
</android.support.constraint.ConstraintLayout>

```
3. Ajouter dans **AndroidVersionAdapter** la composition :
```
class ViewHolder(val view: View) : RecyclerView.ViewHolder(view) {
        fun bindAndroidVersion(androidVersion: MyAndroidVersion) {
            with(androidVersion) {
                itemView.androidVersionImg.setImageResource(img)
            }
        }
    }
```
4. Ajoutez les méthodes d'héritage :

la fonction retournant le nombre d'éléments de la liste :
```
override fun getItemCount(): Int = items.size
```
la fonction retournant la visualisation d'une ligne de la liste :
```
override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
  val lineView = LayoutInflater.from(parent.context).inflate(R.layout.item_android_version, parent, false)
  return ViewHolder(lineView)
   }
```
la fonction s'occupant de charger les données dans la vue :
```
override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.bindAndroidVersion(items[position])
}
```


## Configuration du RecyclerView dans l’activité principale

1. Spécifiez <b style='color:green'>LinearLayoutManager</b> pour l'objet `androidVersionRecyclerView` :
```
androidVersionRecyclerView.layoutManager = LinearLayoutManager(this)
```
2. Spécifiez un adaptateur pour l'objet `androidVersionRecyclerView`:
```
androidVersionRecyclerView.adapter = AndroidVersionAdapter(androidVersionArray)
```

Ici, vous devriez pouvoir exécutez le projet.

## Plus loin : fonction d'extension pour charger la vue

```
fun ViewGroup.inflate(@LayoutRes layoutRes: Int, attachToRoot: Boolean = false): View {
       return LayoutInflater.from(context).inflate(layoutRes, this, attachToRoot)
}

```

Finalement, en trois quart d'heure top crono il est possible d'implémenter un <b style='color:green'>RecyclerView</b>.

### {% icon fa-globe %} Références

1. <a name="dataclass"></a>[Documentation Kotlin : Data classes](https://kotlinlang.org/docs/reference/data-classes.html)
2. [Merge Request 6 Item List Adapter](https://gitlab.com/chillcoding-at-the-beach/kotlin-for-android/merge_requests/14/diffs)
3. [Merge Request 6 Shortcuts List Adapter](https://gitlab.com/chillcoding-at-the-beach/kotlin-for-android/merge_requests/30/commits)

*[AS]: Android Studio
[AK-4]:https://www.chillcoding.com/blog/2017/10/09/utiliser-anko-kotlin-android/
*[AK-2]:https://www.chillcoding.com/blog/2017/09/28/configurer-kotlin-projet-android/
