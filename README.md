## Installing

1. Install a JDK: `sudo apt-get install openjdk-7-jdk` 
1. Install cordova locally from `package.json`: `npm install`
1. Define your `ANDROID_HOME` in your `~/.bash_profile` e.g. `export ANDROID_HOME=~/.local/share/android-sdk-linux`

## Defining a new Cordova platform

1. Within `tictactoe` directory: `../node_modules/.bin/cordova platform add android`
1. Check in all files: _"it is mostly build product but some things like the AndroidManifest.xml you will end up tweaking manually"_

