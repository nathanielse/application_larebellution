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

# Copy Android SDK licenses
COPY docker_environment/licenses /usr/local/android_sdk/licenses

# Set up environment variables for Android SDK
ENV ANDROID_HOME /usr/local/android_sdk
ENV PATH $PATH:$ANDROID_HOME/tools/bin
ENV PATH $PATH:$ANDROID_HOME/platform-tools/bin

# Install necessary SDK components
RUN sdkmanager \
    	       "build-tools;25.0.2" \
	       "platforms;android-25" \
	       "extras;android;m2repository"

# Install Android emulator
RUN sdkmanager "emulator"

# Install Node.js
RUN apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_7.x | bash - && \
    apt-get install -y nodejs
	       
