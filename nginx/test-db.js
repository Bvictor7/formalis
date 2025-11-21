const mysql = require('mysql2');

// Configuration de la connexion à MySQL
const connection = mysql.createConnection({
  host: 'formalismysql',  // nom du service MySQL défini dans docker-compose
  user: 'root',           // utilisateur MySQL
  password: 'root',       // mot de passe
  database: 'formalis'    // nom de la base
});

// Essai de connexion
connection.connect(err => {
  if (err) {
    console.error('Erreur de connexion :', err);
  } else {
    console.log('Connexion MySQL réussie !');
  }
  connection.end(); // fermer la connexion
});

