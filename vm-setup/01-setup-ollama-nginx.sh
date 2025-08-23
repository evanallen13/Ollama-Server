#!/bin/bash
set -e

# Update and install dependencies
sudo apt-get update
sudo apt-get install -y curl nginx

# Install Ollama
curl https://ollama.com/install.sh | bash

# Start Ollama service
sudo systemctl enable ollama
sudo systemctl start ollama

# Configure Nginx as reverse proxy for Ollama
sudo tee /etc/nginx/sites-available/ollama <<EOF
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://localhost:11434;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

sudo ln -sf /etc/nginx/sites-available/ollama /etc/nginx/sites-enabled/ollama
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl restart nginx

echo "Ollama and Nginx setup complete."