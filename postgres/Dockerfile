FROM postgres:11.2
LABEL maintainer="Ioannis Apostolidis"

# use custom script to initialize database
ADD init-user-db.sh /docker-entrypoint-initdb.d/init-user-db.sh
