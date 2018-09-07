#!/bin/bash

source config.sh

docker stop mysql-${USER} mobius-${USER}
docker rm mysql-${USER} mobius-${USER}
docker network rm vnet-${USER}
