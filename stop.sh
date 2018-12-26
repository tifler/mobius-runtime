#!/bin/bash

source config.sh

docker stop mysql-${HOSTUSER} mobius-${HOSTUSER}
docker rm mysql-${HOSTUSER} mobius-${HOSTUSER}
