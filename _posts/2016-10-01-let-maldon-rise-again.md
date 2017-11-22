---
title: "Let Maldòn rise again!"
categories: en coding tutoriel web elixir phoenix
author: remy
date: 2016-10-01 14:00
---

{{ page.url | originally_posted_on_rymai_blog }}

I have a project on my mind for some time now. The project is to rewrite the
Maldòn application ([maldon.io](http://maldon.io)) –which was initially
developed in PHP for an internal Dailymotion hackathon in 2 days– with a new Web
stack I want to try.

<!--more-->

### What is Maldòn?

<img class="full" src="https://d1yjw8g5csx279.cloudfront.net/blog/maldon/home.jpg"
  alt="Maldòn home page" title="Maldòn home page" />

Maldòn is a website where you can "Watch your songs", in other words, you can
import your musical playlists from your favorite music services (Spotify,
Deezer, Last.fm etc.), and get to watch their associated music video.

### What is this new Web stack?

Without more suspense, the stack we will be using is as follow:

- Elixir & OTP
- The Phoenix framework
- A modern frontend framework such as VueJS or React (this is still to decide)
- GitLab as our code hosting and versioning, Continuous Integration, and
  Continuous Delivery solution

### Why rewriting a working application?

The rewrite is mostly an excuse to explore Elixir & OTP, Phoenix and VueJS/React
in a real-world project that’s already in production. That said, the application
does not scale very well, for instance the playlists, songs and videos fetching
is done synchronously, leading to very long page load time after you sign up and
the application needs to import your playlists and fetch their associated
videos. By leveraging Elixir, OTP, and Phoenix channels, the goal is to provide
a much smoother user experience!

### What is the plan?

The plan is to blog everything I do, from the start to the end, and to create a
merge request for each blog post so that you can follow along:

1. [Create the project, host it on GitLab and setup automated testing]
1. Develop the backend, probably transforming it into an umbrella application
1. Develop the frontend to offer a user-friendly experience using Phoenix
  channels and VueJS/React
1. Deploy the application manually
1. Automate the deployment of the application using GitLab

I will heavily rely on what I learned in the awesome [Programming Phoenix] book.

I don't know yet how many posts I will do, but probably a lot. That will for
sure be a very interesting adventure in which I will learn a lot, and I hope you
will too!

Stay tuned for the first blog post in which I will create and setup the basis
for this project.

[Programming Phoenix]: https://pragprog.com/book/phoenix/programming-phoenix
[Create the project, host it on GitLab and setup automated testing]: /blog/2016/10/02/bootstrapping-the-maldon-project/
