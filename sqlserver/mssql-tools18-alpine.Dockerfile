ARG ALPINE_ARCH=amd64
ARG ALPINE_VERSION=3.20
FROM ${ALPINE_ARCH}/alpine:${ALPINE_VERSION}

# all package minor versions seem to exist in the same dist folder, the next major version increase will likely require a completely new download URL
ARG ALPINE_ARCH
ARG MSSQLTOOLS_VERSION=18.4.1.1
ARG MSSQLTOOLS_PATH=/opt/mssql-tools18/bin

# install dependencies
RUN apk --no-cache add bash curl gnupg

# download the desired packages
# ref: https://learn.microsoft.com/en-us/sql/connect/odbc/download-odbc-driver-for-sql-server?view=sql-server-ver16#alpine
# ref: https://learn.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-ver16&tabs=alpine18-install%2Cubuntu17-install%2Cdebian8-install%2Credhat7-13-install%2Crhel7-offline#18
RUN curl -fsSLO https://download.microsoft.com/download/7/6/d/76de322a-d860-4894-9945-f0cc5d6a45f8/msodbcsql18_${MSSQLTOOLS_VERSION}-1_${ALPINE_ARCH}.apk \
    && curl -fsSLO https://download.microsoft.com/download/7/6/d/76de322a-d860-4894-9945-f0cc5d6a45f8/mssql-tools18_${MSSQLTOOLS_VERSION}-1_${ALPINE_ARCH}.apk

# verify signature
RUN curl -fsSLO https://download.microsoft.com/download/7/6/d/76de322a-d860-4894-9945-f0cc5d6a45f8/msodbcsql18_${MSSQLTOOLS_VERSION}-1_${ALPINE_ARCH}.sig \
    && curl -fsSLO https://download.microsoft.com/download/7/6/d/76de322a-d860-4894-9945-f0cc5d6a45f8/mssql-tools18_${MSSQLTOOLS_VERSION}-1_${ALPINE_ARCH}.sig

RUN curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --import - \
    && gpg --verify msodbcsql18_${MSSQLTOOLS_VERSION}-1_${ALPINE_ARCH}.sig msodbcsql18_${MSSQLTOOLS_VERSION}-1_${ALPINE_ARCH}.apk \
    && gpg --verify mssql-tools18_${MSSQLTOOLS_VERSION}-1_${ALPINE_ARCH}.sig mssql-tools18_${MSSQLTOOLS_VERSION}-1_${ALPINE_ARCH}.apk

# install the packages then cleanup
RUN apk add --allow-untrusted msodbcsql18_${MSSQLTOOLS_VERSION}-1_${ALPINE_ARCH}.apk \
    && apk add --allow-untrusted mssql-tools18_${MSSQLTOOLS_VERSION}-1_${ALPINE_ARCH}.apk \
    && rm -f msodbcsql18_${MSSQLTOOLS_VERSION}-1_${ALPINE_ARCH}.apk mssql-tools18_${MSSQLTOOLS_VERSION}-1_${ALPINE_ARCH}.apk

# add SQL tools to $PATH
ENV PATH=$PATH:${MSSQLTOOLS_PATH}
CMD ["/bin/bash"]