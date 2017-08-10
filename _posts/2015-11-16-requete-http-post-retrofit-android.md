---
title: "Faire une requête HTTP POST avec Retrofit en Android"
categories: coding android tutoriel fr
author: macha
---

Ce tutoriel va vous donner les clés pour faire une requête HTTP POST au format
JSON, en Android, avec la librairie [**Retrofit 2.0**](http://square.github.io/retrofit/).

Tout d'abord, il faut au préalable avoir [Configurer un projet Android pour utiliser la librairie Retrofit](utiliser-la-librairie-retrofit-dans-une-application-android/).

Ensuite, il s'agit de faire la requête HTTP POST. En particulier, nous nous intéressons à envoyer un objet au format JSON à un serveur distant.

## Créer la classe JAVA relative à l'objet JSON à envoyer

Par exemple, nous souhaitons envoyez un utilisateur, user, définit par un nom (name), da costa, et un prénom (first_name), macha au format JSON :


    {"name":"da costa",
    "first_name":"macha"}

Il faut créer la classe JAVA **_User_** suivante :


     private static class User {

            final String name;
            final String first_name;

            public User(String name, String first_name) {
                this.name = name;
                this.first_name = first_name;

            }
        }


## Créer la variable et la classe JAVA relative à la requête HTTP POST

Par exemple, nous souhaitons envoyer une instance de **_User_** en POST à l'adresse _example.server.com/lists/arcadegame/members_. Il faut créer la variable API_URL, de préférence dans l'**Activity** principale :


        public static final String API_URL = "https://example.server.com";


et la classe **_PostTo_** représentant la requête POST :


    interface PostTo {
            @POST("/lists/arcadegame/members/")
            Call<Repo> sendUser(@Body SubscribeUser body);
        }

## Executer la requête HTTP POST

Il s'agit à présent de créer le client avec la librairie **[Retrofit](http://square.github.io/retrofit/) **dans l'**Activity** principale, la classe JAVA depuis laquelle la requête sera lancée. Par exemple, nous exécutons  la requête dans une méthode appelé sur l'évènement d'un bouton, présent dans une **Activity** Android.

  1. Créer le client HTTP, dans l'**Activity** principale :

         public void sendUserInfo(View view) {
     Retrofit retrofit = new Retrofit.Builder()
                    .baseUrl(API_URL)
                    .addConverterFactory(GsonConverterFactory.create())
                    .build();
    }


  2. Créer l'utilisateur à envoyer :

         User user = new User("macha", "da costa");


  3. Envoyer la requête via le client en asynchrone:

         public void sendUserInfo(View view) {
    ...
     PostTo post = retrofit.create(PostTo.class);

            Call<Repo> call = post.sendUser(user);

       call.enqueue(new Callback<Repo>() {
                @Override
                public void onResponse(Response<Repo> response, Retrofit retrofit) {
                    Toast.makeText(getActivity(), String.format("OK"), Toast.LENGTH_SHORT).show();

                }

                @Override
                public void onFailure(Throwable t) {
                    Toast.makeText(getActivity(), String.format("KO"), Toast.LENGTH_SHORT).show();

                }
            });
    }


En Android, il n'est pas possible d'envoyer directement la requête : \- soit la requête est envoyé dans un **Thread** en synchrone avec la méthode _.execute()_ \- soit la requête est envoyé en asynchrone avec la méthode _.enqueue(...)_

En effet, Android interdit d'envoyer des requêtes HTTP en direct car elles pourraient bloquer l'application si elles ne sont pas réalisées assez rapidement. La requête doit être envoyée en parallèle de l'execution de l'application, pour cela elle envoyé depuis un **Thread** Android ou bien en asynchrone avec la méthode _enqueue_ de Retrofit.

Finalement, dans ce tutoriel il a été envoyé une requête HTTP POST via une application cliente Android, ceci en asynchrone, sans attente de retour du server. L'envoie d'une requête HTTP GET est très similaire : [faire une requête HTTP GET avec Retrofit en Android](/requete-http-get-retrofit-android/).

**Source :**

[Principaux changements de Retrofit avec la version 2](http://inthecheesefactory.com/blog/retrofit-2.0/en)

[Simple POST avec Retrofit en Android Version 1.9](http://codepen.io/asommer70/post/retrofit-and-post)

[Retrofit 2.0 API Spec, issue on Github by Jake Wharton](https://github.com/square/retrofit/issues/297)
