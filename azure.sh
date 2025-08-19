# Variables – tweak as needed
RG=ollama-rg
LOC=eastus
VM=ollama-vm
USER=azureuser
IMAGE=Ubuntu2204
SIZE=Standard_D2s_v5

az group create -n $RG -l $LOC

az vm create \
  -g $RG -n $VM \
  --image $IMAGE \
  --size $SIZE \
  --admin-username $USER \
  --generate-ssh-keys \
  --public-ip-sku Standard

# Open HTTP/HTTPS (we’ll reverse-proxy to Ollama)
az vm open-port -g $RG -n $VM --port 80
az vm open-port -g $RG -n $VM --port 443   # optional, for TLS later

az vm list-ip-addresses -g $RG -n $VM -o tsv --query "[].virtualMachine.network.publicIpAddresses[].ipAddress"
