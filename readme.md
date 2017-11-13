### Get latest `kubectl` app

```
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/kubernetes-client-darwin-amd64.tar.gz && \
tar -xzvf kubernetes-client-darwin-amd64.tar.gz && \
sudo cp kubernetes/client/bin/kubectl /usr/local/bin && \
sudo chmod +x /usr/local/bin/kubectl && \
rm -rf kubernetes && \
rm -rf kubernetes-client-darwin-amd64.tar.gz
```

### Get config

-> Get kubeconfig for azure + aws + federation from stackpoint>
gcloud config set container/use_client_certificate True
export CLOUDSDK_CONTAINER_USE_CLIENT_CERTIFICATE=True
-> Get kubeconfig for google from google>



### Create global wide dns zone

```
ID=$(uuidgen) && \
aws route53 create-hosted-zone \
--name devfest.netbears.com \
--caller-reference $ID \
| jq .DelegationSet.NameServers
```

### Update CloudFlare

```
update-dns devfest.netbears.com value_ns_1 value_ns_2 value_ns_3 value_ns_4 marius.mitrofan@netbears.ro
```

### Test clusters

```
kubectl --context=federation get clusters
kubectl --context=aws get nodes
kubectl --context=azure get nodes
kubectl --context=google get nodes
```

### Create default namespace

```
kubectl --context=federation create namespace "default"
```

### Launch database clusters

```
kubectl --context=federation apply -f ./deployment/db.yaml
```

### Launch wordpress frontend

```
kubectl --context=federation apply -f ./deployment/wordpress.yaml
```

### Set traefik permissions on each cluster

```
kubectl --context=google apply -f ./deployment/traefik-role.yaml
kubectl --context=aws apply -f ./deployment/traefik-role.yaml
kubectl --context=azure apply -f ./deployment/traefik-role.yaml
```

### Create secret with crt/key for webserver

```
cd ssl
kubectl --context=federation create secret generic traefik-cert \
        --from-file=devfest.netbears.com.crt \
        --from-file=devfest.netbears.com.key
cd ../
```

### Launch Traefik deployment


```
kubectl --context=federation apply -f ./deployment/traefik.yaml
```

# Launch Ingress on each cluster
kubectl --context=google apply -f ./deployment/ingress.yaml
kubectl --context=aws apply -f ./deployment/ingress.yaml
kubectl --context=azure apply -f ./deployment/ingress.yaml
