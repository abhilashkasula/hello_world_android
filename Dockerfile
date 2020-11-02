FROM openjdk:8-jdk

ENV ANDROID_HOME /opt/android-sdk
RUN mkdir ${ANDROID_HOME} \
  && cd ${ANDROID_HOME} \
  && curl -o sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip \
  && unzip sdk.zip && rm sdk.zip \
  && mkdir -p ${ANDROID_HOME}/licenses \
  && echo 24333f8a63b6825ea9c5514f83c2829b004d1fee > ${ANDROID_HOME}/licenses/android-sdk-license

ARG GRADLE_VERSION=6.5
ARG GRADLE_DIST=bin
RUN cd /opt && \
    wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-${GRADLE_DIST}.zip && \
    unzip -q gradle*.zip && \
    rm gradle*.zip

# set the environment variables
ENV GRADLE_HOME /opt/gradle/gradle-${GRADLE_VERSION}/
ENV PATH ${PATH}:${GRADLE_HOME}/bin
