FROM pulsepointinc/centos6-java8:latest

# Install CM server
# Note the repo here should be pinned to specific release version
COPY files/etc/yum.repos.d/cloudera-manager.repo /etc/yum.repos.d/cloudera-manager.repo
RUN yum install -y cloudera-manager-server openldap-clients krb5-workstation krb5-libs

# Add MySQL JDBC driver
RUN \
  mkdir -p -v /usr/share/java && \
  curl -L -o /usr/share/java/mysql-connector-java.jar \
    http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.38/mysql-connector-java-5.1.38.jar

# Add start script
COPY /files/start.sh /

CMD ["cmf-server"]

USER cloudera-scm

EXPOSE 7180
