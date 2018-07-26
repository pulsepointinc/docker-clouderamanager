FROM pulsepointinc/docker-centos7.5-java8

# Install CM server
# Note the repo here should be pinned to specific release version
COPY files/etc/yum.repos.d/cloudera-manager.repo /etc/yum.repos.d/cloudera-manager.repo
RUN \
  rpm --rebuilddb && \
  yum install -y \
    cloudera-manager-server \
    ntp && \
  yum clean all

# Add MySQL JDBC driver
RUN \
  mkdir -p -v /usr/share/java && \
  curl -s -L -o /usr/share/java/mysql-connector-java.jar \
    "http://central.maven.org/maven2/mysql/mysql-connector-java/8.0.11/mysql-connector-java-8.0.11.jar"

# Add start script
COPY /files/start.sh /

CMD ["cmf-server"]

USER cloudera-scm

EXPOSE 7180
