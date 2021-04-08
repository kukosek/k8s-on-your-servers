# Private docker registry in kubernete

Prerequisities: working `kubectl`, `helm` and `docker` on your local machine

1. Run the script `install-registry.sh`. Unfortunately it relies on a helm
chart in a repo that may not work in a future.
It generates credentials for your private docker registry. It puts them
in the registry-creds.txt text file. It also makes a file `htpasswd`
with the generated and hashed basic auth token. Then it installs
the helm chart of the Docker registry using helm.

2. Publish the docker registry service using an Ingress resource.
See example in ingress.yaml. You will need to enable HTTPS(TLS), otherwise
docker will reject your registry. Then `kubectl apply -f ingress.yaml`

3. Try access the URL. It should give a blank page.

4. Try logging in the registry using Docker. Look into registry-creds.txt
for the password.

`docker login https://docker.dulik.net -u admin -p 'mysecretpasswd'`
