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
* invokes ```reset_db``` to re-create and load the database (by running ```app/db_init.rb```)
* invokes ```spec```.

#### re-create the database

This runs a ruby script that creates the database tables. I use this instead of migrations (see <a href="#sequel-migrations">notes below</a>)). It's the same script that is executed from the default rake task.

```
ruby app/db_init.rb
```

There's a rake task for resetting the database, so you can also run it like this:

```shell
bundle exec rake reset_db
```

#### load the database

This loads the database with stock data. This data is not used by the ```rspec``` examples. This script uses the value of ```DATABASE_URL``` to connect to the database.

```shell
ruby app/db_load.db
```

There's a script that wraps this execution, too.

```shell
loaddb
```

#### run the sqlite3 command-line utility

This runs ```sqlite3``` passing the path to the sandbox database.

```shell
db
```

## lessons learned

These are reminders to myself of various things I learned by playing with this project. They don't all have to do with the ```sequel``` gem.

#### sequel migrations

The migrations functionality is so flaky that I eventually gave up on it. I spent hours and hours trying to get it to behave consistently. If the slightest error occurs (ruby syntax or whatever), the migration logic can never again figure out the state of the database.

The documentation states the migration feature is useful when there is more than one developer working on database changes concurrently. My current view is this is not an optimal solution for multiple developers working together.

Given that the developers check in small changes frequently, in accordance with contemporary notions of "good practice," then as long as they update their local repo frequently and run a database creation script as part of their micro-level red-green-refactor cycle, they will avoid conflicts in database definitions.

A single database initialization script also provides comprehensive documentation of the schema in one place, as opposed to scattered across a series of migrations. See ```app/db_init.rb``` for an example.

#### github flavored markdown

There's copious documentation about markdown and about github's variant of markdown, but I didn't find an explanation or example of how to use markdown link notation for a link to a target on the same page (the README.md page, in this case).

Github has a way to generate a table of contents for a markdown document, but once the table has been generated all the links include full absolute URLs, so I couldn't see how to duplicate the "source" notation for linking to these targets.

It was clear that github inserts dashes between the words of multi-word markdown headings in its generated anchor (target) tags. It was not clear how to write a markdown-style link to navigate to such a target within the same document.

Ultimately I gave up on decoding the magic and used plain HTML anchor tags. Not very sexy. I look forward to updating this note to reflect the improved understanding I will eventually gain. It will not be today.

## useful tools

These are some tools I ended up using in the course of playing with this project. YMMV.

#### atom editor

If you want to play with this project, you are free to edit the files using any tools you please. Personally, I find a lightweight yet feature-complete text editor to be adequate for this purpose. Atom provides Ruby-aware color highlighting as well as a markdown preview feature. For this project, I haven't had a need for any of the additional functionality provided by IDEs.

To install atom:

```shell
sudo apt-add-repository ppa:webupd8team/atom
sudo apt update
sudo apt install -y atom
```

Now ```atom``` should be referenced in ```/usr/bin.atom```. If you run ```atom``` from the project root directory, it will open the directory as a "project".

## license

This material is in the public domain. That means if you mess it up, the entire public will be ruined. That's going to be on you, man.

## installing and contributing

You're kidding, right? I told you this isn't a real project. There's nothing to see here. Move along.
