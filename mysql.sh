#!/bin/bash

source config.sh

DOCKERNAME=mysql-${HOSTUSER}
NETNAME=vnet-${HOSTUSER}

case "$1" in
    start)
        echo -n "Creating private network: "
        docker network create ${NETNAME}

        echo -n "Starting docker: "
        docker \
            run \
            --rm \
            --detach \
            --volume ${MYSQL_DB_HOST_PATH}:/var/lib/mysql \
            --env MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} \
            --network ${NETNAME} \
            --name ${DOCKERNAME} \
            mysql:5.7
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
