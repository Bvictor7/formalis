Plateforme Formalis - Documentation Complète
Description du Projet

Plateforme d'apprentissage en ligne sécurisée avec architecture Docker complète comprenant :

API Node.js (backend)

Base de données MySQL

Reverse Proxy NGINX avec HTTPS

Renouvellement automatique des certificats SSL

Architecture du Projet
formalis/
├── node-app/
│   ├── Dockerfile
│   ├── package.json
│   └── server.js
├── nginx/
│   └── default.conf
├── mysql/
│   └── init.sql (optionnel)
├── scripts/
│   └── renew-cert.sh
├── docker-compose.yml
├── .gitignore
├── crontab-export.txt
└── README.md

Installation et Démarrage
Prérequis

Ubuntu/WSL2 avec Docker et Docker Compose installés

Git

OpenSSL

Cloner le dépôt
git clone https://github.com/Bvictor7/formalis.git
cd formalis

Créer les certificats SSL (auto-signés pour développement)
sudo mkdir -p /etc/letsencrypt/live/formation.local

sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/letsencrypt/live/formation.local/privkey.pem \
  -out /etc/letsencrypt/live/formation.local/fullchain.pem \
  -subj "/C=FR/ST=France/L=Paris/O=Formalis/CN=formation.local"

sudo chmod 644 /etc/letsencrypt/live/formation.local/*.pem

Configurer /etc/hosts
sudo nano /etc/hosts


Ajouter la ligne suivante :

127.0.0.1   formation.local

Configurer les variables d'environnement

Créer un fichier .env (non commité) :

MYSQL_ROOT_PASSWORD=rootpassword
MYSQL_DATABASE=formalis_db
MYSQL_USER=formalis_user
MYSQL_PASSWORD=formalis_pass

NODE_ENV=development
DB_HOST=mysql
DB_USER=formalis_user
DB_PASSWORD=formalis_pass
DB_NAME=formalis_db

Lancer l'application
docker compose up -d --build
docker compose ps
docker compose logs -f

Tester l'application
curl http://localhost:8080/api/health
curl -k https://formation.local:8443/api/health
curl http://localhost:3000/api/health


Réponse attendue : {"message":"API Formalis OK"}

Renouvellement Automatique des Certificats
sudo touch /var/log/formalis-cert-renew.log
sudo chmod 666 /var/log/formalis-cert-renew.log
chmod +x scripts/renew-cert.sh

crontab -e


Ajouter la ligne suivante :

0 3 1 */3 * /home/VOTRE_USER/formalis/scripts/renew-cert.sh


Vérifier :

crontab -l


Tester le script manuellement :

~/formalis/scripts/renew-cert.sh
cat /var/log/formalis-cert-renew.log

Commandes Docker Utiles
docker compose up -d
docker compose down
docker compose ps
docker compose logs -f nginx
docker compose logs -f node-app
docker compose logs -f mysql
docker compose restart nginx
docker compose up -d --build

docker exec -it formalis-node sh
docker exec -it formalismysql mysql -u formalis_user -p
docker exec formalis-nginx ls -la /etc/letsencrypt/live/formation.local/

docker compose down
docker compose down -v
docker system prune -a

Accès aux Services
Service	URL	Port
API (HTTP)	http://localhost:8080/api/
	8080
API (HTTPS)	https://formation.local:8443/api/
	8443
Node.js direct	http://localhost:3000/
	3000
MySQL	localhost:3306	3306
Développement vs Production
Développement

Certificats auto-signés

Volumes montés pour hot-reload

Logs verbeux

Port MySQL exposé

Variables d'environnement locales

Production

Certificats Let's Encrypt réels

Images Docker immuables

Secrets sécurisés

Logs centralisés

Base de données non exposée

Monitoring et healthchecks

Dépannage

Vérifier les logs : docker compose logs

Vérifier la configuration Docker : docker compose config

Certificats SSL : ls -la /etc/letsencrypt/live/formation.local/

Vérifier la résolution DNS : ping formation.local

Points de Validation

Tous les conteneurs sont actifs

L’API répond en HTTP et HTTPS

NGINX redirige vers Node.js

La base MySQL est accessible depuis Node.js

Les certificats SSL sont présents

Le script de renouvellement s’exécute sans erreur

La tâche cron est configurée

Les logs sont écrits dans /var/log/formalis-cert-renew.log

Sécurité

Réseau Docker isolé

Base de données non exposée sur l’hôte

Certificats SSL même auto-signés

Variables d'environnement pour les secrets

Volumes en lecture seule pour les certificats

Healthchecks sur les services critiques

Workflow Git

main : Production

dev : Développement

Branches et workflow

Créer une branche depuis dev : git checkout -b feature/ma-feature

Développer et commiter

Push et créer une Pull Request vers dev

Après validation, merge dans main

Version: 1.0.0
Dernière mise à jour: Novembre 2025
Auteur: Victor
