#/bin/bash

curl -Lo /tmp/dcevm.tar.gz https://github.com/TravaOpenJDK/trava-jdk-11-dcevm/releases/download/dcevm-11.0.1%2B8/java11-openjdk-dcevm-linux.tar.gz
tar -xf /tmp/dcevm.tar.gz dcevm-11.0.1+8/lib/server/libjvm.so

docker build --pull --no-cache -t pantsoft.de:5000/wildfly-dev .
exit 0
