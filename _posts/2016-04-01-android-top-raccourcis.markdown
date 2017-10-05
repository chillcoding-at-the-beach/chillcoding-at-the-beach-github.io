---
title: "Top 6 des raccourcis dans Android Studio"
categories: coding android fr
author: macha
---

<div class="text-center lead" markdown="1">
  ![Android Configuration](/assets/img/post/android-config.png)
</div>

Cet article présente une sélection de raccourcis clavier sur Android Studio pour augmenter votre rapidité de développement.

1. Aller sur la classe ou l'élément : Cmd/Ctrl+click sur l'élément
2. Indenter le code et revoir les imports : Cmd/Ctrl+Alt+L
3. Renommer une variable : Shift+F6
4. Auto-Générateur de getter/setter, constructeur, méthodes surchargées : Cmd/Ctrl+N
5. Auto-complétion : Cmd/Ctrl+Space
6. Correction automatique : se placer sur la ligne, Alt+Enter

Remarque : Il est possible de voir tous les raccourcis à partir d'Android Studio > Preferences > Keymap.

Pour aller plus loin : Afin d'augmenter ses performances, il est préconisé de re-construire, Builder, votre projet Android, le moins souvent possible. En effet, le processus de construction des fichiers exécutables (.dex) prend du temps. Pour éviter de re-construire votre projet, il faut utiliser au maximum l'outils de visualisation d'Android Studio, soit la preview des fichiers xml (cf. Android Developer Perf Matters).

Source :
[Android Studio Tips and Tricks](https://developer.android.com/sdk/installing/studio-tips.html)
[Android Developer Perf Matters](https://robots.thoughtbot.com/developer-perf-matters)
