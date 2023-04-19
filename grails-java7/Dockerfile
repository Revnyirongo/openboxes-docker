FROM azul/zulu-openjdk:8

MAINTAINER Michael Seaton <mseaton@pih.org>

# Environment variables
ENV JAVA_HOME=/usr/lib/jvm/zulu-8-amd64
ENV SDKMAN_DIR /root/.sdkman
ENV GRAILS_VERSION 4.0.12

# Install required packages
RUN apt-get update && \
    apt-get install -y curl zip python2 g++ make gcc build-essential nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install SDKMAN
RUN curl -s "https://get.sdkman.io" | bash
RUN chmod a+x "$SDKMAN_DIR/bin/sdkman-init.sh"

# Set configuration options for SDKMAN
RUN echo "sdkman_auto_answer=true" > $SDKMAN_DIR/etc/config \
    && echo "sdkman_auto_selfupdate=false" >> $SDKMAN_DIR/etc/config \
    && echo "sdkman_curl_connect_timeout=20" >> $SDKMAN_DIR/etc/config \
    && echo "sdkman_curl_max_time=0" >> $SDKMAN_DIR/etc/config \
    && echo "sdkman_insecure_ssl=false" >> $SDKMAN_DIR/etc/config

# Set up SDKMAN and install Grails
WORKDIR $SDKMAN_DIR
RUN /bin/bash -c "source /root/.sdkman/bin/sdkman-init.sh && sdk install grails $GRAILS_VERSION && sdk default grails $GRAILS_VERSION"

# Set environment variables
ENV GRAILS_HOME $SDKMAN_DIR/candidates/grails/current
ENV PATH $GRAILS_HOME/bin:$PATH
ENV GRAILS_OPTS -XX:-UseSplitVerifier -Xverify:none

# Set the directory that an existing Grails app should be mounted into with a volume
RUN mkdir /app
WORKDIR /app

EXPOSE 8080

CMD ["grails"]
