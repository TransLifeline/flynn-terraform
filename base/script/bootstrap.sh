#! /bin/bash

sudo \
CLUSTER_DOMAIN=$1 \
flynn-host bootstrap \
--min-hosts 3 \
--discovery $2
