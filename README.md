# CLARA

**CL**arification des **A**ides pour le **R**etour à l'**A**ctivité.

## Installation from scratch sur un poste de dev

### Prérequis

```
~/workspace> docker --version
Docker version 17.12.0-ce, build c97c6d6

~/workspace> docker-compose --version
docker-compose version 1.18.0, build 8dd22a9
```


### Installation

#### Liste de commandes pour installer Clara

```

~/workspace> git clone https://github.com/StartupsPoleEmploi/clara.git

~/workspace> cd clara

ensuite, le user/mdp sera demandé pour un accès à gitlab pole emploi

~/workspace/clara> git clone https://git.beta.pole-emploi.fr/clara/private.git

~/workspace/clara> rm -rf private/.git

~/workspace/clara> cd docker 

~/workspace/clara/docker> docker-compose -f docker-compose.dev.yml up --build -d

Les machines docker (app, db, nginx) sont lancées, mais pas encore l'application

~/workspace/clara/docker> chmod +x ./scripts/restore_db_dev.sh && ./scripts/restore_db_dev.sh

Désormais la base de données est remplie avec les dernières données issues de la prod.

Dans un autre onglet du terminal, 

~/workspace/clara/docker> docker-compose exec srv_app bash

root@b883dc7f48d5:/home/clara# bundle install
```
#### Pour arrêter Docker

```
~/workspace/clara/docker> docker stop $(docker ps -aq)
```

#### Pour redémarrer de zéro

```
~/workspace/clara/docker> docker container prune
```



#### Problèmes possibles d'installation

 - Si Postgre est déjà installé sur votre machine, le service postgre doit être arrêté
 - Vous devez être connecté en tant que root pour faire marcher Docker

### Commandes utiles au quotidien

#### Lancer l'application

```
root@b883dc7f48d5:/home/clara# bin/rails s -p 3000 -b '0.0.0.0'
```

L'application est visible sous http://localhost ou http://localhost:3000



#### Lancer les tests front

```
root@b883dc7f48d5:/home/clara# npm install -g istanbul
root@b883dc7f48d5:/home/clara# bundle exec teaspoon
```

Vous pouvez aussi vous connecter sous http://localhost:3000/teaspoon/default


#### Lancer les tests de recette

```
root@b883dc7f48d5:/home/clara# bin/rails minidb:recreate
root@b883dc7f48d5:/home/clara# npm install cypress --save-dev
root@b883dc7f48d5:/home/clara# $(npm bin)/cypress open
```


#### Déployer en recette

##### Installer Clara sur une nouvelle recette


```
~/home> sudo git clone https://github.com/StartupsPoleEmploi/clara.git
~/home> cd clara
~/home/clara> groupadd git
~/home/clara> chgrp -R git .git
~/home/clara> chgrp -R git ./
~/home/clara> usermod -aG git $(whoami)
~/home/clara> git clone https://git.beta.pole-emploi.fr/clara/private.git
~/home/clara> rm -rf private/.git
~/home/clara> cd docker 
~/home/clara/docker> docker-compose -f docker-compose.r7.yml up --build -d
~/home/clara/docker> chmod +x ./scripts/restore_db_prod.sh && ./scripts/restore_db_prod.sh
```

##### Déployer une nouvelle version

```
ssh identifiant@adresse_recette

~/$> cd /home/clara/docker
~/home/clara/docker$> docker-compose exec srv_app bash
root@inside_docker:~$> cd /var/git/ara.git
root@inside_docker:/var/git/ara.git$> git pull origin master
root@inside_docker:/var/git/ara.git$> bundle install
root@inside_docker:/var/git/ara.git$> bundle exec mina production2 setup 
root@inside_docker:/var/git/ara.git$> bundle exec mina production2 deploy  
```

##### Commandes utiles

```
docker-compose down -v
```

##### URL

L'application est visible sous https://clara.beta.pole-emploi.fr/

### Outils 
Clara est un projet Open Source sous licence AGPL 3.0. 
Ce statut nous permet d'être soutenu gratuitement. Nous les en remercions.

#### Sentry : error tracking
<p>
  <a href="https://sentry.io">
  <img src="https://sentry-brand.storage.googleapis.com/sentry-logo-black.png" width="150"/>
 </a>
Sentry nous permet de détecter au plus vite les erreurs en production.

</p>

#### Browserstack : Live, Web-Based Browser Testing
<p style="background-color: black;">
 <a href="https://www.browserstack.com/">
  <img src="https://www.browserstack.com/images/layout/browserstack-logo-600x315.png" width="250"/>
 </a>
 Browserstack permet de tester Clara sur différents navigateurs.
</p>

## Workflow

Voir CONTRIBUTING.md
