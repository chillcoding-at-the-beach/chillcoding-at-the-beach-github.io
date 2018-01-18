---
title: "Faire une requête HTTP GET avec Retrofit en Kotlin Android"
categories: fr coding tutoriel android-serveur kotlin
author: macha
---

<div class="text-center lead" markdown="1">
  ![Android HTTP Request](/assets/img/post/android-request.png)
</div>

Ce tutoriel va vous donner les clés pour faire une requête **HTTP GET** au format **JSON**,
en _Android_, avec la bibliothèque [_Retrofit V2_][Retrofit],
sous le langage _Kotlin_.

<!--more-->

## Importer Retrofit et Moshi dans le projet Android

Tout d’abord, il faut au préalable importer, dans le projet _Android_, la
dépendance [_Retrofit 2_][Retrofit], ainsi qu'un convertisseur de requête,
et la bibliothèque [_OkHttp_][Okhttp] afin d'assurer la retro-compatibilité :

        compile "com.squareup.retrofit2:retrofit:$retrofit_version"
        compile "com.squareup.retrofit2:converter-moshi:$retrofit_version"
        compile "com.squareup.okhttp3:okhttp:$okhttp_version"

avec :

        ext.retrofit_version = '2.3.0'
        ext.okhttp_version = '3.9.1'

Il s'agit aussi d'ajouter la permission internet. Pour plus de détail, consultez
l'article [Configurer un projet Android pour utiliser Retrofit][Configure].

Dans la suite, nous nous intéressons à réaliser une requête **HTTP GET** et à
récupérer une liste d'objets au format **JSON** depuis un serveur distant.

## Créer la classe Kotlin représentant les données

Il s'agit de créer la classe _Kotlin_ représentant l'objet à récupérer du serveur.

