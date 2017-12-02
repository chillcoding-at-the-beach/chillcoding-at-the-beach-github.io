---
title: "Vérifier l'état de connexion avec Android Kotlin [AK 11]"
categories: fr coding tutoriel android kotlin
author: macha
---

<div class="text-center lead" markdown="1">
  ![Android Kotlin](/assets/img/post/android-kotlin.png)
</div>

Ce tutoriel explique comment vérifier l'état de connexion à internet, d'un
appareil Android, avec le langage _Kotlin_, dans un projet _Android Studio_.
Cela afin d'effectuer une requête réseau par la suite.

## Vérifier l'existence d'une connexion à internet

1. Placez vous dans une <i style='color:green'>Activity</i> ou un
<i style='color:green'>Activity</i>
2. Récupérez l'objet <i style='color:green'>ConnectivityManager</i> comme suit :

        val cm = activity.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager

3. À présent vous pouvez récupérer l'objet <i style='color:green'>NetworkInfo</i> :

        val activeNetwork = cm.activeNetworkInfo

4. Enfin, créez la variable `isConnected` contenant `true` s'il y a bien une connexion à internet :

        val isConnected = activeNetwork != null && activeNetwork.isConnectedOrConnecting

L'objet `activeNetwork` de type <i style='color:green'>NetworkInfo</i> contient les informations relatives
à la connexion sur l'appareil. Afin de vérifier l'existence d'une connexion à internet,
il s'agit de vérifier que la variable `activeNetwork` n'est pas nulle. Puis, il faut vérifier
 que l'appareil est déjà connecté ou en train de se connecter via l'attribut `isConnectedOrConnecting`.

### <i class="fa fa-globe" aria-hiden="true"></i> Références :

1. <a name="android"></a>[developer.android.com: Determining and Monitoring the Connectivity Status](https://developer.android.com/training/monitoring-device-state/connectivity-monitoring.html)
2. <a name="ankologger"></a>[AnkoLogger documentation](https://github.com/Kotlin/anko/wiki/Anko-Commons-%E2%80%93-Logging)

*[AS]: Android Studio
[AK-2]: https://www.chillcoding.com/blog/2017/09/28/configurer-kotlin-projet-android/
[AK-3]: https://www.chillcoding.com/blog/2017/10/03/ajouter-extensions-kotlin/
