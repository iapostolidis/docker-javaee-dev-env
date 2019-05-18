#!/bin/bash

JBOSS_HOME=/opt/jboss/wildfly
JBOSS_CLI=$JBOSS_HOME/bin/jboss-cli.sh
JBOSS_MODE=${1:-"standalone"}
JBOSS_CONFIG=${2:-"standalone-ha.xml"}

function wait_for_wildfly() {
  until `$JBOSS_CLI -c "ls /deployment" &> /dev/null`; do
    sleep 1
  done
}

echo "==> Starting WildFly..."
$JBOSS_HOME/bin/$JBOSS_MODE.sh -c $JBOSS_CONFIG > /dev/null &

echo "==> Waiting..."
wait_for_wildfly

echo "==> Executing 'batch_jdbc_driver.cli' ..."
$JBOSS_CLI -c --file=`dirname "$0"`/batch_jdbc_driver.cli

echo "==> Executing 'batch_jdbc_connections.cli' ..."
$JBOSS_CLI -c --file=`dirname "$0"`/batch_jdbc_connections.cli
$JBOSS_CLI -c ":reload"

echo "==> Executing 'batch_undertow_cors_filters.cli' ..."
$JBOSS_CLI -c --file=`dirname "$0"`/batch_undertow_cors_filters.cli

echo "==> executing 'batch_jgroups.cli' ..."
$JBOSS_CLI -c --file=`dirname "$0"`/batch_jgroups.cli
$JBOSS_CLI -c ":reload"

echo "==> executing 'batch_infinispan_service.cli' ..."
$JBOSS_CLI -c --file=`dirname "$0"`/batch_infinispan_service.cli

echo "==> Shutting down WildFly..."
$JBOSS_CLI -c ":shutdown"
