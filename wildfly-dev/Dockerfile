FROM jboss/wildfly:16.0.0.Final
LABEL maintainer="Ioannis Apostolidis"

# Add HotSwap
RUN curl -Lo /tmp/dcevm.tar.gz https://github.com/TravaOpenJDK/trava-jdk-11-dcevm/releases/download/dcevm-11.0.1%2B8/java11-openjdk-dcevm-linux.tar.gz
RUN tar -xf /tmp/dcevm.tar.gz dcevm-11.0.1+8/lib/server/libjvm.so

USER root
RUN cp dcevm-11.0.1+8/lib/server/libjvm.so /etc/alternatives/java_sdk/lib/server/

# Download PostgreSQL JDBC Driver
RUN curl -o /tmp/psql-jdbc.jar https://jdbc.postgresql.org/download/postgresql-42.2.5.jar

# Download MariaDB JDBC Driver
RUN curl -o /tmp/mariadb-jdbc.jar http://downloads.mariadb.com/Connectors/java/connector-java-2.4.0/mariadb-java-client-2.4.0.jar

# Setup administrator user
RUN /opt/jboss/wildfly/bin/add-user.sh admin Admin#007 --silent

# Add configuration script (standalone.xml)
ADD config.sh /tmp/

# Add JDBC Driver, JDBC Datasources and CORS Configuration
ADD batch_jdbc_driver.cli /tmp/
ADD batch_jdbc_connections.cli /tmp/
ADD batch_undertow_cors_filters.cli /tmp/

# Configure Wildfly
USER root
RUN chmod +x /tmp/config.sh
RUN /tmp/config.sh
RUN chown -R jboss:0 /opt/jboss/wildfly && \
    chmod -R ug+rwX /opt/jboss/wildfly

USER jboss

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-c", "standalone.xml", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0", "--debug", "*:8787"]

EXPOSE 8080 9990 8787
