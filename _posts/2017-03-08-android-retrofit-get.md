---
title: "Make HTTP GET requests in Android with Retrofit"
categories: en coding tutoriel android
author: macha
permalink: /android-retrofit-send-http/
---

<div class="text-center lead" markdown="1">
  ![Android HTTP Request](/assets/img/post/android-request.png)
</div>

This tutorial explains how to make an HTTP GET request with the Retrofit library in an Android Studio (AS) project. JSON format with Retrofit version 2.2 is used (latest version to date).

<!--more-->

## Configure the AS project to use Retrofit

First of all, we have to import the last version of the Retrofit library in our Android Studio project and add the internet permission.

1. Create a new Android project or Open an existing one.
2. In the gradle file of the module (the one attached to 'app' module, NOT the one attached to the whole project), include the library:

   ```java
    dependencies {
      compile 'com.squareup.retrofit2:retrofit:2.2.0'
    }
   ```
3. Add the OkHttp library as a dependency, for back-compatibility reasons:

   ```java
    dependencies {
      compile 'com.squareup.okhttp3:okhttp:3.6.0'
    }
   ```
4. In the same gradle file, import a JSON converter:

   ```java
  dependencies {
    compile 'com.squareup.retrofit2:converter-gson:2.2.0'
  }
   ```
5. Add permission to authorize the application to connect to internet in the Manifest file of the project (`AndroidManifest.xml`), between `<manifest>` and `<application/>` tags:

   ```xml
    <uses-permission android:name="android.permission.INTERNET" />
   ```

## Create Retrofit objects to make an HTTP GET request

1. Instantiate a Retrofit client in the main Activity:

   ```java
    Retrofit retrofit = new Retrofit.Builder()
                    .baseUrl("https://api.github.com/")
                    .addConverterFactory(GsonConverterFactory.create())
                    .build();
   ```
2. Create an interface for the GitHub service, i.e. add a Java class named `GitHubService`:

   ```java
    public interface GitHubService {
      @GET("users/{user}/repos")
      Call<List<Repo>> listRepos(@Path("user") String user);
  }
   ```
7. Create a `Repo` class representing the object to receive:

   ```java
  class Repo {

      final String name;

      public Repo(String name) {
          this.name = name;
      }
  }
   ```
8. In the main Activity, create the request, then send it async:

   ```java
   GitHubService service = retrofit.create(GitHubService.class);

          Call<List<Repo>> repos = service.listRepos("machadacosta");

          repos.enqueue(new Callback<List<Repo>>() {
              @Override
              public void onResponse(Call<List<Repo>> call, Response<List<Repo>> response) {
                  Toast.makeText(getApplicationContext(), String.format("OK"), Toast.LENGTH_SHORT).show();
                  List<Repo> allRepos = response.body();
              }

              @Override
              public void onFailure(Call<List<Repo>> call, Throwable t) {
                  Toast.makeText(getApplicationContext(), String.format("KO"), Toast.LENGTH_SHORT).show();
              }

          });
   ```
The response is in the `allRepos` variable. If not, make sure you have access to internet on your smartphone (or your laptop if you're using an emulator).
