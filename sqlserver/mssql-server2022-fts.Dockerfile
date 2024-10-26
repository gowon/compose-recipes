# ref: https://github.com/tspence/docker-examples/blob/086fa3539045e60c747a27c3c16329a380746201/sqlserver-fulltext/Dockerfile
FROM mcr.microsoft.com/mssql/server:2022-CU15-GDR1-ubuntu-22.04

ARG MSSQLTOOLS_PATH=/opt/mssql-tools18/bin
ARG OTELCOL_VERSION=0.112.0

# switch to root to perform the following commands
USER root

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# install dependencies
RUN apt-get update \
    && apt-get install -y curl apt-transport-https gnupg2 supervisor

# install otel collector    
RUN curl -fsSLO https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/v${OTELCOL_VERSION}/otelcol-contrib_${OTELCOL_VERSION}_linux_amd64.deb \
    && dpkg -i otelcol-contrib_${OTELCOL_VERSION}_linux_amd64.deb > /dev/null

# add the signature to trust the Microsoft repo
RUN curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | \
    gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg

# add repo to apt sources
RUN curl -fsSL https://packages.microsoft.com/config/ubuntu/22.04/mssql-server-2022.list | \
    tee /etc/apt/sources.list.d/mssql-server-2022.list

# install SQL Server full-text-search
RUN apt-get update \
    && apt-get install -y mssql-server-fts

# cleanup
RUN apt-get clean \
    && rm -f otelcol-contrib_${OTELCOL_VERSION}_linux_amd64.deb \
    && rm -rf /var/lib/apt/lists/*

# set permissions for supervisord directories
RUN mkdir -p /var/run /var/log/supervisor \
    && chown mssql /var/run /var/log/supervisor

# Add SQL Server tools to $PATH
ENV PATH=$PATH:${MSSQLTOOLS_PATH}

# Disable OpenTelemetry Collector first
ENV USE_OTELCOL=false

# ref: https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-docker-container-security?view=sql-server-linux-ver16
# run as non-root user
USER mssql
ENTRYPOINT ["/opt/mssql/bin/permissions_check.sh"]
CMD ["/usr/bin/supervisord"]