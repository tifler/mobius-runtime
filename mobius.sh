#!/bin/bash

source config.sh

DOCKERNAME=mobius-${HOSTUSER}
DOCKER=nungdo/mobius-docker:latest
#DOCKER=mobius:0.1

case "$1" in
    install)
        echo -n "Starting docker: "
        docker \
            run -it \
            --rm \
            --name ${DOCKERNAME} \
            --env MOBIUS_DB_PASS=${MARIA_DB_PASS} \
            --env MOBIUS_DB_PORT=${MARIA_DB_PORT} \
            --env MOBIUS_DB_HOST=${MARIA_DB_HOST} \
            ${DOCKER} /bin/install-mobius-db.sh
    ;;
    start)
        echo -n "Starting docker: "
        docker \
            run -it \
            --rm \
            --name ${DOCKERNAME} \
            --env MOBIUS_DB_PASS=${MARIA_DB_PASS} \
            --env MOBIUS_DB_PORT=${MARIA_DB_PORT} \
            --env MOBIUS_DB_HOST=${MARIA_DB_HOST} \
            --publish ${MOBIUS_HTTP_PORT}:7579 \
            --publish ${MOBIUS_MQTT_PORT}:1883 \
            ${DOCKER} bash /bin/start-mobius.sh
    ;;
    bash)
        echo -n "Starting docker: "
        docker \
            run -it \
            --rm \
            --name ${DOCKERNAME} \
            --env MOBIUS_DB_PASS=${MARIA_DB_PASS} \
            --env MOBIUS_DB_PORT=${MARIA_DB_PORT} \
            --env MOBIUS_DB_HOST=${MARIA_DB_HOST} \
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
