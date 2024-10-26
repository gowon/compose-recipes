#!/bin/bash

set -e
set -u

: ${MSSQL_HOST_CONNECTION_MAX_RETRIES:=5}
: ${MSSQL_HOST_CONNECTION_RETRY_WAIT_SECONDS:=3}

attempts=0
connected=0
while [ $connected -eq 0 ]; do
    attempts=$((attempts+1))
    exit_code=0
    echo "run-scripts: Attempting to connect to server '${MSSQL_HOST}'..."
    sqlcmd -S $MSSQL_HOST -U sa -P $MSSQL_SA_PASSWORD -Q "SELECT 1" -C -b -o /dev/null || exit_code=1

    if [ $exit_code -eq 1 ]; then
        if [ $attempts -eq $MSSQL_HOST_CONNECTION_MAX_RETRIES ]; then
            echo "run-scripts: Failed to connect to server '${MSSQL_HOST}' ${attempts} times. Exiting..."
            exit 1
        fi

        echo "run-scripts: Connection attempt (${attempts}) failed. Waiting ${MSSQL_HOST_CONNECTION_RETRY_WAIT_SECONDS} seconds to retry..."
        sleep $MSSQL_HOST_CONNECTION_RETRY_WAIT_SECONDS
    else
        echo "run-scripts: Successfully connected to server ${MSSQL_HOST}."
        connected=1
    fi
done

echo "run-scripts: Running SQL scripts..."

for file in /var/scripts/*.sql; do
    # ref: https://stackoverflow.com/a/43606356
    [ -e "$file" ] || continue
    echo "run-scripts: Executing '$file'."
    sqlcmd -S $MSSQL_HOST -U sa -P $MSSQL_SA_PASSWORD -i $file -C || {
        echo "run-scripts: Error occured while executing '${file}'. Exiting..."
        exit 2
    }
    echo "run-scripts: Finished executing '${file}'."
done

echo "run-scripts: SQL scripts complete."