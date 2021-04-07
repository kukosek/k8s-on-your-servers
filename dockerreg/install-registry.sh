#!/bin/sh

export SHA=$(head -c 16 /dev/urandom | shasum | cut -d " " -f 1)
export USER=admin

echo $USER > registry-creds.txt
echo $SHA >> registry-creds.txt

docker run --entrypoint htpasswd registry:2.7.0 -Bbn admin $SHA > ./htpasswd

helm repo add twuni https://helm.twun.io
helm repo update
helm install docker-registry twuni/docker-registry \
  --namespace default \
  --set persistence.enabled=true \
  --set secrets.htpasswd=$(cat ./htpasswd)
