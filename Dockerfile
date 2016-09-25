FROM xmlangel/oracle-jdk:8u102

MAINTAINER Kwangmyung Kim <kwangmyung.kim@gmail.com>

ENV TOMCAT_VERSION 8.0.37

#add user
RUN useradd -ms /bin/bash tomcat

# Get Tomcat
RUN wget --quiet --no-cookies http://apache.rediris.es/tomcat/tomcat-8/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O /tmp/tomcat.tgz \
&& tar xzvf /tmp/tomcat.tgz -C /opt\
&& mv /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat \
&& rm /tmp/tomcat.tgz \
&& rm -rf /opt/tomcat/webapps/examples \
&& rm -rf /opt/tomcat/webapps/docs \
&& rm -rf /opt/tomcat/webapps/ROOT

# Add admin/admin user
ADD tomcat-users.xml /opt/tomcat/conf/

ENV CATALINA_HOME /opt/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin

EXPOSE 8080

EXPOSE 8009

RUN chown tomcat:tomcat -R $CATALINA_HOME

VOLUME "/opt/tomcat/webapps"

WORKDIR /opt/tomcat

USER tomcat

# Launch Tomcat
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
