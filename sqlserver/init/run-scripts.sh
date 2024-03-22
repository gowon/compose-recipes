#!/bin/bash

set -e
set -u

# show tool version
/opt/mssql-tools/bin/sqlcmd -?

# check connection
/opt/mssql-tools/bin/sqlcmd -S $MSSQL_HOST -U sa -P $MSSQL_SA_PASSWORD -Q "SELECT 1" -b -o /dev/null
if [ $? -eq 0 ]; then
    echo "init: Running SQL scripts..."
    for f in /init/*.sql; do
        echo "init: Executing '$f'"
        /opt/mssql-tools/bin/sqlcmd -S $MSSQL_HOST -U sa -P $MSSQL_SA_PASSWORD -i $f || break
    done
    echo "init: SQL scripts complete."
else
    echo "init: Failed to connect to server."
fi