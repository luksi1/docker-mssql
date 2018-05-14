# MS SQL image with support for docker-entrypoint.d

## Description

The default MS SQL image does not support running scripts on start, even if this is a more or less de facto
way of producing Docker database images. This image attempts to bring the MS SQL image up to snuff.

Additionally, there is support for a database user and database via environmental variables.

## Usage

### Environment variables

This image provides the same environment variables as the parent image with the addition of a MSSQL_USER, MSSQL_PASSWORD, and MSSQL_DATABASE account

#### MSSQL_USER

A SQL user that will get DBO access on MSSQL_DATABASE

#### MSSQL_PASSWORD

The password for MSSQL_USER

#### MSSQL_DATABASE

A SQL database this will be created on start. MSSQL_USER will have DBO access to this database.

#### MSSQL_SA_PASSWORD

The sysdba password for the instance.

## Examples

### Command line

```
docker run --rm -e MSSQL_USER=TEST -e MSSQL_PASSWORD=Abcd1234 -e MSSQL_SA_PASSWORD=Abcd1234 -e MSSQL_DATABASE=test -t luksi1/mssql:latest
```

### docker-maven-plugin
```
<image>
        <name>luksi1/mssql:latest</name>
        <run>
                <portPropertyFile>/tmp/mssql.port.properties</portPropertyFile>
                <env>
                        <MSSQL_USER>test</MSSQL_USER>
                        <MSSQL_PASSWORD>Abcd1234</MSSQL_PASSWORD>
                        <MSSQL_SA_PASSWORD>Abcd1234</MSSQL_SA_PASSWORD>
                        <MSSQL_DATABASE>test</MSSQL_DATABASE>
                </env>
                <wait>
                        <time>60000</time>
                </wait>
                <ports>
                        <port>database.random.port:${database.port}</port>
                </ports>
        </run>
</image>

```

Note: Notice the use of a portPropertyFile so that you can obtain the random port allocated to MSSQL in your flow!