Par exemple, nous souhaitons récupérer une liste de cours, depuis un serveur
déployé [ici sur heroku](http://mobile-courses-server.herokuapp.com/).
La requête permettant d'obtenir la liste de cours est _<http://mobile-courses-server.herokuapp.com/courses>._ 
Avec [Postman][Postman], l'exécution de cette requête renvoie le fichier **JSON** suivant :

```json
[
  {
      "id": "c8fabf68-8374-48fe-a7ea-a00ccd07afff",
      "title": "ABC d'Android",
      "time": 240,
      "cover": "http://mobile-courses-server.herokuapp.com/assets/android.png"
  },
  {
      "id": "a460afed-e5e7-4e39-a39d-c885c05db861",
      "title": "Kotlin pour Android",
      "module": "Android",
      "time": 240,
      "cover": "http://mobile-courses-server.herokuapp.com/assets/android-kotlin.png"
  },
  {
      "id": "fcd1e6fa-a63f-4f75-9da4-b560020b6acc",
      "title": "Outils du Développeur",
      "module": "Android",
      "time": 180,
      "cover": "http://mobile-courses-server.herokuapp.com/assets/android-config.png"
  },
  {
      "id": "c30968db-cb1d-442e-ad0f-80e37c077f89",
      "title": "Interface Utilisateur Native",
      "module": "Android",
      "time": 240,
      "cover": "http://mobile-courses-server.herokuapp.com/assets/android-view.png"
  },
  {
      "id": "78ee5f25-b84f-45f7-bf33-6c7b30f1b502",
      "title": "Interface Utilisateur Interactive",
      "module": "Android",
      "time": 240,
      "cover": "http://mobile-courses-server.herokuapp.com/assets/android-navigation.png"
  },
  {
      "id": "cef179f2-7cbc-41d6-94ca-ecd23d9f7fd6",
      "title": "Adaptateur de Liste de Données",
      "module": "Android",
      "time": 240,
      "cover": "http://mobile-courses-server.herokuapp.com/assets/android-adapter-list.png"
  },
  {
      "id": "bbcee412-be64-4a0c-bf1e-315977acd924",
      "title": "Preference Utilisateur",
      "module": "Android",
      "time": 240,
      "cover": "http://mobile-courses-server.herokuapp.com/assets/android-bdd.png"
  },
  {
      "id": "bbcee412-be64-4a0c-bf1e-315977acd924",
      "title": "Architecture Client Serveur",
      "module": "BDD Client",
      "time": 240,
      "cover": "http://mobile-courses-server.herokuapp.com/assets/bdd-client.png"
  }
]
```

Ainsi le serveur, renvoie une liste de cours, contenant chacun :

   - un identifiant (_id_)
   - un titre (_title_)
   - un module (_module_)
   - une durée (_time_)
   - une image (_cover_)

Afin de modéliser un tel objet, cours, soit _Course_, il faut créer la classe _Kotlin_
représentant l'objet. Par exemple, la classe `Course` représente un cours, pour
l'application mobile, selon les données du serveur :

    class Courses(val title: String, val cover: String)

Les attributs du constructeur doivent porter les mêmes noms que ceux du fichier **JSON**
renvoyé par le serveur : _title_ et _cover_. De plus, seulement ces deux attributs
nous intéresse, c'est pourquoi les autres n'apparaissent pas dans la classe.

## Créer l'interface Kotlin représentant l'API

Il s'agit de créer l'interface _Kotlin_ qui va contenir la déclaration de toutes les
requêtes disponibles sur le [serveur de cours dont le code source est hébergé sur GitLab][Server].
Pour le moment, nous avons une seule requêtes **GET**, ne prenant aucun paramètre
et renvoyant une liste de cours.
Par exemple, l'interface `CoursesService` représente l'API du serveur de cours :

    interface CoursesService {
        @GET("/courses")
        fun listCourses(): Call<List<Course>>
    }

L'annotation `@GET` de [Retrofit 2][Retrofit] indique la déclaration d'une requête **GET**.
Ensuite, en paramètre, il est placé le chemin de la requête `/courses`.

La signature de la fonction associé à la requête porte le nom `listCourses`
(son nom n'a pas d'importance). Elle ne prend pas de paramètre puisque la requête n'en demande pas.
Et elle renvoie un `Call<...>`, c'est la réponse du serveur, prenant entre chevron
`List<Course>`, c'est-à-dire la liste de cours renvoyée par le serveur au format **JSON**.

Toutes fonctions associées à une requête, retourne un objet `Call<>`, ensuite
le paramètre entre chevron varie selon ce que renvoie le serveur (une liste ou un objet)
et ce que l'on souhaite récupérer. Par ailleurs, si la requête requiert un paramètre
tel qu'un nom d'utilisateur alors il est spécifié en paramètre de la fonction.

Par exemple pour récupérer la liste des répertoires d'un utilisateur **GitHub**,
selon leur API, il faudrait coder en _Kotlin_ :

    @GET("/users/{user}/repos")
    listRepos(@Path("user") user: String): Call<List<Repo>>

## Créer l'instance du client Retrofit

Depuis, une <i style='color:green'>Activity</i> ou bien un
<i style='color:green'>Fragment</i>, nous allons créer une instance de client _Retrofit_.
Par exemple, dans un <i style='color:green'>Fragment</i> `NetworkFragment`:

        val retrofit = Retrofit.Builder()
         .baseUrl(url)
         .addConverterFactory(MoshiConverterFactory.create())
         .build()

avec l'url :

        private val url = "http://mobile-courses-server.herokuapp.com/"

les imports concernés sont celui de [_Retrofit 2_][Retrofit]  et de [_Moshi_][Moshi], le convertisseur de **JSON**  :

        import retrofit2.Retrofit
        import retrofit2.converter.moshi.MoshiConverterFactory

Le client _Retrofit_ est à configurer avec une url de serveur ainsi qu'un
convertisseur de requête. Ici, il est choisi le convertisseur _Moshi_ car il permet
de convertir du **JSON** en objet _Kotlin_.

## Créer l'instance du service

Après avoir créé l'instance du client _Retrofit_, à la suite dans `NetworkFragment`, il s'agit de créer
l'instance du service comme suit :

        val service = retrofit.create(CoursesService::class.java)

et d'importer la classe `CoursesService`.

Ce service est créé à partir du client _Retrofit_, lequel contient l'url du serveur,
et à partir du `.class` de l'interface, laquelle contient toutes les requêtes possibles
avec le serveur.

## Créer la requête GET

Toujours à la suite dans `NetworkFragment`, il s'agit de créer la requête **GET** :

        val courseRequest = service.listCourses()

## Exécuter la requête GET

Enfin, il est possible d'exécuter la requête venant d'être créée via la fonction
<i style='color:#00bfff'>enqueue(object: Callback<...>)</i> de _Retrofit_ :

        courseRequest.enqueue(object : Callback<List<Course>> {
                    override fun onResponse(call: Call<List<Course>>, response: Response<List<Course>>) {
                        val allCourse = response.body()
                        if (allCourse != null) {
                            info("HERE is ALL COURSES FROM HEROKU SERVER:")
                            for (c in allCourse)
                                info(" one course : ${c.title} : ${c.cover} ")
                        }
                    }
                    override fun onFailure(call: Call<List<Course>>, t: Throwable) {
                        error("KO")
                    }
                })

les imports associés sont les suivants :

          import retrofit2.Call
          import retrofit2.Callback
          import retrofit2.Response

ainsi que l'import de la classe `Course`.

La fonction <i style='color:#00bfff'>enqueue(object: Callback<...>)</i> prend en
paramètre l'objet <i style='color:#00bfff'>Callback</i>,
cet objet intercepte la réponse du serveur.
Cette dernière est traitée dans la sur-implémentation  des fonctions `onResponse(...)`
et `onFailure(...)`.
Les paramètres du <i style='color:#00bfff'>Callback</i> ainsi que des fonctions
`onResponse(...)` et `onFailure(...)` dépendent directement du type de retour
de la fonction représentant la requête. Dans notre cas, le type de retour de
`listCourses()` est `List<Course>` (définit par ce que renvoie le serveur).

Enfin, la liste des cours en contenu dans `response.body()`.

Finalement, dans cet article nous avons vu comment :

- Importer _Retrofit_ et _Moshi_ dans le projet Android
- Créer la classe _Kotlin_ représentant les données à récupérer du seveur
- Créer l'interface _Kotlin_ représentant l'API du serveur
- Créer l'instance du client _Retrofit_ en version 2
- Créer l'instance du service d'API
- Créer la requête **GET**
- Exécuter la requête **GET**
- Récupérer le fruit de la requête

[Retrofit]: http://square.github.io/retrofit/
[Okhttp]: http://square.github.io/okhttp/
[Moshi]: https://github.com/square/retrofit/tree/master/retrofit-converters/moshi
[Postman]: https://chrome.google.com/webstore/detail/postman/fhbjgbiflinjbdggehcddcbncdddomop
[Server]: https://gitlab.com/chillcoding-at-the-beach/mobile-courses-server
[Configure]: https://www.chillcoding.com/blog/2015/11/16/configurer-projet-android-pour-retrofit/
