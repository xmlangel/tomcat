#!/bin/bash
CUR_PATH=$(pwd)
docker run -d -p 8080:8080 -p 8009:8009 -v $CUR_PATH/webapps:/opt/tomcat/webapps --name tomcat8 xmlangel/tomcat
