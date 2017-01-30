---
title:  "Big Cookie Strategy"
category: coding
author: machadacosta
---

![Big Cookie Strategy in Mobile Development](/img/post/mobile-server.png)

This post is about the Big Cookie Strategy in particular the Big Cookie Model. The goal is to optimise exchange between a server and a mobile application. It has been elaborated based on real life study case, far away of perfect development context where connectivity is of very high quality.

## What is Big Cookie Strategy?

![Big Cookie Strategy in Mobile Development](/img/post/big-cookie-strategy.png)

Step by step:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-mobile" aria-hiden="true"></i> Mobile verifies availability of connection: <i class="fa fa-exclamation-triangle" aria-hiden="true"></i> <i class="fa fa-plane" aria-hiden="true"></i> and then connectivity state: <i class="fa fa-signal" aria-hiden="true"></i> Edge, 3G or <i class="fa fa-wifi" aria-hiden="true"></i> Wifi

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-exchange" aria-hiden="true"></i> Mobile asks needed data to server with the connectivity state in user agent

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa fa-server" aria-hiden="true"></i> Server sends prefetch data depending on the connectivity: <i class="fa fa-database" aria-hiden="true"></i> ( <i class="fa fa-wifi" aria-hiden="true"> | 3G | </i> <i class="fa fa-signal" aria-hiden="true"></i> )

The trick resides in the fact that the size of data set sent by the server depends on the connectivity state of the mobile device.
For instance, following are different data set depending on the connectivity:

| Connectivity | Example of Data Set |
| ------------ | ---------------- |
| <i class="fa fa-signal" aria-hiden="true"></i> Edge | Info since one or two hours |
| **3G** or 4G | Info since 3 days |
| <i class="fa fa-wifi" aria-hiden="true"></i> Wifi | Info since 15 days | 




## <i class="fa fa-globe" aria-hiden="true"></i> Resources:

* [Gerardnico, 2016 - Data Transfert by Gerardnico](http://gerardnico.com/wiki/android/data_transfer)
* [Ralp Pina, 2015 - Efficient data transfer in Android (Slides)](http://www.slideshare.net/CotapEng/efficient-data-transfer-tech-talk)
* [Staff with Alexandre Gerber, 2011 - A Call for More Energy-Efficient Apps (Article)](http://www.research.att.com/articles/featured_stories/2011_03/201102_Energy_efficient?fbid=HZjMhQoG88-)
