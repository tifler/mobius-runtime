#!/bin/bash

source config.sh

DOCKERNAME=mobius-${HOSTUSER}
DOCKER=nungdo/mobius-docker:latest
#DOCKER=mobius:0.1
NETNAME=vnet-${HOSTUSER}

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
            --env MOBIUS_DB_PORT=${MYSQL_EXPOSE_PORT} \
            --env MOBIUS_DB_HOST=mysql-${HOSTUSER} \
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
            --env MOBIUS_DB_PORT=${MYSQL_EXPOSE_PORT} \
            --env MOBIUS_DB_HOST=mysql-${HOSTUSER} \
            --publish ${MOBIUS_HTTP_PORT}:7579 \
            --publish ${MOBIUS_MQTT_PORT}:1883 \
            ${DOCKER} bash /bin/start-mobius.sh
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
            --env MOBIUS_DB_PORT=${MYSQL_EXPOSE_PORT} \
            --env MOBIUS_DB_HOST=mysql-${HOSTUSER} \
            --publish ${MOBIUS_HTTP_PORT}:7579 \
            --publish ${MOBIUS_MQTT_PORT}:1883 \
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
