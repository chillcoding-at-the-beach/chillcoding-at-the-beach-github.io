---
title: "Android : Introduction à Kotlin"
categories: fr coding tutoriel android kotlin
author: macha
---

<div class="text-center lead" markdown="1">
  ![Android Kotlin](/assets/img/post/android-kotlin.png)
</div>

Le bruit des vagues, le sable fin, les pieds dans l'eau, le soleil sur la peau, ma vidéo sur l'introduction du langage _Kotlin_ dans _Android_ s'est réalisée dans ces conditions.

<iframe width="800" height="450" src="https://www.youtube.com/embed/mrJmVjsJlYU" frameborder="0" allowfullscreen></iframe>

<!--more-->

## Kotlin is here!

Le G des GAFA a officialisé le support du langage _Kotlin_ pour le développement d'application mobile _Android_, cette année 2017, à la fameuse conférence G I/O, les 17-19 mai 2017.

Dans cet article, nous donnerons des éléments de réponses à la question [Pourquoi Kotlin ?](#pourquoi). Aussi, ce langage sera décrit [en bref](#kotlin). Puis, nous verrons son [support dans Android Studio](#android-studio). Enfin, nous nous interrogerons sur l'[avenir d'_Android_](#next).

## <a name="pourquoi"></a>{% icon fa-google %} Pourquoi Kotlin ?

**Mais pourquoi est-il aussi méchant ?** Si vous ne connaissez pas cette référence, je vous invite à aller voir [cette vidéo](https://www.youtube.com/watch?v=EHY4I29jxjo){:target="_blank"} :)

Jusqu'à présent, _Android_ utilise la technologie *Java*, initialement développée par *Sun Microsystems*, en 1995. L'avantage de cette technologie est de faire fonctionner un code, écrit en *Java*, de manière identique sur n'importe quel système d'exploitation (*Linux*, *Windows* ou *macOS*), ceci grâce à la machine virtuelle JVM.

Les applications mobiles _Android_ évoluaient dans le meilleur des mondes jusqu'au jour où *Oracle* racheta *Java* en 2009. Ce dernier mena une guerre sans merci au géant de la Montain View, plaidant : les API *Java* sont soumises à la protection de la propriété intellectuelle !
Google a dû épurer _Android_ des implémentations commercialisées par *Oracle* [\[2\]](#oracle). Cela a commencé avec *Lollipop* 🍭 en remplacant la machine virtuelle *Davlik* par *Android Runtime*. Et cela se poursuit avec le support du langage de programmation _Kotlin_ dans _Android Studio 3_.

![Android loves Apple](/assets/img/post/android-loves-apple.png "Android aime Apple")

En outre, depuis ses débuts _Android_ copie *Apple*. Le langage *Swift* a été introduit dans les développements *iOS* à la WWDC 2014. Il a rapidement eu un succès au détriment de l'*Objective-C* [\[11\]](#objc). Il n'est donc pas étonnant qu'_Android_ introduise, à son tour, un langage spécifique pour ses développements d'applications et bizarrement, _Kotlin_ ressemble étrangement à *Swift* [\[6\]](#swift).

Enfin, toutes ses histoires de guerre et d'amour force les développeurs _Android_ à sortir de leur zone de confort. En effet, il s'agit de faire une croix sur nos connaissances *Java* pour découvrir un langage merveilleusement prometteur. Cela dit, les acquis sur le SDK _Android_ sont beaucoup plus important que la connaissance d'un langage de programmation.

## <a name="kotlin"></a>{% icon fa-code %} Kotlin en bref

Tout d'abord, _Kotlin_ est un langage de programmation orienté objet et fonctionnel. Il porte le nom d'une île proche de Saint Pétersbourg, la ville où est basée l’équipe de *JetBrains* impliquée dans le développement de ce langage. Cette société a également développer l'IDE (Integrated Development Environment) *IntelliJ*, sur lequel est basé *Android Studio*. *JetBrains* est réputé pour réaliser des produits de qualité.

En bref, voici quelques unes des vertues de _Kotlin_ :

{% icon fa-paperclip %} Langage peu verbeux : `;` <i class="fa  fa-long-arrow-right" aria-hidden="true"></i> 💚

{% icon fa-paperclip %} Langage clair et concis : ~~getter/setter~~, accès direct aux attributs, etc.

{% icon fa-paperclip %} Affranchissement du `NullPointerException`

{% icon fa-paperclip %} Interpollation de chaines de charactère : `Log.i(TAG, "my width is $mWidth")`

{% icon fa-paperclip %} Déclaration de variables simplifiée : soit `val` soit `var`

{% icon fa-paperclip %} Conversion de type automatique : `val mWidth = 0`

Concrètement, pour avoir une démonstration du langage _Kotlin_, il suffit de se rendre dans la partie *TRY* du [site officiel](https://try.kotlinlang.org){:target="_blank"}. Puis, vous trouverez des exercices cool dans *Kotlin Koans*.

Et si vous désirez des news sur _Kotlin_, rejoignez le slack [{% icon fa-slack %} kotlinlang](http://slack.kotlinlang.org/) ou suivez [{% icon fa-twitter %} @kotlin](https://twitter.com/kotlin).


## <a name="android-studio"></a>{% icon fa-android %} Android et Kotlin

*AS 3* est sorti, en version de prévisualisation, tout juste pour la G I/O 2017 [\[9\]](#as3). Il supporte le langage _Kotlin_. L'avantage est qu'il peut être installé en parallèle d'une version existante d'*AS*. Les versions stable et *Canary* d'*AS* partagent alors les dossiers d'installation (*SDK Android* et préférences).

D'ailleurs, voici les principaux atouts du support de _Kotlin_ dans *AS 3* :

{% icon fa-paperclip %} Cohabitation du code *Java* et _Kotlin_

{% icon fa-paperclip %} Conversion automatique du code *Java* vers _Kotlin_ : `Ctrl+C` de code _Java_ `Ctrl+V` dans un fichier _.kt_ ou [Convertir un fichier Java en Kotlin](#convert)


### Créer un projet Kotlin

1. Dans *AS 3*, créer un nouveau projet : `Start a new Android Studio project`.
2. Cocher la case `Include Kotlin support`, si ce n'est pas déjà le cas.
3. Cliquer sur `Next` puis configurer le projet à votre guise.

### <a name="convert"></a> Convertir un fichier Java en Kotlin

Aller dans le menu `Code > Convert Java File to Kotlin File`

## <a name="next"></a>{% icon fa-calendar %} What is next ?

Dans l’immédiat, on peut s'attendre à rien parce que c'est l'été. Cela dit la version 8 d’_Android_ devrait sortir en octobre comme les précédentes versions d'_Android_ depuis 2013.
En général, la sortie d’une nouvelle version n’arrive jamais seule. Elle est souvent accompagnée d'une mise à jour majeure d’*Android Studio*. Pour la rentrée, en octobre, novembre, on peut donc s’attendre à *AS 3* en version stable.

Concernant le nom de la prochaine version O d'_Android_, je parie sur *Orange Cake* 🍊 et vous ? N’hésitez pas à commenter cet article ou la [{% icon fa-youtube %} vidéo](https://youtu.be/mrJmVjsJlYU){:target="_blank"} pour faire vos propositions. En outre, la présentation correspondante [{% icon fa-slideshare %} Android - Introduction à Kotlin](https://www.slideshare.net/MachaDACOSTA/android-introduction-kotlin){:target="_blank"} est disponible sur *SlideShare*.

En attendant la rentrée je vous souhaite à tous un bel été !

## <a name="references"></a>{% icon fa-globe %} Références :
1. [Langage Java](https://fr.wikipedia.org/wiki/Java_%28langage%29)
2. <a name="oracle"></a>[API Java : Google a enfreint les brevets d’Oracle, selon la Cour Suprême](http://www.linformaticien.com/actualites/id/37221/categoryid/25/api-java-google-a-enfreint-les-brevets-d-oracle-selon-la-cour-supreme.aspx)
3. [Android 7 : OpenJDK remplacera les API Java](http://www.linformaticien.com/actualites/id/39052/categoryid/18/android-7-openjdk-remplacera-les-api-java.aspx)
4. [Kotlin: pourquoi ce nouveau langage est une bonne nouvelle](http://www.frandroid.com/android/developpement/427433_kotlin-pourquoi-ce-nouveau-langage-est-une-bonne-nouvelle)
5. [Introduction to Kotlin - Google I/O '17](https://www.youtube.com/watch?v=X1RVYt2QKQE)
6. <a name="swift"></a>[Swift is like Kotlin](http://nilhcem.com/swift-is-like-kotlin/)
7. [Kotlin site](https://kotlinlang.org/)
8. [Kotlin it's the little things](https://m.signalvnoise.com/kotlin-its-the-little-things-8c0f501bc6ea)
9. <a name="as3"></a>[Android Studio 3.0 Canary 1](https://android-developers.googleblog.com/2017/05/android-studio-3-0-canary1.html)
10. [Android developper: Get started with Kotlin on Android](https://developer.android.com/kotlin/get-started.html)
11. <a name="objc"></a>[Apple : la fin d’Objective-C au profit de SWIFT ?](http://www.ip-label.fr/performance-wire/apple-la-fin-dobjective-c-au-profit-de-swift/)

*[JVM]: Java Virtual Machine
*[WWDC]: World Wide Developer Conference
*[AS]: Android Studio
*[GAFA]: Google Apple Facebook Amazon
