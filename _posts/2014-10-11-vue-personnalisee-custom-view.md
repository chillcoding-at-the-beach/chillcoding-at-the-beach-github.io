---
title: "Créer une vue personnalisée sous Android (Custom View)"
categories: coding android tutoriel fr
author: macha
---

Dans ce tutoriel, il est expliqué comment créer une simple vue (**View**) personnalisée sous _Android_.

_**Pré-requis :**_ notion sur l'**Activity** et le **Fragment**

_**Objectif :**_ créer une classe de type **View**, dessinant une image ou un cercle à l'écran.

## A] View, quesaco? 

Une **View** est soit défini dans un fichier _xml_, contenu dans le dossier
`res/drawable/layout` soit dans un fichier _java_ contenu dans le dossier
`src/_package/`. D'un côté, elle est formatée par les éléments de librairies
_Android,_ tels que le **LinearLayout **ou le **RelativeLayout** (agencement) et
tels que le **TextView **ou le **Button** (éléments graphiques). D'un autre côté,
elle est personnalisée par la modification du **Canvas** de la **View** via
l'utilisation d'un **Paint**. Le **Canvas** représente une feuille de dessin,
tandis que le **Paint** représente un pinceau.

## B] Comment créer une View en java? 

Tout d'abord, il s'agit de créer une classe _java_, `MyView`, qui étend **View**
(`extends View` avec `import android.view.View`) et qui implémente :

\- un constructeur :

    public MyView(Context context, AttributeSet attrs)

\- une méthode `onLayout` :

    protected void onLayout(boolean changed, int left, int top, int right, int bottom)

\- une méthode `onDraw` : 

    protected void onDraw(Canvas canvas)

Ensuite, le constructeur contient les initialisations des objets utilisés dans
la méthode `onDraw` (par exemple un **Paint**). Puis, la méthode `onLayout`
contient les initialisations des coordonnées en fonction des dimensions de la
**View**. Enfin, la méthode** `onDraw` prend en paramètre le **Canvas** de la
**View**. Tout ce qui sera dessiner dans le **_Canvas_** sera alors représenté
dans la **View** correspondante. Le **Canvas** est inscrit dans un repère dont
l'origine correspond au coin haut gauche de la **View**, l'objet **Paint**
permet de dessiner dedans. Ce dernier peut être considéré comme un pinceau, il
possède une couleur et une taille.

## C] Comment dessiner un cercle, avec une couleur personnalisée, dans une View? 

1\. Dans le fichier `res/values/colors.xml`, déclarez une couleur exceptionnelle :

    <color name="mygreen"> #2ecc71</color >

2\. Dans la classe `MyView`, déclarez un **Paint** (un pinceau) :

     Paint paint;

, et les coordonnées du cercle :

     int mX, mY, mRadius;

3\. Dans le constructeur de `MyView`, initialisez le `paint` :

     paint= new Paint();

Assignez lui la couleur exceptionnelle :

     paint.setColor(getResources().getColor(R.color.gray));

4\. Dans la méthode `onLayout`, initialisez les coordonnées du cercle :

     mX=getWidth()/2; mY=getHeight()/2; mRadius=getWidth()/3;

5\. Dans le **_Canvas_** de la méthode `onDraw`, dessinez le cercle :

    canvas.drawCircle(mX, mY, mRadius, paint);

## D] Comment dessiner une image dans une View ?

1\. Dans le fichier `res/drawable/`, insére
 une image exceptionnelle (pensez à reduire sa taille, avec [tinypng](https://tinypng.com/) par exemple) : `waouh.png`

2\. Dans la classe `MyView`, déclarez un **Paint** (un pinceau) :

    Paint paint;

_  une **Bitmap** :

     Bitmap mImgWaouh;

et les coordonnées de l'image :

    int mX, mY;

3\. Dans le constructeur de `MyView`, initialisez le `paint` :

    paint= new Paint();

initialisez l'image :

    mImgWaouh = BitmapFactory.decodeResource(getResources(),R.drawable.waouh);

4\. Dans la méthode `onLayout`, initialisez les coordonnées de l'image :

    mX=getWidth()/2; mY=getHeight()/2;
