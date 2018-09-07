#!/bin/bash

source config.sh

DOCKERNAME=mobius-${USER}
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
            mobius:0.1 /bin/install-mobius-db.sh
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
            --publish 7579:7579 \
            mobius:0.1 bash
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
