ARG UBUNTU_VERSION=24.04
FROM ubuntu:$UBUNTU_VERSION

ARG UBUNTU_VERSION
ARG MSSQLTOOLS_LOCALE=en_US.UTF-8

# Microsoft's versioning convention for ubuntu packages includes '-1'
ARG MSSQLTOOLS_VERSION=18.4.1.1-1
ARG MSSQLTOOLS_PATH=/opt/mssql-tools18/bin

# install dependencies
# ref: https://github.com/microsoft/mssql-docker/blob/master/linux/mssql-tools/Dockerfile.ubuntu2204
RUN apt-get update \
    && apt-get install -y curl apt-transport-https debconf-utils gnupg2 locales

# add the signature to trust the Microsoft repo
RUN curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | \
    gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg

# add repo to apt sources
RUN curl -fsSL https://packages.microsoft.com/config/ubuntu/${UBUNTU_VERSION}/prod.list | \
    tee /etc/apt/sources.list.d/mssql-release.list

# ref: https://learn.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-ver16&tabs=ubuntu18-install%2Cubuntu17-install%2Cdebian8-install%2Credhat7-13-install%2Crhel7-offline#18
RUN apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql18=${MSSQLTOOLS_VERSION} mssql-tools18=${MSSQLTOOLS_VERSION} unixodbc-dev

# update locale
RUN rm -rf /var/lib/apt/lists/* \
    && locale-gen ${MSSQLTOOLS_LOCALE} \
    && update-locale LANG=${MSSQLTOOLS_LOCALE}

# add SQL tools to $PATH
ENV PATH=$PATH:${MSSQLTOOLS_PATH}
CMD ["/bin/bash"]