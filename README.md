# Edgar

[![le chat sur https://gitter.im/Association-Merci-Edgar/Merci-Edgar](https://badges.gitter.im/Association-Merci-Edgar/Merci-Edgar.svg)](https://gitter.im/Association-Merci-Edgar/Merci-Edgar?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Build Status](https://travis-ci.org/Association-Merci-Edgar/Merci-Edgar.png?branch=wip)](https://travis-ci.org/Association-Merci-Edgar/Merci-Edgar)
[![Code Climate](https://codeclimate.com/github/Association-Merci-Edgar/Merci-Edgar.png)](https://codeclimate.com/github/Association-Merci-Edgar/Merci-Edgar)


Merci Edgar est un outil pour vous aider à monter leurs spectacle, organiser vos tournée. Si vous en faite un autre usage, merci de nous ternir informé, nous pourrons l'ajouter ici :-D


## Pour participer au développement

1. Copier le fichier `.env.example` en `.env` et remplir les _crédentials_ pour:
  * amazon S3
  * mandrill
  * mailchimp
  * [rollbar (for production)](https://rollbar.com/krichtof/Merci-Edgar/)
  * stripe

2. Installer les dépendances du projet avec `bundle install`
_Si vous rencontrez des erreurs lors de l'installation de la gem 'capybara-webkit', [cette solution fonctionnera peut-être](https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit)._

3. Avoir PostgreSQL et lancer `rake db:setup`.


4. Démarrer ces trois processu
  * [redis](http://redis.io/topics/quickstart) : `redis-server`
  * [sidekiq](http://sidekiq.org/)  : `bundle exec sidekiq`
  * `rails server`


5. Ouvrir un navigateur à l'adresse [http://www.lvh.me:3000](http://www.lvh.me:3000)


## Développement

Pour faciliter l'utilisation de l'application en mode développement, un fichier `Makefile` a été ajouté. Pour le moment nous avons :

* `make install` pour construire l'application (en lançant bundler par exemple)
* `make run`
* `make test`
* `make clean`

Ou alors, on peut continuer à utiliser `docker-compose` comme ci-dessous.


## Utilisation de Docker

* `docker-compose up` pour démarrer le serveur
* `docker-compose run test` pour lancer les specs
* `docker-compose run webapp rake [command]` pour lancer une commande `rake`
* `docker-compose run webapp rails [command]` pour lancer une commande `rails`

_Vous devez avoir [`docker-compose` installé_](http://docs.docker.com/compose/install/) sur votre machine pour que cela fonctionne.


