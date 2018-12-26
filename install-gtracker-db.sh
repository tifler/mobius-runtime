#!/bin/bash

source config.sh

echo "Step 1/6 --"
echo "create database GTRACKERDATADB;" | mysql -u ${MARIA_DB_USER} --password=${MARIA_DB_PASS} --protocol=tcp --host=${MARIA_DB_HOST} --port=${MARIA_DB_PORT}
echo "Step 2/6 --"
echo "create database PASSCODEDB;" | mysql -u ${MARIA_DB_USER} --password=${MARIA_DB_PASS} --protocol=tcp --host=${MARIA_DB_HOST} --port=${MARIA_DB_PORT}
echo "Step 3/6 --"
echo "create database APIKEYDB;" | mysql -u ${MARIA_DB_USER} --password=${MARIA_DB_PASS} --protocol=tcp --host=${MARIA_DB_HOST} --port=${MARIA_DB_PORT}
echo "Step 4/6 --"
cat ${GTRACKER_BASE}/db/sql/GtrackerdataDB_create_tables.sql | mysql -u ${MARIA_DB_USER} --password=${MARIA_DB_PASS} --protocol=tcp --host=${MARIA_DB_HOST} --port=${MARIA_DB_PORT} --database=GTRACKERDATADB
echo "Step 5/6 --"
cat ${GTRACKER_BASE}/db/sql/PasscodeDB_create_tables.sql | mysql -u ${MARIA_DB_USER} --password=${MARIA_DB_PASS} --protocol=tcp --host=${MARIA_DB_HOST} --port=${MARIA_DB_PORT} --database=PASSCODEDB
echo "Step 6/6 --"
cat ${GTRACKER_BASE}/db/sql/APIKEYDB_create_tables.sql | mysql -u ${MARIA_DB_USER} --password=${MARIA_DB_PASS} --protocol=tcp --host=${MARIA_DB_HOST} --port=${MARIA_DB_PORT} --database=APIKEYDB
