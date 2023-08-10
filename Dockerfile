FROM mcr.microsoft.com/mssql/server:2019-latest

# Generated SSL certificates will be placed inside $CERTS_ROOT/certs
ENV CERTS_ROOT /etc/mssql
ENV DEBIAN_FRONTEND=noninteractive
ENV ACCEPT_EULA=Y

USER root

RUN apt-get update && apt-get -y upgrade \
	&& apt-get install -y --no-install-recommends curl python3 \
	&& rm -rf /var/lib/apt/lists/*

ADD ./createCerts.sh ${CERTS_ROOT}/
ADD ./docker-entrypoint-custom.sh /
ADD ./mssql.conf /var/opt/mssql/mssql.conf

# Set this to true if you are running this on local machine instead of AWS EC2
ENV DEV_MODE false

ENTRYPOINT [ "/docker-entrypoint-custom.sh"]