FROM pulsepointinc/centos6-java8:latest

# Install CM server
# Note the repo here should be pinned to specific release version
COPY files/etc/yum.repos.d/cloudera-manager.repo /etc/yum.repos.d/cloudera-manager.repo
RUN \
  rpm --rebuilddb && \
  yum install -y \
    cloudera-manager-server \
    ntp & \
  yum clean all

# Add MySQL JDBC driver
RUN \
  mkdir -p -v /usr/share/java && \
  curl -s -L -o /usr/share/java/mysql-connector-java.jar \
    http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.39/mysql-connector-java-5.1.39.jar

# Add Kudu Custom Service Descriptor
RUN \
  mkdir -p -v /opt/cloudera/csd && \
  curl -s -L -o /opt/cloudera/csd/judu.jar \
    http://archive.cloudera.com/beta/kudu/csd/KUDU-1.0.0.jar

# Add start script
COPY /files/start.sh /

CMD ["cmf-server"]

USER cloudera-scm

EXPOSE 7180
