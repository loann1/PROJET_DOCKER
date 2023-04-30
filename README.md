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


# Partie Grafana/Prometheus

J'ai essayé de mettre en place un système de monitoring pour le Nextcloud et ses containers docker. 
J'ai fais plein de test mais je n'ai pas réussi à le faire fonctionner.
J'ai réussi à mettre en place le Grafana/Prometheus sous Docker avec un docker compose, mais le lien avec le Nextcloud ne fonctionnait pas donc je n'avais aucune métriques qui apparaissaient. 

Pour le mettre en place, j'ai créer un fichier docker-compose.yaml avec les services Grafana et Prometheus, puis un fichier prometheus.yaml pour la partie configuration de Prometheus qui récupère les informations du container Nextcloud déjà existant. 

# Difficultés rencontrées : 

J'ai fais des dossiers avec les fichiers de configuration utilisés lors des différents test. 

## 1er test : 
Lors du premier test, j'ai eu l'erreur "permission denied" lors du docker compose up sur le fichier de configuration de prometheus. 
J'ai cherchée et j'ai vu que c'était surement lié au fait que j'étais en root sur ma machine pour lancer les commandes.
J'ai d'abord essayée de donner tous les droits sur les dossiers/fichiers que j'utilisais pour le projet, avec un chmod 777, mais l'erreur était toujours là.
Du coup j'ai déplacée tous les fichiers sur un compte local et je l'ai configuré pour qu'il puisse effectuer les commandes Docker. 
Nouvelle erreur après ces modifications -- > error loading config (--config.file=/etc/prometheus/prometheus.yml)" err="open /etc/prometheus/prometheus.yml: no such file or directory" 
Il ne trouvait pas le fichier de config alors qu'il était bien présent. 
J'ai fais plusieurs test en changeant le chemin du fichier prometheus.yml (chemin entier, chemin depuis l'endroit où on lance le docker compose up, chemin avec juste le nom du fichier...) 
Mon fichier de configuration prometheus.yml était au début dans un dossier /projet_docker/grafana_prometheus/prometheus/, mais vu que l'erreur me citer comme chemin /etc/prometheus, j'ai donc copié le fichier de configuration dans ce dossier. 
Après ces modification, je n'avais plus d'erreur sur lors du docker compose up, mais l'exécution de la commande ne s'arrêtait pas, donc je penses qu'elle ne s'est pas compléter entièrement, mais pourtant j'avais bien accès à l'interface Grafana depuis une page Web, et j'ai pu aussi ajouter le Prometheus comme souces de données dans le Grafana. 
Je voyais bien avec un docker ps que les containers étaient up, mais le docker-compose up ne s'est jamais arrêté. 
Donc j'avais bien le Grafana et le Prometheus fonctionnels, mais je n'avais pas de données de Nextcloud qui remontaient lorsque je voulais créer un Dashboard ou quoique ce soit. 

## 2ème test : 
J'ai donc fais d'autres test, avec d'autres docker-compose.yml (j'en enchainée pas mal de test donc je n'ai pas enregistré tous lees fichiers avec chaque modifications faites dessus. 

## 3ème test : 
J'ai tenté de faire un docker-compose.yml qui régroupait la configuration du Nextcloud directement pour qu'ils soient créer tous ensemble en même temps. 
-- > ça ne fonctionnait toujours pas, je n'avais toujours pas de données Nextcloud. 
J'ai chercher les causes, et j'ai lu qu'il fallait surement ajouter un pluggin sur la configuration du Nextcloud pour permettre à Prometheus de récupérer des métriques, mais je n'ai pas eu assez de temps pour tester cette idée, sachant que d'après mes premières recherches dessus, il n'y avait pas beaucoup plus d'informations dessus, et les solutions trouvaient me faisais réécrire les fichiers en entier... 


## Résultat 

Pour conclure, les deux parties du projet sont fonctionnelles mais indépendemment.
Je n'ai pas réussi à lier les données Nextcloud à l'interface Grafana/Prometheus.  


