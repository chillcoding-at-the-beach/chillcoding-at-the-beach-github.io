---
title: "Utiliser les fichiers de Préférences dans une application Android [AK 7]"
categories: fr coding tutoriel android-bdd
author: macha
last_update: 2018-02-22
---

<div class="text-center lead" markdown="1">
  ![Android Base de Données](/assets/img/post/android-bdd.png)
</div>

Les fichiers de préférences, <b style='color:green'>SharedPreferences</b>,
correspondent aux fichiers de paramètres de l'application. Ils sont utilisés pour
sauvegarder des données persistantes, utiles pour le fonctionnement de l'application.
C'est la première solution à envisager lorsqu'on souhaite sauvegarder des données.

En particulier, ces fichiers de préférences permettent de stocker des données sous
la forme de couple clé, valeur (où clé est de type <b style='color:#00bfff'>String</b>,
permettant de référencer la valeur, et valeur est une donnée primitive telle qu'un
<b style='color:#00bfff'>Integer</b>, un <b style='color:#00bfff'>Boolean</b>, ou un 
<b style='color:#00bfff'>String</b>).
Ces derniers sont consultables durant l'exécution et persistent après la fermeture
de l'application.
Un des intérêts est de pouvoir y accéder depuis n'importe quelle classe ayant accès
au contexte de l'application, notamment depuis une <b style='color:green'>Activity</b>
ou un <b style='color:green'>Fragment</b>.

Par exemple, pour une application destinée à un seul utilisateur, il serait intéressant
d'y stocker le profil de ce dernier (préférence de son, âge, sexe, etc.). Cet
article détaille comment créer un écran de paramètre, permettant d'enregistrer
le paramètre audio de l'utilisateur. Ensuite, il s'agit de récupérer la valeur
de ce paramètre, à partir de fonctions natives du SDK _Android_.
Puis, il est élaboré l'écriture dans un fichier de préférence, sans passer par
une interface utilisateur. Enfin, il est utilisé une classe déléguée _Kotlin_
afin de simplifier l'utilisation des <b style='color:green'>SharedPreferences</b>.

