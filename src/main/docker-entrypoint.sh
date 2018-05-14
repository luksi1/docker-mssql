#!/bin/bash

if [[ ${MSSQL_DATABASE}x == "x" ]]; then
  echo "You must indicate a database name"
  echo "Ex. -e MSSQL_DATBASE=foo"
  exit 1
fi

if [[ ${MSSQL_SA_PASSWORD}x == "x" ]]; then
  echo "You must indicate an SA password"
  echo "Ex. -e MSSQL_SA_PASSWORD=FooBar1234"
  exit 1
fi

if [[ ${MSSQL_USER}x != "x" ]]; then

  if [[ ${MSSQL_PASSWORD}x == "x" ]]; then
    echo "You must indicate a passord for your user"
    echo "Ex. -e MSSQL_PASSWORD=Abcd1234"
    exit 1
  fi
  echo "Adding $MSSQL_USER"
  cp /tmp/01create-user.sql /docker-entrypoint-initdb.d/
fi

for i in /docker-entrypoint-initdb.d/*sql
do
  sed -i "s|MSSQL_USER|${MSSQL_USER}|g" "$i"
  sed -i "s|MSSQL_PASSWORD|${MSSQL_PASSWORD}|g" "$i"
  sed -i "s|MSSQL_DATABASE|${MSSQL_DATABASE}|g" "$i"
done

/docker-entrypoint-initdb.d/run-scripts.sh &

# Start the database
/opt/mssql/bin/sqlservr
