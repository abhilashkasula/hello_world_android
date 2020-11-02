FROM openjdk:8-jdk

ENV ANDROID_HOME /opt/android-sdk
RUN mkdir ${ANDROID_HOME} \
  && cd ${ANDROID_HOME} \
  && curl -o sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip \
  && unzip sdk.zip && rm sdk.zip \
  && mkdir -p ${ANDROID_HOME}/licenses \
  && echo 24333f8a63b6825ea9c5514f83c2829b004d1fee > ${ANDROID_HOME}/licenses/android-sdk-license
