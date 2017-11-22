---
title: "Faire une requête HTTP GET avec Retrofit en Android"
categories: fr coding tutoriel android-serveur
author: macha
---

<div class="text-center lead" markdown="1">
  ![Android HTTP Request](/assets/img/post/android-request.png)
</div>

Ce tutoriel va vous donner les clés pour faire une requête HTTP GET au format JSON, en Android, avec la librairie [**Retrofit 2.2**](http://square.github.io/retrofit/).

<!--more-->

Tout d’abord, il faut au préalable importer, dans le projet Android, la librairie [**Retrofit 2.2**](http://square.github.io/retrofit/), un convertisseur de requête, et la librairie Okhttp afin d'assurer la retro-compatibilité :


    compile 'com.squareup.okhttp3:okhttp:3.6.0'
    compile 'com.squareup.retrofit2:converter-gson:2.2.0'
    compile 'com.squareup.retrofit2:retrofit:2.2.0'


Ensuite, il s’agit de faire la requête HTTP GET. En particulier, nous nous intéressons à récupérer un objet au format JSON depuis un serveur distant.

## Créer la classe JAVA relative à l'objet JSON à récupérer

Par exemple, nous souhaitons récupérer la liste des répertoires d'un utilisateur [GitHub](https://api.github.com/). La requête permettant d'obtenir la liste de repertoires est _<https://api.github.com/users/machadacosta/repos>._ Avec [Postman](https://chrome.google.com/webstore/detail/postman/fhbjgbiflinjbdggehcddcbncdddomop), l'execution de cette requête renvoie :


    [
    {
    "id": 39936429,
    "name": "bachamada",
    "full_name": "machadaCosta/bachamada",
    "owner": {
    "login": "machadaCosta",
    "id": 2046403,
    "avatar_url": "https://avatars.githubusercontent.com/u/2046403?v=3",
    "gravatar_id": "",
    "url": "https://api.github.com/users/machadaCosta",
    "html_url": "https://github.com/machadaCosta",
    "followers_url": "https://api.github.com/users/machadaCosta/followers",
    "following_url": "https://api.github.com/users/machadaCosta/following{/other_user}",
    "gists_url": "https://api.github.com/users/machadaCosta/gists{/gist_id}",
    "starred_url": "https://api.github.com/users/machadaCosta/starred{/owner}{/repo}",
    "subscriptions_url": "https://api.github.com/users/machadaCosta/subscriptions",
    "organizations_url": "https://api.github.com/users/machadaCosta/orgs",
    "repos_url": "https://api.github.com/users/machadaCosta/repos",
    "events_url": "https://api.github.com/users/machadaCosta/events{/privacy}",
    "received_events_url": "https://api.github.com/users/machadaCosta/received_events",
    "type": "User",
    "site_admin": false
    },
    "private": false,
    "html_url": "https://github.com/machadaCosta/bachamada",
    "description": "This project is about monitoring Heart Rate, in Beat Per Minute (BPM), with an Android App.",
    "fork": false,
    "url": "https://api.github.com/repos/machadaCosta/bachamada",
    "forks_url": "https://api.github.com/repos/machadaCosta/bachamada/forks",
    "keys_url": "https://api.github.com/repos/machadaCosta/bachamada/keys{/key_id}",
    "collaborators_url": "https://api.github.com/repos/machadaCosta/bachamada/collaborators{/collaborator}",
    "teams_url": "https://api.github.com/repos/machadaCosta/bachamada/teams",
    "hooks_url": "https://api.github.com/repos/machadaCosta/bachamada/hooks",
    "issue_events_url": "https://api.github.com/repos/machadaCosta/bachamada/issues/events{/number}",
    "events_url": "https://api.github.com/repos/machadaCosta/bachamada/events",
    "assignees_url": "https://api.github.com/repos/machadaCosta/bachamada/assignees{/user}",
    "branches_url": "https://api.github.com/repos/machadaCosta/bachamada/branches{/branch}",
    "tags_url": "https://api.github.com/repos/machadaCosta/bachamada/tags",
    "blobs_url": "https://api.github.com/repos/machadaCosta/bachamada/git/blobs{/sha}",
    "git_tags_url": "https://api.github.com/repos/machadaCosta/bachamada/git/tags{/sha}",
    "git_refs_url": "https://api.github.com/repos/machadaCosta/bachamada/git/refs{/sha}",
    "trees_url": "https://api.github.com/repos/machadaCosta/bachamada/git/trees{/sha}",
    "statuses_url": "https://api.github.com/repos/machadaCosta/bachamada/statuses/{sha}",
    "languages_url": "https://api.github.com/repos/machadaCosta/bachamada/languages",
    "stargazers_url": "https://api.github.com/repos/machadaCosta/bachamada/stargazers",
    "contributors_url": "https://api.github.com/repos/machadaCosta/bachamada/contributors",
    "subscribers_url": "https://api.github.com/repos/machadaCosta/bachamada/subscribers",
    "subscription_url": "https://api.github.com/repos/machadaCosta/bachamada/subscription",
    "commits_url": "https://api.github.com/repos/machadaCosta/bachamada/commits{/sha}",
    "git_commits_url": "https://api.github.com/repos/machadaCosta/bachamada/git/commits{/sha}",
    "comments_url": "https://api.github.com/repos/machadaCosta/bachamada/comments{/number}",
    "issue_comment_url": "https://api.github.com/repos/machadaCosta/bachamada/issues/comments{/number}",
    "contents_url": "https://api.github.com/repos/machadaCosta/bachamada/contents/{+path}",
    "compare_url": "https://api.github.com/repos/machadaCosta/bachamada/compare/{base}...{head}",
    "merges_url": "https://api.github.com/repos/machadaCosta/bachamada/merges",
    "archive_url": "https://api.github.com/repos/machadaCosta/bachamada/{archive_format}{/ref}",
    "downloads_url": "https://api.github.com/repos/machadaCosta/bachamada/downloads",
    "issues_url": "https://api.github.com/repos/machadaCosta/bachamada/issues{/number}",
    "pulls_url": "https://api.github.com/repos/machadaCosta/bachamada/pulls{/number}",
    "milestones_url": "https://api.github.com/repos/machadaCosta/bachamada/milestones{/number}",
    "notifications_url": "https://api.github.com/repos/machadaCosta/bachamada/notifications{?since,all,participating}",
    "labels_url": "https://api.github.com/repos/machadaCosta/bachamada/labels{/name}",
    "releases_url": "https://api.github.com/repos/machadaCosta/bachamada/releases{/id}",
    "created_at": "2015-07-30T07:08:22Z",
    "updated_at": "2015-08-07T13:34:41Z",
    "pushed_at": "2015-10-17T14:27:40Z",
    "git_url": "git://github.com/machadaCosta/bachamada.git",
    "ssh_url": "git@github.com:machadaCosta/bachamada.git",
    "clone_url": "https://github.com/machadaCosta/bachamada.git",
    "svn_url": "https://github.com/machadaCosta/bachamada",
    "homepage": null,
    "size": 2144,
    "stargazers_count": 1,
    "watchers_count": 1,
    "language": "Java",
    "has_issues": true,
    "has_downloads": true,
    "has_wiki": true,
    "has_pages": false,
    "forks_count": 0,
    "mirror_url": null,
    "open_issues_count": 1,
    "forks": 0,
    "open_issues": 1,
    "watchers": 1,
    "default_branch": "master"
    },
    ...
    }
    ]


Afin de modéliser un objet répertoire renvoyé par le serveur, il faut créer une classe JAVA représentant l'objet. Par exemple, la classe **_Repo_** :


    class Repo {

        final String name;

        public Repo(String name) {
            this.name = name;
        }
    }


Avec l'attribut de classe _name_ correspondant à un élément de la réponse du serveur.

## Faire la requête HTTP GET

  1. Créer l'interface JAVA listant les requêtes à réaliser, ici nous déclarons une seule requête HTTP GET, _listRepos_ :


    public interface GitHubService {
        @GET("/users/{user}/repos")
        Call<List<Repo>> listRepos(@Path("user") String user);
    }


**Note** : En début de méthode, figure ce qui est attendu du serveur dans un Call, soit une liste de **_Repo_**, _Call<List<Repo>>_. En paramètre de méthode, est placé le(s) paramètre(s) pour la requête, soit l'utilisateur [GitHub](https://api.github.com/).
