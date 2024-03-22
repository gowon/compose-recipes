# ref: https://github.com/tspence/docker-examples/blob/086fa3539045e60c747a27c3c16329a380746201/sqlserver-fulltext/Dockerfile
FROM mcr.microsoft.com/mssql/server:2022-CU12-ubuntu-22.04

# Switch to root to install fulltext - apt-get won't work unless you switch users!
USER root

# Install dependencies - these are required to make changes to apt-get below
RUN apt-get update
RUN apt-get install -yq gnupg gnupg2 gnupg1 curl apt-transport-https

# Install SQL Server package links
# ref: https://learn.microsoft.com/en-us/sql/linux/quickstart-install-connect-ubuntu?view=sql-server-ver16&tabs=ubuntu2204#install
RUN curl -fsSL https://packages.microsoft.com/keys/microsoft.asc -o /var/opt/mssql/ms-key.cer
RUN apt-key add /var/opt/mssql/ms-key.cer
RUN curl -fsSL https://packages.microsoft.com/config/ubuntu/22.04/mssql-server-2022.list -o /etc/apt/sources.list.d/mssql-server-2022.list
RUN apt-get update

# Install SQL Server full-text-search - this only works if you add the packages references into apt-get above
RUN apt-get install -y mssql-server-fts

# Cleanup
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists

# Run SQL Server process
USER mssql
ENTRYPOINT ["/opt/mssql/bin/permissions_check.sh"]
CMD ["/opt/mssql/bin/sqlservr"]