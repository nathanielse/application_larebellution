# Application Android de LaRébellution

## Introduction

Le dépôt contient le code source de l'application Android du site [La
Rébéllution](http://www.larebellution.com/).

L'application Android est une application Web conçue en utilisant le
framework de développement d'application mobile [Apache
Cordova](https://cordova.apache.org/) et le framework JavaScript
[Ember.js](https://emberjs.com/).

Les deux frameworks ont été associés en utilisant l'extension
[ember-cordova](https://github.com/isleofcode/ember-cordova).

## Environnement de développement

L'environnement de développement est disponible sous la forme d'une
image de conteneur
[Docker](https://fr.wikipedia.org/wiki/Docker_(logiciel)).

Le site du projet Docker proposent des instructions d'installation de
Docker pour Windows, Mac OS X et Linux.

L'image de développement de l'application peut être téléchargée en
utilisant la commande suivante :

    $ docker pull nathaniel_se/application_larebellution:test

## Construction de l'application

La commande suivante permet de construire une version de test de
l'application :

    $ docker-compose run dev ember cdv:build --platform android

L'application construite a pour chemin
`ember-cordova/cordova/platforms/android/build/outputs/apk/android-debug.apk`.

La construction de la version de production sera décrite
prochainement.






