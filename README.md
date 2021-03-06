# Minimal Pharo Server Tools

Minimal Pharo Server Tools is a collection of scripts to install, build and deploy 
headless Pharo server applications using command line tools.

We're assuming you use Pharo 7 or 8 and want to deploy to Ubuntu GNU Linux.

Furthermore, we assuyme your code is loadable from a single baseline from a git repository.

There is one example, pharo-http-server, included.

````
$ git clone https://github.com/svenvc/minimal-pharo-server-tools.git 
$ ~/minimal-pharo-server-tools/install.sh
$ cd pharo && ~/pharo/build.sh
$ ~/minimal-pharo-server-tools/run/pharo-http-server/deploy.sh
$ sudo systemctl start pharo-http-server
````

Now the service named pharo-http-service is running. Log files are written in ~/pharo-http-service per day. 
You can locally connect to the running image with a REPL and check metrics.

````
$ cd pharo-http-service
$ sudo systemctl status pharo-http-server
$ ./repl.sh
$ ./pharo-ctl.sh run-pharo-http-server pid pharo-production
$ curl http://localhost:8080/random/64
$ curl http://localhost:42002/metrics
$ ls *.log
````

Whenever you commit new code and to deploy, you first do a new build, then copy the new 
pharo-production .image and .changes over and restart your service using systemctl.

````
$ cd pharo && ./build.sh
$ cp ~/pharo/pharo-production.* ~/pharo-http-server
$ sudo systemctl restart pharo-http-server
````

For your own needs, you will have to edit some variables in the build script.
For each of your deployed services, copy/rename/edit a run/my-service directory.
Let's assume you want to add a configuration for a service called foobar-server.

- create a subdirectory run/foobar-server
- copy repl.sh unchanged (unless you want to use a different port)
- copy deploy.sh and change SERVICE to foobar-server
- copy run-pharo-http-server.st to run-foobar-server.st and edit it start your service instead of ZnServer
- copy pharo-http-server.service to foobar-server.service and edit it so that foobar-server is used as top level directory instead of pharo-http-server and that run-foobar-server is used instead of run-pharo-http-server

That should be all.

Don't forget to add https://github.com/svenvc/NeoConsole as a dependency to your project's baseline.

This is a newer version of https://github.com/svenvc/pharo-server-tools
