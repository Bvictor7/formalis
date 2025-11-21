# Utiliser l'image officielle Node
FROM node:18

# Créer le dossier de l'application dans le conteneur
WORKDIR /usr/src/app

# Copier package.json et package-lock.json
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Copier le reste du code
COPY . .

# Exposer le port de l'application
EXPOSE 3000

# Lancer l'application
CMD ["node", "server.js"]
