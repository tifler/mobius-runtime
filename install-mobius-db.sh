#!/bin/bash

source config.sh

echo "Step 1/3 --"
echo "create database mobiusdb;" | mysql -u ${MARIA_DB_USER} --password=${MARIA_DB_PASS} --host=${MARIA_DB_HOST} --port=${MARIA_DB_PORT}
echo "Step 2/3 --"
cat ${MOBIUS_BASE}/mobius/mobiusdb.sql | mysql -u ${MARIA_DB_USER} --password=${MARIA_DB_PASS} --host=${MARIA_DB_HOST} --port=${MARIA_DB_PORT} --database=mobiusdb
echo "Step 3/3 --"
