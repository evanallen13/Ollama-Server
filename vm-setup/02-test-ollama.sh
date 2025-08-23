#!/bin/bash
set -e

# Test Ollama API via Nginx proxy
RESPONSE=$(curl -s -X POST http://localhost/api/generate -d '{"model": "llama2", "prompt": "Hello, Ollama!"}')
echo "Ollama response:"
echo "$RESPONSE"