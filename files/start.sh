#!/bin/sh

## Read db config from env
DB_TYPE=${DB_TYPE:-mysql}
DB_HOST=${DB_HOST:-localhost}
DB_NAME=${DB_NAME:-cmandb}
DB_USER=${DB_USER:-cmanuser}
DB_PASSWORD=${DB_PASSWORD:-cmanpass}

## Write out db config file
cat > /etc/cloudera-scm-server/db.properties << EOF
com.cloudera.cmf.db.type=${DB_TYPE}
com.cloudera.cmf.db.host=${DB_HOST}
com.cloudera.cmf.db.name=${DB_NAME}
com.cloudera.cmf.db.user=${DB_USER}
com.cloudera.cmf.db.password=${DB_PASSWORD}
EOF

## Default env
export CMF_JDBC_DRIVER_JAR=${CMF_JDBC_DRIVER_JAR:-/usr/share/java/mysql-connector-java.jar:/usr/share/java/oracle-connector-java.jar}
export CMF_JAVA_OPTS=${CMF_JAVA_OPTS:--Xmx2G -XX:MaxPermSize=256m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/tmp -Dcmf.root.logger=INFO,LOGFILE,CONSOLE}

## Log config and env for troubleshooting
cat 1>&2 << EOF
/etc/cloudera-scm-server/db.properties:
$(cat /etc/cloudera-scm-server/db.properties)

env:
$(env)

/usr/sbin/cmf-server:
EOF

exec /usr/sbin/cmf-server $*
