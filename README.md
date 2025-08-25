# Ollama-Server

Ollama-Server is a set of scripts and configuration files to automate the deployment of the [Ollama](https://ollama.com/) large language model server on an Azure virtual machine running Ubuntu. It configures Ollama behind an Nginx reverse proxy, with optional support for GPU acceleration and TLS encryption.

## Features

- Automated Azure VM provisioning via `azure.sh`
- Installs Ollama and Nginx, configures reverse proxy
- Optional GPU pinning for Ollama
- Optional self-signed TLS setup for secure connections
- Simple test script to verify Ollama API functionality

This project is intended for quick setup and demonstration