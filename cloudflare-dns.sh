#!/bin/bash

set -e

export ZONE_ID=$(cat ~/.cloudflare/zone)
export AUTH_EMAIL="USERNAME"
export AUTH_TOKEN=$(cat ~/.cloudflare/api)

curl -X POST "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records" \
     -H "X-Auth-Email: $AUTH_EMAIL" \
     -H "X-Auth-Key: $AUTH_TOKEN" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"DOMAIN","content":"NS1","ttl":120,"proxied":false}' > /dev/null 2>&1

curl -X POST "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records" \
     -H "X-Auth-Email: $AUTH_EMAIL" \
     -H "X-Auth-Key: $AUTH_TOKEN" \
     -H "Content-Type: application/json" \
     --data '{"type":"NS","name":"DOMAIN","content":"NS2","ttl":120,"proxied":false}' > /dev/null 2>&1

curl -X POST "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records" \
     -H "X-Auth-Email: $AUTH_EMAIL" \
     -H "X-Auth-Key: $AUTH_TOKEN" \
     -H "Content-Type: application/json" \
     --data '{"type":"NS","name":"DOMAIN","content":"NS3","ttl":120,"proxied":false}' > /dev/null 2>&1

curl -X POST "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records" \
     -H "X-Auth-Email: $AUTH_EMAIL" \
     -H "X-Auth-Key: $AUTH_TOKEN" \
     -H "Content-Type: application/json" \
     --data '{"type":"NS","name":"DOMAIN","content":"NS4","ttl":120,"proxied":false}' > /dev/null 2>&1

echo "Finished attempt of setting up NS records in CloudFlare."
