---
title: "Créer une vue animée sous Android (Custom View : the best part)"
categories: coding android vue fr
author: macha
---

<div class="text-center lead" markdown="1">
  ![Android HTTP Request](/assets/img/post/android-view.png)
</div>

Dans ce tutoriel, il est expliqué comment créer une simple vue (**View**)
personnalisée et animée sous _Android_.

_**Pré-requis :**_ notion sur l'**Activity**, **Fragment** et la **View**
(cf. [Créer une vue personnalisée sous Android](/blog/2014/10/11/vue-personnalisee-custom-view/))

_**Objectif :**_ créer une classe de type **View** présentant des objets animés.

## A] Runnable, quesaco?

Un **Runnable** est un objet qui implémente une méthode _run_ appelée
régulièrement lors de l'exécution de l'application. Ici, on s'en sert pour
appeler régulièrement la méthode _onDraw_ d'une **View** , via l'appel de la
méthode _invalidate_ explicitant que la vue est invalide. Ainsi, il est possible
d'animer les objets dessinés dans la **View**.

## B] Comment créer une View animée en java?

Tout d'abord, il s'agit de créer une classe _java_, _**MyView**_,_ qui étend **View **(`extends View` avec `import android.view.View`) et qui implémente :

\- un constructeur :


     public MyView(Context context, AttributeSet attrs)

\- un **Runnable** : 


    Runnable animator = new Runnable() {@Override public void run()

\- une méthode _onLayout _:


    protected void onLayout(boolean changed, int left, int top, int right, int bottom)

\- une méthode _update_ :


    protected void update()

\- une méthode _onDraw _:


    protected void onDraw(Canvas canvas)

\- une méthode _isAtRest_ : 


    protected boolean isAtRest()

Ensuite, le constructeur contient les initialisations des objets utilisés dans la méthode _onDraw _(par exemple un **Paint** et des coordonnées). Puis, la méthode _onLayout _contient les initialisations des coordonnées en fonction des dimensions de la **View**. La méthode _update _met à jour les coordonnées de l'objet à animer. Enfin, la méthode** **_onDraw_ prend en paramètre le **Canvas** de la **View**. Tout ce qui sera dessiner dans le **Canvas** sera alors représenté dans la **View** correspondante. Le **Canvas** est inscrit dans un repère dont l'origine correspond au coin haut gauche de la **View**,** **l'objet **Paint** permet de dessiner dedans. Ce denier peut être considéré comme étant un pinceau, il possède une couleur et une taille. Finalement la méthode _isAtRest_ renvoit _true_ si l'animation est fini _false_ sinon.

## C] Comment dessiner une boule animée dans une View?

1\. Dans le fichier `res/values/colors.xml`, déclarez une couleur exceptionnelle:

    <color name="mygreen" >#2ecc71</color>

2\. Dans la classe **_MyView_**, déclarez un **Paint** (un pinceau) :

    Paint paint;

les coordonnées de la boule et les dimensions de la **View** :

     int mX, mY, mRadius, mHeight, mWidth;

et un **Runnable** :

    private Runnable animator = new Runnable() {
      @Override
      public void run() {
        update();
        invalidate();
        if(!isAtRest()) {
          postDelayed(this,14);
        }
      }
    };

3\. Dans le constructeur de _**MyView**_, initialisez le `paint` :

    paint= new Paint();

Assignez lui la couleur exceptionnelle :

    paint.setColor(getResources().getColor(R.color.gray));
    Changez lui de style : paint.setStyle(Paint.Style.FILL);

4\. Dans la méthode `onLayout`, initialisez les coordonnées du cercle et les dimensions de la **View** :

     mHeight=getHeight(); mWidth=getWidth(); mRadius=mWidth/8; mX=mRadius/2; mY=mRadius/2;

5\. Dans la méthode `update`, mettez à jour les coordonnées :

    mX+=1; mY+=1;

6\. Dans le **Canvas** de la méthode `onDraw`, dessinez le cercle :

    canvas.drawCircle(mX, mY, mRadius, paint);

7\. Dans la méthode `isAtRest`, vérifiez que la boule n'a pas encore atteint les limites de la **View** :

    if(mX<mWidth && mY<mHeight) return false;
    else return true;
