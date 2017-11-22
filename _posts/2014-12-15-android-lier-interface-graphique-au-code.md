---
title: "Android : Lier une interface graphique au code"
categories: fr coding tutoriel android-vue
author: macha
---

<div class="text-center lead" markdown="1">
  ![Android Vue](/assets/img/post/android-view.png)
</div>

Une app. Android est principalement composé d'**Activity** et de **Fragment** placés dans le dossier src/ du projet. Par défaut, l'**Activity** _MainActivity_, créé par l'IDE (Integrated Development Environment, ex : Android Studio), est lancé au démarrage de l'app. Ceci est configuré dans le fichier **Manifest**.

Une **Activity** est un composant Android, il possède un cycle de vie (création, pause, destruction en bref). Chaque étape du cycle de vie correspond à une méthode java, la plus importante est la méthode_ onCreate() _appelé à la création de l'**Activity**, elle se charge d'initialiser l'écran, la vue, et autres objets utilisés.

Un **Fragment** est une sorte de _sub-Activity, _il possède également un cycle de vie, calé sur celui de l'**Activity** à laquelle il est attaché. D'ailleurs, une **Activity **peut contenir plusieurs **Fragment**s.

Note : Ce composant a été introduit dans la version 2.3 d'Android afin d'optimiser la programmation sur tablette (cf. [site de référence](http://developer.android.com/guide/components/fragments.html)).

<!--more-->

## A] Activity & View

Chaque **Activity** est associé à un écran, soit une interface graphique, communément appelée une vue (i. e **View**). Concrètement dans le code java, l'**Activity** est attachée à la vue dans la méthode _onCreate()_ de la façon suivante :


    onCreate(...){
    setContentView(mView);
    ..}

* avec :


    mView=R.layout.myLayout;

Note : _myLayout_ correspond à un fichier xml placé dans le dossier res/layout.

* ou bien avec :


    mView = new MaClasseJavaQuiExtendsView(params);

Note : _MaClasseJavaQuiExtendsView_ est une classe java qui étend la classe **View** et elle est placé dans le dossier src/.

## B] Fragment & View

Chaque **Fragment** peut être associer à une **View**. Concrètement dans le code java, le **Fragment** est attachée à la vue dans la méthode _onCreateView()_ de la façon suivante :


    onCreateView(...){
    View view = inflater.inflate(mView, container, false);
    return view;
    ...}

Pour en savoir plus sur les vues : [Article créer une vue personnalisée sous Android](/blog/2014/10/11/vue-personnalisee-custom-view/)
