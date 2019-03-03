FROM pantsoft.de:5000/wildfly-dev:latest
LABEL maintainer="Ioannis Apostolidis"

# Add configuration script (standalone-ha.xml)
ADD config.sh /tmp/

# Add JDBC Driver, JDBC Datasources and CORS Configuration
ADD batch_jdbc_driver.cli /tmp/
ADD batch_jdbc_connections.cli /tmp/
ADD batch_undertow_cors_filters.cli /tmp/

# Add JGroup/Infinispan example configuration
ADD batch_infinispan_example.cli /tmp/

# Configure Wildfly
USER root
RUN rm -fr /opt/jboss/wildfly/modules/org/postgresql
RUN chmod +x /tmp/config.sh
RUN /tmp/config.sh
RUN chown -R jboss:0 /opt/jboss/wildfly/standalone

USER jboss

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-c", "standalone-ha.xml", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0", "-u", "230.0.0.4", "--debug", "*:8787"]

EXPOSE 8080 9990 8787
