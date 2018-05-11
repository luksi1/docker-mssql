#!/bin/bash

if [[ ${MSSQL_DATABASE_NAME}x == "x" ]]; then
  echo "You must indicate a database name"
  echo "Ex. export MSSQL_DATBASE_NAME=foo"
  exit 1
fi

sed -i "s|MY_DATABASE_NAME|${MSSQL_DATABASE_NAME}|g" /docker-entrypoint-initdb.d/0create-database.sql

/docker-entrypoint-initdb.d/run-scripts.sh &

# Start the database
/opt/mssql/bin/sqlservr
