#!/bin/bash

source config.sh

DOCKERNAME=mobius-${USER}
DOCKER=nungdo/mobius-docker:latest
NETNAME=vnet-${USER}

case "$1" in
    install)
        echo -n "Creating private network: "
        docker network create ${NETNAME}
        echo -n "Starting docker: "
        docker \
            run -it \
            --rm \
            --network ${NETNAME} \
            --name ${DOCKERNAME} \
            --env MOBIUS_DB_PASS=${MYSQL_ROOT_PASSWORD} \
            --env MOBIUS_DB_HOST=mysql-${USER} \
            ${DOCKER} /bin/install-mobius-db.sh
    ;;
    start)
        echo -n "Creating private network: "
        docker network create ${NETNAME}
        echo -n "Starting docker: "
        docker \
            run -it \
            --rm \
            --network ${NETNAME} \
            --name ${DOCKERNAME} \
            --env MOBIUS_DB_PASS=${MYSQL_ROOT_PASSWORD} \
            --env MOBIUS_DB_HOST=mysql-${USER} \
            --publish ${MOBIUS_PORT}:7579 \
            ${DOCKER} node mobius.js
    ;;
    bash)
        echo -n "Creating private network: "
        docker network create ${NETNAME}
        echo -n "Starting docker: "
        docker \
            run -it \
            --rm \
            --network ${NETNAME} \
            --name ${DOCKERNAME} \
            --env MOBIUS_DB_PASS=${MYSQL_ROOT_PASSWORD} \
            --env MOBIUS_DB_HOST=mysql-${USER} \
            --publish ${MOBIUS_PORT}:7579 \
            ${DOCKER} bash
    ;;
    stop)
        echo -n "Stopping docker: "
        docker stop ${DOCKERNAME}
        echo -n "Removing docker: "
        docker rm ${DOCKERNAME}
    ;;
    *)
        echo "Usage: $0 {start|stop}"
        exit 1
    ;;
esac

exit 0
