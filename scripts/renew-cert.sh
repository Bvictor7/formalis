#!/bin/bash

# Configuration
LOG_FILE="/var/log/formalis-cert-renew.log"
CERT_DIR="/etc/letsencrypt/live/formation.local"
PROJECT_DIR="/home/belah/formalis"

# Fonction de log
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | sudo tee -a "$LOG_FILE"
}

log_message "=== Début du renouvellement du certificat ==="

# En développement : régénérer le certificat auto-signé
log_message "Régénération du certificat auto-signé..."
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout "$CERT_DIR/privkey.pem" \
  -out "$CERT_DIR/fullchain.pem" \
  -subj "/C=FR/ST=France/L=Paris/O=Formalis/CN=formation.local" \
  >> "$LOG_FILE" 2>&1

# En production : utiliser Let's Encrypt
# sudo certbot renew --nginx >> "$LOG_FILE" 2>&1

if [ $? -eq 0 ]; then
    log_message "Certificat régénéré avec succès"
    
    # Redémarrer NGINX
    log_message "Redémarrage de NGINX..."
    cd "$PROJECT_DIR" && docker compose restart nginx >> "$LOG_FILE" 2>&1
    
    if [ $? -eq 0 ]; then
        log_message "NGINX redémarré avec succès"
    else
        log_message "ERREUR: Échec du redémarrage de NGINX"
        exit 1
    fi
else
    log_message "ERREUR: Échec de la régénération du certificat"
    exit 1
fi

log_message "=== Fin du renouvellement du certificat ==="
