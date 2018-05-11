FROM microsoft/mssql-server-linux:latest

ENV ACCEPT_EULA=Y
ENV MSSQL_SA_PASSWORD=FooBar123
ENV MSSQL_PID=Developer

RUN apt-get -y update  && \
    apt-get install -y netcat

RUN mkdir /docker-entrypoint-initdb.d/
COPY scripts/* /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/*.sh

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

CMD /bin/bash /docker-entrypoint.sh 

EXPOSE 1433
