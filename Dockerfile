FROM mcr.microsoft.com/mssql/server:2019-latest

# Generated SSL certificates will be placed inside $CERTS_ROOT/certs
ENV CERTS_ROOT /etc/mssql

USER root

RUN apt-get update && apt-get -y upgrade \
	&& apt-get install -y --no-install-recommends curl python3 \
	&& rm -rf /var/lib/apt/lists/*

ADD ./createCerts.sh ${CERTS_ROOT}/
ADD ./docker-entrypoint-custom.sh /
ADD ./mssql.conf /var/opt/mssql/mssql.conf

ENV DEV_MODE false

ENTRYPOINT [ "/docker-entrypoint-custom.sh"]