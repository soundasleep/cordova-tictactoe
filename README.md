# cordova-tictactoe

A simple application that uses the [Apache Cordova project](http://cordova.apache.org/) to wrap [a Javascript TicTacToe game](https://github.com/soundasleep/jstictactoe) as a native Android app.

## Installing

1. Install a JDK and required build tools: `sudo apt-get install openjdk-7-jdk ant` 
1. Install cordova locally from `package.json`: `npm install`
1. Define your `ANDROID_HOME` in your `~/.bashrc` e.g. `export ANDROID_HOME=~/.local/share/android-sdk-linux`
1. Install the web application dependencies: `cd wwwsrc && npm install`
1. Install the Gem to compile SASS scripts: `cd wwwsrc && gem install sass`

Internally we use the [jstictactoe](https://github.com/soundasleep/jstictactoe) web application imported directly into this project.

## Building the Android app

```
ant build
```

Alternatively you can execute both Grunt and Cordova build separately, based on the [Cordova Command Line Interface](http://cordova.apache.org/docs/en/4.0.0/guide_cli_index.md.html#The%20Command-Line%20Interface):

```
cd wwwsrc
grunt build
cd ..
node_modules/.bin/cordova build
```

## Testing on a local Android device

Make sure that you can run/debug Android devices through e.g. the Eclipse ADT, by setting USB debugging mode to "on" etc.

```
ant run
```

Alternatively you can execute both Grunt and Cordova build separately, based on the [Cordova Command Line Interface](http://cordova.apache.org/docs/en/4.0.0/guide_cli_index.md.html#The%20Command-Line%20Interface):

```
cd wwwsrc
grunt build
cd ..
node_modules/.bin/cordova run android
```

## Defining a new Cordova platform

Based on the [Cordova Command Line Interface](http://cordova.apache.org/docs/en/4.0.0/guide_cli_index.md.html#The%20Command-Line%20Interface)

1. `node_modules/.bin/cordova platform add android`
1. Check in all files: _"it is mostly build product but some things like the AndroidManifest.xml you will end up tweaking manually"_