## Ajouter un écran de paramètre
Tout d'abord, il s'agit de créer la vue _XML_ spécifique aux préférences,
<b style='color:green'>Preferences</b> [\[1\]](#preferences). Ensuite, cette vue
devra être liée à une classe héritant de <b style='color:green'>PreferencesFragment</b>.

1. Ajoutez un dossier de ressource dans le dossier `res/` via _Android Studio_,
nommé le `xml/` (spécifier _xml_ pour son type).
2. Ajoutez un fichier _XML_ **settings.xml** dans le dossier venant d'être créé :

        <PreferenceScreen xmlns:android="http://schemas.android.com/apk/res/android">
        </PreferenceScreen>

3. Ajoutez un bouton à bascule, à l'intérieur des balises `<PreferenceScreen>`.
Il représente le paramètre audio, avec comme clé, `@string/pref_sound` et valeur
par défaut, `true` :

        <SwitchPreference
        android:defaultValue="true"
        android:key="@string/pref_sound"
        android:title="@string/label_sound" />

4. Ajoutez une nouvelle classe _Kotlin_, **SettingsFragment**, elle hérite de <b style='color:green'>PreferencesFragment</b> :


        class SettingsFragment : PreferenceFragment() {
            override fun onCreate(savedInstanceState: Bundle?) {
                super.onCreate(savedInstanceState)
            }
        }

5. Liez le fichier **settings.xml** à  **SettingsFragment**, via la fonction
<i style='color:green'>addPreferencesFromResource()</i>, à appeler depuis la méthode
<i style='color:green'>onCreate()</i> :

        addPreferencesFromResource(R.xml.settings)

6. Chargez la valeur entrée par défaut dans **settings.xml** dans le fichier <b style='color:green'>SharedPreferences</b> de défaut (depuis une
<b style='color:green'>Activity</b> ou un <b style='color:green'>Fragment</b>) :

        PreferenceManager.setDefaultValues(this, R.xml.settings, false)

À présent, le fichier <b style='color:green'>SharedPreferences</b> de défaut
contient un couple de clé, valeur (`@string/pref_sound`, `true`). La valeur
associée à la clé `@string/pref_sound` sera automatiquement mise à jour en fonction
des interactions de l'utilisateur avec cet écran de paramètre.

## Lire le fichier de préférence de défaut

Afin de récupérer la valeur précédemment stockée, il faut cibler le fichier
<b style='color:green'>SharedPreferences</b> de défaut. Ensuite, il s'agit de récupérer
la valeur via la fonction de lecture appropriée (<i style='color:green'>getInt()</i>,
<i style='color:green'>getBoolean()</i> ou <i style='color:green'>getString()</i>, etc.),
cela depuis une <b style='color:green'>Activity</b> ou un <b style='color:green'>Fragment</b>.

1. Récupérez le fichier <b style='color:green'>SharedPreferences</b> de défaut,
dans une variable `defaultSharedPref` :

        var defaultSharedPref = PreferenceManager.getDefaultSharedPreferences(this)

2. Récupérez la valeur associée à la clé `@string/pref_sound` :

        defaultSharedPref.getBoolean(getString(R.string.pref_sound), true)

D'une part, les fichiers de préférences peuvent être ouvert en
lecture afin d'y récupérer les données préalablement enregistrées. D'autre part,
ces fichiers peuvent être ouvert en écriture (ou édition).

## Écrire dans un des fichiers de préférence

Afin d'écrire dans un fichier de préférence, il s'agit de cibler un des fichiers,
puis de récupérer son éditeur [\[3\]](#keyvalue). A ce moment, il est possible
de modifier, ajouter ou supprimer des couples de clé, valeur.

1. Ciblez un fichier de préférence, sans nom, dans un mode privé (seule votre
  application y aura accès) :

        var sharedPref = getPreferences(Context.MODE_PRIVATE)

2. Récupérez l'éditeur :

        var editor: SharedPreferences.Editor = sharedPref.edit()

3. Insérez un nombre :

        editor.putInt(App.PREF_NB, nb)

   avec `App.PREF_NB` une constante de type <b style='color:#00bfff'>String</b>.

4. Validez le changement apporté au fichier :

        editor.commit()

Il est également possible de nommer un fichier de préférence :

```Kotlin
var sharedPref = getPreferences("user", Context.MODE_PRIVATE)
```
De plus, il est possible d'autoriser l'accès d'un fichier de préférence à
d'autres applications :

```Kotlin
var sharedPref = getPreferences(Context.MODE_WORLD_WRITEABLE)
```

Par ailleurs, à l'instar des fonctions de lecture, il y a les fonctions d'écriture,
selon le type  pris par la valeur (<i style='color:green'>putInt()</i>,
<i style='color:green'>putBoolean()</i> ou <i style='color:green'>putString()</i>, etc.).

## Plus loin avec Kotlin

De façon à faciliter l'ajout, la modification et la lecture de couple clé, valeur,
il est intéressant d'utiliser une classe déléguée _Kotlin_.

1. Ajoutez un fichier _Kotlin_ **DelegatesExt** :

        object DelegatesExt {
            fun <T> preference(context: Context, name: String,
                       default: T) = Preference(context, name, default)
            fun <T> preference(fragment: Fragment, name: String,
                       default: T) = Preference(fragment, name, default)
        }

2. Dans ce fichier [\[5\]](#delegates), à la suite, ajoutez la classe avec un type
réifié `Preference<T>` :

        class Preference<T>(private var context: Context?, private val name: String,
                    private val default: T) {
            var myFragment: Fragment? = null
            constructor(fragment: Fragment, name: String, default: T) : this(null, name, default) {
                myFragment = fragment
            }

            private val prefs: SharedPreferences by lazy {
                if (myFragment == null)
                    PreferenceManager.getDefaultSharedPreferences(context)
                else
                    PreferenceManager.getDefaultSharedPreferences(myFragment!!.activity)
            }

            operator fun getValue(thisRef: Any?, property: KProperty<*>): T = findPreference(name, default)

            operator fun setValue(thisRef: Any?, property: KProperty<*>, value: T) {
                putPreference(name, value)
            }

            @Suppress("UNCHECKED_CAST")
            private fun findPreference(name: String, default: T): T = with(prefs) {
                val res: Any = when (default) {
                    is Long -> getLong(name, default)
                    is String -> getString(name, default)
                    is Int -> getInt(name, default)
                    is Boolean -> getBoolean(name, default)
                    is Float -> getFloat(name, default)
                    else -> throw IllegalArgumentException("This type can be saved into Preferences")
                }
                res as T
            }

            @SuppressLint("CommitPrefEdits")
            private fun putPreference(name: String, value: T) = with(prefs.edit()) {
                when (value) {
                    is Long -> putLong(name, value)
                    is String -> putString(name, value)
                    is Int -> putInt(name, value)
                    is Boolean -> putBoolean(name, value)
                    is Float -> putFloat(name, value)
                    else -> throw IllegalArgumentException("This type can't be saved into Preferences")
                }.apply()
            }
        }

3. Utilisez cette classe déléguée, depuis une
<b style='color:green'>Activity</b> ou un <b style='color:green'>Fragment</b>, en déclarant une variable (représentant le nom de l'utilisateur, par exemple) :

        var userName: String by DelegatesExt.preference(this, App.PREF_NAME, "John")

4. Modifiez cette variable `userName`, cela aura pour effet de modifier le fichier <b style='color:green'>SharedPreferences</b> de défaut :

        userName = "Macha"


Finalement, cet article présente l'utilisation des fichiers de préférence pour
des paramètres nécessitant une interface utilisateur ainsi que pour des paramètres
invisibles par ce dernier. De plus, il présente une classe déléguée permettant
de simplifier l'utilisation du fichier <b style='color:green'>SharedPreferences</b>
de défaut depuis une <b style='color:green'>Activity</b> ou un
<b style='color:green'>Fragment</b>.

### {% icon fa-globe %} Références

1.  <a name="preferences"></a>[Android Documentation: Settings](https://developer.android.com/guide/topics/ui/settings.html)
2. [Material Design: Settings](https://material.google.com/patterns/settings.html)
3. <a name="keyvalue"></a>[Android Documentation: Save Key-Value Data with SharedPreferences](https://developer.android.com/training/data-storage/shared-preferences.html#ReadSharedPreference)
4. [Antonio Leiva: DelegatesExt](https://github.com/antoniolg/Kotlin-for-Android-Developers/blob/master/app/src/main/java/com/antonioleiva/weatherapp/extensions/DelegatesExtensions.kt)
5. <a name="delegates"></a>[DelegatesExt by macha on Gitlab](https://gitlab.com/chillcoding-at-the-beach/kotlin-for-android/blob/master/app/src/main/java/com/chillcoding/kotlin/tool/DelegatesExt.kt)
6. [Correction sur GitLab : MR 7 Shared Preferences](https://gitlab.com/chillcoding-at-the-beach/kotlin-for-android/merge_requests/15/commits)
