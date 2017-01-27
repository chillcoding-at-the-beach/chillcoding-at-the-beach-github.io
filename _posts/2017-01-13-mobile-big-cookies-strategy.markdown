---
title:  "Big Cookie Strategy"
category: coding
---

![Big Cookie Strategy in Mobile Development](/img/post/mobile-server.png)

This post is about the Big Cookie Strategy in particular the Big Cookie Model. Aim is to optimise exchange between a server and a mobile application. It's has been elaborate based on real life study case, far away of perfect development context where connectivity is very high quality.

## What is Big Cookie Strategy ?

![Big Cookie Strategy in Mobile Development](/img/post/big-cookie-strategy.png)

Step by step:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-mobile" aria-hiden="true"></i> Mobile verify availability of connection: <i class="fa fa-exclamation-triangle" aria-hiden="true"></i> <i class="fa fa-plane" aria-hiden="true"></i> and then connectivity state: <i class="fa fa-signal" aria-hiden="true"></i> Edge, 3G or <i class="fa fa-wifi" aria-hiden="true"></i> Wifi

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-exchange" aria-hiden="true"></i> Mobile ask needed data to server with the connectivity state in user agent

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-server" aria-hiden="true"></i> Server send prefetch data in terms of connectivity: <i class="fa fa-database" aria-hiden="true"></i> ( <i class="fa fa-wifi" aria-hiden="true"> | 3G | </i> <i class="fa fa-signal" aria-hiden="true"></i> )

All the tricks reside in fact that server send data set which size depends on connectivity state of the mobile.
For instance, here is a data set proposal in terms of connectivity:

| Connectivity | Example of Data Set |
| ------------ | ---------------- |
| <i class="fa fa-signal" aria-hiden="true"></i> Edge | Info since one or two hours |
| **3G** or 4G | Info since 3 days |
| <i class="fa fa-wifi" aria-hiden="true"></i> Wifi | Info since 15 days | 




## <i class="fa fa-globe" aria-hiden="true"></i> Resources :

* [Gerardnico, 2016 - Data Transfert by Gerardnico](http://gerardnico.com/wiki/android/data_transfer)
* [Ralp Pina, 2015 - Efficient data transfer in Android (Slides)](http://www.slideshare.net/CotapEng/efficient-data-transfer-tech-talk)
* [Staff with Alexandre Gerber, 2011 - A Call for More Energy-Efficient Apps (Article)](http://www.research.att.com/articles/featured_stories/2011_03/201102_Energy_efficient?fbid=HZjMhQoG88-)
