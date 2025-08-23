#!/bin/bash
set -e

# Pin Ollama to a specific GPU (example: GPU 0)
# Requires Ollama >= v0.1.32 and NVIDIA GPU
sudo tee /etc/systemd/system/ollama.service.d/override.conf <<EOF
[Service]
Environment="OLLAMA_GPU=0"
EOF

sudo systemctl daemon-reload
sudo systemctl restart ollama

echo "Ollama pinned to GPU 0."