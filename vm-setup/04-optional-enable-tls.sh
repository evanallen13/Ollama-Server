#!/bin/bash
set -e

# Enable TLS for Nginx reverse proxy (using self-signed cert for demo)
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/ollama-selfsigned.key \
    -out /etc/ssl/certs/ollama-selfsigned.crt \
    -subj "/CN=ollama.local"

sudo tee /etc/nginx/sites-available/ollama-tls <<EOF
server {
    listen 443 ssl;
    server_name _;

    ssl_certificate /etc/ssl/certs/ollama-selfsigned.crt;
    ssl_certificate_key /etc/ssl/private/ollama-selfsigned.key;

    location / {
        proxy_pass http://localhost:11434;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

sudo ln -sf /etc/nginx/sites-available/ollama-tls /etc/nginx/sites-enabled/ollama-tls
sudo nginx -t
sudo systemctl restart nginx

echo "TLS enabled for Ollama Nginx proxy."