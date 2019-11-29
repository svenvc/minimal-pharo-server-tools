# Minimal Pharo Server Tools

Minimal Pharo Server Tools is a collection of scripts to install, build and deploy 
headless Pharo server applications using command line tools.

We're assuming you use Pharo 7 or 8.

Furthermore, we assuyme your code is loadable from a single baseline from a git repository.

There is one example, pharo-http-server, included.

````
$ git clone git@github.com:svenvc/minimal-pharo-server-tools.git
$ ~/minimal-pharo-server-tools/install.sh
$ ~/pharo/build.sh
$ ~/pharo/pharo-local/iceberg/minimal-pharo-server-tools/run/pharo-http-server/deploy.sh
$ sudo systemctl start pharo-http-service
````

For your own needs, you will have to edit some variables in the build script.

For each of your deployed services, copy/rename/edit a run/my-service directory.

This is a newer version of https://github.com/svenvc/pharo-server-tools
