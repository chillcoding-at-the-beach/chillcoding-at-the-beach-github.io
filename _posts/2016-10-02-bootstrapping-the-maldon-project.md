---
title: "Bootstrapping the Maldòn project"
categories: en coding tutorial web elixir phoenix
author: remy
date: 2016-10-02 00:00
---

{{ page.url | originally_posted_on_rymai_blog }}

In this first post of the [Let Maldòn rise again!] post series, we will:

1. [Create the Phoenix project](#create-the-phoenix-project)
1. [Host it on GitLab](#host-it-on-gitlab)
1. [Ensure tests are green](#ensure-tests-are-green)
1. [Set up continuous integration using GitLab CI](#set-up-continuous-integration-using-gitlab-ci)

[Let Maldòn rise again!]: /blog/2016/10/01/let-maldon-rise-again

<!--more-->

### <a name="create-the-phoenix-project"></a> 1. Create the Phoenix project

Let's start working on Maldòn by creating the Phoenix application:

1. Install latest Hex:

        › mix local.hex

1. Install the Phoenix Mix archive:

        › mix archive.install \
        https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez

1. Be sure to have Node.js and PostgreSQL installed.

1. Bootstrap the application:

        › mix phoenix.new maldon
        * creating maldon/config/config.exs
        * creating maldon/config/dev.exs
        * creating maldon/config/prod.exs
        * creating maldon/config/prod.secret.exs
        * creating maldon/config/test.exs
        * creating maldon/lib/maldon.ex
        * creating maldon/lib/maldon/endpoint.ex
        * creating maldon/test/views/error_view_test.exs
        * creating maldon/test/support/conn_case.ex
        * creating maldon/test/support/channel_case.ex
        * creating maldon/test/test_helper.exs
        * creating maldon/web/channels/user_socket.ex
        * creating maldon/web/router.ex
        * creating maldon/web/views/error_view.ex
        * creating maldon/web/web.ex
        * creating maldon/mix.exs
        * creating maldon/README.md
        * creating maldon/web/gettext.ex
        * creating maldon/priv/gettext/errors.pot
        * creating maldon/priv/gettext/en/LC_MESSAGES/errors.po
        * creating maldon/web/views/error_helpers.ex
        * creating maldon/lib/maldon/repo.ex
        * creating maldon/test/support/model_case.ex
        * creating maldon/priv/repo/seeds.exs
        * creating maldon/.gitignore
        * creating maldon/brunch-config.js
        * creating maldon/package.json
        * creating maldon/web/static/css/app.css
        * creating maldon/web/static/css/phoenix.css
        * creating maldon/web/static/js/app.js
        * creating maldon/web/static/js/socket.js
        * creating maldon/web/static/assets/robots.txt
        * creating maldon/web/static/assets/images/phoenix.png
        * creating maldon/web/static/assets/favicon.ico
        * creating maldon/test/controllers/page_controller_test.exs
        * creating maldon/test/views/layout_view_test.exs
        * creating maldon/test/views/page_view_test.exs
        * creating maldon/web/controllers/page_controller.ex
        * creating maldon/web/templates/layout/app.html.eex
        * creating maldon/web/templates/page/index.html.eex
        * creating maldon/web/views/layout_view.ex
        * creating maldon/web/views/page_view.ex

        Fetch and install dependencies? [Yn] Y
        * running mix deps.get
        * running npm install && node node_modules/brunch/bin/brunch build

        We are all set! Run your Phoenix application:

            $ cd maldon
            $ mix phoenix.server

        You can also run your app inside IEx (Interactive Elixir) as:

            $ iex -S mix phoenix.server

        Before moving on, configure your database in config/dev.exs and run:

            $ mix ecto.create

### <a name="host-it-on-gitlab"></a> 2. Host it on GitLab

#### Create the project on GitLab

Now, before doing anything in the project itself, we will host it on GitLab so
that we're set up for the rest of our journey!

Let's head over to [https://gitlab.com/projects/new], I will create the project in
the [ChillCoding](https://gitlab.com/groups/chillcoding-at-the-beach) group:

<img class="full" src="https://d1yjw8g5csx279.cloudfront.net/blog/maldon/maldon-1/new-project-form.png"
  alt="New project form on GitLab" title="New project form on GitLab" />

At this point we have an empty project:

<img class="full" src="https://d1yjw8g5csx279.cloudfront.net/blog/maldon/maldon-1/empty-project.png"
  alt="Empty project on GitLab" title="Empty project on GitLab" />

I will click the "LICENSE" link and use the predefined "MIT License" template:

<img class="full" src="https://d1yjw8g5csx279.cloudfront.net/blog/maldon/maldon-1/add-license-form.png"
  alt="Add a MIT license on GitLab" title="Add a MIT license on GitLab" />

[Check this license out](https://gitlab.com/chillcoding-at-the-beach/maldon/blob/master/LICENSE)!

I added a license file mostly to have a non-empty repo with an initial commit in
its default (`master`) branch.

[https://gitlab.com/projects/new]: https://gitlab.com/projects/new

#### Init the local Git setup

Now, all we have to do is go into the project directory, init Git and add the
GitLab remote:

    › cd maldon

    › git init
    Initialized empty Git repository in /Users/remy/Code/ChillCoding/maldon/.git/

    › git remote add origin git@gitlab.com:chillcoding-at-the-beach/maldon.git

That being done, we won't push all the code to `master`; instead we will work in
a new branch and submit a merge request when we're ready:

    › git fetch --all # I have a `fa` alias for that!
    remote: Counting objects: 3, done.
    remote: Compressing objects: 100% (2/2), done.
    remote: Total 3 (delta 0), reused 0 (delta 0)
    Unpacking objects: 100% (3/3), done.
    From gitlab.com:chillcoding-at-the-beach/maldon
     * [new branch]      master     -> origin/master

    › git checkout -b setup-ci origin/master # I have a `cob` alias for that!
    Switched to a new branch 'setup-ci'

### <a name="ensure-tests-are-green"></a> 3. Ensure tests are green

Before we can push, the first thing is to have our test suite pass. Let's see:

    › mix test
    ==> connection
    Compiling 1 file (.ex)
    Generated connection app
    [... more compilation ...]
    ==> maldon
    Compiling 15 files (.ex)
    Generated maldon app

    23:51:44.516 [error] GenServer #PID<0.2924.0> terminating
    ** (DBConnection.ConnectionError) tcp connect: connection refused - :econnrefused
        (db_connection) lib/db_connection/connection.ex:148: DBConnection.Connection.connect/2
        (connection) lib/connection.ex:622: Connection.enter_connect/5
        (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3
    ** (Mix) The database for Maldon.Repo couldn't be created: an exception was raised:
        ** (DBConnection.ConnectionError) tcp connect: connection refused - :econnrefused
            (db_connection) lib/db_connection/connection.ex:148: DBConnection.Connection.connect/2
            (connection) lib/connection.ex:622: Connection.enter_connect/5
            (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3

Hmm, it looks like PostgreSQL is not running, thus the test database cannot be
created. I'm on a Mac and I'm using [Postgres.app](http://postgresapp.com/) so
I just start it and relaunch the tests:

    › mix test       
    Compiling 15 files (.ex)
    Generated maldon app
    ....

    Finished in 0.06 seconds
    4 tests, 0 failures

    Randomized with seed 546377


All green, we can push to GitLab:

    › git add .

    › git commit --gpg-sign --signoff --verbose -m "Initial project commit" # I have a `ci` alias for that!

    › git push origin setup-ci
    Counting objects: 68, done.
    Delta compression using up to 4 threads.
    Compressing objects: 100% (59/59), done.
    Writing objects: 100% (68/68), 52.69 KiB | 0 bytes/s, done.
    Total 68 (delta 1), reused 0 (delta 0)
    remote:
    remote: Create merge request for setup-ci:
    remote:   https://gitlab.com/chillcoding-at-the-beach/maldon/merge_requests/new?merge_request%5Bsource_branch%5D=setup-ci
    remote:
    To gitlab.com:chillcoding-at-the-beach/maldon.git
     * [new branch]      setup-ci -> setup-ci

GitLab is so awesome, it gives us an URL where we can directly create our merge
request after every successful push!

Let's try:

<img class="full" src="https://d1yjw8g5csx279.cloudfront.net/blog/maldon/maldon-1/setup-ci-merge-request.png"
  alt="New merge request on GitLab" title="New merge request on GitLab" />

Awesome, I then submit the merge request, as a WIP because I have the feeling
that we won't be able to merge it just now...

### <a name="set-up-continuous-integration-using-gitlab-ci"></a> 4. Set up continuous integration using GitLab CI

It's all good but I would like to have my tests run for my merge request in
order to be sure I can merge it with confidence. The issue is that we don't have
any Pipelines running at [https://gitlab.com/chillcoding-at-the-beach/maldon/pipelines]
but there is a "Get started with Pipelines" button, let's click it. The button
links to [https://gitlab.com/help/ci/quick_start/README] and we learn that we
need:

- a `.gitlab-ci.yml` file
- to configure our project to use a Runner

Actually, on GitLab.com, shared runners are active by default for new projects,
so we can tackle the creation of the `.gitlab-ci.yml` file!

Since I'm lazy, and because GitLab proposes `.gitlab-ci.yml` templates for many
different languages and frameworks, we will use the UI to create it:

1. On the project's home page, there's a "Set Up CI" button:
  <img class="full" src="https://d1yjw8g5csx279.cloudfront.net/blog/maldon/maldon-1/setup-ci-button.png"
    alt="Set Up CI button on GitLab" title="Set Up CI button on GitLab" />

1. Now the trick is to change `master` to `setup-ci` in the current URL so that
  the file will be created in the `setup-ci` branch directly!

1. We choose the "Elixir" template and remove `- mysql:latest` and `- redis:latest`
  from the `services` section:
  <img class="full" src="https://d1yjw8g5csx279.cloudfront.net/blog/maldon/maldon-1/add-gitlab-ci-yml-form.png"
    alt="Set Up CI button on GitLab" title="Set Up CI button on GitLab" />

1. Obviously we uncheck `Start a new merge request with these changes` since we
  already have one.
1. Click "Commit Changes". [See the original file from this step].

[See the original file from this step]: https://gitlab.com/chillcoding-at-the-beach/maldon/blob/968149367e13d322fda26e1dc94ab419031f62e4/.gitlab-ci.yml

Then if we visit [https://gitlab.com/chillcoding-at-the-beach/maldon/pipelines]
again, we should see one pipeline in the "running" state:

<img class="full" src="https://d1yjw8g5csx279.cloudfront.net/blog/maldon/maldon-1/first-pipeline-running.png"
  alt="Our first pipeline running on GitLab" title="Our first pipeline running on GitLab" />

And if we click on the pipeline, we see its builds (only one for now), in a
running state as well:

<img class="full" src="https://d1yjw8g5csx279.cloudfront.net/blog/maldon/maldon-1/first-build-running.png"
  alt="Our first build running on GitLab" title="Our first build running on GitLab" />

But the build didn't succeed, you can see for yourself:
[https://gitlab.com/chillcoding-at-the-beach/maldon/builds/4664344](https://gitlab.com/chillcoding-at-the-beach/maldon/builds/4664344)

We actually get the same error we had in development a few minutes ago:

    ** (Mix) The database for Maldon.Repo couldn't be created: an exception was raised:
        ** (DBConnection.ConnectionError) tcp connect: connection refused - :econnrefused
            (db_connection) lib/db_connection/connection.ex:148: DBConnection.Connection.connect/2
            (connection) lib/connection.ex:622: Connection.enter_connect/5
            (stdlib) proc_lib.erl:240: :proc_lib.init_p_do_apply/3

    22:48:41.013 [error] GenServer #PID<0.2901.0> terminating
    ** (DBConnection.ConnectionError) tcp connect: connection refused - :econnrefused
        (db_connection) lib/db_connection/connection.ex:148: DBConnection.Connection.connect/2
        (connection) lib/connection.ex:622: Connection.enter_connect/5
        (stdlib) proc_lib.erl:240: :proc_lib.init_p_do_apply/3
    ERROR: Build failed: exit code 1

Fortunately, this is an issue I already encountered in another project and it's
because the hostname for the `postgres:latest` service is "postgres" instead of
"localhost" (the default value when testing locally). A trick that I like is to
modify `config/test.exs` directly to handle the CI environment.

We will continue using the Web UI editor to do this change. We can visit
[https://gitlab.com/chillcoding-at-the-beach/maldon/branches] and then
[click the `setup-ci` branch] and navigate to the `config/test.exs` file. Now,
click the "Edit" button, and change

```elixir
hostname: "localhost",
```

to

```elixir
hostname: if(System.get_env("CI"), do: "postgres", else: "localhost"),
```

We then enter a commit message and click "Commit Changes". [See the modified file].

[See the modified file]: https://gitlab.com/chillcoding-at-the-beach/maldon/blob/dbea65f4263dccaf99763a60f8dd852571c472c1/config/test.exs

This new commit, triggered the creation of a new pipeline, with a new build...
[that still fails], but with a new error:

    ** (Mix) Could not find migrations directory "priv/repo/migrations" for repo Maldon.Repo
    ERROR: Build failed: exit code 1

This time, it seems Ecto needs the "priv/repo/migrations" directory to be
present but since it's currently empty, it isn't tracked by Git. Let's fix that
real quick. This time we [navigate to the `priv/repo` directory in our branch],
but now we will create a new directory by clicking the "+" button:

<img class="full" src="https://d1yjw8g5csx279.cloudfront.net/blog/maldon/maldon-1/new-directory-form.png"
  alt="Create a new directory on GitLab" title="Create a new directory on GitLab" />


After creating the directory, the [build for this new commit passes]!

    Generated maldon app
    ....

    Finished in 0.1 seconds
    4 tests, 0 failures

    Randomized with seed 877809
    Build succeeded

This also means that now our [first merge request] is green too, since the HEAD
of its source branch (`setup-ci`) is green!

The last step is now to remove the "WIP: " prefix (there is a link to remove it
without having to actually edit the merge request!):

<img class="full" src="https://d1yjw8g5csx279.cloudfront.net/blog/maldon/maldon-1/remove-wip-prefix.png"
  alt="Remove the WIP prefix from a merge request on GitLab" title="Remove the WIP prefix from a merge request on GitLab" />

### What we've done so far

We didn't develop our project that much but we already set up a fundamental tool
in our development process: Continuous Integration!

We also took the opportunity to explore a bit how GitLab works, and a few things
you can do with it (we actually only scratched the surface of what GitLab allows
you to do...).

Did you enjoy the detailed walk-through? Was there something that could be
improved in your opinion? Let me know via Twitter!

[https://gitlab.com/chillcoding-at-the-beach/maldon/pipelines]: https://gitlab.com/chillcoding-at-the-beach/maldon/pipelines
[https://gitlab.com/help/ci/quick_start/README]: https://gitlab.com/help/ci/quick_start/README
[https://gitlab.com/chillcoding-at-the-beach/maldon/branches]: https://gitlab.com/chillcoding-at-the-beach/maldon/branches
[click the `setup-ci` branch]: https://gitlab.com/chillcoding-at-the-beach/maldon/tree/setup-ci
[that still fails]: https://gitlab.com/chillcoding-at-the-beach/maldon/builds/4664476
[navigate to the `priv/repo` directory in our branch]: https://gitlab.com/chillcoding-at-the-beach/maldon/tree/setup-ci/priv/repo
[build for this new commit passes]: https://gitlab.com/chillcoding-at-the-beach/maldon/builds/4664589
[first merge request]: https://gitlab.com/chillcoding-at-the-beach/maldon/merge_requests/1
