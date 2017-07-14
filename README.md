# sequel-sandbox

This is a sandbox or playground for me to learn about the sequel gem. It isn't a "real" project. It's only on Github so I won't lose it or accidentally delete it.

Files are organized into folders so that I will have some chance of finding them when I need them, but there's no well-thought-out directory structure. Don't use this as an example for anything (unless you're looking for a bad example).

I have to write things down or I will forget them. So here goes.

## platform

This has only ever been run on Ubuntu Linux. It isn't intended to be portable (so don't ask). That means the scripts and suggested actions documented here work on Ubuntu 16.04.2 64-bit with bash 4.x. If you want to play with this on a different platform, set your expectations accordingly. In addition, the Gemfile doesn't specify any versions for dependencies, so YMMV.

## environment variables

To set environment variables needed for this project:

```shell
cd [project root directory]
source .envvars
```

You can also do

```shell
. .envvars
```

Remember ```.envvars``` is not a script. Don't execute it; source it into your shell.

Environment variables are:

* DATABASE_URL - required for the sequel extension for migrations (see [project]/.rake/sequel_migrations.rake)
* PROJECT_NAME - used for setting paths that are in the project directory tree
* PROJECT_ROOT - also used for setting paths
* PATH - .envvars prepends current directory and $PROJECT_ROOT/scripts to PATH
* SEQUEL_LOG - log file for sequel gem


## where?

* Toy Ruby source code is in ```$PROJECT_ROOT/app```.
* Specs for exploring ```sequel``` functionality via ```rspec``` are in ```$PROJECT_ROOT/spec```.
* Convenience scripts are in ```$PROJECT_ROOT/scripts```.
* The database is in ```$PROJECT_ROOT/db```.
* Database migration code is in ```$PROJECT_ROOT/migrations``` (as required by the sequel migrations extension)
* Custom rake tasks are in ```$PROJECT_ROOT/.rake``` (the Rakefile imports everything in there that ends with ".rake")


## conveniences

These are keystroke-savers for tasks frequently done when playing with the code. They are located in ```$PROJECT_ROOT/scripts```, which will be on the PATH if you source ```.envvars```.

#### run the specs

This runs ```bundle exec rake```.

```shell
go
```

The default rake task does this:

* deletes the sequel log file named in env var ```SEQUEL_LOG```
* resets the database with ```db.migrate.reset```
* invokes ```spec```.

#### run the sqlite3 command-line utility

This runs ```sqlite3``` passing the path to the sandbox database.

```shell
db
```

#### run database migrations

This runs ```bundle exec rake db:migrate:xxxx```.

```shell
migrate up
migrate down
migrate reset
```

## atom editor

To install the ```atom``` editor:

```shell
sudo apt-add-repository ppa:webupd8team/atom
sudo apt update
sudo apt install -y atom
```

Now ```atom``` should be referenced in ```/usr/bin.atom```. If you run ```atom``` from the project root directory, it will open the directory as a "project".

## about migrations

The sequel migrations extension works mostly like ActiveRecord, but not exactly. A key difference is the naming convention for migration files. Prepend a simple integer version number rather than a timestamp. An ActiveRecord-style timestamp looks like an integer, so it would probably work too, but I haven't tried it.

## license

This material is in the public domain. That means if you mess it up, the entire public will be ruined. That's going to be on you, man.

## installing and contributing

You're kidding, right? I told you this isn't a real project. There's nothing to see here. Move along.
