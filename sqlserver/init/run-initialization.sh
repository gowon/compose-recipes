#!/bin/bash

set -e
set -u

/opt/mssql-tools/bin/sqlcmd -?
echo "Running initialization scripts..."
/opt/mssql-tools/bin/sqlcmd -S $MSSQL_HOST -U sa -P $MSSQL_SA_PASSWORD -i /init/create-database.sql
echo "Initialization scripts complete."