FROM debian:jessie

# Add Debian backports
RUN echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list

# Install Android SDK dependencies

## Install Java 8
RUN apt-get update && \
    apt-get install -y -t jessie-backports \
    	    openjdk-8-jdk-headless \
	    openjdk-8-jre-headless

# Install Android SDK command line tools
RUN mkdir /usr/local/android_sdk

RUN apt-get install -y \
    	    unzip \
    	    wget && \
	    wget --quiet https://dl.google.com/android/repository/tools_r25.2.3-linux.zip && \
	    unzip tools_r25.2.3-linux.zip -d /usr/local/android_sdk && \
	    rm -rf tools_r25.2.3-linux.zip

# Add Android SDK command line tools to PATH
ENV PATH $PATH:/usr/local/android_sdk/tools/bin
