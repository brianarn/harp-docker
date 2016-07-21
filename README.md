# harp-docker

A simple containerized development environment, to create a Harp application via
Docker!

## Purpose / Disclaimer

The intent of this repo is primarily for local Harp website development. It is
not necessarily intended to be used in any sort of production environment,
although theoretically, that could work just fine. Caveat Emptor or something.

Could you just install Node and Harp and do typical local development? Sure.
However, at least at the point that this repository was created, Harp doesn't
support the latest release of Node. Also, sometimes you don't want to go
globally installing a bunch of things, especially if you're moving back and
forth between a few different versions of Node.

With this small Docker-based configuration, you can be up and running with Harp
without any concern about your local version of Node, npm, etc etc. It works. :)

## Usage

### Pre-requisites

You need to have Docker installed. In theory, this should work on version 1.11
of Docker or greater. It was created under the Docker for Mac 1.12 beta, RC4,
and it worked wonderfully there, but nothing being used is 1.12-specific.

### Getting Started

#### If you don't have a Harp website set up yet

Skip ahead to "[Starting the container](#starting-the-container)". It will
automatically spin up the default Harp website for you!

#### If you already have the source for a Harp website

Copy your Harp website source into a folder named `site` within the root
directory of this repository. The Docker configuration looks at that location,
and will use that source if it exists.

#### Starting the container

Starting up the container is a simple matter of executing `docker-compose`
within the root level of this repository:

```bash
docker-compose up
```

If you don't already have the base images, Docker will start fetching them, and
will set up the container.

As part of the container starting, it will then look for a `site` directory. If
it finds one, and it is not empty, it will assume that it is the source of a
Harp website. If it doesn't find one, or it finds it and it is empty, it will
set up the default Harp website template inside of it. See
[`bin/prestart.sh`](./bin/prestart.sh) for details on what exactly is being
executed here.

Once everything is up and running, you should see some notice like the
following:

```
harp_1  | ------------
harp_1  | Harp v0.20.3 – Chloi Inc. 2012–2015
harp_1  | Your server is listening at http://localhost:9000/
harp_1  | Press Ctl+C to stop the server
harp_1  | ------------
```

As indicated, you should now be able to browse to
[http://localhost:9000/](http://localhost:9000/) and see your Harp website,
powered from within a Docker container!

#### Developing your site

Make your changes in `site`, and refresh your page! There is not currently
LiveReload support in Harp, and not a lot of movement on related issues on the
repository, but the way that Harp is being ran inside of the container, it runs
in development mode, so all changes will be reflected on a refresh.

#### Compiling your site

Compiling your site requires a mildly complex `docker-compose` command:

```bash
docker-compose run harp npm run build
```

The first portion of the command, `docker-compose run harp`, indicates to run a
command with the `harp` container, which is where the application is executing.
The second half, `npm run build`, is executing the `build` script as configured
in `package.json`.

At this point, the build command is running `harp compile site public`, which
means that after you've executed the command, you'll have a `public` folder next
to the `site` folder, which contained the compiled version of your site, ready
to ship off to the static site hosting solution of your choice!

#### Stopping things

If you ran `docker-compose up` and still have that terminal up and running, you
can hit ctrl+c and it will stop the container.

If you ran `docker-compose up -d` to kick it into the background, you should
run `docker-compose stop` to stop the container.

## Caveats

If you make any changes to `package.json`, they won't automatically be reflected
in the container. You'll need to run `docker-compose build harp` to get the
container to reflect the new version of `package.json`.

## Motivation for making this thing

There were already some forms of Harp and Docker floating around, but nothing
quite fit what I wanted. This repo might not fit you either, and that's OK.
