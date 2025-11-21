const mysql = require('mysql2');

// Configuration de la connexion à MySQL
const connection = mysql.createConnection({
  host: 'formalismysql',
  user: 'root',
  password: 'root',
  database: 'formalis'
});

connection.connect(err => {
  if (err) {
    console.error('Erreur de connexion :', err);
  } else {
    console.log('Connexion MySQL réussie !');
  }
  connection.end();
});

