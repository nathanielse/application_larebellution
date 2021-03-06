FROM debian:jessie

# Add Debian backports
RUN echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list

# Install Android SDK dependencies

## Install Java 8
RUN apt-get update && \
    apt-get install -y -t jessie-backports \
    	    openjdk-8-jdk-headless \
	    openjdk-8-jre-headless

# Install Gradle
RUN apt-get install -y \
            unzip \
            wget && \
    wget --quiet https://services.gradle.org/distributions/gradle-3.5-bin.zip && \
    unzip gradle-3.5-bin.zip && \
    mv gradle-3.5 /usr/local/gradle && \
    rm -rf gradle-3.5-bin.zip

# Add Gradle to the PATH variable
ENV PATH $PATH:/usr/local/gradle/bin

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

# Install necessary Android SDK components
# The required SDK components are provided
# in Apache Cordova documentation :
# https://cordova.apache.org/docs/en/latest/guide/platforms/android/index.html#adding-sdk-packages
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

# Install bzip2
# Used for installing PhantomJS required by ember-cordova
RUN apt-get install -y bzip2
	       
# Install Ember CLI
RUN npm install --global ember-cli@2.14.0