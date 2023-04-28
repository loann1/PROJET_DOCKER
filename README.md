# PROJET_DOCKER
Projet final Docker - Nextcloud 


Rappel de l'énoncé : 

# Projet Docker
- Un docker-compose qui a au moins 2 services qui communiquent
- Une image Docker customisé qui vient de votre compte Docker Hub (ou tous mais au moins un)
    - L'image contient un entrypoint custom
- Au moins un volume partagé avec la machine hôte pour pouvoir garder un état si on éteint et redémarre le docker-compose
- Des variables d'environnement pris en compte dans le container (dans le entrypoint ou par example pour connecter le back à la base de données)

# Rendu 

- Lien vers un repository git / gitlab avec tous les éléments dedans ainsi qu'un Readme pour expliquer le projet ainsi que les difficultés rencontrées et comment vous les avez résolus


Ce projet a pour but de mettre en place 4 conteneurs :

- Un nextcloud 
- Une mariaDB
- un conteneur Graphana
- Un conteneur Prometheus

L'objectif de notre projet est de mettre en place ces 4 conteneurs afin que le nextcloud stocke ses données dans la MariaDB et que celui-ci soit monitoré par Prometheus.

Nous nous sommes répartis en 2 parties ce projet :

- La mise en place du nextcloud avec la mariaDB
- La mise en place du Prometheus avec Grafana

Difficultés rencontrées : 

Lors de la mise en place de la partie Nextcloud MariaDB, j'ai eu quelques problématiques avec la mise en place de mon entrypoint, qui semblait empecher la mise en place du conteneur mariadb.

J'ai eu également une problématique avec le dockerfile qui semblait mal être appelé dans le dockerfile, ce qui générait des erreurs (il s'agissait d'un problème d'indentation)


Améliorations effectuées sur le projet : 

Mise en place d'un healthcheck dans le docker compose, si la mariaDB ne se lance pas alors le nextcloud ne se lance pas inutilement.
création d'un dockerfile qui permet d'installer les paquets qui pourraient etre néecessaire pour la mise en place des conteneurs.


Etat de l'art du projet : 


Modifications à restantes à apporter : 

Créer un fichier secret qui contiendrait les mdp de la BDD ainsi que du nextcloud.
Réussir à mettre en place un entrypoint qui affiche le uptime des conteneurs 
