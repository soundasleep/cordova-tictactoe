## Installing

1. Install a JDK and required build tools: `sudo apt-get install openjdk-7-jdk ant` 
1. Install cordova locally from `package.json`: `npm install`
1. Define your `ANDROID_HOME` in your `~/.bashrc` e.g. `export ANDROID_HOME=~/.local/share/android-sdk-linux`

## Defining a new Cordova platform

Based on the [Cordova Command Line Interface](http://cordova.apache.org/docs/en/4.0.0/guide_cli_index.md.html#The%20Command-Line%20Interface)

1. `node_modules/.bin/cordova platform add android`
1. Check in all files: _"it is mostly build product but some things like the AndroidManifest.xml you will end up tweaking manually"_

## Building the web app

Internally we use the [jstictactoe](https://github.com/soundasleep/jstictactoe) web application imported directly into this project.

```
cd www
npm install
gem install sass
grunt build

```

## Building the Android app

Based on the [Cordova Command Line Interface](http://cordova.apache.org/docs/en/4.0.0/guide_cli_index.md.html#The%20Command-Line%20Interface)

```
node_modules/.bin/cordova build
```

## Testing on a local Android device

Make sure that you can run/debug Android devices through e.g. the Eclipse ADT, by setting USB debugging mode to "on" etc.

Based on the [Cordova Command Line Interface](http://cordova.apache.org/docs/en/4.0.0/guide_cli_index.md.html#The%20Command-Line%20Interface)

```
node_modules/.bin/cordova run android
```
