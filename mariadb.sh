#!/bin/bash

source config.sh

DOCKERNAME=mariadb-${HOSTUSER}

case "$1" in
    start)
        echo -n "Starting docker: "
        docker \
            run \
            --rm \
            --detach \
            --volume ${MARIA_DB_HOST_PATH}:/var/lib/mysql \
            --env MYSQL_ROOT_PASSWORD=${MARIA_ROOT_PASSWORD} \
            --name ${DOCKERNAME} \
            --publish=${MARIA_DB_PORT}:${MARIA_DB_PORT} \
            mariadb:latest
    ;;
    stop)
        echo -n "Stopping docker: "
        docker stop ${DOCKERNAME}
    ;;
    *)
        echo "Usage: $0 {start|stop}"
        exit 1
    ;;
esac

exit 0
