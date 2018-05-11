#!/bin/bash

# Run all the sql scripts
while ! nc -z localhost 1433
do
  echo "Database is not available yet. Waiting..."
  sleep 1
done

sleep 10

for i in `ls /docker-entrypoint-initdb.d/*sql | sort`
do
  chmod +x $i
  /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P ${MSSQL_SA_PASSWORD} -d master -i $i
done

