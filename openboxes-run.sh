#!/bin/bash

# Set the path to the MySQL socket file
export MYSQL_SOCKET=/var/run/mysqld/mysqld.sock

# Set the JAVA_HOME environment variable
export JAVA_HOME=/usr/lib/jvm/zulu-8-amd64

# grails doesn't run without it for some reason
export GRAILS_OPTS="-XX:-UseSplitVerifier -Xverify:none"

if [ ! -f /app/web-app/WEB-INF/applicationContext.xml ]; then
   echo "Forcing grails upgrade"
   grails upgrade --force --stacktrace
fi

# Install Node.js and npm
curl -sL https://deb.nodesource.com/setup_14.x | bash -
apt-get install -y nodejs

npm cache clean --force
npm i -g npm@6.14.6
npm config set engine-strict true

# some dependencies don't get resolved on their own
npm i --no-package-lock --legacy-peer-deps --force --verbose

grails run-app --stacktrace

# if you want to compile enable this and stop grails run-app
# grails -Dgrails.env=staging war
